Return-Path: <dmaengine+bounces-11305-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k2R2MUetJmolbAIAu9opvQ
	(envelope-from <dmaengine+bounces-11305-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 13:53:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4702B655E2F
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 13:53:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=y7xVW8Mp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11305-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11305-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8F743002E3A
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 11:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83136D50D;
	Mon,  8 Jun 2026 11:52:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFE36D9E7
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 11:52:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919547; cv=fail; b=enFARbHKUBYQZJjEmvtgu4yR1FUxBhKQtkKI28EUfac0QEJq7CBJu+XWBAshSWiFt4sd1uGYe/LkymJC1dlwj1XvAS4iOFTYhRcnIncZsKfsxH02Lxq57zCO/NJFugiK+CxGqIjFbjcNBf4RJMg8p3Ky3B+8u0rxYAHptX7Wb0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919547; c=relaxed/simple;
	bh=LqNgcCbbLLvQPLt9ezniBJFn9ntsd843iNcsLjlUBbs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S3tzU2R8DKpFTYcnlH0Y9QJPp1+IOgIOd5B64CQVyFZgMNhOHlt+g4sQuVtmep464c7JpvGVkHJFSqNWpuQThvRWIBK0RInCR9TUHuEet+0G0JDcoI6+QkgJEuIowOVDKSUJCckxGIgLonrCesQxF9TPGOZQmDG8v1ESNh8Jd5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y7xVW8Mp; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oARH2CW7ROYe5hQBZb0+51FCVNPqqAAb8qLcUaIqvKvDQ7uUYcAnnZ2+aI8+za0P5pr/2T58RU/etv9tmKhCbrpmK4udTHxcFPdbimLl/NtaXhacQ//eEx/RS2gRAhGm3RGwYOgrsc1DIMzhKtTS3K81J2BO5mn63vTzyjxNgjFFqQpQ3c5L4om/B4oKowtGrqWp2yEou8+uMmlsyCGS1XGqg6LLyx9ucJEcx58WYGyohUfDerFir+aG7r1dz5zGrai2MuhW+j5pWfYSu6JBeGWySBuEWXrLxRrQNkAMedjhuBjlBOWRO8UFAhxYHv4gZI847PsgMfotw2cgZpJy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zcjg6tunMIO7oh8NKoi/gP8djOgFn9WgxI2hpUCYJEs=;
 b=Jhmxfjhphkg8cyJbd6cvty5NJMIrHAvb1+CkYyR6XTz2prNsJqgvGsEcnwzErwnFu6V+/G37ZdfQCHFlzYD7VnebJO1gBUo/wevdXMH3tbhbyeiuMqVLGf5/Aqzz/CeLVnBsw2jhcgCk4O4cYgj3YxDPOPCTnkRvUcDXDBKsWar66J2gJscnxwvT4SPj7GSb1hY9wfij8u+fuPmgG1/WsS9IKNE0jtllkPBeDqJ42WUqBPjPn3M6sVIAp4xFctCgEkUnSKog0w81mkomT2podih2r6qA26XybxOKs+tDriF5RTKiUMHeeiT9n0VnzbFtCkbar1H/BYNsUjk6OqpqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zcjg6tunMIO7oh8NKoi/gP8djOgFn9WgxI2hpUCYJEs=;
 b=y7xVW8MpiV0M4rnfSPwhntpcpcRBe+p0ztX2Z7IhsqH27v8sxPwQSsAbVsyaF/d2Gcmox7GAybmDBr1y2AyD8IHafjZW6qtss6VqvKm48dq3yVG1p04JzoZEIFN2vIflJJBeVcSO5sKvPm6Z/0iru/8vBMyFqHmkepbVHWHvq4I=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 11:52:22 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 11:52:22 +0000
Message-ID: <cd35c90a-5232-4a4f-9f53-946aadc3f6f2@amd.com>
Date: Mon, 8 Jun 2026 17:22:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org,
 Devendra K Verma <devendra.verma@amd.com>
References: <20260608112011.3289409-1-devendra.verma@amd.com>
 <20260608114401.5AFC81F00893@smtp.kernel.org>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <20260608114401.5AFC81F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0218.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::17) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e475df-bc3c-4aad-cd23-08dec55466a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|3023799007|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2YSFNCx4HJg/R7vDDm46iirGX3EehZeOgh8+dQ7jq38ENBk2L/GAO2cXl5YY33h4+RUrtyhK5EPYPraA9mz+tXlzHj6wLyQ/nIMDsfGFpGl9EG4LjeKcAYDRLEl3LgICH8Em0agnebG1XXgv+dbkd0YMekgkAR8DmTP0EdCgONVDDy3Kxl3iXW+VdaMaiMlew4H6ts1r6VIUbDjD4/38Bt1rRMSUlo9s5DpPwCijfuMZ3BbIkBCqST6mS7co/iYzsoKNpBmUGYDa1wSe089qGtInxFH+tvbHrX5umiZrk8WL/spGkw1cxSMS6vBD3D96p4O1LSriZ4FFknAkRCEHpZYOxr+2h3DGDeZllgFIeUW/97l7fFkSZM+38ro+7f0WxKltYlgaCY9Wi/nhSiSBZva7jTYAFtS98sPbBh71ovFRhj/Xt0CDnR4WuZGEt8j2oArNHZBmIlTomaBu1ZUcxSaNQKIGn6vSjfJIjZ/L1iH15mMbOkNU2pwpc0Zyvj7+dWrCwwCxswmJusvBLKuONNMtJTlxfjKShR7qX/hial7GJsZTGqibOiOViFdeFFiNT8x8dkU5QuRB8AVDihY9tRujWcHWRw/qKJPpHAjRuyAUUjNJt1RY6SZ9OXIyDgw0QWCrg1YUBwu5XWGEqSvUE0lfW3H2rWk8W+io1OksQer98jnH66iFyPqiC3cGL1bv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(3023799007)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE1SQ201Zll2NmpQd1UvTWlURWpKUm16ZlhzeTJmSmJnR2pkK05yL3A4a2ll?=
 =?utf-8?B?K0MzRzdNSnRXVFdTVGFFUDFaTllnWWVVejhta1pNZ3M5U2lwSnUyTll5cW1x?=
 =?utf-8?B?WmR5UFlUZTFKTS9NUlkvdWpKZlRIVG1NZGdZY2pSNlFCNFh5S2lxZk1nL3Zj?=
 =?utf-8?B?MjBwU2hDV2tzVHNITTZxU0hGUnZIL2ZidEhPaWtNSWVGNW1XR0tjY21ublpX?=
 =?utf-8?B?RERSbXBjWkgvZDRiTFNJRjBKSExWZUNzK0F0OTJyWWlwKzdiN3F0UWROUEFs?=
 =?utf-8?B?VkRUQWdtNWpZM3hPZTQ2N09WK1IvNEt5ZHJUYmFJaTdjZ3VGQjNQVi95cERr?=
 =?utf-8?B?MFFCb2MwRk02UmxSSWZ0TlVhS0IxL0p6THM0MjF4TWVQNW1qS095QVhkZmJo?=
 =?utf-8?B?WDZpL1luMWFYRnN2Vk1MV2IyL0tONFc2WXAxZnZOMGNRL0V0eHZOcmVNb2xF?=
 =?utf-8?B?TThCWkpidXR2RERLTjNFRVIrSGpyWW1vSWdYYStuM0RSZitWa3lzMG1qREZn?=
 =?utf-8?B?V1hkS3VEY1RaUTdaRCtKMjEyQ1Fid21KbzVoNGl1enZtb0JrMmd0OFNCWTZY?=
 =?utf-8?B?ZWo0QW5Ka3FSWGphVjhLRFpaRVZGQVppR050cW9LU1VRL01ZZGpVZnpGVTZl?=
 =?utf-8?B?K3Nmamk3aDlUWGluYVRnNTlqclF2RjloYU1NN0duUUZuZzFhL1Vnb3VVdW1i?=
 =?utf-8?B?N1FLOEZOcytoakQxQWFvcG9PRGEvalRZeUNnNmsybDZqbm83UFllMndBaGIr?=
 =?utf-8?B?eTJrZEpTVWtSZUpIV2FZa1FqQXIvajdHNUptZGdKYmNPWlYxbkpLUU9lNGsx?=
 =?utf-8?B?bUZ2MktJRDlOM01NMVBOUThvYjhDcnpJUEszVXZwaUcrUjJoTFRackRqS1Bj?=
 =?utf-8?B?dG03UFM0ZlpzcCthaUhTTVU0K0Q3RlZ3V080OERETzF3SlVTZytQZEoxMCtq?=
 =?utf-8?B?emJ4TURhemxpWFdIMEIyVkZEZGxjVDFRNmJ5WUNzSVpidTYxNHBSNjhNT2VC?=
 =?utf-8?B?c2svcHhuU2VhMHpFZ2FmaEFRckpTREZpNU1sVmxUV2Mza3JuWWRzOW05VXV1?=
 =?utf-8?B?cUQrTEFJRG1DMXBEMTRPdzJKZ2lZMHlmRWlNS0xXWEd6LzRta0xRNHBuZWEy?=
 =?utf-8?B?MFF5RFp3VldtTG1kdU1hOVdwRGxvZ3JqMm9zSjZlQTBVeEtpT0dMQS9QTDNN?=
 =?utf-8?B?eHpaK3BzcmV5Q0ZQeFZrUTc1OGI5bmV3NDBuWGJOcUJoUURhVlp2RWxaLzhI?=
 =?utf-8?B?VEN3OHlMeTVEMFBsM3Q2bklvN3VVUURXTlhnK3N0VUtDWXdmTTBWSUgwV3Yy?=
 =?utf-8?B?WW4wMlB4MkZGby9RbGZZaElBMWlzMW5nY3BuaWR1U2U2S3grLzRlQnBubTJs?=
 =?utf-8?B?a09QZ3pqamg4NEg4enRmSVJRR29UYkpkOEF1NEc1dVh1TU1KZGh1L1l2MUpR?=
 =?utf-8?B?alNtK29EY0RTVlFUQmk2TUd6bjlhR3o5NC92cXBUOEd6Y2MrbGlDZjV5SllV?=
 =?utf-8?B?Ti9NaDZDOFh3WTdBNU9VNkMzWGxtZDVGOFRhekgyR1pKOUZoOWxRd001UVVE?=
 =?utf-8?B?TFRKSStreUdqVzFtZ2FiVTN2b2x4ekliN3o0TE1jN3JTTVRUVGRyTHBJQzIv?=
 =?utf-8?B?eFFKRUd6ZExLa0RXTEJsV2hja3MwODJUUlgwb2ZCSUs0UXN4UzFKc0NWa2lP?=
 =?utf-8?B?VGVDd0x4SVZkaDRCTGs1NDE3N2U4bTh2Z0JHM21XcjQ2U25IVFFnWk44bmlX?=
 =?utf-8?B?SVR1Smk3VUNiTkRHcmJTTU9ESWUxMmovcEFndERHT3ZLeWM5Q2ppTCtrMnFE?=
 =?utf-8?B?NmJVaGk1elp2YThjRFZYQnJIb2JRb3RodGdTWnQ1ZHljSGEyUFZmQkFvNWgw?=
 =?utf-8?B?a0ZaVXRtckdRZm11SVlSYjZOUkpTejJIcDhMSmcxMFZ6NWxNNWtibGoxQmI3?=
 =?utf-8?B?eTVwVmRyL01kaGswYlkxN09sYXpVc2daQ3ZjdFE3NkR6QUh6V2F6NUcvWmdU?=
 =?utf-8?B?V0xPQWxscEpKMXlMNVlBRWIvRzFsam1YanJMYnAxQ1p1YVpMUkZ3bmY3Sldi?=
 =?utf-8?B?VTR4cVVJQTBCUGVERGhXb0MxdGFVeDNsbE9Jd09rVDBNdk1NcWFHNzl0YUdY?=
 =?utf-8?B?RnJYQ29qY3FKM1dGM2pyd00wTFZ6NGU2ZVZDa2VHdnJIeVJtKzc1VENjZUVu?=
 =?utf-8?B?MmpiMHNGZGl4eVozQUZNUW1ocDROUlM4Smd6enFKM3h3d3h3VnZxSUlWRnhE?=
 =?utf-8?B?NnUxNFZwajJBVXorVzRLeVlmUEt6b2oyOHZZU1BIWUZTQnhJZ21kTlYvNnV3?=
 =?utf-8?B?RHZQTTFmWFRGTnh6SzdwQ2cxZW1XbHZic0hvQTdwY3ROYXhRb01wQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e475df-bc3c-4aad-cd23-08dec55466a8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 11:52:22.4365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7ZzLsqzEHRie8WEnC5zE5rUwqSJH4VHsCVVgnl23IdWT97TJlAgUktIg0wEyeZSmqJVm6qrXDf1ywmsFWmNUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11305-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:devendra.verma@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4702B655E2F


On 08-Jun-26 17:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] The DesignWare PCIe controller driver (`pcie-designware.c`) was not updated to reflect the new 64-channel limits for HDMA, breaking configurations that declare more than 8 channels.
> 
> Pre-existing issues:
> - [High] The function `dw_hdma_v0_core_ch_status()` calls `GET_CH_32` with swapped `dir` and `ch` parameters, resulting in incorrect channel status reads.
> --
> 
> commit 49f2923c673f70626e15a62547f82ae4f0d06439
> Author: Devendra K Verma <devendra.verma@amd.com>
> 
> dmaengine: dw-edma: Enable HDMA 64R/W Channels
> 
> As per 'Designware Cores PCI Express Controller Databook',
> Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
> channels. Current controller driver supports up to 8 read and
> write channels only. In order to utilize all the channels the
> controller driver need to have the channel related structs
> and variables as per the number of channels supported by IP.
> 
> [ ... ]
> 
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> index 632abb8b481cf..84b0076f78bf0 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> 
> [Severity: High]
> This is a pre-existing issue, but there appears to be a parameter ordering
> bug in dw_hdma_v0_core_ch_status() in this file that breaks channel status
> reads:
> 
> drivers/dma/dw-edma/dw-hdma-v0-core.c:dw_hdma_v0_core_ch_status() {
> 	...
> 	tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
> 			GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> 	...
> }
> 
> The GET_CH_32 macro expects arguments in the order (dw, dir, ch, name).
> Because it is called with chan->id as the direction and chan->dir as the
> channel ID, does this cause the driver to read the DMA status of the wrong
> channel, potentially leading to missing completions or data corruption?
> 
> [ ... ]
> 

Yes, it is an issue with GET_CH_32. This issue will be fixed in a 
separate patch series.

>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>> index 1fafd5b0e3153..da7a5cc93ad43 100644
>> --- a/include/linux/dma/edma.h
>> +++ b/include/linux/dma/edma.h
>> @@ -14,6 +14,8 @@
>>   
>>   #define EDMA_MAX_WR_CH                                  8
>>   #define EDMA_MAX_RD_CH                                  8
>> +#define HDMA_MAX_WR_CH                                  64
>> +#define HDMA_MAX_RD_CH                                  64
> 
> [Severity: High]
> Does this patch miss updating the bounds checking in the PCIe controller
> driver to use the new HDMA channel limits?
> 
> In drivers/pci/controller/dwc/pcie-designware.c:dw_pcie_edma_find_channels(),
> there is a hardcoded sanity check against EDMA_MAX_WR_CH:
> 
> 	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
> 	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
> 		return -EINVAL;
> 

This specific piece of code is meant for non-HDMA devices because of
no change is required here.

> And in dw_pcie_edma_irq_vector(), it limits IRQ allocation to the old maximum:
> 
> 	if (nr >= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
> 		return -EINVAL;
> 
> Will this cause any native HDMA PCIe controller declaring more than 8
> channels to fail instantiation or IRQ allocation?
> 

A glue driver is required is needed to enable 64 Read & Write channels.
This limit will not affect the functionality of the IPs for which this
function is implemented. Moreover, this issue can be taken up in a
separate patch series if channels number need to be enhanced.


