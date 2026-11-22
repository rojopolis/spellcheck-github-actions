@test "can do basic run using Docker image with two input files" {
	docker run -e INPUT_SOURCE_FILES="README.md CHANGELOG.md" \
           -e INPUT_TASK_NAME=Markdown -it -v $PWD:/tmp \
           jonasbn/github-action-spellcheck:local
}

@test "can do basic run using Docker image with unignored and ignored input files" {
	docker run -e INPUT_SOURCE_FILES="README.md venv/lib/python3.13/site-packages/pyspelling-2.10.dist-info/licenses/LICENSE.md" \
           -e INPUT_TASK_NAME=Markdown -it -v $PWD:/tmp \
           jonasbn/github-action-spellcheck:local
}

@test "can do basic run using Docker image with just ignored input file" {
	docker run -e INPUT_SOURCE_FILES="venv/lib/python3.13/site-packages/pyspelling-2.10.dist-info/licenses/LICENSE.md" \
           -e INPUT_TASK_NAME=Markdown -it -v $PWD:/tmp \
           jonasbn/github-action-spellcheck:local
}

@test "can do basic run using Docker image without any input files" {
	docker run \
           -e INPUT_TASK_NAME=Markdown -it -v $PWD:/tmp \
           jonasbn/github-action-spellcheck:local
}

@test "can do basic run using Docker image without task parameter" {
	docker run \
           -it -v $PWD:/tmp \
           jonasbn/github-action-spellcheck:local
}

@test "can do basic run using Docker image with two input files but not task parameter" {
	! docker run -e INPUT_SOURCE_FILES="README.md CHANGELOG.md" \
           -it -v $PWD:/tmp \
           jonasbn/github-action-spellcheck:local
}

@test "can do basic run using Docker image with two non-existing input files" {
	! docker run -e INPUT_SOURCE_FILES="DONOTREADME.md LOGCHANGE.md" \
           -e INPUT_TASK_NAME=Markdown -it -v $PWD:/tmp \
           jonasbn/github-action-spellcheck:local
}

@test "fails with a clear message when a declared wordlist file is missing" {
	run docker run -e INPUT_CONFIG_PATH=examples/markdown.yml \
           -e INPUT_TASK_NAME=Markdown -v $PWD:/tmp \
           jonasbn/github-action-spellcheck:local
	[ "$status" -ne 0 ]
	[[ "$output" == *"You have declared the wordlist file '.wordlist.txt'"* ]]
}

@test "writes a GitHub Actions job summary table when spelling issues are found" {
	echo "# Fixture

This fixture deliberately contains a typofied wrod." > TMP_SUMMARY_FIXTURE.md

	run docker run -e GITHUB_STEP_SUMMARY=/summary/summary.md \
           -e INPUT_SOURCE_FILES=TMP_SUMMARY_FIXTURE.md \
           -e INPUT_TASK_NAME=Markdown \
           -v $PWD:/tmp -v "$BATS_TEST_TMPDIR":/summary \
           jonasbn/github-action-spellcheck:local

	rm -f TMP_SUMMARY_FIXTURE.md

	[ "$status" -ne 0 ]

	summary="$(cat "$BATS_TEST_TMPDIR/summary.md")"
	[[ "$summary" == *"| TMP_SUMMARY_FIXTURE.md |"* ]]
	[[ "$summary" == *"typofied"* ]]
}

@test "writes a passing GitHub Actions job summary when there are no spelling issues" {
	run docker run -e GITHUB_STEP_SUMMARY=/summary/summary.md \
           -v $PWD:/tmp -v "$BATS_TEST_TMPDIR":/summary \
           jonasbn/github-action-spellcheck:local

	[ "$status" -eq 0 ]

	summary="$(cat "$BATS_TEST_TMPDIR/summary.md")"
	[[ "$summary" == *"No spelling issues found."* ]]
}
