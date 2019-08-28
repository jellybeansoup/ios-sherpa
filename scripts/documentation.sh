if ! which bundle &> /dev/null; then
  gem install bundler --no-document || echo "failed to install bundle";
fi

if ! bundle info jazzy &> /dev/null; then
  bundle config set deployment 'true';
  bundle install || echo "failed to install bundle";
fi

bundle exec jazzy \
	--module Sherpa \
	--min-acl public \
	--hide-documentation-coverage \
	--title "Sherpa" \
	--author_url https://jellystyle.com \
	--github_url https://github.com/jellybeansoup/ios-sherpa \
	--theme fullwidth \
	--output ./docs
