Return-Path: <dmaengine+bounces-12051-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FH0MFHy0S2peYwEAu9opvQ
	(envelope-from <dmaengine+bounces-12051-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:58:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D89E711964
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:58:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=2QSbMWGd;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12051-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12051-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E03730470E7
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 12:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6594252AB;
	Mon,  6 Jul 2026 12:19:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0133FC5C4;
	Mon,  6 Jul 2026 12:19:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340375; cv=fail; b=B9QqglNP/1/bEtkhUpwdMfFyxzpcZdKb7MHpUGV1+lzPsAPQPXOXe64LgP6QQoXSWaQe6TAMtKdU92hphUTsPK1Jbhrn5FU+0qY+8S4LgW6M4PJCtqKGMamM10mreL7XAZpp55d3b1VwBhxWVX2jbDt9E1Eer/P7yubyaXYZ75w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340375; c=relaxed/simple;
	bh=FC2spHN7LGwIYRsG4IRLawtwZKYTcfl5P1IkmwNNsMU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WTk/Q3jafeZY3s84yCWCyKJRmj2Vk2xMMLYmYikvsjU5mXjNMkQvHTm3TaPGzDAY235haq8ezH0R1xy1vQ1Ye0AAFP8q4KU4JKZ66Ur8CRVf5IB4W9Hdd2IEzYpZHuULfcuS3w99toXZjg02cjaM3OOqqq+OGDFGJOlpo1taXeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2QSbMWGd; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkFYL9Pf1t+gQIyHsksDnHWGv9Ep4kkehtRjcoaqYNUNOTYp076cg3mV5bXXw6e7X8qYOlGojwkMWElS+KyYLgFpXvCFzFtWEBLMz/OjJQTR+ND10ynF+ZnxMo+p/EsCIw9LaTLJMXPP6J8t59rtXemGr/fd4jITXB8sdTHq1yPbWhgsjHfunvOjuV9+1QRZ3n+q3CqmX9QLfnLHHLRbhEJsoa5XphoSIStYWrxO+Dt55KBrbtyn4yINcXBF3OsLnUVArwBnXiglNzhj8ztEqAwVzFXWNR4v50tIhxsQXfaGX9RKcFDFnTSohL0uGkR8k7bxFjgNKRy43hvFOhX24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odwCHHgtwFwKkaHN2NQHuSYgV3dvrGnYiO2N3WrkaHI=;
 b=ZhuPcqu/wjJjA3qVWZwoNi01JbFSvyG8BMcKOAyc4sdz1qmCrGnXLkAh4c3DoHeHSpXd/P27lAb0iwbgu64QSnSawPxxnXMwFcQWP8egMtGDDrByX6xFfwnwTwfnGVTTFzv6eRsta3BgFN6NWqgoPA//BpKc/2GPPBxZUk7aRsFo/NvjTgyhtPrY61lxAWrl50gstgJduJZoTzxSX84Od3jub3+r35q0AzD+yyDQpxVVoj429LThJRhI4TF92Y2ca/OpxajnyDGFbBfn3vPkASg1AO2xhnNHgvUl5LPouVEYiGHmVZ8PcKHtA7eSY8iswSyF06hnIQDnnr/vCsHKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odwCHHgtwFwKkaHN2NQHuSYgV3dvrGnYiO2N3WrkaHI=;
 b=2QSbMWGdTobxDzZpqMaswKmcVq+o4Ahd04D/LCSeWEYeUwG7oJh/WQn7nIXpc81JJe+Er0QQBKHCMIhV8CigCk/dT1TdnH/Jh1SAneiyilTddNEZHALLDNJbd4o3Nqs3jYTb+2wLjMGPKtBKZnufMm4DyIkBb1adx8ID8tZfE9k=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:19:29 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 12:19:29 +0000
Message-ID: <88b599f8-87a4-4a74-ade9-a7689b5a9d8c@amd.com>
Date: Mon, 6 Jul 2026 17:49:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Devendra K Verma <devendra.verma@amd.com>, bhelgaas@google.com,
 mani@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@amd.com
References: <20260626132151.1875965-1-devendra.verma@amd.com>
 <aj6kWCMbzyYC8Nh8@SMW015318> <791ac596-69ae-4eea-9741-0dc889111909@amd.com>
 <akQfydYXj0xwwVQK@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <akQfydYXj0xwwVQK@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::13) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6a282f-fb52-4e21-846e-08dedb58d411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	i65J3I/19vn0JParXtqf/DjZRElvI3z33ZyVscLBtRtLmt7ygAaxXlUfsWwIkSLHiXl4XuMzsE4UY3tYeITDPAEuLrb0JBlWHyKtdTkdyLXJis1oUqMqlXgSv5FEeScuvhJCLr4kgVYEJgY4EB1DJrUcT35HaKUM8WW9T/HGKRBpzC+dpPkMP5nnt39gNLvgzY8e25Qi7WeOi454BzXMM5MKBRdyzlm3UBPdeK9CwKlrJ7WKTA+lltgRB5QS9f44Q6C3JZviVVMBtH049WpWRpRz/IPAKvOhLevyRl5+1hPWqTWDNlgtmaW0aghxcEQFGUf7gUP/hc4QeFVo+yFwUYWwlbitM58jgV0W+QW1Mi6IP2ZQYiwHKY90qlNJ0F0gIFmffPgDIX6TLgS0cZKl915BO4R0U4tqzPLDe2Nbzm0eEhMzhy3Eibxnbo5KrASEYHgXTN4Z9e1CBDCxWzSNBDoohTw2MOjxY0xw2JWZk7WsHAOMiLgduvpVBrECtPTAH6moEijZ0h3m54o0zP1j7fs995a6wN5XCEp5S/zxoqUxA6J/XPdvccThwsIFrF2bLUbas1WOWuEVb7zz9QDpg5+6+NCd1aPRnCnsxvUrxcaHfcxx/ONJqAlkUiDvlFPkEp7BAUHmjKqegyZVbNMa4tYCWZ1p+TfHHJosjtttIaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFFpdFhSTU1jZDg0UXdoTTFFZE4xZ2t5WW5wa25uRlo2NytFaldMUU9pUkRt?=
 =?utf-8?B?dTcybVBWNkVZWlVJQmFxN2piWUg2S21Sd1NSbWhZWTlreUUwNlFiK01MTWtJ?=
 =?utf-8?B?a0V3ZzhlSmNTUy8vekZJckMyVk1YVStxY3NwNGV1RDVKdC96WlJxMlN5SHJM?=
 =?utf-8?B?MWZDK29lemlZYVhqNWN0aTFUaEdGQXZXTUlRV2dTdGwxY0xXenV6cUV0NkNB?=
 =?utf-8?B?SE5nMzJqRUlGY2dkalZVTjRiMW8rUm1CWXN3dE93RjRJOTV3cHlZL3VFaHI1?=
 =?utf-8?B?QnNQekJTazJ5T2N0MGsvL1BFWFhFZ3JuUHpNMVhqVWpvZGY4QnJzUmxTYi9O?=
 =?utf-8?B?OGtVNU10dVI4ejJndzRlNURkd0xVN0VvZmNxUWxocHJ5WENoekI4aFlmWmdE?=
 =?utf-8?B?VDV1d1lUWllNWE9FNURhd01OSXo2Q0d1RCtlbERqc1dKdkRHdXhhRUNCdnZV?=
 =?utf-8?B?U1p5OXNmcHc2N0xoS0pLbHd1cXVXcmhPZjBLNkI3UHRyWVVpSHdKQ0YvQ1JP?=
 =?utf-8?B?TjNZbjJiMGhOMittbWN6Ui9zdXV3Q1dHcDJlTUU0cExWMVg3azBQT1lSYzMv?=
 =?utf-8?B?bVNRbTljdmhMKythMWFTNVBqL2NEVVpSVTJxNStiTkw5WFBFOHdmWmNHczl6?=
 =?utf-8?B?aU44Q0lQS0hZWXJDa0VJNDNuMDRIWWNtUGRxTmRoaFgwWkxJK0Z0TXBneUF0?=
 =?utf-8?B?NXhrdDdMQ0pSYVFlaEh1NFdyZG1OQXoyOVV4MnJvSENJZ1RBYzJGZS9lSWJm?=
 =?utf-8?B?ZGNvMm1HMHN2SXNTSHhtcHdSa2xxbDkyNWh1ZElMbzVFWEZ6eXdteklteW4w?=
 =?utf-8?B?OE9PSzVWYllra0pkeG8xRTRXQlRFY1Iwc2ZJUGwyRGNvQmV4N0k3bisvVXh2?=
 =?utf-8?B?R2ZOVm5xSms4dGE0SUJxNFplOEQ3WTdreHZRWXFyN0lqa1ZhQUhWUml4QjBJ?=
 =?utf-8?B?SjhnRGpWQ0hzTmtYLzNweHF4UkFPQmhrZ0N0Si9RVG9BajgvMWNZK3VUemNw?=
 =?utf-8?B?Q2NzVER4TjlGY1JsUGRuVHNtNVhFbm95WlpQM01UVHJUL084a3pCMUJNTWo5?=
 =?utf-8?B?SGxHRnl6UG1hL1A1ZEJDZWR3Z3RkNWxBTjErZmJJbXFtOHNwMTE5N3FsVkVT?=
 =?utf-8?B?Z0x5ZlRYSitYVWlEMnpLWXc0THlocmlRMDZTQWZCMm56Yk9iSENkaW52T3Q3?=
 =?utf-8?B?a2R5YW1EZ25kNUMza1NyNjNyd1BJb09hODNXVDkzQlFldzN4M29BWXVFK08r?=
 =?utf-8?B?UWRSYm93azlXbHh6ZXV6WEl5MHZXTE1wOFBVMUN6KzlJZ1NkTjlza2ppb2dl?=
 =?utf-8?B?dm82RUtrL2ZFeVlyR1Fna2d6ekhTOFFKSTdCSmJORnFZemxZd1l2NjQ2WFBD?=
 =?utf-8?B?aFlNNHlFUWdSdTIwZUxPQTRUbWlFajRaekRmVWdSY21CZDEvUGV2c1RxVkt1?=
 =?utf-8?B?bm9QTG1sRzg1WFVrY2FTSmFZUlp1L1p5ekx6M2l1SFRDRkRPNWptMHZSaENu?=
 =?utf-8?B?SGRjUEg3T0JWN2w0QVREckZSTGpxd0lOV2YrMmhmTlo0eS9WTUk4cUdzd21h?=
 =?utf-8?B?NzVvMlZGQUFzZ0hVYzFpbjhlZGM4VUpEK2E1dmRYRjNFTkNTNGM5ZWVYdDNY?=
 =?utf-8?B?YVRLb2MzOHRjUmZyWm44VUYrUWtlYTUzTnUrZDJBbjhiNE4zdmZmdGxqS3ZN?=
 =?utf-8?B?SlhuN3hkd2wyS2xsc3JQTmx6SUl0Yk9QUjVwOEtxNHhzdXlTaGM3ZzhrN2Iz?=
 =?utf-8?B?Rld0YjlwS1lZeHVQaFBZR2g3N2Rlbysrc2Z6MHRuZUc0N0VZaXRWNHNTV3I1?=
 =?utf-8?B?aHJXWEptaUQ1eldaZmRwUXVZajUxYVk4cDZxL08rMk15dzFtbmdpRnNQQnNV?=
 =?utf-8?B?UXRjODhMVWU5cDRCUTNaRndQQ2dpU0FnSlZZU2JOVmloNGlIb1J3cWlLS1pa?=
 =?utf-8?B?eWtkY2EwU29ZZlYwb3ZVOVdLZFEzNVppUXIydUNvY3lLS3FXSHhTb0VwbWFL?=
 =?utf-8?B?YlF4K0EyRjNNU0ZIYzB4c2dGTmQrbCtHRTJVQ1MwT1Y4YzNXTVlocFBTMVg0?=
 =?utf-8?B?QnRJK1JqdU0xMEorSXM3eWQ5bmM2clhRM21FUUFIbnA0dERzdHZDS3lCMkdn?=
 =?utf-8?B?WVhoV1AzTVlWNEFNNHMzQ2NwQ2hHMDE3Qlg3YS84dHpTT1JjK2VYdjQvMFFD?=
 =?utf-8?B?ZWZLTW9xandLRVBUMFVUUEpFL3UrV0JyT3gzKzl1eEhrazdrQ3ZPVWg0S0xi?=
 =?utf-8?B?TC9oMHNmVk1RT1lXUGlMWng4SVVrRDZMdTFQS2NDMHFzVk5Oa1FMNW9FSDZH?=
 =?utf-8?B?SzVoejk2aU1RRHEzeGFCaHdacGx5cm04VzFaZ3RkVzRCTnRTczl4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6a282f-fb52-4e21-846e-08dedb58d411
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:19:29.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57DhcHTOSV903yrXqiznsmIX0d+bvMv/ofbkJgMBVrD3wR2yjO7NrZLTeDy8xz23fGWvyMcvC0ybWML6Y2XGAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12051-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:devendra.verma@amd.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D89E711964



On 01-Jul-26 01:28, Frank Li wrote:
> On Mon, Jun 29, 2026 at 11:27:39AM +0530, Verma, Devendra wrote:
>>
>> On 26-Jun-26 21:40, Frank Li wrote:
>>> On Fri, Jun 26, 2026 at 06:51:51PM +0530, Devendra K Verma wrote:
>>>> As per 'Designware Cores PCI Express Controller Databook',
>>>> Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
>>>> channels. Current controller driver supports up to 8 read and
>>>> write channels only. In order to utilize all the channels the
>>>> controller driver need to have the channel related structs
>>>> and variables as per the number of channels supported by IP.
>>>> Following changes are made to enable 64 Read / 64 Write
>>>> channel support:
>>>>
>>>>    o Defined HDMA specific macros to reflect the channel count.
>>>>    o The count of ll_regions and dt_regions in dw_edma_chip and
>>>>      dw_edma_pcie_data shall be in accordance to number of read
>>>>      and write channels.
>>>>    o In dw_edma_probe() configure the channels as per the channels
>>>>      of the IP used.
>>>>    o Changed mask types to u64 for higher channel counts.
>>>>
>>>> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
>>>> ---
>>>> Changes in v4:
>>>>     o Changed 'mask' variable to a bitmap type as per the
>>>>       review comment.
>>>>
>>>> Changes in v3:
>>>>     o Reverted the FIX for AI reported GET_CH_32() issue, as
>>>>       per the recommendation of reviewers, need to create
>>>>       separate patch for it.
>>>>
>>>> Changes in v2:
>>>>     o Fixed the pre-existing bug related to GET_CH_32
>>>>       interchanging the channel direction and id.
>>>>       This bug was not caused by any version of this patch.
>>>>     o Fixed the issue when using for_each_set_bit() for mask
>>>>       of u64 type.
>>>>
>>>> Changes in v1:
>>>>     o On review recommendation of sashiko bot, in the function
>>>>       dw_hdma_v0_core_off(), the loop iterates over registers
>>>>       as per the number of channels enabled and not on total
>>>>       number of channels supported.
>>>>     o Changed mask types to u64 for higher channel counts.
>>>> ---
>>>>    drivers/dma/dw-edma/dw-edma-core.c    | 19 +++++++++++-----
>>>>    drivers/dma/dw-edma/dw-edma-core.h    |  4 ++--
>>>>    drivers/dma/dw-edma/dw-edma-pcie.c    |  8 +++----
>>>>    drivers/dma/dw-edma/dw-hdma-v0-core.c | 32 ++++++++++++++++++---------
>>>>    drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
>>>>    include/linux/dma/edma.h              | 10 +++++----
>>>>    6 files changed, 48 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
>>>> index c2feb3adc79f..adf1b3939f96 100644
>>>> --- a/drivers/dma/dw-edma/dw-edma-core.c
>>>> +++ b/drivers/dma/dw-edma/dw-edma-core.c
>>>> @@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>>>>    		irq = &dw->irq[pos];
>>>>
>>>>    		if (chan->dir == EDMA_DIR_WRITE)
>>>> -			irq->wr_mask |= BIT(chan->id);
>>>> +			irq->wr_mask |= BIT_ULL(chan->id);
>>>>    		else
>>>> -			irq->rd_mask |= BIT(chan->id);
>>>> +			irq->rd_mask |= BIT_ULL(chan->id);
>>>>
>>>>    		irq->dw = dw;
>>>>    		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
>>>> @@ -1079,6 +1079,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>>>>    	struct dw_edma *dw;
>>>>    	u32 wr_alloc = 0;
>>>>    	u32 rd_alloc = 0;
>>>> +	u16 max_wr_cnt;
>>>> +	u16 max_rd_cnt;
>>>>    	int i, err;
>>>>
>>>>    	if (!chip)
>>>> @@ -1094,20 +1096,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>>>>
>>>>    	dw->chip = chip;
>>>>
>>>> -	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
>>>> +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
>>>>    		dw_hdma_v0_core_register(dw);
>>>> -	else
>>>> +		max_wr_cnt = HDMA_MAX_WR_CH;
>>>> +		max_rd_cnt = HDMA_MAX_RD_CH;
>>>> +	} else {
>>>>    		dw_edma_v0_core_register(dw);
>>>> +		max_wr_cnt = EDMA_MAX_WR_CH;
>>>> +		max_rd_cnt = EDMA_MAX_RD_CH;
>>>> +	}
>>>>
>>>>    	raw_spin_lock_init(&dw->lock);
>>>>
>>>>    	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
>>>>    			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
>>>> -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
>>>> +	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, max_wr_cnt);
>>>>
>>>>    	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
>>>>    			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
>>>> -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
>>>> +	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, max_rd_cnt);
>>>>
>>>>    	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
>>>>    		return -EINVAL;
>>>> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
>>>> index 902574b1ba86..d12fefbf3952 100644
>>>> --- a/drivers/dma/dw-edma/dw-edma-core.h
>>>> +++ b/drivers/dma/dw-edma/dw-edma-core.h
>>>> @@ -91,8 +91,8 @@ struct dw_edma_chan {
>>>>
>>>>    struct dw_edma_irq {
>>>>    	struct msi_msg                  msi;
>>>> -	u32				wr_mask;
>>>> -	u32				rd_mask;
>>>> +	u64				wr_mask;
>>>> +	u64				rd_mask;
>>>
>>> Can you direct use DECLARE_BITMAP(rd_mask, 64) here?
>>>
>>>>    	struct dw_edma			*dw;
>>>>    };
>>>>
>>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> index 0b30ce138503..79f653da8e0f 100644
>>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>> ...
>>>>    	}
>>>>    }
>>>>
>>>> @@ -118,19 +129,20 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>>>>    	unsigned long total, pos, val;
>>>>    	irqreturn_t ret = IRQ_NONE;
>>>>    	struct dw_edma_chan *chan;
>>>> -	unsigned long off, mask;
>>>
>>> after change wr_mask to BITMAP
>>>
>>> 	mask -> *mask
>>>
>>> So needn't change this code if support more channel in future.
>>>
>>> Frank
>>>
>>
>> It looks good to make this piece of code generic and support for more
>> channel but I did not push that change as the final limitation comes
>> from the HDMA IP which as per the documentation supports upto 64
>> channels only. As there is no channel increase BITMAP was not
>> implemented for *_mask variable.
> 
> DECLARE_BITMAP(rd_mask, 64) the size is the same as u64. needn't call
> below two bitmap_from_u64().
> 
> irq->wr_mask |= BIT_ULL(chan->id),  use bitmap_set().
> 
> Everything will be simple and better extendable.
> 
> Frank
> 

Thank you for the suggestion, Frank!
With this change dw-edma-v0-core.c also require a minor change to work
with {wr/rd}_mask as bitmap-type in 'struct dw_edma_irq'.
I will push the changes in next version of the patch.

-Devendra

>>
>> -Devendra
>>
>>>> +	DECLARE_BITMAP(mask, 64);
>>>> +	unsigned long off;
>>>>
>>>>    	if (dir == EDMA_DIR_WRITE) {
>>>>    		total = dw->wr_ch_cnt;
>>>>    		off = 0;
>>>> -		mask = dw_irq->wr_mask;
>>>> +		bitmap_from_u64(mask, dw_irq->wr_mask);
>>>>    	} else {
>>>>    		total = dw->rd_ch_cnt;
>>>>    		off = dw->wr_ch_cnt;
>>>> -		mask = dw_irq->rd_mask;
>>>> +		bitmap_from_u64(mask, dw_irq->rd_mask);
>>>>    	}
>>>>
>>>> -	for_each_set_bit(pos, &mask, total) {
>>>> +	for_each_set_bit(pos, mask, total) {
>>>>    		chan = &dw->chan[pos + off];
>>>>
>>>>    		val = dw_hdma_v0_core_status_int(chan);
>>>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>>>> index 7759ba9b4850..48e40efceb2e 100644
>>>> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>>>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>>>> @@ -11,7 +11,7 @@
>>>>
>>>>    #include <linux/dmaengine.h>
>>>>
>>>> -#define HDMA_V0_MAX_NR_CH			8
>>>> +#define HDMA_V0_MAX_NR_CH			64
>>>>    #define HDMA_V0_CH_EN				BIT(0)
>>>>    #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>>>>    #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>>>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>>>> index 1fafd5b0e315..da7a5cc93ad4 100644
>>>> --- a/include/linux/dma/edma.h
>>>> +++ b/include/linux/dma/edma.h
>>>> @@ -14,6 +14,8 @@
>>>>
>>>>    #define EDMA_MAX_WR_CH                                  8
>>>>    #define EDMA_MAX_RD_CH                                  8
>>>> +#define HDMA_MAX_WR_CH                                  64
>>>> +#define HDMA_MAX_RD_CH                                  64
>>>>
>>>>    struct dw_edma;
>>>>
>>>> @@ -89,12 +91,12 @@ struct dw_edma_chip {
>>>>    	u16			ll_wr_cnt;
>>>>    	u16			ll_rd_cnt;
>>>>    	/* link list address */
>>>> -	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
>>>> -	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
>>>> +	struct dw_edma_region	ll_region_wr[HDMA_MAX_WR_CH];
>>>> +	struct dw_edma_region	ll_region_rd[HDMA_MAX_RD_CH];
>>>>
>>>>    	/* data region */
>>>> -	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
>>>> -	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
>>>> +	struct dw_edma_region	dt_region_wr[HDMA_MAX_WR_CH];
>>>> +	struct dw_edma_region	dt_region_rd[HDMA_MAX_RD_CH];
>>>>
>>>>    	/* interrupt emulation */
>>>>    	int			db_irq;
>>>> --
>>>> 2.43.0
>>>>
>>


