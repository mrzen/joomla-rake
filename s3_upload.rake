# -*- mode: ruby -*-
# -*- coding: utf-8 -*-

require_relative 'helpers'

##
# Get the S3 Credentials
#
def s3_credentials
  
  {
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'] || $package['s3']['access_key_id'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'] || $package['s3']['secret_access_key'],
    :region => ENV['AWS_REGION'] || $package['s3']['region']
  }
  
end


desc 'Upload the package to S3'
task :upload => [:package] do

  require 'aws-sdk'
  
  s3 = AWS::S3.new(s3_credentials)
  bucket = s3.buckets[$package['s3']['bucket']]

  package_files = [ 
           File.join( $package['s3']['path'] , package_name + '.zip'),
           File.join( $package['s3']['path'] , $package['name'] + '-latest.zip')
          ]

  package_files.each do |file|
    o = bucket.objects[file]
    o.write(Pathname.new( File.join('.' , 'packages', package_name + '.zip' )))
    o.acl = :public_read
  end

  o = bucket.objects[ File.join($package['s3']['path'] , 'extension.xml') ]
  o.write(update_manifest)
  o.acl = :public_read

  p "Uploaded package #{package_name}.zip and update manifest to S3"

end


desc "Make a new Release (bump, package and upload)"
task :release => [:bump, :package, :upload]
