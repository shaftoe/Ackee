include config.mk

all: push-to-heroku test-connection

push-to-heroku:
	@git push -f heroku master

create-heroku:
	@heroku create $(APP_NAME)
	# @heroku addons:create mongolab --app $(APP_NAME)

config-heroku:
	@heroku config:add \
		"ACKEE_USERNAME=$(ACKEE_USERNAME)" \
		"ACKEE_PASSWORD=$(ACKEE_PASSWORD)" \
		"ACKEE_TRACKER=$(APP_NAME)" \
		"ACKEE_ALLOW_ORIGIN=$(ACKEE_ALLOW_ORIGIN)" \
		"ACKEE_MONGODB=$(ACKEE_MONGODB)"
	@heroku ps:scale web=1

test-connection:
	@curl -I https://$(APP_NAME).herokuapp.com/ 2>/dev/null | head -n 1

setup: create-heroku push-to-heroku config-heroku test-connection

destroy:
	@heroku apps:destroy --confirm $(APP_NAME)

PHONY: all create-heroku push-to-heroku config-heroku test-connection setup destroy
