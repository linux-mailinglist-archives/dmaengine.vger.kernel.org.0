Return-Path: <dmaengine+bounces-12257-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O2h/OurDT2oyoAIAu9opvQ
	(envelope-from <dmaengine+bounces-12257-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:53:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A969733238
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:53:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=kRPQM05N;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12257-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12257-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3292730E25A7
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5480A13A86C;
	Thu,  9 Jul 2026 15:48:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922724192EB
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 15:48:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612109; cv=fail; b=ND4pBV5s81rrRR0xG5wp/ujHbP1s5tQmksHxZpRZcbZk36YavvHg7XBL13oXZnrq0mVLGwdYCMRfQeqSqqS+kdxak3hbmD3m0EUd+1OkU6SeeX/vnulhE4RovhqSwFbIZaN0yHz662YqDFcw7npAstU/fTOt/fVBIO12vp/RANo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612109; c=relaxed/simple;
	bh=wLPqgJhnlq/mwOs1POiITqiI1gdh+0gizBTiyUF3bFc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGBq7NlhTo5usnzR16wlFzud+g9PkGanepklofgeBZLGpWw6UsVNTa7vrX/qt/hZu4AEMzrZzODlOXaCp5A7ZXQSHF7eUSTBcYvh9mIQtHytE+N/CJmNM5GwDocWZ3WBDXMv1NpF37PAboF3IJ01h9msG4ARffPhb41G17cUNSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kRPQM05N; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRLNBrIFIdz1GNKtKNfchaybVwOHq7Q/Vkwl6MhYtgWivi3iZgKKht2mJNeEMPvmmqn8Gya2YTm5TaFMf+3YDO/oM2PV0oDt9gTy391OzV9ypZBY/R2NyJAzgzjnUPxXtrN9c9yZ+OqSi0o2+i7S6GERD2U1LgFhsiVI0PmnMUSvX627IM9y7esA3kwqx30vW/w91CKP+ZFqzBPBjFak4SqH946RxQf62oSA2XA9eGOVofMmdgl6g1CNPBuwVXUJ4WU0ErZCxitF8V4qVfGXI2JAIp5REltgB2RlzVTCf0wgiqBeeZRNTeDrJv0ySN6s+Vhpp+1hyxuMv5AcIwcS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQoOIOApnGn5U2mXs82psmOS/oyOJQyD5nm5+MaQ2OM=;
 b=WmB68PHmV2Ie7kbZ04Vo4c8HKowBpyIxNBXhvhDfWssvC31sWL8RtWWWhNQHmtn82rBNkV/nBOQBKH4lIbIil3og3Rkuf6a6LGLTOcs4JX3cU5zeXhh5p+izA6vVba5/AsSQp6FkA2NHdBM1hrrgcc0vPrT27EUdSI/uSj7IMIGUoNi1efxMpJDAgXMpkklzeYibQ4NQRHKhv9kwsQq36egAlFVcAjdE8JM7hj7wbYJ50NxjRSRpOuHa7e5PJFbhOpRAwslwn5mn+nesKdNPZCmf6r+PFAgsDBq2CraoDA2tI/pis5gp9zN5ccgHC2OL0c2bYLiizJrOp6gg6ZC+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQoOIOApnGn5U2mXs82psmOS/oyOJQyD5nm5+MaQ2OM=;
 b=kRPQM05NiJ9xck64/X94pr7ifSFyYciZmqsPM6uDLvqavuTWfjocUGMdhMh2t6/C6lC62oaMSvDi031QG+Cl2UP5RlFORmAp6rEQg18JNQ+PLFDFrELLZuU9YIk/KwyjddwYPuqkv7VEgSXyBBTquxoK/0weKxJlG2CZc8/QaNI=
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Thu, 9 Jul
 2026 15:48:13 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 15:48:13 +0000
Message-ID: <354c4e2c-bf6f-4f32-9f30-a5ca2463cdca@amd.com>
Date: Thu, 9 Jul 2026 21:18:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/4] dmaengine: xilinx_dma: Move descriptors to done
 list based on completion bit
To: sashiko-reviews@lists.linux.dev, Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20260708100652.603074-1-srinivas.neeli@amd.com>
 <20260708100652.603074-3-srinivas.neeli@amd.com>
 <20260709101123.F2F9E1F00A3D@smtp.kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <20260709101123.F2F9E1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::10) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d03a47-08a2-4878-7a2c-08deddd17bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|5023799004|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	cqc1VG/EoayhARYbL/5XPo5DvZ1oAsCL+tUyNtcsnzrHyKH7K/T7wa4dfk0wYtbZA0l8iCfebV4hQJctcnUu3UqyH7F1507BCA/vyZjl8PMSmmdWwuvVIrUXvkdCuiZbE6gy2OefaJq7MIIHrDpHWmmvhLMbXo8gKT3ckkPPgaWP6mIk+rUgiYsm0ixntBHcXX6lEMyFaV0IOHqN9RNHAkhEVT8Qb1DR49jtOmq8LgewdN7Vf/Ol00VmlWOOwKX7HskDcGICkxck6f1G/78CHoI0IwcLP6zsBqScLAT7IOQwXNsrAoUGViJ/vSFZJR0Ug5Cjvk/x4bN2vQwkUUkhiJZAoQjv5MqAB7xgzb59CNiyljR1Jb2NopRJvUli8OivAlFDHM4C1e3DZxH8lNtKuO8kC/w6WyEs6tahN0cRyxLTVGLjlouzCMPQEGrUxCejTD3uLkdlPh19iUCgicXR6wr6KP1jvMa3uDcvu4Qqry+EZPxZct8fgNsigX8Tvk7wCrnxZTxgFAmgnOoPDLjcC4l+716oTZoArHhoRU2kkCCsmMGQzNBwNs03BSo1GR0hFcR46rOOJFKQuPWYNnGY1Qrf26XEQ9n8H9CafpgMoOrQc7RoJvfDRY/NCJO3EwNw4x/jevop2rXSN6v1aMciYHyRFygoobw8//4nUsc2krU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUpIMHd5U0tmKzRrRE84L2hQSjdCbG1OTEZLU3U4V3dleEtxWExabkhudUM5?=
 =?utf-8?B?dDZXYUR5Z0NoMHFNLzhDMThMU3I5Slg4RUtob3llTXRWVXlRNTJjMFh4dTFu?=
 =?utf-8?B?SFN5MFBpTjNiUnI1M3ZDQXlLU2pKOGFmZk5MUXVFRkZ5U3czV3I5MUtoT3Nq?=
 =?utf-8?B?dVFkbS9va1UvVVZZcXFWbnkwWWxzaGtLN1NDOWp0UWU5TVhUS3A4M1paaTVF?=
 =?utf-8?B?NG5TdTFwWkZCb1VmbElqZW03WE5UUVhwRjlvamF1UHBEWUt2Q2pBei9XcFlh?=
 =?utf-8?B?WVowYm5DNS9HeW1LUGR2aXdNS1o0L3daelRmcE9uMjJWWHBpZlFOQ1h3K3V2?=
 =?utf-8?B?ZldGcGJUdWZ4aFdjL20reHVxWVp4ZnFKRFkwOFl2WUcxMDZySjY5dlNIT2t0?=
 =?utf-8?B?ZVM4K3FvalZCUXdWa2VFK2ZZYVBFOUNSN3hPSGhOM1pLODNxYTBGWjRPN3Bu?=
 =?utf-8?B?UGhpdGR3dzJnaXN6RmJLYy9VMm1JY0Q2VVYrSXNtaXB3b2lEUTRrMTRlS2hO?=
 =?utf-8?B?QmUxSTVqQlJiY1Z0VjVJZlc4UWFaZXpidzdVcWFZUkVxRmk0QUZ5bEd1TG95?=
 =?utf-8?B?RVJzNm9IRVVXVlZGbU1MUE9pUW1CdEYzSTVCcFQxN0kvRDRvWU5NTHg0Yk1C?=
 =?utf-8?B?UGIvdURDZHZkdmE2bWlFdG80SS8vQnJIUEFEZVR2YUo1dnFnM1pXcTV5Z2t0?=
 =?utf-8?B?TFArejF0cFR6bmlxYWpwMGRzRU5QdDNCUE5CaWNFUXFMajlVYUl1YUwrM2lC?=
 =?utf-8?B?WW1iM05LNlFWR3ZRcFVoMXZ1RXM4UG9WWW15UXJhTngvMEJaM0hicFFrUFV5?=
 =?utf-8?B?aHhPQm1taG45WVFSWTlLOTVMZDVGblNJUkRJS1hrWUVBQTJHUm8zOEtkY1cx?=
 =?utf-8?B?SHBqcm9JZy9qUlJjRkhMMjFPd1VNdTNkY1BUTFF0TDkwbmFFVGlkekRBV2xy?=
 =?utf-8?B?Wm1naTBFY2ZnVVJvdkRLUzNBcklKL3gxZFF5eTJTbXY0UmUyeUp3aGpOZkVr?=
 =?utf-8?B?dkNlVG5IM1Y2OE1UUEhnMHozTUh2Tmg4NHpvb3hHUHh2Y2loaDkwS2xhendB?=
 =?utf-8?B?VzN0SFM5ZmtFSGNpWXlTMFVGb0piRHFrZFZ0OVFCWEUrbHl5TldwbndENXRB?=
 =?utf-8?B?eExjd1hoemFtMXdUeThaTkpxd2oxeWFZcjJFRjBUVnlnZUdaQ2dZNmxDbnl1?=
 =?utf-8?B?dDE3UUUwNWZhSTJwVkpQQTcwSVNoTzFWRFpWZzNWaDB2RHhIdlNVd05aVjJC?=
 =?utf-8?B?VWora0VGbTZaQ2x3MWp3dlFsQzh5VTdpTVZpYkY5RmVRdEx4dzlEM3BRMi9N?=
 =?utf-8?B?bVdqaTZPK1M1dmFTRE1ZNkt0MzFBM2tnclVPbXVyUHc1MVAxNklEQzBNY29t?=
 =?utf-8?B?NDJadHdDQytxMjNvZ2ZHQWlXUFFreDdtSll5RDFLWkQwK2lRaGE2SXo2NFo1?=
 =?utf-8?B?My9hYzR2MXR6QUtvK00xdFl3UTgvR2J4MjVMc3AxY1NWNVZsQWhMcFRjK214?=
 =?utf-8?B?SWFvSmlka25TVEpxUEJtZWNaTUluSktMWGNDREo0c1FodHhwSTFrSlNDZXJC?=
 =?utf-8?B?NTVWVXE3SGwxWkk2VG0wc0FkbFIyMzRuV1lIUTUrakU5cjBleWhaWEZyRVhH?=
 =?utf-8?B?aUpPR09VVUZ5cDg5Z3JqSFlhZ05ad2poQks5ZnNSaWRrbExOcUJKNlhMYWli?=
 =?utf-8?B?bWt1MVAwK1RqckRzK2FBd1JuQ2x5V2U0K3ZpQTJEckcrTlpaRGFPWGpoczB1?=
 =?utf-8?B?ZEdPMmcxV3llckVwNmlZODVPamlBcW5IRVpaOEpROHZsS2FKQkJ0SUxYMU11?=
 =?utf-8?B?Q3p0cCtPaGt0bmZKMk8yMW9SSGxXNFhVZEhsZ1hRN21LaGJncUVKU3h4MVp6?=
 =?utf-8?B?bTgvRU1IaVdWWjZZV1RhaDUwYU9wRFBHeVI5NE1KWlhNSG1ET0o1R1R1WG55?=
 =?utf-8?B?N3NsM0lWOHR3R2RkT2dSZktpeUVqY0FVTDBqMXUzWGJpSW4veDNYUVRLd3F3?=
 =?utf-8?B?MjFTeVFYS05YWTBjY1VYOTRFZkdEblZENGlMSE1pV2dhSTlKeUcwVkVCdEta?=
 =?utf-8?B?bDMxOGlMenVFUkZiY3ZSSEVXV0pMNVozc2l5dEtOeU1PMGE3S25rbHlDSXNu?=
 =?utf-8?B?dHNEYVovS2pMVFFqazZ2V3kyNS9iUGVwbGlzZklBVkErbjh3QUZ5bFVvUE9E?=
 =?utf-8?B?dDRJRGJ0N2JVUm05YVVXVGQvaGRlTjNVeFQ0TmJxbWJYUHIxY0xsNEJsNU5V?=
 =?utf-8?B?bG5wakpjcElVVDcxN1BhV1VZMDcwbkNXR09NTVNxMWFHNm9LSjZlSnIvb0NT?=
 =?utf-8?Q?seISAy9l8jN5AvgmF/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d03a47-08a2-4878-7a2c-08deddd17bff
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:48:13.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xm1DcgyOpgGkLCQWaULoeoZb9ueQRskYb9KwDjpl5LMMzH51PrRZoqQSv25B210/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
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
	TAGGED_FROM(0.00)[bounces-12257-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:srinivas.neeli@amd.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A969733238

hi,

On 7/9/2026 3:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Software state mismatch leading to hardware corruption and channel hang in AXI MCDMA.
> - [Medium] Missing read memory barrier (`dma_rmb()`) after checking the DMA completion flag in coherent memory.
> --
>
> --- Patch [2]: [PATCH V3 2/4] dmaengine: xilinx_dma: Move descriptors to done list based on completion bit ---
> commit d59255ad1a6d4a4beb643022da1f9820716a0752
> Author: Srinivas Neeli <srinivas.neeli@amd.com>
>
> dmaengine: xilinx_dma: Move descriptors to done list based on completion bit
>
> In AXI MCDMA scatter-gather mode, xilinx_dma_complete_descriptor() previously
> moved all active descriptors to the done list unconditionally. This commit adds
> a check for the descriptor completion bit before moving entries, handling
> scenarios where interrupt coalescing causes interrupts before all queued
> descriptors are processed.
>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index 965fb69a2a3ad..9b8b6f1acd4ea 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -1773,6 +1773,17 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
>>   					      struct xilinx_axidma_tx_segment, node);
>>   			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
>>   				break;
>> +		} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
>> +			struct xilinx_aximcdma_tx_segment *seg;
>> +			u32 status;
>> +
>> +			seg = list_last_entry(&desc->segments,
>> +					      struct xilinx_aximcdma_tx_segment,
>> +					      node);
>> +			status = (chan->direction == DMA_DEV_TO_MEM) ?
>> +				seg->hw.s2mm_status : seg->hw.mm2s_status;
>> +			if (!(status & XILINX_DMA_BD_COMP_MASK))
> [Severity: Medium]
> Is a read memory barrier needed after checking this completion status?
>
> The CPU polls the s2mm_status or mm2s_status field in coherent memory to
> check the completion bit. Without a dma_rmb() here, could weakly ordered
> architectures speculatively execute subsequent descriptor reads out of
> order?
>
> This might result in stale reads of the descriptor fields later on
> (for instance, during residue calculation) before the hardware has
> actually confirmed completion.

The MCDMA descriptors are allocated using dma_alloc_coherent(), which 
provides cache-coherent memory between CPU and device.

On coherent DMA memory, the CPU sees device writes without requiring 
explicit barriers, so dma_rmb() is not needed here.

>> +				break;
> [Severity: High]
> Does breaking out early here create a state mismatch with the IRQ handler?
>
> If this check breaks out leaving descriptors in the active list, the
> channel is technically still running. However, looking at the call chain,
> xilinx_mcdma_irq_handler() immediately forces the channel idle and
> starts a new transfer:
>
> xilinx_mcdma_irq_handler() {
>      ...
>      xilinx_dma_complete_descriptor(chan);
>      chan->idle = true;
>      chan->start_transfer(chan);
>      ...
> }
>
> This appears to bypass the idle safety check in
> xilinx_mcdma_start_transfer() and overwrite the CDESC hardware register
> while the DMA engine is actively processing the remaining active list.
> Could this software-splice new descriptors without establishing hardware
> links, leading to a permanent channel hang?
I believe this analysis was run against an older version of the driver. 
The list_empty() guard was added in a recent patch series:
https://lore.kernel.org/all/20260626092656.1563871-1-suraj.gupta2@amd.com/

   The current code in xilinx_mcdma_irq_handler() has this protection:

   xilinx_dma_complete_descriptor(chan);
   if (list_empty(&chan->active_list)) {
       chan->idle = true;
       chan->start_transfer(chan);
   }
When the completion check breaks early (leaving incomplete descriptors 
in active_list), the list won't be empty, so neither chan->idle = true 
nor start_transfer() will execute. The hardware state remains consistent.

Thanks
Neeli Srinivas

>
>> +		}
>>   		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
>>   		    XDMA_TYPE_VDMA)
> [ ... ]
>

