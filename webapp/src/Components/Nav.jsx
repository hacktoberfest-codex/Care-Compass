import React from 'react';
import './nav.css';
import Logo from '../assets/logo.png';




const Nav = () => {

    return (
        <div className='app'>
            <header>
                <img src={Logo} alt="logo" className='logo' />

                <nav>
                    <ul className='nav-links'>
                        <li>Home</li>
                        <li>Features</li>
                        <li>About us</li>
                        <li>Work</li>
                        <li>Benefits</li>
                        <li>Testimonials</li>
                        <li>Contact Us</li>
                    </ul>
                </nav>
            </header>

            {/* ----------------------------- HERO ------------------------ */}
            <div className="hero">
                <div className="tag tag1">
                    <h2 className='blue'>Say Goodbye to Waiting Rooms:</h2>
                    <h2>Seamlessly Streamline Your</h2>
                    <h2>Healthcare Experience</h2>
                </div>

                <div className="tag tag2">
                    <p className='one'>
                        <h3>
                            Tired of spending precious hours in crowded <br /> waiting rooms? Say hello to a new era of
                            <br />healthcare with  <span>“Care Compass”</span>.
                        </h3>
                    </p>
                    <p className='two'>
                        <h3>
                            Effortlessly Cut Your Wait Time with <br /> Our Medical Appointment App
                        </h3>
                    </p>
                </div>

                <button>
                    Download App
                </button>
            </div>

        </div>
    );
}

export default Nav;
