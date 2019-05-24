/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  ScrollView,
  Button,
  Image,
  TouchableHighlight,
  Alert,
  TouchableNativeFeedback,
  NativeEventEmitter,
  NativeModules
} from 'react-native';
//import PropTypes from "prop-types";

//初始化, RNMethodTool 就是原生类的名字
var NativeBridge = NativeModules.RNMethodTool;
const NativeModule = new  NativeEventEmitter(NativeModules.RNMethodTool);


class NativeRNApp extends Component {

//在页面加载完成之后，这里类似于 iOS 的 viewDidLoad
  componentDidMount() {
    //添加监听，作用参考原生里面的方法
    //核心方法，通过 EventReminder 这个标识监听 原生发过来的通知，收到之后就调用里面的方法，data 是传过来的参数
    NativeModule.addListener('EventReminder',(data)=>{

          var dic = JSON.stringify(data);

          alert('事件1' +  '   ' + '原生带过来的参数'+ dic);;

    })
    NativeModule.addListener('Event2Reminder',(data)=>{

          var dic = JSON.stringify(data);

          alert('事件2' + '   ' + '原生调用RN方法' + '   ' + '原生带过来的参数'+ dic);

    })

  }
  onPressButton() {
    Alert.alert('You tapped the button!')
  }

  render() {
    return (
      <ScrollView>
        <Image
          source={{uri: 'https://i.chzbgr.com/full/7345954048/h7E2C65F9/'}}
          style={{width: 375, height:180}}
        />
     
        <TouchableHighlight onPress={ ()=>NativeBridge.rn_doSometing()} underlayColor="white">
          <View style={styles.button}>
            <Text style={styles.buttonText}>RN调用原生 </Text>
          </View>
        </TouchableHighlight>

        <TouchableHighlight onPress={ ()=>NativeBridge.pushViewWitnTitle('下一级页面','myDetail')} underlayColor="white">
          <View style={styles.button}>
            <Text style={styles.buttonText}>下一页 </Text>
          </View>
        </TouchableHighlight>
      </ScrollView>
    );
  }
}


const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
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
  button: {
    flex: 1,
    margin: 20,
    height: 45,
    alignItems: 'center',
    backgroundColor: '#2196F3'
  },
  buttonText: {
    padding: 15,
    color: 'white'
  },
});

AppRegistry.registerComponent('NativeRNApp', () => NativeRNApp);
