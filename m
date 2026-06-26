Return-Path: <dmaengine+bounces-11813-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wXdjAEFXPmqOEAkAu9opvQ
	(envelope-from <dmaengine+bounces-11813-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 12:41:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B88A6CC245
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 12:41:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=bcSDWIqD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11813-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11813-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 145F03003EC0
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02533859C3;
	Fri, 26 Jun 2026 10:41:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFEA3B38AC
	for <dmaengine@vger.kernel.org>; Fri, 26 Jun 2026 10:41:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470461; cv=fail; b=qla3Z1ZKBfQvutgvbuFWDk9H7xGIvEXkpYRo0uNm9rqBn/jPDN8r4kvvtnZ7ZA4EHFQxzfINov3PO7b9E4akBMPn1k4OAOBeVUE8iPmMCeijtKP95IHs5nDBYfwn/1BSSTvemI1FkZG8x2k0DoGz7cOnm5WT+/W9KSe+rS87lzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470461; c=relaxed/simple;
	bh=mj0Ea7CDmxp2AqzHmayuKoQAU1BQa64GTmlbuyujc1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1vSEeeRdWY/aqKX2rXt7XByRVTus/k4RcfKtiPz9PQex9o9HluExwfxLz5rg1pjGCp0l2rFjSt3r9gPzYrrWcUH6Q78wagFR7uldxHYndf43ZZ6hyWVbtwrxgycQvjDm7HR9Z5kgquB0PPkZmIdpGu7QgHYMaxM5HIq/DHG/pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bcSDWIqD; arc=fail smtp.client-ip=52.101.46.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a49PbLK2vcRO4LXYWPQCpE264aLG+q8Q3f7bLiefTVRa6f+A4alZ6tcNHIhlrq+ZPbUVaujxy150l/dfylq1y0Kj6ACKVTOIy73YRHxb/JT1gRxsRBt/5uUXpT24xR6dZTyKDaAPO5jhDQF3ntakum1hPfx5Ss1FA/h6kYO6YpCG8nt/QO2Z44KJBh3rX2Ec2kaZ6u3Suds5mUwMQxn0N9mEo7uVCUnHgBJ7ohoTRsYVS/8JxdFpfXHMlK4VuE+EVUrapS8kccfJ79e6i2FFDoZmaadO8fu5/7RfOIMfcBBPWJd5mA7m8npgfk/ht4M/GImKfG+GayarBgEXA0fgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMmiaRLyJu7JEK5ABx8q5WdC4QJt6xt+sse24oCI1/4=;
 b=IlA8kTEicLNbHhX9LijnQe2S+prEhvGLg2MiaHB+Xa9qUy3c28cxYEYz72f0Okwa/pNQ5UmqdpWFjQVyO2KYNHu9eF0C0Ch5mgMP8v/e2/5DNXotUjsOXZFWNz2ZksAZ7u1ogT+HBYrrCMA5WvZDAjXthAy4EtjsDLNeevVKCQ8Fljq9xGfdnRnMKNAzi1KC/60ybnexVhEHtCzrM4xdTBOtGNqUGBqqZ+GDFUh5cWxP+dfAK8QB9RWz2q/uAVctA+1o0dDUOqMRS/VagAJR2cu5xFTe6QgcS5zMipAw+PM95X9YvU9uEKkKxAojcfdcPMCeYB32vDu2njtF8DXLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMmiaRLyJu7JEK5ABx8q5WdC4QJt6xt+sse24oCI1/4=;
 b=bcSDWIqD/bnXK/Vugj7ITNto33Ox5u7bBl7hgbK+HPM5ymv6SLDwTtub/n3+7yrqcJfdfLwsm1jMFXUO7erXyGALOfILZ79fdGVs1WLLc7wd4Iyi6BBp1wsrHCVSF6ds3WAHzD6+VCSW3sH1om4XcQi2SbbxJfLjbQ2Hp2nJBTM=
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Fri, 26 Jun
 2026 10:40:56 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%2]) with mapi id 15.21.0159.012; Fri, 26 Jun 2026
 10:40:56 +0000
Message-ID: <57d1511d-73b7-401a-8435-fc82aac5baa5@amd.com>
Date: Fri, 26 Jun 2026 16:10:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dmaengine: xilinx_dma: Fix channel idle state
 management in AXIDMA and MCDMA interrupt handlers
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20260626092656.1563871-1-suraj.gupta2@amd.com>
 <20260626092656.1563871-2-suraj.gupta2@amd.com>
 <20260626094721.9FC9B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <20260626094721.9FC9B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0075.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25c::16) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 9935ec68-7373-4a2b-fb67-08ded36f6762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q78vsfxeKL7nuhlJOprvdgC6PfELbeRWrb6bn6yOuKorassuJinN3Gt64GDPqWr0whXjSS6g2i7g28qNEXP8Pi6nDmzDu2g93mO6/t8ipm4RIBiQwroNRlTti1Vusdn6OqjiMANLTrrxKOH/LpZIKyh1JDxLIn5y4snklacq1Y6FHLTeB7uTPu7gLrBotMqqXNX7UD+zviXOrfYY9qOLruCEIYhnU3GkoGj4t5jNRhKSdR1H0X1t60/YqnPrH4XFwtM4tsbRMF3x1wD9Fg4Yi4+T2v1PU3cd81Gob0tWnlIQzu6Qw0PPVWZWJXB63Plr423ION37/as1aINE+UeSTdvkIZetT+Jf2ANy0y+SEFQdrQoJQx5szp652vpqv9JJ3cP+wlM5b8BWxLx+mfz9jMW23ANfBWp/+JshHqRMsrSBEJT8yYaenEQVjGAwRACPjUBigKuMmlQCZiOrd1NA6pK02jgN9Xzt1DPAi/nMCbaETQE0vUP3m0bGsKNW49kma3Y7qAjLHxco+ZH79pjhY8N/gwETRnw7xX9MeEcSuJP5V2a/d5Zt+6kE+GttJ+No+dD52+abKL4UMdhSF5Ug0ZSg/sVSqabwlZHD/7G5xnvt5fBHMbiVkl3HPZs7dNoDafTOaQOnPwMP2NqwZOiusGMn4RyKod6quFwbhBhxuic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1UxdXVSanFLdCthQ2IzdFhhcXhKR2J6REJ1c3FvYytJY2tZMXgyYzErM3NW?=
 =?utf-8?B?TWpZWVpGK3dvTHN3SmRLMXFJeHBNeURzMWFRUlhqdnBpRTlrQzN2bWNrbUVK?=
 =?utf-8?B?R0RLVzROeXhNZVdlTlRjcXFoOERCNHJYUURLM1hJNUJqYnU5VS9Jdk5XYnRi?=
 =?utf-8?B?ZnFiVi9UcUo0Y3ZOVjZPc2FqNmU5Rnlac21ja3IwbnB1U3hIWFh4N3ArNWg4?=
 =?utf-8?B?UmJkZThuelZHUkQ2VE9lVXNXMGJWVUYyZEVsWEplV0lVMHpaK0NqTzNPL2Mw?=
 =?utf-8?B?Z0pjcDY0bkZlczhibk01QjIwQUVtMTlQWmYzZndNWDY0M1gwUi9uU05OcmNX?=
 =?utf-8?B?Z2hueE5pcDJRMjJ2ZFlzV2U3c0xLN1FXWTJOa2FwNVJyMUxyeFhFeFpiTUsw?=
 =?utf-8?B?dnBJTWR1SlN4eGc3Mmk2TjlEUVVQWFR0SUdRVnlicmZhMWtLQVp1TW8wZG8x?=
 =?utf-8?B?bEMwb0xVZCs2SGVFQ0x2Zk50TXhUQ1loYk85NWNVQlZRVTlRTkNaUWlvRmVI?=
 =?utf-8?B?MU1VS3g5VURtYUhaRW5UUXlKYXFERkpFSDkzWVhpTEJPS0lKVm9wVE80ZkVM?=
 =?utf-8?B?b2VTNDJFQU9zckdrT2hSUUVYVDYweHBaaHdCL0Y3S1VTc01oaHAwZE1QM0JP?=
 =?utf-8?B?bEcrZ04za1VlN0hjaWZRMlZQQTFyYzB6bk51S2NKRHdBUnBHQ2prZm43UXh6?=
 =?utf-8?B?enBJVWJMNlozcm9KODJDYTg5TDFlSWFhamVlWUV5OUZaR1V4Ty9VeW1qNEI3?=
 =?utf-8?B?bjAvYlpIOVRLSjRKaDFBQjVia0hBL3RyL1FNTk5BK3RacnZjc2orckZvUXB6?=
 =?utf-8?B?VXRmRWg0QWttYXc5S0N5VmNiMUZacDNrNU1kZUFONWcxcnFxYWgydm9vaGxv?=
 =?utf-8?B?RHIrS1pBZXV3YUNjdkNDUG1uWGxyWVoweDIydkE2bjZuQ2NMSURrb3JpT08x?=
 =?utf-8?B?SjY3K0JtUi8vbS9Yc01FVjA2bmlna2g3WFNYYXBGZE8xd2F6c3FLV3F0ZjIz?=
 =?utf-8?B?dDlRcDFpUzc2VlNjL3IwalFtWTc1bkxYTU1wdmJOZHdCWTluVEVSUVlXUkt2?=
 =?utf-8?B?WVE4R1lzSCtuYmZUTnQzT212OENlSktuSzd3TlVkQTd5SVhoMFl2OENNVGh2?=
 =?utf-8?B?L2d0MDFMN0I5cTVmaHh3RVN2NEV1N0dmaWJsWWxJN1JHMzlLZFJxRWYwZHZS?=
 =?utf-8?B?S09INnZBeFhlWFlJZ2tvTExqdkRsZ1RDdHkySEtzY2RHTGxmZnVRZmUrdnpr?=
 =?utf-8?B?N3crUC9RRVhvemdDM0NJNUdZVmFncHBxaEFicGxMQ3BaRnQ4cFRNbUdOaUdQ?=
 =?utf-8?B?Z1VtaCtUZGkzMUVPeStOL2d6bHlmd2ViZnhBdFAva0xxT0NlaUo0WTk3cUNw?=
 =?utf-8?B?V0Myc21Sb0xPdHY4U0huK05hM05tMHJGSWhGbUZFSnZEOTEwQTNqeWhzZ2dU?=
 =?utf-8?B?WUY0MnBzMk5yaXQ4Ly9JeDZYR0JGWkRwSUpaZEV6RzhPbUoxSXp1NU5TQUE4?=
 =?utf-8?B?Lythd3FnZVNPZXExVnlJNXJHL21QMDZTTVNtRlZDOWpnNzZmYUdVVmlZaTNM?=
 =?utf-8?B?RXpZUWhuSGxNa1pxTC9NNVBROHJ0WndFNFdQNVl5TWcyY0FtMmN0c1ExYlRX?=
 =?utf-8?B?OG9xQ254am42UmR0aVZlNHB6UWNlR0ZrOW4rTDlYZUVHcWM1SUhISEh3M0pY?=
 =?utf-8?B?NWt6VXFETlVHK0o4WVAwQ08zQnJtbG5yLzF4RTRocDl4WFR3djlGRWlMWG1H?=
 =?utf-8?B?R1JOL1Y4SDdNRkhjRUMvSXdFU1U0WWpMTVFRMXE0ajY4RzZ3Kzc1L0pFc0N5?=
 =?utf-8?B?M0FtckNvQjkyOVpocXFNN0FvckJjYjZoYWl4emdXNXZaenZIYTZWUHpxV0t0?=
 =?utf-8?B?VGRNSXdYVXNwUm5Zd0tVRUhLeXhjeSt3cGZjNVUrZU85SXZZY1RBQWhsOHp0?=
 =?utf-8?B?M0hnYytXd3dxc2FmRWY0ODY2K252dGhXd1Vic0xMd0IydWYwUy9IbVlwd1N3?=
 =?utf-8?B?aHZSaThPZzRxQWdkN0U0YkZsL205L3IwZDRtMzhXMVhCMzQ1eEZGQlQyaVJh?=
 =?utf-8?B?WDJpM2tVVkdyUjlCY3J5WVhjY0F0YnZ0YjdQdlhhUlMrVnFWNW9vR2pvQjlR?=
 =?utf-8?B?OE9kclp5Mm5WL3BlZXdKbFVuK3VWL1dUWFdrOWJOU2tlbUhzdEFBV1ZQTkZP?=
 =?utf-8?B?Q1FJWWZmSEdQa0loNXZtU3IzU1UrN2gyS3Jka25JenFOVTR4SFMyVE1pWXQ2?=
 =?utf-8?B?WFpDaGxxb3F3dE8zZ0lEeVcyczlVOG40VkhRSDQ3ajRRMGJJcnA1eXg4MG9F?=
 =?utf-8?B?dXc1U1ZEdWdTOVZEZnROYkpicmc4bXk1SXVMdTh0bHNOUWRVVHRCUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9935ec68-7373-4a2b-fb67-08ded36f6762
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:40:56.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIKFf0dwLcdLnD/YVI+qYWS1mQNb9yJkn1nEaxf9eWvFWrJllvTQoLBe+ae2s3+UUEDHN87zmi6F1ses/eVtUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11813-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B88A6CC245



On 6/26/2026 3:17 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch claims to fix a race condition for MCDMA channels by conditionally marking the channel as idle only when `active_list` is empty. However, this fix is entirely ineffective because `xilinx_dma_complete_descriptor()` unconditionally empties `active_list` for MCDMA.
> --
> 

I agree, MCDMA unconditionally empties active_list. It is being 
addressed as part of separate series:
https://lore.kernel.org/all/20260313062533.421249-3-srinivas.neeli@amd.com/


Regards,
Suraj

> commit fef85fe49f3788eecfb93a71efa6536e69b799c0
> Author: Suraj Gupta <suraj.gupta2@amd.com>
> 
> dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDMA interrupt handlers
> 
> This patch fixes a race condition in AXIDMA and MCDMA irq handlers by only
> marking the channel idle and starting a new transfer when the active list is
> empty.
> 
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index 404235c173538..ca396b7097427 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -1893,8 +1893,10 @@ static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
>>   	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
>>   		spin_lock(&chan->lock);
>>   		xilinx_dma_complete_descriptor(chan);
>> -		chan->idle = true;
>> -		chan->start_transfer(chan);
>> +		if (list_empty(&chan->active_list)) {
> 
> [Severity: High]
> This is a pre-existing issue, but does this check actually prevent the race
> condition for MCDMA channels?
> 
> Looking at xilinx_dma_complete_descriptor(), the hardware completion check
> is restricted to AXIDMA:
> 
> drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_complete_descriptor() {
> 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
> 		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> 			...
> 			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
> 				break;
> 		}
> 		...
> 		list_del(&desc->node);
> 		...
> 	}
> }
> 
> Because MCDMA descriptors are unconditionally unlinked from active_list
> regardless of their actual hardware completion status, active_list will
> always be empty after xilinx_dma_complete_descriptor() returns.
> 
> Will this cause the new idle check to always evaluate to true for MCDMA,
> leaving the race condition unaddressed for those channels?
> 
>> +			chan->idle = true;
>> +			chan->start_transfer(chan);
>> +		}
>>   		spin_unlock(&chan->lock);
>>   	}
> 
> [ ... ]
> 


