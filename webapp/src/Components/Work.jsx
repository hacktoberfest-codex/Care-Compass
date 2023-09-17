import React from 'react';
import flowchart from '../assets/FlowChart.png'
import Vector1 from '../assets/Vector1.png'

const Work = () => {
    return (
        <div className='work-wrapper'>
            <h3>How App will Work??</h3>
            <img src={flowchart} alt="" />
            <img src={Vector1} alt="" />
        </div>
    );
}

export default Work;