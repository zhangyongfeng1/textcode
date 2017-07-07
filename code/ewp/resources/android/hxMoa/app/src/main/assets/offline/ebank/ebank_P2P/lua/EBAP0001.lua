(function(this)

	--如果总页数返回""或者nil-->"0"
	function change_CountNum (recordCountNum)
	    if recordCountNum == "" or recordCountNum == nil then
	    	recordCountNum = "0";
	    end
	    return recordCountNum;
	end

	--页码pageNumber 
	local pageNumber = "1";
	--每页显示记录数countNum
	local countNum = "10";
	--总条数
	local recordCountNum = "1";

	local div = [[<div name="referencelist" class="div_t246_h255_w320" border="0">
            			<table class="tabel_w320_bgFFFFFF,height249" type="scrolltable" nexturl="reference_list('3')" preurl ="upUrl()" border="0">]];

	--回调、交易明细刷新数据
	function refurbish_callback(response)
            local code = response["responseCode"];
            if code == 200 then
	       local json_data = response["responseBody"];
    	       local json_tbl = json:objectFromJSON(json_data);
	       local transaction_list = json_tbl["body"]["transactionlist"];
	   
                recordCountNum = change_CountNum(json_tbl["body"]["recordCountNum"]);
                pageNumber = pageNumber + 1;

                --判断是否有数据
                if recordCountNum == "0" then
	    	    local div = [[<div name="referencelist" class="div_t291_h210_w320" border="0">
			             <label class="label_l136_t10_w320">暂无数据</label>
			           </div>]];
		    local show_div= document:getElementsByName("referencelist");
	             if show_div ~= nil and #show_div>0 then
	                 show_div[1]:setInnerHTML(div);
	             end
	       else
                      for key,value in pairs(transaction_list) do
            	          div = div..[[
            	          <tr class="trtd_h40_w320" border="1">
                               <td class="trtd_h40_w320">
                                   <label class="label_l15_fs14_c999999">]]..format_date_year_month(value["transactionDate"])..[[</label>
                                   <label class="label_r140_fs14_c999999">]]..format_money(value["transactionAmount"])..[[</label>
                                   <label class="label_r35_fs14_c999999">]]..value["transactionType"]..[[</label>
                                   <label class="public_line_b1"></label>
                              </td>
                            </tr>]];
                      end
                      local div_callback ="";
                      div_callback = div..[[</table></div>]];
                      local show_div= document:getElementsByName("referencelist");
	             if show_div ~= nil and #show_div>0 then
	                 show_div[1]:setInnerHTML(div_callback);
	             end
	        end
	    else
                 window:alert("网络请求失败");
                 return;
             end
	end

	--向下滑动空方法
	function upUrl()
		
	end

	--P2P列表查询--falg判断是否是首次进入
	function reference_list(falg,merchantId)
	    local startData;--获取开始日期
	    if falg == "1" then
	        startData = get_early_month(string.gsub(ert("#dateStart"):val(),"-",""));
	        ert("#dateStart"):attr("value",format_date(startData));
	        location:reload();
	    elseif falg == "2" then
	    	startData = change_date(ert("#dateStart"):val());
	    	pageNumber = "1";
	    	div = [[<div name="referencelist" class="div_t246_h255_w320" border="0">
            			<table class="tabel_w320_bgFFFFFF,height249" type="scrolltable" nexturl="reference_list('3')" preurl ="upUrl()" border="0">]];
             else
             	startData = change_date(ert("#dateStart"):val());
	    end
	    local endData = string.gsub(ert("#dateEnd"):val(),"-","");--获取结束日期
	    local merchantId = ert("#merchantId"):val();--获取商户编号

	    --获取当前日期
	    local date = os.date("%Y%m%d");

	    --日期校验
	    if startData > date or endData > date then
	    	window:alert("选择日期不能早于当前日期");
		return;
	    end

	    if startData > endData then
	    	window:alert("开始日期必须早于结束日期");
		return;
	    end

	    local after_a_year_years = string.sub(endData,1,4);
             after_a_year_years = after_a_year_years -2;
             local after_date = tonumber(after_a_year_years .. string.sub(endData,5,8));
             if after_date > tonumber(startData) then
                   window:alert("起止日期的跨度不能超过两年");
                   return;
             end
             
	    if recordCountNum ~= "0" and tonumber(pageNumber) > tonumber(math.ceil(recordCountNum/countNum)) then
		window:alert("最后一页");
		return;
	    else
	    	ert.channel:next_page("ebank_P2P","EBAP0002",{id="ebank_P2P",tranCode="EBAP0002",startData=startData,endData=endData,pageNumber=pageNumber,countNum=countNum,merchantId=merchantId},{request_callback=refurbish_callback});
	    end
	end
	reference_list("1");

	--选择要查询的平台交易明细
	function option_choice(merchantId)
	    reference_list("1",merchantId);
	end

	ebank_public.allSuit:physicalkey_back();
end)(ert.channel:get_page("ebank_manage_asset","EBAP0001"));