Return-Path: <dmaengine+bounces-9142-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEmjCftFoWkirwQAu9opvQ
	(envelope-from <dmaengine+bounces-9142-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 08:21:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B4B1B3C4F
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 08:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E66302E301
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 07:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C60313537;
	Fri, 27 Feb 2026 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="ps7GWHwC"
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023090.outbound.protection.outlook.com [40.107.44.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7E310764;
	Fri, 27 Feb 2026 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176720; cv=fail; b=G1Jf7J0/8qIeQpOn6u4M+XE4erJmw5U9GfciYCrcc1/XB/KxwSnXi/wnwkUJ6AE7oMEGGQyfGP4XDwmoJ+wAOTurEb6OS0EYzY8TVW5M/lE89CX5pW5D4daKPA3vse+uBf1AeEWj0iWqCYmcVu9wmcbrtDtT419KmruegYFVx2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176720; c=relaxed/simple;
	bh=eyAA3Vwn+PCzkmfZp8+HGxbrx1tuydoqM9xLWqdx3CE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L/mDcjAXgyA4sI1aomzoOD/OIMwt+RkVOdd0X1H3PPAnktF0OBi/cG4bltFyU5/hpTPAn3P3CRni+jLWX0EsZYO0fa1OTtfaxb2Ubd3NXU1pwmFHj9TNDJDbCud22kYVGfaHFWYOiVLmNXdGoDnxyZKycMOxVIykXR3Zok5+CuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=ps7GWHwC; arc=fail smtp.client-ip=40.107.44.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw8jJT/T+dnKCa1FDWrL4fM1l98Tug3paEiVgCH0YEWdU1mRHM8m7DBVCRJtFqtxCDzM1xIBVdWIlORjXedk151R89nm0jP5Rq5f2jFP8NOiGwwiOhiqiPyoVk2erYhapH5HPInmBHWOAu/ESzA6MZyYj7V33Kepq55mqbgKgkWE0PmC33IcGxbvUw75dyLiJxdre3hWGAeExa1/SEqwgZWsqy2e/jf/nIhU7E4WMNwjew/eUQL1wyOn8eRPf+hoV93ZsC3AIhBGeaLdDWAwrM2SO3cnQUMDgPhhoYM4Rv+L/po/BAzdEc6UqjaLSM6fFDdW9UczDX2ATNaU6RyWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL/XiYEInBLhP62m8YuBFsVJYlS46+C4ZmAK2X6ARJI=;
 b=DR9TT5Nfdl+1a0fsh+9szG384W4rUA5v6rLjxM2kmdjVAKO7udzLrYVWyLi/fNzA1CMMO3GGS+mysQbfZ0ROwUubj5/zQky4LLn/SQmd6QhjShZkcLQz/NQVmsKkFdHFJnt7Sl5CtE69/vjDcMY/rAhCrX79OanyXCWtrDwpYQ3x99a2RjLOoAc4Xy+EJLXiZMHv5aOt01QAMXDePwl8EMufpn5ERbCCrEa0zHL4vUe/M+cUczwfxmNi2YtRBNmxXRObofvDQQ8+hTltj37wsHnFTIOtuSRr4elpKL05ohUqo+yKrwkjKHgt7MLrDfe59uQ6tFQo1adsL5/MbkiVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL/XiYEInBLhP62m8YuBFsVJYlS46+C4ZmAK2X6ARJI=;
 b=ps7GWHwClwbJdRtKF99a2bNYbwTajDD4aVbM2Tokk5R1IXX/fEYnysZ8RTxP8mt0owr769Ea08QGcrdMdwR1ZKkLRrUtYx4cp+cteI8La6fCByqBQTRKdMJXH/zmwgiXXO9ddb+Np3VnJcXJN2a3zO8z8Xop4VLGTOUpFfniLlh3FOY8xtAoj+ov768hvGkPKH/ZD3E5aK9uFUXWmIVXbL1QFGktWzv3ii+uPpRlgtquBsOqCU+JffHEx6uJexNHgnW9bcHPIVEb6YyEOsXnej9zd0QPzsjnTyH61xNG+vhpkob7bOTk1pkKfa6Exx4GX5KycHYz6Md1gCSUkuWUwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KU2PPFE09DED81A.apcprd03.prod.outlook.com (2603:1096:d18::42e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Fri, 27 Feb
 2026 07:18:34 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%6]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 07:18:34 +0000
Message-ID: <de05570b-cf26-46b0-85f6-72deb0c62494@amlogic.com>
Date: Fri, 27 Feb 2026 15:18:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260206-amlogic-dma-v3-0-56fb9f59ed22@amlogic.com>
 <20260206-amlogic-dma-v3-1-56fb9f59ed22@amlogic.com>
 <aYZCFiI0PbAhabj8@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <aYZCFiI0PbAhabj8@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KU2PPFE09DED81A:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c54e0b-4cb2-4071-f7c8-08de75d06a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	adtLBJlvzs/+85QSDruGYbE0tA8LJcdfkTo+GdI8zZCFicS0pABRHogPhiAxWHprcXxzOHsBrnA1gNksLWIqKf3Ilz2fsjz9DUERDVpY35gvQT5FPh+KcNoo4arRKo5gBNVEJ0lc/szpHwB5ZLSJI0Ybw5MKWALEI5jQvincYEiGYYuCgxQV1B+65uru/EwVejVpQKuA6eMyf0d4pcuPKC8yVLk3hRHPTopidq/7w76NxlcakT5HCXwveMcR5pifO9crMQSE1oo6Pggwp8hV1ikLQdWh/NGMzFvEfIHMCJOeA6fTQUZy5dCT+mGXVrKx0he4FVcfWdTEeLFEoWedwLF7Rw0p6iJvaq6gfmKr9GP69hccvLOLgcL/MQEViAE0RGIGJklLsDBYEocPJMXKr1yPhcOwkrdBWkQvZCEK4Ev2TMOtr7tGnrB8Pg82fWM7Z3rBz8ndgU2T66k0BoEitEitFcnpWoutsRHWdHSwo+HHqpyeOZ3CAxrXNK5B0UYBOi1gspmwe4Oa/Q1LZGcjMwGsMW66ieUIoKFsRK68DJT5TSpCoR8tjQ35kbhuGH7rDavWHFAIoQBK7ofvH821RmmcA9en+U2ilso0kw0EsZaRJt7AZLV9uPO5Sqh1OSUK9L+C8oNMCWvUkQmSWcpH+2/QzaUVNSwIHKsUHWanJnUBbmh80TEmJ47nlMBNxfNw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U21YbE93UmdBNWdaV1NPcFFsS2RuOVNiMHVPbHVVSkg0WWJrZmVmMEhsbmIx?=
 =?utf-8?B?azIzanMxbjNkOE1VOG1KZ3Fqb2ZvN1Q1VWd1NksvYjNsRDRqOWMyK01EQlRI?=
 =?utf-8?B?eno2a0pzVVRYZFQvODZ4TXJVUEJJMXNKMWhuL0I3ZEM5TlhMejVQVGdJT05i?=
 =?utf-8?B?U3A0d3AyRm9aYlJKVDVSdDVWQS83WFhVcEF3NXJMYlJkeHZLRU9xNDNwbjZD?=
 =?utf-8?B?VERPZmpCaDlXeThTQkluUmRjdjJVMUJWVE5nVkoveHJ0U2tpVEM1VzM3dzl5?=
 =?utf-8?B?Y0tGTmtqMkc5R1M1R0lMZ2lrUmJWTU9SbURQZXhxQkRnaW1FODRxL3VtcWtO?=
 =?utf-8?B?TDRrcGlBcmFBME5ZNlNJUW1EdE9WRDQ0dEt1OEJMQmJxUEcydENvbHNOMWww?=
 =?utf-8?B?TEhHclo3RUc1ZXNxVlNocXpIWU55blkxTU9MdjJ2UzRhcS9ZdjBDNUJDZE40?=
 =?utf-8?B?dGE5bEh2eitHUU12aFFQTFZ5VzVaNVBPckNIenptQ0JldnZPd2l4bXN5cWxC?=
 =?utf-8?B?ZHovWmM5NWFoV2Q1NVRqbk14MFNUL0MrUjdLVURFMFplSkU3MHY1Um5Xei8v?=
 =?utf-8?B?UStrS0dRM0hMQ0ZCN1p6bDB0V3BuWDRCek5kU3c5NDZVWkRTR2pOMVRINUUy?=
 =?utf-8?B?cXFoMnFMazR6cFVZdUN4RnFDcmNaL3Fsd0RqeFNQNEwxK3VNVXFORlE4Z0Ja?=
 =?utf-8?B?MStVeWltakw2NUNnU2xob2hydmdhaE11UERkdWFYejF4cHJlOFVMNm5Scnh1?=
 =?utf-8?B?aVdwem4zTTlYenZhSmNrN3FoSnZEQnMvcEgrbTF2bUN0MHRoUXJnYm9QYlJ3?=
 =?utf-8?B?bTFnUzVkNVZ6a2FhRWxFS3FDVWZCT2RPcFFMR09wVXBrdzlNRnRqN0ZiUkVx?=
 =?utf-8?B?QTkxZXcwa1dyUUI4UzJ0ZG52RGpxaVlaQ2cvYjFoQmhHNjF6Ym1kN05vVmM5?=
 =?utf-8?B?Qm5YTHdqZHBic0d0cUpIZ1Bkem9xYzkzRGZkcWNKemxqcUY5THN2MDlxQUZr?=
 =?utf-8?B?NEFtVDIyTVorcDFTZmNoU1lBQ09udklDckNFQWNoVk44cE1MRjh5Rm56SHRM?=
 =?utf-8?B?WTZmdGpxK1NQOE1GM2MwdjBpWG1zWWIvbVFxSC8zUXFvNUR3SFNiS2FCZnFK?=
 =?utf-8?B?VUV2SVQ3M1hLY1RwT2VOL20rS1Fud3ZXcE1FMnRlRnFXQ1hOeVFESG9rZ1Mz?=
 =?utf-8?B?Y2EreUxGU0FFZ0N4QmwyNGxzRmpjL1g5K2FJNVc0ZThsRjRRdVVobWNsV0Nw?=
 =?utf-8?B?NFN2dGNWdzE3SHZXL2cwc1RkTFJyR3QzTWNrbFdrRWpzQ3J6OHBNc21WeTVN?=
 =?utf-8?B?UGJPNUdoOHdBR2JDSXMxYWtFT1AwOXpMRWpPcTh0TkhOMUZCMFZaVjlkK1FZ?=
 =?utf-8?B?WEZQcGoyQnd3dkFWQTlmalUrYXdMdDN2Vmt2K3BJbHlxRTRlSGNKa2hjcXBC?=
 =?utf-8?B?SkhXTzY4UUtxSzFVaHZXWGVyaWQ5V25qVzl6RjJUZXJvWHA5ejJWbFo3QkI0?=
 =?utf-8?B?bkRFVWdjRlJIWkp0clhpSzI1SWNwdGY1YkxjVDd0a0VITkN2MmpWd04wSXpz?=
 =?utf-8?B?UWRxaHE1SjN4VGVBQzlhY0FwdkVmVnpJTm5JeHc0UzJPV3UxV3RLbGJkWFEv?=
 =?utf-8?B?YXF6Q01sbFNJQ2ZNSEVrbXlKYUlqOVRIR0E3UDhlbkZpeTMwWm9KR25WT1Zs?=
 =?utf-8?B?bFRjcDVydmVaMVV1d2tnNTJJSjdZOTVQRVVGV2RQZlZ0b1pzUENCcUdNVUZm?=
 =?utf-8?B?NlJPYVRESlNHRVJ3ZVZpbEVwbEhjQllwZFd1eXFnREJCREpFd1ByZm1MMmsv?=
 =?utf-8?B?QjZmNW4ySWlTOFhlN05TQ0NvYTQya0FKVUExT2c5c25aaE41UkFxOUxqNTY4?=
 =?utf-8?B?R2hjQlkrdytvQWlPQTJFKzgyeExsZnFOeWl1UDhkVGpISUJTNzA3Mm1DZ01m?=
 =?utf-8?B?K2U2MzV6ODU5eG1tVHAvUnF5VHRxMTM1S2ZERU9mTFdUVkRuTnVCSXVsZmRU?=
 =?utf-8?B?ZlNDVGFZT3pObWJvUmJFemhCZFVUYnBlTlg4dzdxOGVKVTBHbFhOam5Wakdx?=
 =?utf-8?B?am9UR0xZSmRadHdYZ3lYTmNvK2lxWTlRU1RzS3k4bzZRUTZxZHUyNkdWd1Y1?=
 =?utf-8?B?Y1ZBNlJvYldtQ1dHdWJpVlliUG01TVIvMlZvMlRNS1ZxYnJZby94YUhnTDhv?=
 =?utf-8?B?VkpOTWJiTjRJeU0xcEdOOEE4VUlGS2lBb1hXQmhpSDMwS1FlVDhjVE1lTmZo?=
 =?utf-8?B?aElWV0FuMHJ4UElXUWlPSnpPSHE2UGdYbnA3UE5Gb3lmTzNiWDVXU3pYNDlF?=
 =?utf-8?B?S2lTWkpNYzFCUmp0WVIvRFExOE1JS2dwcU54SUdWK2Z1aFkxUlRsZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c54e0b-4cb2-4071-f7c8-08de75d06a92
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 07:18:33.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bls+HgYkUwNCccwSoVxRye80cfYy8YwiIm7yL7vGGPj81Qmn5KSSPLVObTmqHxLJ0fokvc85istNVpSQpfPXw/PcypFhIlb8btOvj3G5eQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE09DED81A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9142-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amlogic.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amlogic.com:mid,amlogic.com:dkim,amlogic.com:email,fe400000:email]
X-Rspamd-Queue-Id: 63B4B1B3C4F
X-Rspamd-Action: no action

Hi Frank,
    Thanks for your review, all will do.

On 2026/2/7 03:33, Frank Li wrote:
> [ EXTERNAL EMAIL ]
> 
> On Fri, Feb 06, 2026 at 09:02:32AM +0000, Xianwei Zhao wrote:
>> Add documentation describing the Amlogic A9 SoC DMA.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 66 ++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
>> new file mode 100644
>> index 000000000000..3158d99a3195
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/amlogic,a9-dma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic general DMA controller
>> +
>> +description:
>> +  This is a general-purpose peripheral DMA controller. It currently supports
>> +  major peripherals including I2C, I3C, PIO, and CAN-BUS. Transmit and receive
>> +  for the same peripheral use two separate channels, controlled by different
>> +  register sets. I2C and I3C transfer data in 1-byte units, while PIO and
>> +  CAN-BUS transfer data in 4-byte units. From the controller’s perspective,
>> +  there is no significant difference.
>> +
>> +maintainers:
>> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,a9-dma
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: sys
>> +
>> +  '#dma-cells':
>> +    const: 2
>> +
>> +  dma-channels:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Needn't it, which is standard proptery.
> 
> Frank
>> +    maximum: 64
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - '#dma-cells'
>> +  - dma-channels
>> +
>> +allOf:
>> +  - $ref: dma-controller.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    dma-controller@fe400000{
>> +        compatible = "amlogic,a9-dma";
>> +        reg = <0xfe400000 0x4000>;
>> +        interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
>> +        clocks = <&clkc 45>;
>> +        #dma-cells = <2>;
>> +        dma-channels = <28>;
>> +    };
>>
>> --
>> 2.52.0
>>

