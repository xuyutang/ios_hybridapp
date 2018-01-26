/*
 * form validate 
 * version 1.0
 * Requires jQuery v1.3.2 or later
 * Author: liuxiantao 20141227
 * 
 * notBlank
 * date
 * email
 * phone
 * integer
 * length
 * same
 * after
 * regex 
 */

var Map = function() {
	this.elements = {};
}

Map.prototype.put = function(key, value) {
	this.elements[key] = value;
}

Map.prototype.get = function(key) {
	return this.elements[key];
}

Map.prototype.getClass = function() {
	return "javascript.Map";
}

Map.prototype.keys = function() {
	var k = new Array();
	for(var key in this.elements)
		k.push(key);
	return k;
}



$.fn.validate = function(config)
{
	$("font.required").remove();
	var map = $(this).form2Map();
	var paramMap = map.keys();
	//给不能为空元素加红*
	var $require = $('<font class="required" color="red">*</font>');
	var $error = $('<span class="error"></span>');
	for ( var name in config) {
		for(var i = 0; i < paramMap.length;i++) {
			var f = false;
			if (RegExp("^"+name+"$").test(paramMap[i])) {
				var $errormsg = $error.clone();
				if ($("[name='"+paramMap[i]+"']",this).attr("error-width"))
					$errormsg.width($("[name='"+paramMap[i]+"']",this).attr("error-width"));
				$errormsg.attr("id","errormsg-"+paramMap[i]);
				
				
				for ( var j = 0; j < config[name].length; j++) {
					var validateConfig = config[name][j];
					if (validateConfig.rule == notBlank) {
						if($("[name='"+paramMap[i]+"']",this).attr("type") == 'hidden') {
							
						} else {
							if ($("#errormsg-"+paramMap[i]).length == 0) {
								$("[name='"+paramMap[i]+"']",this).after($errormsg.clone());	
							} 
							if ($("#require-"+paramMap[i]).length != 0) {
								$($require.clone()).prependTo("#require-"+paramMap[i]);	
							} else {
								$("[name='"+paramMap[i]+"']",this).after($require.clone());	
							} 
						}
						
						f = true;
						break;
					} 
				}
				if (!f) {
					if ($("#errormsg-"+paramMap[i]).length == 0) {
						$("[name='"+paramMap[i]+"']",this).after($errormsg);	
					}
				}
			}
		}
	}
};

$.fn.form2Map = function()
{
    var map = new Map();
    var a = this.serializeArray();
    $.each(a, function() {
        /*if (map.get(this.name) != undefined) {
            map.get(this.name).push($.trim(this.value || ''));
        } else {
        	var values = new Array();
        	values.push($.trim(this.value || ''));*/
        	map.put(this.name, $.trim(this.value || ''));
        //}
    });
    return map;
};
$.fn.validateForm = function(config, callbackFun)
{
	var params;
	var data= '';
	params = $(this).form2Map();
	data = $(this).serialize();
    var errors = validate(config,params,data);
	var hasError = true;
    var msg = "";
    for (var name in errors) {
        if (msg.length !=0)
                msg += "\r\n"+name;
        else
              msg += name;
        hasError = false;
    }
    if(!hasError)
        App.prompt(msg);

    if (hasError && callbackFun)
    {
        callbackFun(errors);
    }

    return hasError;
}




function isBlank(value) {
	if (value == undefined || value == null || value.replace(/(^\s*)|(\s*$)/g, '') == "")
		return true;
	return false;
} 
function notBlank(config, parameters, value) {
     return !isBlank(value);
} 


function regex(config, parameters, value) {
	if (isBlank(value)) return true;
	var a = RegExp(config);
	return a.test(value);
}

function length(config, parameters, value) {
	var min = config.min||0;
    var max = config.max||100;
    
    return isBlank(value) || (value.length >= min) && (value.length <= max);
}

function select(config, parameters, value) {
	for(var i = 0; i < config.length; i++) {
		if (value == config[i]) {
			return true;
		}
	}
	return false;
}

function same(config, parameters, value) {
	var ref = config.ref;
    var refVal = parameters.get(ref);
    return refVal == value;
}

function after(config, parameters, value) {
	var ref = config.ref;
    
    var refVal = parameters.get(ref);
    if (isNumber(value)&&isNumber(refVal)) {
        return parseFloat(value) > parseFloat(refVal);
    } else {
        return (new Date(value) - new Date(refVal)) > 0;
    }
    return false;
}

function phone(config, parameters, value) {
	 if (!isBlank(value) && !(/^0?[1][358][0-9]{9}$/).test(value))
       	return false;
    return true;
}

function date(config, parameters, value) {
	if (!isBlank(value) && !(/^(\d{4})(-|\/)(\d{2})(-|\/)(\d{2})(( )(\d{2})(:)(\d{2})(:)(\d{2}))?$/).test(value))
		return false;
	return true;
}

function email(config, parameters, value) {
	 if (!isBlank(value) && !(/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/).test(value))
       	return false;
    return true;
}

function url(config, parameters, value) {
	 if (!isBlank(value) && !(/^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/).test(value))
       	return false;
    return true;
}
function integer(config, parameters, value) {
	 if(!isBlank(value) && (isNaN(value) || value.match(/[\.-]/) || parseInt(value)>2147483647)){
		 return false;
	 }
    return true;
}

function number(config, parameters, value) {
	if (!isBlank(value) && !(/^((-)?([0-9]{1,3})?([,][0-9]{3}){0,4}([.][0-9]{0,4})?)$|^(-)?([0-9]{1,14})?([.][0-9]{1,4})$|^(-)?[0-9]{1,14}$/).test(value))
		return false;
	return true;
}

function validate(config, map,data) {
	var result = {};
	var paramMap = map.keys();
	for (var name in config) {
		var exist = false;
		for(var i = 0; i < paramMap.length;i++) {	
			if (RegExp("^"+name+"$").test(paramMap[i])) {
				exist = true;
				var val = map.get(paramMap[i]);
				for ( var j = 0; j < config[name].length; j++) {
					var validateConfig = config[name][j];
					
					if (typeof(validateConfig.rule) == "function"){
						if(!validateConfig.rule(validateConfig.params, map,val)) {
							putError(result, paramMap[i], validateConfig.msg);
							break;
						}
					} else if(typeof(validateConfig.rule) == "string"){
						if( typeof formValidatorServletPath == "undefined")
						{
							alert("formValidatorServletPath未设置");
							return;
						}
						
						var flag = true;
						data += '&rule_value='+val+'&rule='+validateConfig.rule+'&rule_name='+paramMap[i];
						$.ajax({ 
					       type: "post", 
					       url: formValidatorServletPath +"/formValidator", 
					       cache:false, 
					       async:false, 
					       data: data, 
					       dataType: 'json', 
					       success: function(data){ 
//					    	   $.each(data.paramErrors, function(key, value) {  
//					    		  flag = false;
					    	   if (!data.success)
				    		  	  putError(result, paramMap[i], validateConfig.msg);
//		                        });  
					       } 
						});
						if(!flag) {
							break;
						}
					} else {
						alert("数据验证规则未设置");
					}
				}
				if(name == paramMap[i]) {
					break;
				}
			}
		}
		if(!exist){
			for ( var j = 0; j < config[name].length; j++) {
				var validateConfig = config[name][j];
				if ((""+validateConfig.rule).indexOf("notBlank(") != -1) {
					putError(result, name, validateConfig.msg);
					break;
				}
			}
		}
	}
	return result;
}

function putError(result, param, msg){
	var _paramnames = result[msg];
	if (_paramnames == null) {
		result[msg] = param;
	} else {
		if ((typeof _paramnames) != "object"){
			_paramnames = new Array();
			_paramnames.push(result[msg]);
			result[msg] = _paramnames;		
		}
		_paramnames.push(param);
	}
}

function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
  } 