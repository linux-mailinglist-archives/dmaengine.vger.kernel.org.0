Return-Path: <dmaengine+bounces-7239-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15354C682B5
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 09:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DDF9352A7F
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC929E0E5;
	Tue, 18 Nov 2025 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MPGfOWaF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EEE3081B5;
	Tue, 18 Nov 2025 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453536; cv=fail; b=nez+hF/sXswemgsOg5C4fEE2VJq0KkuP2qRw45tXy1W+WbRCiptR1ma8UW2CwQyjk34J8Dv6iY8IgolQSYt3q4p7mqUUEmlHVLeS5LllBK1EnvGljuo5WW9oh7rWIR9KD7CThJpmoBbHImDPulHyNk7JFXj7420+2ucraWldm7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453536; c=relaxed/simple;
	bh=A+jeyls11EXuzDwZlLV8jSUZtACfj5qDzZBlFr2o6Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EKRJD3VjjFV8hROLwRTrwZhAJKhJwz66WnBmtfvgZ4O+flFFL89a60I/NTmgdJtjFESTXJ453d1C7TOQnTH078GxXZMgx/2CNy8HJOdPGx5N3+YeSqgtc7N8yhVxc0SvOI3fn3i1Lfn9BE2JGPqLMVWy2BCj6Oh24yfhhsbC180=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MPGfOWaF; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI85ATL3653920;
	Tue, 18 Nov 2025 09:11:35 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aejnmswh1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 09:11:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCLc1xjuRmnPnyX+ZiRKVgANfA0GSdrf1avEeMySbWpxJgPlULf0guqsuV2JCXNobjcjjDia37u6hvr+NqFicsg/CY7qUwKJ95qfb6N8DR4yfYr+6h2hPJCUJ20DypUmpvWUfN2V5L1+CRfZi+BPe1uBQpjNakQlJ81V+IEmv0Xj72OXgAnNF//WcQ3iqR1gqbzYfIFAvptZLqR8gnWiWuv1BPPssAJfSC0mVkLOmIwEko212g47Wbs27gzMPF0XSUpshGJ39y39o+X8sAF/43Omj73LpINFJwKS44GVCUTGkaZK4gqJYuFMrLmSxr3fpO/ci5DeSo5JBZmUfx19Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2DwgavI0Z6dbmZdwXC5R9uvJA8eEA1L12PN0eeGDi4=;
 b=KyncMX+PGoRGvKY7hzz75TLrYPzTAfLAp/VnQg79t1NXb/81EtSJ7xSxdcIH+l7UHT9Ip9VDlGNdVtsdlZUDmoccGe9TNr86PsuetbuusQjjoeCe48rZq9qDTevaV4zbPJvMO+aHbkbQdYNhFOd6VgziNmpNyYIEt77G5Q1H/U4SAAni/ivHz8DBAKZEKWqHm6dLslOmOEedUHbHAWYbJ1hsl65QfboXu7kGmwPdscnNndwhmIvX9lkOV48b6ADrHnT+I9HYj+TtFJD38jxrHwp4nOlT93y6x0on1hNobsNx6dwto4cPZT/W5+sTfOvdVw4lNVsLMZrcHj6S5xQbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2DwgavI0Z6dbmZdwXC5R9uvJA8eEA1L12PN0eeGDi4=;
 b=MPGfOWaF1BfWWVP+YY0UlnuEWEsODPaG4FBbvjWrJ9JkMXP2KWcJFi1d4SKLQlfKMzzvUx0eSUGIisAwF0b7nMy0Cjz4t+lF+uT2tI1t3l1jvTAiIVW8JJ207TU9oBfrqOnpTZFkvsXuQ1aUbLtQBxobANIghN3tO1vhK0eK0yNqBZEZrD5HPiRT1DxeVEuAVNm2JlwRDFNNtSaQjbssGqGly918DKvA7DIsgPhI+AwO/YbBKeZPIytm8V4CRLccxjVgVM5Zss1r2EYQYZtwOTfjR37kwOpyqLD/wN42oRkljNbsXZV2dyLGELEgRFdRn0lNu5/2IWU9/t0mkozJcg==
Received: from CWLP123CA0113.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5f::29)
 by AS8PR10MB6650.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 18 Nov
 2025 08:11:33 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:401:5f:cafe::22) by CWLP123CA0113.outlook.office365.com
 (2603:10a6:401:5f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Tue,
 18 Nov 2025 08:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 08:11:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 09:11:55 +0100
Received: from [10.48.86.127] (10.48.86.127) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 09:11:30 +0100
Message-ID: <ec4001b1-e7b5-4d7d-8665-2b5d5a843c8c@foss.st.com>
Date: Tue, 18 Nov 2025 09:11:30 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] dmaengine: stm32: dmamux: fix device leak on route
 allocation
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
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Pierre-Yves MORDRET
	<pierre-yves.mordret@foss.st.com>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-11-johan@kernel.org>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20251117161258.10679-11-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004A:EE_|AS8PR10MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: ff41f466-febb-498d-9f2a-08de267a1564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXVwVUwvTm80cnNqR250RGNYbE5STlMxVDFVSmxwTGorSDdVR2lqU1huU0hN?=
 =?utf-8?B?S3Vyam05QXk1bHNza3NlVDJyOXd1eXRjbEpoK0FYTG9ldUVRdHhlaElURFRP?=
 =?utf-8?B?Vmtvb0c1alhOSXp4Vk5NQk95QVFuekZGOTJUZnpjbktrZEZJM3NhQmRBYXNC?=
 =?utf-8?B?MURHKzMrd25PSkFYdExrUEpkUEtSM0lnMUZRNjVxcllwY3VqM0Q1UUhsOE14?=
 =?utf-8?B?QkVxUGxxMEJ3bUdLaWRES0dsRkVZS00wVHprbFBYUHRzR0tJNjJJMExEcjNt?=
 =?utf-8?B?ZXN1eFZseDlBZDhwWlAxdElwc2VJVDBNVDkwSVcrbk44cC9oeVdJOWozRDVo?=
 =?utf-8?B?alVacStmZVNZbzEyTVNXK2hmakJRQjFqblNqYUczN1FsYlV6N3FEWUsvU1Vu?=
 =?utf-8?B?V0dzVTVnM20rZk9OeVRwcG1NQXBML1dEQjUrQWRqb0Y5RUN2bmozTXFhRVNq?=
 =?utf-8?B?UGQrcFZOajJkWGVLZzI4NFFCczYyK3Z1S3d6YnVWTHZHMm9UbjNzOVRRMlZs?=
 =?utf-8?B?WDRsYVNoS1hKZnY2MFlnM3FTYWxSeFpGQTBraCtwMlozN2xld1BRZE10bVdX?=
 =?utf-8?B?RUtUK1JoTGFiK3k5M056YXd1SC94M3huREJ6VmxWZ1VGT3NCcC80TDRMTXN5?=
 =?utf-8?B?UFZVOTVrWlhjTXAyU1EyTmtaekhqZkVNLzluTmJlcVdpczhEd2RPTWhzMTlS?=
 =?utf-8?B?WHJuZVRHOHBMbFN0OXlZcUt0OW9CeHBZa0IxY1Y3RGJySlRadFdVT3dIRGJM?=
 =?utf-8?B?VWJpUnArQ1FpamZyNjFrSDJOL0gzdmlBaUZKYzdnRDlDYWtpSXFCRE4xcjVy?=
 =?utf-8?B?Y2gxd1BIWENJb0ZJZ2JCN1RRYWZuVHFadjZ0S3psVmZYOURxU2NZb0VlR0x1?=
 =?utf-8?B?OGZEZ284TmVmRkNyNm1mRWVIQjZVWXdsQzFwbitxSHlzUUNPNHlnQTZWZWh5?=
 =?utf-8?B?bDFPZXc2SjJQelJhQTh5UHF6UTZSVyt2M0dnUFp5TkVYN0gxUGV2bmV5bkNJ?=
 =?utf-8?B?M0ZlS0p6bUxzU0JTR25lN0Nrek1nZkdPVkN1M1JyVmpXam1nelNycmd6Mmsv?=
 =?utf-8?B?UkFtZnlKdXRoQzBPYnJHdmhTWUpvcWFVWTUxd1pwTHJkSDFEWFlJbWkyTWQ0?=
 =?utf-8?B?Qk1pbkFwY1VCa1lwdzBWSklTVnE5dnQzNitLa2hNcUFrMlJOR1lLRnlNS0Zz?=
 =?utf-8?B?TEJYT0VqRlVpbGJwNlhaUlptVWxURlE1S09yRlI0cUtxWkFyM2JMSy8zWnZn?=
 =?utf-8?B?azgvekpTNlpKeWtxaWJtSkdwdGxTWm1sVVVNb2h5QzJZYktRaWYwcGhFWmpM?=
 =?utf-8?B?UzVjVTZHd1daY0NhbGk5WkNKdmp3ZTFaaUpZMWRESmdlSVJncytSREVsNnhW?=
 =?utf-8?B?S3dIUmVFSncralR2OXRXWVZpWWxRZXJNbkNSRUVGQ2NORERHbFl3WVJqZ2Nv?=
 =?utf-8?B?L0pEbUxaV3VCMnkrUFJkeUUvR1lDalNRZHEzeFhSTk5rbkhzTWZWUUx4bUJV?=
 =?utf-8?B?Y25ZM29CYlpLb3dUWjRJWjAxTHEwSGhXRlpSalBDY1FmM1g0d3pwU3pETjdY?=
 =?utf-8?B?em1uVUwvNHoyNnM0TXgzVUliSkErVnJNUFgrc1k2TWlxaWE4SGk0Z3hZay9M?=
 =?utf-8?B?STdMUTQ0QlF2dGJiczBzaWtNN1ppdjVWN25QdFZBR0Jib3Z6dGFOVlBFS0ht?=
 =?utf-8?B?anVCWEpPdXFPaGJwbk02MFVRZDN4TXFuaVVUWmhLdU5TWnNGSEVRa0ZYTHVL?=
 =?utf-8?B?QS9iMnpWTlRrMzRwVjBiQTN5UmNjLzdIU3g2YWtRTzRIV1BjaDJBcFMrcndu?=
 =?utf-8?B?aWJUUlZIMFkxQkhTWHRCdmZzNk9vb2xhM0g5WFVIOE9TcUtYNnJWVmMwSGhG?=
 =?utf-8?B?bk1NWXRKenFnQkVwb0lBWmFIRzdsbERhWnd5SUtjVFlNY2tiNjF3YVVpaFBJ?=
 =?utf-8?B?Rm1LUkhPS2oxT1REQWFvcnNPZ3dma082M1k5cEdSRzR1QmJLVmlpenRYSFB6?=
 =?utf-8?B?YUFadldsZm1sWGtOQTZPU1A4NmRoS21mR0d0ZEliYXA0WFlwU2hueTgzRXFH?=
 =?utf-8?B?TWhNK1B4UE4yY21TYjFXcDF5NXYxeEZjQm5ucjdnbE94V09kaHdsd3RMRHJU?=
 =?utf-8?Q?uZSQ=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 08:11:31.9176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff41f466-febb-498d-9f2a-08de267a1564
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6650
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2MyBTYWx0ZWRfX0+JAwRBeEj2Z
 rKiZP6zlBjrgYGna7d/7q6MpIGL3HT2AwWPNcMJCIXdYdbriTCdKi32OcQrdxiJ1Hl/GKwvJf3F
 P3o2KmH2N2PMHlM7o3vOX4c3u37YIYYv03GZNQuBuf2NzDfLWd2+jVQpHavIJQWl91kiWjnOkgE
 6Yai5P5KOvDtbLOGNH78E0nThqWEAvcL9gCN5qtfz4WKkK/gDzTCy6fA9GAvm9S+EM6qKc+vVSC
 zZO4R7pOascICiiDvHPBtQDj0FGudGrVYRg6kb10PZaz508jFJJuNx3+obFxBKBp8acShocNErG
 sdsXcCAwJSKPW6yVeCeXfNu4d3zZ1Myike3ylAmevXIk3lcFYjrtwQ4RqYYt8SKIrUFadk6dINY
 8QQxzGukRS7AdKGEabxU5AYqpq3CTg==
X-Proofpoint-GUID: gFTxWWHt0vgokRqnuC9aUejb2CIJ0esg
X-Proofpoint-ORIG-GUID: gFTxWWHt0vgokRqnuC9aUejb2CIJ0esg
X-Authority-Analysis: v=2.4 cv=M8JA6iws c=1 sm=1 tr=0 ts=691c2a37 cx=c_pps
 a=6Kf4RVHJovTFG9veQ3L6kA==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=uguMaT5T8Rbt2-LxA2UA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180063



On 11/17/25 17:12, Johan Hovold wrote:
> Make sure to drop the reference taken when looking up the DMA mux
> platform device during route allocation.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
> 
> Fixes: df7e762db5f6 ("dmaengine: Add STM32 DMAMUX driver")
> Cc: stable@vger.kernel.org	# 4.15
> Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

> ---
>   drivers/dma/stm32/stm32-dmamux.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
> index 8d77e2a7939a..791179760782 100644
> --- a/drivers/dma/stm32/stm32-dmamux.c
> +++ b/drivers/dma/stm32/stm32-dmamux.c
> @@ -90,23 +90,25 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>   	struct stm32_dmamux_data *dmamux = platform_get_drvdata(pdev);
>   	struct stm32_dmamux *mux;
>   	u32 i, min, max;
> -	int ret;
> +	int ret = -EINVAL;
>   	unsigned long flags;
>   
>   	if (dma_spec->args_count != 3) {
>   		dev_err(&pdev->dev, "invalid number of dma mux args\n");
> -		return ERR_PTR(-EINVAL);
> +		goto err_put_pdev;
>   	}
>   
>   	if (dma_spec->args[0] > dmamux->dmamux_requests) {
>   		dev_err(&pdev->dev, "invalid mux request number: %d\n",
>   			dma_spec->args[0]);
> -		return ERR_PTR(-EINVAL);
> +		goto err_put_pdev;
>   	}
>   
>   	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> -	if (!mux)
> -		return ERR_PTR(-ENOMEM);
> +	if (!mux) {
> +		ret = -ENOMEM;
> +		goto err_put_pdev;
> +	}
>   
>   	spin_lock_irqsave(&dmamux->lock, flags);
>   	mux->chan_id = find_first_zero_bit(dmamux->dma_inuse,
> @@ -133,7 +135,6 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>   	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", i - 1);
>   	if (!dma_spec->np) {
>   		dev_err(&pdev->dev, "can't get dma master\n");
> -		ret = -EINVAL;
>   		goto error;
>   	}
>   
> @@ -160,6 +161,8 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>   	dev_dbg(&pdev->dev, "Mapping DMAMUX(%u) to DMA%u(%u)\n",
>   		mux->request, mux->master, mux->chan_id);
>   
> +	put_device(&pdev->dev);
> +
>   	return mux;
>   
>   error:
> @@ -167,6 +170,9 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>   
>   error_chan_id:
>   	kfree(mux);
> +err_put_pdev:
> +	put_device(&pdev->dev);
> +
>   	return ERR_PTR(ret);
>   }
>   


