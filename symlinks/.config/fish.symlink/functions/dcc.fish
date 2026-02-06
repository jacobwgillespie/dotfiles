function dcc
    env AWS_PROFILE=depot-Developer \
        CLAUDE_CODE_USE_BEDROCK=1 \
        AWS_REGION=us-west-2 \
        ANTHROPIC_MODEL=opus \
        claude $argv
end
