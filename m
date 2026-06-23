Return-Path: <dmaengine+bounces-11758-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gWjqMY+tOmoSDggAu9opvQ
	(envelope-from <dmaengine+bounces-11758-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 18:00:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E2F6B883C
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 18:00:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=uNpbKSzz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11758-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11758-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16C09301A51A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C9330ACFF;
	Tue, 23 Jun 2026 16:00:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591C3081A2;
	Tue, 23 Jun 2026 16:00:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230410; cv=fail; b=KzSqZ0WyJVcVjdYswfvg8ObKUIx7fnHFPeFQypt/99D9KW3iR8wMWEBwWSeNXjmDq2Tyj79FpTjcofszy6ai1Bke0dyRqVyOB3qFp4PpxcGtMJx2hDJ1eObl7lFaYvI3DpzUH/9ExH0oviA5UYrOJGH2mgdvWN9SwsTNscYg7zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230410; c=relaxed/simple;
	bh=xMeX1o9kRX1jI7WNunVVZWZR3RPZZW0AO1wMZJjHy/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PiiXyod4JaEg2sY/Ylm4VVP5FyPo97pqy20wQ4PYWQrOPp6vCoe7p70P5yucVQ/Tx1cDVrsB5g/DPuh6g8B+gUYK7oB/6Y84DWEW75TL/kkvzJfUz6Fqok+8ElZtBK42Qm1BJKSxd4prMObuGWSDJFop4kafW2bqrUbtdPMzBhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uNpbKSzz; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA3S3vN3GzUr7ShQgmglUNGhD84ZHLe7UztOPigPT/r8WmOA2iXtPHuITW7Lndl41ouI429Zs/CMSuxmYieYz9z5Xj9MNZ5mU+VLITsKRKy/X2jsDRwCQOFPisdfmDYgdzrDFu8s06DZgMNQ0xZMbE7biCoBEl8K4tNb2TYGxzn/YDTfMUJmsdy6k0VMsT9iEJFxIwW0QIg3T18ef+ERwKqag22e7yFY3fYVZb1MdSu7Jp4Zj22+jV9ByQSsPHyCkz06eLk3SAUzxmmGmk4d7HWU1x128C/kkWFGBI0ko9yhMjpmGydtHd03HK3i0ucYclZLc6RQg6Y93foSLWuD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl5onSsMJgyDyHNAL/WcBCaLiBhm7EJqzj4ZI6iqxsM=;
 b=u7WnDFPYPuUr1vULuWgf0M+c55Oi5hxmxMyvFzZvAQmpGyfyRQHWH6EwwnRxt9lhnIu8g+Mv5QRs9dKhnekCrdRxjcRxU6VwOm3f2IrJoMs2jacQ+fUUNhfSSvTmXkR08KTuKMf2ZlBvWvROLYILZ5V/SNpfIBiZIIJHVsup+Jzow9+SNagFpdYx/q47+VfZLyDn0+lgR7kq6yKPThZQRYrOXnu2JbJUG8PM9oPmlhrWu3BjsG2R/+YBl1ZzfNMNgMOeu7DyoeLCIEUTalcKjPaL9d8DPLXdqxI7b3/0n4o+NakfYVnmDeG8zYkOszCX6gEV5MQpB10GuUBrU1oDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl5onSsMJgyDyHNAL/WcBCaLiBhm7EJqzj4ZI6iqxsM=;
 b=uNpbKSzzcGpDXLjwBONazkz1RG500BhSnNXSTBVucl61ISxVrabfcvXuEUFP354TQqD7ASYbslh8IeTLHrpA9boWQG+XxwdkRSt6k+Mck2BziVdw+7gwrpEk26SmqoqEqSZ2KeR/+m6WjHkDkk4iams/q+/ey+NzIS95O++oaZk=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 16:00:04 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 16:00:02 +0000
Message-ID: <7079c747-3168-4aee-aa28-9410b57ba806@amd.com>
Date: Tue, 23 Jun 2026 21:29:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/3] dmaengine: xilinx_dma: Fix channel idle state
 management in AXIDMA and MCDMA interrupt handlers
To: Suraj Gupta <suraj.gupta2@amd.com>, vkoul@kernel.org,
 Frank.Li@kernel.org, michal.simek@amd.com, linux-kernel@vger.kernel.org
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srinivas.neeli@amd.com, dev@folker-schwesinger.de
References: <20260620203417.4000360-1-suraj.gupta2@amd.com>
 <20260620203417.4000360-2-suraj.gupta2@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260620203417.4000360-2-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0143.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::10) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 7756c962-50ec-4f77-9906-08ded1407c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ekjsOf0rgoX0FaosehdZWdVbMtrf5tawiHGf/hmuEfCDADjDktpFpAFeAUAZofwNtAyUtpcJLONzJS3pEno144Kw3hOhsPeTBeeqfKFEH0BfIsCefZvR7iWx4sL1mDCx3d5VhcuysujF6RmoJanrZVjHICpmyhVOnbrOFHDPoBKeEAOhsf6opS5RA/QjNbYXSjscWKXmw7F4gIQ5UZwDdtteWacTerYt/akd5UDLgYymPKT9uxelxo2mLwB5wIj1+JpN31PhkomJDvTBWWyvS/4s6DvWETJKXZY3oIYElxR+q5uCVWQBrR0OcoeGZFfeUPUrwDhiTwzVSjDeeIcQjwBgUqvEYcPiIzRXEHmvhODgC5bQMfLrDp8OHi8dC1Nokd7DGjmAVHj/ZPrYFWzMDQ/w6jQKzQ5pJRA2uAHeaRlMnwoKJUg1+j/PeJP0Rsdw44Z8rO6guE6oiwV1p8YZbxDO7DswrNaPssQdZhM1Wg27gn7fPNkbc3rghlH4kdnlIxXTIUIVXJQrcRnlsnbHkg3CZ4JZgCfAB58YCTe3CWA3ZkGw05JdLFTNQ9jO3gRtY1BAZxX9tTL2jqHaUNMHiVo1mm64OgHCrDQPQ36EkxR3XQ3lFW0O1JBoAitY5/RovPmzJl1FeKjQOVfmAVik4sU1TqADx1XTJ0d06BIUdnQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vnh6WHJ5U2trYkVDOGdQNjg3SWZ5dm5LTGtFRmtmTldkL3dJZ202dng0QWxD?=
 =?utf-8?B?Q1RuREVZSmJQTU5iMmE0Y3BwNkh1a0Z6dS9ucWVyT1Q4a2VmZFluNk1jZ3hh?=
 =?utf-8?B?ZTZvbmFCS3k4QWtybzhsQ3gwREpoQU96dzFVYU04K1pnd2d0OVZPdnZQaHp2?=
 =?utf-8?B?RmQ2SVdoRHZrOEZUakVSMWorVC9sbEtQTDNPRTRIOEd6b1lWNnVMaFVtL2Mv?=
 =?utf-8?B?aTlpK1JobEpxOG1DcmxFUjE2UldGMENkbkZqUCs1RlhOSHRhSjRIM1dFaU5Y?=
 =?utf-8?B?bVVrSjc5OFlsY21MTlJzZHZUQi9rZEd6TlQrYVFYTXVCS2ZsZlNzTEVzMGV3?=
 =?utf-8?B?Y2dxbjFqemZRQnNROUlSWWRPOU5pRXNITExnbTVjTnE3cXRjb3QvZ1AraGk3?=
 =?utf-8?B?QTh6YXdwUG9mZGdPWE9ZeEU5dG1ZR2VxWEZ4VERuZElUWVRYYXdHeUllRklM?=
 =?utf-8?B?UjlReEJscVdsVXdBc1VYVGFJRHJ2dFZtdDB0aEt4cncvRlhzY2ZoTTdUZkda?=
 =?utf-8?B?d2J6bXk0bkdBQ2FKOWgrYnNvdCtwaG9udDBpeUExaU9MdC9QWDNxWThtMnh3?=
 =?utf-8?B?amU3azc5UlhZYWowUWpTQ0Z0QUk1VG5oR0JKMnpqaFRtVEJqUHNzM1oxM3Ji?=
 =?utf-8?B?cHN3U3M4TDFRdVI5ZmlORE1NU2FDLytMeVFoRElQcmZPTWNrakV4SlBmZFJC?=
 =?utf-8?B?d2VwWjFBYW81VGFTY2EyQjNOTzExQys5RGhMR2tFQmlxdGJpUWpRUzdBUUJE?=
 =?utf-8?B?S3N4N3JvZFh4MDhkU0EzMDh0Q1V1Z2NqbTVjRnd6V0RMSEtTTm1MRkxzR29j?=
 =?utf-8?B?TFJyeS9hd2c4VE5WbEJNTlAraG1ob3FXTmVpTE1wVVd4Uk0wK1VYM3dySHF4?=
 =?utf-8?B?Tk1DTHVUNUk4b0dMeEtQdWxlMjRvS2xPMUVvSFZubCttMjlTUWQ5elZCR0py?=
 =?utf-8?B?eGplVktGNzBKaGlBVlR0TytxWFdtM3d0SVFORGVKL2J6N0xNVnhPNW45QVZI?=
 =?utf-8?B?dFFhQUp0OWRPblhCTi8rVHFBYmZUcEtpR2NFMllsWVlZbUpxVDR1U3pmNzZE?=
 =?utf-8?B?bEZ1Q1BoL2E3VHdTNEl2Q1FWaDNxMThRdjlGREVlcVNsQmRpZzRsM3g4SlFY?=
 =?utf-8?B?b2ZPSXhFdVRiNHZ1QVN3SmR4emtnMGp0NGZKSllRZ1AwanFvUFI3Vzd0WHdo?=
 =?utf-8?B?bHFMQmNlMjZLMzZjcE8rRUUwQk42c2ZDYWhzY2ZVcXV0U0JqOWNIODY0d0Vj?=
 =?utf-8?B?T2hHbWk3TGtjYS90K3VCcUhCRHNmNzVPUGZhd1lGVFZGLzRqa3pWcjg3YW5t?=
 =?utf-8?B?NXc5QWJQR1dYU29KcER4ZXpJeFgzREE5bmhYdVZObmtiNjdXc2NHZnFRRjRS?=
 =?utf-8?B?Q0t6TWpsZHRFUWIzZVFFcTRaYmtNMWtZdmdxYmpiVDdjTHlESGk4ZS8xQUJG?=
 =?utf-8?B?Mkpyd0dmVUt0ME1hdnZQZWJxNDN3ZnN3OTNWaVVrRVZHdGcrNzB4MHcxbGNz?=
 =?utf-8?B?eWNwTE9rT0pxbUYwS2dRdG1sVG54aGpDMFltL2FaNVQ1eGhMZ0ZXcWFsTnZL?=
 =?utf-8?B?Z05uclpKd1JjQ0ZLOGZZU0JrU1VUZGdRTUVZWXVlbUt4K0lvTEVwY0RjeFFR?=
 =?utf-8?B?SEo0ZEY3S2c4MW5XUFVqQ1VKM3IzQlBYcm9hakRKYWo0NEJVeVIrYzhlejJy?=
 =?utf-8?B?Ynlnb0tWRGlUejYwZUtCSkFMWkhzeUNxQTRFZnVKR0E2ZVZTODAxbkUrRkVE?=
 =?utf-8?B?MEtjWXN3Wi9yUFI0eTl2NEdQeFdhVUxnU2hDblFlQ2lZdmdkaGRPcE9jOGxa?=
 =?utf-8?B?UHpFRytNS21ndVdLUnM0dUFaQUZjRDg5TGZ0SjNyS2x6Ly9YRU1UYVlHcVlX?=
 =?utf-8?B?QmJ6ZHdxNThqSEFtYyt1aTRBejVHWHBXZ09UMjlrM2dLRFBQd1E3KzRSc25L?=
 =?utf-8?B?OVJYSzFJTkw3VjJpaDBjQTJCUmlDcmE4cldBbEUvN0k5V1RvQVMwV0l3YkNI?=
 =?utf-8?B?cUduTDFvcDlOWWJIMW84M3JsZG1HSWVVVTN1Z0Nic1VJQ3F5WVdYMms0WUcx?=
 =?utf-8?B?dHBwTjZUTzkvR2hJT1NiRmYyNXkyd1ZqSXVod0pyaXNJR21ZTEU5OWxBVmNu?=
 =?utf-8?B?YWJFOTdhRmJFdDlDdWdHSksyVnNzdnlwWThrc2FjUEhncUU4V1A4Y1NyRXJj?=
 =?utf-8?B?SEIvU0NlSlBpYkZwU2cvRzhiaCtLU0ZKMU5MOW5lb1NjZGRFMnRHZ1JYdU1R?=
 =?utf-8?B?S3QxZ0MwNUZmeUlhR3dPZGpBQ3dZSFBBUFRtY0plWUZwUllyL255anZQa1Yr?=
 =?utf-8?B?d09kdEgrcnROMG16emtxVjJCWHVRMlBLVVdSanFSdzNaVFAwR09RQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7756c962-50ec-4f77-9906-08ded1407c48
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:00:02.9481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWFlcGKOdHu8NiDANJYAgbXy5Wkj1XImenJ3zV17ptrKrzLM1BUc1RUTVRPeUmHv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11758-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:suraj.gupta2@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srinivas.neeli@amd.com,m:dev@folker-schwesinger.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,folker-schwesinger.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46E2F6B883C

On 6/21/2026 2:04 AM, Suraj Gupta wrote:
> Fix a race condition in AXIDMA and MCDMA irq handlers where the channel
> could be incorrectly marked as idle and attempt spurious transfers when
> descriptors are still being processed.
> 
> The issue occurs when:
> 1. Multiple descriptors are queued and active.
> 2. An interrupt fires after completing some descriptors.
> 3. xilinx_dma_complete_descriptor() moves completed descriptors to
> done_list.
> 4. Channel is marked idle and start_transfer() is called even though
>     active_list still contains unprocessed descriptors.
> 5. This leads to premature transfer attempts and potential descriptor
>     corruption or missed completions.
> 
> Only mark the channel as idle and start new transfers when the active list
> is actually empty, ensuring proper channel state management and avoiding
> spurious transfer attempts.
> 
> Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access Engine")
> Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---

Checked shashiko report and it points to 3 existing issues
which should be handled in separate series.

For this patch.
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!


>   drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 404235c17353..ca396b709742 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1893,8 +1893,10 @@ static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
>   	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
>   		spin_lock(&chan->lock);
>   		xilinx_dma_complete_descriptor(chan);
> -		chan->idle = true;
> -		chan->start_transfer(chan);
> +		if (list_empty(&chan->active_list)) {
> +			chan->idle = true;
> +			chan->start_transfer(chan);
> +		}
>   		spin_unlock(&chan->lock);
>   	}
>   
> @@ -1950,8 +1952,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
>   		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
>   		spin_lock(&chan->lock);
>   		xilinx_dma_complete_descriptor(chan);
> -		chan->idle = true;
> -		chan->start_transfer(chan);
> +		if (list_empty(&chan->active_list)) {
> +			chan->idle = true;
> +			chan->start_transfer(chan);
> +		}
>   		spin_unlock(&chan->lock);
>   	}
>   


