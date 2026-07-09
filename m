Return-Path: <dmaengine+bounces-12260-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1EuoLC7LT2rUoQIAu9opvQ
	(envelope-from <dmaengine+bounces-12260-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 18:24:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A0F7336D5
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 18:24:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=aiFGWz7Z;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12260-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12260-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34EA830BE53D
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041BF434414;
	Thu,  9 Jul 2026 16:18:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612D434418
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 16:18:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613935; cv=fail; b=kkHNwgwytz+T2WQq+HRxQ9VX0ZkbsOQk5iHxCH7aKVP+tw1knd6+mLHL/VTsoVXQ8rjk+v/SwQEDqUI11fD7lsUEP5deprzGJlkNr1N1Gw62j0pIrsfntQZX8G24Num14ILUYGDfJEwJr+HDp+mtQnGk2EVP5LcwHAqevhcMVE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613935; c=relaxed/simple;
	bh=3aG+It5vI6YysOcY8GhFz+0t1XS1a+28R00nmBtoqyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N//lbkzaUfaNfM08WFzcZy5vyrM7QNwLBh2UUc9nxvpvAzmPp6OqvZyayfDx3rLCdp7j4VdR3XGZVnb6DBfNzoLPkA2hdHgPr/Hm5aR+COoEsiZtleEAEMYdD2OHvt2f4COS/47sosZKjmNnxr77cWzUNweEgok87tRzHzUS/SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aiFGWz7Z; arc=fail smtp.client-ip=40.93.198.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ya547dnEJTnCqiLMz9LlLy2HoQgYB6c7JqCDRyTpDDe1w/z8v3f//SSbVwUY3zEbe6/xducPRRxK2EpUZqSV4UJEYauw36b3x3CsKYQOE9xBY1h4/zlwOzm7r99/goCPbHu72kLwz/C8f9R+Elxy9NqVBBkSuSfZKFjmtQ2YmChyXcOXcZuG9Y6wMPCEroMKXEsWaXdnsEcc+EOYOKWfY5/u8nZcmboMrOAO/uqdqQECorDKuJJRkOHyL/zrbQuaESzUwX6wBEPtmyZTYFA8MpVMvvntzBFH0cP6W11EtLMoTY+izJar32une7i7Ijk8Q5stK/f5KgSRapzQoy/Qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5lJ/McIDr8QOypAmV9jE0jrjI+2jXbQT40n9rKlTsQ=;
 b=TxA1adxCOhdW/d9H+CmoXLHMPEgRU98ufpF0ZQh4QC3/rNocmzRoU2DHINRpGYyP5YiS12L/jKIRqRy84WMQrCbmVmvrPZvWPQBZq+MxO3RU6sodlgg1Bp8gbzJevVCV+L33QcYGHtWzeiTOdPdwTckL9xLUzcOV83pgmXRstd1afpYLAm8Egoxy9hOVgZENfgIFPoqAgOZSY5zDUx1TOhBMAbYcvwS4KZcpHFbYHTr3TljKFMpLKNxadwQOxqJ4AykH0mFu4DqNS7hr/gIjSgnpcp6vMLQmpNsEE7+cSLb8lYeekK+p+ZUyXx/joyjaiN9HLMLPprdnxeodEq4paQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5lJ/McIDr8QOypAmV9jE0jrjI+2jXbQT40n9rKlTsQ=;
 b=aiFGWz7ZXqOlkWqQoGM7v0+qcrF0ptO/tsxe3hQosqlBlAtRyN0Sl2Q7RqPfp4d+RMJaInga55brCT6EsWlXR84Ou60YuoMkIvjhqsduuVFtJ24Yrm0P91ST+6TJLJsCHN2am2HgbOyq1tvp7YDtBnw6aUGYrKC03zL5n7ckx7M=
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 9 Jul
 2026 16:18:41 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 16:18:40 +0000
Message-ID: <75675ea2-04a8-4eed-9151-919304f9cd79@amd.com>
Date: Thu, 9 Jul 2026 21:48:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/4] net: xilinx: axienet: Derive RX frame length from
 DMA residue
To: sashiko-reviews@lists.linux.dev, Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
References: <20260708100652.603074-1-srinivas.neeli@amd.com>
 <20260708100652.603074-4-srinivas.neeli@amd.com>
 <20260709101123.375A41F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <20260709101123.375A41F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::16) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd940ff-f5ca-4d66-d5b8-08deddd5bd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	Eqs0og2ew1k7/v0eOw4ZKkRNqOF/OUi1xe9DlHfqSGZ907nOUWfomSmJdjIgxfeKK2aUqDl+tIDcpvPtDyIBGM49NQqdKZxYzKdgRtyUoNaaxBJJEHyh2+LIsrCNFFpnAcpjCIO9bPcZI2GS5CbAL4Lt5vZ43S1PQ3Jcg4/NpfhD3CDNsYD9MzJrLk4qxB8b3vMnb4DlXngJrYhzSndBoBMYgGGs8XSVnX5cYM82x8H9/OFK2LeduqpW1DbiCaxnqnphsOQypI/L3r7x0HP3EQzZXPFWJzEkBHOLJOEG4FU75BYF6LYOmgN++Ec2Xc9AoyOT1brndh3HttvFcgwuUQP/6XLLniuwB8+Uz1C64IZm04vNmhsWZZQpLynRkHeAcYTBLwoQUKpYScIBZtIbPF02j+GoHnw1Xxc2VyEIKoFInN3W0ERagJX0B61y5gLtGF28lteZk2/rM9cfA4LJIXxkhPZffR8clEFGhwQzCOd6Yhm/xhh7oCGSmDzS1a7Illtqxr53JnCwJzJ1d3tfVNOqDkg/NciUL/3n4KK13AqD7RCuAJsGKtnRfiDFeeJXBHVNrgYL4st5XeHOzUeDJmHuz8dnhs5hN9xuqv31wVssVmPr46bJ0IDPSv9FtXc6onxYWD4p0WVEBPieksCyc6PhQb3uw70Eolcjr5DFa10=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHpjNi9Kbmo0Q1NJc3h6S2JVTXpFeHlBSy9JZTZtSE5wQnNZUUl6K2E5Mkdz?=
 =?utf-8?B?Sk4wME9nUWdxTkhYdnkzUjN3eDRDOXc0RVJYVjVGZXVBdFdkV1dlYURaUlc1?=
 =?utf-8?B?ZENhbE9KbWY1bTdKWkhvMlYwNzNsUHNHV2hqMVNQYkVuT2hrSldac0gxV2VQ?=
 =?utf-8?B?eUtOSE5WZko4ZGlBQlZlR1lXL0xoZmFLMk43OFdwaEZ2dCt4cFRPMXdZZDUz?=
 =?utf-8?B?OXBCcVlNRTljNmpyemR3cENPWkVwVU1wQkdCQS9rS3AzL3g3WklWYnVnNTJV?=
 =?utf-8?B?OHdoNit6bER6WTE5MWRldmRhSEJTUUYxSXUzSmlibk13ZWM5eVV3WTZxRjBz?=
 =?utf-8?B?MzZjd0FlSmZNUEhyUnd2SG5QY3ZEQ0hZNERTa3Ixbk1Sc3NnSXc2YW45NWlk?=
 =?utf-8?B?blpyYWEyUGZQdDBCSlBUOVQ2OFY4N0hiNEFVZ1lLeitxVDN1K2E2cUdaM3ZK?=
 =?utf-8?B?V1IwQlZHQ3RyT3ZCZk8wd2hHTFUzQ3hIelFXQnZTSDRIQWhiWlR4WkROdi8y?=
 =?utf-8?B?ejVaZDcxSjUrZ2grRDd4UGRCT0FHN1l3MnI1S3JRM0hET215M2ZVdXZ0SjJx?=
 =?utf-8?B?cytaV3dXNzVlWWNHV2RrbTg1NTFUcnJjelNiNVJ2R05pRHBTUHVUVDRoVEpp?=
 =?utf-8?B?MElJdmVjS1lTajFPS1M5N2pTVGVZN1Y3Y01FcTJWUmVZY1o4eHNXTy9IbDJ0?=
 =?utf-8?B?QzYwVmU0Sk1na3F4NkFrTEgwQTNwSDdnNXVKOU83QmF3VDFQK2pOa1hUZGNN?=
 =?utf-8?B?eXZudTJMS3JLM2tBNEQxRnRzOGk4cDZSTVVFNHZRczdHZTYyOU9lMTd6TUFI?=
 =?utf-8?B?YWx1RnU3RlRKTE0xZGt0eFhXa0VpaEV0T085dk4xN29RR2syaGtKaVZMVEpt?=
 =?utf-8?B?RXRUTVYwZVAyM3pYbFU3RGVyNXpWL1k4QzVEaHZCT1lXRExtY25jYUFtTUU5?=
 =?utf-8?B?RlZ6UHF4NEM4bVpITDMxRndZVU1QbnZxdUxKUzQyMkxNOGZSdHdEODIzdUo5?=
 =?utf-8?B?Q2VFenNjb0RrM0VIR0hTL0lCTlQzNkRYSDJKZnVrWlVKZzVTa1NFS243Nk5z?=
 =?utf-8?B?NDV2RHZSOXE5RmpSb0NvcVRiNFk5TTkrcnJnT0grQ3dNT3RUTlFteEFWWWtV?=
 =?utf-8?B?M3FmWERWMGZRRVluUHJORjZEMytMN3VraVI4M2x2djFqTk1KVDZ4Z2M2SW0z?=
 =?utf-8?B?Nm5BMjk0Y3ZhcXE1UXdYNm9sdUZhZ2pqeHpBbURjZ2VBOG01UkhXMkVhK3p5?=
 =?utf-8?B?NXVBRVE5ZXVmbjVndTBhelZ3bkMzemtQaHIvN0gwK2t4cWR0Q296QnllWkd6?=
 =?utf-8?B?Zzk1ekphdTIwTEdzWjlSZzBMa3Fla3VkcE9jRkREUjRSYkpCck5JMjlCRmpO?=
 =?utf-8?B?cGhhaDhnNU1tcElNa0ZXS3g2ZU42VFl1a0tZVUtnL2MzK3RhajdpWUFPVjlI?=
 =?utf-8?B?OXZwUXJXQkhJZ2p3Z1VBSGhodFNXanNEVVpvVU5jRXR6WkxTa2g3NGxyWXJw?=
 =?utf-8?B?TFhRenlReVhhTGZKWkROWHk1dHpYeks2SDdRVHhlQnFFWm44MFlYYkpDWlZv?=
 =?utf-8?B?cFQxMjZiZk5DYnhiOWhwdFVJSkdwZ0ZKc1YrZ1hsa08vQUZCMXdsaENBbnM3?=
 =?utf-8?B?ai9FcEN1eVNyeGpPQnQzVWI5VW03VTcwQStnOTBScU9uQmRCcFp1aitsVmpZ?=
 =?utf-8?B?UVJESzVGZisrakJIUGpDMTBYT0dINjBsbEowZnVSN3FxUG13azNsWWM3a3B1?=
 =?utf-8?B?RWZIcEg3bnZHVXBEV0ZUVnNEdk9LOGNRK3MwMG1aR2MvOE4xd0EraTc1dUdJ?=
 =?utf-8?B?TnpvMVVYVHhORjVoN2Zzbk9hZW85Wis3YWhZekFBUTd6TVl6Ulgybk55ZWFB?=
 =?utf-8?B?VHhuUXpabTJRVDd3eXV6c29Gb0RkNXA4cmhNcG1UNVd6R0h5all4VEp1T3lT?=
 =?utf-8?B?bWZUV1JySTRCcG11OWl2bnIzekF1cHpMRFdrdnoyR1lCTVFHMVFnTnc1aGIw?=
 =?utf-8?B?WC9JajkxVUVZbWFMVEsrZUF0S1ZDVUQxczl6aVJwME1EcU0vUEE1QmdiTFlO?=
 =?utf-8?B?WW9yTEMwOU1FMEpPWTY0TmtQZTFUS3ZMTHdKYXllVUtFVTI2Y1U1NlI5YndS?=
 =?utf-8?B?ZVp1UFlBV0lpSzVvcXliK0dEdGU2NWhZY2I4c3d1OU5CQWRIRXFIY0NmSVZQ?=
 =?utf-8?B?YUxEWkg5Wm1PSDU1SkpIaEt0eFRkeTNQeWtZV3duKzRyU3BtZlc0TzFFQXRO?=
 =?utf-8?B?akEvY052ZXZSaEJhTUVmYzFJNElpam5sejFWRkhESEwrNVVSMGt0KzhSbFZQ?=
 =?utf-8?Q?eubU9WZyz5sjavsmAj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd940ff-f5ca-4d66-d5b8-08deddd5bd2f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 16:18:40.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +V+i6m1RD3PV0TBCOYr8a94g9XPL++qlQQ9EUlyaNanYSryrK7V3GHevNiHbzzn3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983
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
	TAGGED_FROM(0.00)[bounces-12260-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:srinivas.neeli@amd.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[srneeli@amd.com,dmaengine@vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[srneeli@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40A0F7336D5

Hi,

On 7/9/2026 3:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Pending SKBs and DMA mappings are completely leaked during device stop when using dmaengine.
> - [High] TX ring head/tail desynchronization on DMA mapping failure leads to use-after-free and double-free in the TX callback.
> --
>
> --- Patch [3]: [PATCH V3 3/4] net: xilinx: axienet: Derive RX frame length from DMA residue ---
> commit 0ead77c343fc9310122738aba9dee99007a10e45
> Author: Srinivas Neeli <srinivas.neeli@amd.com>
>
> net: xilinx: axienet: Derive RX frame length from DMA residue
>
> The dmaengine RX path previously determined the received frame length by
> reading APP word 4 of the DMA descriptor metadata. This patch updates the
> code to use the standard dmaengine residue mechanism instead, allowing the
> driver to work on designs without the AXI4-Stream status/control interface.
>
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index fcf517069d161..67d1b8e91d683 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -53,7 +53,6 @@
>>   #define TX_BD_NUM_MAX			4096
>>   #define RX_BD_NUM_MAX			4096
>>   #define DMA_NUM_APP_WORDS		5
>> -#define LEN_APP				4
>>   #define RX_BUF_NUM_DEFAULT		128
>>   
>>   /* Must be shorter than length of ethtool_drvinfo.driver field to fit */
> [ ... ]
>
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_stop() {
>      ...
> 		for (i = 0; i < TX_BD_NUM_MAX; i++)
> 			kfree(lp->tx_skb_ring[i]);
> 		kfree(lp->tx_skb_ring);
> 		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
> 			kfree(lp->rx_skb_ring[i]);
> 		kfree(lp->rx_skb_ring);
>      ...
> }
>
> [Severity: High]
> This isn't a bug introduced by this patch, but are pending SKBs and DMA
> mappings leaked during device stop when using dmaengine?
>
> The descriptor wrapper objects are freed here without first unmapping the
> associated DMA addresses or freeing the encapsulated SKBs.
>
> Since the driver loses all pointers to previously allocated SKBs and their DMA
> mappings, could this exhaust IOMMU space and leak memory each time the interface
> is brought down?
>
>
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_start_xmit_dmaengine() {
>      ...
> 	lp->tx_ring_head++;
> 	sg_init_table(skbuf_dma->sgl, sg_len);
> 	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
> 	if (ret < 0)
> 		goto xmit_error_drop_skb;
>
> 	ret = dma_map_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
> 	if (!ret)
> 		goto xmit_error_drop_skb;
>      ...
> }
>
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_dma_tx_cb() {
>      ...
> 	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_tail++);
> 	len = skbuf_dma->skb->len;
> 	txq = skb_get_tx_queue(lp->ndev, skbuf_dma->skb);
>      ...
> 	dev_consume_skb_any(skbuf_dma->skb);
>      ...
> }
>
> [Severity: High]
> This is a pre-existing issue, but does this lead to a TX ring head and tail
> desynchronization on DMA mapping failure?
>
> In axienet_start_xmit_dmaengine(), the tx_ring_head is advanced before the
> failure points, and the error path does not roll it back or submit a dummy
> descriptor.
>
> If skb_to_sgvec() or dma_map_sg() fails, and a subsequent packet successfully
> completes, axienet_dma_tx_cb() will unconditionally increment tx_ring_tail.
>
> Would it then incorrectly operate on the out-of-sync tail index, dereferencing
> and freeing the SKB pointer of the previously failed mapping?
Both issues identified (SKB/DMA cleanup in axienet_stop and TX ring 
head/tail desync) are valid pre-existing concerns in the dmaengine path, 
not introduced by this patch.

   I will address these in a separate patch series.

   Thanks,
   Neeli Srinivas

