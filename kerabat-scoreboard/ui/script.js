let isOpen = false;
let currentTimeFormat = 12;

window.addEventListener('message', function(event) {
    const data = event.data;
    console.log('[Scoreboard] Received message:', data.action);
    
    switch(data.action) {
        case 'open':
            console.log('[Scoreboard] Opening scoreboard');
            openScoreboard();
            startClock();
            break;
            
        case 'close':
            console.log('[Scoreboard] Closing scoreboard');
            closeScoreboard();
            stopClock();
            break;
            
        case 'update':
            console.log('[Scoreboard] Updating data:', data.payload);
            updateData(data.payload);
            break;
    }
});

// ESC to close
document.addEventListener('keydown', function(e) {
    if (!isOpen) return;
    
    if (e.key === 'Escape') {
        console.log('[Scoreboard] ESC pressed, closing');
        closeScoreboard();
        fetch(`https://${GetParentResourceName()}/close`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        }).catch(() => {});
    }
});

// Clock functionality
let clockInterval = null;

function startClock() {
    console.log('[Scoreboard] Starting clock');
    updateClock();
    clockInterval = setInterval(updateClock, 1000);
}

function stopClock() {
    console.log('[Scoreboard] Stopping clock');
    if (clockInterval) {
        clearInterval(clockInterval);
        clockInterval = null;
    }
}

function updateClock() {
    const now = new Date();
    const timeElement = document.getElementById('timestamp');
    
    if (timeElement) {
        const is24Hour = currentTimeFormat === 24;
        
        if (is24Hour) {
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');
            timeElement.textContent = `${hours}:${minutes}:${seconds}`;
        } else {
            let hours = now.getHours();
            const ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12;
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');
            timeElement.textContent = `${hours}:${minutes}:${seconds} ${ampm}`;
        }
    }
}

function openScoreboard() {
    console.log('[Scoreboard] Opening UI');
    isOpen = true;
    document.getElementById('scoreboard').classList.remove('hidden');
}

function closeScoreboard() {
    console.log('[Scoreboard] Closing UI');
    isOpen = false;
    document.getElementById('scoreboard').classList.add('hidden');
}

function updateData(data) {
    if (!data) {
        console.error('[Scoreboard] No data received');
        return;
    }
    
    console.log('[Scoreboard] Processing data:', data);
    
    if (data.timeFormat) {
        currentTimeFormat = data.timeFormat;
    }
    
    // Update all elements
    updateElement('totalPlayers', data.totalPlayers || 0);
    updateElement('medics', data.medics || 0);
    updateElement('lawmen', data.lawmen || 0);
    updateElement('wagons', data.wagons || 0);
    updateElement('saloons', data.saloons || 0);
    updateElement('ranches', data.ranches || 0);
    
    // Update server name and player ID
    if (data.serverName) {
        document.getElementById('serverName').textContent = data.serverName;
    }
    
    if (data.playerId) {
        document.getElementById('playerId').textContent = data.playerId;
    }
    
    // Update own job
    document.getElementById('ownJobCount').textContent = data.ownJob ? 1 : 0;
    document.getElementById('ownJobName').textContent = data.ownJobName || 'NONE';
    
    // Update own job icon based on job type
    updateOwnJobIcon(data.ownJob, data.ownJobName);
    
    // Animate number changes
    animateNumberChange('totalPlayers', data.totalPlayers || 0);
    animateNumberChange('medics', data.medics || 0);
    animateNumberChange('lawmen', data.lawmen || 0);
    animateNumberChange('wagons', data.wagons || 0);
    animateNumberChange('saloons', data.saloons || 0);
    animateNumberChange('ranches', data.ranches || 0);
}

function updateElement(id, value) {
    const element = document.getElementById(id);
    if (element) {
        element.textContent = value;
    } else {
        console.error(`[Scoreboard] Element ${id} not found`);
    }
}

function updateOwnJobIcon(job, jobName) {
    const ownJobIcon = document.querySelector('.own-job i');
    if (!ownJobIcon) {
        console.error('[Scoreboard] Own job icon not found');
        return;
    }
    
    if (job) {
        const jobLower = job.toLowerCase();
        const isOnDuty = jobName && jobName.includes('ON DUTY');
        
        // Update border color based on duty status
        const ownJobElement = document.querySelector('.job-item.own-job');
        if (ownJobElement) {
            if (isOnDuty) {
                ownJobElement.style.borderColor = '#4CAF50';
                ownJobElement.style.color = '#4CAF50';
            } else {
                ownJobElement.style.borderColor = '#D4AF37';
                ownJobElement.style.color = '#D4AF37';
            }
        }
        
        // Set icon based on job type
        if (jobLower.includes('medic')) {
            ownJobIcon.className = 'fas fa-medkit';
        } else if (jobLower.includes('law') || jobLower.includes('sheriff')) {
            ownJobIcon.className = 'fas fa-sheriff';
        } else if (jobLower.includes('wagon')) {
            ownJobIcon.className = 'fas fa-wagon-covered';
        } else if (jobLower.includes('saloon') || jobLower.includes('bartender')) {
            ownJobIcon.className = 'fas fa-beer';
        } else if (jobLower.includes('ranch') || jobLower.includes('peternak')) {
            ownJobIcon.className = 'fas fa-horse';
        } else {
            ownJobIcon.className = 'fas fa-user';
        }
    }
}

function animateNumberChange(elementId, newValue) {
    const element = document.getElementById(elementId);
    if (element && parseInt(element.textContent) !== parseInt(newValue)) {
        element.style.transform = 'scale(1.2)';
        element.style.color = '#FFF';
        setTimeout(() => {
            element.style.transform = 'scale(1)';
            element.style.color = '';
        }, 200);
    }
}

// Initialize
document.addEventListener('DOMContentLoaded', function() {
    console.log('[Western Scoreboard] UI Initialized');
});