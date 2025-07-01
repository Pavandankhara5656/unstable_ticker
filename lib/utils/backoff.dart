int calculateBackoff(int attempt) {
  return attempt >= 5 ? 30 : (1 << attempt);
}
