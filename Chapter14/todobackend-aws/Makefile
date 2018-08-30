.PHONY: deploy

deploy/%:
	aws cloudformation deploy --template-file stack.yml --stack-name todobackend-$* \
    --parameter-overrides $$(cat $*.json | jq -r '.Parameters|to_entries[]|.key+"="+.value') \
    --capabilities CAPABILITY_NAMED_IAM