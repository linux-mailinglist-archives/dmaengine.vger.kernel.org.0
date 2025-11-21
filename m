Return-Path: <dmaengine+bounces-7283-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA26C78FEE
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 13:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 32C9B2451F
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255D2C3770;
	Fri, 21 Nov 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JPAQY/nL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73450296BA2;
	Fri, 21 Nov 2025 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763727429; cv=fail; b=Ec27thrtEscF96BQpGP66A0ezNQGZ23AaAu+PlU1ibWqTCH/hYlrjVJh7u6LHINwD9dIt+gpkQY0YgBjORRjdZoS1T9jMYOYCuFcgpOLOp3JjergV2CskNwq9A+UVShYmpntfFDg+48/wGp7wEWXaLDTsR1k3ZESkXCp+Ma0CJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763727429; c=relaxed/simple;
	bh=s3Xm7bJSWMOxsZDFPFZL4bHDPiFB+dEQjvpqBxj1WQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kQYmFuBE/WziJzt1x+zVLzBCcnQatGg2khLYsf0dEPWPDXuRD8EL2GxeK3cMNWu+DOlhfLCtqO+CqgPajPWjeF3tE54rCnlmn6jxK2TP4uWO3D+bTI7OhBlqm2GcufZrH4CK+rBdCUPdrTFayva4e4ZEpVaVmrADKfx6oBl0xNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JPAQY/nL; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALC6E6B3288091;
	Fri, 21 Nov 2025 13:16:37 +0100
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4ajnmt8nax-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 13:16:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRxarjtROX1wvHqGeAJZaiXCh5Y7/BtkgK6OXF8/6ez32xNJCUtvj5HFALehEkJ94u/8f72O+rU7f9Ah4TN81MgPP1nXUNQ+CeEbbWvs5un+7KPTD1+bkjoAtblOo8+cAKmbwt2duEB3yEHFL0BcIdtmniixHFdNfMSHvPu3iTNNXAdFbBg6jBGgtVIkHReWSXa6RSXnRylIIP37ruZzKpqzIbuQPxgfdoY3ZWGRMTqENwH7fofrMKmFY1khf1Vxz7DvWJCIoK+7ldLHufuWuwqi8sfYGU5icGOcaGRCj8YKcBcE90euBjKlJNDIiNSdnZAiri4C7R1sGgvGLo07yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVrThsM9UOAKfi/vbBZnoIbTzRZ9SUMTxeLyIXIfc9k=;
 b=s1WueV6CUw7V1riM0s6My56Ql7qFfG0eqjSR+TflcXppZ0xKZAjHnW8+TkxofD+EIdH8LcTtWwAdbinkG+gMeWrYkOzq8qjir5ch3StKlbTTQvC3iNtXRjoDaPY5XzBjJG7zVhAZU1F1gC0YwF9xaBr9Uk2seAOPseX7ES2jv28g75WAq5f1GGu2aSlfIwmPGo+LOe8Bv4qS77gHqY7eR8HM11OcUcyl0Oztik9BPk0WtqxUApm4nev/5OrP940FaCgZCYx4Qlz2n/hCe6PCzuZ0X/FdgkYkl8S6LHVDC6PXuSoNMflV00jJFAbGZJy3EMv+Mal7/TMBdhPl9PG7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=linaro.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVrThsM9UOAKfi/vbBZnoIbTzRZ9SUMTxeLyIXIfc9k=;
 b=JPAQY/nLskWd6BwjBoxidBJLXnn1FAxrshri+9fUYzX93OqGznQRfRa3vDjtJekygsCMiJX0ZIizUFvEm8jyy/TmI2J8rZpxiWJs0NzRMxxhuZtYP2nANjaVa0r5LTVURahqE81Vh7DJTJTF8lW2FRoCO9lEtZsBAsPqnFxecqjncST+z0MNmAw6SNcDYrs4P9NUZUVBUa1WEADJoi3uXBgrQZbc43WmDO4fGlAlt4Nw1Lts8UfL+gKa47++lQZBshxz11bB+yvl3vMXBqlA/aKV2pNPkahCSLiKD+Kjl5ggfhC+h+IF2Uh0+Xa//1PGhAJMc2XxVZsiW4DKgUuang==
Received: from DB9PR06CA0009.eurprd06.prod.outlook.com (2603:10a6:10:1db::14)
 by DB4PR10MB6991.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 12:16:28 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::3) by DB9PR06CA0009.outlook.office365.com
 (2603:10a6:10:1db::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 12:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 12:16:28 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 13:16:53 +0100
Received: from [10.48.86.127] (10.48.86.127) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 13:16:27 +0100
Message-ID: <871f07f3-5d0a-43c4-863b-ad4d804e1e38@foss.st.com>
Date: Fri, 21 Nov 2025 13:16:27 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dmaengine: stm32-dma3: introduce ddata2dev helper
To: Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20251103-dma3_improv-v1-0-57f048bf2877@foss.st.com>
 <20251103-dma3_improv-v1-4-57f048bf2877@foss.st.com>
 <85f08f72-7608-4076-a474-579eb4c7dc4c@linaro.org>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <85f08f72-7608-4076-a474-579eb4c7dc4c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008860:EE_|DB4PR10MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e34232-5897-4637-f310-08de28f7cc57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M29nYkppczY5L2NMaFE1djZjZldUck5zMHhsLys1L1lEVEFFNE14NU5XRmh3?=
 =?utf-8?B?TlZDTm45bklsZFFST1c1NUxIbS8rY3hDRHY3NVdkSm1DRyttMmhkMm5YNVlH?=
 =?utf-8?B?Vlk5NGNCZHlaV1JDRUIxdGFLM3pHa1hsSlM3ZTBFK3VROWpVTEF0OU45TTMw?=
 =?utf-8?B?R2QxSGpXRjljZHQ1b1ZNMk1BSjlCcjhPN1QvWFV6dVlXTGMvV2lzZHJ1NEhY?=
 =?utf-8?B?RzVUVWdoU3pkQjEzKzM1QWxGV243cUxZUm5heXBFRzJLOFJTZUplaGNMb0c3?=
 =?utf-8?B?M1k5RVdnNXB2QWdiYUo2YlAzbWM1SGxRNURKZlIrSlZJZ1lKanJJOFNuVzB4?=
 =?utf-8?B?REwweU5YMmZFdWd3U3hvTUdtNHNOOEF0L3lxYkdNb1R6aXRkVTFqdFFCMzNr?=
 =?utf-8?B?WCtkYWpoWmFKTGN5K3R5d3NnaktVdHRTSUhsWTJVTTFjVWtaR0x2UDMveEFj?=
 =?utf-8?B?Sm5CQU94ck4rZVB3cmxnaTBkaUxEVnlTcWdmMW9LSVhXVXBKYXpCZTlNa1RB?=
 =?utf-8?B?SUR1QVYyaWt4MjlMb21WZUFLc2RlVFVsbUd5Rm5BbDlBcWNFdnpPZnUvUElr?=
 =?utf-8?B?U1djRWFqUWNmZzdCZERlUGRZNVQ1NXlXTWpNcWJYMzFUOFZkS3p1aHdCL2FM?=
 =?utf-8?B?WWJVVWd4YkJEZ1diOUZGVzgrTWRFUnJ2MmNVckNFTWc2TG1sLzBFaEJIU0RN?=
 =?utf-8?B?RGJ3WndsVUtxdW1SbmhUWVF0RWNoYjRKSlYwUHhPTWZUakZzK0k4ZnNHL2dw?=
 =?utf-8?B?RWlSMFBUenN3QkE5NVIyWXBKWjdNUGE5dlNXNWVBM20rMmhGa1RzcXozT1Ex?=
 =?utf-8?B?d1pEYk5pOWpZbXpZL1lJVy9HNVliQ0VXRUFwZGZYdEtvT0JvOUFkZ2F2aGxT?=
 =?utf-8?B?TG5nNEZQUWo5SnpubVpKdEhEcEtPT3k1N1kzMGpCemNUMnpyeS9XeGlaMXNm?=
 =?utf-8?B?RkRUbVhRM2lXK3REVnRZRkVRcTlJMzJWZm0xa0JKbmRyQlBvWUNXVG5ma0pU?=
 =?utf-8?B?bmRhSENiSGFwdXMvajFlNUg2Z3BNY28rcVo0K0JVQTFXTS9RT1N6WC9iMkMr?=
 =?utf-8?B?YnRHd2VaSW1mVkg4NHI2Qk9RdWEvOWw3SGlLV0w2MmxXU0MrTVRhamlsU2tQ?=
 =?utf-8?B?L29WUytMS0ZxRndSV2h3Mkt6aEUwNWZEOUNVbnVZZ1ltTTBONUVxVTZrazZm?=
 =?utf-8?B?aStHVUpyRVpESTNIWTRRV05uNFFreFAyM0tlenlhcTByemdYRXVUMmo3TW82?=
 =?utf-8?B?dEs4MnZVUFpCNmIxbnV5MVlBbUtTc2NPeEdMWi91bkRrV3RXWjNOemQ2YXRz?=
 =?utf-8?B?UWtrUTF1WlZlMWRiYnZJRSt4OHYzSVczd0pEam41dkxGTURrR2U3KzJKVzN6?=
 =?utf-8?B?VWRqQmZhbUh5WWgySE5QK2NsR0EzTHlZU09Pa1ljUERJNUFBejB1L3gyTlEz?=
 =?utf-8?B?MHFXMTRxSjhqaVVOd3JBN3dkcXY3aGN5YytFWlF2cDVHYVZkb0YzczJRYytN?=
 =?utf-8?B?NTBEYjhnbUFOdmczWE91TlFBTW1rdDJXSUkrOWZueSt1NC9mbU8yVVJ4dWRG?=
 =?utf-8?B?UXlsc2RqNlRWdnJubWl4SjRTb3UrSjJKa0NGdlBJMzRXNU5rUG0vK203bXNy?=
 =?utf-8?B?aVVoSU8vQnNuWXZHejl6RnRNRnY3c3NxUzAxTno2ekhhd2NkVEwxMGlwRCtI?=
 =?utf-8?B?NThDYjkrcFoxYkFUR1V6YlFBcjNWa3drbG40WWY0WVMxZ28vRVFXTzdUOVR0?=
 =?utf-8?B?NGQ1WlBhY0hvNS9TOHJxZUFYL1VrVEZvb0tFbUYwOUNyeWJjTGg5QityUjlt?=
 =?utf-8?B?MlhRZnZTcmV0YUpVWGVaL3BRRnpVVHJULzdud3R1NnlJU1FiTE50b0N2bkNq?=
 =?utf-8?B?N1lCOE53NFZCRmpObmpMV1N6U1RBakNBNDRBbUxQWC9YaGRzeENmaFFSSWc2?=
 =?utf-8?B?NXZKYllUMWM3MG1OYjVnaVViSWVNSU1DNWxsSDlpK1J1TXR3MEw2YVV0bGhn?=
 =?utf-8?B?SGFPV2NXOXJndlBieXVkK2VtL1FSbHhPampZQW9sMG9xeHBpblJJUmFOMWFo?=
 =?utf-8?B?NW1uUlRFRExSQW9HUlFSdStXYTcvSGdqTUUzQkhNNnA4S3lEV2tKNFhJTzVT?=
 =?utf-8?Q?tEjY=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 12:16:28.2400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e34232-5897-4637-f310-08de28f7cc57
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6991
X-Authority-Analysis: v=2.4 cv=fYKgCkQF c=1 sm=1 tr=0 ts=69205825 cx=c_pps
 a=OO0GoY2mO76woEg6W8CiTg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=RjcZ-PNYxbEjufFQTR4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: 0JKom53V4fmRmFA1VfPifmEllF2zLf8x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA5MiBTYWx0ZWRfX+/buOgwwk7I0
 RGW0UfXv/NAMc2rJVJDjabC2tk/5WMWNWbWc/s9a4v5GmaWh6h0KrTU8qedEukZENEkI6YBSNrW
 w/CZSAEL6bTrrncfiqcoHHV7dXyJ1rukKle35R4Fq7KhBDbMiY9x2NG21muR+aTR7eF6Pig0ky2
 NucZuh6uSIhKTXqk70R+zC26VaE7YGUBbs0ragJs2lskF5exLjBx13tQDoKYcrfDXYe6eNtUvCf
 apWZDC+jeeFDzzzD9CGsgmDoE9V0cJqgksOw/0iU+VKdFgwZAEclgf3ayxwv7G/Ojk3DwRUiBLi
 1WOE/QIuf8bWYIEHOSl+jbfdrQMyHjt6XHU+yTq0dPX7HuAqOkQAdQtocgwoVcThcqnpdiC7u6e
 m+cw9gBECDo/GBeKtt+/ifXfQAdzdQ==
X-Proofpoint-ORIG-GUID: 0JKom53V4fmRmFA1VfPifmEllF2zLf8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210092



On 11/21/25 10:25, Eugen Hristev wrote:
> 
> 
> On 11/3/25 12:15, Amelie Delaunay wrote:
>> ddata2dev helper returns the device pointer from struct dma_device stored
>> in stm32_dma3_ddata structure.
>> Device pointer from struct dma_device has been initialized with &pdev->dev,
>> so the ddata2dev helper returns &pdev->dev.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>>   drivers/dma/stm32/stm32-dma3.c | 29 ++++++++++++++++++-----------
>>   1 file changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
>> index 29ea510fa539..9f49ef8e2972 100644
>> --- a/drivers/dma/stm32/stm32-dma3.c
>> +++ b/drivers/dma/stm32/stm32-dma3.c
>> @@ -333,6 +333,11 @@ static struct device *chan2dev(struct stm32_dma3_chan *chan)
>>   	return &chan->vchan.chan.dev->device;
>>   }
>>   
>> +static struct device *ddata2dev(struct stm32_dma3_ddata *ddata)
>> +{
>> +	return ddata->dma_dev.dev;
>> +}
> 
> Not really sure how much this helper actually simplifies the code. To me
> it appears as if there is no improvement, but this is a personal
> preference.> +

Hi Eugen, thanks for your review.

Saving two characters cannot be considered an improvement, but the 
purpose of this helper is to 'standardize' device pointer retrieval, 
similar to the chan2dev() helper above.

>>   static void stm32_dma3_chan_dump_reg(struct stm32_dma3_chan *chan)
>>   {
>>   	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
>> @@ -392,6 +397,7 @@ static void stm32_dma3_chan_dump_hwdesc(struct stm32_dma3_chan *chan,
>>   	} else {
>>   		dev_dbg(chan2dev(chan), "X\n");
>>   	}
>> +
> This newline here appears to be unintended >  }

Indeed! I'll fix it in v2 Thanks for catching that.

Regards,
Amelie

>>   
>>   static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_chan *chan, u32 count)
>> @@ -1110,7 +1116,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
>>   	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
>>   	int ret;
>>   
>> -	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
>> +	ret = pm_runtime_resume_and_get(ddata2dev(ddata));
>>   	if (ret < 0)
>>   		return ret;
>>   
>> @@ -1144,7 +1150,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
>>   	chan->lli_pool = NULL;
>>   
>>   err_put_sync:
>> -	pm_runtime_put_sync(ddata->dma_dev.dev);
>> +	pm_runtime_put_sync(ddata2dev(ddata));
>>   
>>   	return ret;
>>   }
>> @@ -1170,7 +1176,7 @@ static void stm32_dma3_free_chan_resources(struct dma_chan *c)
>>   	if (chan->semaphore_mode)
>>   		stm32_dma3_put_chan_sem(chan);
>>   
>> -	pm_runtime_put_sync(ddata->dma_dev.dev);
>> +	pm_runtime_put_sync(ddata2dev(ddata));
>>   
>>   	/* Reset configuration */
>>   	memset(&chan->dt_config, 0, sizeof(chan->dt_config));
>> @@ -1610,11 +1616,11 @@ static bool stm32_dma3_filter_fn(struct dma_chan *c, void *fn_param)
>>   		if (!(mask & BIT(chan->id)))
>>   			return false;
>>   
>> -	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
>> +	ret = pm_runtime_resume_and_get(ddata2dev(ddata));
>>   	if (ret < 0)
>>   		return false;
>>   	semcr = readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(chan->id));
>> -	pm_runtime_put_sync(ddata->dma_dev.dev);
>> +	pm_runtime_put_sync(ddata2dev(ddata));
>>   
>>   	/* Check if chan is free */
>>   	if (semcr & CSEMCR_SEM_MUTEX)
>> @@ -1636,7 +1642,7 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
>>   	struct dma_chan *c;
>>   
>>   	if (dma_spec->args_count < 3) {
>> -		dev_err(ddata->dma_dev.dev, "Invalid args count\n");
>> +		dev_err(ddata2dev(ddata), "Invalid args count\n");
>>   		return NULL;
>>   	}
>>   
>> @@ -1645,14 +1651,14 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
>>   	conf.tr_conf = dma_spec->args[2];
>>   
>>   	if (conf.req_line >= ddata->dma_requests) {
>> -		dev_err(ddata->dma_dev.dev, "Invalid request line\n");
>> +		dev_err(ddata2dev(ddata), "Invalid request line\n");
>>   		return NULL;
>>   	}
>>   
>>   	/* Request dma channel among the generic dma controller list */
>>   	c = dma_request_channel(mask, stm32_dma3_filter_fn, &conf);
>>   	if (!c) {
>> -		dev_err(ddata->dma_dev.dev, "No suitable channel found\n");
>> +		dev_err(ddata2dev(ddata), "No suitable channel found\n");
>>   		return NULL;
>>   	}
>>   
>> @@ -1665,6 +1671,7 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
>>   
>>   static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
>>   {
>> +	struct device *dev = ddata2dev(ddata);
>>   	u32 chan_reserved, mask = 0, i, ccidcfgr, invalid_cid = 0;
>>   
>>   	/* Reserve Secure channels */
>> @@ -1676,7 +1683,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
>>   	 * In case CID filtering is not configured, dma-channel-mask property can be used to
>>   	 * specify available DMA channels to the kernel.
>>   	 */
>> -	of_property_read_u32(ddata->dma_dev.dev->of_node, "dma-channel-mask", &mask);
>> +	of_property_read_u32(dev->of_node, "dma-channel-mask", &mask);
>>   
>>   	/* Reserve !CID-filtered not in dma-channel-mask, static CID != CID1, CID1 not allowed */
>>   	for (i = 0; i < ddata->dma_channels; i++) {
>> @@ -1696,7 +1703,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
>>   				ddata->chans[i].semaphore_mode = true;
>>   			}
>>   		}
>> -		dev_dbg(ddata->dma_dev.dev, "chan%d: %s mode, %s\n", i,
>> +		dev_dbg(dev, "chan%d: %s mode, %s\n", i,
>>   			!(ccidcfgr & CCIDCFGR_CFEN) ? "!CID-filtered" :
>>   			ddata->chans[i].semaphore_mode ? "Semaphore" : "Static CID",
>>   			(chan_reserved & BIT(i)) ? "denied" :
>> @@ -1704,7 +1711,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
>>   	}
>>   
>>   	if (invalid_cid)
>> -		dev_warn(ddata->dma_dev.dev, "chan%*pbl have invalid CID configuration\n",
>> +		dev_warn(dev, "chan%*pbl have invalid CID configuration\n",
>>   			 ddata->dma_channels, &invalid_cid);
>>   
>>   	return chan_reserved;
>>
> 


