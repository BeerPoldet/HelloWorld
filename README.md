# Getting Started


1. Create the bundle id at developer.apple.com
2. Create the app at appstoreconnect.apple.com

3. Rename HelloWorld to <AppName>
```
rg 'HelloWorld' --files-with-matches | xargs sed -i '' 's/HelloWorld/AppName/g'
rg 'helloworld' --files-with-matches | xargs sed -i '' 's/helloworld/appname/g'
```

4. Put your team id
```
rg 'F6395XL53N' --files-with-matches | xargs sed -i '' 's/F6395XL53N/YOU_TEAM_ID/g'
```

5. Update app_store_connect_api_key.json renaming it from app_store_connect_api_key.example.json [(More about app store connect api key)](https://docs.fastlane.tools/app-store-connect-api/#using-fastlane-api-key-json-file)

6. Update content in `fastlane/*` files

7. Rename directories
```
mv Packages/HelloWorld Packages/AppName
mv HelloWorldiOS AppNameiOS
```

8. Update Target iOS version
- project.settings.yml

9. Update Xcode, Ruby version
- github/workflows/*.yml

10. Provision certificates and profiles
- Create github repository name `apple-development-certificates`. Use shared same repository for every app under the same team id.
- make sure that you have ssh access to the repo on the machine that have to run the next command.
- run command:
```
make cert
```


## Installing Fastlane

```
// If you're using Nix
nix-env -Ai nixpks.ruby 
// or just using plain gem to install bundler
gem install bundler

bundle install --path vender/bundle
```

## Certificates

```
bundle exec fastlane match development
bundle exec fastlane match appstore
```

## Setup Continuous Delivery

Let's make sure you setup these secrets in environment variables
- MATCH_PASSWORD
- MATCH_GIT_BASIC_AUTHORIZATION
- MATCH_GIT_PRIVATE_KEY

(More information)[https://docs.fastlane.tools/actions/match/#match]
