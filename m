Return-Path: <dmaengine+bounces-11828-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aUt0GGP6P2q7awkAu9opvQ
	(envelope-from <dmaengine+bounces-11828-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 18:29:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5596D245B
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 18:29:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=LXlspY8t;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11828-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11828-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 059C0300D6A2
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7511C2EEE7E;
	Sat, 27 Jun 2026 16:29:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A67149DF1;
	Sat, 27 Jun 2026 16:29:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782577760; cv=fail; b=TQiUdadt/GyIYOcPh44K6FVeswsK+6zgyq5w1/1XGVutIdCrK62k6R0bjKxnmdtFHGkS0v28pHjfAKp24rJQwMDM4eBsxIiMHmeQ0lrPocrRn54GI1PPsmwTDF/OopxFcGI/c/fnAU2QycGm04cMX+8MsF99LXVHb1xBN/BEndk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782577760; c=relaxed/simple;
	bh=qCqlmDfPW9qhz3nO1kactrQQWkP3owYYvCdmaqkS7vA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5nUvNp0MinAD6X7UyzzUsqKm2n4tCa6Q1x4k334K/vD8/zlF3agwObZwyXH8NQ8VrDi90sREu3O9NK86UTdR1M9ITUFVKzUS4B9vF43dwn6pgFLyU0IVCB3sco3aYdC1ulosjjgzuJL0IJwYxhtMFPFT7Hkmnucc+FE+1KedgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LXlspY8t; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTXCRWowCfCYKoGFU80N3qoTp6+srPt0t/c6IeJr3Y5grK9HMF8IXrBMgCs/JBJILWv5GbogXV+KKQRRgmKC4u62GHUhlCo34TCqQ4qTWcYQ8gDDf1WgUb/y6KZbHuQIy7lWmfIk//vOcSIWYI/cozJj+XaycmyDcLOePTNoQVmNdUPUOUdUCk/dAX3Kt3Qd9DcFbG2mpZmIwLjWZWHWwd9oHgVrJ7C8+9D8oInjLfA0wK6XRxFA6J7NMgzyFYNEP1JWaJ7Rsc8b4UjrnSdtH3KPhJyKMZMyRtyfUrw9DiBlpguGuXodr6/6R/5Y7T4VBTOqLAk/y3Njml+Ir3WbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kVuwVobO7bICdhkJZKQb6fIkiahJplxcjuNKsfvE8A=;
 b=RAfNQVGKRhhux5cQXlGEX3TnhgCzWyBIzG7a3nbWJRqLkmik/79gUlbwPvDXrnp/rahu7y3juhyoQsbUS7mAU4CmbEve1NGMjGakh1P4P8vfVJCi/Dnzdq5gplqqUIcGlUMH4Ebl3vG1GavdNVhKQy7+SoWwjPyRXGOrP3YPZgYPsauDzRld0aGzgxCIhgJl06/cBo3jZGU8ZUfLE8z7HqvU+z8VTFwZVpxzoUdUDJLi9+BjB8gLMr+/IWAvsGpmWSAvHOXKIZJr6fBQm9S/1kkDxopin5z+6VVoDR2VJuNE2QiHODf668DWl8PrfvlF9bZkVwVaOiBW6nPvj+df1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kVuwVobO7bICdhkJZKQb6fIkiahJplxcjuNKsfvE8A=;
 b=LXlspY8tM6hAsJUuyVsp1b3dyJ4rew32I++MhCMIDTWZQDG4EPEvhKkiTzNEd9aDuxuuLl7bIQ5XVWpsVUK4bSL/nSHGr9qliYh4a/XzRmtOxlwHc3csUzkhbeJ3hl1ypxSk7dl/cq8jC9RdPuXr8eHmrMKkrJ7oCGm27EM1XFw=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 16:29:14 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 16:29:14 +0000
Message-ID: <21c995be-5881-4b59-928e-058027153ac2@amd.com>
Date: Sat, 27 Jun 2026 21:59:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dmaengine: xilinx_dma: Fix channel idle state
 management in AXIDMA and MCDMA interrupt handlers
To: Suraj Gupta <suraj.gupta2@amd.com>, vkoul@kernel.org,
 Frank.Li@kernel.org, michal.simek@amd.com, dev@folker-schwesinger.de
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260626092656.1563871-1-suraj.gupta2@amd.com>
 <20260626092656.1563871-2-suraj.gupta2@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260626092656.1563871-2-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::9) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: b287fe68-d529-4d1c-0533-08ded46939fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	uPw4XAiB4TceoAmr6Yf6EP4R4Aq+2mhMmb1PTHMSc0t6IrXaGRvrP20BG53h/haajA69/056KbNMe99SWYFVeQhmSqzwbUQb8HJQorekhSzbnfTKSgd5bYPlFMLy36RtnFa4FKwA+D7UrE5p90cTaV5gyLYgKKoYFV0iOCmtW2rBMdnpaQUCymQ8WSe9zt1z9gXuLHTgbPRaDIMNIxH8uuHm9BYvapuEANBm5JtEeNUC3jLrRIFCv5MTboadlr9CcK+AR+DEDb4M3fsic8uZVQzdVmZt46eXYFU+cUmcyupuO2I9FFkvZn4hEqCbDIfo+n743l/zoNsemiqbHUhoOg6QuaMTEoeDcOXapZCONNX8O/Is4D1HX5bhJxNhgibLp8s+HE+IEdnl0b+ubRScrT4FDGpWnW8wi+WPTydush4zw3hq3qlLiB545z1kQq60m+0xgmJk3M8ksMlmNcl6EtIzm3B6X4qdz07hiyepl/spKBMmYl6xwod55DNy8q/8/rZkf9qr5dDH7JWGM2/dh734zuMnqXRTzocZCIdDU4N/kGOlnwqkzizshdqhaoiDyg6sPJ+NfKUe8x0UVMdntLHDMFd+Kx567U92IA6a9UuA0KIjdvtPC81YINgf/utEsJLpGORd1XvZg6k1nvE/zRUAPlwE3K832/hXu6vOrdc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eElTQ2ZDblRZbTgyT2hkMjJneE5Kb29FbmtsL2RGZjVNU3hYM1ViQVpYcFFn?=
 =?utf-8?B?akJhMmhnZlg4elhDNTF0UmhjNFhSQTdZRWowRWtjcWhaRVIzYXdCVzUyZ1RI?=
 =?utf-8?B?eVFDT2lZUXEzZjFJd0JzUndOMklCQTRhTmFaNDF6SS9PNTY1emRVM1o1ZFk2?=
 =?utf-8?B?YXlVL3hIYzFqeE92TEhJNlBkZ2VLQTFYTDM5Y2RBMk5RWmRvNXo4SlRqelV5?=
 =?utf-8?B?ajdvTlkwV0NsRjRZYktDV2dzV0xCRmZEZU9ZV1ZxYWt3Q0lkSGZnTnJJT3Bm?=
 =?utf-8?B?Z2RWOWxOUTEwWGptaDVHb1J3WmJEVkZSeEJsWEFhY2F4VTBzWnJ6dUlkSHRO?=
 =?utf-8?B?SjlZRGtQMTQ3cWxyclF6RUxVU1UxMk1UeWVVaWh6bmloY0tnYVZTT3hlNFlz?=
 =?utf-8?B?Lzdla0N3eTNhRTNhbW1FMUhxcFJST1Y1SkY2TCtETXVTTVB3c0htRlo5R2Ni?=
 =?utf-8?B?SDFMUEJpS29uWGhrZlJtWFd5d1E4SENvNWdiZ2p5eFo0eHg3MlB6Slhuek1D?=
 =?utf-8?B?SE10VkZMSGFjWHVPUlhIeXRJV2hCQzcwQUhqWWNnaUJGWlR5TUhsVVZmUkJG?=
 =?utf-8?B?WUhvWXFmR1Nnb2V3Rm1QcVowUDVGV0lzMWFMMCtKVUtqU3QrK21GaCtFZThW?=
 =?utf-8?B?S1RSWDlSQTNSbVlnbFFFWm8yNEJYSUtTL0hZOGw2Sk01bmIrZVNpUXNvYmE3?=
 =?utf-8?B?OGhNTWswSHJGZmJzT0t6bjdtMmtnZzA5N2x5di9XZnpQRGpoR1hONDlPc3Vx?=
 =?utf-8?B?a0lzanFJNzgwZE1wSWpZUFd0SHhvRFJiWVVSZ3dKR3NiZTBiN0dOOGNrZk1u?=
 =?utf-8?B?WG4rYVFsVFJXQk5jcXcrZDVkN3lpVjU0dEpHdHZXQ0E3eXl4U3ZWWVUzZUU3?=
 =?utf-8?B?RlJxbjZxRlJRQmdmRkNieU1XVU1ZckFrcTdxNVdOKy9PREMvK0M4ekJzVlNm?=
 =?utf-8?B?WHBKMFVGRXVjQnNWdlZTNFRZYmU5S1RYdWVBMk1PeGdBSU82SWIvRjZmNG5n?=
 =?utf-8?B?c3VIazFibWowOU15elBlNjQyUFMzdW5Tejl2a01EV0oyRnNtNVZsNEJNZlZC?=
 =?utf-8?B?aWdDQWtlS3gvK1dZUDN6ZHJlRW9JK2EyKzRkVUZHbHZkNzZJRnFodVRKcy9U?=
 =?utf-8?B?SkxEVjdJdzIxbGdCZEhYbFFlVm9sT05hUzJ5eW04TzZLMGhtTjh2Wng5aDJN?=
 =?utf-8?B?ZEpaZHEveUVJVFFYN240TU9DcmdiSktPWFkvaUxnZ1VhQU5jM25kT1Z0ejZt?=
 =?utf-8?B?NFkySjgrRFVGRVNQb2lHSWxQV0tJeHFPQzUzWWFrK2NLMmRzUVZCQ0xjNnhh?=
 =?utf-8?B?dUlWdkJpaEtZTHFNRFExQjBmZ2hQRTVvSU81YkcrSStOV1ZsMHZCWXdZTmJO?=
 =?utf-8?B?VVhLYlo4bUtWN1JGOEhzVmFUZ3ZjNlBvaVJaRjJLZTFFSkc2aFh2T2hnV29D?=
 =?utf-8?B?dXpBcFlSTTZuRGNBMmthL3daQjJweU5BeE5yU1N3OVg2UzhXYjJUZ0VXRnpN?=
 =?utf-8?B?cGcya01Ick5VNklDZFlZSkZMby9qTnJnRDdnNW5PdzlxUnpNYWQ3eGpXRWRB?=
 =?utf-8?B?MUg4ZXZzN3VXMk1NZm16OEptbDhMMjJOKzFpa1VERy9odWFUZmFSTmZCbmdS?=
 =?utf-8?B?UnRnSjVCc01kN3Y2ekJmRnAwbml1S3BoRzZiT0RPdEhwdUJmV1V1OTRyVXVE?=
 =?utf-8?B?V3ZFT3ZUeDBaRjRLV3R4NGtZS2p6YXBXNkI2WW9DSGFuZ1dEbVQ1dG1FNEpj?=
 =?utf-8?B?WE05Q1Y4ektEZy9tMWR4blpTWEhLSm1IMjhEbnViSXJIZ3BVNmlCUEkwNGs1?=
 =?utf-8?B?ZjJDZHJqVXF6VWlkbHFQYldoUGtRME1tR3VBcnV5THN6S3VVYnpHaERFQzZI?=
 =?utf-8?B?WVprM2lPRTExVXBsLzFoNURDRlRoWlZXVS9EZkN2Mm9HRU1tUElJNUREblNZ?=
 =?utf-8?B?UEVaYXNhV0FUUDBSQVozQjlPeW1mV1d0RG1ZUHR4QkZ0OFBMYWlpUndUbU1O?=
 =?utf-8?B?MkJCbTZhbjhzRFVtaVR3UmFvY2dXNjNiYTliQzZsbDFWejBzSE1lbDV1d3BL?=
 =?utf-8?B?VVR4N3lmaEpFR3gzWTJnZ2pHNmhwa0hVeGU0Wk1IMS9NUkt3OE9icEFMRms5?=
 =?utf-8?B?RXRocTB6aDY0dmc3Q2NEMTcrMGdDbVhrS1V2bkR5VG5QOG15UXlvRFdXZVNX?=
 =?utf-8?B?VmVxZnpHdzRNK3VHYWU0a2RpNHBQQmhIUitpYjF4UVV0SllBaXdVZk5mOE5W?=
 =?utf-8?B?b2gxUDE1SnlDOVc1Umxvb0xlY1A3UitiUEw3T0dEV1puSHpIQyt5dkpTblJu?=
 =?utf-8?B?dHNWSXkzZ1hvcUpIR3RaenFDelErYWtXYWU5a1FaR2VvQlFSRmVIdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b287fe68-d529-4d1c-0533-08ded46939fb
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 16:29:14.3596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKAu1mVT9wiQPF4n7l5VhOFFoRXvueS0lSJOd4y3FFWJheUuU8GXmwAivXlXm4xG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11828-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:suraj.gupta2@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:dev@folker-schwesinger.de,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB5596D245B

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

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> ---
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


