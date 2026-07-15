Return-Path: <dmaengine+bounces-12538-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GthtG5fvVmrADAEAu9opvQ
	(envelope-from <dmaengine+bounces-12538-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 04:25:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1EC75A0AE
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 04:25:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amlogic.com header.s=selector1 header.b=mjuzeW5D;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12538-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12538-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amlogic.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D350300E298
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 02:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D4038D3E2;
	Wed, 15 Jul 2026 02:25:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023072.outbound.protection.outlook.com [40.107.44.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06A248881;
	Wed, 15 Jul 2026 02:25:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784082324; cv=fail; b=Lg3xmOrnkFokeTLlsTQLPPyOmfjlmVwogtO0sJP96TX7FyWxN+d6rcebCB4DLHOhwbKdzV98IH6FB/bYnrZUBEW9visoCMM3h5deO8dcoyfyR2qp8NjTGTpd7MrLFRt13WJ+KpbkkEffHtpVl49k18MUW0p8/TTPUmnJ3c289D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784082324; c=relaxed/simple;
	bh=ncpmVElnm4Jgn5GzCxvXcwEEip1IBRGRLubnF04JT/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jkmViTVKmgGpAK2Z3Qri44Ojmyp03dW7QY9mHA6FPb5m0W2IT6ITjcSJ29ZItK/BSHmmcQwPcAmCxyoh/c9J9e7tFnGGBrsiF598p3CbjuQhXquYi5uxWwp72NnsDiZdTzDySnuHTmfmHzyDcvZ8iBb3HC9btFaxEg/2ZS/Ug4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=mjuzeW5D; arc=fail smtp.client-ip=40.107.44.72
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHlt4WxVgvkEAnW/kn0Fh7VcR56ePCYWkr3G3Fc1LUVRcmwvEMfQbTqkNKxEhNan7OIvlS/ZoNw9x3zi4Z6j7lPUWO2SNQFEBl1aAXaDGlrzJp2p1nnCU9ih7QHPXud3LPZ/IQkP0OLVAWOdVvIha/tOi5aFJFRx7sYmshYje6AohPzGSYIKs79Ao0CKOqDDm2vqmJqF3eyfBsEZ1S3T8YsHZW4zapfn/sVgYs9UG7WSnlQ3CeZ1CDzORyQa1v/5iS1DX+3TaOTLcmkw7dyucnRDpaiKgYS2tQcX+OFXcYH8k/ahVeqmUoJKa8c7af5cr/3wc1dXwgI+gmzlxbZ0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzIFBJm883BOhVEE2h49Dkf94Lv7uQtxDNSuXy1d+54=;
 b=TLTIIEGWbQCCt08QcZWKfNkDwoEF7GBpsvI+Tf4NFhw5ShzyfyQd2OgAmdHq/8ctR1gXdSBzt9FSJIK+Rl1f6/Wx21Z1qhXXzSmFGTfNXBLRwcLDkxbD45wiy0SPqaoLGs5jl8Fk1KwxpKYM7kcl6Zsa2ar94coSe/WomxM5DjHnTvqkQBti4mBv7pUK2Rjrx382uk1hfi0HZVyc1z+bPJy/659XAfV8660CKIitKj2igw/gUd0Xqqvvu/aODLYEDymZZq6k0WpkBEPsQdtAz6W79zWfkN+JijjTIeULFFt6SpuMYzzVxVLZzfA4ue4dzDMkWS7Iufrp19gsIqvtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzIFBJm883BOhVEE2h49Dkf94Lv7uQtxDNSuXy1d+54=;
 b=mjuzeW5DCa+ebFo9qDDrxcrcALOuBUKL0JKcSqSrqmWy/bpkunmMad/j5t9pjPprVVUqKeWHqGP9u8okNtg9pU6b5Ejcfk/4HVSwtLYx0+zk9KTgZ9Dz2fdKA+k/vrUZIvy51k9BN0ewqMA8PZnpHYcOJTszGdQMb7j8Xrdm4QiV38wL6v4YAzVP/sxTnIEQDwxTMpaqLwfWtnbizSwzl3H7WSlDxZFIbj5mPf6tGRAzcslyIUTdUjE0avY6pmgXzCiXQ/nFVjxfqXw5L/p27GXRGt1FLU7iWGsjJgc3i37kiHVendM6wyyVF2BMVsE4goO9resIhvBSQjhpNJ8+mA==
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com (2603:1096:101:b8::14)
 by SE3PR03MB9920.apcprd03.prod.outlook.com (2603:1096:101:336::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 02:25:18 +0000
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::295d:a415:ad29:f34c]) by SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::295d:a415:ad29:f34c%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 02:25:18 +0000
Message-ID: <5d59a919-b150-440e-a77c-16ceffdf88f2@amlogic.com>
Date: Wed, 15 Jul 2026 10:25:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] dmaengine: amlogic: Add general DMA driver for A9
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, linux-amlogic@lists.infradead.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Frank Li <Frank.Li@nxp.com>
References: <20260714-amlogic-dma-v11-0-de79c2394282@amlogic.com>
 <20260714-amlogic-dma-v11-2-de79c2394282@amlogic.com>
 <alYlhm9vav59wKq9@vaman>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <alYlhm9vav59wKq9@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEYPR03MB6877.apcprd03.prod.outlook.com
 (2603:1096:101:b8::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR03MB6877:EE_|SE3PR03MB9920:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce10b18-bb63-4de5-96c7-08dee2184fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|18002099003|22082099003|6133799003|3023799007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	qqgXuZRMD5ZNLLH31XQ2UbNI/Hsye8fjaCSycp9i7REjLk4wwTZej6kDk0EDLNbS8X9U7KFJEWufNIwibZC7PPPVdTcAwveGoMF34vUom/IcxE0u6t5YxdLlcY4Rm14OZNRzoe2CVohNrHENLQ7VsZgGytk+rqXzY2dQbxE5O+CX/r4DoXc1t+1A9AN8JNUHxyK9UnHRmo47hnQ1WIT3p/VsYTXtHndDF1FoFB9ocHGfd6QQdP2zU+/sIl7rxGxpfvxB3dIZplJHuGpYR+vSSpawn5jlTJ1h9eHH6lIW+rRHmgHINKMLGdCsm+TYIXpvDNGRvOik5rpafYKnrCMoE397HKdX6kaa50tkfodlWeCVpPNupo9NgU2Dm+gjWMwQ3JyyUna9a76W0VeM8+9w3mlSwBMS26nn2TYnBCcFwAuG3zMitIIhrxogUujRBCa4V3sW+1ade4TozJ5lTt9vn0CRjBxvmh0z2vRg3++FzWkMuyiBfcuwW64kDTXPqgBxNArCjphlX/dthB9E8Zkx0z9/I0Weg39QGYcsh1SurFgav3LnJkucx87yFeEB9eT9oRstIVAgCOw97gcs4wWMNT8G180vWeYxiU/caRjGTG9wT521jSTM/nwOBxu/N7x/2CxdBL4Da7nBwte0hNF8C4sDQiVhkNDFfPLWOQRZb0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0gxdkQ1dkZtQWRhYkZLdTIreVVONUp0WUNKcFA5aE5JY3R2Z0t6R2VwZ2p0?=
 =?utf-8?B?TkZiVFFPRUhIei9DR1Juc0M2YkdEcGtsOWZxZ1RVdE5xNFN1QWQwZzJzaFo2?=
 =?utf-8?B?YjFaNGI0cHJWZ2hRWHFSeUlFZkxFSmROUGZXOU1XM3NPVFhGc0s2THRYcnF5?=
 =?utf-8?B?WmdUL2FRTDNMNHhZb0ZJT2dTL01WdWpaaGxGbHJWUUo2LytXR0MzSGk3LzM2?=
 =?utf-8?B?UG9sV3NIck5iUnN4TWdva1JGUUltTC84WEo2YUVQZ1o2VHlLbjZOZ2FKbysr?=
 =?utf-8?B?UVAyT0NnOFlDRUxuTWswYXVlNnhFTWhHam1CRWkrTzN2LzBSWUtTZUlCTVdN?=
 =?utf-8?B?WEtSem1ERElJcHA1eUpyMk9VZ2NoWmFkQ0JhQXVZR1NDbEhRZ0plTmh1SFRu?=
 =?utf-8?B?TEJleGgvSERHOTI3UmJwMktRbkpyYTdZcFNCLzFFYTVKVnZ0Wko5RUpSaEtt?=
 =?utf-8?B?eXRyZkVUaTRjU252UHFlZVF6U1J1aHhBL1ZXcndYUWljdC9zblYvQk1PNnZs?=
 =?utf-8?B?N3gyYVhRWFdYUHVmazVMSkdHeWFHVjhuQk5KWDJzNDYzeFBSSE5CalZXNVRN?=
 =?utf-8?B?dkZEblRGNi8vRysyeTJxOVRlTkN4MWRROFpySjZRajZPbEtmdUMxL3k0WGZw?=
 =?utf-8?B?bjBQa29QcFZYTEE0aWNtc3NIQW02SWFGVUxCZnUyRDNTdjk1KytQOGNmM3ZI?=
 =?utf-8?B?T2tRdjJCK1FPcnhieG0xSDBlekh2T1ZwWC9VVng2WmkxUzlGdllPU243a2VB?=
 =?utf-8?B?M0Qyd0s1SWFkUFc5cnJpSzZoZ0xrUE1vWTMrN3dJQ3lsMnhPamRJaE82WE1w?=
 =?utf-8?B?M2h3VnRaUWpmSVNOcnN4bnFYUW93cEQzTkpWTU9qdVp3UkpIZGNXbHVCZ3J2?=
 =?utf-8?B?ZGppY3JPdXU5bFpjdjFjUWpRYk8zVTdlM3Q1UGg1ZHJaTm1BdCswZURnRzBQ?=
 =?utf-8?B?dDRaQ0p0a3gxM0ZZc1g2YlRKeURnbkJxN2JiR1F2ZnlOajNlOEFsS1VUbTEx?=
 =?utf-8?B?R1NNZmNnZDUyQWdZamZ5RTJsRmFaZzFIYTUzS1ArSFdBNUJiNmllSHJ3cjVy?=
 =?utf-8?B?VnBRdVkwNkhXaXprS0gzdkxZMlRKcnp6c2E0SklpcHp5ckJHTnYyRzc2a2NT?=
 =?utf-8?B?Ymt0RGdGTTFNWWdpL09EVVZwOU1Db2RkL1RRL1NZdjVGb1FoWlZLNkhqS0Vv?=
 =?utf-8?B?dkpIeXhPZVJ4b3JRYVpqSmVrZ1hpVVMxZHJVQ0tkdU4wTXQ5WXhRMlpmd2dX?=
 =?utf-8?B?Y1JRM2NDOVl2R0RxM2xBRDRmUmdUUGI4TDVmQTFCNDRXOWxVTU5Fb29keG1z?=
 =?utf-8?B?L21uN3RxUTVGZHdmd0NhSDR1eWQ5WDV3d3RmZ1B0dW9tRzVmREJ4Q0dDRmV0?=
 =?utf-8?B?UmRlK0w1bG5XcTdTS0J6bDNWUzZiOHdIQ1pkRUoyc3Z4eEkvN1NCZ1IvQWVR?=
 =?utf-8?B?VXRYL0krdGhRVlV5Y2M3ZGdWYkhQS1N2a2dhNE03M2d2YWVMdHJad3pBL081?=
 =?utf-8?B?TnlzTHFvSG5lM3MzaEtpakJCUmVmR1JkTVZLbWpwS3Vid3F5Uno1NTNXNU1t?=
 =?utf-8?B?aDQ5c2Ywekx2L0VHOUkra3ByTXB2b1IxWGdhTkpLQTh5VXVBL3B1cUlNaG5K?=
 =?utf-8?B?aU5KUC9uUzBhMFBVSXllc2hwdi9vUzJaQTdNNlJkN29iaHpTdGJvOXAzd0VV?=
 =?utf-8?B?RVBhbTlNc3NxMk53T3dIRDFIUW9wNDVhbDBaZ1hvZ3Zjc1JmZlk5bTRzSmhC?=
 =?utf-8?B?Mm1LNHdOWXpEM2lXd3F6d3E1QjBHVFpucGtwYTEyRzFVTldRcWkyWnk0QUg4?=
 =?utf-8?B?UkNJb3RsU0gyVGx2djFocHZKV2R2TUR5blBmakx0eHJXU25nQThtbi9meUxZ?=
 =?utf-8?B?bm53N3BGNGVLdm5UbkZyMk9VVzV6dllXM05rY01OLzdtRi9LK3NIU21oUWZo?=
 =?utf-8?B?cllRWmdXOEtOc3JqL0s4akNQamJRajJZa1ZCQlhodzVCRy9DbXhFalEyRm94?=
 =?utf-8?B?VGNuTGJEM2xvVkRueHRsWm1MbEMvZEtDNVVBV2RWRm5TSi9SWmN1UDNVQUt6?=
 =?utf-8?B?MEQyT0Y1eGtDUmlEY21kL3ZDM0pTVHVZNDV3cmNnK3FiUTMvYndraENhRUoy?=
 =?utf-8?B?SE5MNmMwSi8rTmtBKzliVzZmcmtsNHM3WlJhOVhSRXRjcUM5MHlsSjNJdUxk?=
 =?utf-8?B?dXNwblhHdzQ4VFdSUVU5Z0FWckoxdkhNS0RkMDRrZS9FY1QzUnBEQU9oZVNT?=
 =?utf-8?B?RVhJYXovaWNrYnRaS25rYjVnRGpiRG8zTzNNMGxKOUlOL25nOTBMeUk0VW9y?=
 =?utf-8?B?d3Rva2ZHTnN0d3lKQndZVEFWQm5yODNYOHBVbTJYcC9oWVV3c0xIdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce10b18-bb63-4de5-96c7-08dee2184fba
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 02:25:18.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGK1xt7gsyk88anOH+t3tR4ksHC8sHuwcOAgR/ICRIrTJ5cclgJqRIJaIyaA4XKAZ63cf/TrTTv6eXQiYAytRhdLNeUBeYVKUjT5I57oGbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB9920
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-12538-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:Frank.Li@kernel.org,m:linux-amlogic@lists.infradead.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:Frank.Li@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amlogic.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amlogic.com:from_mime,amlogic.com:mid,amlogic.com:email,amlogic.com:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB1EC75A0AE

Hi Vinod Koul,
    Thanks for your review.

On 2026/7/14 20:03, Vinod Koul wrote:
> On 14-07-26, 08:08, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>
>> Amlogic A9 SoCs include a general-purpose DMA controller that can be used
>> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
>> is associated with a dedicated DMA channel in hardware.
>>
>> Reviewed-by: Frank Li<Frank.Li@nxp.com>
>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> ---
>>   drivers/dma/Kconfig       |  10 +
>>   drivers/dma/Makefile      |   1 +
>>   drivers/dma/amlogic-dma.c | 726 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 737 insertions(+)
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index ae6a682c9f76..01f96a8257e5 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -85,6 +85,16 @@ config AMCC_PPC440SPE_ADMA
>>        help
>>          Enable support for the AMCC PPC440SPe RAID engines.
>>
>> +config AMLOGIC_DMA
>> +     tristate "Amlogic general DMA support"
>> +     depends on ARCH_MESON || COMPILE_TEST
>> +     select DMA_ENGINE
>> +     select DMA_VIRTUAL_CHANNELS
>> +     select REGMAP_MMIO
>> +     help
>> +       Enable support for the Amlogic general DMA engines. THis DMA
>> +       controller is used some Amlogic SoCs, such as A9.
>> +
>>   config APPLE_ADMAC
>>        tristate "Apple ADMAC support"
>>        depends on ARCH_APPLE || COMPILE_TEST
>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index 14aa086629d5..f62d12b08e15 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_DMATEST) += dmatest.o
>>   obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
>>   obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
>>   obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
>> +obj-$(CONFIG_AMLOGIC_DMA) += amlogic-dma.o
>>   obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
>>   obj-$(CONFIG_ARM_DMA350) += arm-dma350.o
>>   obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
>> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
>> new file mode 100644
>> index 000000000000..9de650a79aba
>> --- /dev/null
>> +++ b/drivers/dma/amlogic-dma.c
>> @@ -0,0 +1,726 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>> +/*
>> + * Copyright (C) 2025 Amlogic, Inc. All rights reserved
> 2026 please
> 
>> +/* DMA controller reg */
>> +#define RCH_INT_MASK         0x1000
>> +#define WCH_INT_MASK         0x1004
>> +#define CLEAR_W_BATCH                0x1014
>> +#define CLEAR_RCH            0x1024
>> +#define CLEAR_WCH            0x1028
>> +#define RCH_ACTIVE           0x1038
>> +#define WCH_ACTIVE           0x103c
>> +#define RCH_DONE             0x104c
>> +#define WCH_DONE             0x1050
>> +#define RCH_ERR                      0x1060
>> +#define RCH_LEN_ERR          0x1064
>> +#define WCH_ERR                      0x1068
>> +#define DMA_BATCH_END                0x1078
>> +#define WCH_EOC_DONE         0x1088
>> +#define WDMA_RESP_ERR                0x1098
>> +#define UPT_PKT_SYNC         0x10a8
>> +#define RCHN_CFG             0x10ac
>> +#define WCHN_CFG             0x10b0
>> +#define MEM_PD_CFG           0x10b4
>> +#define MEM_BUS_CFG          0x10b8
>> +#define DMA_GMV_CFG          0x10bc
>> +#define DMA_GMR_CFG          0x10c0
>> +
>> +#define MAX_CHAN_ID          32
>> +#define SG_MAX_LEN           (GENMASK(26, 0) & ~0x3)
> So you define a mask for 0-26 and then clear everything expect last two
> bits, why not define last two bits..? Something does not look right here
> 

Will do, define  GENMASK(26, 2)

>> +static int aml_dma_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct dma_device *dma_dev;
>> +     struct aml_dma_dev *aml_dma;
>> +     int ret, i, len;
>> +     u32 chan_nr;
>> +
>> +     const struct regmap_config aml_regmap_config = {
>> +             .reg_bits = 32,
>> +             .val_bits = 32,
>> +             .reg_stride = 4,
>> +             .max_register = 0x3000,
>> +     };
>> +
>> +     ret = of_property_read_u32(np, "dma-channels", &chan_nr);
>> +     if (ret)
>> +             return dev_err_probe(&pdev->dev, ret, "failed to read dma-channels\n");
>> +     if (chan_nr > (MAX_CHAN_ID * 2))
>> +             return dev_err_probe(&pdev->dev, -EINVAL, "dma-channels unusual\n");
>> +
>> +     len = sizeof(struct aml_dma_dev) + sizeof(struct aml_dma_chan) * chan_nr;
>> +     aml_dma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
>> +     if (!aml_dma)
>> +             return -ENOMEM;
>> +
>> +     aml_dma->chan_nr = chan_nr;
>> +
>> +     aml_dma->base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(aml_dma->base))
>> +             return PTR_ERR(aml_dma->base);
>> +
>> +     aml_dma->regmap = devm_regmap_init_mmio(&pdev->dev, aml_dma->base,
>> +                                             &aml_regmap_config);
>> +     if (IS_ERR_OR_NULL(aml_dma->regmap))
>> +             return PTR_ERR(aml_dma->regmap);
>> +
>> +     aml_dma->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>> +     if (IS_ERR(aml_dma->clk))
>> +             return PTR_ERR(aml_dma->clk);
>> +
>> +     aml_dma->irq = platform_get_irq(pdev, 0);
>> +
>> +     aml_dma->pdev = pdev;
>> +     aml_dma->dma_device.dev = &pdev->dev;
>> +
>> +     dma_dev = &aml_dma->dma_device;
>> +     INIT_LIST_HEAD(&dma_dev->channels);
>> +
>> +     /* Initialize channel parameters */
>> +     for (i = 0; i < chan_nr; i++) {
>> +             struct aml_dma_chan *aml_chan = &aml_dma->aml_chans[i];
>> +
>> +             aml_chan->aml_dma = aml_dma;
>> +             aml_chan->vchan.desc_free = aml_dma_free_desc;
>> +             vchan_init(&aml_chan->vchan, &aml_dma->dma_device);
>> +     }
>> +     aml_dma->chan_used = 0;
>> +
>> +     dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
>> +     dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
>> +     dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
>> +     dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
>> +     dma_dev->device_tx_status = aml_dma_tx_status;
>> +     dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
>> +     dma_dev->device_pause = aml_dma_chan_pause;
>> +     dma_dev->device_resume = aml_dma_chan_resume;
>> +     dma_dev->device_terminate_all = aml_dma_terminate_all;
>> +     dma_dev->device_issue_pending = aml_dma_issue_pending;
>> +     /* PIO 4 bytes and I2C 1 byte */
>> +     dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
>> +     dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>> +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>> +
>> +     regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
>> +     regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
> I think we have macros for 32bit masks, please use that here and other
> places

Will do.

