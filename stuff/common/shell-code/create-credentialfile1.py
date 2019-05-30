def main():
f=open("~/.aws/credentials","w+")
f.write(
'[default]
aws_access_key_id = AKIAIZYEWTVFWMNPEYAQ
aws_secret_access_key = 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'
)
f.close()

if __name__== "__main__":
  main()
