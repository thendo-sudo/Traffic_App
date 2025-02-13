document.addEventListener('DOMContentLoaded', function () {
    const buttons = document.querySelectorAll('.city-buttons button');

    buttons.forEach(button => {
        button.addEventListener('click', function () {
            const city = this.getAttribute('data-city');
            fetchTrafficData(city);
        });
    });

    function fetchTrafficData(city) {
        fetch(`/traffic?city=${city}`)
            .then(response => response.json())
            .then(data => {
                const flowData = data.flowSegmentData;

                // Extract relevant data
                const currentSpeed = flowData.currentSpeed;
                const freeFlowSpeed = flowData.freeFlowSpeed;
                const speedRatio = (currentSpeed / freeFlowSpeed) * 100;

                // Update the DOM
                document.getElementById('currentSpeed').textContent = currentSpeed;
                document.getElementById('freeFlowSpeed').textContent = freeFlowSpeed;
                document.getElementById('speedProgress').style.width = `${speedRatio}%`;

                // Determine traffic status
                const trafficStatus = document.getElementById('trafficStatus');
                if (speedRatio >= 80) {
                    trafficStatus.textContent = "Light Traffic";
                    trafficStatus.className = "traffic-status light";
                } else if (speedRatio >= 50) {
                    trafficStatus.textContent = "Moderate Traffic";
                    trafficStatus.className = "traffic-status moderate";
                } else {
                    trafficStatus.textContent = "Heavy Traffic";
                    trafficStatus.className = "traffic-status heavy";
                }
            })
            .catch(error => {
                console.error('Error fetching traffic data:', error);
                document.getElementById('trafficStatus').textContent = "Failed to load traffic data.";
            });
    }
});