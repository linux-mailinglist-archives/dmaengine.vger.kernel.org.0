Return-Path: <dmaengine+bounces-11760-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SjfuAsnUOmpXIAgAu9opvQ
	(envelope-from <dmaengine+bounces-11760-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 20:47:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2126B981C
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 20:47:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=G47rcMvD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11760-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11760-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5205D301ABB6
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDD733121C;
	Tue, 23 Jun 2026 18:47:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93B2DF15C
	for <dmaengine@vger.kernel.org>; Tue, 23 Jun 2026 18:47:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240454; cv=fail; b=UqxEe+tDFMeaIosGqVHSQq/9qKxy+dSD7cY8JSGHc+FTEJ5woaLnIkvQl/oSjg+kp4mG/qmG1oCTvXBfl7vlIoal5ZFAB9lKJsFHJ0GG4qzi6ALgrzultqLfx9tYEzfmAnq8/pvCZLPPYx921FgvpI3gTfPCqqjWhxaeeXdBT9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240454; c=relaxed/simple;
	bh=FaueBCq8JLG98i1J1OMOvECLzero2Vu+VlzgnVtWT60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EClDoTswhwcb0CXz42R+Tws9iQCIqqPf5+v66doVtVN6BkolO5A7QVEJgRRM+UGQjt7iFyYEsbMbLU3QiR7lnRsfsni/F5XhFdr68fnZYmR8dCXsnih2JC/P0NGxcHJuclp7rremDG1LWo3k4ehzVMcoDOmq3SAEL22NjvrGe+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G47rcMvD; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDOqb7qdFwGIVrqzj/kn9YKGcWMGm0oUesPQt3VOfqK/hg9iMiTMxgLHJVUHxpDNQPJZ4lG2DVKRnIZdXx56JwK9FOMg1H/Iv0Pl+BqkNpbCr0CmfNuKf+619vBEutycKWayAMV21PpW5a/SvnVCk/0NTd1TqnjjIjcV2cIMc0LcWuxeAjJi8oNQZioxOMH0uCKLstDwRcHE16zOh1LuT7xgr7pC2CqjsidArtXdhI8UKd5kCXECMlckgBwa2sHN4SCNBPZDuVfSYVZvql6IY06+o1egyyQjvtOSGvQRobxu0mNQ/qzlalXX1mUM/3q3o9zgPn6F1h8PVu8ex5mkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVl7juI87FMKjT9aQgIFeSkJqrLt0wps76nrNk7tcsg=;
 b=YOjVIYGBtNTfzGxK2kHLLDjPQx9tbES7ckglAXWO0NrrgDbdx03oxgzICbxK5XTQp+ldCPxbrZhYGk+tqgqvDnJFsFMfUxn56YJVGgo4ll/VqDeU57VA5TEebz2YWZNsX99sMoLucrlut/i7YLgfuOqyCvgNNBZIgh0ZymyOP2zODnijm+B5Danj+GIDPcMnBwuSCZF9OpeQUM0bSkBbU3xyMjNEeRJZsGxyhl+8A4y4PFS8JPGn5uVseNDZtQpzu+se76F9yYj8eRkZA8/hl5wqXUK0EvNc5otTc9fuVrV3/fXWyhLxYRbUfktOnzthGmGTibOjzPgdcslp9TcHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVl7juI87FMKjT9aQgIFeSkJqrLt0wps76nrNk7tcsg=;
 b=G47rcMvDiGlZyXTR9iIt3c4W3f8Blmx4kVwUatd5JT4dvFUSPQAgfg1RS6cmhnUcanU02SXtGae4d+kxreERujCfnqOlV6ktg5iRQpROsd0Z1tswHjZLgvc9BUrHDOCP37TroSxRoCZacyIUWK7CkAgSllAtnXBWesflD1OXHyc=
Received: from SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13)
 by PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 18:47:29 +0000
Received: from SJ0PR12MB6807.namprd12.prod.outlook.com
 ([fe80::9b22:6b26:982:abd0]) by SJ0PR12MB6807.namprd12.prod.outlook.com
 ([fe80::9b22:6b26:982:abd0%5]) with mapi id 15.21.0113.015; Tue, 23 Jun 2026
 18:47:28 +0000
Message-ID: <0f00a643-8aa0-48c0-b6e8-d1956e623cc4@amd.com>
Date: Wed, 24 Jun 2026 00:16:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/3] dmaengine: xilinx_dma: Enable transfer
 chaining for AXIDMA and MCDMA by removing idle restriction
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
References: <20260620203417.4000360-1-suraj.gupta2@amd.com>
 <20260620203417.4000360-3-suraj.gupta2@amd.com>
 <20260620204738.462EE1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <20260620204738.462EE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::31) To SJ0PR12MB6807.namprd12.prod.outlook.com
 (2603:10b6:a03:479::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6807:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5da640-bfcc-43f8-4a11-08ded157e00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wol6AiTjVUJAnwxgKIIxrOeotUC+arMu8F/e2OMajM/OSEGLa+azOZqiZ0YOGlEl3X0la14XXaxcz3sBZIfMZgcCn3sI7PQxEaGngrqgk/pmFNs8By4Tp7DqcQ7rC7ig7cgNXxAXZTZayNlE3D2Yq9fHONKsgkV8rtsnN6030JzQz5jpwBvYuwgfsVPsLI1Bt8LkwlER2LD+KuUMKzh1A9lGnRoPuo8p8i4FMluhO/HPUgtg35RRN0I8PnVrQeG8T8u5KVHQvGxNjBbMmO7R7GIPwGkO4E7EDJKlkv/j4sPKG/lB5SwpOnjw1dtOFUnM2CgQPv7EqZHB7XH1FK36Rka9XobR3EAnKesJIjm2H6cUt9e4lj6nlEokzGmdimk535PecNdKXHtK6icsd2wJcgDhwPAEytwEy1DOhBXqeezlO4o5BDv7Rx+Gw/ST4dHPQAkW9uDVK+8sRdJMr435jxh7PuZd/Wg8Di1jM+97sheQ5rrttS4VjhMAXcbjuSi/R2/N67ZpBQwe6nY7NH1vKckuoBHikQ5JIcfIjRHCdSfMxfc4LZxetEgiCCirk2r4IBXqjOuj7G5fGwQPA5JptKX9ot556ikBnl/WnORLkzwierRLTexbsEm2gL/Ml1nRZN5iylC7h6HZXMsgWAgGWVwNW9x64+7PRtzT4AxHNvE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6807.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEc5SzZ6em1lbHErVWNCOGZBZUxvWE1rT3o0b29WcENDS3A2ZGl2cmlRb0VX?=
 =?utf-8?B?VmJublJQQy9zdUtIckFDRVRlQVJjakNPS2VvMERFajg5Q3hpekRZcDcyU2pp?=
 =?utf-8?B?TWI4Tk1CUEt3UkhwSGw4Y2NkT0pCQTc3M0JpNVBYWU1Da3JpWlNlKzVMMGJi?=
 =?utf-8?B?ZU41eXovdnQ3UzZzOXpIL0ZIbFFGR3NpTUJkNnd5aHZMWS8wLzljamN3NU93?=
 =?utf-8?B?Mit5aC9MbkliMFdtNmtIcUp1cVJDbEtqcy9HcFo4ZzNrOWlFL2pqeFVrc2Y5?=
 =?utf-8?B?UmJGVHViOHFEb2RDNWJKcjdIc2l4Rnk2bTBjaVNYcWhGdHpiLzgxSVpLVW03?=
 =?utf-8?B?TmFtYVlpMkdINU9WcGc1NGh2MVR4L0Z4MThyczJpckdpZlpDVFM2OWFlVnJn?=
 =?utf-8?B?b1hkTlRodkIycTMvYmg3NE9SOVFhT0pXN1pjS0UxV05nMGpFWWdCNS94TVdj?=
 =?utf-8?B?a2l6c1hPQkZTVjkyWHA5QVRMSXdxRy9DOUxiUWl4UE9LRldZdEpOK0pFR0tU?=
 =?utf-8?B?WmJGVFZqS0dwbGgxU1FmNVhyMWxZZ2tTclEwVzlKM09kbWFGalVXQ2V4Vzhx?=
 =?utf-8?B?TFVacWVMckp6VWhnVHo0Y0RTbnVCYmI0RmVyczRVZldaZkRuUTRCbVlDUllF?=
 =?utf-8?B?VDdPMU91ckh6WTlSNjRiT0t3OTJYRjZ1cUtBOERBWXF4Mjdnb2twMWNhQ2hy?=
 =?utf-8?B?Q2RRdkxYSVhVcXNUcjNOKzVINTI3Nk94UnEzbVgrWDIwVDlGSk10S0YzUGZY?=
 =?utf-8?B?NzhicVhpaHoxbyt3Q2s5V05RQ0pWRXRscGgzU2ljMEV6dzJzc21pYmkwNkFQ?=
 =?utf-8?B?bkZ2TGRLc1ZCeXNMRVZZS1M3NEk4aHQvaWpGR3ZieGZpQ1Z4c3RHR05senRw?=
 =?utf-8?B?ZGVpci9IS0ZVNDNUb2pVOGNva21iRmZZakdOdkFKVUdITTgxanlqeVJaZklq?=
 =?utf-8?B?Nkk0QU00b1NXeHd6VmNhM0VVTWM5RDc1Q2h0QXplTE41K0pzbUoxc2J5OS9K?=
 =?utf-8?B?WFpuV3ZEQWlDQXpyb2ludTk3dFJ3ZUQ1QnlVbU5mOGtvb0hYZFR4aWp3Nzkw?=
 =?utf-8?B?NVgxNjBGc0NxYjhCUWRyT3N0dEozQ3hPOHJRM1czdm5BaWhiNTNKK1dxZ1ZW?=
 =?utf-8?B?WWlpZTltdURWQnZNTEk1MzFZc1padEo1MzcvVnpGZFFmM24yYVVrZTcwZDky?=
 =?utf-8?B?UnVXTFRsY2hpcVBISlladXJWQWlCZjFYS3phQ3l2ZXJ1MEU4N1Z5SzlxVy9s?=
 =?utf-8?B?VHpRMGZZcmtPa0M3SXBMRThJSmpEYWJnZ01pcWgzNnZFVWo4dzNodFVFU05t?=
 =?utf-8?B?ZStWbXJjd0JSTjAxQVlNdUJZOElsMXNiNmxwSlJNejdKa0pnZ3lYVDhpSGhV?=
 =?utf-8?B?VU1aZ0hJc3pJYWJRM2xFNUFEUDlBM3R6TEgxYnZjbnNnSlE5V0dkRnBMcHRM?=
 =?utf-8?B?cERKZ2gwaHV2REs1dURHTGxjazJVczV3d1k3aDZtOURBS0Zrcm5adWM0RmZx?=
 =?utf-8?B?Y1VPczVIR1JBbG83bFYzam93NjJNTmZ2WTlUNUJPZXN1WWVrWGFRWEVDZHFQ?=
 =?utf-8?B?NmZGSDV2dWRqV3pMY1hYVFcyKzRaajdSNENzcW5HaXVFdEtXM2l2UWQzVUhk?=
 =?utf-8?B?UTQ3bERQVHR4cEZFS2JFYmFVY2tZMWVrd1IrdkhKaDB6SWhuUnNkZDFRYTUz?=
 =?utf-8?B?UHNNUmdRWis2Mjh3VThJT3JHNVpINFBhb0lLSkRYQ0JGeVZ2dGIzN3F2ckVD?=
 =?utf-8?B?OUNMak1LeTJNQy9hVWxkYjhhRXBVd3BNVUd6S2JJaUQyMFY5SEl0USs1NzVS?=
 =?utf-8?B?NzJGaTJ1QitRcmU0RDhIZ1dtOHhSY3ljQk91WE1MRW43dzZFNldEU0JiNFk3?=
 =?utf-8?B?ZXpSWm1qQ1RncElUdzJ1Ly85TEw1aXE0NTlJcXhIOTV2N0hQUVd6MC9MQWhn?=
 =?utf-8?B?T2FvbkhnZDVQdUVwZ1BiYTRnR2ZRVHVhckdQdEQwVWZFWURwNTlHRVI5QlJW?=
 =?utf-8?B?ZUlBMEdHWENsK012NnpsbmNRQWxTeitPMG5mWXZqWDg5ck1wZXZMWFZOK21a?=
 =?utf-8?B?ZUJCUjAzSW8vMzNYZ0ZEb3JUL2ZqMElDMHdGQ3VQdEJHMEJldmlsNDRCUE5J?=
 =?utf-8?B?MFRLSUpkekFMTUR0TnhsTm9kSjlhYWZiNUFuWk9tWGxkVXlxblplcnVoRHFy?=
 =?utf-8?B?TzBuclAyN3hYMC9FUEUrZWNuQ3IwTmdzMEl0YTJmRVdBdWZ4UGVyeW42bGk2?=
 =?utf-8?B?N0pnRisxRElya3FoMm5YbWZhUXBWZVBmMktyUGZoR1RlZUhxTCtBOE1pRWl1?=
 =?utf-8?B?TnVGSHdhYUNDUVlYd1A5OWhrb1NmRTlFdFN4NklmZk5vNHVFVVZDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5da640-bfcc-43f8-4a11-08ded157e00d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 18:47:28.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWuBXOrSzC0DJUH0N7eQHem4+Yrhf1m1RfUuyJT56XKPpkiRgMD/ETAnwDjeVa0szQDY1QnGLMOjobsl6oPprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11760-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A2126B981C



On 6/21/2026 2:17 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] Removing the channel idle check unconditionally overwrites hardware registers in Direct (non-SG) mode, corrupting active transfers.
> - [Critical] Appending new transfers to a running Scatter-Gather chain breaks the hardware descriptor chain, as new descriptors are never physically linked in memory.
> - [High] Updating the interrupt coalesce threshold while the channel is active uses a partial descriptor count, disrupting interrupt generation.
> --
> 
> commit 59ccde00ae0d672019658b79ee8d2055ebb8fa7a
> Author: Suraj Gupta <suraj.gupta2@amd.com>
> 
> dmaengine: xilinx_dma: Enable transfer chaining for AXIDMA and MCDMA by removing idle restriction
> 
> This commit removes the idle check in xilinx_dma_start_transfer() and
> xilinx_mcdma_start_transfer() to allow queuing new transfers while the
> channel is busy. It also updates the CURDESC register only when the active
> list is empty in scatter-gather mode, relying on the hardware tail pointer
> extension mechanism to handle chaining.
> 
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index ca396b7097427..35b553ee3205c 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -1580,9 +1580,6 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>>   		return;
>>   	}
>>   
>> -	if (!chan->idle)
>> -		return;
>> -
> 
> [Severity: Critical]
> Does removing this early return cause active transfers to be corrupted in
> Direct (non-SG) mode?
> 
> Without the idle check, xilinx_dma_start_transfer() can proceed while a
> transfer is running. In Direct DMA mode (has_sg is false), the code falls
> through and executes:
> 
>      xilinx_write(chan, XILINX_DMA_REG_SRCDSTADDR,
>                   xilinx_prep_dma_addr_t(hw->buf_addr));
> 
>      dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
>                     hw->control & chan->xdev->max_buffer_len);
> 
> Could this unconditionally overwrite the active hardware registers if a
> transfer is already in progress?
> 
> Additionally, moving the newly queued descriptor into active_list appears to
> cause xilinx_dma_complete_descriptor() to prematurely complete newly appended
> descriptors, because the loop break condition is skipped for non-SG mode:
> 
>      if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
>          break;
> 

Agreed, I'll restrict the idle removal to the has_sg path (and keep 
direct-mode transfers serialized as before) in next version.
> [Severity: Critical]
> Can appending new transfers to a running Scatter-Gather chain break the
> hardware descriptor chain?
> 
> When the idle check is removed, we update the TAILDESC register to append
> transfers on-the-fly. However, the Xilinx AXI DMA engine requires SG
> descriptors to be physically linked in memory via their next_desc pointers.
> 
> In the driver, descriptor linking occurs in append_desc_queue():
> 
>      if (list_empty(&chan->pending_list))
>          goto append;
>      ...
>      tail_desc = list_last_entry(&chan->pending_list, ...);
> 
> Since start_transfer() moves all queued descriptors to chan->active_list and
> leaves pending_list empty, a subsequent submission will find an empty
> pending_list.
> 
> Will this cause it to skip linking its next_desc pointer to the tail of the
> actively running descriptor chain in active_list?
> 
> When the DMA engine reaches the end of the original active chain, it might
> follow a stale next_desc pointer instead of the physically unlinked new
> descriptors.


I don't think this holds for the AXIDMA/MCDMA SG case -- the BD segments 
are kept permanently chained in coherent memory.

In xilinx_dma_alloc_chan_resources() every segment in the pool is wired 
into a fixed circular next_desc chain at allocation time:
       for (i = 0; i < XILINX_DMA_NUM_DESCS; i++) {
           chan->seg_v[i].hw.next_desc =
           lower_32_bits(chan->seg_p + sizeof(*chan->seg_v) *
               ((i + 1) % XILINX_DMA_NUM_DESCS));
           chan->seg_v[i].hw.next_desc_msb =
           upper_32_bits(chan->seg_p + sizeof(*chan->seg_v) *
               ((i + 1) % XILINX_DMA_NUM_DESCS));
           ...
       }
i.e. seg[i].next_desc -> seg[(i+1) % N], a closed ring (same for the 
MCDMA seg_mv pool). These links are never torn down: when a segment is 
recycled, xilinx_dma_clean_hw_desc() zeroes the BD but explicitly 
preserves next_desc/next_desc_msb:
       u32 next_desc = hw->next_desc;
       u32 next_desc_msb = hw->next_desc_msb;
       memset(hw, 0, sizeof(struct xilinx_axidma_desc_hw));
       hw->next_desc = next_desc;
       hw->next_desc_msb = next_desc_msb;

Consequently xilinx_dma_prep_slave_sg() never programs next_desc itself. 
It relies entirely on this pre-established ring for both intra- and 
inter-descriptor linkage. Segments are allocated FIFO from the head of 
free_seg_list and freed back to the tail in order, so the head of a
newly appended descriptor is the physical ring-successor of the previous
chain's tail. Extending TAILDESC therefore walks an unbroken in-memory
chain into the new BDs; the descriptors are physically linked.

> 
>>   	head_desc = list_first_entry(&chan->pending_list,
>>   				     struct xilinx_dma_tx_descriptor, node);
>>   	tail_desc = list_last_entry(&chan->pending_list,
>> @@ -1599,7 +1596,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>>   		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>>   	}
>>   
>> -	if (chan->has_sg)
>> +	if (chan->has_sg && list_empty(&chan->active_list))
> 
> [Severity: High]
> Does updating the interrupt coalesce threshold while the channel is active
> disrupt interrupt generation?
> 
> The driver updates the hardware interrupt coalesce threshold using
> chan->desc_pendingcount before writing to the DMACR register:
> 
>      if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
>          reg &= ~XILINX_DMA_CR_COALESCE_MAX;
>          reg |= chan->desc_pendingcount << XILINX_DMA_CR_COALESCE_SHIFT;
>      }
> 
> With the removal of the idle check, this function now executes while
> descriptors are actively running. Since desc_pendingcount is reset to 0 at
> the end of each start_transfer() call, it now only represents the number
> of newly submitted descriptors in the latest pending_list batch.
> 
> Will overwriting the active coalesce threshold with this potentially much
> smaller partial count disrupt the DMA engine's interrupt generation and cause
> erratic coalescing behavior?
> 
>>   		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
>>   			     head_desc->async_tx.phys);
>>   	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
> 
> [ ... ]
> 
>> @@ -1660,9 +1657,6 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
>>   	if (chan->err)
>>   		return;
>>   
>> -	if (!chan->idle)
>> -		return;
>> -
> 


This doesn't disrupt IRQ generation. The axienet driver does exactly 
this for adaptive IRQ moderation (DIM). axienet_rx_dim_work() recomputes 
the coalesce count from the DIM profile and axienet_update_coalesce_rx() 
writes the COALESCE field into the (same) CR register while 
lp->rx_dma_started is true, i.e. with transfers in flight.

Same applies to below MCDMA related comments.

Regards,
Suraj

> [Severity: Critical]
> Does MCDMA suffer from the same unlinked descriptor chain vulnerability when
> TDESC is updated while active?
> 
> Like xilinx_dma_start_transfer(), appending new transfers to a running
> Scatter-Gather chain might break the hardware descriptor chain because the
> new descriptors are not physically linked in memory to the active list.
> 
>>   	if (list_empty(&chan->pending_list))
>>   		return;
>>   
>> @@ -1685,8 +1679,9 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
>>   	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
>>   
>>   	/* Program current descriptor */
>> -	xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
>> -		     head_desc->async_tx.phys);
>> +	if (chan->has_sg && list_empty(&chan->active_list))
> 
> [Severity: High]
> Does this also overwrite the MCDMA CR coalesce field with a partial count
> while the engine may be active?
> 
>      if (chan->desc_pendingcount <= XILINX_MCDMA_COALESCE_MAX) {
>          reg &= ~XILINX_MCDMA_COALESCE_MASK;
>          reg |= chan->desc_pendingcount << XILINX_MCDMA_COALESCE_SHIFT;
>      }
> 
> Similar to the AXIDMA case, using desc_pendingcount here while active might
> disrupt interrupt generation.
> 
>> +		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
>> +			     head_desc->async_tx.phys);
>>   
>>   	/* Program channel enable register */
>>   	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);
> 


