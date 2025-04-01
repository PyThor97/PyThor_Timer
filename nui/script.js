function showTimer() {
    const timer = document.getElementById("timer");
    if (timer) {
        timer.style.display = "block";
        setTimeout(() => {
            timer.style.opacity = "1";
        }, 10);
    }
}

function hideTimer() {
    const timer = document.getElementById("timer");
    if (timer) {
        timer.classList.remove("flash");
        timer.style.opacity = "0";
        setTimeout(() => {
            timer.style.display = "none";
        }, 500);
    }
}

function formatTime(totalSeconds) {
    const hours = Math.floor(totalSeconds / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    const seconds = totalSeconds % 60;

    const pad = (num) => String(num).padStart(2, '0');

    return hours > 0
        ? `${pad(hours)}:${pad(minutes)}:${pad(seconds)}`
        : `${pad(minutes)}:${pad(seconds)}`;
}

function timerCountdown(seconds) {
    const timerDiv = document.getElementById("timer");
    if (!timerDiv) return;

    timerDiv.classList.remove("flash");
    timerDiv.textContent = formatTime(seconds);

    const interval = setInterval(() => {
        seconds--;

        if (seconds <= 10) {
            timerDiv.classList.add("flash");
        }

        if (seconds <= 0) {
            clearInterval(interval);
            timerDiv.textContent = "00:00";
            timerDiv.classList.remove("flash");
            hideTimer();
            return;
        }

        timerDiv.textContent = formatTime(seconds);
    }, 1000);
}

window.addEventListener("DOMContentLoaded", () => {
    hideTimer();
});

window.addEventListener("message", (event) => {
    const data = event.data;
    console.log("Message from LUA:", data);

    if (data.action === "hide") {
        hideTimer();
    }

    if (data.type === "time") {
        showTimer();
        timerCountdown(data.seconds);
    }
});
