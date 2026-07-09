Return-Path: <dmaengine+bounces-12159-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d69bBN8aT2qPagIAu9opvQ
	(envelope-from <dmaengine+bounces-12159-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 05:51:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A453272C72B
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 05:51:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=bUjPJEcx;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12159-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12159-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948423056514
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 03:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597834104B;
	Thu,  9 Jul 2026 03:41:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354E175A8B;
	Thu,  9 Jul 2026 03:41:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568493; cv=fail; b=ax+W6JjIv82B4qA6aHOdCB20l25wV1KxFUWyK66bCEKCDflbxMU8GkEYdtKyHqVXznsS4ffxo2daY/Xl9xdRaKsq+bDU17vndN87k7JLFrDDtw2NXL6IoUNYmb2IXrR1GTxeu3cw0ysSzcEM2INfnWnaIx03LR+DNHEjqMMw3Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568493; c=relaxed/simple;
	bh=2PVN83OwO6BH8GbvMM8MLR5FadWA1S+W6JrNgWPkz/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qpX/Jg8R9750fU0wbG0o85MQNggCYfuT9HDVZVMTB792WyE47iT3BpECyt16WAUhlDoTv1QuLZAOAMoJOMGVNB9v2HdPqg9hNNsbT2phDbhwm17fWYvV06vG80xAZjpD1fwMgNv35T8wUciymnX7Eqtx4tZEOPKpkVPVPrPh7ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bUjPJEcx; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihPl1HojKaWWQnykh4WS7v21k9PYgduj932CS4w96u/UlNlUhVMvYk/Lg+/9JDoUVBliBZG5HseApEht/GhO9dZyCbWYVJWBD87+AWKYnvDlMCTaBw2B832DvGOMX2TB1csAL2xugQgg+yQf2GY/gGE0tsIQZA659I2oITep65rG8N/MHj9BXM3q4Gk/GmCrM6bUbdXCpxB5edU46+fnYDP3IGD6HcXU7s/ymdcbjqIq9tow/gSsVIqswrw9SA1kRZhWWHs2GMb8S532rJRYixQZPrEUyfxMb50mJJ0bCHDAPHQdRJlsSSwfPuAd/2MlxjTDjfvkLvnYmort8iXGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br6eRz1+0jMVAJ+soG1fj8tH1PIUweiaN6F5u7Vt8aU=;
 b=P+qbmoib2QHLTsI3OUpCQ0mVnCdiexMxMv0MEmmFT5A34f7ZB5p88egR0Gd9/q0d29AvnRnDeX3yLBshDyhjw8FGu2PqAvLv2BmxSNFfDi/qOJP2zDpIAALvlQy6UJq/VtccDCYLZRS/Gys5J4UrUfOxULoUqpdaH4u9tK08Xhh+EN04pgCbXv+JqvdG5E5hIkHF+nOfuNP5a0UYRT/5xNReZX99uMZUrJut+3RFhuqvGdN3IJinShS6/U7qJvytdFuecu43ZKgNZWJOnv4lBuLk5Y20iDwO3Cv9GWrrbQOmXDbHq3FpmIJo3qEgc8c3snoxcRD6D3Xp7jQ5K5wQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br6eRz1+0jMVAJ+soG1fj8tH1PIUweiaN6F5u7Vt8aU=;
 b=bUjPJEcxc8W166F3UkxBDWdOZGGig8CI0M6iJicUt4Ps4Q/7j2mEMabbmIdtf8BTKzhG0YafOfWHlbpaJ0LAHkSFrKU4yyPn9koF5gAjc9IcddTH6UFr+/QCelUPQNRboFcokvkPqmcLgWaRuGoqaQhq3zJSaHARbZQNA+3+1N9enqT1IRMwavVkYtuzcyXXeaTUv+78D1ovwu5eFCuFFCDOOWxw5klwXjFwo3MVXzf4t0EEU41SWR3l1D6xsPEeBBoMpC3qR9Ud0UaMmO6iXG20USixL0kFfMnvJN6aDeAc4NHv4HWjXji3xrz729J6pgMUq/kXCTYCGDhIxpxDew==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB12004.eurprd04.prod.outlook.com (2603:10a6:20b:746::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:41:29 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 03:41:29 +0000
Date: Wed, 8 Jul 2026 22:41:17 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: ludovic.desroches@microchip.com, vkoul@kernel.org, Frank.Li@kernel.org,
	tudor.ambarus@linaro.org, nicolas.ferre@microchip.com,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	sashiko-bot@kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v6] dma: at_hdmac: Fix use-after-free by proper tasklet
 cleanup
Message-ID: <ak8YXTE5LJO2GFfJ@SMW015318>
References: <20260709023922.645413-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709023922.645413-1-zenghongling@kylinos.cn>
X-ClientProxiedBy: PH8PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:510:23c::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB12004:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f285ea-d383-45fe-4595-08dedd6bf5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|19092799006|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	P1+bcgVL+11joEID+h9+Oy2Q8J1GOT6S3vzVl1OWniJEfr/lpJjwuHS5U0W3S90kEGOOsDhqf05HQuhh040TFuKo6xUWcy4QDvNP9qaMAe0O/Mg5tc0N5Fo6UnuyXoLcDARakGX5ugwnY++rfWrKcTgQdcNshJte1HP9eiBPmEQVWsWtUMSgAV4x+YECl6VHelxN5BuFN8aniLXAZaFFlFAa92zivVyYpl5QlrzfU+LNFv506SR7ICm5cx9r176DWnA0S20BHZy7lgXySETmCkolmPWtoGaBs7NUOLW54KD0qIf6B4t4SVYTSGAyLk+zCK5ZMwN5l96CW7jnpRO5aZNuPpLP3BOaMiLEZFYmFycN50Giaje+/si0dxE0axVCBR24TAh/3NheAZWi0Ky+NxVplHOH9+ruH1pccAg7sSHtNSW0ek+g7UZjTYtSdW3Nqh5jGzoXJFIx0M2YkS6jEJKDLFe5aqvX2xHjrXLDimutwhcvruscxGkwV57c1xhX1HITmCTN6MmagUrTU3fpHEHgqlxGWJa+gDr+lXGHqi7cZrWtSmDyGNkv9WxlyigbFzeJQQxiHnghHq+iQ4zZ9bcCUyT9zyrKpXAJ3I2jxbAUL+Lg1VoVdAltVRAVABJjS6wbLiBCfAsKNrfoEoT2vxYBnJ1HZxDUD1cnejxMNks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3JhdUM1Zzk2ejNQeVNFZHc4b2MyUzBodTdGL0J6akhPcFRMUkRtNjRvWitn?=
 =?utf-8?B?Y3FiZUdRTC9YZ0RxL1NVdmlVUmQ4MUlnTndmaUtvQzUrV3R0eU11ZTVySUdE?=
 =?utf-8?B?Z0krOE5lZGNpRGFuUzBlc1h3WHpqQXIrODlaZmFwWGZKdVVVRzMwQmhLVWpK?=
 =?utf-8?B?SnFKUzJnamxucE1CZUJ2eGc5V1Fhd2FURmF0Yy9MN2NFMU9GUGRlc3BVMWVT?=
 =?utf-8?B?dTRBRzF4MlNkK0VWRStPQW5mbmpub1pmMGtaS29FdzZVeDAyQXJEZjZBenEy?=
 =?utf-8?B?YWhrbjRiaVA2bEJ2Y3RUb0xZNjFJUWRrVEwxc0pvRUZTdzNhc3JFUkJzN2Zz?=
 =?utf-8?B?T3NZY1BnMGRzL3JRRkRYUXZhbCtqbFlmbFd0dVJSYlpUczR1MU5yc3Q2OFI5?=
 =?utf-8?B?bGVYeHUvSTZvU0lRaTNYQmFOQlFsRVBXTkI1Y1FiV0RocG9lZXNGbnlzaldE?=
 =?utf-8?B?YUhrMnMybWsvd2tYeW1BcE0vdjl3QXhaWldoRUp5M0pXY3p6b2pKZC95dmNu?=
 =?utf-8?B?ZUd5UDloTHZvRHhheFJsandTNHh5WEJTVlhidEY4eDFzN2g4Sis2MG40dVRx?=
 =?utf-8?B?WjFTeURHNkkvQUlRUWpldEVhdXN1cmFBYnNkdkZ0ZGZBS1BNeHdwQTJxSkNK?=
 =?utf-8?B?M29DZjIwTGZKZG5zTFV1bERQZ3lyczFNMC9MblhDQ0J3RU5IVlo1ejZoMjk2?=
 =?utf-8?B?YzVyUGVpUFowUXNWSUNORjNtRmRnbjVIVE9MSUtyYXhQUGorREhGbEw1T2xy?=
 =?utf-8?B?K3ZBaUdUT0gwVVJrTHRsWnpkdDYySzRsZlZzMGg4a01XbFhnWk1Sa1VCZlZN?=
 =?utf-8?B?dzBrRmNxYnhkcEg5TW82bk0yOGJubU5WdU5NQmdXN1kxMmJXU25DNm92dVJV?=
 =?utf-8?B?NUpEbWwxaDI1b1R2UTdZTUc4bGpCcU5LdjA5VUJQMnZVMWl1RzRBMXVPUmNj?=
 =?utf-8?B?UThjaW0vaHl1OERMelFwZHFXZWYxZUFxQmZhblllVzhLTlBKclMxRzJOVmYr?=
 =?utf-8?B?ZmdhL0pVN3RONGZVMmlpWWUzMWI4MldCZGU2RmVERVlCM3pYVlVpdmdUaTNW?=
 =?utf-8?B?aGVYSmREamExQk1Ca0lEU1UzRm1VVkx6a3diQXNINUZKbndjWmU5eTdRSkxQ?=
 =?utf-8?B?VmlyMnlpS0lYbVZDVVM1YUE5L3lEWEhrek02Snh0bFZ6TjZpMlVMTFhxNStJ?=
 =?utf-8?B?M25OZEo1WHBDYWNjRjkzTXNtelplVzlOdFo2OWo4U2plakhNT0tBN3RGQ1NI?=
 =?utf-8?B?RUFHWUN1OUEwakpWYkwvMUJjczE2NFlJTjVrVWRwSjN6dnEyREd1N21lcE5s?=
 =?utf-8?B?dWYyMWJyaWpLbVJIRThoOXdtUFVDYklCK2lCbE4renJFMWYwbWM4V2g2M1Nj?=
 =?utf-8?B?T1g2U1hEaTBHWFZkWXpqMGh3QTZPOGlMMGxXd1dWTjUrc1R3aGpaZ25FVDRS?=
 =?utf-8?B?aGZWblRmckhTUXFCTnprdHBjWmZ3aENudGdtWGdxcTR3SmwvOHFaNWV5OWZq?=
 =?utf-8?B?NmRKTkJ1MEphZnYrT2JQVEduUCtOQ3FNMm5PdnFnRFBLSXM5VjBaMmF0eW50?=
 =?utf-8?B?c1NibkY1TmhqSXp3bk1pdmJCdjBRREZVcnlpdDh3TjhTK3RydFRHcit1YjlO?=
 =?utf-8?B?eUgwa3IwbXo4QlB6OTdVaERUU0psd0RLM3YvZzNYQVBOZnV0MVdDek1mOHNF?=
 =?utf-8?B?eXYrUVUyL1B3d0xnWlhyNG9sYXZJN0ZiWUM0elVqL0QxV1Q0RVJ0U2dqOVJ6?=
 =?utf-8?B?WXk2bnRFTXZIbW1na01NRlpaamIrWUg2MS9VQzJURUloZFdNQ3hkNEJWc1F0?=
 =?utf-8?B?bVlzcDk5QndJTVlDb0FCVXFTM2UyOXQvLzhnVmcrZWRaMlhJVVBUWldwajh0?=
 =?utf-8?B?MVM4QnVza2luUGtpb1NTZEhPVGNyVHh1TElXRE56Z25WYktsYm9DL2o3L0xV?=
 =?utf-8?B?bGpwTnJCb0hDQThJYy9Mb3Fac2QwWW5jVmNicEFZWURSUHR2QzVyRjFoZGRn?=
 =?utf-8?B?ODNOQ2hxVy9RaDFXZGl1dWdSak4xVUhuN2l0c0ozbkdoSlVXeTgrZ2M3UGJt?=
 =?utf-8?B?S3JDczZ6TFEzMXhkQmlxdnNTaS8rNE9TclpLdEk1ajU1OUNkZENoK1RweWlZ?=
 =?utf-8?B?UW9qcmZobVo0QWpDMkFMN1BacWIzbmJwc1Naa3lkMlgyUXM3VmRWb2lLVUlP?=
 =?utf-8?B?ais5U01vNkI4VWFPZExraXp1V2YwT3UyN001aFZiZ3NqUGJ0cVZmK253YVFj?=
 =?utf-8?B?RURGazFEaXp3OElQbXU2ZmRRVWFURHNDS2VsV2lIbVUxKzJkeDVCMEY1UFFR?=
 =?utf-8?B?UXI2VTJmS2ZrRTB3MzNERWhqZDhiNFFGaUlRcVVldDBWUUJYcXFOS0g1bTJo?=
 =?utf-8?Q?pA2bYs0iSby8rt972mUJV1D8h5I/II/82T8K6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f285ea-d383-45fe-4595-08dedd6bf5cf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:41:29.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/062wIioaXE7RIW1+A/lw6oIY4d6kSudgw/tDPZMTKwAByfXjAfm3uK61++tXYDTVH08guxl3t/DFj2cDu2wJPtDML/WiLBoAt9GAx8c9Aq26gnRk5H4ebJPdHGs0hN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12004
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:ludovic.desroches@microchip.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:tudor.ambarus@linaro.org,m:nicolas.ferre@microchip.com,m:linux-arm-kernel@lists.infradead.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:sashiko-bot@kernel.org,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12159-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,kernel.org,linaro.org,lists.infradead.org,vger.kernel.org,126.com,nxp.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,nxp.com:email,SMW015318:mid,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A453272C72B

On Thu, Jul 09, 2026 at 10:39:22AM +0800, Hongling Zeng wrote:
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
> Suggested-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
>  Change in v6:
>   - Replace free_irq() in error path with disable_irq()to allow natural
>     fall-through without goto, per Frank's suggestion
>   - free_irq() now called only once, in err_desc_pool_create label
> ---
>  drivers/dma/at_hdmac.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index e5b30a57c477..09b1aedefb45 100644
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
> @@ -2105,6 +2119,8 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  err_of_dma_controller_register:
>  	dma_async_device_unregister(&atdma->dma_device);
>  err_dma_async_device_register:
> +	disable_irq(platform_get_irq(pdev, 0));
> +	at_dma_cleanup_channels(atdma);
>  	dma_pool_destroy(atdma->memset_pool);
>  err_memset_pool_create:
>  	dma_pool_destroy(atdma->lli_pool);
> @@ -2118,23 +2134,17 @@ static int __init at_dma_probe(struct platform_device *pdev)
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

