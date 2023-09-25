var VueCmp = new Vue({
	el:'#vueuse'
});

var isEmpty = function(obj){
	if(typeof(obj) == 'undefined' || obj == null || obj == ''){
		return true;
	}else{
		return false;
	}
}

var copyObjProperty = function(from,to,createProperty){
	for(var key in from){
		if(createProperty){
			to[key] = from[key];
		}else{
			if(to.hasOwnProperty(key)){
				to[key] = from[key];
			}
		}
	}
}


/**
 * 方法名：ajax
 * 参数1：url地址，如：'http://kdcx.zendee.cn/express/getExpressCode.action'
 * 参数2：请求参数，如：{expNo:'123456'}，可为null
 * 参数3：请求成功回调方法，如：function(data,textStatus){},data是返回的数据，数据格式请看参数4的dataType说明了，textStatus为状态文本
 * 参数4：自定义配置：如：{type:'post'}，可为null
 * 		参数解析
 * 				headers：请求头，如{token,'6666'}，默认null
 * 				type：请求类型，'POST'和'GET'，默认：'GET'
 * 				cache：是否缓存页面，true缓存，false不缓存，默认：false
 * 				async：是否一步请求，true异步，false不异步，默认：true
 * 				timeout：请求超时时间，单位毫秒，默认60000
 * 				dataType：请求成功返回数据格式，'xml','html','script','json','jsonp','text'，默认：'json'
 * 				isWait：是否显示加载中动画，true显示，false不显示，默认：false
 * 				isShowErrorMsg：请求失败是否显示提示信息（与后台result结合），true显示，false不显示，默认：true,
 * 				errorFn：请求失败回调方法 如：function(XMLHttpRequest,textStatus,errorThrown){}
 * 				completeFn：请求完毕回调方法 如：function(XMLHttpRequest,textStatus){}
 */

var ajax = function(url,param,successFn,cfg){
	if(isEmpty(cfg)){
		cfg = {};
	};
	var headers = cfg.headers;
	if(isEmpty(headers)){
		headers = {ajax:'yes'};
	}else{
		headers.ajax = 'yes';
	}
	var type = cfg.type;
	if(isEmpty(type)){
		type = 'GET';
	};
	var cache = cfg.cache;
	if(isEmpty(cache)){
		cache = false;
	};
	var async = cfg.async;
	if(isEmpty(async)){
		async = true;
	};
	var timeout = cfg.timeout;
	if(isEmpty(timeout)){
		timeout = 60000;
	};
	var dataType = cfg.dataType;
	if(isEmpty(dataType)){
		dataType = 'json';
	};
	var isWait = cfg.isWait;
	if(isEmpty(isWait)){
		isWait = false;
	};
	var wait = null;
	if(isWait){
		wait = VueCmp.$loading({
			lock:true,
			text: '请稍等......',
			spinner: 'el-icon-loading',
			background: 'rgba(0, 0, 0, 0.7)'
		});
	};
	var isShowErrorMsg = cfg.isShowErrorMsg;
	if(isEmpty(isShowErrorMsg)){
		isShowErrorMsg = true;
	};
	
	$.ajax({
		url:url,
		headers:headers,
		type:type,
		cache:cache,
		async:async,
		timeout:timeout,
		data:param,
		dataType:dataType,
		success:successFn,
		error:function(XMLHttpRequest,textStatus,errorThrown){
			if(isShowErrorMsg){
				var result = XMLHttpRequest.responseJSON;
				if(!isEmpty(result.reason)){
					VueCmp.$message({
						type:'warning',
						message:result.reason,
						showClose:true
					});
				}else if(textStatus=='timeout'){
					VueCmp.$message({
						type:'error',
						message:'请求超时，请稍后重试！',
						showClose:true
					});
				}else if(textStatus=='error'){
					VueCmp.$message({
						type:'error',
						message:'请求失败，请稍后重试！',
						showClose:true
					});
				};
			};
			if(typeof(cfg.errorFn)=='function'){
				cfg.errorFn(XMLHttpRequest,textStatus,errorThrown);
			};
		},
		complete:function(XMLHttpRequest,textStatus){
			if(!isEmpty(wait)){
				wait.close();
			};
			if(typeof(cfg.completeFn)=='function'){
				cfg.completeFn(XMLHttpRequest,textStatus);
			};
		}
	});
};