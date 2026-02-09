Return-Path: <dmaengine+bounces-8855-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ep7INwPimlrGAAAu9opvQ
	(envelope-from <dmaengine+bounces-8855-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:48:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2239F112A6E
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87AD73006451
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D908385539;
	Mon,  9 Feb 2026 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QrzubQ+X"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6B3816F5;
	Mon,  9 Feb 2026 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655705; cv=fail; b=C58PZPcN8R2WwqQYOPeVyWjjOdNBt8l08J6YsqhZmEiIwmivCxXx7ZJXI9D9q5m7acdGg1nl0Eq2JDd4V8T3a/Dj+f7VJkp5+hPKLYkKjfz0+UnWr6cS1w5/0k59hvDyEsR+i7AUCCfVtL1NRiQxaPemsQuExbDOapUQJ0orhtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655705; c=relaxed/simple;
	bh=lkHSn6B8wDdqZyvc3DYe66Aq1dlWejhnPOwTlBEiArY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I7/sYJ7k1fHGAnlsVQukkrnjO8s3gK1mZYZ1svULPJOwKREOFlWLWPu0HrVMUWu9I0fM3kYsxSgPQzWTZUkrhXKBLE2glZGzoqVrSxJ6l3rzvdKA/mzv5bhSiB85t7IDkVhHb6enn/WnTdHlRILEFTEsu/Kgy4872OCRp5Tu0Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QrzubQ+X; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBcRgQZuEYa5mFJK0cIyoQ0dGFZmPXA+zs31jYL6j33doA/nJeYdEOR3WBHBWGY3Lmmh9yN+XbLfA/MktkbpoLuhHk7T+DeMIFB9uiye6PtUq4OBNdBKUNWjqwAoU0Jg6DmYVVPCtpkexgFNzbJ5/jARJk6y12cGkxdyTLbd4LqPH/IzZylHiV49C13iFXzTDbUGoZkJOxBDgwl9HOOzqK4DAZObdVWMSI26LYvU2/DkyocTHqGHN1gWMPBIsKk1euOt6BnN1YYWoKNMGcUJPjwhDoYzaqe5NAipsKv08RjscIu9gQcPUKHA5tZ+No/5FIabKR5jRUqZ2ZKiiLlNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6ZCAQZjrf23K0qnN/0FK9RQcdEaSqS+ztf2Q+Wea+Q=;
 b=OBP1fPvb3HvccqrLbv8Iru/6OIkGQCBrXjRFOPj7D2cwY0akSrr9QX0TC9TN3JOz6J9MqydFgSkbVpW51EGLH6lgda0fdAhl5Wt0NOjrMs3UzIXBw0aJJvcS33flRBHnWdUY/81+6iYk681WdqLaewE27fmO7Loq581G5IytHRuZ4XnV+Blh9+1cn+8Xo2TzqnE56iUf+Li6QEgoRLusCrIvIDNnYJ+RjV1dC4TTnjhawiuxxt5Q0WA9iAjYCqN+NCfxx0bjB8tfgT6JJP/zZp83uXPYL6SbZjJHpDraSF/6ENc25vnPHUNWs3xMOObZrcvgQBgjI881h/BFT9C5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6ZCAQZjrf23K0qnN/0FK9RQcdEaSqS+ztf2Q+Wea+Q=;
 b=QrzubQ+XfqyQEq3uMiwGSuqq5Tga9iClnm6HeT4X100YqtVlWTCRLfGHdkaXAYcfq3/yYdYNHLV3Yv5mIdihayh70rCish2ccyrzRiK1g3q+scPuyTtuyDSyYNnRv1TCGAOZzOgoYsHuP3qGKjKPguDlVappAvJA9Oa9DLGrmwuFGkfr6/Q1fBN3MYc8KflttvJYkXRTJYqvY7FgtqtvgEaok0Li+ocmgai2uPtQiEkmDVQaCNljVQppVG1CZ0arHXmeR19JJHmued9+qY6SQ95gRwgwK8yUAAj1Z2MNnOA7D/YNA/4SdCVuKbjCYuNgOOyFTzEpWcGj8LtLbgrT8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB10561.eurprd04.prod.outlook.com (2603:10a6:150:227::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 16:48:20 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 16:48:19 +0000
Date: Mon, 9 Feb 2026 11:48:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Xiaochuang Mao <maoxiaochuan@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org, jeffbai@aosc.io
Subject: Re: [PATCH v2 1/4] dmaengine: loongson: New directory for Loongson
 DMA controllers drivers
Message-ID: <aYoPyWS7o27G-AHh@lizhi-Precision-Tower-5810>
References: <cover.1770605931.git.zhoubinbin@loongson.cn>
 <d62faafc653efab602c8d6bfcdcee1cb217171b9.1770605931.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d62faafc653efab602c8d6bfcdcee1cb217171b9.1770605931.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB10561:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab0b3a6-dedf-46ef-ff1a-08de67fb07aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zgULMXwN4GiCeKOxuQZ3HmT8JKc0vAPxhbajuo3nYI7l7mqaDbrBMhSpJ0Ky?=
 =?us-ascii?Q?5jsTzVbnJCRw5/fuNPdIV96kcf/2sG4zKyiC9ju1Uis4z9UXFuZV0yVigxwD?=
 =?us-ascii?Q?JRN6aK3fbKq1pB51kBK7xKsztU5e6MSmIfQlvYuuklwcsRAaOHr4cVqJMqZ5?=
 =?us-ascii?Q?Oy0N/EX3Bl1XyOV53s3DqsgrcnelffMSy8FBOT5K5KtOTB7XxEF/ScnbTYN+?=
 =?us-ascii?Q?9J/l+y1g01R67/mAQO/yrhBXdM6dhuwAPIeV12xe0jT1pbtmOGa3UyF4jm8q?=
 =?us-ascii?Q?1trGQazJRCJoU+QQfwf/9TouvxVg4fFzu9g+N8pVAFbuoOuAVltq46KVWeMY?=
 =?us-ascii?Q?LKajYCnGvCInduvRf8C9WBz5+lq1V+EBYO9Lz8Y70rvd/iFx9fNrhdWPUHHm?=
 =?us-ascii?Q?bMJnqk0ESuQcnp3QDIcG8R1EzMT0kIg8ouXXa5lO24Lh1KoDDim0z4sXMLfZ?=
 =?us-ascii?Q?n2pdqB4+Qso++xBrnvN+I/DMdEusYJ/kmj9dGuMwEm8KMTVjncDe7FsIGFTs?=
 =?us-ascii?Q?MyA8Hohqy2fDDvViOOsxuWNMJ1KCfu8qqF8j6RM+uP0PLD5cU2pNJVvUh/RJ?=
 =?us-ascii?Q?T6WHezJHn6BdM6P/Ixwmd+TU558nP0BnO5SxW69fxQKDj4H8EGd9z7ktg79k?=
 =?us-ascii?Q?qcDgWcOzFiAis/zY/3H5LClUXSkPZLYlmev2N76s8nuX+BFIglite+HUYKhf?=
 =?us-ascii?Q?SsBfMjjB9ocqxp0x7eOh9lcgulS30csCM91ZNcLtLD4X6VI8UQ6eYkSV1cVG?=
 =?us-ascii?Q?xjyNVCbsbB3Lkv5jInF/pBPk65qf/kVBK34plY2Lx8GpBH9+WLiOAUjajc+/?=
 =?us-ascii?Q?sU3eSVGwoupjP9qhHavUAzMq+yDYcXSH8x4WCnPRBgylZMUE3NeqY2hoXVmF?=
 =?us-ascii?Q?bS3t9B2hO8gidyYKL2/1tPOrUY5R+M36M9VIYLkfQmp2LaMspp5Vp/D437lN?=
 =?us-ascii?Q?RKvzpuLiCv9ERc0fRSiaatMv3662pB0g2VE/3iWSpkKDK/t0eQWMJXtBLfMy?=
 =?us-ascii?Q?eeHzyViCQ38SO3lec1VygpcNekVNnEi5uQWwsUnn7HlyZMop09id3KHzrCZ+?=
 =?us-ascii?Q?UoZvSdCngNfYIIenF7OJBHxtoIzR6qjEdrQl0wNKJzoaacXTuAGN29lKACBU?=
 =?us-ascii?Q?lEr7zOJxduisdScbvKYq58MpDPGyEp6C/yNf3GswbveDO3sPb4NDIVnf0t+T?=
 =?us-ascii?Q?Wrvou0HAUh8NeU0ivBzvRkpCbk6UnG8TzRw+WNIRS/sDJok5UOXPRLiEUyC9?=
 =?us-ascii?Q?WjrhtJ9DPudEhnmxilrxuX+wwpaTyIiuD32LA+EApeXwNjcz8ZwSFuA5tq/H?=
 =?us-ascii?Q?gyKS3Z/TPPaf2dr1N7N7g6BIYVOf9jzGrbqkKfCvGAPwBYs5qlcpUwBRDHWj?=
 =?us-ascii?Q?JrEVROGaB+oc+mik8gvOKS50BjMxhNRFZIO/8p0HVwNe7QIEzEk0Utw1pkqw?=
 =?us-ascii?Q?q4gihtRzkh9EJoJkmdaAXI5lQaAUSBZtq4b2dFxEydWQjkwh0vPEtqD0x00S?=
 =?us-ascii?Q?/NY//n09knAYPPR3M+PJ9Cf/Q6gg/DQk8QqTUBZjpHdlKMfSC3s8ITpMrcra?=
 =?us-ascii?Q?VdAfmoJyNwXGlY2/18aPxQ8Sj0GZsEWOCQFFc7XEw7SjERX5q0HlOqBNonxm?=
 =?us-ascii?Q?fg06oObTpIZYu9IAHhNECXg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dGDpjeYD1Fe2fbzM+KwdmRwoseHrfWufX18ZNUYgrj2qHB3w2Tw9jmxoekaG?=
 =?us-ascii?Q?60w5+w3X1Qdx+XJ16pt13S5n5FCCuNJRmv9PrdcTtzorX0aa7kJAADa4EnHe?=
 =?us-ascii?Q?fA5FtJRFTuOKEr8M+wM9b+TUyheJPzLsqH4qB+VZdW4/i+TvZAvCUFiMdryE?=
 =?us-ascii?Q?/rcyCQ3u4OsBg582bsJ+LP6fFX71xAGlWkAcxMnthOwhiQCHQpuwgC0ZTHSO?=
 =?us-ascii?Q?ixCM5l8PrruNarEcQCnGOhSE4MmaPICC6DWmeBsi3fGP4OJgG069llWrVX2P?=
 =?us-ascii?Q?cxz2VROIczYrydrOp474XKVtDpfd34Pfft5l8QJdET/LCmG8ORX+08cC2QtC?=
 =?us-ascii?Q?23QDWXQ8FM/A+oQ6vNmkEXiVrxhkU9j8da08Q8mmUHUgh5+7L9ac6zW4jek2?=
 =?us-ascii?Q?vze6xZazGS1Dh2lZVCgKGsCsVKqO3mKWh+zJWMXNzccg5GXmYwgfdunFZ69X?=
 =?us-ascii?Q?hKzQ8q8iY9LGlMDapVAeY+hlrb1tP4HC5DexSANi+2CMCb6QFe9eGovdltDj?=
 =?us-ascii?Q?9gwxqnRlJBVI+e0fDr5t5E9BXwjlSPhFuuo2okOqwnsMQZ3WTGYM6lk8EY/7?=
 =?us-ascii?Q?BDHr5KJM66pz+iazpdSCRXX93XxBOtjfgpBIaJOzj4JaI53hN81U2URkpyk7?=
 =?us-ascii?Q?Uo37F68HcV6QVdoVs1RTEXNCB8q3nxi9wgeXdnUV1GYcotEU1XyFiozZ8fv/?=
 =?us-ascii?Q?fLwu6n4fbI/O3ApmoQlr3E7vVhA/ET6AGNUx0OZ1qTlmtGnUK00p35jkQu7z?=
 =?us-ascii?Q?h2eefmZT96naKv6dq+rWRZWQcwJmyZDXnS1WLz1iQithT78fadiPWDNMyJW9?=
 =?us-ascii?Q?zhBUbj9RYoNd6keVAF19+IEQxdGSH8xyCVNlfEy2bjLwUeI5QqLhxOrL9z0W?=
 =?us-ascii?Q?L022qLMh5swLBeEiYtTWPPyuStyskdYMYVLe6Z+cPzm701r+CQZBlZVDVcfo?=
 =?us-ascii?Q?GQTG8OlA35q5vJi8m2hYh/TOss1truUi3bOJBWRTxMhDbIXMKR15C4DbGA4L?=
 =?us-ascii?Q?fuMaNvoWtuhsdjYos6E4d2PHxmNzt1lcnNFbYSO/kSZePmWecpcWLZguhbDm?=
 =?us-ascii?Q?tjHMa9qMeu2h7G7aSpLQVOI0LRp4fXVhsyuX8KdKBew6m/bFHwjUlMtMzHT5?=
 =?us-ascii?Q?GBaS5nTR9sRovdfPoCClGxNz2g+S2G72j9T/kbEOs289zBJVkZOeeRZ28Fyx?=
 =?us-ascii?Q?4egVsLGzdD2ghTZV7x2kVv033tf1HWWkXwI9ajcvX5rjh9ihKWZb2915IDq3?=
 =?us-ascii?Q?sC6KyeiTc6XaLplxfqBr8wa+hyQfoKY3B9v78MRvlaHbzidxEyuq0LYS/K8D?=
 =?us-ascii?Q?ciLWfFzyMIRezDGDO2hP4A7idaIUeIOXOn/4TPHqSk84GBjFaJXDb3gek3NJ?=
 =?us-ascii?Q?dXhdo+uJumf4wg6Hb9ah6F9PM30p/KreYwm1Trmk21LJuYvl4eezuY+1TkPm?=
 =?us-ascii?Q?gkfisQil69kmlRaiJUWi5WACSEVTASgkHpYROg7BRehT0YtQ1PfY74yxjfP/?=
 =?us-ascii?Q?c0v7lG+V+3/OohH9a9i/CxtU1Ce5GVfYuJ81j9Cxp9S2WSEjeEnxINoPDUHI?=
 =?us-ascii?Q?buleKOFPXCKfGid0GW8BgPGtq/mwxoFzPEIUN89CdnNtDc7uFjDzfDOEWUiJ?=
 =?us-ascii?Q?J8/W31VX6HUaVO0+PAbzRs1wFs+17PaiLTgI1aCeVHywDzmvkvqgUxYkAksK?=
 =?us-ascii?Q?q3Q+iz3d9Jez6ywrsDXsjjhGBSWibJgBrCXFwiRA9UcuV6EvKwQ0nWIZg965?=
 =?us-ascii?Q?TrJKcwuyCg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab0b3a6-dedf-46ef-ff1a-08de67fb07aa
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:48:19.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heogAK2OqCWn27cvpRhfc+P80276rA2tWPUxn5CdRJ+o/S1QpeG+DFGClbP8IeIujMKDe/Ys8A9+OLLvaOXRUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10561
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8855-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev,aosc.io];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 2239F112A6E
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 11:04:18AM +0800, Binbin Zhou wrote:
> Gather the Loongson DMA controllers under drivers/dma/loongson/
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                                   |  3 +-
>  drivers/dma/Kconfig                           | 25 ++---------------
>  drivers/dma/Makefile                          |  3 +-
>  drivers/dma/loongson/Kconfig                  | 28 +++++++++++++++++++
>  drivers/dma/loongson/Makefile                 |  3 ++
>  .../dma/{ => loongson}/loongson1-apb-dma.c    |  4 +--
>  .../dma/{ => loongson}/loongson2-apb-dma.c    |  4 +--
>  7 files changed, 40 insertions(+), 30 deletions(-)
>  create mode 100644 drivers/dma/loongson/Kconfig
>  create mode 100644 drivers/dma/loongson/Makefile
>  rename drivers/dma/{ => loongson}/loongson1-apb-dma.c (99%)
>  rename drivers/dma/{ => loongson}/loongson2-apb-dma.c (99%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f630328ca6ae..27f77b68d596 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14777,7 +14777,7 @@ M:	Binbin Zhou <zhoubinbin@loongson.cn>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> -F:	drivers/dma/loongson2-apb-dma.c
> +F:	drivers/dma/loongson/loongson2-apb-dma.c
>
>  LOONGSON LS2X I2C DRIVER
>  M:	Binbin Zhou <zhoubinbin@loongson.cn>
> @@ -17515,6 +17515,7 @@ F:	arch/mips/boot/dts/loongson/loongson1*
>  F:	arch/mips/configs/loongson1_defconfig
>  F:	arch/mips/loongson32/
>  F:	drivers/*/*loongson1*
> +F:	drivers/dma/loongson/loongson1-apb-dma.c
>  F:	drivers/mtd/nand/raw/loongson-nand-controller.c
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
>  F:	sound/soc/loongson/loongson1_ac97.c
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 66cda7cc9f7a..1b84c5b11654 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -376,29 +376,6 @@ config K3_DMA
>  	  Support the DMA engine for Hisilicon K3 platform
>  	  devices.
>
> -config LOONGSON1_APB_DMA
> -	tristate "Loongson1 APB DMA support"
> -	depends on MACH_LOONGSON32 || COMPILE_TEST
> -	select DMA_ENGINE
> -	select DMA_VIRTUAL_CHANNELS
> -	help
> -	  This selects support for the APB DMA controller in Loongson1 SoCs,
> -	  which is required by Loongson1 NAND and audio support.
> -
> -config LOONGSON2_APB_DMA
> -	tristate "Loongson2 APB DMA support"
> -	depends on LOONGARCH || COMPILE_TEST
> -	select DMA_ENGINE
> -	select DMA_VIRTUAL_CHANNELS
> -	help
> -	  Support for the Loongson2 APB DMA controller driver. The
> -	  DMA controller is having single DMA channel which can be
> -	  configured for different peripherals like audio, nand, sdio
> -	  etc which is in APB bus.
> -
> -	  This DMA controller transfers data from memory to peripheral fifo.
> -	  It does not support memory to memory data transfer.
> -
>  config LPC18XX_DMAMUX
>  	bool "NXP LPC18xx/43xx DMA MUX for PL080"
>  	depends on ARCH_LPC18XX || COMPILE_TEST
> @@ -774,6 +751,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
>
>  source "drivers/dma/lgm/Kconfig"
>
> +source "drivers/dma/loongson/Kconfig"
> +
>  source "drivers/dma/stm32/Kconfig"
>
>  # clients
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a54d7688392b..a1c73415b79f 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -49,8 +49,6 @@ obj-$(CONFIG_INTEL_IDMA64) += idma64.o
>  obj-$(CONFIG_INTEL_IOATDMA) += ioat/
>  obj-y += idxd/
>  obj-$(CONFIG_K3_DMA) += k3dma.o
> -obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
> -obj-$(CONFIG_LOONGSON2_APB_DMA) += loongson2-apb-dma.o
>  obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
>  obj-$(CONFIG_LPC32XX_DMAMUX) += lpc32xx-dmamux.o
>  obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
> @@ -88,6 +86,7 @@ obj-$(CONFIG_INTEL_LDMA) += lgm/
>
>  obj-y += amd/
>  obj-y += mediatek/
> +obj-y += loongson/

keep alphabet order

Frank
>  obj-y += qcom/
>  obj-y += stm32/
>  obj-y += ti/
> diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
> new file mode 100644
> index 000000000000..9dbdaef5a59f
> --- /dev/null
> +++ b/drivers/dma/loongson/Kconfig
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Loongson DMA controllers drivers
> +#
> +if MACH_LOONGSON32 || MACH_LOONGSON64 || COMPILE_TEST
> +
> +config LOONGSON1_APB_DMA
> +	tristate "Loongson1 APB DMA support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  This selects support for the APB DMA controller in Loongson1 SoCs,
> +	  which is required by Loongson1 NAND and audio support.
> +
> +config LOONGSON2_APB_DMA
> +	tristate "Loongson2 APB DMA support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support for the Loongson2 APB DMA controller driver. The
> +	  DMA controller is having single DMA channel which can be
> +	  configured for different peripherals like audio, nand, sdio
> +	  etc which is in APB bus.
> +
> +	  This DMA controller transfers data from memory to peripheral fifo.
> +	  It does not support memory to memory data transfer.
> +
> +endif
> diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makefile
> new file mode 100644
> index 000000000000..6cdd08065e92
> --- /dev/null
> +++ b/drivers/dma/loongson/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
> +obj-$(CONFIG_LOONGSON2_APB_DMA) += loongson2-apb-dma.o
> diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson/loongson1-apb-dma.c
> similarity index 99%
> rename from drivers/dma/loongson1-apb-dma.c
> rename to drivers/dma/loongson/loongson1-apb-dma.c
> index 255fe7eca212..e99247cf90c1 100644
> --- a/drivers/dma/loongson1-apb-dma.c
> +++ b/drivers/dma/loongson/loongson1-apb-dma.c
> @@ -16,8 +16,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> -#include "dmaengine.h"
> -#include "virt-dma.h"
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
>
>  /* Loongson-1 DMA Control Register */
>  #define LS1X_DMA_CTRL		0x0
> diff --git a/drivers/dma/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
> similarity index 99%
> rename from drivers/dma/loongson2-apb-dma.c
> rename to drivers/dma/loongson/loongson2-apb-dma.c
> index c528f02b9f84..0cb607595d04 100644
> --- a/drivers/dma/loongson2-apb-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> @@ -17,8 +17,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> -#include "dmaengine.h"
> -#include "virt-dma.h"
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
>
>  /* Global Configuration Register */
>  #define LDMA_ORDER_ERG		0x0
> --
> 2.52.0
>

