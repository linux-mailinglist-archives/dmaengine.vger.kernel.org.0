Return-Path: <dmaengine+bounces-8548-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOBaFOfjeWl60wEAu9opvQ
	(envelope-from <dmaengine+bounces-8548-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 11:24:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFE39F67C
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 11:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBD013003D1D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151C2E1F11;
	Wed, 28 Jan 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dMXeqtsd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8232E03F1;
	Wed, 28 Jan 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595875; cv=fail; b=Yb4L1ZGzR0eRva8thJDk1FDVEV6ragQfmCeAiLic/cAefwfXNNzuJliMiOJDEkP7bqKvfGmSVyUDD1EAwStZI1czlXoCB9Gj2PsQSP9SmIoFdAUHPMS4TGkJMWf0V98f9QbH2yku/jDqbkCmyWSWdKm8TNA+zRNOF8pLqyufJ0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595875; c=relaxed/simple;
	bh=hIHN440oI4+uYfZrlu5HZ3xlaIIwSpcYqP53CjCQ2oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YLb8nN6IgVw51WjNMybttUSWYifclTSRFcNoFbYY7OCYA/2LZuM7mJb89fCVnO4DHsBG6wI7CdLQVI3kZywoYkJqvgfP7Rm2/LHtgjacvmI1EfIzkb8qKTd7VGiojjysafHLRXEC9e9tvOl/NTA9corakoIAh19rbF83mCoHySU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dMXeqtsd; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SAHss42019677;
	Wed, 28 Jan 2026 11:24:04 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011005.outbound.protection.outlook.com [40.107.130.5])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4by8crsv3q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 11:24:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za/M2KtGsqAcnmsW9wyK0L1JA6pUeSA1sjBoDLVpVHucf5GN+YvbO1LrUbRtXXS7p0/y/8mlBOURTcfQPPTnnwiKVuqnSIeINc3sElGofZDtEaaE+UASeHbTcUdoHvG43OpowK9puDtOxKlHONvz00y2XCK84TYJMD2puHfaEGmZYJfTWEZ+mxrf1QhRSiTLz3qE5nglqCL8ReP/9StSuX3g82ZWBnddqHVmYgEHM7sjE5xSz95nPjLGfFTQKKu7qs20SwvbZTW9/EaMx5TOnWFJ/reP5c+sJO7Sg2SNnlTtinlUk9pBGnzToxbrrav63d1gqnR5iOTHMr1ckoECXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKvVVeSFgB1nPAQxmq4BvQwmbbblf9twNK8iyW4NYRw=;
 b=orxQmj/5Zz8e6BeTn/23NcIM71vc4DZ8ovJISLKpqK3av+mCZHMHybgNVqTNrCq7caMvjeZsEMP3j3jOQXtnpOaZs1KZw7vrWIuRNTd7iIuUlys2+bQMGaTFJZ3dgVFtAYURMO6XOqxG9OlOnX9rGDgNvfb3xRO2Mizhs8nCZgPgiSreqmsRLWCAYEiknYdq4mcFeQGs9PB99sfoSEdK+UkWoO3luMpipdbMmPdpHLLZLMZSdnhuJhNyoWVcmF6GHvXrEKwtmwjz3wsxJY6/JX3fdqCWwMcX1CqvVyoI4ss44P/0cC/r5bjgYiA/I+5WaA1yj9FBst/vZwRYS1+c0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=iscas.ac.cn smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKvVVeSFgB1nPAQxmq4BvQwmbbblf9twNK8iyW4NYRw=;
 b=dMXeqtsdNkYB79Nnddglk1++ehtrmzpZdbQM1BAT+eEBbrkf3qkHpUwgd5+aIzkWu1CC1/9XWSy/ukx5twJrDeHsER+qTHfJ4azZ7QIYta/DqCbFNp5GLn69zYNBIU+ymrc92+8rwksLtBGRWkFAgxruI/bmWREKXlvt0x7xjWWIF4k8A1sku7kMVk56s9UHiZCGD/kZJsBoRkivMI1IPTyvgUcG2UAieyiZBHIGkUTII86S4PR5WtgGaLHLekv2PnAIVkuAgggLsptCft/K8MeAaU9WVM0aiVNewe97TN4n4ZR7xdhduHzgqmdzqzfsdS12vfNwFhg0GXEJxEgbMQ==
Received: from AS4P189CA0035.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::14)
 by DB3PR10MB6788.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:438::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 10:24:02 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::54) by AS4P189CA0035.outlook.office365.com
 (2603:10a6:20b:5dd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 10:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 10:24:01 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 28 Jan
 2026 11:25:34 +0100
Received: from [10.252.0.73] (10.252.0.73) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 28 Jan
 2026 11:23:58 +0100
Message-ID: <09f432c0-fc94-4a9c-8548-4bec85fc8ea2@foss.st.com>
Date: Wed, 28 Jan 2026 11:23:57 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: stm32-mdma: Add missing check for
 device_property_read_u32_array
To: Chen Ni <nichen@iscas.ac.cn>, <vkoul@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260128042321.2260321-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20260128042321.2260321-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DD:EE_|DB3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: b9753890-a495-439b-ba7c-08de5e575ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDhKcm5vUG52aFVaNzhzalBwMFJKanhFYnhTMVpTT0tmNFdtSHptdnNzOUdV?=
 =?utf-8?B?aGswTE95S0dCMC9UK0o2K2tSVzZNOFFLS0syckxwdWR1cktMdFBnbVZlZzNn?=
 =?utf-8?B?L2VLOXhPRmlzNEVZcGVtZDRNZmVPYms2dHMwT2ptRnVpTU1IS3lIMU1UbHFi?=
 =?utf-8?B?cUpoNFhmdTBUVE5BV1Z0eVV3bzdHR21yZ2NGc1dYNjFLZUUxZU9jL1p1dUR5?=
 =?utf-8?B?SU9UWFZXSG16TkZ1c1d4T3pqeTM0VUhOcmt0SHI3U0dmOXhWa1RJekFhTDJ0?=
 =?utf-8?B?MFU5RlR6MlkvYzBqZ0c4RkhQNTQveHZyWXdZenU3V1hzSzVvR1JVbW9ZSzNa?=
 =?utf-8?B?UVpyYXZxY3pKM0xRZ1BIZXlrazVRRzFSNjZmdDE2cGxRclNFZGIrOHVyNTNG?=
 =?utf-8?B?d2pISm9IRmV5MEtQL2lyL3dyd2pBdm95N1hudG53bytqUDZxTEpROWFmMWdQ?=
 =?utf-8?B?RnZScU13NUF4TXBOeTY1UnZMbEl4eSs1YldPYTRRUERkMUJTV0FkQ1BLRTFS?=
 =?utf-8?B?alo0TFJEWlZtblB6RVJoeEJhRjlZNVlNUW9MMjBwdTlMMGUzci9rZGliaFE4?=
 =?utf-8?B?MXN0L3Q5dHlhUTc4WGxyeFpjQ24zZkV0VGxvSUVWeDVIenhkTCtWQis2NGZ2?=
 =?utf-8?B?OHBGdWVSWkNyLy9Hd1d0Mk5IekRmR0pvT3F4TjVXdUZYYzJMZGpBU1U3eWJE?=
 =?utf-8?B?Wkp1bi9yZGhjcDJkaUp2MnNYdE5WamkyM3pobVlFOEtDQ0k0ajgvZWZ5VmE2?=
 =?utf-8?B?Q09xa1RLRmlIWExyUjJ0UjBtZmlsZTFCbWpCaW5LSFNkTElDaU9raGdjUGw5?=
 =?utf-8?B?MTBMNTE2TlRYVzBtRVZ2RG9pRFRyR1VhdzlYOGhOZDNZc0s2aTFlUVZZQUFj?=
 =?utf-8?B?ak5Da205YWx6M3ZzTkNmVzZCU0lFMUg5V21XOTJhUTFYamxMZVpETlBWRlda?=
 =?utf-8?B?U2YxMVBiS1VjYzZoWDRZbjFXUWlkUllXVC9OV2UyS2JXODVGenlWdmhramtu?=
 =?utf-8?B?RGVlc3VFVVJra24wU3FFUFlKVXFqODBDVUxxMU1hYnkrSGk1NVBrT1MwbENw?=
 =?utf-8?B?c3lyQmk5N0E1VXg0eTBCNVdVZzlUQURFUUpHOEcxUEZtSHA5dzNPRHRXQU9D?=
 =?utf-8?B?cHF5cCtVcXpEWk9QVzZ5U1YveUorRmlLM1R6SkxyUUExckFtQ3BndHhPSEVi?=
 =?utf-8?B?SVY0bDlhVm9zeXJ0eEwxclJheUIvQ1lqSXBKNTBrdWVLK0VRZTBQWi9zY0sr?=
 =?utf-8?B?dXlrU005ZXRWdDQzcmlRN0pZYSt3czBtd3VPMm54ZFptNG82WXFoSzNCOTVD?=
 =?utf-8?B?RXRtKzREanJGT3oyK3hnUmQ0bnR0R0p6YlhudTd6WXBMOEhLQ3d1Wit1d0x6?=
 =?utf-8?B?MXNNdzdKSDl6c2htS3lEbTRVdzlFMGpRS1N2LzgxYmVzM3R4dFFaZ3gvUEdX?=
 =?utf-8?B?R3BDNUtaSFUwS0FSVkxHT1k3blRkREZvbjVybmpNMnhpcWJMTGNLcWVaTEtM?=
 =?utf-8?B?TzdkYnlTNGpCMG1EaHdzQjNhSHZYTVlQNnh1eEViQ3NFMnhMM3Y5ZEt1emkx?=
 =?utf-8?B?bXRKdnpzTVM2VTBzMkM3VmxhWmJuN3l5UTRTNUd0M1hMeFhvajFudFVMMmg2?=
 =?utf-8?B?a053bE1HVXJva280dFZLS2syQWNhSklpaVZXWHJpditYR21nRUo5a2xaZVhM?=
 =?utf-8?B?VjhEME5EMHc3QStFTFVGS0FYdmMrZ1RHd1Q2Q3hlYWo3SXNqNTI4bTJPaHRZ?=
 =?utf-8?B?QWRJQjQ5TS9CclJYclF4REtIcTU0bzhCQTRsVE9RbFc0Mzc4OVZXZ3VIYjF0?=
 =?utf-8?B?ZVZ6bjhnQVlVaGNUaER2ME1nWVd6azlOWUVKVGR4ZGk4alhKa3FSSkFqS1dS?=
 =?utf-8?B?L3Y0NDlzZ2t5NFowalBqa0ZpZFk3STdDMS9maHpSSmh2aS9sRURjMjNPRGNG?=
 =?utf-8?B?SkRzQ0VqZ0RsWjJQU2src0pXUnlQM2tpSStWaXpzVFdsb0dtdUNrTUZFbGtZ?=
 =?utf-8?B?bXFqSUdNdUtxOTVzeEJUWXEweUJFS214YmRMWFBoTmVlT3FZZjRNNkhCMkh3?=
 =?utf-8?B?NG9yR2tqSU0zYzZpM254RlNVeUlCNklHMzJ5NHZHODBKTkdDQVdISFpTTkMr?=
 =?utf-8?B?dDZCV0tEUHdrem9EamdVQzJxTXJVQkxxS0lxdWpJNytmekp3MGIxOVhPQ3Fa?=
 =?utf-8?B?NjJHRjRXaXpOSnVpekRRU0plYjJGZnlEcGViWXlyS003T1JzMktXZUMwaEl4?=
 =?utf-8?B?bWh1blMxQXhJUVpqZUMrcCttak5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:24:01.2624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9753890-a495-439b-ba7c-08de5e575ae6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6788
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA4NCBTYWx0ZWRfX6RAcQXsSdrzR
 9s8jc5TcuQHTVpLadBXitKKH0jOeqNu6lZApleY7K8txPhtPYXDDAlMP2gEk57PoXH5P8uT52pr
 TIcGtn8zUwAi06bGIYhfPcQWpY6YDx/ZWXarG69jdL2JafZmqEAZ6FfohXxa8rj9yYR1QdslOsy
 qMjEymzdPyOyZTWekD87yw87cxyfJ6K//M+hEUi5HwjQkJSHwUciQRWr/ioVeVKk7HIl7RjNqTL
 29HrV4YilAUM5h7eSCvUEWNHJRxfMnBzelY7ehpTrrf0KW3FfAumyjBcXgaftFbtiCvJFhNYcwk
 /lM+CHRJdLF9zk2h5VbGP9tHAIQCrMrkUnMVF/S4W+lMqov2xStmL10V1BRZYSxMFp4JvH4iKdj
 KcLeStFmeztJyhM9EDw8kHIiLX6nD2g83IIGsEj0y6M4H9tnMic6jIc7jmc0TyYziex+s3xbfFD
 egCPy+3g8/dFh5BFD0A==
X-Proofpoint-ORIG-GUID: 9LVDE62ErkzDOM602fPyCmQQa5CC_zGb
X-Proofpoint-GUID: 9LVDE62ErkzDOM602fPyCmQQa5CC_zGb
X-Authority-Analysis: v=2.4 cv=K84v3iWI c=1 sm=1 tr=0 ts=6979e3c4 cx=c_pps
 a=nIPM16a0Nuaph4AHzLZmgg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=9VQrtOUWDvwA:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9vhlW_lVbprXuTGuAQ4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8548-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foss.st.com:mid,foss.st.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:email];
	FREEMAIL_TO(0.00)[iscas.ac.cn,kernel.org,gmail.com,foss.st.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amelie.delaunay@foss.st.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CFFE39F67C
X-Rspamd-Action: no action



On 1/28/26 05:23, Chen Ni wrote:
> Add check for the return value of device_property_read_u32_array() and
> return the error if it fails in order to catch the error.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/dma/stm32/stm32-mdma.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
> index b87d41b234df..f833724cf42c 100644
> --- a/drivers/dma/stm32/stm32-mdma.c
> +++ b/drivers/dma/stm32/stm32-mdma.c
> @@ -1630,9 +1630,11 @@ static int stm32_mdma_probe(struct platform_device *pdev)
>   
>   	dmadev->nr_channels = nr_channels;
>   	dmadev->nr_requests = nr_requests;
> -	device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
> -				       dmadev->ahb_addr_masks,
> -				       count);
> +	ret = device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
> +					     dmadev->ahb_addr_masks,
> +					     count);
> +	if (ret)
> +		return ret;

Your patch breaks MDMA on STM32MP1x platforms because 
"st,ahb-addr-masks" is an optional property. That is why the return 
value of device_property_read_u32_array() is intentionally ignored.

Count is used to check the presence of the property and to allocate 
dmadev->ahb_addr_masks accordingly:
	count = device_property_count_u32(&pdev->dev, "st,ahb-addr-masks");
	if (count < 0)
		count = 0;
	[...]
	dmadev->nr_ahb_addr_masks = count;

If the property is not present, dmadev->nr_ahb_addr_masks is set to 0, 
and MDMA behaves correctly.

With your patch, when the property is missing, the MDMA probe fails 
because device_property_read_u32_array() returns -EINVAL. This is 
incorrect since "st,ahb-addr-masks" is an optional property, not a 
required one.

Regards,
Amelie

>   
>   	dmadev->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(dmadev->base))


