CONF_BUCKET := helloworld
CONF_ENV_KEY := ios_environments
CONF_ENV_PATH := s3://$(CONF_BUCKET)/$(CONF_ENV_KEY)

CONF_VERSION := 3ZPU7yDtxi_JYJlwg850AocC_qev22jo
CONF_KEY := $(CONF_ENV_KEY)/ConfigLive.swift
CONF_LOCAL_FILE := Packages/HelloWorld/Sources/Config/ConfigLive.swift

xcode:
	make xcg
	open HelloWorld.xcodeproj

xcg:
	xcodegen generate
	make schemer

fmt:
	swiftformat --config .swiftformat .

conf: TMP := /tmp/conf-$(shell uuidgen)
conf:
	aws s3api get-object \
    --bucket $(CONF_BUCKET) \
    --key $(CONF_KEY) \
    --version-id $(CONF_VERSION) \
    $(CONF_LOCAL_FILE)

save_conf:
	aws s3api put-object \
    --bucket $(CONF_BUCKET) \
    --key $(CONF_KEY) \
    --body $(CONF_LOCAL_FILE)

test:
	bundle exec fastlane test

deploy:
	make xcg
	bundle exec fastlane deploy

assets:
	make l10n
	make swiftgen

l10n:
	swiftformat Packages/HelloWorld/Sources/Resource

swiftgen:
	swiftgen config run --config Packages/HelloWorld/Sources/Resource/swiftgen.yml
	swiftformat Packages/HelloWorld/Sources/Resource

schemer:
	./bin/schemer-cli gen-test \
    -p HelloWorld.xcodeproj \
    -s "HelloWorldiOS" \
    -c Packages/HelloWorld \
    -o HelloWorld.xcodeproj/xcshareddata/xcschemes/HelloWorldiOSTests.xcscheme
	XC_SCHEME=HelloWorld.xcodeproj/xcshareddata/xcschemes; \
		mv $$XC_SCHEME/HelloWorldiOSTests.xcscheme $$XC_SCHEME/HelloWorldiOS.xcscheme

cert:
	bundle exec fastlane provision_certs
