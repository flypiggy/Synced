openssl aes-256-cbc -K $encrypted_9e7da2809d56_key -iv $encrypted_9e7da2809d56_iv -in config/deploy.enc -out config/deploy_rsa -d
cap production deploy
