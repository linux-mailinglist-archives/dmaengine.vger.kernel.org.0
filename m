Return-Path: <dmaengine+bounces-7241-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF900C682A5
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 09:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1D884E2159
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425183093AB;
	Tue, 18 Nov 2025 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jeFkDo5F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB4308F36;
	Tue, 18 Nov 2025 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453714; cv=fail; b=edOjo1V5msx+doahs6vb2M64At/wq4i1rnH+6f8WIwiQVM6Z2UucueyZOO1tRZMim3ogt9Czrhy7olMyFJKkvglD9tVrlZQ0ADOqcqI0pbm83u6dHuYBLhmjENZuI4Y9lB9rjJb6sJXIp2Fdb5s8vXq5dQiGiCIwTns0t4wKjfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453714; c=relaxed/simple;
	bh=ISkfNhP9byIxGxLK6tMCGzFbTC/hKojEBuBfyv76JB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dIWGMIuiEwpdfSj/372n2Eq3Lws4u5P1BvtLb4i8QIFf6L8hiFpoMOBJ9KzrDfrwtL01C8yv6N513oVCBw/8h3XvoDe7LGHNfVRMqxRqggC9WB1EPwLTKukUnR+FYOm8ITIEuV7KvR8T6+5rdAcSte15muXx27egTXEOsLiYfog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jeFkDo5F; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI848sJ3209347;
	Tue, 18 Nov 2025 09:14:44 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4af3y587bk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 09:14:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGvzSlerl7ow8Y09pmU+2TkA+8m6XUvWdUdoQPhtLX7/ypUy4kVxWtLuUw8uvCUYAbVDTZLPYEZtztlQb6+2D7aKykbExVNbhBfblcDhOs5Ehjvy2Gy/e3W/8ZVNZSJh293OaqqEI7+wN5KK02HREjzD0e4LXJ74yQ3FbxkUEWxTBDQxFwvZAp1i1Fr9XKKaI0lRnLzl9J8MEGfx9QrhRaAuofSp17GciqZh2H4D9BrWTMql0LYTTEaNDLfLkXlFCyay6xatHt+GnNXqNdDX5POXH47+edvu6ub/rcgNwdBJI0BhV6QmkwTGjoRhhrUSpVGGvgGnTBBxC/jvwQp9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0HSEbDbg2DWrMWFo/rb8jMpVMfCLomLXvr+TBC3784=;
 b=TeMm87i938KhAOfLD8nIxmdD8L+ofRuP9Pc+FHn3hLj/LzhUD7MNUXdiQ8F94iniL/h47vWa8Tyes4XZYARQNTexcb8dlZMv9G7ac0qqbbiUxZa133psQ/30ORZ4qiMcHexetNGOXy3PA3+nq36zjaZ0fqrksjbJfwguyNMnW54XjUmJcMcTfjKMXsycoTMm7+c5+h9tYNALkqvwquFT2XwekA4Hz+SGf3OyG2CU96oZKaI7BsqqNmfzbHPcTeW66It4mOIf/1OTSe1DggEjvAKYICIIn9YenBQAiBTUTWHAXO8rU8cdzGPUocmBEJVbjVlbhMl4ygMfp/MlPFG7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0HSEbDbg2DWrMWFo/rb8jMpVMfCLomLXvr+TBC3784=;
 b=jeFkDo5F2d6upbPctgaDHZXGYwX2q3+HyRmGW0+Bkc47r5emsxUAvLDuPzmxmUc26hIXtOcyIoczxKkg1UEL/D+u9jYNNQkLV8dXBPySETVechkJE82lO0PbomKiJ/cotJJvCy+foKj9L73ydoWADA4XV+F5p+i5fcI4GWnB6aLhLoFBzLXiVRTYcNFt1w0HxoyLY8Jy3qjPxKJeYjUDBeT0aS60JgA+r7DwrCzO5pnfON6ryOTwrIWjwKDK0tqs+m/EiDFLtW6NPC2kzmJsRmSkFpcgWYbxsEGIaGn3Y/LoO122Ea1FJZO78dpbwMnXJdHdrAT1TXR+22RgOrVjWA==
Received: from AM6P195CA0085.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::26)
 by AM8PR10MB4036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Tue, 18 Nov
 2025 08:14:39 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:209:86:cafe::3f) by AM6P195CA0085.outlook.office365.com
 (2603:10a6:209:86::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Tue,
 18 Nov 2025 08:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 08:14:39 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 09:15:03 +0100
Received: from [10.48.86.127] (10.48.86.127) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 09:14:38 +0100
Message-ID: <edf69d41-1997-47fb-998d-014af3074713@foss.st.com>
Date: Tue, 18 Nov 2025 09:14:38 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] dmaengine: stm32: dmamux: clean up route allocation
 error labels
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>,
        Viresh Kumar
	<vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Dave Jiang
	<dave.jiang@intel.com>, Vladimir Zapolskiy <vz@mleia.com>,
        Piotr Wojtaszczyk
	<piotr.wojtaszczyk@timesys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Peter Ujfalusi
	<peter.ujfalusi@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-13-johan@kernel.org>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20251117161258.10679-13-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|AM8PR10MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: ec806575-2a55-4f6a-3361-08de267a8534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3RYbUM4N2ltUktxZHVuMDZyaGFSb3NOanQwdkJZK2xyaERhMisySU1sVjRj?=
 =?utf-8?B?UkhEeFVzb0V4MHhjSmVReGxQMmQ0c0gzUXhBOHhhOVNzaWZvK3FQVGdWdGRs?=
 =?utf-8?B?WHNKOHk5ak14cm9VSzdySjhBRGp6cnBoVzRXZWhOWkFtZ2dVUXROVGRUa1h2?=
 =?utf-8?B?K1JyZ0dEYmJRckhtaXV1S2xGTWVLREpQVkZpcEdIRnlKcWkvV0Y3alhYUVFZ?=
 =?utf-8?B?UnRpREZPVSswakZFOTMzSDhMVmc0RGMxZHl0MXR3VzlWc241QXNuVjdFTjFz?=
 =?utf-8?B?VHdDMWw0WWw5aVQ0L0gwRXU4YTlrZE50SEVmRFlENU9QOC85Z2Jvb3VwbVl5?=
 =?utf-8?B?dTFwWGV2NHlSS2lnRkF2QWI5UU0zbk8rbGtrZEJEbVBtTFJVZkpxTzZlVi96?=
 =?utf-8?B?emxkN3R4WWpacEI1RFZiM2o4a1FHdnU3UzIxNTY2SWlORk1vWGpMSGF1OTZ0?=
 =?utf-8?B?YVB6b2VwaExmbWkwU1JQcXJkTWVYL2NuSjNjRUhzQzhuWlBUMVQrbGZmQngx?=
 =?utf-8?B?cHZESGR1VjRUZno1VHVKdDhCY1ZyNms4T05Jd0FLK3k5Y0ZIS1NUdk5LV0RT?=
 =?utf-8?B?NXdKVmZmM2JTYlozTkc5dVEveUV2c3FpTlMzRlh0MWhvR3JJS05NY1FTcWFj?=
 =?utf-8?B?WEdXcmJJcWpYWWhwVHdweEIxajFXQkpMbWd0bUhYRG1Tdmo3KzQxejdIVkpa?=
 =?utf-8?B?RkZ6c2tMdktJaHpNM0hEUGlCM0ZPY3JkYTRwVkFiOS8zUk9JZmIyYzlrQ3RI?=
 =?utf-8?B?RWdKNDN3aVRBTEF4MXNxR21WWUdRczRmRGxEbDVtWkgvdHB2RlZQSzZjSzNq?=
 =?utf-8?B?ZUVsUkNCNkdPdjgrZko4SndNcmVtV3RTanpjSG9FcHJHNlozZkgwVTFFYm5q?=
 =?utf-8?B?Ukgvd0h6Y0s2YWlGcGxWVEZtQWgvekFuTUx1Y0dmVmJ5Um1ZWUlCb0VoTUlU?=
 =?utf-8?B?L1RuOG1aT2tyTnBCZ1JOdjlpOS9VRHJBdUk2azZubTZYZVc0WnRmcjlQLzAr?=
 =?utf-8?B?QWxoOUFrL04zNEtKMW9FUnNBanQ4VnZjK1VBaCtOWHN2K09rWDFrNlE3L2tw?=
 =?utf-8?B?QXRKVHlhK2RveEZkdll2eVBmY0VBWm5Gdk11WnJERTJRR2ZEN1Zubk5uVFd5?=
 =?utf-8?B?VlM2VStjUW9Mb0k1NCtjUTJyQTM0MUVrRTdNNTR0bitQTUdsa1U5SDM1YWJm?=
 =?utf-8?B?bnoyVkI3bi9vM3RKU2txaStlb3d2Q0JkdVl3ZlZGZW1VSXFvTFpwOTNzc3NB?=
 =?utf-8?B?WFVhM3NlaEc2cU9wUC9mbnpWQ05laWJDaVhhRkJPQnoyZ0pFdVh5Q0daR3RO?=
 =?utf-8?B?VE51aXVoWWlPdTRRemZKaGZTdDgyMENDZHpETWpETXNvWE93WldhZmJicTAv?=
 =?utf-8?B?R3pmcEVPNWhjSkVmK1d2RjRxRDBocEUyYmFDUmhLaEF4N0JhVlJJQ2oweFpI?=
 =?utf-8?B?UkJzVFd6eTFrUUlLM3pUc1dDaHpJeGxRbFF6V045UVkrNWtyc0Y2VDhVZXZl?=
 =?utf-8?B?Z3ZNNVp6LzJ5b1pmblRnRGs1MFVZb21ZRUhaSCs1V3RveWY3WHcwaGd3ZW9z?=
 =?utf-8?B?VnN2SGIxTmRVbzQ3blE1ZXpINTZlWENEMzFpcU1KTmhqQ1FoUHZUQmF4M00z?=
 =?utf-8?B?K3R1QXZPZGFKN3BibTF4cFFveEx0cFRTelhELzZISUFHdFprOTE5NjFHYXBD?=
 =?utf-8?B?cm1TdTk5d1k3WWxWRUtPakhLTmpRWWpXdWdkMmpqeWJQaXZXR0J5blREZm9K?=
 =?utf-8?B?cTJoQzB5NzFoVFdxM0RsbkhZWDhldjVVakdkcUNpVTA1eGFXMCtScXEvU1Jo?=
 =?utf-8?B?TDllUlczWlZvdEJ5dnZ3aDJRWldaelZlcXNkV2NpMjUxQjFOZWF3TzdBdmVm?=
 =?utf-8?B?dUpvR0pickl4YjV2UzBMV1FmYkRHbUhscEZGdFJRbk1hQkd6QThsa1BVdW5G?=
 =?utf-8?B?QmNnSkJvOE5XKzFUakVka2xqaUw5cXdKQ09rN3JIeGVmQk55dFpOdjFUSlRl?=
 =?utf-8?B?M0N0Rms2Q2YycHA5RHdmeW1qK0JZaDFOLy9INjR1dG8zSEtiNGUzSXdHMzF2?=
 =?utf-8?B?emlWbnZkbmw1ZjRsZFBxYVVlcUNaWjNBVm9td1puaVVna1B1NkwrM0xVZm9o?=
 =?utf-8?Q?nHZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 08:14:39.4963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec806575-2a55-4f6a-3361-08de267a8534
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4036
X-Authority-Analysis: v=2.4 cv=cYzfb3DM c=1 sm=1 tr=0 ts=691c2af3 cx=c_pps
 a=gAYfV89Uuw/G0ej/I9H2mw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=8S5RfTLhQsfG7c-RZ7AA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: SgyA7fbPSuhRMJ4zyAJMFRpZOV2RjOME
X-Proofpoint-ORIG-GUID: SgyA7fbPSuhRMJ4zyAJMFRpZOV2RjOME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2NCBTYWx0ZWRfX+l3y8lGKm7DV
 kfgtE1masglIFxeNGGbyRstk9vAz+lpYfD/HofsJxr7J6gy3WmxQo+f7wVx+Wdday0Jotkp3mOn
 hIfdnedf/jSetiSP8Tad1R7EQtOl3HNBJNAPP1n4MJOJ6epz5mDrDDXHEndiRiY13AmpRjTHGxQ
 I/xDLEBG2TCJGPoKQaiOINepKNiuMIFFCA32H6MrL0RmD4isRQ2cH/UHNFHBJ/LgmjDZ2Uv+Lln
 m4jaiCy5Ce7kUp1RkBcuoClbzWiW4Z42jTDyALQDJBQi4sPTNbLqf0YRMrX4OVc0S57u9cwXsnl
 xhYGx7VXG/7SzG2vW2WLuBR+inzkyAYsXoKAI0GHGEhwCYNNUcrdUNZ5wlm0plmeEak1NQnKPtx
 DjxAiYZnPyiLYdTCHpIiMgaEnnL1IQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180064



On 11/17/25 17:12, Johan Hovold wrote:
> Error labels should be named after what they do (and not after wherefrom
> they are jumped to).
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

> ---
>   drivers/dma/stm32/stm32-dmamux.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
> index 2bd218dbabbb..db13498b9c9f 100644
> --- a/drivers/dma/stm32/stm32-dmamux.c
> +++ b/drivers/dma/stm32/stm32-dmamux.c
> @@ -118,7 +118,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>   		spin_unlock_irqrestore(&dmamux->lock, flags);
>   		dev_err(&pdev->dev, "Run out of free DMA requests\n");
>   		ret = -ENOMEM;
> -		goto error_chan_id;
> +		goto err_free_mux;
>   	}
>   	set_bit(mux->chan_id, dmamux->dma_inuse);
>   	spin_unlock_irqrestore(&dmamux->lock, flags);
> @@ -135,7 +135,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>   	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", i - 1);
>   	if (!dma_spec->np) {
>   		dev_err(&pdev->dev, "can't get dma master\n");
> -		goto error;
> +		goto err_clear_inuse;
>   	}
>   
>   	/* Set dma request */
> @@ -167,10 +167,9 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>   
>   err_put_dma_spec_np:
>   	of_node_put(dma_spec->np);
> -error:
> +err_clear_inuse:
>   	clear_bit(mux->chan_id, dmamux->dma_inuse);
> -
> -error_chan_id:
> +err_free_mux:
>   	kfree(mux);
>   err_put_pdev:
>   	put_device(&pdev->dev);


