Return-Path: <dmaengine+bounces-12150-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1mVZH3zDTmqMTgIAu9opvQ
	(envelope-from <dmaengine+bounces-12150-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 23:39:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F7A72A959
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 23:39:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=J1IPZdq0;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12150-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12150-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A1D23054C5C
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 21:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC813F65E5;
	Wed,  8 Jul 2026 21:32:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527952E7631;
	Wed,  8 Jul 2026 21:32:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546358; cv=fail; b=C2v23HgWOWqZgN0UDf3IFEYCWJdkQXOrGYwKWu4bMEJen/mYijTGHhMyU07Q6ssEd9whKArC1nZWyDBZmtbaHmTvHVs5GGvgEmB4N5Gvl8BLHyF/DK8L+JoZ7NIOTSO4zSuIt5dYM0EYzl4CXeO6GpPQzBFstJAFol3YnjV4NWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546358; c=relaxed/simple;
	bh=PttzdIgsknMM06GxxYXoUzt/6/dNXRPRaRAaNgahZ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sO37UEP41Ks6mW23BnzQPK+y3hDrFlHJXWyhjUudk4lb5Uven/hg/Z0TNfiNjZrGBTYddDDiBaK3i36ZPabr0YhFHd15MLOOVcYPEd/luB6y3kJoYBetVrz2nvmGSsIUro0Lf8/QpFyCIGLwUf6C0hCJpJUrM1tp1pXZNfj/uXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J1IPZdq0; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBaU9CMrXPtJiJWKu9xZYwQ46C1uHiE1RcDVsB7FhwmAT8yeCDAWlukMcyHhMNprapzDR4++dBx8rqw/ackqSY5ot0hrIcYi8AuWgH008G1bErYJrF6qmY7pLELMjAvHN8C46gqUJtHCmtvU4TOEqBO7wMbYdUZlRSFWQDxov95AqkXvkouVBo8ELEemxNXkB00GoplvL02ihZSn5yItkeJbmJQNFCUusQ138BBd9AfXeuowSptnDmilTfzH8FJ32W5iR1Ndju2nh0oWsEkEJUwavVDfL8KhIqcvl5Q2/Taq166okPy0Hfy8+3hQLIOMr4XVxS53mjL4FyPMyh0Arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pku8GHPaxhSQ41SOECDhGw3a3aohHX3YGpZ/O7z1uVI=;
 b=XpQQnnnUS8eXQHx/QjcqGd7hn5vn4xkiD795i1YoshXS8H4XP9qz+tGAAto5NLqDG/qTvNc68kofzGvpdWsnAi44i3SHPKOlEaZzzDAEFxD5hWXfsVM7w7tgU/RY5HtxVkSU8B8fv6VGmODaiZzsSLwGDT+gnoNS4qW5tlmyUjjZe4ENu1I+Z7dGQuvlqrhCw5ErvRquHuHL+iaD8mK+beULebL/PoRkC3U9vz1Vs4jBSBPjJmEfUTDflUIGvKaKYR/bjn335AFL4NA497qhpb9QRcoAQurwNnzwp8Xp4XWKpE3ZnVl1jPud4qNLx9vJ9zL78V5zPxRHPY98RaWSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pku8GHPaxhSQ41SOECDhGw3a3aohHX3YGpZ/O7z1uVI=;
 b=J1IPZdq0Nn/0rcn9uNHt3mgG5V5Cg0SUGbFAdI9J38GeTRcFeEjW+SzXVJO6UYKUDkb7N6vkx6iXRh7Bs/mCjDFFx0JBb++GVnHFDDTH2T4KyzsMPQmMWKKEPTAwdlyMKa684FyaZ1uZunq4/zZVF6C6/geGsBhVxxkk87eLKEUztR79bmyj8y47YHpsLAHeeg8KIMDf3781bnIyaUH6/qov+gGIMmvkvVBcBJ4A2qdFE3oAC9ujC+YGpjK+g/9ClGRLRbzsLE05SBDLutPqYUVUREaGeQEr3aK39PPx+Ici55ONp67cQ7WY2kdMjlYX5z+8lsFTuDb7huanXxc0Yg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10341.eurprd04.prod.outlook.com (2603:10a6:800:217::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 21:32:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 21:32:32 +0000
Date: Wed, 8 Jul 2026 16:32:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: ludovic.desroches@microchip.com, vkoul@kernel.org, Frank.Li@kernel.org,
	tudor.ambarus@linaro.org, nicolas.ferre@microchip.com,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v4] dma: at_hdmac: Fix use-after-free by proper tasklet
 cleanup
Message-ID: <ak7B5gxc9LrMmxO4@SMW015318>
References: <20260708025959.40283-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708025959.40283-1-zenghongling@kylinos.cn>
X-ClientProxiedBy: PH7P221CA0045.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10341:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b003e5-ad7a-40f5-3384-08dedd386b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|19092799006|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	z6nDbytrhPQDHKO/xC6IT0g4XIUzP2LSWvlH0adQ/pI7UC3tAPLrM7RsSIF/f+sMn2Vbbp1U/dSa6YM3Bb7m5sxL4ifjAg6oSfB0PWcj84TfFBlUrvzEz1iiy18ZUtGxF9pJHm8CyD+ac+P0xT/OKRSCyi1HzmzIr2GoIlfwG6CVZtJx8nBMbq2kzVXrEA7lL5Q4wD4/EQ5RuIIfVdAGFfaDTND1fsJF57QbRWdAkZIZ3GZWfrdz0R8HUQ4gM+uATkU6Jcz+TB/O1NoGTq8q4/xhbkCr2+jdIfzF1NPYYdWCpATlkoIztEwetrsO7E/5BKjmFmVwF3CifJag6XqzI/i4VLq5H/K+uejo9FrpZGK8b3EtNfp5KU8QNVgWzq0iKLdORSRzNRCU/V9BNmit20h28K2cub/zm44Bsj/vUSR3tilJV3RcyOe9Y4k5Da9CwniMDjIr7MYMUQYWjlVkAv0la+/0EPmnbtaI/g8uPsAgeM5zT0pKFUrOzIEhdcU6/3TX5Z3fE5N1Pvw5OAuiSbCT+rXpasneJAEWTBaYzP4orsj++i/Pj1BqgevumhbHP+lbOtF+5K1PBDJ79SwTqsaOfDCzA3Kwq+zHgE0oj02Ta6obW2i0mflozx2nlRKOszsHON5i8suIvcSAbYysskJOMXKzwMWX0fGcxdZryo8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(19092799006)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SC9UWVB0RG8vbnZhVjBFOEwvd3Y2d1dsNmxOTDluSlo0dzJ4NXQxMWlkVS9N?=
 =?utf-8?B?aCtUMmpkTXJoajdtbkxXNzlMYy9WWUR1YVdsU01xZS83SXNDNkhEVmZVSFFY?=
 =?utf-8?B?SWpJMzZKWHk3K2hGQkROUlFJOStiWUdGeGJmaEJkSG9sWGozMXdlRURCYSs2?=
 =?utf-8?B?NWN2V3FiYk9kbmx5emE2ZWN0T1pIa0QxNmlPeUN0VXZ0NGhEaVMrZThMMktZ?=
 =?utf-8?B?RkNRVGlrTVoxOHpLZENkYjBTOG9GN2xDSmxuMzg2Y3NIamVlZ2FRNG1TN2hl?=
 =?utf-8?B?WlU1OGJScDBLU21uRUFmNmVKZFhVcFhZWkdBa0hUSWFORWswSTlJeEYvK3Iz?=
 =?utf-8?B?TG53cDR4VjFVelZ2ZEVJdzNSK1d1dGRnSEcybXZ5Mzg5RmJrdEF5OWVYakJU?=
 =?utf-8?B?S0hHS2ZQbmlCUVBWSVdNWnVteEowUkN3RnJGVnpsbkdJWkU1S001cGZFRmxX?=
 =?utf-8?B?a0Nla3JUNTlwVnlDSkt1T29lZmEvMU9vUnBSbzYrL2YxbFE0b0VRb2VqeTc1?=
 =?utf-8?B?MzJPaFBrc3ZEb1VxblZwSlUxYmNMQnFmMEZUTGxSVUloOTg2c3M5dnlPZkZk?=
 =?utf-8?B?d291Z2xYc2JPMjlzODJHTExWakEyeVZ2R0s1NnJqTkh1YXFMSDgwUEN0b0xk?=
 =?utf-8?B?YUwzblR3WHI1U21GSWd3M3Q4UDg0bHM2MlFyV1lnaHhGU1p5cjI2RzhiUkJk?=
 =?utf-8?B?bGFNWHVtdFdERTFCdGNSUHdRQVBMa21iMkRDWENDbWNPM0lMT1FOS3V6UW5w?=
 =?utf-8?B?L2VCSzVDUGRWRkNyMVBSRisxL28rNEtmcW02bVJ4Wit1OVJ0QzhmVmdHWER1?=
 =?utf-8?B?cVVzbHozOU92SEV4Q1ZJb3l0VVZRaTJNTFQ1bFJqQzdGaXV3MktRNlErdmtS?=
 =?utf-8?B?TUVMaHBZNHhkY2tGcXhneHBLaEYwYjVwcTNreml2N2NCbkIycXhaM3VMQWU0?=
 =?utf-8?B?L3d0N1lVeVZ3ZGVwbnBkaGRjSDhaaTlIajhmeFRORkpTZ3RZSHZyQW5Zc3JF?=
 =?utf-8?B?emlCR1EwNGM2VkRMUmtYdlhmNEhpWG5sa0RHWkZzcHNqOTQwSmFtQWVGMEVM?=
 =?utf-8?B?SStSek9jN2kzdkE2ZWhqZzdjMkV0aU5oNGJIaTdiUXY1OExxMXdZam5CbjA2?=
 =?utf-8?B?SkNYL2l0MEVWNXRIOTJLT3hlbUxjYXlaWTRGWURVQm1aTGxwa3dzVmJYYVls?=
 =?utf-8?B?ZEVNSk9PYmk4M0x6bUtZSlY1UmtFbVlpMUtuaGVmV3Z4TXBNRDZrSXRYWTBv?=
 =?utf-8?B?Ri9CSWMxS0JvbFIwdkxLVXdqOXJRc3VzK0NmcVFEa0VPdktKVm04SlAxRmNV?=
 =?utf-8?B?eVlzVGZYa3VqcDVWdjhWOVQ4ZWdnbTNmZ3lQU1hZRVZqRmxLUU9ObGIvV0Zh?=
 =?utf-8?B?YXo4WSs2Y2pkMFNHMjlGeDhuRmVPalFnMUhSMXZOUWNjQ09yTDJTTDVvbG5v?=
 =?utf-8?B?MC9NWTJpWmtGSmllYnlLVm1JUnlmY0Voak43MWtKUWxuTHpTMTcydHFFMFBJ?=
 =?utf-8?B?MHQ1aDI3Z1V4OWRkdTY5WUdrSHNrSGtBdDd6dzh5b2ZHMERhc05aUk4vTW83?=
 =?utf-8?B?NURucnlLb3JQZlRJY0pSTjZ0ZmdQUUM2RksvSHhhc05Pem1HRk1qaUhnUEhZ?=
 =?utf-8?B?T3NqczZxalk3YmNodGlRcWhtMHlFOFBGQXVDd3NQNFlxZFFDQm9sUlg0dFlp?=
 =?utf-8?B?ZEQ3dXhKcHZhb21LQ040VGpzS3FPY013eUtpTE9qVWE2SHVFTWRZNjd4ZE1x?=
 =?utf-8?B?S21uSG85SWtVQjFWaVhrcDJ4eDdXTGlQT01ickVrUzVmRnk3WmtzeDM1L3li?=
 =?utf-8?B?Sy9EbXpuanQxaWx3NXpXSm9VeXVWY1dDNEJUTFRaT3pKQnh4c0hYNi9OSW13?=
 =?utf-8?B?ckpmS2lzTi9KUHBNVGlQMndKRHhFYUo3elJXN3RVb291YWt6N0VNaFBSbjRi?=
 =?utf-8?B?cEtoOFM5SG1mbHZoRHBRVzVpZWlLTTYvZExpKzJna0pBdFJuTHBSZzd4dml5?=
 =?utf-8?B?UGZBK0dzRGRaeUhtR0xjOEJaTmlyWEpZeldnSzROMEl4R3hXMU1uWEFpZG80?=
 =?utf-8?B?YklxS3pUUjVkV0NNZVg0RGJsYzhJVW1id09aaDYxSHlKZnpsTU1GNlBkazVO?=
 =?utf-8?B?c3ViMVIvOHV2ZkN1VHRpcno2Zms0dzJZdEkyc01lRVlaODJUcmJIaWEyYzVS?=
 =?utf-8?B?ejlpZzR4NnYvdnpzVWVDTTd6TjRXQTRyWmFIRnRyWnpHaUFCUEpBaVYyUUdY?=
 =?utf-8?B?V20vOEc2Y2tFbldBeHBrdGdDOHRSU0JJam1OVEk2cU1zSDRHUkFCRXRjSzhk?=
 =?utf-8?B?MFg2TEozOVVlTEdndnhEKzJGK2lsZDlJZWhWQWYzalNzSnk0ZFZjV0NVSm9k?=
 =?utf-8?Q?Xjgv4IdnFxy9xjV0KuKUn8k/EDLmUdTSJlqlU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b003e5-ad7a-40f5-3384-08dedd386b14
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:32:32.1396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/IgggfYk6e4PNPbjrxo0jZXiu3js5SS/m3jEpsy3tDv8tDe+qHL8AKZaEV63fHAbjqke7Wsqqe2B7iRa/wJC6c+d/eojN9rEQjGoaWec/9PebsKK9fw5V0Rx7iGbfpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10341
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12150-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:ludovic.desroches@microchip.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:tudor.ambarus@linaro.org,m:nicolas.ferre@microchip.com,m:linux-arm-kernel@lists.infradead.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,kernel.org,linaro.org,lists.infradead.org,vger.kernel.org,126.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,kylinos.cn:email,SMW015318:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7F7A72A959

On Wed, Jul 08, 2026 at 10:59:59AM +0800, Hongling Zeng wrote:
> Current cleanup paths have a use-after-free vulnerability:
> - vchan_init() creates tasklets that access at_dma_chan memory
> - free_irq() only waits for IRQ handler, NOT tasklets
> - atdma is devm-managed and freed after probe/remove
> - Running tasklets accessing freed memory → Use-After-Free!
>
> The fix requires careful ordering:
> - free_irq() FIRST to synchronize with running IRQ handlers and prevent
>   them from scheduling new tasklets
> - Then kill tasklets to wait for already-scheduled ones to complete
> - Only then free other resources
>
> Fixes: ac803b56860f ("dmaengine: at_hdmac: Convert driver to use virt-dma")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260604073945.54B311F00898@smtp.kernel.org/
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>
> ---
> Change in v4:
>   - Fix error path fallthrough causing double-free_irq()
>   - Use channel iteration index (chan_id not initialized before registration)
>   - Remove unnecessary defensive checks
> ---
>  drivers/dma/at_hdmac.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index e5b30a57c477..044a0fb38b7a 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -1940,6 +1940,20 @@ static void at_dma_off(struct at_dma *atdma)
>  		cpu_relax();
>  }
>
> +static void at_dma_cleanup_channels(struct at_dma *atdma)
> +{
> +	struct dma_chan *chan, *_chan;
> +	int i = 0;
> +
> +	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
> +			device_node) {
> +		/* Disable interrupts */
> +		atc_disable_chan_irq(atdma, i++);
> +		tasklet_kill(&to_at_dma_chan(chan)->vc.task);
> +		list_del(&chan->device_node);
> +	}
> +}
> +
>  static int __init at_dma_probe(struct platform_device *pdev)
>  {
>  	struct at_dma		*atdma;
> @@ -2105,12 +2119,17 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  err_of_dma_controller_register:
>  	dma_async_device_unregister(&atdma->dma_device);
>  err_dma_async_device_register:
> +	free_irq(platform_get_irq(pdev, 0), atdma);
> +	at_dma_cleanup_channels(atdma);
>  	dma_pool_destroy(atdma->memset_pool);
> +	dma_pool_destroy(atdma->lli_pool);
> +	goto err_clk;

I forget the reason why need goto here. Can you call disable_irq() or
disable hardware irq and call synchronize_irq() at free_irq() place. then
goto can fallback to below clean up code

Frank

>  err_memset_pool_create:
>  	dma_pool_destroy(atdma->lli_pool);
>  err_desc_pool_create:
>  	free_irq(platform_get_irq(pdev, 0), atdma);
>  err_irq:
> +err_clk:
>  	clk_disable_unprepare(atdma->clk);
>  	return err;
>  }
> @@ -2118,23 +2137,17 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  static void at_dma_remove(struct platform_device *pdev)
>  {
>  	struct at_dma		*atdma = platform_get_drvdata(pdev);
> -	struct dma_chan		*chan, *_chan;
>
>  	at_dma_off(atdma);
>  	if (pdev->dev.of_node)
>  		of_dma_controller_free(pdev->dev.of_node);
>  	dma_async_device_unregister(&atdma->dma_device);
>
> -	dma_pool_destroy(atdma->memset_pool);
> -	dma_pool_destroy(atdma->lli_pool);
>  	free_irq(platform_get_irq(pdev, 0), atdma);
>
> -	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
> -			device_node) {
> -		/* Disable interrupts */
> -		atc_disable_chan_irq(atdma, chan->chan_id);
> -		list_del(&chan->device_node);
> -	}
> +	at_dma_cleanup_channels(atdma);
> +	dma_pool_destroy(atdma->memset_pool);
> +	dma_pool_destroy(atdma->lli_pool);
>
>  	clk_disable_unprepare(atdma->clk);
>  }
> --
> 2.25.1
>

