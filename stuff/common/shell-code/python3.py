import boto3
session = boto3.Session(profile_name='default')
s3 = session.resource('s3')


#creats a bucket

#s3.create_bucket(Bucket='mybucketamar001', CreateBucketConfiguration={
#        'LocationConstraint': session.region_name})

#add a file to the bukcet
#s3.Object('mybucketamar001', 'hello.txt').put(Body=open('/home/amar/tmp/hello.txt', 'rb'))


for bucket in s3.buckets.all():
    bucket.objects.all().delete()
    bucket.delete()
    #s3.buckets.all().delete()


#reads all buckers in account
for bucket in s3.buckets.all():
    print(bucket)