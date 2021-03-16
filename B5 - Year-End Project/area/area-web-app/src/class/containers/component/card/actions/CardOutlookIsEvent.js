import React, {Component} from 'react';
import {withRouter} from 'react-router-dom';
import {connect} from 'react-redux';

class CardOutlookIsEvent extends Component {
    constructor(props) {
        super(props);

        this.state = {
            days_number: "",
        };
    }

    componentDidMount() {
        this.setState({days_number: this.props.days_number});
    }

    render() {
        return (
            <div className="column ml-3"><figure className="image is-64x64 mb-5">
                <img alt="" src="https://www.cloud-pour-tous.fr/wp-content/uploads/2019/06/logo-outlook-new.png" /></figure>
                <p className="is-size-6">Si j'ai un évènement dans les <span className="has-text-weight-bold">{this.state.days_number}</span> prochain(s) jour(s)</p>
            </div>
        );
    }
}

const mapStateToProps = (state) => {
    return {
        user: state.user
    }
}

export default withRouter(connect(mapStateToProps)(CardOutlookIsEvent));