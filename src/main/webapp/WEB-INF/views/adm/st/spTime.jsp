<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="nav" uri="/pNavi-tags" %>
<script type="text/javascript" src="<c:url value='/resources/usr/js/freeCommon.js' />"></script> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
<script type="text/javascript">
	$(document).ready(function(){
		$(function() {
			$("#stDateImg").click(function(e){
				e.preventDefault();
				$(".firstDate1").datepicker('show');
			});
			$("#enDateImg").click(function(e){
				e.preventDefault();
				$(".firstDate0").datepicker('show');
			})
			
			$(".firstDate0,.firstDate1").datepicker({
		  		dateFormat: "yy.mm.dd"
		  	});
			
			$(".firstDate0,.firstDate1").change(function(){
				if($(".firstDate0").val().trim().length>0 || $(".firstDate1").val().trim().length>0){
					var firstDate0 = $(".firstDate0").val().replace(".","");
					firstDate0 = firstDate0.replace(".","");
					
					var firstDate1 = $(".firstDate1").val().replace(".","");
					firstDate1 = firstDate1.replace(".","");
					
					//alert(firstDate0+"---"+firstDate1);
					if(parseInt(firstDate0) > parseInt(firstDate1)){
						$(".firstDate1").val($(".firstDate0").val());
						return false;
					}
				}
			});
		  	
		 });
	});	
</script>

<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate var="year" value="${now}" type="both" pattern="yyyy"/>

 <section class="board">
      <!-- 제목 : str -->
      <div class="subtitle">
        <hgroup>
          <h2>Network Statistics</h2>
          <h3>Check the traffic, internet speed, and the AC status here</h3>
        </hgroup>
      </div>
      <!-- 제목 : end -->

      <!-- 탭1============================================ : str -->
      <div id="tabs">
        <ul>
          <li><a href="${pageContext.request.contextPath }/adm/st/list?url=trMonth">Traffic</a></li>
          <li><a href="${pageContext.request.contextPath }/adm/st/list?url=spMonth" class="hover">Internet Speed</a></li>
          <li><a href="${pageContext.request.contextPath }/adm/st/list?url=acMonth">AC Monitoring</a></li>
        </ul>
		<form id="command">
		
        <div id="tabs-2" class="topLine">
          <!-- 탭2 Traffic============================================ : str -->
          <span class="tab_topLine"></span>
          <section id="tab-container" class="stats">
            <ul>
              <li><a href="javascript:doSubmit('${pageContext.request.contextPath }/adm/st/list?url=spMonth', 'command', 'post');" class="tab"><img src="<c:url value='/resources/images/btn_month.gif' />" alt="" /></a></li>
              <li><a href="javascript:doSubmit('${pageContext.request.contextPath }/adm/st/list?url=spDay', 'command', 'post');" class="tab"><img src="<c:url value='/resources/images/btn_day.gif' />" alt="" /></a></li>
              <li><a href="javascript:doSubmit('${pageContext.request.contextPath }/adm/st/list?url=spTime', 'command', 'post');" class="tab"><img src="<c:url value='/resources/images/btn_time_on.gif' />" alt="" /></a></li>
            </ul>            
            <section id="contents-3" class="topLine">
              <!-- Time : srt -->
              <div class="statsSchbox">
                <button type="button" class="statsSch" onclick="doSubmit('${pageContext.request.contextPath }/adm/st/list?url=spTime', 'command', 'post')"></button>
                <a href="#" class="iconCalendar2" id="stDateImg"><img src="<c:url value='/resources/images/icon_calendar2.gif' />" alt="icon Calendar" /></a>
                 <input name="strEdate" type="text" readonly class="firstDate1" title="input : date" value="<fmt:parseDate value="${fn:substring(requestMap.strEdate,0,8) }" var="dateFmt" pattern="yyyyMMdd" /><fmt:formatDate value="${dateFmt}" type="both" pattern="yyyy.MM.dd" />" />
                <span>~</span>
                <a href="#" class="iconCalendar" id="enDateImg"><img src="<c:url value='/resources/images/icon_calendar2.gif' />" alt="icon Calendar" /></a>
              	<input name="strSdate" type="text" readonly class="firstDate0" title="input : date" value="<fmt:parseDate value="${fn:substring(requestMap.strSdate,0,8) }" var="dateFmt" pattern="yyyyMMdd" /><fmt:formatDate value="${dateFmt}" type="both" pattern="yyyy.MM.dd" />" />
              </div>
              <section>
                <table class="boardSch" summary="Month">
                  <colgroup>
                    <col width="80" />
                    <col width="53" />
                    <col width="53" />
                    <col width="53" />
                    <col width="53" />
                    <col width="53" />
                    <col width="53" />
                    <col width="53" />
                    <col width="53" />
                    <col width="53" />
                    <col width="53" />
                    <col width="53" />
                    <col width="*" />
                  </colgroup>
                  <thead>
                    <tr>
                      <th rowspan="3">Sort</th>
                      <th colspan="4">Total<em>(bps)</em></th>
                      <th colspan="4">GIGA Wifi<em>(bps)</em></th>
                      <th colspan="4" class="end">LAN<em>(bps)</em></th>
                    </tr>
                    <tr>
                      <th colspan="2">UP</th>
                      <th colspan="2">DOWN</th>
                      <th colspan="2">UP</th>
                      <th colspan="2">DOWN</th>
                      <th colspan="2">UP</th>
                      <th colspan="2" class="end">DOWN</th>
                    </tr>
                    <tr>
                      <th>Min</th>
                      <th>Max</th>
                      <th>Min</th>
                      <th>Max</th>
                      <th>Min</th>
                      <th>Max</th>
                      <th>Min</th>
                      <th>Max</th>
                      <th>Min</th>
                      <th>Max</th>
                      <th>Min</th>
                      <th class="end">Max</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:forEach var="result" items="${list}" varStatus="status">
                    <tr>
                      <th>${result.END_HOUR} Hour</th>
                      <td><c:if test="${result.TOT_UP_MIN==null}">0</c:if><fmt:formatNumber value="${result.TOT_UP_MIN}" type="number"/></td>
                      <td><c:if test="${result.TOT_UP_MAX==null}">0</c:if><fmt:formatNumber value="${result.TOT_UP_MAX}" type="number"/></td>
                      <td><c:if test="${result.TOT_DOWN_MIN==null}">0</c:if><fmt:formatNumber value="${result.TOT_DOWN_MIN}" type="number"/></td>
                      <td><c:if test="${result.TOT_DOWN_MAX==null}">0</c:if><fmt:formatNumber value="${result.TOT_DOWN_MAX}" type="number"/></td>
                      <td><c:if test="${result.WIFI_UP_MIN==null}">0</c:if><fmt:formatNumber value="${result.WIFI_UP_MIN}" type="number"/></td>
                      <td><c:if test="${result.WIFI_UP_MAX==null}">0</c:if><fmt:formatNumber value="${result.WIFI_UP_MAX}" type="number"/></td>
                      <td><c:if test="${result.WIFI_DOWN_MIN==null}">0</c:if><fmt:formatNumber value="${result.WIFI_DOWN_MIN}" type="number"/></td>
                      <td><c:if test="${result.WIFI_DOWN_MAX==null}">0</c:if><fmt:formatNumber value="${result.WIFI_DOWN_MAX}" type="number"/></td>
                      <td><c:if test="${result.LAN_UP_MIN==null}">0</c:if><fmt:formatNumber value="${result.LAN_UP_MIN}" type="number"/></td>
                      <td><c:if test="${result.LAN_UP_MAX==null}">0</c:if><fmt:formatNumber value="${result.LAN_UP_MAX}" type="number"/></td>
                      <td><c:if test="${result.LAN_DOWN_MIN==null}">0</c:if><fmt:formatNumber value="${result.LAN_DOWN_MIN}" type="number"/></td>
                      <td class="end alignC"><c:if test="${result.LAN_DOWN_MAX==null}">0</c:if><fmt:formatNumber value="${result.LAN_DOWN_MAX}" type="number"/></td>
                    </tr>
                    </c:forEach>
                    <!-- 
                    <tr class="bottomLine">
                      <th>24시</th>
                      <td>15,000</td>
                      <td>15,000</td>
                      <td>15,000</td>
                      <td>15,000</td>
                      <td>15,000</td>
                      <td>15,000</td>
                      <td>15,000</td>
                      <td>15,000</td>
                      <td>15,000</td>
                      <td>15,000</td>
                      <td>15,000</td>
                      <td class="end alignC">15,000</td>
                    </tr>
                     -->
                  </tbody>
                </table>
                <p class="unit">(unit: bps)</p>
              </section>
              <div class="excelDown unit">
                <div class="alignCenter">
                  <div class="button1 type2">
                    <a href="javascript:doExcelFileDownSubmit('${pageContext.request.contextPath }/adm/st/list?url=spTime&downExcel=Y', 'command', 'post');"><img src="<c:url value='/resources/images/btn_icon_excel.gif' />" alt="icon" /><span>Download Excel</span></a>
                  </div>
                </div>
              </div>
              <!-- Time : end -->
            </section>

          </section>
          <!-- 탭2 Traffic=========================================== : end -->
        </div>
      <!-- 탭1=========================================== : end -->
      
      </form>
    </section>