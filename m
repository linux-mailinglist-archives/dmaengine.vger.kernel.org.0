Return-Path: <dmaengine+bounces-12164-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yhh2ME9ZT2rFewIAu9opvQ
	(envelope-from <dmaengine+bounces-12164-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 10:18:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835E72E2AA
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 10:18:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amlogic.com header.s=selector1 header.b=gkBDvqbL;
	dmarc=pass (policy=quarantine) header.from=amlogic.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12164-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12164-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD6643038C54
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 08:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707753E8660;
	Thu,  9 Jul 2026 08:11:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022129.outbound.protection.outlook.com [52.101.126.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2823E44EB;
	Thu,  9 Jul 2026 08:11:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584680; cv=fail; b=iy0mXJeVSnySDTUOgOC+0CkO34vyFrlBDx2Wh2pLxcbkAX54CH32BiYu9fwZUoY3BRUozEf7mT1DDk69j1wbHRfS/VqQILaeVzlwBxdE1SIzaz34UCdSRywGpOQxmjGQiJ6BjB4KJWMB6IPVG3tK58GoOnX6nqN5+dd9LjSG0Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584680; c=relaxed/simple;
	bh=AHHK9KjU3mro1YinRtydmXuP85LBlNs1AQzQ64tON2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=szlkn2hfAgdcaR2FIpfKXGFgsjFoPAMArmkrIEJtEFMc+ICSvlAPfcGgKDi35Ur3qodN6uT1XWNNzLOqbXV+7df2/ZKEooVg5lY9wHgrUOYOzydOXo8LqifimWCGRSLAP4RDVYXfdbE1bMOu3ixK1Byv7xF4F37szdpOBpqwfJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=gkBDvqbL; arc=fail smtp.client-ip=52.101.126.129
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrHw7cHUaGB6PuOS16ztLB1BWjKQ+iV2L0+HPsGOSn576EeQttEpewKVvwwUWCc7x92dC1+kWZhsgXI9CrTtAj090Aj6J9ddCnbHBBP94D0Nw90Gldwxac06WqtGz/9+OG126HtZw7j/hNIROF+47dSsIDv1ihmnBAQUT99gzvPtXL0WC8pjuVitS6+9ugmSdWq4CZNDfKDXDNoSSk9nUUwIQMriHXEtVr+vl6HqVbkRc5/JKP3qeRzoH5ZnSIyg908GsKsu9hLjnvFzj/wPcEfuHjFp1rR6k9+QdHc/0l3Eb3yNCu/2KSKpznqDeY6dmQ33tRPeRGQCHAfKrJlNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZiuNbipBeGMfEQj6fshtzRIKR9h78/N7JUx6VZj/bU=;
 b=bD17OsRr3Y986xywRXaDq1qL/2VkUYeiuPL8xe73wqBHt+3ikL/cftPc1LafpZuA2ipvZE9GmYo3+StCiP1ho7G/fj7ELvcCbvBdpEGQuQqu6PLce3PcmZeyiEF/qccyo4dhwNFEolkUWoUTn+XeWtJVEPOWnffDrc6rE66qV9ceYd1G8plPMI+CdL9MWu05jDZZ8tTM6gsiK2iDrAeIwzHLhOEfbJYcrtepSGc2FLDqtLLL4lm1+eIoxppowyUUIR6iHTnFvO1SebyJZo3Rc9kMe8bFmHzdfZ3k2gg4+UVmrHTYYeUhSeyFS4uQCKDsvoxvigXZjqN6KFnIR5PCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZiuNbipBeGMfEQj6fshtzRIKR9h78/N7JUx6VZj/bU=;
 b=gkBDvqbLZLDhgogb8PgyKyfFOWLVlDoKtSueuCHfFXfkr1I6aXfRfXqX0CCAf0K8ph0bLqmsyYU3B4jiGca6HImZPUfO+zVt0OWjS5pY8PkEimRrXqckDNT16/RT4mtvILmkYlaCGytQnXCZhEPu4UctMIOgHCmTeELoHgO7RAGy/IVyy2Y+WsDgC991XtXRljFacVIKAbqKdW+n4cQ9IzH6TZZNUymrHZgBjfgIc/CwH/4YkpoAfKueFJZ4Y9siLxnCOoBxismOA0b9R59s2glu2vu3GoIZw1D968CogPzAu9AsFuqzmYCrka3JB7O2lO5votb8g/SSvX5xv7+NPw==
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB7582.apcprd03.prod.outlook.com (2603:1096:400:413::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 08:11:14 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 08:11:14 +0000
Message-ID: <312356d0-39e3-4160-b862-0277ba146f47@amlogic.com>
Date: Thu, 9 Jul 2026 16:11:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] dmaengine: amlogic: Add general DMA driver for A9
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev,
 Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: dmaengine@vger.kernel.org, neil.armstrong@linaro.org,
 Frank.Li@kernel.org, vkoul@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org,
 linux-amlogic@lists.infradead.org
References: <20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com>
 <20260626-amlogic-dma-v9-2-558d672c4a95@amlogic.com>
 <20260626055325.ED2721F000E9@smtp.kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20260626055325.ED2721F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0036.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::8)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYSPR03MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b08437-9951-4ae1-54a9-08dedd91a529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|4143699003|3023799007|18002099003|22082099003|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	APkd8mWnkrjNHazQAB5qDsEchw0I36dQHpj0kmYK5cY24hANaTCqVcG/MXyJ6P+I8KBbz2aR9BviDDPZnutgsMab36hBlYQ2kl/Hr6xw6glwQEsa19PneEqUbZUCRmGiLzfOXRZ4y0irqZinC5PdS3xaxhNlwWt3MGSAfzAYC1wiaKxSB/vIxwwCktWFhYIU2U9bO/K0JTjAqajDQ8gitmk+T964dQwwMx4GsSz23z75UlU7p6FKY6Kp8z+Hu5Jb/+Ovuph0lOV+cnUlaHP5J90KuwZzxfcZE1ak3jsW2Gj9YTeOJ+GNAZsXevjWNMqW9Mn1oIguo2Ews6cXJfwdrqg2Df8ZutoMEm6ojDoG6XQkLDAJ8ajTcqMwaRybZ1niqjwjGsip1nS57D79VnOk6cMGGMrW4n39MIlwykqHFrwT4SpqfsNKD4nyZnQvxU5+ORib1qGBr2MRCXJx7QVEdwg+2zWKY/bj475QDFKpL+GdZq3yPCoWcQTSFQpAwQpdnKg6TEKQIqgnvRbMgKOfK51dYrVLsNBokQvvcEdXqU+hauSyDzu5JYXovHk4V09j2UYkcEkl1CxiISpIJzFqUBSn+QVYof/OllJldVPo0bo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(4143699003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmpLL1p5SnJ1T3dFcUsvblN3YTl6cnIzR3FhaEd2L1poM0pmLzRaYVFGSDZL?=
 =?utf-8?B?YWVNUEdRRHg1aUhmdVVWc3hqb3p0Y3Bqd3NJWjZRbEVNSHJFUWNGdE85UzEv?=
 =?utf-8?B?TzN6eXV3M3JLN1F0WFdISy9wcE1LdmNsSUhCazRrNFNpZmJYUU0zc1NEZzlH?=
 =?utf-8?B?RU83NElEMCthQnR4SlZ3TldxN1N3NjdnNlhpZEJuaVMwU0U0OG5uSng1TGx3?=
 =?utf-8?B?ZldGbzl3cWVBUHM2R0Y1b0lSeWljemRJdVdYTHF5QWV6bkZJRkJsQmgvSjND?=
 =?utf-8?B?QkpxelBGNW1adzhaRFQ2a0kvNzdESWc3U3Mza3JhZkhXYnRRdUxRNkQxRE1V?=
 =?utf-8?B?ZzNCS3pGZlJkWkZFTzdISkV6cmhDLzRnZkw3OU8wSlpmOHNFbE83VUg0Qzhq?=
 =?utf-8?B?V0M0dEhhTUZuMXVPOXorL3JBdGx6S3ExQTdVUVh2N3ZqZGp0VStDOXhEZDJu?=
 =?utf-8?B?T2RaNjZqNjcvNTZJMmd4eElqR0lSYUpqZTI2dWxYNUhCbHN4RDhBZGJVQ0xj?=
 =?utf-8?B?UmdKUUNudGZRZjBhb2tJM1VxS3FJT2lGRmM5Vi9QM29tVjEzNkNFODFTNUxx?=
 =?utf-8?B?b1plQnRXVExWUUV5RURSWTN2UkVaNEhNYWVZUWpONW4ycURCNElnZEkwWFp1?=
 =?utf-8?B?SytsSWk3RGd6R3NZQjd6RTFFaE5ZSzlXaHA0VGJMMTA5SzdOd0sxSFcxU2V5?=
 =?utf-8?B?MHNPZmhMdG5jOXdocndWQ0ZkZk5TS3NRMk94NldNbHoyN1NESlRQNXliNTh3?=
 =?utf-8?B?VzRwbjlRcVVXWTN4bHlpNHFSNkdReHIwdzYwTFU0dXBKQXFMaUgvVmk2N3dm?=
 =?utf-8?B?ZU1NR201MHpMcTZGeU1tNVpJTWlYeHl0VERiOUd3LzY4RFI2YVJuNVZMZUFx?=
 =?utf-8?B?YkUxZ241a2hkd1BCZXJYZFlVTU1xc2lXYnY5K3VPVW1obG5HZkppMDd5WHR0?=
 =?utf-8?B?Q2RaVVRZRzNKUk1rOEdycDFLMlNiQVZyMEhIWnhWOG4xa3Y3dlVmV05VaWVG?=
 =?utf-8?B?U1liRGlZU1NFeHdkY1Z1ZUZWZjBSU3JyTEdydUtMc3QvLzNZS2lGREdVdzhV?=
 =?utf-8?B?NURDdmNERGV2OFluNjlFa20vK0E4RWx2SkVZVHMvNExDWm1VbHZNWVlLdFhO?=
 =?utf-8?B?U3phVitIOHAyelB6T252YkJ0ZFYySHNpRTEzY2JVS3JkSllLRkVmR3Q5bGF5?=
 =?utf-8?B?dGRmdUo1SjdER1ZLRHBkd2F0Q3V0TnJOMzJ3UjB4U24vTUNlL0lwUTdsZUFE?=
 =?utf-8?B?S25XRHREWUNUUmcwRUFPVlNveXpTM2x0SkR4akNQTkIycUhWMC9sN0pqalY4?=
 =?utf-8?B?OUIrZ25vQkxJSmlvNDVwazV5S3Axb2JsM3hrT2lRWHlnSG1iK2lPcUIyNFhq?=
 =?utf-8?B?c29sb3JGWWpsVy9NUmRNWUF1SUxDSlVNTG15SlE2a0dCeURIMUhXUFo0VTc3?=
 =?utf-8?B?eXlCNFdPV1M3SC91UFVuY3ZDTy8wZUZDenlVbmhncnFCUWpqc1c2QW9iTm5M?=
 =?utf-8?B?M0hXK1ZvRHd1V2RJdHYrVHNYTVlTSFdIUk1JYjdMc0t6R2oyNFV6OU14OWJI?=
 =?utf-8?B?Si9pS0diWHN1VXdSMXAyVG1JeDdtNXNWallha2sxaDVTVkpSM28rdVc5bCtk?=
 =?utf-8?B?NXhlWU9nRkpNYnJURFdPcUN6Mk5JSG5NNjR1MUxueit1MENhc2YrMVV5OGZr?=
 =?utf-8?B?My9KQXI2ZXQ4UEV3MWFETmxDS2ZMeERnNWJ5SjBPYndRaGZKWHhJREhqazBu?=
 =?utf-8?B?bmtwK1I5N1R4MTVRWnpvSGo1amlJTTQ2cjh3Yjk0cUp1Y0J4OGNwLzA3aUFV?=
 =?utf-8?B?QTZET0VOK0Jwb04zd3U0NjlBOE01cTl3dzNMWis3Snl3ZzBKWERZLzFVVUdU?=
 =?utf-8?B?RTJodzlodWFPRDlRbGdCak5GZytwRVFnMGp6UEJzRTRaN1N4Zzg1MlhlcnRt?=
 =?utf-8?B?QVVEWWg1aUVSSUFHQ0FrbU1MUnJXVGR2cUxRVkQ3QUlwU2crSGlGUlVSNGs2?=
 =?utf-8?B?a1p1V0VLZGc5SUpRci9OUThQWDZuM0xNQ1BQU1c3SEh0TVhkNW9ETFIxQS9o?=
 =?utf-8?B?QjJIUG5CSlRhNUlWUWltVGN5WHFzMWIxQ2swQW5RSVhQMmZYSTZsS3FIVjFj?=
 =?utf-8?B?SnpORGdiNVVLc2NlYTgxbHBmVzFaS1VTM0ZyZEJ5aXVMOUdod3lTeVo0ZnFq?=
 =?utf-8?B?dGdyVVgrY05nQ1RNZGVndzdzWjhqRVk2Z0dkWks5SDVZVi8wOHlSM3pyR3Mz?=
 =?utf-8?B?dkhsTStUUzNoUjMwRGx1UDlGcnc1Skg3bkFyZ3pUL2JVSkNlckYzOVpUWHV4?=
 =?utf-8?B?d21XWlg1MC9pR2JnaDBmUnU4bnplZHZ0eE16bVFXWlpQcWM2aXByQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b08437-9951-4ae1-54a9-08dedd91a529
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:11:14.5553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVa1XXTuUD+Afi7pDu5xEW64+22BaqOJAdjdcAf+qLMrIx1k/3N7GO9vj9t9dAl6Rnoy+p6qqJKtWpOItCDgZb7H8qhPv2wlqHsF3jgxTKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7582
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12164-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:devnull+xianwei.zhao.amlogic.com@kernel.org,m:dmaengine@vger.kernel.org,m:neil.armstrong@linaro.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:linux-amlogic@lists.infradead.org,m:devnull@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amlogic.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,xianwei.zhao.amlogic.com,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,amlogic.com:from_mime,amlogic.com:email,amlogic.com:mid,amlogic.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1835E72E2AA



On 2026/6/26 13:53, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential issue(s) to consider:
> - [High] Use-After-Free during driver removal due to missing IRQ synchronization.
> - [High] Sleeping in atomic context when freeing virtual DMA descriptors.
> - [High] Out-of-bounds write in `aml_dma_prep_slave_sg` when processing zero-length scatterlist elements.
> - [High] Broken pause/resume state machine logic leading to channel stall and state corruption.
> - [Medium] `aml_dma_terminate_all()` fails to reset channel error state, causing permanent stall.
> - [Medium] `aml_dma_tx_status()` improperly handles unissued descriptors, causing false errors and incorrect residues.
> - [Medium] Mismatched DMA address registers used for 64-bit physical addresses.
> --
> 
> commit 7102a7639af273fc6303ccde475117debb548165
> Author: Xianwei Zhao<xianwei.zhao@amlogic.com>
> 
> dmaengine: amlogic: Add general DMA driver for A9
> 
> Amlogic A9 SoCs include a general-purpose DMA controller that can be used
> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
> is associated with a dedicated DMA channel in hardware.
> 
>> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
>> index 0000000000000..bce6932f3a12e
>> --- /dev/null
>> +++ b/drivers/dma/amlogic-dma.c
> [ ... ]
> 
>> +static void aml_dma_free_desc(struct virt_dma_desc *vd)
>> +{
>> +     struct aml_dma_desc *aml_desc = to_aml_dma_desc(vd);
>> +
>> +     dma_free_coherent(aml_desc->dma_device->dev,
>> +                       aml_desc->sg_link_size,
>> +                       aml_desc->sg_link,
>> +                       aml_desc->sg_link_phys);
> [Severity: High]
> Does this code sleep in atomic context?
> 
> When the virtual DMA descriptor is freed, vchan_dma_desc_free_list() calls
> this callback from within vchan_complete(), which runs in tasklet
> (softirq) context. Calling a sleepable function like dma_free_coherent()
> from a tasklet can result in a scheduling while atomic panic.
> 
> Could this driver use dma_pool_alloc/free or kzalloc/kfree for descriptor
> management instead?
> 

Use workqueue to release resources.

>> +     kfree(aml_desc);
>> +}
> [ ... ]
> 
>> +/* DMA transfer state  update how many data reside it */
>> +static enum dma_status aml_dma_tx_status(struct dma_chan *chan,
>> +                                      dma_cookie_t cookie,
>> +                                      struct dma_tx_state *txstate)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     struct aml_dma_desc *aml_desc = NULL;
>> +     struct virt_dma_desc *vd;
>> +     u32 residue = 0, done;
>> +     unsigned long flags;
>> +     enum dma_status ret;
>> +
>> +     ret = dma_cookie_status(chan, cookie, txstate);
>> +     if (ret == DMA_COMPLETE || !txstate)
>> +             return ret;
>> +
>> +     spin_lock_irqsave(&aml_chan->vchan.lock, flags);
>> +     vd = vchan_find_desc(&aml_chan->vchan, cookie);
>> +     if (vd) {
>> +             aml_desc = to_aml_dma_desc(vd);
>> +             residue = aml_desc->data_len;
>> +     } else if (aml_chan->cur_desc && aml_chan->cur_desc->vd.tx.cookie == cookie) {
>> +             aml_desc = aml_chan->cur_desc;
>> +             regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &done);
>> +             residue = aml_desc->data_len - done;
>> +     } else {
>> +             dev_err(aml_dma->dma_device.dev, "cookie error\n");
> [Severity: Medium]
> Will this incorrectly handle unissued descriptors?
> 
> Looking at aml_dma_tx_status(), it attempts to locate a descriptor using
> vchan_find_desc(), 
> 
> If a client queries the status of a descriptor that was submitted (residing
> in desc_submitted) but not yet issued via issue_pending(), vchan_find_desc()
> will return NULL.
> 
> This causes the driver to log a spurious "cookie error" and return a residue
> of 0, which might incorrectly imply the pending transfer is complete.
> 

If it is not found desc, it indicates that the client's callback has 
been invoked, and then he should not come to query status.

>> +     }
>> +     spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
> [ ... ]
> 
>> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
>> +             (struct dma_chan *chan, struct scatterlist *sgl,
>> +             unsigned int sg_len, enum dma_transfer_direction direction,
>> +             unsigned long flags, void *context)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     struct aml_dma_desc *aml_desc = NULL;
>> +     struct aml_dma_sg_link *sg_link = NULL;
>> +     struct scatterlist *sg = NULL;
>> +     u64 paddr;
>> +     u32 link_count, avail;
>> +     u32 i;
> [ ... ]
> 
>> +     sg_link = aml_desc->sg_link;
>> +     for_each_sg(sgl, sg, sg_len, i) {
>> +             avail = sg_dma_len(sg);
>> +             paddr = sg->dma_address;
>> +             while (avail > SG_MAX_LEN) {
>> +                     /* set dma address and len to sglink*/
>> +                     sg_link->addr_low = lower_32_bits(paddr);
>> +                     sg_link->addr_high = upper_32_bits(paddr);
>> +                     sg_link->ctl = FIELD_PREP(LINK_LEN, SG_MAX_LEN);
>> +                     paddr = paddr + SG_MAX_LEN;
>> +                     avail = avail - SG_MAX_LEN;
>> +                     sg_link++;
>> +             }
>> +             /* set dma address and len to sglink*/
>> +             sg_link->addr_low = lower_32_bits(paddr);
>> +             sg_link->addr_high = upper_32_bits(paddr);
>> +             sg_link->ctl = FIELD_PREP(LINK_LEN, avail);
>> +
>> +             aml_desc->data_len += sg_dma_len(sg);
>> +             sg_link++;
> [Severity: High]
> Can this write out of bounds for zero-length scatterlist elements?
> 
> Earlier in aml_dma_prep_slave_sg(), sg_nents_for_dma() calculates the
> required number of link descriptors. For an SG element with length 0, it
> computes DIV_ROUND_UP(0, SG_MAX_LEN), adding 0 to the link count.
> 
> However, this for_each_sg loop unconditionally consumes at least one link
> slot per SG element, setting its properties and incrementing sg_link.
> 
> If a client provides an empty SG element, this mismatch might result in an
> out-of-bounds write past the end of the dma_alloc_coherent array, leading
> to memory corruption.

Zero-length processing will be skipped in loop.

>> +     }
> [ ... ]
> 
>> +static int aml_dma_chan_pause(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     unsigned long flags;
>> +
>> +     spin_lock_irqsave(&aml_chan->vchan.lock, flags);
>> +     regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE);
>> +     aml_chan->pre_status = aml_chan->status;
>> +     aml_chan->status = DMA_PAUSED;
> [Severity: High]
> Is the pause and resume state tracking prone to corruption?
> 
> If aml_dma_chan_pause() is called twice, it overwrites pre_status with
> DMA_PAUSED, which might brick the channel upon resume.
> 
> Also, if a client submits a new transaction while paused,
> aml_dma_chan_resume() restores DMA_COMPLETE but doesn't call
> aml_dma_start(), which could permanently stall the channel.
> 

NO, I don't think the driver will call pause multiple times.

>> +     spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
>> +
>> +     return 0;
>> +}
> [ ... ]
> 
>> +static int aml_dma_terminate_all(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     int chan_id = aml_chan->chan_id;
>> +     struct virt_dma_desc *cur_vd;
>> +     unsigned long flags;
>> +     LIST_HEAD(head);
>> +
>> +     spin_lock_irqsave(&aml_chan->vchan.lock, flags);
> [Severity: Medium]
> Will the channel stall permanently if terminated after errors?
> 
> When a channel hits 6 hardware errors, aml_dma_start() halts the channel
> and abandons pending processing. To recover, a client driver typically calls
> dmaengine_terminate_all().
> 
> However, aml_dma_terminate_all() doesn't reset aml_chan->status to
> DMA_COMPLETE or aml_chan->err_num to 0. Any subsequent transactions
> submitted to this channel might hang forever because aml_dma_start() will
> immediately return due to the persistent error state.
> 

Will add reset reset aml_chan->status to DMA_COMPLETE.

>> +     regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE);
> [ ... ]
> 
>> +static void aml_dma_start(struct aml_dma_chan *aml_chan)
>> +{
>> +     struct virt_dma_desc *vd = vchan_next_desc(&aml_chan->vchan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     struct aml_dma_desc *aml_desc = NULL;
>> +     int chan_id = aml_chan->chan_id;
> [ ... ]
> 
>> +     if (aml_chan->direction == DMA_MEM_TO_DEV) {
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR,
>> +                          lower_32_bits(aml_desc->sg_link_phys));
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR_HIGH,
>> +                          upper_32_bits(aml_desc->sg_link_phys));
> [Severity: Medium]
> Are the correct DMA address registers being used for 64-bit addresses?
> 
> The hardware registers define RCH_ADDR (0xc), RCH_ADDR_LOW (0x20), and
> RCH_ADDR_HIGH (0x24).
> 
> In aml_dma_start(), the lower 32 bits of the physical address are programmed
> into the legacy 32-bit RCH_ADDR (0xc) rather than RCH_ADDR_LOW (0x20), while
> writing the upper 32 bits to RCH_ADDR_HIGH (0x24).
> 
> If the hardware expects the lower bits of a 64-bit address at 0x20, this
> might result in an invalid address and immediate DMA failures.
> 

These two registers are equivalent.

>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_LEN, aml_desc->data_len);
> [ ... ]
> 
>> +static irqreturn_t aml_dma_interrupt_handler(int irq, void *dev_id)
>> +{
>> +     struct aml_dma_dev *aml_dma = dev_id;
>> +     struct aml_dma_chan *aml_chan;
>> +     struct aml_dma_desc *aml_desc;
>> +     u32 done, eoc_done, err, err_l, end;
>> +     u32 cpl_data;
>> +     int i = 0;
> [ ... ]
> 
>> +     while (done) {
>> +             i = ffs(done) - 1;
>> +             regmap_write(aml_dma->regmap, CLEAR_RCH, BIT(i));
>> +             done &= ~BIT(i);
>> +             aml_chan = aml_dma->aml_rch[i];
>> +             if (!aml_chan) {
>> +                     dev_err(aml_dma->dma_device.dev, "idx %d rch not initialized\n", i);
>> +                     continue;
>> +             }
>> +             spin_lock(&aml_chan->vchan.lock);
>> +             aml_chan->status = (err & BIT(i)) ? DMA_ERROR : DMA_COMPLETE;
> [Severity: High]
> Can an interrupt overwrite the paused state?
> 
> If an interrupt fires while the channel is paused, this handler unconditionally
> overwrites status to DMA_COMPLETE and calls aml_dma_start(). Could this unpause
> the hardware and break the pause semantics?
> 

When paused, DMA will not work and no interruption will occur. So this 
situation will not occur.

>> +             aml_desc = aml_chan->cur_desc;
> [ ... ]
> 
>> +static int aml_dma_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct dma_device *dma_dev;
>> +     struct aml_dma_dev *aml_dma;
>> +     int ret, i, len;
>> +     u32 chan_nr;
> [ ... ]
> 
>> +     ret = devm_request_irq(&pdev->dev, aml_dma->irq, aml_dma_interrupt_handler,
>> +                            0, dev_name(&pdev->dev), aml_dma);
> [Severity: High]
> Can this cause a use-after-free during driver removal?
> 
> Since devm_request_irq() is used in aml_dma_probe(), the IRQ remains active
> until after aml_dma_remove() completes.
> 
> In aml_dma_remove(), the driver loops and calls tasklet_kill(&aml_chan->vchan.task):
> 

NO, when module remove, mask all irq.

>> +static void aml_dma_remove(struct platform_device *pdev)
>> +{
>> +     struct aml_dma_dev *aml_dma = platform_get_drvdata(pdev);
>> +     struct aml_dma_chan *aml_chan = NULL;
>> +     int i;
>> +
>> +     of_dma_controller_free((&pdev->dev)->of_node);
>> +
>> +     regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
>> +     regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
>> +
>> +     for (i = 0; i < MAX_CHAN_ID; i++) {
>> +             aml_chan = aml_dma->aml_rch[i];
>> +             if (aml_chan)
>> +                     tasklet_kill(&aml_chan->vchan.task);
> But an executing interrupt handler on another CPU can subsequently call
> vchan_cookie_complete() and reschedule the tasklet.
> 
> Once remove() returns, devres unregisters the DMA engine, frees the IRQ, and
> frees the driver struct via devm_kfree. The tasklet will then run and access
> freed memory, causing a use-after-free panic.
> 
> Should the driver explicitly free or disable the IRQ using devm_free_irq()
> before calling tasklet_kill()?

Yes it had  mask all irq before call tasklet_kill.

> 
>> +             aml_chan = aml_dma->aml_wch[i];
>> +             if (aml_chan)
>> +                     tasklet_kill(&aml_chan->vchan.task);
>> +     }
>> +}
> --
> Sashiko AI review ·https://sashiko.dev/#/patchset/20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com?part=2

