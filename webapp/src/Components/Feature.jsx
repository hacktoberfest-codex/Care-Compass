import React from "react";
import "./nav.css";
const Feature = () => {
    return (
        <div>
            <div className="features">
                <div className="features-content">
                    {/* in features-content, we have the blue box for listed items with margin left of about 60% */}
                    <h3>Key Features</h3>

                    <ul>
                        <li>Key Features: Instant Booking: Book medical appointments at your convenience, 24/7, without the need to make a phone call.</li>
                        <li> Real-Time Updates: Receive instant notifications and reminders, so you never miss an appointment again.</li>
                        <li>Reduce Wait Times: Our intelligent scheduling system optimizes clinic flow, minimizing your time spent in waiting rooms.</li>
                        <li>Secure Access: Access your medical records, test results, and prescriptions securely from your smartphone.</li>
                        
                    </ul>
                </div>
            </div>
        </div>
    );
}

export default Feature;