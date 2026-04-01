Return-Path: <dmaengine+bounces-9808-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI4VC8T+zGnRYgYAu9opvQ
	(envelope-from <dmaengine+bounces-9808-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 13:17:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AA23793A3
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 13:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E3B13003988
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF63DEAE3;
	Wed,  1 Apr 2026 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o8HmH0RE"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42903DC4CE;
	Wed,  1 Apr 2026 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042140; cv=fail; b=pA5eQrneMAMm50p7L7+ZVY7dXsQzyReJogkfS5sfIGY7pkgOrNpbukrpA2jO+viq+CyNez6hW+6fu2+RvYI8o2TMZ9itb7mOXf8zzZeDKgzAcYnGY6gwbqH5Qx/Zioyvat91E++qTMpmcPGKxfe87jiHBnHDqZU3WQYMJ37D5Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042140; c=relaxed/simple;
	bh=4lRfzBWiM+oc0fC8J8xWdSqbD4M7YPprNC5P6oVlNF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B3k6nIGsHlWI0ZGMHBz6mnX/M/FFPl8/zZVZW05ExBACuIeVpr4xlHKdfxVYCaaRyF2uQJcCJYAI88Adx1hle2U+gA+313RJgnBvBLDOlMDzBA9/zIee3iB2M/bave6lulGxNuJxig5l66GR8agsYRVIaEoDSHntNWqCPNruIPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o8HmH0RE; arc=fail smtp.client-ip=52.101.52.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WePjU032sE3ACQKKBrqAnjR3hqxWAPEhOFpH3ynrPvFZIXxuRcJ0xG3YtrEn2Oa/Vlbg5puUld6fFzpcQt05datwXxdY1OxKPfSWe4ACzAvznyQzu7x+DYkUpr0qT828taoMz//0BhT/sddAE5CpYzlUP0vib0V/h0ynxyLOuUK4xr+TPfstuAfXkq27P8s8Gn1+Vg7YjAlMfcxnpLkGi/56SXdPC7fX2LpI1oFbFWU13Il2waUqQD3UePuUjQBuo6u8n7NDL/LXjQ67XH+ALSj/bO92OCwXnv/3RoOZkEXBKCRxuhdw/RNLf9mlIQtgoo/2bI175WRoJC1uXj68Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9709fC4+XsYiZLg+dvjZOP8Y2408NUEilGBPLAhOIs=;
 b=Nx6ajy07Qd4yZKwZV8KiN0STM4wpnUjYmH4hxZ4FKkk+apV+rbHJeHw1gkef91AC/C+tKnovR6yHCw2ej63NNvAzgI7VWmKXxC/RKbmyahaxyiNAneLqZwSHcW09ZWFPStnIJU2E2X9S/4WoRn+WLQHxBcJ1etNseNT+DaXa+i+994Kg8t7/1sCcVoIaMtWZaTyUcGV4uWLga30K/kqPyqY8ntqO0rpk0vRwEBRJbPtZpp32+7WgdobNl8QgFttYG1xdhnrSiz3kGg3LEmV39KM6FvGueBDOa84YvCo2rb+dTJTC4wwDQnB8ffZ6rTaUjAQJgj5zEw89DdlNrCwd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9709fC4+XsYiZLg+dvjZOP8Y2408NUEilGBPLAhOIs=;
 b=o8HmH0REMInbDiq98g5UFUKS/cQ/pqwwLkpJvFrtI+kljq7ZHVsu+/dKqUF69/mGjfPFRecN/eo11fEN8NFDC7FPfdF8aDywwMWpgf3kClDL+KWoqd4CPSYBgqlT773i4n9LyiU1geAML0XaP3/YMgsGrOih5FP2PlCJLxYO58E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 11:15:36 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 11:15:36 +0000
Message-ID: <f5a8ac32-3c65-4703-87fc-d0990839887d@amd.com>
Date: Wed, 1 Apr 2026 16:45:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: xilinx_dma: Fix CPU stall in
 xilinx_dma_poll_timeout
To: Alex Bereza <alex@bereza.email>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Tony Lindgren <tony@atomide.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260331-fix-atomic-poll-timeout-regression-v1-1-5b7bd96eaca0@bereza.email>
 <vA8GpbivDeKzKN1k0B6m1cvW-rZwJjKzvhksYdUJPo4fsfhLQoXtWoK59V1YX_U2U3jcVR2PAmzrleamvq8Dmw==@protonmail.internalid>
 <833bb42a-65b8-4c93-8109-d2959f8b807f@amd.com>
 <DHHOCNHDN27K.RIE745OFAACD@bereza.email>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <DHHOCNHDN27K.RIE745OFAACD@bereza.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::8) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d16e0de-641e-46ad-1877-08de8fdfff79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	i4jcSSd4GwQStymeYzsN90IgiaTLC89NzjEurEfiV90QykZSglyqsmTMa4oUc1RsQCG70OGXabfuCW/ME+h1FZXwrUpfv10bxHs29VnCT2nvYGOPeH/EuvYwswEBkQugB0AvZQt61Aahqq9mxAu4fdmbbHMORPVpdyihWZnVkrbpc9XqH/jFJSD5K4T+4K47oAG4uaEZAwebspUcAGPehyFv+1L/H0Q67IuZiKDbrI/p5Qp/rjZp9A4gRdEHAl1ctEek21Tfy+xRq37Pz8p9uRVw3qFQrmbUYce/EJNfoflJw3IuEWv/61LCRI7ePra8If4Z9xsS0SWAmqNnYD63JtVndJQaZXT41f1whs+2WJh3DCuf93C4fvjnspNPRQTP4v8/HBgfkB/M8xEJ4c3rEB1zXWvct3NSsP5vpEi209n1lhdSzQvWBi2KG1W4EAfDD9ewdMMF1RslZ7uOa/hc2VYPUJKVIc6NIB9ckUgpG4w4Uop9a6LBUV/7ITW+Cpa21Pka6SgOOE3Wm2J+EUxn6sEzYMCqbvt+HmtRMtVJNwiJRZPJDWG8yQ3Ic7hWFZkNNcxDofZrCo/JY05FVky1Td+jC30xePiaFYIYnGaEWE+oj1sAWOhNpYtJj05L8ujabn1al54q7WGreyHzz63W9uyE4rpEF/XtJ8hiDa6DS748ARvota73QQ3LPKjaulfHoD2vOGnlFx7uISVF7EaeukN290w2jbdIS2xtZ1oxJkM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0plMHFXcWlHZ0JSOHVHSDBNSjZDNUYvUVE5dDhkSXozZWJaUnBGOWY2ajZ6?=
 =?utf-8?B?UHFLWk9raEtpWkIybWV3NFB4czVja0dlUGRXTHZuMTNVTk1mNkJDTlhiWU8w?=
 =?utf-8?B?SXNTb0JHZURpNWNxcTN3VmZvNEVlZjJNM0xsV3dJN1U4V2Z0akwzbmlDV2hk?=
 =?utf-8?B?dU9Kdy9Rc2t0eGlyYkhnYXZtMy94MzIzcjd2aHJEemxzTVBtTHFqLytCMzE2?=
 =?utf-8?B?RVNjZ01sQStVZjBzY1ZNaVRrcDl2bXNVYmJ3UmtkbHBVUFNuTUt5S3VuUlhO?=
 =?utf-8?B?YWR0RklNTm9DcHMzejAwT2p0RlFmakVDQjlEOTI4eENHaXRSdStLZ0dHc0Z0?=
 =?utf-8?B?azg3UWZaemE1Q1U3VVVuZmUwbmRhNjBlNU5MRE5Sa2p6SVB3QVNjNlExOWdL?=
 =?utf-8?B?RjhBenlXTmcreVZLeUdiWDRUN3FMV1Ayd1VoLzRkQlpGbkxYUGdJVVlvOEpk?=
 =?utf-8?B?V1JqT0ptbGRsSFZnTGpGblYzVVh4dUJzaXg3TGNIendjVVByNkJEUkpucG13?=
 =?utf-8?B?Y2IvSVFJR01ZNDdiaFpoM1lETUxOMkpQZ3I3M05rbG5ETEFqL05mcG93ekRw?=
 =?utf-8?B?blNmN0k3RUQvRXducUtwMWdBNjBOb0RKNnlPUkdUVGZGTWVvOXQrTm5nYlRn?=
 =?utf-8?B?VDZ6Zk5aSnJtT0RkbkRwaUpjVHFFYk12MmJqUDhnaThGdHAxdEVaREhJVGxx?=
 =?utf-8?B?c0dwbnRQWkZUUUhpWDUzb0J3WjVmV09objZLUjcybjlpSGRjRk1GS2NVWXRn?=
 =?utf-8?B?L0szVW5ySWl2eDdPUGdlQlZJSjM3V1h2TVJhalpMVENtdGpvZlUzYzB1YkdV?=
 =?utf-8?B?RkZkbmpKS2xEQ1NOdENieFBlWWQ4VElrbDZiNERtNWNqTzJXZFdtN1AyaWNs?=
 =?utf-8?B?WTltY1U2TDBpSmo4QlZMbXRIR1VvdC9JR3NCOSs2WDU2R0IrUk9QNHltUDhi?=
 =?utf-8?B?a2ExRHN2QUJpa05palNVVHN0YXpDV1NWZHJCUW1IZmgvVWpHVHUrMTVGZm15?=
 =?utf-8?B?MXRSeHUyV0F2bmJHWmw2WlpxNjBWZ2UrbXlwSUk2Rm8weVVoQWhIaE0zcktP?=
 =?utf-8?B?VWRHN1pOT05xZi9Vb0dJcWlFZVVtaGNvbUFEZjB1UC9xeDg1SlFWQjRDK0xl?=
 =?utf-8?B?MDlQS0ZodGJaNTZCYUxpaVZGeDYrODdqYkU0MnF4VGZXZjU2cW4xS3c1ZGF6?=
 =?utf-8?B?OERQYXJTTHlrOW5PU1VOSHM0Q01SQ3RRWmtuaENTUWFSK1BINTh1WDRkTGl1?=
 =?utf-8?B?TjBYVEJocFRhRVNhMGkzRW9acTBHUjAzblBEQlBlcmd2MEFyT1NTV0lFaWp0?=
 =?utf-8?B?R3dHTFo1MWxKbFBzL0R6TS9jaUZZOUwzRmVlZGVxazZXa2RKa2U2cU9ReFNM?=
 =?utf-8?B?QXQyY09mb2V5LzVncGQ4UElhZjhsLzY3Tjh2eDRVeFJhV1krNVNMZXJiNUQ2?=
 =?utf-8?B?ZWhYSmRCWkRxRnF4dDIyRjVJM05lU3hhWjUwK01pQkpHV05QMytrQ0NyOGpW?=
 =?utf-8?B?SWVMUGxNdktFWUpMVjJzS0Evc0RpekNnaUhHSlNVdzBJakhRaUkvWlVlWXVr?=
 =?utf-8?B?TisxWE1ZTllSUmVGbjJ3SFJvd3E2SXdwMFhXL3k2RjQ0R0JyanpDSEtKRnFz?=
 =?utf-8?B?Wlg4bjBNdlF1d1I1WUpYR0twMnFTNExpd1hTZS9pRjlqYXFmMjMxcDVEYUlh?=
 =?utf-8?B?NkpWVjFPcmZMcWRWWWo2blBNSzE1Tnd6QkY2N2ZjTnhSVEVZekxYcTFRSGQx?=
 =?utf-8?B?RE55b2M0VGdTU1lMOTI3bVFCRmxVUTJMcEFqMVdxdnVySUtmcUtvUWpIcHpk?=
 =?utf-8?B?WlV0T2ZOdHpnRXB5aUNIOXhjMGRKc2hQWHFvV3FiV1k2b0NLdjVNVjRpdnJP?=
 =?utf-8?B?bm96LzFCVXB1REVYVXVJMFhUalE4cHFvdDY5K2NUY1ZJczJZMUJaYlFmS3hX?=
 =?utf-8?B?ZFRwejUzWXhybEJrRHhnRFpiSy9RTWxLQmJyVDlpNlhRQm5UYlY5Ym9Wa1dw?=
 =?utf-8?B?L2tsYVRNVmhOSXFGYWJtUGxLQkNOcEdLaG1KWWplRGk0dzJweGY0RkRWU2VY?=
 =?utf-8?B?SlBxTVdsU2I3ZHAyVmFyUW5tTHhYL0NsbC91MVhPNFFGaW8xaEJwelNzRkpK?=
 =?utf-8?B?WjByMUt2ZlQ4Wjh0ejF2dzFXMHp3eGhnOVdLb3B5WmcyQkxoeWZUTU1qeFQ1?=
 =?utf-8?B?bEhEVTd0V1pjYVErTVFvUDYvRHBIZXhicEtHQStSQXMyVmhjUmVDRzc0NzZV?=
 =?utf-8?B?U1ZMWUVKbDBTRW1lakIzOURYRmJQVkwyTFYxR0NpUVVGbFJweldoNjZyaUwz?=
 =?utf-8?B?NXBUVlJBcFdWaGptbjV0OHFwNXFMd2Y1c1d6ZktYdW1uOFhjMWE1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d16e0de-641e-46ad-1877-08de8fdfff79
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 11:15:36.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJVSHeVOfEKpHBSbdBJtR1Xs5eiOTzWZTaar36cPup83zJyol/l0CGrOjW4cV8bH6zoWtz+vkb/zVV+WBeIpqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9808-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bereza.email:email,amd.com:dkim,amd.com:mid,aka.ms:url]
X-Rspamd-Queue-Id: B1AA23793A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/2026 1:57 PM, Alex Bereza wrote:
> [You don't often get email from alex@bereza.email. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed Apr 1, 2026 at 7:23 AM CEST, Suraj Gupta wrote:
> 
>>> Rename XILINX_DMA_LOOP_COUNT to XILINX_DMA_POLL_TIMEOUT_US because the
>>> former is incorrect. It is a timeout value for polling various register
>>> bits in microseconds. It is not a loop count. Add a constant
>>> XILINX_DMA_POLL_DELAY_US for delay_us value.
>>
>> Please split this change in a new patch.
> 
> Ok, will send a v2.
> 
>>> Fixes: 7349a69cf312 ("iopoll: Do not use timekeeping in read_poll_timeout_atomic()")
>>
>> This patch doesn't fixes anything in iopoll, please use correct fixes tag.
> 
> Ok, but I'm not sure what would be the correct fixes tag then? I though I need to reference
> 7349a69cf312 in fixes tag because this is the actual change that surfaced the CPU stall issue that I
> want to fix in this driver. I'm fixing the call sites of xilinx_dma_poll_timeout but they were added
> in different commits. Should I add all of them? That would be the following then:
> 
> Fixes: 9495f2648287 ("dmaengine: xilinx_vdma: Use readl_poll_timeout instead of do while loop's")
> Fixes: 676f9c26c330 ("dmaengine: xilinx: fix device_terminate_all() callback for AXI CDMA")
> 
> Three call sites with delay_us=0 were first introduced by 9495f2648287, then 676f9c26c330 added the
> fourth call site when introducing xilinx_cdma_stop_transfer (probably copy paste from
> xilinx_dma_stop_transfer). Would adding these two fixes tags be correct?
> 
>>> Hi, in addition to this patch I also have a question: what is the point
>>> of atomically polling for the HALTED or IDLE bit in the stop_transfer
>>> functions? Does device_terminate_all really need to be callable from
>>> atomic context? If not, one could switch to polling non-atomically and
>>> avoid burning CPU cycles.
>>>
>>
>> dmaengine_terminate_async(), which directly calls device_terminate_all
>> can be called from atomic context.
> 
> Right, thanks! Just for my understanding: I still think there is potential for improvement, because
> from my understanding it would be beneficial to do the waiting for the bits in the status register
> and the freeing of descriptors in xilinx_dma_synchronize. Do I understand correctly that this is
> currently not possible due to how the DMA engine API is structured? To make this possible I think
> the deprecated dmaengine_terminate_all would have to be removed and all users of this API would have
> to be adapted accordingly, correct? So this would be a patch of much larger scope than xilinx_dma
> driver alone.

Yes, your understanding of xilinx_dma_synchronize()and proposed changes 
looks correct.

Regards,
Suraj

