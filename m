Return-Path: <dmaengine+bounces-12064-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kH6hNPi+TGpfpAEAu9opvQ
	(envelope-from <dmaengine+bounces-12064-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 10:55:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1871968A
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 10:55:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=IkaImiKh;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12064-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12064-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E640C30008BB
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 08:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BE123D2A4;
	Tue,  7 Jul 2026 08:55:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0826E71E;
	Tue,  7 Jul 2026 08:55:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414515; cv=fail; b=EvPSpPdLZmTijeUngPOEKoxY6C053wamzU4tlvdwCMRSVpDTaM0e0oOHIJNb5+tzgfu+/xDQFv48rKa/XUaJyZxJWpChrcIena8FS7H2+0Yb0h4u3L5cBOM82rplvO6J0m47dnfTfmG46b/19TnkbDRZkNbRO5rTK3Cd3mBllQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414515; c=relaxed/simple;
	bh=ybmqVuDU0fGp/HJ3Wp3nj8Fon8fyjJ9kWQya6WIQ/IE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kWrYnCzaofzZ1SFau12xLD1DlXxUzeWh8K/qBcNdSLSV4JHPoruOhUGzrK0wWrUygChyguvnjW5LM6xQ8xmmZyU4kPEBY3o4lyBbGSAFW9WCjImvhZcBo5k+075HCupq38mjptbTsfzEF2BEQcJ0xeQlGAzTA/eVwbOmn6AzZ/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IkaImiKh; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzNQAffIvLxLEph1gVPTjUbQrIJtjaXM/UgdDwgRMAOKuhhjg4WdVcg01j1xv5LNwQPq0x95lvRB85u6kvkOCJnaYVdYpY+x7/Sqt5Evk5Ia9hdSfKnYv2DBo5HwjdTZurRbS0Ok7XTTVRVs99E/p4v8xt8Nn/RuIoR2O8N1HSeE12mM5ckcdB60CxaR3lcwcWhdSkNFuCLZ6lC+2JNb/UK5EpfDgb88sHvzR5mUgba2vyvIFI2RWQZENTkqLOAvyHbs0HdWx+YzCpFYjgCRn0KktGQkCVJUjeh/JPKEIJY5ZO06Sml9N+1LdaZqQ3lqpLYgOLv95YRr7+5R0N14gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztO5VmOXTcKt9SnYbNgQULmin/1JqWz+F+AtX547Kuk=;
 b=Nl2u3cOQer100Sn1k5FUbwbN69wypaOjHg/l1F2JVjF7wqlsoIQwKazaKY+gok1VIn6WYsQoOXSgGE5kVoXwY+3hnj8WJ5OOeF0JsWXTTKQixAKcRA4GcZR+Gbx6t/YHi96Ur47SREtUg4IT9uJFPEvuSU9HcparY2LYA0GGEy+EqTW8t3QGvIdJre3EB/hLuoLm1BDKvHSj+BLY50zqCQP5XgMf+Rbms7aT7D1kZVFNtPFwZB8SKOU/5rYnuV7+OEM3lErAvSLdkxJhNbC15aO98J6BinUQ4TIm0mcETpmHvJ5N+ESSNtG9LD68zmuh0jEEp3qztQOB/4bbi1LfAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztO5VmOXTcKt9SnYbNgQULmin/1JqWz+F+AtX547Kuk=;
 b=IkaImiKhx3j0eV8XJv3UMklBMLD1/2AnpAQ+yPFIFvcP24cF4HiIul5l/QqWIlrInQb30h97eSwmS4g2mOpqEY2CF0tmLORzqzIs3abvrfaTDiE4kOlMnqHYyHFZapzcVDBWC5OE0hzrpYa+7jng9j0L61x+UHJyM3vKGedRLRg=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 08:55:10 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 08:55:10 +0000
Message-ID: <7746a9ba-70bc-45ea-bb4c-bb912ee01be7@amd.com>
Date: Tue, 7 Jul 2026 14:25:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: Frank Li <Frank.li@oss.nxp.com>, Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
 Frank.Li@kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com
References: <20260706123326.2023088-1-devendra.verma@amd.com>
 <akvH9KrZL8iKs7hS@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <akvH9KrZL8iKs7hS@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::17) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 789afef0-d642-4bdd-d3a3-08dedc05737a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lZNs949d9veZpNx5vcy6nVfh7VzrthO7urKk9c47OZl3Maa9GFLjQSHxObNmVFU3i/omPwPNb4LD1zOn2XLGJF/cQDkLYy3oscgI/T25mjlJ34Zn8EHoE5PQklYRhg+9kdtQdFhxkpXQGKF/9Doe34y/BWgOiXjpL9O+PeipKvz2UpNpcckSVsliJEGNKV8h/94e9xB8yxATT4mYLNbwxtWWWXLEChNiu5bjZpStpvV0K+2LC2OS9LXhg/m4tSCOAyQe1oJB5L2FylJEsKJKJwM0TvPSsWtcm4ngaVhqkfwCVd+rEeMrKmWhVaXY+wUe77Te/G1UFwwY/WNj/iiAzXEsoxm9jVk7H1oWL225YaZZ7NYr6iNn5MYlCzycwQBZF6+cBWfzNNLV7GdJCrt/Ncw/FAzKyjJ3rI9PFknClffaxxeSVKrJ0a86UlAKDE9dvAEV4N/p/QU8NgpD22e+faiHHzNMaKEuia0ahYtCrhIsTG4t954AIaHXttgbftU1FuWG7f2RFz8wwytKqaD8hTxnReF16BFg423R3JykWXDpRAcukuVMFJvseFlEtmJNIAeRILiZ//35FZWInhLuUlylr+0kpgBZD6PeC3bvUhR2cF61K96CfVJaXJyVqaYLOKX6xl+fMsCcnrr9amDMVDNPglDRVZ8VqqOGMG2bISo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ektpcnpNVXZWMjlJLzB3WUFPRmNhcHl0ZllNb1lXZTJTbWRqa2hEY2xMTzVY?=
 =?utf-8?B?V1BVb1BlTXlJZ3BQRk03ZnhxeG92U3hmbHR4S3FuUzNtOXN5aEZibnBNdlpB?=
 =?utf-8?B?V3dlTzJDajlaRFQxTVo3ejBrSTNjbDRPVjNzSWpweUhkTEtlTGQzMDZXeVdh?=
 =?utf-8?B?RnNnUk5RcjZ2bVkzWkkyc2I4UzEzU01yT3ZONWVtcXRBUmlJclhUbEZ0VFBW?=
 =?utf-8?B?VS9mRkRhN2dZZkl3dllLNm0rcloyYS9ibWN0UUZZQXBQRURUcmV1TGR6S2RZ?=
 =?utf-8?B?NkxsSnFraXVXSnFjZVFKUmNtWjA5MExzOTRBMjB1bVQwTTZxS21WRHBSeHd4?=
 =?utf-8?B?ZHN3WjR2bS9PWWY5UFkvZ1BMYlVvU3g2bUxjTVYwcnF6T0pXWDhjc1VCZThI?=
 =?utf-8?B?Z2U1SThwM3NUSmpydzFLRUNGZTBHVkdFcmI4S1p3ZEhlYUtIOHRXMmpCcWdT?=
 =?utf-8?B?VnZUV1J5cE9mSlFWeGMrWk9VRTF2MXVYelRkMHdzSU1NSEp5ZzhDbVBjS3Jn?=
 =?utf-8?B?eFZhU2JrL0VwNEF1cUNkQUMxM1BxMklkd3dncEFCNVAwbXdnRjZGWkN4RWpm?=
 =?utf-8?B?N1lYZzJiRVh0MVRtMHBtYjQ0ZXZ2T2xaV3BtbFlmYTFZbERnem4wOWIyeHV0?=
 =?utf-8?B?SGZsbEJ2dHhqanlndDJoRVJYcXV2L2VtSGJ5SEU0L2k0Q2xEMW1WditDNklv?=
 =?utf-8?B?RVVXSDhiZE0vVDRkYVJ2aDJuTGxTWGpIL0xmNHNYakVmTUdvd2tRMXEzZE9Q?=
 =?utf-8?B?NzlWYUg0VjJpNWRPL043Z3E5ckZjanh6VVBjaWJrekNEUE9DWnB6MFdtTGtn?=
 =?utf-8?B?R3UxRGpWSlVwWStPVmIrYTNhQTRzdHBoRHRITUxWaWhxSWRYSEY5aXdWbmlV?=
 =?utf-8?B?TVNQRDlCYjYzZWRuOGdSYmZiWDdub0pKODdqc3ZZYkwxTG9EN1lyQjBnakJ4?=
 =?utf-8?B?NXpEUnZxU2thWEJRSSs5Y2pGanVwU1l6Ujlwb28xMlNyeHRHVmxMU3hUeEJn?=
 =?utf-8?B?eTl6N0ltSEFtVjZuc0Y2d3JyaHRzSDJzbTlmVk95WnJkdDZWK29FdHZKdm5P?=
 =?utf-8?B?Ri9ZYXF6a0ZSOFVzWnUrN2tFV2RrakJXcWphM3pUTXFScCtQaC9qbmJYZzRK?=
 =?utf-8?B?NmNud1BvaVJERk5uN0kxcHpCRXVNbzh0MHYvQ3FmcVFxUUZicW1WZnJqeGZj?=
 =?utf-8?B?V2lqbXBvbldpeWRXNG1oN0prMUVPbGFMdVl3Mk12eHU5aWQ1aTU3NEJjVFR4?=
 =?utf-8?B?OWdPL1lVcEpTVko2aTZaZ3pNMko4bWdPY2ZSaUFPelNhTk5XYVBVcUNhSldv?=
 =?utf-8?B?Y0IxZTMwVUt2anU1TTlrUktjcUhWUU1nS0FCMDJ0ZG1pZjhkRTFJNGhDNnd5?=
 =?utf-8?B?WVRDdHlDc0pPSVdKZ2wvZGlNVFlScExjYlBKcTZZZWh6bVV1TGh6amF3WDNv?=
 =?utf-8?B?U1NucWx2TXNwQWd6Zk0xek44QlhqdnIyZTJYc0VUNjgyWHFJbVE2dGorWmI4?=
 =?utf-8?B?Y0VlNkZ0NG43dVd2eS8zdDhqc0Q2NDl4RnFpdzZqU1d1YkQrall5MTNGNHFi?=
 =?utf-8?B?ajNweWt4NVlnNEEvOWVGekYrZHo3VW1uTk1xY293UU5LZzk1dDhZc0FRYnA5?=
 =?utf-8?B?VjRwU0ZudjZBUVJFd0tXSGN1QnFvSXUrTW14SHg4L1dZVVlYcWZBUjAwUjlP?=
 =?utf-8?B?YkVQeXJOV28wR3dleGdmc2l1L2VSZ2lyL0NOdW1yakgrSEV2K3hZelRDZ0dD?=
 =?utf-8?B?eEJ3dFViSlJjOGtFV0pTNFBNdFR6S0YzbHRMRkJBc1NoQTdySmxPZng5VU5n?=
 =?utf-8?B?R1haNlN6aXVWaWcwaDBjVUNPMXF5S1JtSWhzK25naDNwcnNmYUZKWHIvSGY1?=
 =?utf-8?B?b0JnQ2lka3dLVWVkbi82ZWkzUGR3ZmtEMWk1RVBIb2FJaVJRbys0c0xIc29w?=
 =?utf-8?B?QWs3aHRRZ2VldWFUekNsM0REdXZIQ0h5YjN2cUJLOXdVVGVFZ0t4amc5ZFVB?=
 =?utf-8?B?bElIZXBqSUlkSDZ2eHRaWWROMWR6UzlxZC9maytWdy9xeDRTT0YzanFaNUda?=
 =?utf-8?B?R0xSUEZpaXNqb0o1ajRiQk1rMkFrcGVjT0FGZnlTd01VZzlUMzVaelN3T1p5?=
 =?utf-8?B?K0p0VmFOQkY2clA2UEx4bExaeGp1RUZlSWdpR2Nrb1p4Z3VuWWcwNjZuWFYw?=
 =?utf-8?B?c1VzR0wvSk5XWkdZeEk0dDkyc3R1aWN2dW91eklzQlc3NUNJSzRlNDNVOG5H?=
 =?utf-8?B?Z0lNcFM2eVh0S3J4cHZndXpGSCtrR01rOCtrTjJkcDFyRmFVV1dVL0RHSU11?=
 =?utf-8?B?ZXA2a1U2QlhWSEw0Y25EbDBIM2xiVk9MeDlYYlVDcHpYb2o5ZEw5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789afef0-d642-4bdd-d3a3-08dedc05737a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:55:10.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQ03AoWZgbjbr1LPkXtcE2zXMW8E3jPLFgDOPOQ0uNsIbLjc+mD1WC7QsFCs6G3IYM9GtD2Md17D4GbDWBUpbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
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
	TAGGED_FROM(0.00)[bounces-12064-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4A1871968A



On 06-Jul-26 20:51, Frank Li wrote:
> On Mon, Jul 06, 2026 at 06:03:26PM +0530, Devendra K Verma wrote:
>> As per 'Designware Cores PCI Express Controller Databook',
>> Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
>> channels. Current controller driver supports up to 8 read and
>> write channels only. In order to utilize all the channels the
>> controller driver need to have the channel related structs
>> and variables as per the number of channels supported by IP.
>> Following changes are made to enable 64 Read / 64 Write
>> channel support:
>>
>>   o Defined HDMA specific macros to reflect the channel count.
>>   o The count of ll_regions and dt_regions in dw_edma_chip and
>>     dw_edma_pcie_data shall be in accordance to number of read
>>     and write channels.
>>   o In dw_edma_probe() configure the channels as per the channels
>>     of the IP used.
>>   o Changed mask types to u64 for higher channel counts.
>>
>> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
>> ---
> ...
>>   struct dw_edma_irq {
>>   	struct msi_msg                  msi;
>> -	u32				wr_mask;
>> -	u32				rd_mask;
>>   	struct dw_edma			*dw;
>> +
>> +	DECLARE_BITMAP(wr_mask, 64);
>> +	DECLARE_BITMAP(rd_mask, 64);
> 
> Nit: Please macro HDMA_MAX_RD_CH and HDMA_MAX_WD_CH
> 

Thanks for this suggestion!
I will update this in the next version.

-Devendra

>>   };
>>
> ...
>> @@ -252,7 +252,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>>   	}
>>
>>   	val = dw_edma_v0_core_status_done_int(dw, dir);
>> -	val &= mask;
>> +	val &= *mask;
>>   	for_each_set_bit(pos, &val, total) {
>>   		chan = &dw->chan[pos + off];
>>
>> @@ -263,7 +263,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>>   	}
>>
>>   	val = dw_edma_v0_core_status_abort_int(dw, dir);
>> -	val &= mask;
>> +	val &= *mask;
> 
> It should be fine if sparse don't report warning.
> 
> Frank
> 
>>   	for_each_set_bit(pos, &val, total) {
>>   		chan = &dw->chan[pos + off];
>>
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> index 632abb8b481c..0181bd276e22 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> @@ -53,13 +53,24 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>>   static void dw_hdma_v0_core_off(struct dw_edma *dw)
>>   {
>>   	int id;
>> +	enum dw_edma_dir dir;
>> +/HDMA_MAX_RD_CH
> 
>> +	dir = EDMA_DIR_WRITE;
>> +	for (id = 0; id < dw->wr_ch_cnt; id++) {
>> +		SET_CH_32(dw, dir, id, int_setup,
>> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
>> +		SET_CH_32(dw, dir, id, int_clear,
>> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
>> +		SET_CH_32(dw, dir, id, ch_en, 0);
>> +	}
>>
>> -	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
>> -		SET_BOTH_CH_32(dw, id, int_setup,
>> -			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
>> -		SET_BOTH_CH_32(dw, id, int_clear,
>> -			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
>> -		SET_BOTH_CH_32(dw, id, ch_en, 0);
>> +	dir = EDMA_DIR_READ;
>> +	for (id = 0; id < dw->rd_ch_cnt; id++) {
>> +		SET_CH_32(dw, dir, id, int_setup,
>> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
>> +		SET_CH_32(dw, dir, id, int_clear,
>> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
>> +		SET_CH_32(dw, dir, id, ch_en, 0);
>>   	}
>>   }
>>
>> @@ -118,7 +129,7 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>>   	unsigned long total, pos, val;
>>   	irqreturn_t ret = IRQ_NONE;
>>   	struct dw_edma_chan *chan;
>> -	unsigned long off, mask;
>> +	unsigned long off, *mask;
>>
>>   	if (dir == EDMA_DIR_WRITE) {
>>   		total = dw->wr_ch_cnt;
>> @@ -130,7 +141,7 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>>   		mask = dw_irq->rd_mask;
>>   	}
>>
>> -	for_each_set_bit(pos, &mask, total) {
>> +	for_each_set_bit(pos, mask, total) {
>>   		chan = &dw->chan[pos + off];
>>
>>   		val = dw_hdma_v0_core_status_int(chan);
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> index 7759ba9b4850..48e40efceb2e 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> @@ -11,7 +11,7 @@
>>
>>   #include <linux/dmaengine.h>
>>
>> -#define HDMA_V0_MAX_NR_CH			8
>> +#define HDMA_V0_MAX_NR_CH			64
>>   #define HDMA_V0_CH_EN				BIT(0)
>>   #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>>   #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>> index 1fafd5b0e315..da7a5cc93ad4 100644
>> --- a/include/linux/dma/edma.h
>> +++ b/include/linux/dma/edma.h
>> @@ -14,6 +14,8 @@
>>
>>   #define EDMA_MAX_WR_CH                                  8
>>   #define EDMA_MAX_RD_CH                                  8
>> +#define HDMA_MAX_WR_CH                                  64
>> +#define HDMA_MAX_RD_CH                                  64
>>
>>   struct dw_edma;
>>
>> @@ -89,12 +91,12 @@ struct dw_edma_chip {
>>   	u16			ll_wr_cnt;
>>   	u16			ll_rd_cnt;
>>   	/* link list address */
>> -	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
>> -	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
>> +	struct dw_edma_region	ll_region_wr[HDMA_MAX_WR_CH];
>> +	struct dw_edma_region	ll_region_rd[HDMA_MAX_RD_CH];
>>
>>   	/* data region */
>> -	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
>> -	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
>> +	struct dw_edma_region	dt_region_wr[HDMA_MAX_WR_CH];
>> +	struct dw_edma_region	dt_region_rd[HDMA_MAX_RD_CH];
>>
>>   	/* interrupt emulation */
>>   	int			db_irq;
>> --
>> 2.43.0
>>


