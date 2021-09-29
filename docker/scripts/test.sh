#!/usr/bin/env bash

set -eu;

bundle exec rspec;
bundle exec rubocop;

# テストの終了
echo -e "";
echo -e "\n  =========================\n";
echo -e "         TEST PASSED";
echo -e "\n  =========================\n";
echo -e "";
exit 0;