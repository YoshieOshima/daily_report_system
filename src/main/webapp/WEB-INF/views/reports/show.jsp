<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="constants.ForwardConst" %>
<%@ page import="constants.AttributeConst" %>

<c:set var="actRep" value="${ForwardConst.ACT_REP.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commEdt" value="${ForwardConst.CMD_EDIT.getValue()}" />
<c:set var="approval" value="${ForwardConst.CMD_APPROVAL.getValue()}" />
<c:set var="deleteapproval" value="${ForwardConst.CMD_DELETE_APPROVAL.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">

        <h2>日報 詳細ページ</h2>

        <table>
            <tbody>
                <tr>
                    <th>氏名</th>
                    <td><c:out value="${report.employee.name}" /></td>
                </tr>
                <tr>
                    <th>日付</th>
                    <fmt:parseDate value="${report.reportDate}" pattern="yyyy-MM-dd" var="reportDay" type="date" />
                    <td><fmt:formatDate value='${reportDay}' pattern='yyyy-MM-dd' /></td>
                </tr>
                <tr>
                    <th>内容</th>
                    <td><pre><c:out value="${report.content}" /></pre></td>
                </tr>
                <tr>
                    <th>登録日時</th>
                    <fmt:parseDate value="${report.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="createDay" type="date" />
                    <td><fmt:formatDate value="${createDay}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th>更新日時</th>
                    <fmt:parseDate value="${report.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="updateDay" type="date" />
                    <td><fmt:formatDate value="${updateDay}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th>承認</th>
                    <td>
                    <c:choose>
                    <c:when test="${report.approval == 1}">承認済</c:when>
                    <c:otherwise>未承認</c:otherwise></c:choose>
                    </td>
                </tr>
                <c:if test="${report.approval == 1}">
                <tr>
                    <th>承認日時</th>
                    <fmt:parseDate value="${report.approvedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="approvedDay" type="date" />
                    <td><fmt:formatDate value="${approvedDay}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th>承認者</th>
                    <td><c:out value="${report.approvedBy}" /></td>
                </tr>
                </c:if>
            </tbody>
        </table>

        <c:if test="${sessionScope.login_employee.id == report.employee.id}">
            <p>
                <a href="<c:url value='?action=${actRep}&command=${commEdt}&id=${report.id}' />">この日報を編集する</a>
            </p>
        </c:if>


        <c:if test="${sessionScope.login_employee.id != report.employee.id}">
        <c:if test="${report.approval == 0}">
        <form method="POST" action="<c:url value='?action=${actRep}&command=${approval}' />">
            <input type="hidden" name="${AttributeConst.REP_ID.getValue()}" value="${report.id}" />
            <input type="hidden" name="${AttributeConst.TOKEN.getValue()}" value="${_token}" />
            <button type="submit">承認する</button>
        </form>
        </c:if>
        <c:if test="${report.approval == 1}">
        <form method="POST" action="<c:url value='?action=${actRep}&command=${deleteapproval}' />">
            <input type="hidden" name="${AttributeConst.REP_ID.getValue()}" value="${report.id}" />
            <input type="hidden" name="${AttributeConst.TOKEN.getValue()}" value="${_token}" />
            <button type="submit">承認を取り消す</button>
        </form>
        </c:if>
        </c:if>



        <p>
            <a href="<c:url value='?action=${actRep}&command=${commIdx}' />">一覧に戻る</a>
        </p>
    </c:param>
</c:import>