Return-Path: <dmaengine+bounces-10595-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI2RAGeFDmrq/AUAu9opvQ
	(envelope-from <dmaengine+bounces-10595-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:09:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A6159EAFA
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFBB530254E8
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 04:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464DE3859EC;
	Thu, 21 May 2026 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wrJ5yFR6"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55928384CF5;
	Thu, 21 May 2026 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336180; cv=fail; b=G/2nfNvAArmMOn1O5u2yk73ATcULQLdVwRSXwbWXZc8DVuyrsflcZjIVpSuPIdLskSiQvhxHXD4wRG479B1UkjayBQMormVs4hGboaVZ3xzCH23DIu034VrQQLr+aA4iSfBCBchBG80CVVN2aFdbBbzigjlxRF5Fe5djGykZE8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336180; c=relaxed/simple;
	bh=4P21RHS1cRmS2gst9EAt/kIS5NP12dikh3CeRKQZ5CY=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=N3nGO7QxPJvlKedfZPWDh0erKX54MRkQ8aEi5QTZA3dMYKqRG9yneW75dR3N28UzXtWgmz6hSfbs9dXg7OFY6z6e5E/bBXOGHeRSh/eBdy3A/q2MXGjloFzQxkkp3sl4TF8MCrg9LWJs4jc3kP/zag9HmAJZZfH869EGnvJxojA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wrJ5yFR6; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URLSB6C1alPbInxGZ0BZsh1vsxdOHoeJlS/jqRn0jVRGPWndjiBHn96z6tm2eCVq4SoNaSWyHg7+C7DOE5rd8xCJWHKGn/H+R3TR6sV9MipgVET8YBpkaWnV3BuoPlPxmQfGJx0ZZqk4C/EJ7lJMZrHiJL82svL8Zle/890fLMOL7PcMVuoQ/35UI4ow6upgf8lL4vxxdWGjnhgF0X0U45dCUrVjnFDOHg6aQjHYX77c2ybkvRM0Eguwz1yMug7VmbC7pUNUCLJs7kpv47WcZos9NHI/STNe0IEJ0iy6JA0w/7aM374UguIPNO3+W4i24zcZ0Vz5ziJlUGgWbGAklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0yEy+cqzHN1LcdeTV7Bzq8MzgxYdpiAZqhAanduywM=;
 b=jZBtHvJX7ZTBTfCiZcBszPHURtXlVg5c1mbPXM5y015YUyxZtN9ros9TDWbbMG+r+L2qZR5yruL6ZLZ60RE8BW4ron9ds6U9p/vq+2mRdEWm0/xsDATJWySBRUFwozt1b0GCYzaxiJdTFOdVWp4WRUoZH9GNABrWgEDiawtAtGTdZA0PZclkvoT60vlf2vvvhanEuTAswq/sY2V4jS3weaG1ft+eu66hBFCRNtKsSCemEJLcCrhbmrlIFH/bZtPXqkGl2lxixU5eA1Qx9ZvJ/8rogeQzGCVcNtorxzfszuBNLK7ud9n0GmMYZlpWce7sChM6ZN9RQ1Ryxyn2RH0tmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0yEy+cqzHN1LcdeTV7Bzq8MzgxYdpiAZqhAanduywM=;
 b=wrJ5yFR6+50e43jmhNETpr4rH3mnhVQaBK4Hsuu6C5V3yEN02rjk6RUR3cfLze7hOoQzMVo4rBXVt9UWiq38pJJDhooJXRzT3CgI/K7Sg9+VQW88KT/9uE4/5IQQ42zvE4ly8/yZ9uK/nV8//eymvPq0G6TNBaY8LucxEBeVB4qZv1KxMmEUsNTpEKWYcphA3raWE16DsNyK5qtD0aR8Ch5TYVptsdVdJMQmWvPWOLpOeERPOBJq0BS5glxLeNv/NW3FV7ue94w7+Gb9JuoFvODEXWPV71Y6XjrOKQpGab/fqOupCOZRUNIFiuDyD5PNvO0/WtoETTWI5gpr1DGyYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB11531.eurprd04.prod.outlook.com (2603:10a6:102:4df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 21 May
 2026 04:02:50 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 04:02:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 21 May 2026 12:05:04 +0800
Subject: [PATCH] dt-bindings: dma: fsl-edma: add optional iommus property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-edma-iommu-v1-1-6eec3f24c306@nxp.com>
X-B4-Tracking: v=1; b=H4sIAG+EDmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyND3dSU3ETdzPzc3FLdZAMj01TDFCOL1KREJaCGgqLUtMwKsGHRsbW
 1AKNxNXVcAAAA
X-Change-ID: 20260521-edma-iommu-c025e1d28eba
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MA5PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB11531:EE_
X-MS-Office365-Filtering-Correlation-Id: 989b5f92-25b2-442c-50e0-08deb6edd37b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|56012099003|18002099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	xbr8BvkJYSoWA4BHOB+j4w3AzIce0bbSIAV/HJKDTaCU/c88I3Y7TfWlui3tl81zVKi7/xxGilfNBEJMgq9/P6Qlj6mgWdoKybGQbflRanCjS5i4yxR2d92fWBsp0rUTcxmb5gkO/ycHoPBKE2bQXhK3bc+L/rbwIHFcq0jSpbe94FLRkM6DaBfDO9z72Cqg+PNIDsBjoXOnPvBPqzvOnwnpRnmupnCyhANiZhzPcsYxbljzx1uIVIRkLaoipTytOSYLAtxLJpbWkEQiGaNzkAH8xSIlqnebCXI1t5GT0CIlqGNd8os2HZUYtKVn39Jg+NZKEWMe8nUUIDfx8UFFFUlwGxnC8wfoELKL3hhF5MI3GSpGZDX+9p9MShn6TUFUID3IaUv9kxgjuDokVvqnYPpZrDa0DpbMhFSZdgq1oZ3XB5ZeCEQ/B99be3hyp1/CzdC5QYGCpvoORcodeQlbVVVOTAiOyvU2DH5h0gLGC1wSXmJ9QWjcJQzNXsdvPlzet9EjdiWno/63L+T+OO7am6QxZtPEXw0p2dDHTHKX4ufE+FvhFJZg/MVh1iPsHRtDrqxpPW2EKXEKehLNuJzaasAeKVAq99iUKPGPU1LWtswWf9mWGuowXW0Rf9ZXpiIaP/5fLG91S/oixXm5jJ/h6LmgWIxe55LT3/gJg1M76ew17BGjXH9/tl+mbHgnX3gADwjhLTVfhuwZ6PQnYM7vmqPg8ILspvkmnbE2JOKUmvu9ZSzvPtmyG+ABZmyKFyVQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(56012099003)(18002099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VC9lTFFzdGFjYmx0R1I1L3NVMURFNUtPSDg3bjdIblcxR0tpSitzaVZuZjZ2?=
 =?utf-8?B?elFZRmk0dWJwWWtIUy9UN2RFd09GYWl2MFpWR0VTb0d0UXRqbGY1SVpnZGt0?=
 =?utf-8?B?MjY0c1grUGhBSHppUTFhS2tqM0xGaDBOZTBvV043T0QzbFFaZjVzQlFSL0hQ?=
 =?utf-8?B?ZGt2NkoxU2hlR2VZc2RUaGk5ZnNBamxVSHp3dkI0TUJ3YWQ1cldaVTVUY2JH?=
 =?utf-8?B?YkZjVzZtYTRmdi9GN0ZDZzJqb1VPYWNVQmJpdGc3T0VMbG12RHRaZ2lKNFM1?=
 =?utf-8?B?czFyRUpka1RYN0lNaHFWbVJ6MkhQKzJtOW8xa1hhaFkweDZzWEF6QXZzM1Z3?=
 =?utf-8?B?WmNiMGdkMGp5NzVYQTlCUmhMVFlaYXkxNzUvQ2lOeWNhaE9mdUJpZDBDZHdN?=
 =?utf-8?B?MGhiVmU4U0VHaHhzWGFRVWwxSGdZUFVvd0ZjVGtZb1VkdjRqVFVCYWYxdGRs?=
 =?utf-8?B?MEhFd1hRZHZRV0M0aTdOMWdOT3ZoOXJpalNSN3pRclNjM3UzZTdKREZUdTgx?=
 =?utf-8?B?NyswYXptQjVYaUZXWlVTNnV5QklYSi9pQkJzRHBRTDBHVnowQTFBZnZINFcx?=
 =?utf-8?B?TUxOclZhOFZiaE5SblhTSk9CZUp2b3F2bFFzLzdXaExWT0V6cGdMa1d1TU41?=
 =?utf-8?B?TFlWWFJWVEYyMzJHdmxzMmVreXlIcjhaK0dnalFWb0IzNFJpbnV2d0kyaUR4?=
 =?utf-8?B?N3hWTEZWSzllYnBwM25COGpTQXRDK3VBRVYzYWRTNzRrTitWdWRQQXpIRFZF?=
 =?utf-8?B?M2x6QzN1OG9McjJ3TDlkZnFZbVFxVTYxTFA2RlFKeUhNYS9ycUIxYXBLZ2JZ?=
 =?utf-8?B?L1gveDdvWU16VFJpZDB2U3FlMEhuVGp5KzNKdmJ0encrQlNXRGFKQW1qcHkw?=
 =?utf-8?B?S0ZSaDhrWTZyMDcydnJ6Tk1DenFlVzBoalBoM1EyUVZTMW1nQTJRc1pTdWkw?=
 =?utf-8?B?T0hKQkxRcVdMc051eGhnRlR0RWExczRkbEV2QUVzTFA4b1hraVlabUViSmx2?=
 =?utf-8?B?ejFxZU5UN05rUnh3ZVlRWTV5ZG9tdWFOdTJNM2hVa25uK0Q4NDM3dDZ2bzk5?=
 =?utf-8?B?NVR3YzI3eEhvSlRqd25mWlFscHZQV095am1Nd3IwdFVtb0U2OFJiMGJiTmFN?=
 =?utf-8?B?cW1COUdCMzlZNHZQWTg1NVB1K1RsaFF3NGlQQ0Q4WURBQmRYeG83eXdBQjNW?=
 =?utf-8?B?bXptK3o0WEovbmt6bndwb3FWOVFNdHN3Nk5JQ2laSEhFcHY0bmxzUU0wNjdV?=
 =?utf-8?B?aE9UYmE0dGRmMzY2TTRDK3drK2NHVlFSdmpuMUx0SFl2Z3NmN1NaVUF4T2h6?=
 =?utf-8?B?SlNZWGdYM2FGNjZSK0VzMjNrRzgwTlhYVTRXM1NUMVRzcnErM0didWtPbER6?=
 =?utf-8?B?cTJnbi82NE5FZDZsZ2F0S1paWVowVElRbit6R1FmUmYwOHVjUEpoejROY0hZ?=
 =?utf-8?B?Yld1Ym9aMFlZMTZyc3JxSjFWQit0VzhVd1pHZ21xYnl4cFY1YWlSWmRsRGFZ?=
 =?utf-8?B?N3BYb1JQbk54bFhPZGY3bTBoejJrV2UxY0JQZkdGZHYxV0c4bVAzQUxXd1Vr?=
 =?utf-8?B?WWZZdnhiczZCbXppQ3FmbmNvUXhWOVdCV0VUL3hPbkhBOUtYY3JGb3k5T0Jq?=
 =?utf-8?B?Mjg2RjZRc0JMeE5hc1dnZHAyemNZdXVXMkt2OS9KZzJJK3J2Y3lFd0srZk9r?=
 =?utf-8?B?YVFqbURzRGlYS0EyZUZzdVhDQTZYQnpjeG8rbDlFS0ttZmZQanQ0Q213d3d5?=
 =?utf-8?B?WXNHQmtsR0RSVWtXSFBiYzIxWXFSK0tJcERkOWhkekNsdDNzRTlQVzJxeExl?=
 =?utf-8?B?ZG82VGZXTGtiWTJGSS9FWnZmcUlEOTRRWDdlZlkxK2ZZTmJ0QjdnaVI0ZXZM?=
 =?utf-8?B?Rzl6czM5NGN0L3JhVmxtM2VxRGJjeFZ5Z3RpSXYxZENud0xESmF4WFZFRlNx?=
 =?utf-8?B?QXJTQWxHVnIvcW5IQVU5WVhUb2VoTTc4MlcyUnF3a2xFdDk0NXZ2MVRtOEMv?=
 =?utf-8?B?c0ZQSVFVcnYxNUNmZU5ub2JEQ2VHMjBvbENHNjBTQTlLR0FoRStzVG9UTzhE?=
 =?utf-8?B?SGUzbkp0ZzdYZ1dITzNRZmdpQ0JDQldJVnlKdldXNURqUlZGcmUxMXFyUldZ?=
 =?utf-8?B?RTJXU2V3NWNBbkxCRDEzZjhLUndlMHZsbU5lRVpXekZNVDVySjJVVC9TRThs?=
 =?utf-8?B?enhQQm11eHRmMzBTMlZjRkd4ZDBCdTFIWHI5Q2l0OE5HUEJJL0UzaE9qRUpm?=
 =?utf-8?B?YVY2WHh4UnArdXVVU1FuVWZWaXhYZG1EcHBOYUhmRGJ3K29RZDRGRXI5MkNX?=
 =?utf-8?B?NUdEdWxpYWFheGdET3R5RmV4ZHpuU0E3eFl2UnRiVW9FL1ZQa1dLdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989b5f92-25b2-442c-50e0-08deb6edd37b
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 04:02:50.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Hm9QHsY12cZ8BGwEyZk+zAhaLyN421OFXya5d1Nma9R7GT5yr/ZZRvT/d9sYmGCWAgi0rETlJdQ2xFE4qznmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11531
X-Spamd-Result: default: False [1.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_MATCH_TO(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TAGGED_FROM(0.00)[bounces-10595-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 70A6159EAFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peng Fan <peng.fan@nxp.com>

Add iommus property with each channel could use one IOMMU entry. i.MX95
supports max 64 channels, so set [minItems,maxItems] to [1,64].

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index fa4248e2f1b9cecd00f1535744bfe6d9ecdba613..bb8de804da53fdc47703f722f18453853742209d 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -54,6 +54,11 @@ properties:
     minItems: 1
     maxItems: 65
 
+  iommus:
+    minItems: 1
+    maxItems: 64
+    description: Up to 1 IOMMU entry per DMA channel.
+
   "#dma-cells":
     description: |
       Specifies the number of cells needed to encode an DMA channel.

---
base-commit: 687da68900cd1a46549f7d9430c7d40346cb86a0
change-id: 20260521-edma-iommu-c025e1d28eba

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


