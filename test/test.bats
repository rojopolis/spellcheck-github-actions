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
