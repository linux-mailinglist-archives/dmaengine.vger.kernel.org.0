Return-Path: <dmaengine+bounces-8856-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH1tC6YRimlrGAAAu9opvQ
	(envelope-from <dmaengine+bounces-8856-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:56:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EA8112C06
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEC6D300820A
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34373815C5;
	Mon,  9 Feb 2026 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SFxJfVZH"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7481A3815E5;
	Mon,  9 Feb 2026 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655913; cv=fail; b=XUMx7V61/n9/PpqMHZZUDxs9twwXLPUDeOMftPWVIO1jWMLwJ3RWvSQvH+5Bz1x9Olj8zrbsAqTpj29QuF4aZTzzkA1VuxvtvBoD78XpOK2oUkWyACZAF6liwzq3WuSNuO0dW2OfRFSD+MNxfD8MZ5oSlsBKyrFOVjGezknx65w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655913; c=relaxed/simple;
	bh=Hb2iYvSulSQQ1WCaNLYapzYMbzNG6zVNIM2HdSufI+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mt8Sbz/FrY1dd87a0WU+yIxtnLBSPoRlqUGdcdI7JD1d/B7I8wYnCdFyIxyRWI4VEgHHNehvg6dD/iMlQ7rIwwTbIG9uoLhfsW2chLF1IYrfTmUUiVdc/Ye9B44PJWw1XG49Q+RjZeaDWOq8kLtKz9TZWwGNsfqslYbpBCquff4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SFxJfVZH; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+uf34uwQGLOT6U8DtCUOjfz0EH2tiGrtxAuuGINvow+RV+tPAGP4OoGKmkdmwPg8+WLGu3O21Gc5tJEczSTuRCwCkDbLEEkhFaDAh5qJJgbDjGA75NEVuHge8glkynymd5NL72iioLC4UOZT3gdRzsA9+/w2aC1JPqzNnGIFCa1xSnmH0fO2Mlm5dDD+ps6Ot0xq3f9LWnIH+ynHZVwLSgPWJplWMXlOQciR3W5yIH3h2TOm0O1PEbbfjNY4p0UnOv4yi4To2CIoXExc+7lXFJBD4YxgA8WyDEwX3Bn4NPvgEtAfWpq+0yzq7xX/l54ILbwQ+0nfjqk5qOV6qZSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+UHe6dNCl1MBzy1Hd5bAMj6C1FRR9PWPFrTzdY+18w=;
 b=hQK9atH7v74MqpuvOi5r/iLWupum6oYu+W+JFKaTvuD+vQG+x69sHEMlhGvljFq4gfa6qn+8O3PD1PryjCMDHFFjod4WGAACxPvBQdiOWGSAVNqv14tbVs3vI8rtF5a+KuwQ+goFQhC/W1ri05v2dXw52tFOdjQgPuAyZ5ZJHtHKvdxN5DR3PR/0y43ISk3Ogt4LN3esozeHErnDCUyFRHo2DfyYQkWXaOiomUyPM0BV0j/wcL7i5SnFZQSKsZryY83bKXuBEB8gJVe8DhmV50AdSybhnnRph94FuSCeFbhR52LjMy64S2GpmBOnOdl8XyrvUp9oZLfWisMoh7YpIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+UHe6dNCl1MBzy1Hd5bAMj6C1FRR9PWPFrTzdY+18w=;
 b=SFxJfVZHBQ0Kx/RmtwBmO934DLz3p44k9DqlpKBadbogOowsjnzdbkW13/DX7PET4KgjSRkXrNPGofnaROShoPqnWYM0m/XL6b4m+1mwy6XpcC/duHR4Y5z6s55B6MIhJTZlKlU1ZuuGEiA/QtriVsh9+4AUzDHlyBYVhcYifpVcRQ/OlAYmFoeqsy3F/vGkzu7mcav3ADFTohmABNaRzPt7+tM4Zet6T4zyZbdXqi1yUBL36q7tmNk0FilScwVEsnZAuqV7IMMuhzWwhUY4yIE/3L8pIMI9pzJsEV7QU3wOqdFOTKa7NMmuXLKn1WMMjXItw+kl+A67G2l9HcadpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI2PR04MB11004.eurprd04.prod.outlook.com (2603:10a6:800:27e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 16:51:49 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 16:51:49 +0000
Date: Mon, 9 Feb 2026 11:51:41 -0500
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
Subject: Re: [PATCH v2 2/4] dmaengine: loongson: loongson2-apb: Convert to
 dmaenginem_async_device_register()
Message-ID: <aYoQnaEQ5qVOgWkx@lizhi-Precision-Tower-5810>
References: <cover.1770605931.git.zhoubinbin@loongson.cn>
 <3e48916fed24d995cd558b4df3841d2fa5189a27.1770605931.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e48916fed24d995cd558b4df3841d2fa5189a27.1770605931.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: PH8PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI2PR04MB11004:EE_
X-MS-Office365-Filtering-Correlation-Id: a4da5fc6-f86c-4bb6-42b7-08de67fb849c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|7416014|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pBAte2JmnsPF+jF7SNnrJhkY2MmIlkyxjlfO/t5Uo0KlfV6/xV61vRZUV57r?=
 =?us-ascii?Q?DTC0hXhW2a6BJSqIYJvrRfm8iUmFinBz+UTD2zXmSphbX+he9wkrAnI/c/XN?=
 =?us-ascii?Q?JCeIyhsUnjXMZDI2QhpPPmS5NzZBd/mj5DKJ6xeRXVVDdKR1tjxopBdhcNoh?=
 =?us-ascii?Q?/f6D+mZ+xcMQ1VTkCahy6d32U0syrGuN/b574TDy28feNykmC5EQRmsv4lME?=
 =?us-ascii?Q?u24Qg+wpHH61KW/e6wtA4dBUxTv4hvar2U3p2fiVslo2hrNZlURa61DcgVfz?=
 =?us-ascii?Q?p37CQBKTRnyGN4yslNNClBRmfgV6Bb6rK9dspplHYp+QPL/8nAgqGfCoHIUi?=
 =?us-ascii?Q?v1YPX/2nUwl7grWh/Xy9U7WgeI1P9iZCKVPp7XSrvlfUtT8P5rxoePlIiXTX?=
 =?us-ascii?Q?tvb92qIwgllhVmyySMdT1bLmuS1BCObj4+yV7bBNmL6AgIPsgrvsnNddEd5Y?=
 =?us-ascii?Q?mE+3AiHudvRWWwvWlK+5SUFUT6qpv9GNIkAFdhZjEGSdIHMA3x4SgKnt7Gby?=
 =?us-ascii?Q?ZooPPejjRr2ARfAqF3YU5NFoGvxFVM322oTnDNpxUNOHtwVjmp7oFsNjeSNC?=
 =?us-ascii?Q?ZWcZbkpycQJQz46/iGywqUqF4eI8zxHTIE0cZl52QBfs41i/cNhJBWMAoR4j?=
 =?us-ascii?Q?2kAxq41iOkaw6Ra3/18QPIM2812b1HBF4ETyDQH8ZagqaRJuEgzg+mFbs+CR?=
 =?us-ascii?Q?z+VKHJzBsF/2gCvCMGl2exnU9caAjuRfpnmpylTQYRiykyCAmmuJdHcAJodI?=
 =?us-ascii?Q?xomJHtp3WW/uuur/7Qe3Jqpb1kgPASq1j95p9TWav251BI7z61fxOwr9i6S1?=
 =?us-ascii?Q?2y4Ry/zdS28PWbj4d4CV5RkBoThIB/6FomG+AFBQd+5A8hqN7xdqf+vXU/hU?=
 =?us-ascii?Q?KiqWTvuy81bHQk7yBQdUtT4t7QV7QU4niYnfiNmxfG4LCfTBlaIFzslF/lig?=
 =?us-ascii?Q?1HKz2r8ZPT/IffCNzIPO+YmGNB3WChVI7FEi3l8+tZf0Dpp/ynDkC5vuFf/E?=
 =?us-ascii?Q?f2HivVQS+xuS3dj6u5DhdRltgkhs4Y1Hkv7AU684WrA4ZK1HgZscO/ld8EHl?=
 =?us-ascii?Q?0A1PSZlsG5JKuHcjlO6RdeshkE7HNzK5t35MnmuSyPGS5tPMEBukoz8YA32J?=
 =?us-ascii?Q?A5UDRoJh8qWZBJs8Ruz8B9rm/s/fKfO8/t3/Kymma4pO9LUn00wt9Z2E4biy?=
 =?us-ascii?Q?uJL4Yno/l+dHtFlSFcs3ooSJg03sgaazVoscMLM2zMMHWdK1H6DU2EzPfN72?=
 =?us-ascii?Q?fgHcoucWr2khmqJfC4Z1HXt5LQUTDWyIuuxYJPAckeRh0iw/10THp1htFIVi?=
 =?us-ascii?Q?v5hlfyDoKk3AKmGmKlEaR5Dr0CSNtE9h1rAT0ZfpnBvdFv9vxDY8h0r309AG?=
 =?us-ascii?Q?rFkEQSTDLgdC+PM3Wa1FQOlmqaa3lNsBg2DbTP+JYYmop96ijHnmp7ZZXORD?=
 =?us-ascii?Q?pUee/4CdiWJy1G9y2magMz7D3STjFsd81KGcdatVJcwCF+Alz0glIaOkY4Af?=
 =?us-ascii?Q?1qPcuVUAzMaxPgJJ5S9iQoWHrjutuCOZzrT+37uymuQOCOxS4OpZKPGhX7ks?=
 =?us-ascii?Q?46LRBn5/MsybBYQtkEFhcshXmbNx2l2r3ZrPiolo+R4F50EhKRE/t5hnnIIT?=
 =?us-ascii?Q?3d1j+ZmR1CCFx6q7EfcjLEo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(7416014)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V3rWwFWUZcybEJpNENvY3+1ue88SxC5dXQThFpOGT4Abt4Bk+QwywHvin7V7?=
 =?us-ascii?Q?ighqUaxAjlCDoDzl11afoVxy0vv+QLRe1JSyIrlYyoh1ltbGgOxDVleyDgH/?=
 =?us-ascii?Q?8xx+MO9slFYuGwMFNjIo5As/BkTRNnMMudOgrzqpYgFasqwh7uCF5g0fraau?=
 =?us-ascii?Q?wlSsMCbES6QaqIM/Pk6kOdwTANKETvYvcFRMm9UikSy/Aoih3aco/H1t+Tld?=
 =?us-ascii?Q?8qcQjBtW8kD6NSxNu+lc3wRfQkLF1vFEZodfHmoB1z6cUCY8tTTqyyMbvF92?=
 =?us-ascii?Q?BlaKOB9e0g3qOVjGRz1xVU7bDjWFCY8ylpvZP/88vIcA7teRMLkr5P9sqvSF?=
 =?us-ascii?Q?clVOnt7pqE13KZkMisTvv1NTAm9cBLor1gB8IOvi2VK6wZ1K405TafSwpY2c?=
 =?us-ascii?Q?gGfhMMH+KNQrw0ONr9MCFNfT5WueI4yZ83cy+ICNeqOSiytPtVr1F1b3/3Cy?=
 =?us-ascii?Q?DD4mxjMGhpTMylRlTCuhqzqIi3R13FV+ceDEEye40fzSDhbgz8y2ROONvXZ+?=
 =?us-ascii?Q?/1mG2yjCortaBD+Jhbvd5ICdR0pYBf/7lL1FuniVvpPd1kDCTkIShZ4+dMQc?=
 =?us-ascii?Q?0VQRSLQfl16RQ2lDy9q4aRodY4hgfg/0zYtkQdx9/Bw63SwDUZNOnHUy9UQ4?=
 =?us-ascii?Q?iyJdmR8JAk1FC4R7kkFpgROkzP3IRIreydz2zKAjJF77PTF7Uu/iUTJylVtE?=
 =?us-ascii?Q?DxXWzCfYW5lo/bNqsVhEiKRAoTfhsyLy+OtY+8eQxRwJsO2FyaRWQN+E82ZG?=
 =?us-ascii?Q?qDxK2yQ9+Du/sWl3JcCOWyka69WFcyOdo+S9bYiLj70J3/qpCg3A4NHfh5C4?=
 =?us-ascii?Q?kFbLqFBabvOzZB47TA4itQh+1+wA76fT764lVLJOQrIsyrRBqavlBvdUOZe0?=
 =?us-ascii?Q?eECTGTue2IhyP6BgD1nUmgoCBqB5KQO26OE9yWyLF19Gvp8tEXMOmsEBk+JI?=
 =?us-ascii?Q?004mtvg/XPkmxSXigj1Nwko5WMsh0ic9KXHOwieAUCMqBRgoFC7O2ofoGbAv?=
 =?us-ascii?Q?rtg1dyYJB9g3nIutTCmvKIJml1upF/e67bT3yaNEVJNfsUZ+HBYm3QN+1nGj?=
 =?us-ascii?Q?tog40UN4vVSM2rwtIQ17yt/ZjU94FQpMQwb6MOKylta9Hv4mXbnwSSX5CEfR?=
 =?us-ascii?Q?mzqqLhYRMiC2LyvArBSXbI0klOQMcn0InPbxm8dT6Bep0R/hi2FRLMRE3IRy?=
 =?us-ascii?Q?3wxNKoOn0b2NzOiw642PdeYxxhEng04zI/PjMFgcjsrhNXVrd/f4DJj+NK8t?=
 =?us-ascii?Q?oAuooYiiKs/Mx4YmxdXW4E0miR/gWIFR4FiT69xeA549dcnVH4DOLMhJb1ns?=
 =?us-ascii?Q?It04Gkq9wd3ReJ2mleRJOqVXHMjRFsGP5dZZCavxEASqvppxqRMJUwjFSg5R?=
 =?us-ascii?Q?ONaB8TCxJ3z8ezDWbU1mUoLKh/FneCusAKzpr7YOMc+k/xxqAm3lCC1MkiGp?=
 =?us-ascii?Q?XMxjgvcHCINK7ByVVdet1qI74OYKV+hNhxevP+f/EBIm4wTNAXqhQmiYmf9S?=
 =?us-ascii?Q?s57wW8h04qAg2gYZYBrLf8p78yrIWN+xbMyUfzL2q1qr6BKven4+qfoPZWPf?=
 =?us-ascii?Q?b4K4skVQR6Bd0OXxSSq6VDKMvai36IMooBaXD55m+AEpjXcSwAjy8rIjwXoO?=
 =?us-ascii?Q?8nm2x48/MH7r2J3FSFefhNJtMM32IBcT5OrSGaFFc0Kx41OKXUBbYwzcTVAm?=
 =?us-ascii?Q?5EfL0S3sLmCdwzgjsVPyQ59cOiz98T2gxdZMt7HSSm8vBeVoc0cqH7x6uuJV?=
 =?us-ascii?Q?xHCcFQ5KWg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4da5fc6-f86c-4bb6-42b7-08de67fb849c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:51:49.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2/m0hCTagzVdc4xVTYARK5npnZ9n961qjdYA8BXaWSNp6GkbV5WtOiL773gXDRAWLH0yofEsHnw5nJ6i+alRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8856-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82EA8112C06
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 11:04:19AM +0800, Binbin Zhou wrote:
> Use new dmaenginem_async_device_register() helper to simplify the code.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/dma/loongson/loongson2-apb-dma.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
> index 0cb607595d04..5e9a13ad9aa2 100644
> --- a/drivers/dma/loongson/loongson2-apb-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> @@ -650,21 +650,19 @@ static int ls2x_dma_probe(struct platform_device *pdev)
>  	ddev->dst_addr_widths = LDMA_SLAVE_BUSWIDTHS;
>  	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>
> -	ret = dma_async_device_register(&priv->ddev);
> +	ret = dmaenginem_async_device_register(&priv->ddev);
>  	if (ret < 0)
>  		goto disable_clk;
>
>  	ret = of_dma_controller_register(dev->of_node, of_dma_xlate_by_chan_id, priv);
>  	if (ret < 0)
> -		goto unregister_dmac;
> +		goto disable_clk;

This patch is okay.

You can use devm_clk_get_enabled() to simple probe also.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

Frank
>
>  	platform_set_drvdata(pdev, priv);
>
>  	dev_info(dev, "Loongson LS2X APB DMA driver registered successfully.\n");
>  	return 0;
>
> -unregister_dmac:
> -	dma_async_device_unregister(&priv->ddev);
>  disable_clk:
>  	clk_disable_unprepare(priv->dma_clk);
>
> @@ -680,7 +678,6 @@ static void ls2x_dma_remove(struct platform_device *pdev)
>  	struct ls2x_dma_priv *priv = platform_get_drvdata(pdev);
>
>  	of_dma_controller_free(pdev->dev.of_node);
> -	dma_async_device_unregister(&priv->ddev);
>  	clk_disable_unprepare(priv->dma_clk);
>  }
>
> --
> 2.52.0
>

