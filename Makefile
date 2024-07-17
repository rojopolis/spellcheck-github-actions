local:
	docker build -t jonasbn/github-action-spellcheck:local .

latest:
	docker build -t jonasbn/github-action-spellcheck:latest .

latest-amd64:
	docker build --platform linux/amd64 -t jonasbn/github-action-spellcheck:latest-amd64 .
