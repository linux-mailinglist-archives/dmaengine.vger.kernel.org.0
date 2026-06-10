Return-Path: <dmaengine+bounces-11395-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id waWPKKwlKWoHRgMAu9opvQ
	(envelope-from <dmaengine+bounces-11395-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 10:51:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB06676EE
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 10:51:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=omikjEZp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11395-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11395-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB2C032DFF36
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100D03B14DC;
	Wed, 10 Jun 2026 08:43:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB364282F2A;
	Wed, 10 Jun 2026 08:43:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080996; cv=fail; b=ACKukcUraWcMx59C4I9yIJ7s8JiNM+gBbCfYF+kHN94H+ldCE3B3haiIV2+rb6pjl5u9d4xt79N4yiAS/HqSW8cSbvJkrij/1DPh7ZLXy2h7LbQfUvoRSgjMzOz4LFgMK93pYPh1D4smdx/N+cGYqwojtP0mIRE3EaGXKGxUjyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080996; c=relaxed/simple;
	bh=yLlK3MRgwavOmpuZDqQmivDRoNXgi6KaAgS/0CeZDVA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YTeRP7vlv/0SAPjh1+MohVvF89msWcS1qTaWNESgQ95sNxEc8xll2bQinddbOrcHWcsfJ50gZsT+L0W6SLFs1kDaN7wXoqo/lSEAOrGeanTSVUqrgVl7mz+nfQKsz0hBMqgiEOgQxUywDd2/xPmt3VvhxxR9/wA4RpSyBxoWw+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omikjEZp; arc=fail smtp.client-ip=52.101.62.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMWAVuNRfm9ncNQf/blGNrv8mu90pzE84nm0ZEVJxR8kod8f9Gyve6mWUg1TITk39iTeNsr4ycJS2ROPng1L9840FZusiCPBtXcmvWIHyk+mdAuSIcvIaqf0C2cj9eNeg3iVVpyf8x1tzffikdrZKD4twHlyGyEoFaX3mtmecraIiDZrR3nasYBCU7Y2/V5vJYDuHtPIjXFQrPpgJBkEZDscaRZmimd+0nZ7Jc7MvBluvo7go6QoHa4czLjE2LeK3Y3RAZlkblgkkZfG33e7rDxotk1f//kwmqmqD8vgHFbPlRuOhLg8QN5MrPDed3WiEm3WwMhYMhAhUWUAmWdMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l9EB3AQGJVUdxisi0YLxWrHNVdGgAhKeF+tnstrPNg=;
 b=ov3v7aYa8klgaJHeD6ub5ptPDeJ//fMrEaa4Pb8iZeC/MkPagi9LU/45J88ZnEAYIzqE5topcMV0B8sOKPb7Pb+8mnpv/3MJFA4kAzpKt8k+QWIEBle89j7UmfO8YBuZ7GdI6uMCDb7CbiL0FaXFko3jKXfkCPpK2SUb7OmQOpVmOJk2KFCMF9PqBzU1ZZeKWvqe6QSHMJnc2OstT8OmnDJbUU5OYltvZktef4gga8OUg4nMIzexGf6B1euzKbUEUARXJqgN4B+Jn1lWx0Ts0+/JVqJ90Uya/2kzGiD9oDALPvVofGKTdxkuIXX5p/0VxE0PpUAoY8n958EXt9uV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l9EB3AQGJVUdxisi0YLxWrHNVdGgAhKeF+tnstrPNg=;
 b=omikjEZp1SSHvZ70aikemtcYOnzr4d8ujkIy5ljxChznDpXI2LtyRRvIkgiIsIPwhehiOl/S6mNGLe6gzS7nlfGncwG6ck6Nlnv3n8+mCxtLUSHrkWnpVnTkj+4oaXy1W7RS7Y6PLsYsbdoQPkYvG8pqZb0DdzIsJdE72I04DIvK05ByCzQ77LQCsPBiLAdtWQsXXEu356Rm2xr0itIdm7JijtmnG2T4I6cRDTvXDBqvXyt39F17VaX4Z2/cexZbhwQP3MFLiaFfu3wlaqTio2UuhlBd8qE8PJi/8FNE+YAfMI6UvdYzW1ZunE9HeW3WZV6VR1MKzXdVk/Y7rAzB/w==
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Wed, 10 Jun 2026 08:43:12 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:43:12 +0000
Message-ID: <60410a5b-226b-44ee-93c1-d9cb3eedf01c@nvidia.com>
Date: Wed, 10 Jun 2026 09:43:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4] dmaengine: tegra210-adma: use platform to ioremap
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260609212531.22044-1-rosenp@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260609212531.22044-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::10) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 91bbeecd-2ba6-4656-85a7-08dec6cc4e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|10070799003|1800799024|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RT/aTWmxqtOCAPc5Aa3LJ0blPcq2aX+kGDWIhcOsesumK9Ztl949FjrlzWnBbI/2hfxEfFOiVdk7Ss7kCVTZxTorLgfilL6hh1Cq8p6IE7sNjw21wvzA6hvxI3UlQqEyhMRpXWJyssokszUxLncWIxRbCHgXpnMZN6cwrtSJ7OBV5CbT0H7IGDZoruUNnEdU/v8PtXpNmS5SwODUYvTUVfihzpKI0lAOpkC+04Yphr59p9eTd9XCGIXNpVvpaXBcF6D1TxNnzt71OsyFhpK1OjVDTFH/KpaY9l9USU8y+/qcm5nCUYiUZ64Z8YN1t0sWJ0y+3KHnBWJdcY1vx2LR5wg/YlZnIBUajIYkqREPv0Lko/Xt+wXMK6ML+eds0JY8v3q3NJLFdPJwHhmiPuq5bv09NKlBGybsqYgf5r+gA9GTbDil56XLQZiEVPfBY4DbvDBcG5fMTdF4px2kK5d3aICLx8EwfvT8hPhpUKiyagiVsImR8Ls1MJC5d5iAUQ3eMfWovNxIs5yudyHFb0vPd+5fCBDXEQo6JKwFWxgpZCYpYc1Atht1Mpf4izBmsWNdqH9Th/qeFtLJrmjc+arrgjgOrDZ/tIbT3AApyHWVObanA5zW1x2DGRISCsm4axaExUHReQ3Mj3qa5Y5wzOTli8VTotuPMjPpDHmkBhcNrBwu3iHmm1JL5GjkhRb0tVBF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1NtbFU5Tmt5VzlqOEVqUFovR1YzekswaWhGWnpBTDA5OC9LNUxiazZKcG93?=
 =?utf-8?B?bkZoSTVZZWRqd09NZEZDVWJ6YWNsZXVmNjMyUWxpZ1JkMGdCc2xUMDRQWDhE?=
 =?utf-8?B?NG9CUE5OL2xSQVRMcGxIcGNJU1ZJVFg4cjJubFZiY05DUUo3YWFSTjdPUWd2?=
 =?utf-8?B?RXNpMHpnNlErUVMrY2xZemFVR1FPTmRJUHBGVVZnbnk0c08xWUVtWXVqNmJx?=
 =?utf-8?B?Sjlqd2dFK3B2a2VZV29uS1NJMVhmZ1B0VU1nNG1weFZhY2NZK0pCQlJGRGZ0?=
 =?utf-8?B?MzdnOGVLUWZ0SjhmbzU1ZjYrWWF0V0FUY1dnWFdMYjdFcXlmeis1TXdxZ1Bi?=
 =?utf-8?B?L3hDYkdjVGZ3UWZPSGdHdzFXUWxsZlYyUzNJckNSSFBuN3RiNmRwcGRaaDhJ?=
 =?utf-8?B?elRSUkRKQnVpOUJJalBCb0F3UWcxQ3c1My9Ucy85R0dCSUNYR1FkcUo5cjcw?=
 =?utf-8?B?Uzc4N0Q1TkczY2RDczJHR3NhWjF2bjIwMGdScDc0bERacGpNcTErL2REU2pO?=
 =?utf-8?B?TEtCNEE1UVZJNGg3SGNtYTMreVpTNE5lYVEwOWFEMlNoZUdYVkNCcjUrTEty?=
 =?utf-8?B?VUdydk5nZjFST2FyU0hkOTk0QUlnNTZFTTk0NEx2U0hoaFVFeTdNOUppS0ZN?=
 =?utf-8?B?UWh1NXdHTUt1c2RNYTZrRklTck5OVVpqVGhyZWhpaUpZZGNpbDBaNitsMEt1?=
 =?utf-8?B?TTJ0WVcvMGJMbnduN0hGQW5rTDlmamJxUS9hdVFLSlFPc2ZGTnVsaWwydmdp?=
 =?utf-8?B?cUtMei8zenRFU1VUMmlXTVpQaEhOeE1mWmRMaEJKbnZQV2RSMTBZYk50WUJh?=
 =?utf-8?B?T05Hcjd2R09FTHB5ZHRBMnVpNkJuZklMbHpjbWlTZ1c0ak5peUNGNDJOVEx3?=
 =?utf-8?B?UStDN0Fvb211YzdFWUxHbHZLSHZlOEVUbHc0Y3FrZGNNVEJqQmNkTFhkcFUy?=
 =?utf-8?B?TlJPcmJhcHJicExoUHNFT3BQTmVDejg0UzR0WWNKcjZSaWYyM3pieVBEQzFO?=
 =?utf-8?B?bDVMSEZ4SHNGS1kyaFE4dTVyWWx4Z1ZpNm92NThBdHMyYTBBVVlqd2VLTW5h?=
 =?utf-8?B?dzZ1Ymk4TWg4K2NSMjNyMElqNFhLbFU3UzZ6aDc2cXdmSGxMdk9zbnhXU1Vm?=
 =?utf-8?B?b1dJK2dvZTJOZ0JqM3o4SG5xckpjNmxLQk02akcvb3BGY0dYTjJuMjBEYTky?=
 =?utf-8?B?UlBjOVd3VUtGRExQZ2NZYWN1ZnRTLzRPNDBFS1VmWThwUm42R0RoWjVuVGt0?=
 =?utf-8?B?a2lxL29wNlpYN01EQ0h0QVZhRnFBdUo4ZFdwdjcvbFkwWWt6U0toLzEwKzBn?=
 =?utf-8?B?WlJlcllNdW1odXcvdXRSVWV0S3BrUmtNcHgvTlpHMkltK0pCMUhXMHZpcW9j?=
 =?utf-8?B?akQxK2N4UXZSb1NnUlNMNkFUMXJ2N0tRanh1Um5EUmJMUjd2bjErQkdGbmJz?=
 =?utf-8?B?REdJNCtwd3JhenEyVjJkRVlLVmV6SFlkOGZxaFpqNDVrdVk5NExwaGU2T0F3?=
 =?utf-8?B?OFJrVmc5NGNvTWcxOE9MdVNObXhXanA1MUhLLzVlK2ordUIrc0ZNRTRhV2xr?=
 =?utf-8?B?c2VZQzAzNGgzTm9xOHRmY3VmWEhURVJGN2hNNkwxWmEyRGNCc0pUeFpTR0R0?=
 =?utf-8?B?UTZhYlBFVEZjQlJzQ0kyWmZhSFdQa1Z4WlhXd2hjZmNLMWxYU1VUOWZzQ2pC?=
 =?utf-8?B?MGUrMUFsVHRGMTZYN3FuTCtxQmJpaW41UWt1RlNRdUhObUt2OTgvbzluQXpM?=
 =?utf-8?B?V2ljRDVYSTRSZ2Vla1l4bjdIVzZZOERvbHcxUXZFSEszNzJ5NWZzZUVGRzRO?=
 =?utf-8?B?cm1oY3JQVTdxcjhrVWZtZnM0WjRkeDk0WmRaTW1CanV4bnNSRExnUVJ6Mk9u?=
 =?utf-8?B?ZStHMVZ2Szg0azI5RmlacUJldEhOWlJneSs1YnJqMWVkcFRLdHV6dTltUThL?=
 =?utf-8?B?TTJ6NEN5NXAyVkN2TmhKYTB3ZWxlTGJxSTluNHMrdStWQWNBdE05KzQwUGx0?=
 =?utf-8?B?L2VKazAzVDNhRmlGN05jL3dWbTc3MmpIZEVsZHRobzFGSFJic2RDYmUvUHA1?=
 =?utf-8?B?ZWtvVDhnaHFYek5JclRqL2dXaDN2WW42NTRhMjY5ZUdnK3FTRks0QnBpdW9S?=
 =?utf-8?B?ODduYTNvODIvTmlWVm80bGxCakxSMk1KU0w1UStOWDJIYXd2WUE5NUFXZm5X?=
 =?utf-8?B?QU0rZFQ5UUF1ZXliVFhsa0w4SFM1R0hnNE5oQ3cxNHBGdTJTcWhMcUZBYk5U?=
 =?utf-8?B?a1ZoZFkrZGFQdDJHM0dXa2s2dEhlTnEzUUVKQm5aaXpBTEFMa25VTnpySXg4?=
 =?utf-8?B?NXNBNE5zYmdJaVZzSXMzSzFyU3RtVEw1dHRnMVBSOEVqbHJ6NThYMWw1NUhT?=
 =?utf-8?Q?wVHA8gEPZqOjktENhYo7rFzXlE4Nv9e4IGTqPnxW4TeuT?=
X-MS-Exchange-AntiSpam-MessageData-1: d6oGb0wBTvnI/Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bbeecd-2ba6-4656-85a7-08dec6cc4e56
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:43:12.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XhxKjeMXdVL9t9rctukUmCViKQ0oJSYfFmjPH9FYphi1DxvyCRNYuagtVNC5V4ObEDn/IrAMS9aytPdSmcvUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11395-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:ldewangan@nvidia.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thierry.reding@kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EBB06676EE


On 09/06/2026 22:25, Rosen Penev wrote:
> Simpler to call devm_platform_ioremap_resource() as it returns multiple
> error messages for whichever part fails.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v4: rebase and reword commit message
>   v3: change subject
>   v2: reword commit message
>   drivers/dma/tegra210-adma.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index ceaee1e33e68..21a381d022cf 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -1087,15 +1087,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   		}
>   	} else {
>   		/* If no 'page' property found, then reg DT binding would be legacy */
> -		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (res_base) {
> -			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
> -			if (IS_ERR(tdma->base_addr))
> -				return PTR_ERR(tdma->base_addr);
> -		} else {
> -			return dev_err_probe(&pdev->dev, -ENODEV,
> -					     "failed to get memory resource\n");
> -		}
> +		tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(tdma->base_addr))
> +			return PTR_ERR(tdma->base_addr);

The dev_err_probe() was purposely added to assist debug. Please don't 
drop this.

Jon

-- 
nvpublic


