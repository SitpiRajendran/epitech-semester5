import React, {Component} from 'react';
import {withRouter} from 'react-router-dom';
import {connect} from 'react-redux';

class CardGoogleCreateEvent extends Component {
    constructor(props) {
        super(props);

        this.state = {
            subject: "",
            time_start: "",
            time_end: "",
        };
    }

    componentDidMount() {
        this.setState({
            subject: this.props.subject,
            time_start: this.props.time_start,
            time_end: this.props.time_end,
        });
    }

    render() {
        return (
            <div className="column mr-3"><figure className="image is-64x64 mb-5">
                <img alt="" src="https://i.pinimg.com/originals/8e/a5/8c/8ea58c63db9488fd16c18deb4a5eaeae.png" /></figure>
                <p className="is-size-6 has-text-weight-bold">{this.state.subject}</p>
                <p className="is-size-6">Début : {this.state.time_start === "night" ? <span className="has-text-weight-bold">19h</span> : <span className="has-text-weight-bold">{this.state.time_start}</span>}</p>
                <p className="is-size-6">Fin: {this.state.time_end === "night" ? <span className="has-text-weight-bold">20h</span> : <span className="has-text-weight-bold">{this.state.time_end}</span>}</p>
            </div>
        );
    }
}

const mapStateToProps = (state) => {
    return {
        user: state.user
    }
}

export default withRouter(connect(mapStateToProps)(CardGoogleCreateEvent));