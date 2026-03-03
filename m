Return-Path: <dmaengine+bounces-9222-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI9+LSUcp2kUeAAAu9opvQ
	(envelope-from <dmaengine+bounces-9222-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 18:36:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE71F4B4D
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 18:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36ACF303A86F
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9E33E3DB1;
	Tue,  3 Mar 2026 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S+Auf81b"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF993364E95;
	Tue,  3 Mar 2026 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559252; cv=fail; b=N4kOik+gskp/sAvPhRu+AsLal1bHm/Clqq7N1n9usndx3BCONTqrcw4hRoFRhbtPrne/3k8pzhZoOO8xh2XcgCj29DF6XJnjRi8JWXXLzg/n2dX4b0AUaMC0D9rwpT9RxK9ieP45n3Nl5oXwP6YTW54ogj2hBGItXl3MVxk9BcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559252; c=relaxed/simple;
	bh=aUwB/y0T3zu+yfRJMBrIs9mX9NO6nTCPOXlPQBB7xA8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ll2ErjzL77eZZ+pzbG8rSRrSg0hgZtnGy/rViCphJc2gJFlMKlaDHEI3MMpAJjCqG/1aoLbrWb+rQWWf9GYcBqG4dn2f4Way+xt2me441UTXex2eh8JW4PD0fwGHarDJ9IKU8ExJ8VcljKtE1lKH74TxX5/zWxyGk0Ho/E52aXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S+Auf81b; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDcs3V+F7JYmHdzxzEde9v702PUBdlyNWOEGQsATjWN05muy+rRD5ekhj6Lv86eDoP+tSxGjsz7fR/2B/e6Rqb6CUGntH8NqL+Md+zeLViKhPnPYwAMNdY4BPTbmmMpX/Z00S1R2iBE6y/VTQF4x+8UB1QvVb2jsuFeppTBzj67YKW4XGvtRTMdRm604NoQz66YiKWARkwYElD+8yjIKFEstjOz2UMOe8NYuG9ak9UKo3vRpaBQBoNY6DsS/lPZOpCnw6bpO08gSkpwhPFAReSktfY/KtUJqdytyJNAXXqIC2Brtw1SFutZlA4f+C0iu/LU0MVQm86FzCem7wwrA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jxcCLOF13+rpnyrtrMXhZEF87PkPyvUmUV90mFdCl8=;
 b=KRFjv3vaitlDS9RTOadZKsl1P50saxYA9A8Jo/qTXLcdWE4ZYkli3lxRns0Slw7o5YxiN/E2uMWhdn2z7flvN08Vvjbwr8ZBnr8OD0O3aqkYr+BngHKWMCC3JaLleeZcvxb9eiK6+IYQjWUrFDHr3OZ/+RFhw4lx/AF1XKlNHsusKd7rNjAyQ7NT0I+2SvRQoaAeszmke9RoOabRPgKnPWqurDPNEtnGWJjPQMGD2Aw4IUrCCULlIquHZlZsM8oFDhWzeKEeW5L17vjnwH97G4BQbWpOYHXCP37umcK7Wte6fVuu2OfR+7PdxpQKkvfFiFUEITrse1Da+FngMcdvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jxcCLOF13+rpnyrtrMXhZEF87PkPyvUmUV90mFdCl8=;
 b=S+Auf81bewLSCLJ516wg6jP+ZRx/zxEOsynqKxGwo9MeJeW0Zqro6cx6ZgwkzdwwyoagZwCV+T2I7aNokK/McxOAH7fLkRoCTxNcYdY3kMk2g19BikeUoLeXmyFb5eW+692cIoUeKHdTeqqI0nousCCcHc8jKovfFg3fM2gPImtnendaqC96m40MG5JAzt5etkGiIIE6PE6EZJ6kYKZh6da6RiX/3J0JSrROF0Mkxw0bWrehcsz0ivOid8ymkMhjMn4cGpDZevlDvqWcFXvQEnKPe6mHqfomuMmOUupFcVVG5qqm9ABZZpNRiT4NkSsgeuy1HUN57sSrskiLx6/xGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 17:34:05 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 17:34:05 +0000
Message-ID: <361e0146-c5af-4f16-a946-14d1df85f99b@nvidia.com>
Date: Tue, 3 Mar 2026 17:34:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add
 iommu-map property
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, krzk+dt@kernel.org, krzk@kernel.org,
 ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, p.zabel@pengutronix.de, robh@kernel.org,
 thierry.reding@kernel.org, vkoul@kernel.org
References: <28c731aa-970c-4ca4-93b5-e2cc57b0c119@nvidia.com>
 <20260303171441.11545-1-akhilrajeev@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260303171441.11545-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0198.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::11) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: da2d76ba-d34d-4102-4c4c-08de794b1136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	9K6/OFWCwLTTg+SerAHQC1v3KgO1cy9y9XHxCGVKooJhxUruiPX+MA30K0uAWGe/2EBpDFiG2IdTpcGK4AAmsqQsQ3OC48VAeybfXOy2A9v8azbq17XSjQSPGD+mlFPuiEf6z6qVWEqc6siC/tCtVvlvKQi4533e/SIcmG7UOt3a/Vm8QPkatiaKPBXP3vz0O4Y5cFAjzyYAQGWnSK6PjtiKr9nQIT1RaVym74En8YA9BH8JwZRzBfYsQPIvyI3JYNiwwu5IcrzyICaPCiDULn9z7zkeNgwzacpFqowg89xX3EFXxkwWxwPOeK5TH2KDVuGKYLTHKuNFk6m8eRDpERHM22hu5SLN6aaHEgKDpMpQjaW93FCmJ6CwuOKH5N5gBzsZI5jIbO3F3WxQGFMtZkDri1avSZhdIWONMpU7vYgLR+Kg9ccwP/WGnXJ3eS/esX84zYEJ3QFfe67dhRmiHzw1msm0hcsJa2JjpdiVRK0bD25qCWJjP0HmZDpoRZtLX+WoAZ0E3LuOQNVh8OF/MnvXTq61mvqs+h9AD7eaPiossnLfchLFEy77fZX4yVmIxzefH8hED/9cz4vLoJah9BSCWYKU0mXddamXXg66qxolNbM7SJ2Co4RXbRvJBjCIqpQlGZuI6LspKbu+Y5Irp7BxSoMMB7vCkeVbJokztCBusn5lqgGGR3dCCkx9yjPIWigcA8GQV85MpvksQ3WDp7668ouH/AMNm17TnwtaVZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjJQZkgxeFZueHA0aDdkejBoVEx2MnkrM1VEaWxnN1RDN21JcHRZQmRZZkM2?=
 =?utf-8?B?R3lmdEVpTGRGL2JnbDRQUTV4aUJkYWxacXF0dmlTcG9ZeG51clFSUVk0OHMy?=
 =?utf-8?B?cTRWS1V4ZEVWa1Z2dWhNNTNVSmxoNkNsM3FHdVFqZXhWN3IzanMyUERoY21j?=
 =?utf-8?B?dWVDYXVySERxb0NUSmUwMUQrS2FmWEFhckpFYzRldktCSmdFK0MrT05ScmVP?=
 =?utf-8?B?Vi8wUS9zbnFWbHR6NUxTTVY2WjIrYzdkNVlsN3hacnlLR0Jhd21qb0c2WmpO?=
 =?utf-8?B?QkRRSU1SMTN2NXdYc0h5dE5qR3liQkxxcE9XelN5K3M1bjM3L3RjV3lNYjRp?=
 =?utf-8?B?dWJIOVpmU2Vac2hQMVAxUmZhYmFzT3VEQUt3WldDTWpPakJXZUYvVnBGVFZ2?=
 =?utf-8?B?bVZ4U3YwVUI1NjRyaVF4NEN4NjlIYWZGMExYU3V2Nmx5ZFhZV0tvYk1LcXd4?=
 =?utf-8?B?Q0pkMHNQekZSMEpLUng1Q0FWWmxoQVc2VHJiekJqUm1xS29JUEc1d2xPYWpk?=
 =?utf-8?B?TFZGenkrN2xNNkNQbVo4bTRmOHB3WFYzVkE5cW43bHNWQVF2UzdJZFA2TVpP?=
 =?utf-8?B?RzVmWFVsNDBORkxqVVBsVE1CZ2pBQXoyOER0bEkvcE9JbVAyMFZaL0pmZkhv?=
 =?utf-8?B?VjArb1cvSUhJNCt2NitnUlNZVHRmZTVlOEFNcnJLekxQWVJ0NXdsZmlPY2Fw?=
 =?utf-8?B?RW1iMm83YkV6L1lRdUZWaDhzUDR0ZmdLY0plWC9FTlB2ZVl2THRqckdtcTJ2?=
 =?utf-8?B?S05yeHpDZGU2cnlIbXpXWllTRGk3alVnKzJDejlDZXEyRUR5MjhtaXdtTVF0?=
 =?utf-8?B?VzQvYUdJY0YzU0U4OFY0eVBYSWJ4YzNSN1BTNWNPaW9Jc0NkV2lCZ1h0aVZ3?=
 =?utf-8?B?QklzbE5KdkVYUFpoMWFwU1pRWHFGTjFYK2k3NFQ1SmNKaGpsVmp2RUVXN2p4?=
 =?utf-8?B?MXpOSHNHK0VvdXN0K0RMMndRUWJJQnNEOWUvZVZGWW1SSjBCZlZPK21iZ2JG?=
 =?utf-8?B?anJYUTUvNktsdHZiUlJxQjdwR3pjMUZkT2xoekJMZHRyVE0xbjhJWDV4aTBH?=
 =?utf-8?B?bW9OU3RwbnEwcmU0TXViRVpkN2ltdXRRNnNLZW81R3dDV3BIRzNmZUpGdVM3?=
 =?utf-8?B?a29sUUxoUUl4OHI2akFOL3FLSjkwT2h6ZFoybFpuVmdDTVlOd3J5MHcydnZY?=
 =?utf-8?B?NzFGQWU4SmpYSzFYT3lWYkpiRE9MNnY2OU82SGNON3dYcmdUdnM0UjFJNFNX?=
 =?utf-8?B?bzZ1V1JXQVhDemdYaytBS3JkdnAxTVF6cmIxcGc1Y0xYZXBvQUNsRFl5VlN0?=
 =?utf-8?B?dXRnT1JmeFJ5aWFCNTFuLzdkMnlzVnowS2JTeDVpTExET004a3NYZk5oRkF1?=
 =?utf-8?B?T0krck02MXM5TU1pM1pqeCs0WElJQ2xGQ2t5M0Vna3AyNktYSzJIV3ppck4x?=
 =?utf-8?B?WmVnYmxFRVBUakUzT3M2UURMM0pmaEhkQ0NpNmtmTUdZSFEvd3p0S3ZESjlG?=
 =?utf-8?B?dDFCZ0owVEoxSWYrYW9QQ1UrNExDeXl5bVNUREhnY3krR3daelNFNnJqbzRN?=
 =?utf-8?B?dVlGYm40SWNTejJmUko0WkVoV2t3U1pVNzBDb3Jzb2RtOFJncC8zYU5LaVQ5?=
 =?utf-8?B?cHdUQ2MzaFNzbDMySDZ6SnJBSi9EM2toR3BLWjhzclpRM0VXTlNnOC9BUTgr?=
 =?utf-8?B?NTdudzlHc3d5bXNoU3ptb25iNFJMa1U2eUc4ODBaNmxjdUxLcDc0bVZneHFL?=
 =?utf-8?B?dHlmZ3RnZFFWSnM2Ymgwc2QwZ1Y2NUdJeW8wRUlVS200b1crSWt2eHVkZFY1?=
 =?utf-8?B?Um1rTmZrR1FENVNvQ2QzU0pDRTQrdFVVSFJJZExRS2R3RkNyM0hsa2N6L2RP?=
 =?utf-8?B?NkdhaFQyYWhJQmNWOGFOVnN6V0UzcmkwVWNaR0kvQzJIZnorRzQzVkVFbHdG?=
 =?utf-8?B?b3FJTzY0b1JYRE82aEFoQkZWUFNGNnR4ZGRqZXg5YnF6ckRML1c2M0lhTkVa?=
 =?utf-8?B?STFTSUVRYXI3d3dIeVpLK1NoK1JYMnVIZFN4bm1HdG5HdllUMS9rQVFuWm4z?=
 =?utf-8?B?UXlTc1kreTQ4U0ZRLzVWa1BnUjNUVjJjenJRT3ZobWgyS0pKR0VJZTh4elNr?=
 =?utf-8?B?Y3pkQUZmNFZUamJQVmp2Kzl2YWQ4M2pPWURSY2hSK3lKWkpKaVpxb2FxR1d4?=
 =?utf-8?B?Z1ZHUEptRm0yM1RNb1gzMGVIUnRYeEhCOGlKWFRVNWxla1ZqQUdOYXV2UThM?=
 =?utf-8?B?alNjQk5YdmtST0JtNGIrK2hhVVI3UEFzeURpZXJtQmF0dUpEc294dFd0blJK?=
 =?utf-8?B?RElJRnB0TGx3VW54TUNpdnFVVmR1T1RhYWNWS1VMc1pxelYyN3BSMUFLeHBL?=
 =?utf-8?Q?Gc+aOJxyJ5qE0aJBQmQ5deH4X5691yAoSPqrzQM5jR69R?=
X-MS-Exchange-AntiSpam-MessageData-1: rwtjhslDR1xx5A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2d76ba-d34d-4102-4c4c-08de794b1136
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 17:34:05.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dtJKmgwB0mjNs4D6zfIJ73gGAE0cP4NC5P0Y/VP+em+GfV5HJU7S0crXr3yG0W0HIHNeaBGghVl4w4AkvHpnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827
X-Rspamd-Queue-Id: 3BCE71F4B4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9222-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 03/03/2026 17:14, Akhil R wrote:
> On Tue, 3 Mar 2026 13:09:00 +0000, Jon Hunter wrote:
>> On 03/03/2026 08:40, Akhil R wrote:
>>
>> ...
>>
>>>> Why is this flexible? If it is, means usually items are distinctive, so
>>>> I would expect defining/listing them. If they are not distinctive,
>>>> commit msg is incorrect. If the list is as simple as 1-to-1 channel
>>>> mapping, just add it in the description how they are ordered.
>>>
>>> Yes, it is a 1-to-1 channel mapping to an IOMMU ID. The intent of making
>>> it flexible is to allow non-consecutive IOMMU ID assignments as well.
>>> This is particularly needed in virtualised environments where the
>>> hypervisor may reserve certain stream IDs, and the guest VM can map only
>>> the permitted ones. Shall I add a description here mentioning this
>>> use-case?
>>
>> Isn't this already handled by the 'dma-channel-mask' property? The
>> driver will skip over any channels that are not in specified by the mask.
> 
> dma-channel-mask would not help if a channel is exposed, and the
> corresponding IOMMU ID is not exposed. For instance say channel 15 is
> available for a VM, but not the stream ID 0x80f.

Is that a valid configuration? Above we said it is a 1-to-1 mapping 
which would imply the mapping is always constant. Ie. same channels maps 
to name SID. Is that not the case?

Jon

-- 
nvpublic


