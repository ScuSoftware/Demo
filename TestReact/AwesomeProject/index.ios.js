/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';
import React, {
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  TextInput,
  View,
  Image,
  TouchableHighlight,
  NativeModules,
  ListView,
  NavigatorIOS
} from 'react-native';

var list_data = ['row 1', 'row 2'];
var list_count = 2;

class AwesomeProject extends Component {
  constructor(props) {
    super(props);

    //list view
    
    var ds = new ListView.DataSource({
      rowHasChanged: (r1, r2) => r1 !== r2
    });

    this.state = {
      //list view
      dataSource: ds.cloneWithRows(list_data),

      searchString: 'placeholder',
      isLoading: false,
      message: ''
    };
  }

  onSearchTextChanged(event) {
    this.setState({ searchString: event.nativeEvent.text });
  }

  _executeQuery(query) {
    NativeModules.MyCustomModule.processString(query, (text) => {
      this.setState({text});
    });
  }

  onSearchPressed() {
    this._executeQuery('jj');
  }

  componentDidMount(){
    var that = this;
    // var start = new Date().getTime();
    //   setInterval(
    //     ()=>{
    //       list_count++;
    //       list_data.push('row'+list_count);
    //       that.setState({dataSource: this.state.dataSource.cloneWithRows(list_data)})
    //   } , 5000);
  }

  render() {
    return (
      <View style={styles.container}>
       
       <View style={styles.flowLeft}>
         <ListView dataSource={this.state.dataSource}
          renderRow={(rowData,rowHasChanged) =>
            <View style={styles.flowRight}>
              <Image
                source={{uri: 'http://facebook.github.io/react/img/logo_og.png'}}
                style={styles.image}/>
              <Text style={styles.button}>
                {rowData +':'+ rowHasChanged}
              </Text>
            </View> }/>
        </View>

        <Text style={styles.welcome}>
          欢迎使用React Native！
        </Text>

        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>

        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>

        <Text style={styles.instructions}>
        测试测试
        </Text>

        <View style={styles.flowRight}>
          
          <TextInput
            style={styles.searchInput}
            placeholder='Search via name or postcode'
            onChange={this.onSearchTextChanged.bind(this)}/>

          <TouchableHighlight style={styles.button}
              underlayColor='#99d9f4'
              onPress={this.onSearchPressed.bind(this)}>
            <Text style={styles.buttonText}>确定</Text>
          </TouchableHighlight>

        </View>

      </View>
    );
  }

}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFC',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  flowRight: {
    flexDirection: 'row',
    alignItems: 'center',
    alignSelf: 'stretch'
  },
  flowLeft: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    alignSelf: 'stretch'
  },
  button: {
    height: 36,
    flex: 1,
    flexDirection: 'row',
    backgroundColor: '#48BBEC',
    borderColor: '#48BBEC',
    borderWidth: 1,
    borderRadius: 8,
    marginBottom: 10,
    alignSelf: 'stretch',
    justifyContent: 'center'
  },
  searchInput: {
    height: 36,
    padding: 4,
    marginRight: 5,
    flex: 4,
    fontSize: 18,
    borderWidth: 1,
    borderColor: '#48BBEC',
    borderRadius: 8,
    color: '#48BBEC'
  },
  buttonText: {
    fontSize: 18,
    color: 'white',
    alignSelf: 'center'
  },
  listView: {
    paddingTop: 20,
    backgroundColor: '#F5FCFF',
  },
  image: { 
    width: 35,
    height: 35,
    marginRight: 10,

  }
});

AppRegistry.registerComponent('AwesomeProject', () => AwesomeProject);
