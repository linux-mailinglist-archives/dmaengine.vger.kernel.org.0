Return-Path: <dmaengine+bounces-7743-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F940CC6945
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 09:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D53130B84A0
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 08:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F0D33859B;
	Wed, 17 Dec 2025 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OyPKJfB9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F52765D3;
	Wed, 17 Dec 2025 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765959343; cv=fail; b=LyWR9ECzbYIyKAUN99iE7odP0h96SFT5Jwv4ch3ejTrmYlCeMs48JBRkA4a/uj3AwgICEomzXHl5Mz1U3R4x0xFEVZOX/o3BHEh5yuNiW3S08BVP68gksnau9Ijr/h7adbwDdEnevOb0uhuQ395/hO4eitcRQDhjpWT0gmiDdjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765959343; c=relaxed/simple;
	bh=ApwYuVCGUPsqzZwvv4zjLI9hlGSKdbdh2Hu0XSgyLAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JxSD4ljs036owfQZuCFctRpkYWfMpeTp0hXICL5gO5d2BFpoNgDTFvnOVG3XR3wu1yzbEyh6yZeMPY9bfcaHVl2BL3UaYVhIXM3v4ooHmwUzpIz/3filVy55dP49X5vnBW2J4YcoJQpGnWphVCMpKdWfS2SfNzFfkTYjNKkNUy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OyPKJfB9; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH81j973372479;
	Wed, 17 Dec 2025 09:15:13 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3gavhhp0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 09:15:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfcNi12fKdyY9IvyqYxOdfyhTfN8CSgaZAGHHQ2t+ozac0pw1nwfIk5FZHfY+8AynvOWtcys0PX65HmuPfXeKpYom83nebCmsAIwFMbDuZpUiiMDGN48igIU7b8qFRiiDFWmz87JKdqboHTCXZCQsMsJgPXXw0dbxPkI6oKE1bWUE29MJ3l9emT66WpmK81eY7JWH00SLj+pFHvj2DdKec5LPricLgiLChtsqNTLGmGQjgkG8sx4xcHcFgIcMLiCO5yy04ueuh0m4tSZflGe3kotPTVazNmu2Jh2N4fHDA32l2IakOhMTUdbryIlPIhq4JFObyvXh3uwImDauhR9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONFSxHUn/1MUYTo5eBGZG/S7pcHqaQG08q0b14keHvQ=;
 b=Pj2/Qog7GHJLGuauEg/g32dCQTKJmharwr1q5I1Scgnoyxdv2hoDRLaYAX8QyW201U29Oo/t7dYYKKw4KHfhfiZjEt7idno631NWnoBOb5TJi9yuyvF+Uvfl8LkwzuNRJMxcqrbMjvz4XNr7gt09U3KDGaIpM7glTQiFOWGtVrkPsbiW3jOgFMgg49ZlvlIp0Q37HS3+TY+jpQEjAKDhQy4hO0iGLr1MMTzHlAB7ibAR2Yd6Tv95V9diugUzdrzEp9TCFXLGV5dx5gNDJAyK7PjxoTiLMGrx7CPSMJ2lUEmeLG4ATtzPIBt6e9fOJ7q2WNQzcSzlv0PB1Nh5j1/BcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONFSxHUn/1MUYTo5eBGZG/S7pcHqaQG08q0b14keHvQ=;
 b=OyPKJfB9dtezP8ahMrh27lH/RJo4g/bz8XAd2sivye4wISkVX0UhmkBbiRuNaJTW05RzdJuUpbkypIql+iqyNGrHIc/qKvHrIZ9aZv4jKsnynsA9UHhCIkRHJg7Nex0nQFecSQHUKqHaNjetGPXGtDNxKyEvkBNoKzizFArnnCo86EgRkv3CN9POKFzXipB23cOxbct1MW0MuVKCJP/BFr/Bj5CfcQED4okv3ggPWW+T1UjuFUxbsrnmlTnFoI6U0oADsdrUtYty163wo7oDbrkpldcRSyVDGjvfSBS+4RoO2hw3Eorn+eGKgAsg/bwolSD0pJl5Dz6YnsVp8SLmeQ==
Received: from AM8P251CA0022.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::27)
 by DB9PR10MB5619.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 08:15:09 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:20b:21b:cafe::99) by AM8P251CA0022.outlook.office365.com
 (2603:10a6:20b:21b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 08:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Wed, 17 Dec 2025 08:15:08 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 09:15:50 +0100
Received: from localhost (10.252.24.91) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 09:15:05 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Wed, 17 Dec 2025 09:15:03 +0100
Subject: [PATCH v2] dmaengine: stm32-mdma: initialize m2m_hw_period and ccr
 to fix warnings
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251217-mdma_warnings_fix-v2-1-340200e0bb55@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAIZmQmkC/32NSw6CMBRFt0Le2JK2gBVH7sMQgv3AG7Q1fQQ1p
 Hu3sgCH5yT33B3IJrQE12qHZDckjKGAPFWglynMlqEpDJLLTvCGM2/8NL6mFDDMNDp8M+PaR2N
 EyztroOyeyRZ9NO9D4QVpjelzXGziZ//VNsEE6y/KnZVWnerbm4tENa21jh6GnPMXGjHgirQAA
 AA=
X-Change-ID: 20251030-mdma_warnings_fix-df4b3d1405ed
To: Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>,
        "Amelie
 Delaunay" <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|DB9PR10MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e0d3d5-fab6-4823-a21f-08de3d446454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDBGWkZnMEFKZmgzSkpiVW4zSmJWdUxaN2FQaTVjVFI4T1pINUxPamtvdGJq?=
 =?utf-8?B?SXRRYmVPRkFmZFUreklvUkFvNFgyV2FYZUxtM2M3c0hTWmtzYmV3c0tIVmFG?=
 =?utf-8?B?ZkU1b2h1ek1BeFJRemhEWjNBeHFhVDdLTXNFVW1hTXZsNDVNL2RrOStwT21r?=
 =?utf-8?B?ajAzMmhPL1pJSE5reVNWWVN0MEw4QkVVQU9YNCthUFdweXdYVWRsa3ExNkFH?=
 =?utf-8?B?THhpcVhsNk1EWVRmZFFZZWgwcmI5R2xVRmlnN2x3UXVvd2dwSi9Bc3pnZk5i?=
 =?utf-8?B?QWZrZTZRTDdVMmFHampMUHdpYWQvdm5HWUdaZHdPY2FmR092WTRQdk5BcDRx?=
 =?utf-8?B?eUZCMnBmR1REbGhmb2xMcWRaUzYrenI2VnlEY0VreVNmVkVxQm5aRGRKdWN4?=
 =?utf-8?B?OWxwWHNZcHhZdkJEc2c0YzczS3pKdUgzL2k1NkNObXV1NmxPclJudHY1b3J2?=
 =?utf-8?B?cC83SDVzUDFFS3pWNzZZWHlUaTRaemdvRFJDN0FEK3pRSFJWWWRzK1ZjUndS?=
 =?utf-8?B?WENyRmxJZHdOeTZjQ3E3cC9YeXA1RitOMlhNZXF4ZU1ENnlqZjBFKzZqVkZh?=
 =?utf-8?B?U21Ucit1U2JmRjduVEczT2Z3ZWVLRmxxWEZtSURKWVNsSEFVS1pzYkNSMDRx?=
 =?utf-8?B?K0hKVDV1WFR3OHIwcTJYN3Izeng4Tnk0Wm9OZlJmZVBuZzFWZ2w3Q25RV0RI?=
 =?utf-8?B?UUt0TWRMRW9tVWl2R3FzZVFra2gvWFVwWndEcVpEUzZMNE9aVVlxNldrSUtQ?=
 =?utf-8?B?WU5DRENiLzRNODhkYlBrWUVLdmlBRHVlQmdrMG1nT2EzYjFWWitXS0JmNHdP?=
 =?utf-8?B?Um8xVVY3Wmt3b1dQWGVPdTNlOU13ME1yZk0rTGNOY2NCWjZyeEJCVzFNeU1z?=
 =?utf-8?B?dFMyVlVUSUptbE1KcVFEZUo3dnAwb3J2aUZHWGtNM2orZlFuOFk4anliOTdH?=
 =?utf-8?B?Z3cyMS9Kcit6WVZ4Z3JjazRWQjJ3UmVYL3FjRG4wYlFnZ0d3VmpIVWFjNGFx?=
 =?utf-8?B?OU5YT2JkakN6VmR6aDRPNlNhVFlEV1RiY0NBVmhsSFBqN1hBMkwvRFRoL285?=
 =?utf-8?B?dTlQNkJkanFUMzM2UHFYWWFaY29iZnFtNEVES1NXYmU1eWhNTHcyRDhBZ0V0?=
 =?utf-8?B?a2htMkhnSkRFbWs4VGxoejBXU0tnM3ZXclBHTnV1U0lmUFd6UjJvRGVRVmk3?=
 =?utf-8?B?OTRLMmJQRUxTQnRsSm4vQ0lCU2NaWVh5VG5XM1FTZVFyQnpGaG91dUlyb2ls?=
 =?utf-8?B?UkgzTzF4bzVQc3hTcjNvZ3VNRW1lb1ZOSUI5NE10OTVvdkd2b3RWbkVTbVVx?=
 =?utf-8?B?N1Bkc2UvTFZFN1RiM2M5RkVjdURIZVIrTE83MFVWdkUyRXlxTGcvVC9QazU3?=
 =?utf-8?B?UjJmU1dQVFVnTzdURFBjTkplUUlvQmRTK0lrOTFHYUZNS041dzVRb0d1UFBT?=
 =?utf-8?B?alFtemZtM0c4L0xjSnVCbjc2Ny9DK0NNWVhtL29ITllTRnZtcTNaTGtDczVx?=
 =?utf-8?B?YmdwSFFWeDhDYmpGRytuaStFY3NzL2ROU2FTVEZwbHk4YUdVUGxta0JFZFNH?=
 =?utf-8?B?dWtTOHphVldBRzdmZGhHK1hDNnA4SlJGWXRUUWVJNUNzUWV1bzRVd3hWY2lR?=
 =?utf-8?B?Y25Nb05PS1FNcWdES2lEaVNRWll5V1psUWs5eUJ5MVpNdGZ6UWFrTkxJeXp1?=
 =?utf-8?B?dG15QVd3eGR2cTJUWlE4MUo2ajB2VDU4NXdsMzdhUzJTN1JrWlowMzhlMFI4?=
 =?utf-8?B?SjZhdUJQb0I2SUNrZXVacXZDcDN4SW1oV1RYUXF6b3hoRzFubUgrc2dkWnc2?=
 =?utf-8?B?UWxnUlJhbm8way9qUkpNM1o1UjZZK3dOd1NtdU15cktEbWQzSmdNb0YyRzlM?=
 =?utf-8?B?cWRTODFwbzgyVU92M0x5aThHa1NqVEI1NEtBZm11cklIczRnaEhSZEd6NHEy?=
 =?utf-8?B?VHJQTStkcDRzbGZoOFVRME9NekNjVXRaY08zNS9McHpNQjdNK0NnZkRVSXNJ?=
 =?utf-8?B?dk92Y0YycHVDZlovN2gyWkZadGRRTktGL2ZFelM5dFNYYnY0bXpBM010TGxr?=
 =?utf-8?B?enREcDB1c3lrV2MvN1czOFJBVGh0azNqcVB3OG5kU1V4U2U2YkZ2OUtKWXp0?=
 =?utf-8?Q?LovKnKKkcZllA7N294VRjWyt/?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 08:15:08.2667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e0d3d5-fab6-4823-a21f-08de3d446454
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5619
X-Authority-Analysis: v=2.4 cv=Ba3VE7t2 c=1 sm=1 tr=0 ts=69426691 cx=c_pps
 a=uk+jbS6DAws4lyiH9MsXVQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=_yuozHrGAV4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=pGLkceISAAAA:8
 a=9Nr3kCKZwl6MpmKL_EIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: IJzHiMM7OH54OIUUalHOaxBkZxzs10JO
X-Proofpoint-GUID: IJzHiMM7OH54OIUUalHOaxBkZxzs10JO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA2NCBTYWx0ZWRfX2mlLPKyrG5xr
 TtO1sudzXAjIoPqdBYXumaNkC9Y+LMrk9vu9O5MN6PISrC93+JfCEtCb49IiAJ+1C3ru3mz5oDc
 ODq96Ausk1zahMQQNWMC1NH8OvHU/9bzMP2WIhawbmXSKqLqTt8DWTuvFWDoaatALxJ1AqozR/1
 RNfLqKm+nEymPG+LeFAILDA8qr5reI9s7mb1rGqv5524HWvu3Lpr/mcuT8bvXYJWyFHrQOIQBev
 4nZ97mYeIUwQPeCL7/H6xWqxRHAujwY3HGdjUiZqUhgUS9SEiBu2BfrzNQWM+5jRxIWYHxWKAtK
 YWiM3NxmzRoJcCvEnvei/Nc9VwBVFcSX/wu3C3rQ02ZyYqioPrk2DjX7S2/d6J0dR2xBKhQyoRA
 JiyeRHk/SCzM/tGrnkjIcb6+wiTdIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170064

From: Clément Le Goffic <clement.legoffic@foss.st.com>

m2m_hw_period is initialized only when chan_config->m2m_hw is true. This
triggers a warning:
‘m2m_hw_period’ may be used uninitialized [-Wmaybe-uninitialized]
Although m2m_hw_period is only used when chan_config->m2m_hw is true and
ignored otherwise, initialize it unconditionally to 0.

ccr is initialized by stm32_mdma_set_xfer_param() when the sg list is not
empty. This triggers a warning:
‘ccr’ may be used uninitialized [-Wmaybe-uninitialized]
Indeed, it could be used uninitialized if the sg list is empty. Initialize
it to 0.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Reviewed-by: Clément Le Goffic <legoffic.clement@gmail.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v2:
- Added code-review trailer
- Rebased on top of v6.19-rc1 
- Link to v1: https://lore.kernel.org/r/20251030-mdma_warnings_fix-v1-1-987f67c75794@foss.st.com
---
 drivers/dma/stm32/stm32-mdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
index 080c1c725216..b87d41b234df 100644
--- a/drivers/dma/stm32/stm32-mdma.c
+++ b/drivers/dma/stm32/stm32-mdma.c
@@ -731,7 +731,7 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
 	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
 	struct scatterlist *sg;
 	dma_addr_t src_addr, dst_addr;
-	u32 m2m_hw_period, ccr, ctcr, ctbr;
+	u32 m2m_hw_period = 0, ccr = 0, ctcr, ctbr;
 	int i, ret = 0;
 
 	if (chan_config->m2m_hw)

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251030-mdma_warnings_fix-df4b3d1405ed

Best regards,
-- 
Amelie Delaunay <amelie.delaunay@foss.st.com>


