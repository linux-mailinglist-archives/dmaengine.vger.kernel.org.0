Return-Path: <dmaengine+bounces-7048-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716CFC2AF7B
	for <lists+dmaengine@lfdr.de>; Mon, 03 Nov 2025 11:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6DA3B3765
	for <lists+dmaengine@lfdr.de>; Mon,  3 Nov 2025 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A82FB085;
	Mon,  3 Nov 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Zo5YQwsO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6A2F692D;
	Mon,  3 Nov 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164950; cv=fail; b=OcFwZq38Kmt2riCK5phXJlU4IYVAd0PtzyR4q6as02ZWljBIFYSMhDkO+ywTRU7x7o4XZXie216UZjrmnMQPdXK0yOANRwXT/p58X5VseBPiD4TbAiMMlgMJyyhepFL2Cah9/wP+djbtgv1RZGm3P2KppWbNnjdHM0BTGfbIHzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164950; c=relaxed/simple;
	bh=A8BoHxz1cPhYuRLXfisKGsyrnbV5NWaWbOTf2NOHEi8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=qBv7RweAN5zGMAfyON9PQl52r9y474hwFV4qkws+xx0yizsaL2/AKbXM0+v7Akzmnp2+lHAm33eP1SyJZ6b516Pvkv/Ml0k7C+97Jc2v28n5cWLtL6mz677i89X3t9Io0pHL/Mf1k/eOHMaWjJ92w5MrSLT/vEDb9hBgGuv63vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Zo5YQwsO; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3A8PRA2953680;
	Mon, 3 Nov 2025 11:15:23 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a59yh74yk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:15:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCAC38pvonoQYSZW0E7PsratvjvR6wtVbshq9fXiraVv7dRaMd7FdowCATF7QDo/NMun8XxQRwt/0qUkAjn/yXqPRqfP+iOAAHQ+saDi4Z4qP5m5FR+GBwwkzLlYGtbhHFCxECXYAz0ILVTv/mNRBlNhxtq9BaoxeZcoJ7vR9nLuDeZi0E3qsO/XjrM5OLuTElN3coL/PCkXP0K41lCQUSW3pjNJy8riHPAMbPbm+A7aNdvGJ0WasPA4mj+hzyBrlQRjny1ShVwYIbV3ZHqHY8m5OIYR201CwLwv6iQrSs9MPLgCvJVTAyb5PpbuNutP1shNpeKoH5nhNk0+7RyUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3f8RNSTUqTyy9d5J3kkGM6JQNHMAMJcEm9iCkyZ8EM=;
 b=y0j2TaefpQGdC15XX+4N9rJfJLIYIF70ap2FbkjDFAZ0xrPsWt8szMj8/kqBRiOHNbRkuJ4rnfK3lWYpsEpECEGzbrJXUfnMcbMpxoZzG6lpqM5wLUpVsFjvE0+ZURp5QffT4vVvIFE3AWx+ELQh4GQtF8lOAvLIxQ1ZIqhyKczdEL4zaWKl6ajePJsp+BsqcXxK3o/dB2ZNltLjqzWsMTYTe94DWX+GY9n2QcP4hiYQ3605mJZwbACEcd62VlxsfHKLGHphDQSFt6FWS+vQEaUMiR/rs9w14LZbGeCypniJAaExKtiky3wgW30wx0GxGodWhMB8weZq29ABFroUPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3f8RNSTUqTyy9d5J3kkGM6JQNHMAMJcEm9iCkyZ8EM=;
 b=Zo5YQwsOyycLSa8dan1NExEKlLrp1AsQ6hpV5TTlGohFH6zluYMnpFRZ2/WMRwUH2m2DEvJk/4joj2MU60tvVp3dDm11YlULgMSA7M5g+4Xju65aUSdQHxzRntPyJ7k3CepNjm2+EHmGdEiODcRPV61I0EtTdW/1RF5QyyaaJE6zh3j7nYt6bQ7IpL7Gzrkuw4S0baESjy3cirJKdiADl7jd6W7Au6+g8ldwwQ9nvAZQoRGbvyxhbgtsZzjG7b/oi2fCBz4qYuiDCYqOVHgMO49FFMWyy0T+5pmHyr6aAc4boNFTExcZxrf4TuF2baE01qwh9/Ncvyj9jKTi5avL6Q==
Received: from DU7P251CA0012.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::18)
 by DB8PR10MB3765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Mon, 3 Nov
 2025 10:15:20 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::d6) by DU7P251CA0012.outlook.office365.com
 (2603:10a6:10:551::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 10:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 10:15:19 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 11:15:24 +0100
Received: from localhost (10.48.86.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 3 Nov
 2025 11:15:18 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 0/4] dmaengine: stm32-dma3: improvements and helper
 functions
Date: Mon, 3 Nov 2025 11:15:09 +0100
Message-ID: <20251103-dma3_improv-v1-0-57f048bf2877@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK2ACGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNj3ZTcROP4zNyCovwy3SSTJGOz1FQjY8NUEyWgjoKi1LTMCrBp0bG
 1tQA8GUU2XQAAAA==
X-Change-ID: 20251103-dma3_improv-b4b36ee231e4
To: Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|DB8PR10MB3765:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c36eaf-0207-462c-dac2-08de1ac1e433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEdjYjB3SUtVQXZsU3FlVnRIT3N3SWlYdTR1VnVJRGQ1L3g2RlJLeDJoVXpU?=
 =?utf-8?B?MnpuODZtM3JXNkx0a2xMWk8rUTNRQUs3ZkNydWtvS3c4elErUHdockEvRXVY?=
 =?utf-8?B?am1lMDNxb1ZNVEtGdTdhY05xVGZQS0Y0VmE5MHUzQzYvRUxmOEE5NUlzNlVu?=
 =?utf-8?B?Z3g0enI2b1pJUUkxODkvMjF3L0psMW5iR0FkU1NMRG05a2RDaThHZmgxZWFQ?=
 =?utf-8?B?eXQ0QXBucDlKOTlqbmV4T1ZERnRhTWpHRW9yRlllUFowbWZyZVhjckM0UUNz?=
 =?utf-8?B?N2hEck1IajllZk5PWE4xSnB2OVRWVmp3RWEvQzNaNnM0emZFbUQrSno3RnVt?=
 =?utf-8?B?c1A4Tk1rMCtLUGkvVVUyWUlVMElNd3lCQUdzVzkwOURzQWZUdzd5MTZ4K0JQ?=
 =?utf-8?B?c1gzeS91d2NTTGVSbzNoa3NscFBzU1Q1ZnVIY0Q5Z050dUVwZHhEYVRvbUxZ?=
 =?utf-8?B?dkJHcVFOakRwdUFrQXhpYXoxNHFKdksxekVWSC9lOWNhYkVEZUhvSy85a0Z2?=
 =?utf-8?B?WC9jbWFDM2x5VXVsVVI4Y0V3SXZLd291ZHZjeklHWnBQbDI5OVhxQzdWUzhB?=
 =?utf-8?B?b0tNWFIzSGY5K3NGVTRMcUkvbWFSNXJzL3l2Vm9PN093cUV0aWRQTjIwOFVM?=
 =?utf-8?B?R1hsajdyQjJUNU5OQmY0Mm1LRmgrbTBtaUZqak1ud1V0RGZBZHpxN05EQ1NI?=
 =?utf-8?B?b3MreHV5anJPd2x2YW1VYnZLRlpBWlBDMW8yc3drWGFrUlg5VXhTNW5vS2Mw?=
 =?utf-8?B?bXN1MG9YQnEyQkpIckFVRm5uVFlWbGRBZ0JFV1h4dUN4SS9KVG5oNmJyV2Zl?=
 =?utf-8?B?ZUJtMUxCSWc1Vko3c09mNVg2UjNra0kyT0EvbnNwRCtaS1JVUjRLZkN3VU1o?=
 =?utf-8?B?ZDdIWTJNOC93aUR0RXB0TzdUR2tOUEFQTVJhU0UxZWc0OVZlVHRPeUtMdHYy?=
 =?utf-8?B?SXZVTHhhQ0pRSHRGZEZSdFhUTDFLZXNLQTNxTU8zcERWL01Wb05HZVNuV0kv?=
 =?utf-8?B?OTVRRVg5akxMV0lqRllySm9sai9SSXQyMVh0NUo0c0JiWitQdGUxYVJNQjQ0?=
 =?utf-8?B?dkZsK2pDdWg5WFJURUVhT3BpRTErNjJJUGt3ZHhnM3NWTHlta3VMUXNoSGRm?=
 =?utf-8?B?VFJjTXU0L0hCeGErellqUHJWaGpOUzF0RWpUQU9jbnpQYVNBbGtIMVNVRkl6?=
 =?utf-8?B?MFhuN0VVRFhZU0dnOVpQa3BybkRBalQyZFYrTFBSd1FxQlJLcjlOOTUvNUJz?=
 =?utf-8?B?MEM2RFhUOGptYUwxTVZlQmpVZVRxTVo5d3lVamZRN3AvNkFpK2tkQ2hHNkRq?=
 =?utf-8?B?bXl2M3lxZkpjdzdDSkpOSVlycW8zRmlmci9MVE4zbk84NGNSd2dKeEVWTUdS?=
 =?utf-8?B?TDE0TUtZcEZhVDVKNkppMUgxcGRWUW5mdWs5VmowZS9Kakl3VkhRMjFsdnlZ?=
 =?utf-8?B?RXFXc1VJY3BWcitUSTFMY0g4RE02SWV3Y2x5SytraE52QzlZbUc4SVBrVjFq?=
 =?utf-8?B?Rm9qamsvY3llMjhlYnRoZDhnUWd1SDhDUVBCbC9QUHMyV3E5VEtJOHgvNWll?=
 =?utf-8?B?bFNQbU5YNlRVQmZZV2UzSTVqNTN1WWgzRVdXQWpSaWg1YldBTVVjR0Z2L2Nh?=
 =?utf-8?B?V2FtN25pckRITk9yNXl1K29PUzNvdlB5cUJZSHRmODZNN01ZK3hXdnluZlgy?=
 =?utf-8?B?d3p1ZkMzVVdWMlgxdWJySWs1YUd6cHV2b0sxSmFFWTRlTEt5WGFvUS9iRS9i?=
 =?utf-8?B?WGQ3SDJ5bFZrL25tODJvanV1ZStIMDJ1OGhFNUoyRHhFQThiTmp3S01QR2w4?=
 =?utf-8?B?T3BwQmRKaWJtUk1BODhXQmEwNXV2U3oyVCt4ZGpYbTVuWTk1cDFUS3FnOUNS?=
 =?utf-8?B?YjZiMFhwTUxDK1JFQ092alBkVzFxckFsMkloY2t0VDZiSzE5SFAyckN5enhI?=
 =?utf-8?B?SUFJRkJRdXhjcmVyUEs3Z0txVC9RVVd3S2p2b0o4WVlzRC9Dc0NBZ0psczRG?=
 =?utf-8?B?dXJzdE4xV2wxN2J6SlViNG5oVzNrL1pxL2wyQ2tPZ3laZFZGSFVjNUlEb2Zj?=
 =?utf-8?B?VFluTXdlang1RnRZWDZ0amtJYVlNODRVUVRvSldTNkJ1Wm9jZjlWZ1MxV0U1?=
 =?utf-8?Q?Wzxs=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:15:19.1626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c36eaf-0207-462c-dac2-08de1ac1e433
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3765
X-Authority-Analysis: v=2.4 cv=Uohu9uwB c=1 sm=1 tr=0 ts=690880bb cx=c_pps
 a=WIKKr3Q+Zo2wxA0Am9cKlQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=F7b9RQ0zxoaY1ic3SWwA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 685feIax238ZfAyW2YtwuRp_1rYyWk-Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5NCBTYWx0ZWRfXz8hYuQRL4rRw
 589Y46kYLjkY1hZWyGOc/c7bjfonklqKmpInK0tvBYc2pzdTN3C07JFaBw/MnWLWDG4KPueOhxc
 DvGQbi/yDjxRFdF2LyqYZAspDdyX/xcuvLCb7Rb6ta/doIPUDkm3C4TyXosk0Vv5JUVHj4ST4xy
 NsAN4GuuwS3A2DAJThw7ynvm7/mZ+AYh2ew/tq1OPaRXrJsgCOO08cugSYTzdSM4PYfcS46w7fR
 PBA93NXeIP4RlVjM/rmBt3cnDmEhzNtlWOSbS9FhVICmrZscFAmIl3CV0fwE5obk+c0o0Xet7Q4
 4zKGOW5pNshlEzoFuLgVDSOWtwC+rkN/98QriU22OXCPqHNULh4qdyZte9bQGEG++CBUZkK4tZ9
 dSmI2+XzKWiMeF+42tC/gyMiIKe2LA==
X-Proofpoint-ORIG-GUID: 685feIax238ZfAyW2YtwuRp_1rYyWk-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030094

This series introduces improvements and helper functions for channel
and driver management.

It enables proper unloading of the stm32_dma3 module, replacing the
previous subsys_initcall() mechanism with module_plaform_driver().

It introduces helfer functions to take and release the channel semaphore,
and restores the semaphore state on resume, considering the possible
reset of CxSEMCR register during suspend.

It also adds a helper to retrieve the device pointer from the dma_device
structure contained in stm32_dma3_ddata, simplifying the code.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Amelie Delaunay (4):
      dmaengine: stm32-dma3: use module_platform_driver
      dmaengine: stm32-dma3: introduce channel semaphore helpers
      dmaengine: stm32-dma3: restore channel semaphore status after suspend
      dmaengine: stm32-dma3: introduce ddata2dev helper

 drivers/dma/stm32/stm32-dma3.c | 166 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 137 insertions(+), 29 deletions(-)
---
base-commit: 398035178503bf662281bbffb4bebce1460a4bc5
change-id: 20251103-dma3_improv-b4b36ee231e4

Best regards,
-- 
Amelie Delaunay <amelie.delaunay@foss.st.com>


