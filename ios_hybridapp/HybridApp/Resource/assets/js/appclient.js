//var base = "file:///android_asset";
var base = "/Resource/assets";

function viewImage(img){
    var src = $(img).attr("aliasSrc");
    var images = new Array();
    var current = 0;
    $("img[v]").each(function(index){
        if(this==img){
            current = index;
        }
        images[index] = $(this).attr("aliasSrc");
    });
    App.viewPicture({current:current,images:images});
}
// 这段代码是固定的，必须要放到js?
function setupAndroidWebViewJavascriptBridge(callback,arguments) {
	eval(callback)(JSON.parse(arguments));
}
var agent_android="android";
var agent_ios="iPhone";
var	App = function () {
	var userAgentInfo = navigator.userAgent;
	return {
		selectDate:function(config){
			if (userAgentInfo.indexOf(agent_android) >= 0){
			    //app.selectDate(config);
				app.selectDate(JSON.stringify(config));
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				app.selectDate(JSON.stringify(config));
			} else {
			}
		},
		selectImg:function(config){
			if (userAgentInfo.indexOf(agent_android) >= 0){
				app.selectImage(JSON.stringify(config));
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				app.selectImage(JSON.stringify(config));
			}
		},
		readFile:function(path){
			if (userAgentInfo.indexOf(agent_android) >= 0){
				return  app.readFile(path);
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				return path;
			}
		},
		viewPicture:function(config){
			if (userAgentInfo.indexOf(agent_android) >= 0){
				app.viewPic(JSON.stringify(config));
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				app.viewPic(JSON.stringify(config));
			}
		},

		callHostPlugin:function(pluginName,method, data){
			if (userAgentInfo.indexOf(agent_android) >= 0){
				if (method && data)
					app.callHostPlugin(pluginName, method, JSON.stringify(data));
				else
					app.callHostPlugin(pluginName);
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				if (method && data){
					app.callHostPlugin({pluginName: pluginName, method:method, data:data});
				}
				else{
					app.callHostPlugin(pluginName);
				}
			}
		},
		setTopMenu:function(menu){
		    if (userAgentInfo.indexOf(agent_android) >= 0){
		        app.setTopMenu(JSON.stringify(menu));
		    } else if (userAgentInfo.indexOf(agent_ios) >= 0){
		         app.setTopMenu(JSON.stringify(menu));
		    } else {
		    }
		},
		setTitle:function(title,color){
			var len = arguments.length;
		    if (userAgentInfo.indexOf(agent_android) >= 0){
		    	if(len ==2){
		    		app.setTitle(title,"#" + color);
		    	}else{
		    		app.setTitle(title);
		    	}
		    } else if (userAgentInfo.indexOf(agent_ios) >= 0){
		        if(len ==2){
		    		app.setTitle({title:title,color:color});
		    	}else{
		    		app.setTitle(title);
		    	}
		    } else {
		    }
		},
		dial:function(number){
			if (userAgentInfo.indexOf(agent_android) >= 0){
				app.dial(number);
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				app.dial(number);
			}
		},
    setTabbar:function(menu){
        if (userAgentInfo.indexOf(agent_android) >= 0){
            app.setTabbar(JSON.stringify(menu));
        } else if (userAgentInfo.indexOf(agent_ios) >= 0){
            app.setTabbar(JSON.stringify(menu));
        } else{
        }
    },
		openNew:function(url){
			if (userAgentInfo.indexOf(agent_android) >= 0){
				//app.openNew(JSON.stringify(url));
				app.openNew(url);
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				app.openNew(url);
			} else {
			}
		},
		setNavigator:function(arr){
			if (userAgentInfo.indexOf(agent_android) >= 0) {
				if (arr == null || arr.length == 0) {
					app.setNavigator(arr);
				} else {
					app.setNavigator(JSON.stringify(arr));
				}
			} else if (userAgentInfo.indexOf(agent_ios) >= 0) {
				if (arr == null || arr.length == 0) {
					app.setNavigator(arr);
				} else {
					app.setNavigator(JSON.stringify(arr));
				}
			}
		},
		close:function(){
			if (userAgentInfo.indexOf(agent_android) >= 0){
				app.close();
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				app.close();
			} else {
			}
		},
      dragRefresh:function(allowDrag){
        if (userAgentInfo.indexOf(agent_android) >= 0){
            if(typeof allowDrag == 'boolean' && false == allowDrag){
                app.dragRefresh(false);
            }else{
                app.dragRefresh(true);
            }
        } else if (userAgentInfo.indexOf(agent_ios) >= 0){
            if(typeof allowDrag == 'boolean' && false == allowDrag){
                app.dragRefresh(false);
            }else{
                app.dragRefresh(true);
            }
        },
		prompt:function(message){
			if (userAgentInfo.indexOf(agent_android) >= 0){
				app.prompt(''+message);
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				app.prompt(message);
			} else {
			}
		},
		alert:function(message){
			if (userAgentInfo.indexOf(agent_android) >= 0){
				app.alert(message);
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				app.alert(message);
			} else {
			}
		},
		confirm:function(config){
			if (userAgentInfo.indexOf(agent_android) >= 0){
				app.confirm(JSON.stringify(config));
				//app.confirm(config);
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				app.confirm(JSON.stringify(config));
			} else {
				if (confirm(config.message)){
					if (config.params)
						eval(config.callback)(config.params);
					else
						eval(config.callback)();
				}
			}
		},
		selector:function(config){
			if (userAgentInfo.indexOf(agent_android) >= 0){
				app.selector(JSON.stringify(config));
			} else if (userAgentInfo.indexOf(agent_ios) >= 0){
				app.selector(JSON.stringify(config));
			} else {


			}
		},

		getLocation:function(){
            if (userAgentInfo.indexOf(agent_android) >= 0){
                return app.getLocation();
            } else if (userAgentInfo.indexOf(agent_ios) >= 0){
                return app.getLocation();
            } else {


            }
        },
        onPageEnd:function(){
        	if (userAgentInfo.indexOf(agent_android) >= 0){
        	  if (typeof onPageEnd != "undefined"){
        	      onPageEnd();
        	  }

            } else if (userAgentInfo.indexOf(agent_ios) >= 0){
                if (typeof onPageEnd != "undefined"){
                	onPageEnd();
                }
            }
        },
         onResume:function(){

             if (userAgentInfo.indexOf(agent_android) >= 0){
                if (typeof onResume != "undefined")
                    onResume();
            } else if (userAgentInfo.indexOf(agent_ios) >= 0){
                if (typeof onResume != "undefined")
                 onResume();
            }
         },
         onSaveState:function(){
             if (userAgentInfo.indexOf(agent_android) >= 0){
                if (typeof onSaveState != "undefined")
                    onSaveState();
            } else if (userAgentInfo.indexOf(agent_ios) >= 0){
                if (typeof onSaveState != "undefined")
                 onSaveState();
            }
         },
         get:function(key){
            if (userAgentInfo.indexOf(agent_android) >= 0){
                return app.get(key);
            } else if (userAgentInfo.indexOf(agent_ios) >= 0){
                return app.get(key);
            } else {

            }
         },
          remove:function(key){
             if (userAgentInfo.indexOf(agent_android) >= 0){
                 app.remove(key);
             } else if (userAgentInfo.indexOf(agent_ios) >= 0){
                 app.remove(key);
             } else {

             }
          },
         put:function(key,value){
            if (userAgentInfo.indexOf(agent_android) >= 0){
                   app.put(key,value);
               } else if (userAgentInfo.indexOf(agent_ios) >= 0){
                   app.put({key:key,value:value});
               } else {


               }
         },
          showLoading:function(second, callback){
              if (userAgentInfo.indexOf(agent_android) >= 0){
                if (typeof callback != "undefined")
                    app.showLoading(second, callback);
                else
                    app.showLoading(second,"");

              } else if (userAgentInfo.indexOf(agent_ios) >= 0){
              	if (typeof callback != "undefined")
                    app.showLoading(second, callback);
                else
                    app.showLoading(second,"");
              } else {

              }
           },
           hideLoading:function(){
              if (userAgentInfo.indexOf(agent_android) >= 0){
                  //setTimeout("app.hideLoading()",2000);
                  app.hideLoading();
              } else if (userAgentInfo.indexOf(agent_ios) >= 0){
                  //setTimeout("app.hideLoading()",2000);
            	  app.hideLoading();
              } else {

              }
           },
           show2dCode:function(data){
               if (userAgentInfo.indexOf(agent_android) >= 0){
                   app.show2dCode(data);
               } else if (userAgentInfo.indexOf(agent_ios) >= 0){
               		app.show2dCode(data);
               }
                else {

               }
           },

    setTabbarBadge:function(index,str){
        if (userAgentInfo.indexOf(agent_android) >= 0){
            app.setTabbarBadge(index,str);
        } else if (userAgentInfo.indexOf(agent_ios) >= 0){
            app.setTabbarBadge(index,str);
        }
    },

        postData:function(url,requestMapping,callback,content,files){
               if (userAgentInfo.indexOf(agent_android) >= 0){
        	   		app.postData(url,requestMapping,callback,content,files);
        	   } else if (userAgentInfo.indexOf(agent_ios) >= 0){
        	   		app.postData(url,requestMapping,callback,content,files);
        	   }
        },
        getDeviceModel:function(){
               if (userAgentInfo.indexOf(agent_android) >= 0){
                	   	return	app.getDeviceModel();
               } else if (userAgentInfo.indexOf(agent_ios) >= 0){
                	   	return	app.getDeviceModel();
               }
        },
        checkNewVersion:function(android_upgradeUrl,ios_upgradeUrl,isShowTip){
                if (userAgentInfo.indexOf(agent_android) >= 0){
                    app.checkNewVersion(android_upgradeUrl,isShowTip);
                } else if (userAgentInfo.indexOf(agent_ios) >= 0){
                    app.checkNewVersion(ios_upgradeUrl,isShowTip);
                }
        },
        selectDateRange:function(config){
            if (userAgentInfo.indexOf(agent_android) >= 0){
                app.selectDateRange(JSON.stringify(config));
            } else if (userAgentInfo.indexOf(agent_ios) >= 0){
                app.selectDateRange(JSON.stringify(config));
            }
         },
		base64File : function(filePath) {
			if (userAgentInfo.indexOf(agent_android) >= 0) {
				return app.base64File(filePath);
			} else if (userAgentInfo.indexOf(agent_ios) >= 0) {
				return app.base64File(filePath);
			}
		},
		sendBroadcast : function(actionVal) {
        			if (userAgentInfo.indexOf(agent_android) >= 0) {
        				return app.sendBroadcast(actionVal);
        			} else if (userAgentInfo.indexOf(agent_ios) >= 0) {
        				//return app.sendBroadcast(actionVal);
        			}
        },
        selectVideo:function(config){
             if (userAgentInfo.indexOf(agent_android) >= 0) {
                 app.selectVideo(JSON.stringify(config));
             } else if (userAgentInfo.indexOf(agent_ios) >= 0) {
                 app.selectVideo(JSON.stringify(config));
             }
        },
        deleteFile:function(filePath){
          if (userAgentInfo.indexOf(agent_android) >= 0) {
               app.deleteFile(filePath);
          } else if (userAgentInfo.indexOf(agent_ios) >= 0) {
               app.deleteFile(filePath);
          }
        },
        playVideo:function(path){
          if (userAgentInfo.indexOf(agent_android) >= 0) {
               app.playVideo(path);
          } else if (userAgentInfo.indexOf(agent_ios) >= 0) {
               app.playVideo(path);
          }
        },
        closeForResult:function(config){
            if (userAgentInfo.indexOf(agent_android) >= 0) {
                  app.closeForResult(JSON.stringify(config));
            } else if (userAgentInfo.indexOf(agent_ios) >= 0) {
                  app.closeForResult(JSON.stringify(config));
            }
        },
    getCurrentWifi:function(){
        if (userAgentInfo.indexOf(agent_android) >= 0) {
            return app.getCurrentWifi();
        } else if (userAgentInfo.indexOf(agent_ios) >= 0) {
            return app.getCurrentWifi();
        }
    },
    openWifiSetting:function(){
        if (userAgentInfo.indexOf(agent_android) >= 0) {
            app.openWifiSetting();
        } else if (userAgentInfo.indexOf(agent_ios) >= 0) {
            app.openWifiSetting();
        }
    }
	}
}();
