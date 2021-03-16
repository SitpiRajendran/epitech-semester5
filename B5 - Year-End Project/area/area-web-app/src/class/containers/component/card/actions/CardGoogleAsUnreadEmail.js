import React, {Component} from 'react';
import {withRouter} from 'react-router-dom';
import {connect} from 'react-redux';

class CardGoogleAsUnreadEmail extends Component {
    constructor(props) {
        super(props);

        this.state = {
            filtre: "",
            filtre_option: "",
        };
    }

    componentDidMount() {
        this.setState({
            filtre: this.props.filtre,
            filtre_option: this.props.filtre_option,
        });
    }

    render() {
        return (
            <div className="column ml-3"><figure className="image is-64x64 mb-5">
                <img alt="" src="https://image.flaticon.com/icons/png/512/281/281769.png" /></figure>
                <p className="is-size-7">Déclenché lorsque un email est <span className="has-text-weight-bold">non lu</span></p>
                {this.state.filtre === "subject" ?
                    <p className="is-size-7">Si l'objet est : <span className="has-text-weight-bold">{this.state.filtre_option}</span></p>
                : null}
                {this.state.filtre === "from" ?
                    <p className="is-size-7">Si l'expediteur est : <span className="has-text-weight-bold">{this.state.filtre_option}</span></p>
                : null}
            </div>
        );
    }
}

const mapStateToProps = (state) => {
    return {
        user: state.user
    }
}

export default withRouter(connect(mapStateToProps)(CardGoogleAsUnreadEmail));