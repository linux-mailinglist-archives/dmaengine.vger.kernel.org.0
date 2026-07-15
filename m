Return-Path: <dmaengine+bounces-12537-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3kSpChfvVmqrDAEAu9opvQ
	(envelope-from <dmaengine+bounces-12537-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 04:23:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE3675A0A6
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 04:23:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amlogic.com header.s=selector1 header.b=E3YS0c+n;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12537-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12537-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amlogic.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75DE5301DC02
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 02:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EAF3655EA;
	Wed, 15 Jul 2026 02:23:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023128.outbound.protection.outlook.com [40.107.44.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D086341;
	Wed, 15 Jul 2026 02:23:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784082194; cv=fail; b=XgT/c4gfjm3ABRymxuKUVikjKtjCgjCZrV+USdMd5FKrcG3YMlxsVTHv3UqJ2fsPqL9XXIhuDGh/2id4d+ZMk3nPgKHSmSOFLsepZMBAoD/ZrPcybdihwE2q2SsWAKK6HE2BEM9l15frEHQMkBwx2o/woJXNsctpgOnQxbWNGXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784082194; c=relaxed/simple;
	bh=+/ZfmBlHPosMwIA1dm9F7tVViBNgFcMhwcpiOhkRSho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ijuHx3lMViypQbO3rSksbf74XxOj0AcovDPrmeWLT4vWkFxkY03VBMp4rkCvu2sSu7MKrl2eH96gXOJTEcaiuVbv4aw5GQ62gpR7u4kJX8UzibQKEknuJwtoKyVWnShDuXB8EabOrgybWYwYRJSxpY4budWUbfxRWC+IP7AFfa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=E3YS0c+n; arc=fail smtp.client-ip=40.107.44.128
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qV2JAvezC45HyKHeSjs+8Tu2OWvaNN2vq0x5uYeqRAn32WSHVZiPozoNVBH6U+N0F6FaUmyP3z2HNsk1Bh90qOyq7hFcpvY6SfCFUp8ANVCpZmcWCRDfxB4sKC1ROpem8O0dKbACJ0Yk3G7g5BipaL+oaWCQeEnxa3ZV3CskIghmefKZbu6RZTxMWWRsR5aYofULxH11XG0i/5cv14i+91X2y2wgpWCnh3In396R+re8vNxOEsUwWwn/R5VWCCcnYFzUduxXjkXAAsulN0WB94zdCD61xmBYlDHQN9gHxbupjJhGph622dijYMQ6Unr0UEuVEk//psubfrqlWUgLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7k1WW5HbxzdE+3AYnnYXinvh/zJrjtBKIbl2zSdjpew=;
 b=jTyoFEnVC/v6lBgwraynUuXB6MZ4aHTvcdBCKxk6XLD/d1o3dVP9jlbyQdv5tGW4c3bJvHcCxhForpcKSAjLGNPvDlxikQ/36gOWRw4hjiLMiw3I1fw1PMKDSOG44iA13k+f+GTigHRv0N6GYX3Ax8DDIreMnyy4vidCe1kd9WjETSjFaswP4qmuw5PAvpIc46LoxzUlsCBPgPDtZg9MVLT7llGQeBSFFdxw7sdH5fto18NJyAkwv6vBhSONLwF3QLX6LcPwLltOCCqmJZyhqIdBSHPK6Z32rq6tg0oUv8UTxQZDRLwCZ7ReObAmelQfud33dbTlK7UmX57wWMoWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k1WW5HbxzdE+3AYnnYXinvh/zJrjtBKIbl2zSdjpew=;
 b=E3YS0c+nHXcKfqqpXY58MbJjm2mERpYpDv6XA3EIpQ/pmWtKxoyCX2dYub0KfBHdC6ExiGDZ/h60eXvjPpjy+vFKjgcy/547FCQdgpMfqjhM07FfmQU5G8ZA7xgdAI08yN1Mwq2Xs6YELJIFH7pm+mHxbR9Bk56ShjlFBIpoe8iuk+kVgXNLCLxZg0VsFbB8AFo4JWd7SIVhmxbrsKZIdMVe306QrN01BDceIXCaJT2/LfGBigSYxu+L18x+QF10SHlJ6bAbBfY50LOZnRDZ9+WHt6J0e/8uwnmlRJkLsT858SkrbPMJNG+9CrMzYiNX5Gx1wie36DbRv2Z8yWoOBg==
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com (2603:1096:101:b8::14)
 by SE3PR03MB9412.apcprd03.prod.outlook.com (2603:1096:101:2e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 02:23:08 +0000
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::295d:a415:ad29:f34c]) by SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::295d:a415:ad29:f34c%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 02:23:08 +0000
Message-ID: <a016f456-28a1-4d54-bef0-d30e8621455f@amlogic.com>
Date: Wed, 15 Jul 2026 10:23:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>, sashiko-bot@kernel.org
Cc: neil.armstrong@linaro.org, robh@kernel.org, conor+dt@kernel.org,
 Frank.Li@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org
References: <20260714-amlogic-dma-v11-0-de79c2394282@amlogic.com>
 <20260714-amlogic-dma-v11-1-de79c2394282@amlogic.com>
 <20260714081942.2E0B91F000E9@smtp.kernel.org> <alYkfmsBU0UqI6Hz@vaman>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <alYkfmsBU0UqI6Hz@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To SEYPR03MB6877.apcprd03.prod.outlook.com
 (2603:1096:101:b8::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR03MB6877:EE_|SE3PR03MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fc6ebe-dbda-4e22-6f47-08dee2180267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|4143699003|18002099003|56012099006|11063799006|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	A7Fo0dFwpvXnbcnz8PeKXQN2vV5+Yr4y+2MutdNYr2annbXi3C+egch3XSQ9XvLmmkl7MvaQTBOI4zpq6/kF0n6ZkQrgiZJxuCuXY2Kgy0czUBVknihVW0bz5d0fMCwA9NXfaNWEdVMuJ15HXhLGif2JNvhzNH0HyepncLv6ra9mhoYjG161sW/cTSEHlduWiXKXVUIjkNnHgM+dJ79XifaocDvid6EtRxQt9fOxWRzrbq/jRGSN/uEfBLAg5sUvCcDwC5T9jyCpa3MmwBI7E3AAd0gz5Bn9938YIueWB+atotAKwNGrQ7wd6JAmkJoxK/2eHEPrMSWw6YcR0xpWW/PedY7d4lgxQOGas5SXj/+TZojcB2CTqtrSaNgMp8f0pULxy9nppuHC+MAvGnZWdx+7iFSbCbvRfqBmh50Soe3oGY7ZMo7bC410Brdg0xpF6RLOHFbjnCfoJbeN73YNznc3HOF1TZRmxdEaVlpvfcdittthJTL/DDQHCfVhIyh0ANt3ikIdAvtjFp6Eym8rcOVQKGxlCaDq9vx+TMBos65eunNhtP4UzZp5rUgNl8sMVhp++jK4RUtfCwPgWHrWRLEhCNpNNs4aDIccWaiQk4maC3MzX800Y7htaHj/9bRVCrrcn7aI1l0qcV7qN5fsy0Zp6Ba8qRz0y3/Z6k4QuI8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(18002099003)(56012099006)(11063799006)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXFLUUVKM1lLclNoOWJ3eWhQMFlJZFliQmpwVjJpQzlJc2hTZzgrcTBidDJu?=
 =?utf-8?B?NTcvU2w2TVZxc2NKWmxVaEdZb2Nzdjl6enlkbVBGSTFlWlNpUVhLWTZVOHFo?=
 =?utf-8?B?RGZQSzhDSFJMV1QzS0ZNdXJJR0Evd254ei85MSswRWtHeUNvTTc3Q1FyVSs1?=
 =?utf-8?B?SmQ3bUNkVVNLRll2NzVsSldXbWlpMDZaclFDaFhFWi8wWkVRbmlTZzk0Zm9M?=
 =?utf-8?B?c1B2em53dEs1K1dkTTd3ZTMyK1pOSFJuVGovR1pHYXZmMHZrSnFmOU1wUmwx?=
 =?utf-8?B?bEZqV2dSclBkRVBtc1phdFpRQ2IvOU1wT0g2OFJneE52VjQ1Vk9QOFBzNnhq?=
 =?utf-8?B?c3hFL21xd1VnM2tHM1NoclFpbVhQVGtYVkFVVytmMjRxL3pSYlYyK0ZZbzdu?=
 =?utf-8?B?VlBLOEZWUGJDMUtWOXNXaTJGZ2R2SUZ4bFhGbXdJQVVEMk5acFpYL3pZWW5i?=
 =?utf-8?B?K2xCS3hFTDNnTExKd2NHSXJ6YXVFSmg2V1JxN0h0M3VJdTFTYjhWNVlWaUdp?=
 =?utf-8?B?YVV4cWkzcU5ENlRTYmFyZm1GdzNicExXemZlS21DcDZQb1NmUGhnZ2lwZjFw?=
 =?utf-8?B?VC9yblFyOVpmeUxiZGdsSkZIYlQ4dFhCQ0ljNHMxaVhHdFlJR2prVTQ5eXM3?=
 =?utf-8?B?ZU0wY0RJSkhXSWM4d0ZvVnpYU05UVFdqYXhldTBBSUtjekI4aExidkpManBk?=
 =?utf-8?B?N2hWVEtYeDBDZFdtdjNrR2dmMzJBcEdFUTFPSGNmWmE4YmFwek1haE9EZnF5?=
 =?utf-8?B?T2dwZmc1LzlpNVBNTzlsVkdqTTVydUQvbXFGckVXakEyMG1xK3NSYk5Ta2xF?=
 =?utf-8?B?MkN4MlJvQnBWeTllTVgzYkIwRFd0b09GRElaRFFzK0NhckQxVnBFellhd2xl?=
 =?utf-8?B?WEY0S3BMdDcybmQxb0Jya0ZlcTJDMFNVem5qc3hGL212ZjR4U0FHSmZTZWN1?=
 =?utf-8?B?UzFRalFZdFZmVjY0dFlQNFR5NnR3U0Fmd0Z1R1FTazNZSkFlNVVFWit4MFFB?=
 =?utf-8?B?dTZZQ0FERFhJVkFPTVE5cVJPYlJnMVlOTjRKMVJ3YnRaaWtCZFpZWndCRUhY?=
 =?utf-8?B?VVBpQXkwRHFkR0gvUXJSSXNyemd4ZW9oN0ZENTZqUFZhSjF0K0RGL201blJk?=
 =?utf-8?B?Z21YdFIzVnFMQmhuOS9qNDBnYnMwellpSk9LbzVBMHFEU1hZWm5KQk5IcUkz?=
 =?utf-8?B?L3haZ3JZbWlZTW1adkY5NjRLNllyU3dCWFFXVWtFRnBxN290Y1FrUVZXR3NE?=
 =?utf-8?B?Nk5NRHR3cm5GditmRnBGVWV6d2tES1h6Um1KbmlrMldHclZwNjFubmhJcktm?=
 =?utf-8?B?NkFqYnFzd3lxb3FBTHMvK2tNMDRoNW55M2ViREYvUisxaHQvcU0yT0diZjNj?=
 =?utf-8?B?YXp6QWlENFJwZExMS1U2WERVMUpYamxxbUlKYWhkVE9rOERvK1JtYW5LeEFh?=
 =?utf-8?B?Y1QwQTNiSVZVUjY2N3c5LzVrYUpBV0pwWVZqOWY1REFkY3NxeUh6RlBqSHVY?=
 =?utf-8?B?RURkMTRJVXB5RkJZSXdOWnFVclU0dFBNd3FJNjZHeFVCb1d6VnNCS1FlcUh5?=
 =?utf-8?B?THhJUFFucU0vbHk4NGNMUmpFMUNudzhmclJLRXNIMTFtT1UySzExZkZWYkJZ?=
 =?utf-8?B?OUVCVUlKSFJKQ3JSNU9temRFcFBiTythVVlmYTNtTHdNbVdpTFVCM0c2Ti9R?=
 =?utf-8?B?NGtiMG5zWGowZkk3dVp3VDlRelpGaGdEMlVaVUtjZzVxWE4xN1ZNOUZFaWVi?=
 =?utf-8?B?ekhvSzkyNm5jZTdGellmTWM0VnZuN0h5VFAvdU54Q2NRQUdUOEZqcVVBZWow?=
 =?utf-8?B?R0IxTXNZRDJ2QW12ZWM4bWFzbHZoNm90cllFT1hOQlBRRS95a2phdUUxSHJl?=
 =?utf-8?B?Z08xenpsOWZuOWtsb2JjSi9oRktRc3NhMGdPdW5jb2FzN2JUZEE3cCtlOFlq?=
 =?utf-8?B?UlNPbVNjcldEMml3OUNhbm11dmVtMTllZjVxeU5sZTc5bXNvWkhrUGlpWVVF?=
 =?utf-8?B?NDRPdS9DUEZoNTZ0ejBUNXVBL2JNNGtLeUprQURpbFZaVlhsOEoyRmhhSXU2?=
 =?utf-8?B?b0RBcEt5K1V0RnAzTVlRbFdZRDVYSjhXdlNxVjlQa3VyRmk3dm1FWmUzUnpz?=
 =?utf-8?B?VkdyUW5scjdURWg2bDNlVURLZEFYZDV1TTd3b1BSRG1RZ0VCZXgxWTRjTE9N?=
 =?utf-8?B?OUFLdElJZHhJRk0xWnc2dnk1anZhN1B4cWh0eEJReWlCM1Rkc0d1eVM4QjBl?=
 =?utf-8?B?aFp3bHBvYlA4QjY1T1F6a1pCaGtBQS8vV05JdXIrN0JWOURZR00zUlIwTzBB?=
 =?utf-8?B?V05CM0VNd25KWkJVdXMxOFdoNTNkdVpaallTNGh4cktmdmpLUndDZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fc6ebe-dbda-4e22-6f47-08dee2180267
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 02:23:08.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5ZilxKZ3TStSFDt1ryhyF9qu1xYWIur6051LsbYO4xgnea47g3hIm54HAuLn/lXdKL5ju4+9wnqbz2GVqx33K8a95Cg0TiyQ/wG0iD0V5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB9412
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12537-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:sashiko-bot@kernel.org,m:neil.armstrong@linaro.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EE3675A0A6

Hi Vinod Koul,
    Thanks for your review.

On 2026/7/14 19:58, Vinod Koul wrote:
> On 14-07-26, 08:19,sashiko-bot@kernel.org  wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Low] The macros DMA_TX and DMA_RX in the global DT binding header lack an Amlogic/SoC specific prefix, leading to namespace pollution and potential build conflicts.
>> --
>>
>> --- Patch [1]: [PATCH v11 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA ---
>> commit 093f368eaa67418008421d43d724ce2e98651039
>> Author: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> dt-bindings: dma: Add Amlogic A9 SoC DMA
>>
>> This commit adds device tree binding documentation for the Amlogic A9 SoC
>> general-purpose DMA controller. It introduces the YAML schema and a header
>> file defining the channel type macros.
>>
>>> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
>>> new file mode 100644
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
>> [ ... ]
>>> +  '#dma-cells':
>>> +    const: 2
>>> +    description:
>>> +      The first cell is the DMA channel type(DMA_TX or DMA_RX).
>>> +      The second cell is the DMA channel index.
>> [ ... ]
>>> diff --git a/include/dt-bindings/dma/amlogic,a9-dma.h b/include/dt-bindings/dma/amlogic,a9-dma.h
>>> new file mode 100644
>>> --- /dev/null
>>> +++ b/include/dt-bindings/dma/amlogic,a9-dma.h
>>> @@ -0,0 +1,8 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>>> +
>>> +#ifndef __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
>>> +#define __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
>>> +
>>> +#define DMA_TX                     0
>>> +#define DMA_RX                     1
>> [Severity: Low]
>> Are these macro names too generic for a global dt-bindings header?
>>
>> Since headers in include/dt-bindings/ are globally visible and frequently
>> included by C drivers, unprefixed names like DMA_TX and DMA_RX could lead
>> to namespace pollution and macro redefinition build failures if a driver
>> includes this alongside other headers that use the same common names.
>>
>> Would it be safer to add a vendor or SoC prefix, such as AMLOGIC_A9_DMA_TX?
> I think this makes sense to add here

In the 4 version, I was advised to remove the prefix. Should I use 
DMA_TX or  AMLOGIC_A9_DMA_TX here?

https://lore.kernel.org/linux-amlogic/c47d44f6-3d0d-482e-b45c-7f6e98d9ac4e@amlogic.com/




