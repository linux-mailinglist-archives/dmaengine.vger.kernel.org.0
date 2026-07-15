Return-Path: <dmaengine+bounces-12547-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dCBOAs96V2rSOwEAu9opvQ
	(envelope-from <dmaengine+bounces-12547-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:19:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF7575E04A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:19:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=BJGKDSbq;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12547-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12547-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2F073021D9E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2937A443AB5;
	Wed, 15 Jul 2026 12:06:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A699435A92
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 12:06:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117217; cv=fail; b=MC2cLtJU84Ha5v0QRLdF/6SOBmPq0+3Pgm8qUmYpmvLV6byrRtfr0jatS3kK4Trp04/u8f/UbCwDkw2oB8zvVT2u+PA5babA7xCEDRmWKK3Qyewntgjslbj2zp5MedErHgbk/KttfTXIh8yOS8O4URXxIKD+dVYNN/BS5w1uRR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117217; c=relaxed/simple;
	bh=MvW1VPVuQcRn6cNCkxwlV1Z9lAtkmEQTbOnsGYKOoWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iF/iHGJT/9gGXCfJeh5r/7gRWEMhS3cjVaoBnnBnhegZMPb+B/NcfqaLegsWWMsQrq+MKx47XT0qpit7OXjGiVUVfDNtsPgrfElPbbSiX3dtKsS4vu2xA1JLKZR+A+wl9jmYkULs9wWvCtHm6RfmSYaBNqhSdyFVeRvggHAHtb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BJGKDSbq; arc=fail smtp.client-ip=52.101.53.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MK1AwoKBaP2ZPhmscQWPSmuHhXE57a9sezxnZZwsd7evx37e9BTwdKEEZnqVgA/usZQw36v6UxF9Cht0D9AZkV7sYnTLEAa6wqqHGXZRYcx4ylIJ1+eqvgO+A33CgjSstaGEGe9z3gYTKgWlVmOLm+i7pUOdC/WsWd5vJny+qJtI/rIEH7Fmkze9FUISUbQUdizc+QDtH3KjMBUSF9+6Jl4ySk1o4KCzVuiu1jtfc9/7jEBrcKd4iQw3lwgIGoGpw/2eSS7zz+SSxqdppmThP7jEucTyhN7C88b5GKXBHAE2dxOJ+61KflXd/NsgqQqZfH04ly4/yDwblASfQa8FGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49cdWgYjWCWqyOJTvzvnCdqfUOHwZgL0b+m1vfvi0vE=;
 b=ACx/m67s7QDNZbP8I0+XrntV3+VCo2CVRfpmJNYx04I4XY2UL0JA7umnxj5ATZtZe2Z9njxKv6Wh2NGM00iO5/TaBq3PmrxLHSvKG5TZpdCsOISqUrnD0OcjMzNdxBywBouqIJi9V97hj60PoeKtLJwx4uq5QB2KplfnhLNVekj4mihGmeo+t3pSFDRP5WUw4hRBVcqJAGaZW9whwlAlacjQXAVoV2Ws1rMSi+4cNoEhNj5XhTOXPn9f9zsIR9pEf/hMxfyNzldrPVE96vbekD2Wq3xDOsWa5xEfurmBl2PuuOIuJ03ZQKg5s0OZrNn/S47ucA5MGWHPHV0FcdNB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49cdWgYjWCWqyOJTvzvnCdqfUOHwZgL0b+m1vfvi0vE=;
 b=BJGKDSbqCpgwiN7koxasZh7S6DsAOsaIRuBmyJ+nee5b2SUJqLYqTHvYKWuYXsOza59xEvKa737827S4QbPkFOHrdVaR36GCdxRzVwtoPprhjGJZVcGXOEsk6VjvB1suqfpO2ftWJZFutvIOc3VqdVMQ7Ka8BV2pAo8SUKg5U1M=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 12:06:49 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 12:06:49 +0000
Message-ID: <2d4192de-cf53-47d1-a63c-65030f759e0b@amd.com>
Date: Wed, 15 Jul 2026 17:36:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org,
 "Verma, Devendra" <Devendra.Verma@amd.com>
References: <20260713064854.4065262-1-devverma@amd.com>
 <20260713070750.D13091F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <20260713070750.D13091F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0150.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::7) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|CH1PR12MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f0afa7-18eb-4bb8-1f24-08dee2698c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|56012099006|6133799003|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	+1DFZ9RDhED+MEewa1KsShnuzvMalohcKJpRvlNBbxAPpNAceD1feL7Bt1i0/ZBIQJfN1pWPIyDQNxvZktCn9mnNu8G4bgy3ngPcL1E2OHbDskfH+4xpHPQuEp/U9oWFCRP3vbDHdRG2nejUVjmoY8PhTeVcx8C4puGGWsmDeEQmS6ZoebAOcoTItpHOfz17gvONERMfopvB/mOhb+yI8FcT1zYd5c2bTJaxa8XRAjVR9wyJNoWLWejCkDsajReh1GPDhby9wZsUIGvIZzb2vTZjkCRKJluGBeQudwbt4NgdqNTveb1FHMOztukdgZMNVL5Ks/eCeiHIFX5DuT2ylOtVb9N3XcW7hwFlx2+niA4UETOY982F/o5cNewiNgLguQOAXu6mwnRH5MN5av/2Z/IfMZMzWVK4tzqddr7UJ/GduQEl4E1CJnQHgGsTXPLYCAj31dMp/Bl8Z7Qqq7Z6jkjN+hP5hM3kHXyFdahIhm0OjoLVxwLAGz1p+BarAiD0osrJjGgoUbm6Y4jVGeOPsS0ifKhNa//zaZHUjqMdqkr3PTMYMS66F/ElSq3e3I6Qh8SC/6bEP0Q4B97Je53m70DRqI+AfHxn1AOeFjw/Y0l3tPAE+1vUy3QUxuJXy846BzmMVDtofGAJFd/1tv0WJfn9YLTSYf9+zT4Vb34+vkk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUVzakUzaGYvd0ViTVRWUTM0SEF2SW9WWlUrS3lEM2Y4cU9BUXNCSE00S0J0?=
 =?utf-8?B?WFN1ZGFkNlJYZVY4bXE1MytXWERoZ29EYkxrUkFaTzV4MSs5NXp6NkdEYzRX?=
 =?utf-8?B?OUFDZ3FEd0Iwc1dtSEM3T0ZiemphM3dhSk8rZnc4YXZYSEVSdFl0NTdpOTJ0?=
 =?utf-8?B?cmFtRVFGMWNFNjhaQWQrdWJ2SUN0eEtITjVHOUZQMGhBU1FiVEc5M0tIRkMr?=
 =?utf-8?B?Q1VSMXVDZjU3WnlhL1hQU0ZOa0JtREliZ1RUTFFvNWdXNFVVblJkem53aUNr?=
 =?utf-8?B?bVJ4MGRmZTlVK0pISnh3OWI1K0Q5RWUzSVZLZFhIdXAwYndXM0JFaFRSR01Y?=
 =?utf-8?B?MUdoRnpxUCt2TUIrL0czSStlQytMOWEzR2ZPVVFzUUlxTXVxYmx5cTRLQUx3?=
 =?utf-8?B?OEZEZVpyTDNDSUc2MC9VazBsWml5MmlvamV2UGdIc2phbUFNWFdqNjc3WVVl?=
 =?utf-8?B?N1lJTXpoNGl0WXNsOWdQMnAzTVJPMGFEU2JJbTBFM3lBL1pwV0VCcXFISis0?=
 =?utf-8?B?K3YrZHY4TThHcWNKTFVUU1ltbUkyTVVTMU1xbFNwSXcyS2lKdTh4Q0k4NEN0?=
 =?utf-8?B?cWphS0pPOUhQSklGZUF5SkppdHVUV2lFcTc1bmFRTHBzaUFrRlF2ZWxGdHhy?=
 =?utf-8?B?ZGcvVUloQjZodHdrUSt5RmxQanhBS0hEZC82RmtCR2c2NmtMaUFhL2hpRzY2?=
 =?utf-8?B?S1kxems3K1kxWWh6c24vSyswMVpnRUxKMWI1VVQyU0FVTHYwRkxTWWo5UzFo?=
 =?utf-8?B?TVgvT3BPWjZUaGNObTdxZVJESFZuU013aWdsdTllMU1aTndIY0wwYzE4K1Jh?=
 =?utf-8?B?dUxQLzMzSEROai9Qek9UTzM2aTA1YW9Vc1ZrZTlUZ2lKMk1vUmR3Yk9tMW9y?=
 =?utf-8?B?NG93NTlNYzFMcmorT2dYek5EM0VkRDdFeU4xVFNnNWlvK0g1Vkx6NExheE92?=
 =?utf-8?B?MU1GbEl0K0x1WjJOdXR3NVFBcGs0MEpvTTd1Zkd3R1paeFoxeWpybGIxeWRQ?=
 =?utf-8?B?aEF0aVJQQlJ5QjVyYjBQdmNhVHc1UUo0U3A2bitzak5YS2RlalZjcjF3R2ps?=
 =?utf-8?B?L0xJQzdCRVg2Uzgva2QyMi9sckhTR0hYcEk2VXFqbVAxUSs2RVhFVEM4Mitj?=
 =?utf-8?B?NEorNzY3RUw1ZkFQMVQyb3VtL1FOTFV6TjRUK2h5M1h6NlhBYWlnRW1JWkRv?=
 =?utf-8?B?QjZLV016TllHR1FsdXdnN0FudHlNeVQyaEdnYW5jT0R3ekJPcmVmQVZVSVVn?=
 =?utf-8?B?d1huWUU4MlkwdU5Vdi9CUWhlSm9uL3o3bFZ6RGRsdHJoOE1PYlBadWJaR0kx?=
 =?utf-8?B?SGwxcXQveVNEYThSSjNoWTNzLy9vajdCQzR6d0pYdGFKRGYzQ091TFpFUUlV?=
 =?utf-8?B?NmphTjNyYkpTR1hmMjFqZzNxajVCTExYZHpLeG4zTmZiazJIU2RVLzZCUWFn?=
 =?utf-8?B?akZrYTZsZVQvaWhkUUpiMVB2WjhCTzIrOGg5c3hmNVFqMjZhSEc3L3dFTzBP?=
 =?utf-8?B?V0tCbm52SXNlY3JXY21oNzBVYkJlMExTMDB6MXYyUHFoSExCYlF1ajJQekpS?=
 =?utf-8?B?eFBiaVpsNlZYQVJVQ2MrL0hQeFRPclRlbkpUZWxQbVhRUmszTDVyVXFWMHF1?=
 =?utf-8?B?OEtnUmVMVGRja0lmOUVXSjVOa1Z2K1pCWHd3aWQrSmJsS1RNSlJFSVBpZXM0?=
 =?utf-8?B?aWpCU0Z0QzBDQ1ZkZGN0Rll3NFNiaktBSWhHY2xxbmRZVkFFVzlIZkxDR3dQ?=
 =?utf-8?B?T2Y0dXBZMGlLTUR2bHVYL05Jc2QwbENvaEdMcjZxRUdCYTRLeTFjMC9yQ1dV?=
 =?utf-8?B?TUdLRlRVQjFqOGI1bm4xOTVCNXViUThEUWo5Qm82Zmk1Y0Q1UEVSdyt3Vjdi?=
 =?utf-8?B?bFR4NGoxUi9jRDBLQ3dDQWRwdUZ0NXlVTGdPa3lWSUZock1SRklnTGUxczBy?=
 =?utf-8?B?YVlPSzY2SnR2OXVMS2NHOG8rS1dCUWtRTTZCbHBqR3JvRWhNdUVyT0w3SmNI?=
 =?utf-8?B?dkc0cFJVbFdlVXZTcnRoTmNiYmViZjBZQ0lNK3AzTlViMXd4OTl3OWk4R3Zs?=
 =?utf-8?B?UDZkWk5CdDBTa29ZbHVhR015RFhrZ29oc25rbUgxU1JrT3JodTY0dGoyY2th?=
 =?utf-8?B?VDRISFJ3Z211WGg1ZG10U1JxTm1DWTdSY29XbVJBeEN6NUcxYmNRS2kwd2FH?=
 =?utf-8?B?U1A3K2tuSEQ4ZW1rRU9QbkM3OE1aVExOUHQvenBQTS9rb295MzVLWTZOelhT?=
 =?utf-8?B?UHlzNDhOVUlZeExFWU0ydnBpYiswSFlockhRbzVabGwvY05WZ2hqVEVYcUdP?=
 =?utf-8?B?anZHaUtzbUJUamkvdlUrLzE2YUp0SERsbVZQMjRYbEp0MklubHlSZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f0afa7-18eb-4bb8-1f24-08dee2698c99
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 12:06:49.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b4GZyER8R+I+HRddQdAI0rO6Tjq4jDIZ7fAxod25gibOnBd7Ijp/c3qwDJAqL4F08VjH/NoHWfk35yIL6XXPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9717
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12547-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Devendra.Verma@amd.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:from_mime,amd.com:mid,amd.com:email,amd.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDF7575E04A


On 13-Jul-26 12:37, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] The DesignWare PCIe controller frontend fails initialization for platforms attempting to use 64 HDMA channels due to hardcoded legacy channel limits.
> - [Medium] The dw-edma-pcie endpoint driver silently caps dynamically detected channel counts to 8.
> 
> Pre-existing issues:
> - [High] A race condition during initialization causes a guaranteed NULL pointer dereference if a shared or spurious interrupt occurs early.
> - [High] Incorrect argument order in dw_hdma_v0_core_ch_status leads to invalid register reads, breaking DMA status reporting.
> --
> 
> --- Patch [1]: [PATCH v8] dmaengine: dw-edma: Enable HDMA 64R/W Channels ---
> commit 639271379db4829feeac5972fb5074c44780d440
> Author: Devendra K Verma <devendra.verma@amd.com>
> 
> dmaengine: dw-edma: Enable HDMA 64R/W Channels
> 
> This patch introduces support for up to 64 read and write channels in the
> DesignWare HDMA controller. It defines new macros for HDMA maximum channel
> counts, updates data structures, and transitions bitmasks to 64-bit bitmaps
> to accommodate the expanded channel limits.
> 
>> Changes in v3:
>>    o Reverted the FIX for AI reported GET_CH_32() issue, as
>>      per the recommendation of reviewers, need to create
>>      separate patch for it.
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the incorrect argument
> order in dw_hdma_v0_core_ch_status() still lead to invalid register reads?
> 
> When the DMA status is checked, dw_hdma_v0_core_ch_status() calls GET_CH_32()
> with the channel ID and direction swapped:
> 
>      tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
>              GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> 
> The macro evaluates the numeric channel ID as the direction and uses the
> direction as the channel index, which breaks DMA status reporting.
> 
>> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
>> --- a/drivers/dma/dw-edma/dw-edma-core.c
>> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> [ ... ]
>> @@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>>   		irq = &dw->irq[pos];
>>   
>>   		if (chan->dir == EDMA_DIR_WRITE)
>> -			irq->wr_mask |= BIT(chan->id);
>> +			bitmap_set(irq->wr_mask, chan->id, 1);
>>   		else
>> -			irq->rd_mask |= BIT(chan->id);
>> +			bitmap_set(irq->rd_mask, chan->id, 1);
>>   
>>   		irq->dw = dw;
> 
> [Severity: High]
> This is a pre-existing issue, but does this initialization sequence leave a
> race condition that causes a NULL pointer dereference if a shared interrupt
> fires early?
> 
> In dw_edma_probe(), dw_edma_irq_request() calls request_irq() with IRQF_SHARED
> while dw->irq[i].dw is still NULL.
> 
> If an interrupt fires immediately after registration,
> dw_edma_interrupt_common() executes and dereferences dw_irq->dw to call
> dw->core->handle_int. This will dereference the NULL pointer before
> dw_edma_channel_setup() finishes initialization here.
> 

This is a new issue and shall be taken in a separate patch series.

>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>> @@ -62,11 +62,11 @@ struct dw_edma_pcie_data {
>>   	/* eDMA registers location */
>>   	struct dw_edma_block		rg;
>>   	/* eDMA memory linked list location */
>> -	struct dw_edma_block		ll_wr[EDMA_MAX_WR_CH];
>> -	struct dw_edma_block		ll_rd[EDMA_MAX_RD_CH];
>> +	struct dw_edma_block		ll_wr[HDMA_MAX_WR_CH];
>> +	struct dw_edma_block		ll_rd[HDMA_MAX_RD_CH];
> 
> [Severity: Medium]
> Does the dw-edma-pcie endpoint driver silently cap dynamically detected
> channel counts to 8, defeating the purpose of the 64-channel support?
> 
> During probe, dw_edma_pcie_get_xilinx_dma_data() reads the channel count from
> the hardware VSEC but caps it using the static template limit:
> 
>      pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>                         FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> 
> Since pdata is initialized from xilinx_mdb_data which statically defines a
> maximum of 8 channels, the dynamically read channel count is bounded and
> will never exceed 8.

The Xilinx MDB only supports 8 Read / 8 Write channels. Enhancing the
support for 64 R/W channels will not cause any issue here. The capping
specifically for the IPs which support only 8 R/W channels is good thing
to do here.

> 
>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
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
> Will the DesignWare PCIe controller frontend fail initialization with -EINVAL
> for platforms attempting to use 64 HDMA channels?
> 
> When an HDMA platform is probed, dw_pcie_edma_find_channels() in
> drivers/pci/controller/dwc/pcie-designware.c still uses the legacy
> EDMA_MAX_WR_CH limit:
> 
>      if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
>          !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
>          return -EINVAL;
> 

This specific function is implemented for non-HDMA IPs. Having support
for 64 R/W channels for HDMA will not affect any of the above.

> Additionally, dw_pcie_edma_irq_vector() rejects requested IRQ numbers
> that are greater than the legacy maximums:
> 
>      if (nr >= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
>          return -EINVAL;
> 
> This artificial cap at 16 seems insufficient for platforms using the new
> 64-channel support.
> 

Though, the irqs allocated by the number of channels, this change will
not affect any functionality. This is a new issue and shall be addressed
in new patch series.

-Devendra

