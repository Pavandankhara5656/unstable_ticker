# Unstable Ticker 📈

A Flutter assignment for tracking real-time stock prices from an unstable WebSocket server. This project focuses on resilience, anomaly detection, and performance.

---

## 🚀 Setup Instructions

1. **Run the WebSocket mock server:**
   ```bash
   dart mock_server.dart
   ```
   Ensure it's running at `ws://localhost:8080/ws`

2. **Run Flutter app:**
   ```bash
   flutter pub get
   flutter run
   ```

---

## 🧱 Architectural Decisions

- **State Management:** `Provider` was used for simplicity and fine-grained reactivity.
- **Structure:**
    - `models/` → data classes (e.g., `StockModel`)
    - `services/` → WebSocket logic, reconnection, JSON handling
    - `providers/` → reactive logic for connection & stocks
    - `screens/` and `widgets/` → UI components

- **Separation of Concerns:**
    - `WebSocketService` isolates connection logic
    - `StockProvider` handles domain rules like anomaly detection
    - UI layers stay clean and reactive

---

## 🧠 Anomaly Detection Heuristic

**Rule:**
If a stock's price drops by more than 50% compared to its last known good price, it's flagged as anomalous.

```dart
final isAnomalous = (previous - stock.price) / previous > 0.5;
```

**Why 50%?**
- In real-world stock markets, a 50%+ drop in one second is extremely rare
- Balances false positives with effective anomaly detection

**Trade-offs:**
- Could miss gradual crashes
- Could flag valid price drops (false positives) in highly volatile environments

---

## 🔁 Connection Status Handling

- **Live Status Updates:** Shows "Connecting", "Connected", "Reconnecting"
- **Exponential Backoff:**
    - 2s, 4s, 8s, 16s... capped at 30s
    - Ensures stable reconnection without overwhelming the server

---

## ⚙️ Performance Optimization

- **Efficient List Rebuilds:**
    - `ListView.builder()` ensures only visible items rebuild
    - `StockTile` is stateless and keyed by stock object
- **Minimal UI Jank:**
    - State updates via `notifyListeners()` only when needed

### 📊 Flutter DevTools Overlay
> Include your screenshot here from running the Performance Overlay showing no UI jank.

**Green UI/Raster Threads:**
- Architecture prevents full widget tree rebuilds
- Stream-based data model avoids heavy memory use

---

## ✅ Features Summary

- ✅ Live stock list with price
- ✅ Flash color when updated (green/red effect stub planned)
- ✅ Handles malformed JSON
- ✅ Flags anomalous stock prices
- ✅ Reconnects using exponential backoff
- ✅ Shows connection status in real-time
- ✅ Clean architecture and documented code

---

## 🛠 Future Enhancements
- Animations for price up/down flashing
- Manual refresh and connection retry buttons
- Unit and widget tests
