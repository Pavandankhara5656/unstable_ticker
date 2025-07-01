bool isAnomalousPrice(double previous, double current) {
  if (previous == 0) return false;
  return (previous - current) / previous > 0.5; // >50% drop is considered anomalous
}
