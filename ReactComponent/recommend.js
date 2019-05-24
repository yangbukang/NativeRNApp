/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import {
    View,
    Image,
    Button,
    Text,
    ToastAndroid,
    TouchableOpacity,
    FlatList,
    StyleSheet,
    Dimensions,
    NativeEventEmitter,
    NativeModules,
    AppRegistry
} from "react-native";

import React, { PureComponent } from "react";
import Colors from "./resource/Colors";
import Images from "./resource/Images";

/**
 * 列表的数据源
 *
 * @type {*[]}
 */
const dataList = [
    {
        key : 'Text',
        type : 1,
        content : 'THIS IS TEXT'
    },
    {
        key : 'Image',
        type : 2,
        content : Images.other_test.bg_beauty
    },
    {
        key : 'Button',
        type : 3,
        content : 'THIS IS BUTTON'
    },
];

//初始化, RNMethodTool 就是原生类的名字
var NativeBridge = NativeModules.RNMethodTool;
const NativeModule = new  NativeEventEmitter(NativeModules.RNMethodTool);


class NativeRNApp extends PureComponent {

//在页面加载完成之后，这里类似于 iOS 的 viewDidLoad
  componentDidMount() {
     
//核心方法，通过 EventReminder 这个标识监听 原生发过来的通知，收到之后就调用里面的方法，data 是传过来的参数
      NativeModule.addListener('EventReminder',(data)=>{

            var dic = JSON.stringify(data);

            alert('我是 RN 弹框，原生 调用 RN方法' + '   ' + '原生带过来的参数'+ dic);

      })
  }
  render() {
        return (
            <View style={styles.container}>
                <FlatList
                    data={dataList}
                    keyExtractor={this._keyExtractor}
                    renderItem={this.renderItem.bind(this)}
                />
            </View>
        );
    }

    //此函数用于为给定的item生成一个不重复的key
    _keyExtractor = (item) => item.key;

    /**
     * 根据数据中的type，判断该显示什么布局
     *
     * @param item
     * @returns {*}
     */
    renderItem({ item }) {
        if (item.type === 1) {
            return (
                <TouchableOpacity style={styles.item} activeOpacity={1} onPress={() => this.clickItem(item)}>
                    <Text style={styles.txt}>{item.content}</Text>
                </TouchableOpacity>
            )
        } else if (item.type === 2) {
            return (
                <TouchableOpacity style={styles.item} activeOpacity={1} onPress={() => this.clickItem(item)}>
                    <Image
                        style={styles.img}
                        source={item.content}
                    />
                </TouchableOpacity>
            )
        }else if (item.type===3){
            return (
                <Button
                    activeOpacity={1}
                    onPress={() => this.clickItem(item)}
                    title={item.content}
                    color={Colors.primary}
                />
            )
        }
    }

    /**
     * item的点击事件
     *
     * @param item
     */
    clickItem(item) {
        NativeBridge.pushViewWitnTitle('下一级页面','myDetail')
    }
}

const styles = StyleSheet.create({
    container : {
        flex : 1,
        padding:10,
        backgroundColor : 'white'
    },
    item : {
        flex:1,
        flexDirection:'row',
        width : Dimensions.get('window').width,
        justifyContent:'center',
        alignSelf:'flex-start',
        backgroundColor : 'white',
        borderBottomWidth : 1,
        borderBottomColor : Colors.border
    },
    txt : {
        padding : 10,
        fontSize : 18,
    },
    img : {
        margin:10,
        width : Dimensions.get('window').width,
        height : Dimensions.get('window').width/3*2,
        resizeMode:'cover'
    }
});

AppRegistry.registerComponent('NativeRNApp', () => NativeRNApp);
