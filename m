Return-Path: <dmaengine+bounces-10156-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBO/KILK72knGAEAu9opvQ
	(envelope-from <dmaengine+bounces-10156-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 22:43:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4826A47A2E2
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 22:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA011301E210
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F7F371CF5;
	Mon, 27 Apr 2026 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="mXaS/4S2"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15592C3252;
	Mon, 27 Apr 2026 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322390; cv=fail; b=lEExJoaOBpcgPPXsxS/4cTksStJ/BFsFMhFYRkd3McATXeEFAF86XZ6dbAbxzlLTQ8oHyZ3Gkq14CqfcF+L7hHACUZF0g7hHWVFTqXSbuOC6mvy5aVDdhsk1ElkyCLaQIEJ4tFs9YR7Cdkdn5fHe63tCg+xWtWf533p6MKKYQIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322390; c=relaxed/simple;
	bh=587KSE/mBHlcC1zyB/ZzV6dcer4yy+VvGcgD8lme/jE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWy9LwhZiKld1VuVbgXZiL4/vpCh74geugiiTvjhn7AWTz9QLFJ6uOr5Thz3cJQpaZYQ/Z5cfyXewVf4QJ3BVVmq4sKUcYwOGGgwPccCt6d7YU9NUBWoBgElgLPfgbMWHPkJgUNtoa5EjZNr2rAMU4YD/iGxgEPzja9tUHsYZXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=mXaS/4S2; arc=fail smtp.client-ip=52.101.52.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUh77Y8MYJlZhKjg7cr9IZMNNqrz/rZ2qa3tNEc+fec4C7Ju2THcWJblbVnRaqWsvyoKQu+dUhBVNp4GpuLjmVm37rB1bK2CCCYDLT4BzK6PrU+SzNHI48mXeHIxXZZ1yckmz04lu6d99FmaPs4HZMLrAY6IoHyP3tghy99Mz1KEnbJuD4AsUgTBdf48+3RcVVgHji2YBIDA5Qvt/o6jqudWrz+L9xONlDtcVp5UYCJO+vJGt1BvCEOiHbDs8Q8H7qSmSnmE5EFe5fDVwFzrriTXjJgTDZFTAjlIDkMhLoj8cX3ZD0mM4vhMDH5j+EBD1cgIeMa5/5R7wZRZN3faMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=587KSE/mBHlcC1zyB/ZzV6dcer4yy+VvGcgD8lme/jE=;
 b=JBSBPDWe2m0PUXgGc7whO81nXvxcarqS1U4Y+X8CQYCyQDQp+k4PTYxZYzV+P7o8uGNnzVqUd8ZSEiYQ/X29Gg7jV3JZdkFRu+SLujKDNw5PQ66DfWoCR3smuF4XOShj5DAgGaeS69ZUB2th02krtSFErSEjyLtujddPS1MOz3p/oh4aeeg2pXQXOID0eUQwz4WqzzPzCNJ1VT/xa19Ags3nCGgINqRiR24y1CZmhyqxt81o5jZYYKSWtuFkGu8/MzSQWt7aXGQeUe2HjZ28NR0imAc46B0gAucQ5+9ruoMJw7ZVD1v2RP/rIj8FC5uO9FnXzXmU7m2QSDQXx6aPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=587KSE/mBHlcC1zyB/ZzV6dcer4yy+VvGcgD8lme/jE=;
 b=mXaS/4S2ySUjjDWZ0IHnYqwUL9esfa44nwOyfeA3PSxmst6DepNPBSqa3gJjLITYVh03D8R5fmbdXIH3RhlOIPFr37oRxRWcMHUeKl83DVTcXJtcDCT6AgU6UejcOMBE1V143s18p1Wly9dN8WRFl0AoPR/HJoB+cbQxLS8VlD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from IA1PR03MB8288.namprd03.prod.outlook.com (2603:10b6:208:59e::6)
 by PH8PR03MB7197.namprd03.prod.outlook.com (2603:10b6:510:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 20:39:41 +0000
Received: from IA1PR03MB8288.namprd03.prod.outlook.com
 ([fe80::b5ee:28c6:e04b:5599]) by IA1PR03MB8288.namprd03.prod.outlook.com
 ([fe80::b5ee:28c6:e04b:5599%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 20:39:41 +0000
Message-ID: <f54c3c2b-33da-42a0-80b7-0f6615d930ce@citrix.com>
Date: Mon, 27 Apr 2026 21:39:33 +0100
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Laight <david.laight.linux@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, dmaengine@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/9] uaccess: Convert INLINE_COPY_{TO/FROM}_USER to
 kconfig and reduce ifdefery
To: Yury Norov <ynorov@nvidia.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
References: <cover.1777306795.git.chleroy@kernel.org>
 <9fe875d2f55af59c12708336c571a46038528678.1777306795.git.chleroy@kernel.org>
 <ae-tVFVfx72oCC_i@yury>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <ae-tVFVfx72oCC_i@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P250CA0028.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::33) To IA1PR03MB8288.namprd03.prod.outlook.com
 (2603:10b6:208:59e::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR03MB8288:EE_|PH8PR03MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c641edc-eb50-4bae-eff2-08dea49d1bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9FY6m28LCnvy2YkNWJMU+RNswXX+UwdsQPdASIMzD4ybDBQF2lnqvw7QSZPd4BDHC6544/xGvr7GB2IBHK0xFm5TP97Q4B1LLrSYLufDx/SF+LLyKnRdZAhIUZNWvNg0Xs5VZ3Y96fvuQgvPSnPxAQkGJsp8+l2efbhOxHp/BdR2lVMpM++TBM4+FCcwak7FFBclmvyZjFF5YMn4tZiem79sc1Btt0cKEs8JPf9TGbKnDGPH/J9Y8EhC24T8KX1ItZRFFeXIU+G6K9NRUWxxrH7jD+OpsX4eWEXPyZJBnTOAua4918teYDpsYCArRx00EqYolosDciYnyZHCFXIVcvwB1j6VfSrJBdoJr9q4FR6IUGHdUZwHvSFkcMyhayrOK9wwb9KMjU6gnMokNDgilgm1hbCSR7oay+ZI0URVG6m2aFFU+eEEPwwe3PGIMvwNRVkUwpwiTyWxaqEmuwLDdZ0Qzn670vzddOnAl8EWaxRrUT6cmlQ/tvguQHMpnV2hNmfeyZUAZ3+5h41r/ERZCpoFCQ5C69bfEUQcbYKr9ym2osWQa1/n5l0sqiSYk/6JECxxCxmcHamWHf7LNL/hcXOMsg/bNvRMqStPCAohY+6JZNi7L0Ar/b4V3ZLBFmWPdpbmlnjlxOXg/5Kda/Bbg+FvpEqD1RRP+5yqOU3Vj/50V74AdZePk80A+r3os1lE5a/QEOkr6z00c3SGyd8xmkOuMWHXsMLEY/YVFSHzUb8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR03MB8288.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTdZYld2cGR3RFV6NUZRcm9jVXBRMlhvSlN4K2xTZ1Bkdy9GUWlHTVh6VGxr?=
 =?utf-8?B?by84cnBsbmVBUzVEaHhsSXFjVEdycnJOcmQwb1JvWE1QMW1Ma2JMWnhXQ3A1?=
 =?utf-8?B?YU9lV0ZORHllTDZtSVBKQ3RlMnp6dE5LNEhwNE5mL2hJMlZCVk9ZbkRtSDdn?=
 =?utf-8?B?K29mVGpIY2JkOWpVWnIrYjNyNHh2VFlDdzhadjc5bFJTUDMxbkJQSDZUWit1?=
 =?utf-8?B?bHNwY2xuWjZWOGNGRVJ0NHl3cEJnN3FmeXlmTVFtTkw0WVFlNkZqTk8zYkda?=
 =?utf-8?B?RXRsR2VPRHZTaytHeUNYN0l1UkJXV3RxZTA3WStCaE5ObUMxWW4rSmVIb3lj?=
 =?utf-8?B?Mzh0aXFtSnJ2R3Q3YVBIYVpCSlFjYXR6bGhweXFka0U1TlNOdkxrMjRFK1ZL?=
 =?utf-8?B?Y0ZDYmFPa1I1STMzdEVSN0dySDNuRlp2U0hiUmZ1ODVCaWtaTlRwVG56ZGhP?=
 =?utf-8?B?NmpMWWQ3TUlCaVR0ZHBNRkg2dm5BdUtPV1YrcTJyTFpLNXVFMkVqYzk0Y1ZD?=
 =?utf-8?B?ckIrT0dCc21rdzk0UURPOW41YTRFbGtXeVM1N0VqWEJIWTJEdkFnQjR3Wjlm?=
 =?utf-8?B?NnZxRkZ0MkFlTjg0SUV5dDVLZFQrN1paTUdzeE51enZYMFRjUlZtODdaOFZy?=
 =?utf-8?B?a1VFMnNYd1Nac3RWZkUxWlJsNFoxM2g2djFzZW1sM3NJZFd2ZS84WnF3RnJL?=
 =?utf-8?B?alZQck5OcVdXeklCMkY2WXBOMTM3WEUxSGovdXNwQm9XaDlhRWVFdmdXaEcx?=
 =?utf-8?B?QUovaFVUQnE5cXY5QUlzWnFjZDNLOXNHKzBtTTRkNVZOK1J2cldwL2dkdnlH?=
 =?utf-8?B?VWd1YkwzWTZHaWZnb0RrUStuZm1CT2VxM1JoYjladkFVb1M0YlpveS9QRndL?=
 =?utf-8?B?S0R3VnZTMC9EUzRxb0dodm02eHNKRFdDT1hmWlM3U29yN2ZWOUxBVXJDTHlS?=
 =?utf-8?B?NkZDRWNnWVEyczlBTC82MUcvM1pKVldDZGgrWkZOU3VnRlh6OHpwQ25ra2Fj?=
 =?utf-8?B?RjlHMmE2T3VLWUZyRytIR3pqWVdUZWVMSmx5Z1FZTXl1TFFORTNFVXFheFQ2?=
 =?utf-8?B?WmdlS3F6SnRzbEpzUTZGdkhzRHdpbGVBYUZOZHoweTFsV3ZyZ0swRFhNT3hm?=
 =?utf-8?B?dWZSYzhCblRHS3BUdzRxRktBZVFpOGplZExETEwzTEVlbktWaGxsYlkySFk4?=
 =?utf-8?B?WHltVy9EYTVRRktUQWFxSGhNaExjemNLY2YzT1ByaUtEUkhvZWIzaWJVL0Yy?=
 =?utf-8?B?M3ZoamIvMkpzZTJRSGJWSkdxV3N1c0EwSzFGMU1pNnJmdDJ0OW9sQTdkLzRS?=
 =?utf-8?B?YWZZRG9WR0loTzFFQy9lL0N0NWxaOFpiYnhXZjdIaFVoenBwMEpFY3VsU2pN?=
 =?utf-8?B?dUprK2lLRHVEcHpCQklJT0hycSs2K2MrQWNVdFltZ2NPUjFRUU9wakV1QkJa?=
 =?utf-8?B?YzNKN2FGTnlBUU4yZUdOTTIxd3hpNVFaaytwN3Z4cmhJT2xIVmFIbzdQU2Za?=
 =?utf-8?B?YzBDOFFld3BCRTB3elU3MWRiS0lkRGJNZ0dvcDR0blZlL0FIYTRLMTJidisz?=
 =?utf-8?B?T1RQZFM2NWxTcVpJUlpySTdZWFExTlozOTlJTUxqQUgyRUlpM3F4OVdVeDk1?=
 =?utf-8?B?UmlmaFliTGxkTzB4NmxEVlZUZjdzWUJINzdBWlo3Q3B2cGJCbmoyK2V6K2Jj?=
 =?utf-8?B?ZlBiVDJHMTY5cGdmeWlvbENXM3diVXN3elMzUEluL1pJY3owUWRmektKaE1Y?=
 =?utf-8?B?bEpwendKKzRtMVZieHhZamxMK0QzL2JHb3NzYTVvUjZwNjZOREVaWXpwTVNO?=
 =?utf-8?B?aGdyL2lwZGxoM0Y2b2w1MlhzRVNzUitBVjNTbGJlRkRGZElGV2tXUG5OWmpw?=
 =?utf-8?B?NmhHYStiK2JsTDlzU0VoMEhRTXJpSVg0T2czNzlrcUlKL2hvdkdFWkhqalF5?=
 =?utf-8?B?Z25wMitPVGhOMXNJc3J5WFIyRnBqOWttTUg3WTUwNW5HYlZTYmxNTEpVVUU5?=
 =?utf-8?B?dTFqR1pRMTAvWHFHUFozRHlMdmJUQS9NUHdsQWoxRHRtZUZIdmx4SzNEQkhm?=
 =?utf-8?B?dFRzTmtvdkZEMS9Ib29YbHNRZmVMZ3dnVWlrWmJMK2tEems3RUZSdGtVZjNB?=
 =?utf-8?B?eWUweitoQTRvcnBiQnRZSlhSeG9oa2U3MER6NTdyWWY2VE5VazNycmp2YWd4?=
 =?utf-8?B?T2RCQjBPSVZFL1dMQiswMm95WE5XMkxuMEZnVGt4dmhncWgzb0tuTWhDYWs0?=
 =?utf-8?B?Uy91T0hVSFpNQS9VSDJsSHNFN3VBR2R0eUI4NkFaTmVRb3JjcXBRWFYrSlZ0?=
 =?utf-8?B?MVI2V1daUUxINW1OeXdLelV0TDlEYWZKWnZ1TWdZSk5tNS9wVkIyY2d3TGdV?=
 =?utf-8?Q?Z28RZNN4T+YLRj6w=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c641edc-eb50-4bae-eff2-08dea49d1bca
X-MS-Exchange-CrossTenant-AuthSource: IA1PR03MB8288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 20:39:41.7379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7P/OK4nVkYKoOZOPceJ7mFnHteXT+or/VZsK1G7zm1+pF+DiXElHabbIzD2P/Aa25ppayHLm/G+R8tVFazmqVeDsv153yTNZHilISIGWHks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7197
X-Rspamd-Queue-Id: 4826A47A2E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10156-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[citrix.com,linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[citrix.com:+];
	RCPT_COUNT_GT_50(0.00)[51];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[citrix.com:dkim,citrix.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 27/04/2026 7:39 pm, Yury Norov wrote:
> On Mon, Apr 27, 2026 at 07:13:43PM +0200, Christophe Leroy (CS GROUP) wrote:
>> Among the 21 architectures supported by the kernel, 16 define both
>> INLINE_COPY_TO_USER and INLINE_COPY_FROM_USER while the 5 other ones
>> don't define any of the two.
>>
>> To simplify and reduce risk of mistakes, convert them to a single
>> kconfig item named CONFIG_ARCH_WANTS_NOINLINE_COPY which will be
> We've got a special word for it: outline. Can you name it
> CONFIG_OUTLINE_USERCOPY, or similar?

You can't swap the "in" for "out" like this.  "out of line" is the
opposite of "inline" in this context, while "outline" means something
different and unrelated.

~Andrew

