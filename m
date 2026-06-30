Return-Path: <dmaengine+bounces-11887-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HxKSK2m1Q2o9fgoAu9opvQ
	(envelope-from <dmaengine+bounces-11887-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 14:24:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0316E421F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 14:24:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=CM2NIVdk;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11887-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11887-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65FBC300A582
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABF2409E1C;
	Tue, 30 Jun 2026 12:17:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F031E82A;
	Tue, 30 Jun 2026 12:17:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821864; cv=fail; b=jeLGNMABkkNxCqkqhJQV+BK0FnBs/b2+TzdbT1zrRz8D31Jwk9kcIXQnIk3r7SEw4OOxjuKcHH7IKLNZ4hVKRDgvNPTHQeAXf5H8/QtTvVZEhxUzm7ibhJ4TIhkyUBV8TB0R797XRgaoTYZvyQBUTxVuCgIJSz63RKZv4/FfjmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821864; c=relaxed/simple;
	bh=dVyZ7yHHxsI7a6wdkkLHq7wscg5XNRY5vwhct3N11SQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NILE06rIFZVuZ26PrWBdQAsCWTKiYGMX9AMg5DvvR0d7t79Nt1Fq99uE7MNAdbjM4rsJw5wOLSS+3PLhgJZ34+4dX6Tk0zTq/IbvC/HTW+5GtyoLlEV3yHcFVpV7DNR8cL5+refpYaOIOZYecJU4r6ycQLFPveAeWNA0EaraJeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CM2NIVdk; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bp4yyj5/k8pSl+uWX+BZ+7pqUDpzAjbjHmFRVm+grCpe0bDoCPqSlBFy8t9NlnmutzQHeq7PIWly/fG6Fn7ZW1Oz9gN93NP1IjwtcLRaUkBsSBDEYkdD4UkwpgQuOu3ViY7WChLopLVzCaTOPA/NorONC3G5TfSLPp9B8wxksMhhNbqSArGqdaudDN0a2MJZJ/+D80HpctoQOi/+MFLQRL8NR70xdbNL42uD+HQX6t5MJO56oAblTEz8v+df3H+g/jmUoEsPcYT8tFfnov4WL1cj0Qs4oB9o+ZSfG9zfEmFsHyWoUIDC5xH9fAkh653I8qneMRQogHI8QC0vgmEahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cndRjFFNCSZBjXb6YYNn1YuG460lyKVJaoAkBWbiywQ=;
 b=r4YqXpan3vMLtHNoN5fqJb83paVz3HXs++zz6i5TzUXCMu+dp0AVkeVvzQ8eFJ+nDqVbf+r3st6QV3G2HLbTeRHK2+X/TckMpmbX/A9+BKJlaba4pPuXCxiEJNsKFByImxXSKv3ihPuwBgD4TTuHibtr/uBFew3k6RgqpLNrrP50Xi9SKso4btwQei4I9z6UEiahnz4uo5DCpvUgx/8D5T+YMgNyviZFhBug75SiKri+qhgPmiRbStCGHd5LAFRa8B3fiG0qjT9jSw8OZcu7gHiuKnHsnVfSVzgP8TxqByJfqRTCWlTK7ZE7Do7MjddluFLQBa2RRgFbtWCudRosDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cndRjFFNCSZBjXb6YYNn1YuG460lyKVJaoAkBWbiywQ=;
 b=CM2NIVdkdXuxZftkcDXIf3ftpMxXzFt00k2hS0Af+QH2o37jX/IpdNa1bZsCEqcfNk5H01S6QfokTwEA4ctAhinEA1AD05STVdxV0QYlRX4r5EgAZwrC+HaxWmdubV0xX1blhH33XMjJtm2uYN9bYgNqk9104lMGIEbcqE+9+sVMILVcZJ2wuO6lElCqSZz8JWWzghFsoSh4tLfJYUrw5T0CURWwCIccQKF+xGwPac1qD2Zcg1jX9Zj+t/phWIpldyz89p/LTN/NWUSScVCrpyGn2QNcyRheCDKheq0n/fl/JVPAGjRULhIh+nRWOH7cBo0Ycm0XamiR/R4nah4CRg==
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 12:17:37 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 12:17:37 +0000
Message-ID: <4bbd8cad-581b-43a7-b644-f6202f7aa293@nvidia.com>
Date: Tue, 30 Jun 2026 13:17:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4] dmaengine: tegra210-adma: use platform to ioremap
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260609212531.22044-1-rosenp@gmail.com>
 <60410a5b-226b-44ee-93c1-d9cb3eedf01c@nvidia.com>
 <CAKxU2N-DELS8D=ZFk++s-AW-uZv4gKvqmKM0gzDdbGy2zvrGKw@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAKxU2N-DELS8D=ZFk++s-AW-uZv4gKvqmKM0gzDdbGy2zvrGKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0119.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::16) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: d18dd8e8-8b02-4c3b-d744-08ded6a192b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cWW5itQANDKKAlZYdAtsT5V1gxFIPvXGP97m8K1NJKhv7m1fVTJmvdQraDlMFA2T0Nh94Ki1SXaQmWXyBVw9Or++1p3jVjg1Kblzzzp52daYpsx+FXVW12WD0vizzFe9zw6CC2PSnN8RVkeVZEUL7WGmR+RyvR9t/HJkbXaGLlTIiuc/gyEI83F+8jFSk0ALdc7MA5QXsLh+eeQcIArU6N2AtlzaBCQ0/Nd3O809uPC4S86XhdcLSZ2Mt++bUhSqfftRT45DR976TtHk6t2zpLEzJ92fdC/vAj69/HFrplcZ6+Ujhie/cgX2HAdnCf4Z6lcpZxsmkKlms+ZUXX9hH+X55yuBvFYonZCDqU86iuGyfG8ay51ikxkW6zR9A5jne2TEC842iig3XnNrrWi3pvYJA+QeiBxCuhzW0CJa6PEJLG4el6zpcsj4vwATA5w7e5cbeCsB82ndzJ4038fwfFJZuLlRc/D7WfIfK9Jz7Z+Zvbcf7/2Xno799sSGRFoqrvB6RnTK6xaErEiX+DPEpwHzsWpdSO1iTTQZcGHIsUaiUKsBESr+LVYQCcfsylrKICvBGVCDVkKL24kTyiZ9QMQw0S3+M07d+PK5Q9GHrOf9Y+QjCDCzJ4v5wyncqBaaVjutUBKWuh7YReU6mI5xp1guywIhwCcQ7rFsqPRo9ow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0RNN2Y2czEwZ1Z3ZHdVY3pQaTE4T3dFMjY5cEt3RFBqK0drbno3aTNzdkM5?=
 =?utf-8?B?SThQZW9tZDdKK3UvR3dNN2ZTWFRBeTBaZDZ3Y0FUQkV6TFA0bzJFMjlyN214?=
 =?utf-8?B?UXVjdzNRUzMxczFhOFlyMU5VYW9HOEVqbmFXZnFyUVZEU28wa3FHU0cxK08y?=
 =?utf-8?B?THRXK3hBV1phS01IUm9iVHEyeGYzQTkxRXYvQTFHRXpKNlQvM2ttWmY1R21R?=
 =?utf-8?B?M1RZQ0d0ak1HUXZWWGlQWENmS2VEdUhkRzZvL1E3MVNLTGV2ckdsWVVEQk04?=
 =?utf-8?B?VitVNitHOUJoVGJuOEZ5MU9PWHVYdko2czYzQ3RZeGpSaldUN1hNbmozbTMv?=
 =?utf-8?B?dXZjaWRtSXdiTUVkZmNRd2xDdm8yN05RdHFJQlJsY2VVL3JEQU1rcW9jdkkr?=
 =?utf-8?B?WVNYMWJTUzNLTFNTVWtrQWZsVEdWaTlranNwM0J5ZllTRVlNMjgwRHNBM09w?=
 =?utf-8?B?ZlVNV0lBbEpJZG1GTjJJcHpFSS9yQ1JDUTZIUXRWbFVmZktxNzRuMjVpd1NG?=
 =?utf-8?B?ZGU1bnU5d25xajdvSjFTcG1UVklvcHVIWk44ekRxZ3doeVBaRmlyTE8rYlRi?=
 =?utf-8?B?VEJ0QkMwajRucmtkSkdJQnkvSXVod2FDYXZNejRrYzlJVHNMaE04R29ZMENH?=
 =?utf-8?B?UHVuQ3d3a3RheHA3K2FmbHVnZTVnQ05KM3RMRDhDeGo0TC95OGFFdllhRDR0?=
 =?utf-8?B?VGRYdmlKRDZUWlpYSENOME5CTldxeFF1STE3OSs5YVUyTzNhVzlFWjRSbi80?=
 =?utf-8?B?R1pNckFxS2ZocWhDaHFzTmxtMUY1Ym1XSmhVU2lzWXpsbDRkTWcvZVhMajRn?=
 =?utf-8?B?d3dXS29JN0psNnRMQUduY01TL3orRFpNK0dENEVmeG16MWMzTUcrdWJmd3VL?=
 =?utf-8?B?S1F4eXFMMVh6Nzd4SGF0SmJHdktKY3VQWlZiMGVMaXBLZkFOaVRaeTZyTUhz?=
 =?utf-8?B?MUM3K2ZNdTdTaWpuUDFNUTJyWXkxeTA0UGVoeXE5aWdLbzFrZVpvejZqYzNx?=
 =?utf-8?B?c2ZobUhPVUVNb3p0VThtcjYwUW9XTC9nY1JjcVNHZUVrMVBsYmxnV2hWMnZD?=
 =?utf-8?B?U0t3UG9TRmQrQWVIcVo4a3hsTk1YZm5WcXpVL21nbEVKenJTalA1NnE0TVFy?=
 =?utf-8?B?ZS82Y2JDRDNFL0hkSEI2WDZNNVBlWGtIdU42OWZtVHVRNWRyL0krRWJ4TkhU?=
 =?utf-8?B?a1Q5NFFCakZpaGJvRTI4bkpEQTN1OGxQUEc4TGdzZEZNZy9BazJrbG9zT1Np?=
 =?utf-8?B?UVNLSi9lVyttaE9JQkkzWnMyUnpPRlNndHlCNVZyRVpQWTRQUVV1b29RSmRW?=
 =?utf-8?B?VzlhV1BNaWZmSFZFMzZQM0xZeklJRVp6cXFWTjFEeXlwcENLUlo4R0hZM2xN?=
 =?utf-8?B?QTFpQ0pPSGRHY0g3c3YydmZJbVh2WDdhQVRLMGtLeVZNcnl5Vzhwdlo1TTA4?=
 =?utf-8?B?ZEZ0NFl6TjBXWWVjRTJlQkZERUp0OWdhU25ZdVl3LzZ3aUtPOW5pb3NleXU2?=
 =?utf-8?B?Sm1yQ2srY2pIUyt4S2xLSDFtL21mR1pnakE0ZHhidk5rR2hOVk5zOTBCVDFK?=
 =?utf-8?B?eFhyRnlMODh6cVhvdm1IUSs3aWtZV2JVd0RBN0hZazM3YnhpenJtOTRQQTBD?=
 =?utf-8?B?ejY1QTdFdFhRUVdEVmtPTlFhNjRaY0d0UGZmb01EKzBkYmJjZ2phc0ZPU0l2?=
 =?utf-8?B?ZXBtQ2I5cDdpM1RCWWhudTFZOERYTU5xQVVTbkZoQm00QlBrTXNSZjlkekFj?=
 =?utf-8?B?T2RjcWxpNmhERXh0d1MvWFIyRklpRXlMQ3NDK3M3R0htNktKWDBZK2RYdEgw?=
 =?utf-8?B?Z1pNbVphTjZBd3ZnTUZOM3BFT3hwR3U0ZitpaGg0R1VkU3BXb0RNeE5pQ2hj?=
 =?utf-8?B?NitZcUNtOXZ6M0dUbitZUm1ZTk5zcFJhdDE0YzNFaStNOHI2dnFFTUpDRXZO?=
 =?utf-8?B?bzd6ZmlrZXhKN1dXc1FEQlFEdFdJTU4wZXROSDRzQy9DVGd4SVlWR0FwTHUx?=
 =?utf-8?B?OStiWVJWYnVTMlhzczBpMG91Z29RUUhYWmxMOEZIM24vY1BGSXdFQzJYYkJ0?=
 =?utf-8?B?R2N4dHFuZ0oxLzAzUzlzWnUrWWtxdmkyTEhPOU1tUTE4cGx6NzBNWER6WGM3?=
 =?utf-8?B?YlBualo1ZHJEWDM4MXMwQU9xS1lmSHRlTlpUUEt3S1BUamxJdU42MGpFWUlr?=
 =?utf-8?B?L1lkem1JOHZ2L0paSURHUnAwblJRMElWOFU4Um9xVDJlWVNMVlRBTm1Jb00r?=
 =?utf-8?B?aWVWUENuSGFVVWlOTnBaY1FVRnFacHBXcmdzWDBBcFpNa3Q4RVZSR1o2WjRm?=
 =?utf-8?B?VDZ3eVE1L2syeXJpNGhHVEd6cDJUMkFTUHhsVnlTV1lYeENvU3h4UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18dd8e8-8b02-4c3b-d744-08ded6a192b8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 12:17:37.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfJvH3ZelWvaxTxcjP300UGGMvjAylj42wEOJIpWdcrlAPNHeelxxExfi20tf7l4TlDVsYVRyAPYzKG9sNmikQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11887-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:ldewangan@nvidia.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thierry.reding@kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B0316E421F


On 30/06/2026 01:31, Rosen Penev wrote:
> On Wed, Jun 10, 2026 at 1:43 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 09/06/2026 22:25, Rosen Penev wrote:
>>> Simpler to call devm_platform_ioremap_resource() as it returns multiple
>>> error messages for whichever part fails.
>>>
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>> ---
>>>    v4: rebase and reword commit message
>>>    v3: change subject
>>>    v2: reword commit message
>>>    drivers/dma/tegra210-adma.c | 12 +++---------
>>>    1 file changed, 3 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>>> index ceaee1e33e68..21a381d022cf 100644
>>> --- a/drivers/dma/tegra210-adma.c
>>> +++ b/drivers/dma/tegra210-adma.c
>>> @@ -1087,15 +1087,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>>                }
>>>        } else {
>>>                /* If no 'page' property found, then reg DT binding would be legacy */
>>> -             res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> -             if (res_base) {
>>> -                     tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>>> -                     if (IS_ERR(tdma->base_addr))
>>> -                             return PTR_ERR(tdma->base_addr);
>>> -             } else {
>>> -                     return dev_err_probe(&pdev->dev, -ENODEV,
>>> -                                          "failed to get memory resource\n");
>>> -             }
>>> +             tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
>>> +             if (IS_ERR(tdma->base_addr))
>>> +                     return PTR_ERR(tdma->base_addr);
>>
>> The dev_err_probe() was purposely added to assist debug. Please don't
>> drop this.
> If you're talking about the memory resource error,
> devm_platform_ioremap_resource() prints
> 
> ret = dev_err_probe(dev, -EINVAL, "invalid resource %pR\n", res);

Well technically it is devm_ioremap_resource() that prints the above 
which was not obvious. So clarifying that in the commit message would be 
good.

Jon

-- 
nvpublic


