<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="_csrf" content="${_csrf.token}"/>
	<!-- default header name is X-CSRF-TOKEN -->
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<!-- Bootstrap Core CSS -->
	<link href='<spring:url value="/adminWebTheme/vendor/bootstrap/css/bootstrap.min.css" />' rel="stylesheet" type="text/css">
	<!-- MetisMenu CSS -->
	<link href='<spring:url value="/adminWebTheme/vendor/metisMenu/metisMenu.min.css" />' rel="stylesheet" type="text/css">
	<!-- Custom CSS -->
	<link href='<spring:url value="/adminWebTheme/dist/css/sb-admin-2.css" />' rel="stylesheet" type="text/css">
	<!-- Morris Charts CSS -->
	<link href='<spring:url value="/adminWebTheme/vendor/morrisjs/morris.css" />' rel="stylesheet" type="text/css">
	<!-- Custom Fonts -->
	<link href='<spring:url value="/adminWebTheme/vendor/font-awesome/css/font-awesome.min.css" />'	rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    	<!-- jQuery -->
	<script	src='<spring:url value="/adminWebTheme/vendor/jquery/jquery.min.js" />'></script>
	<!-- Bootstrap Core JavaScript -->
	<script	src='<spring:url value="/adminWebTheme/vendor/bootstrap/js/bootstrap.min.js" />'></script>
	<!-- Metis Menu Plugin JavaScript -->
	<script	src='<spring:url value="/adminWebTheme/vendor/metisMenu/metisMenu.min.js" />'></script>
	<!-- Custom Theme JavaScript -->
	<script	src='<spring:url value="/adminWebTheme/dist/js/sb-admin-2.js" />'></script>
    
    
    <tiles:insertAttribute name="head" />
</head>

<body>

	<tiles:insertAttribute name="body" />
</body>
</html>