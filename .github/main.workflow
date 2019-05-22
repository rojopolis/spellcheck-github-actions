workflow "Push Workflow" {
  resolves = ["Spellcheck Action"]
  on = "push"
}

action "Spellcheck Action" {
  uses = "./"
}
