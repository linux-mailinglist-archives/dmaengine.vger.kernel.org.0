Return-Path: <dmaengine+bounces-2749-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F7B93EC96
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 06:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43031C213FA
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 04:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1498C80BF8;
	Mon, 29 Jul 2024 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GR6cJg9G"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2066.outbound.protection.outlook.com [40.92.23.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ADF1E49E;
	Mon, 29 Jul 2024 04:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722227769; cv=fail; b=W8ZxT1r07aFmreDUWTIbia8vCf5lrRSfvFBKyCiw6mlqUfWUhWazC0OEivbBIj5defAH98nVqXxkhxY1Fk2mttMSkvDW4yot1ihnJhmaT+8x2k17COWniI9PiIUh4Grn4kBxratmOhuQb6X+l60V8aYSyBT5URUpZ1sQf2hMaDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722227769; c=relaxed/simple;
	bh=P1jOG3ND4Mf1zjSBQvVz4l0JIQR4C4K7EMCPtti7aTU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YZgd2yx3FM7yCSl+hWxPikRIJ12hbVvOguzdbIZU/bjKCPFewFcl30v8MvQ71u2pWKoRA95cVKE67MOIeKqsknE7FSpJYXgttLDkmCnqZG6m/FLlkxXAqr1jNjZkPQNBlP2PJbL806Sqby6HWPmXa919WS1MpQGHeoehsOrg5C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GR6cJg9G; arc=fail smtp.client-ip=40.92.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jL6DOeqGuaZynAjDgDv6m+hsNKrcLjamCdlpEFHdGuqwEToBUztxfZW4oM4ciTZbPkry5VYBHsHcZ8vi+d3Cs3G597tvyIuOTtEbCFxDeEPvgzjjnhK8l4NI7DGE4nNrrjV0iZH0lDDTbuuEzWhy5YqMEd6cxcIwdUS9LPqxkUsUnZy+i5P7tltz0xmqv8Z7YKC5//GI3lolV6YuZO7z3GeKO6Fr4QqnXfyDRUyzL3V7Z/t/o9AVAm8Ty7S/bEy6rMM2oZ+Qp7EgqLvN7Q9VpFivfG4ypyA5NY0wWOXh+nlhZwqGpFRs0+EFdUoNOuLF6wwA/9lKTg8ihL8G93j3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSdhpdIFY/BUNL2KPiiab+YLI170g9vlizGWY0C00TU=;
 b=UkMM8cmyhx3BKXSBDu82U7C6h1Irn7wF3qe3itvqFzpZ7WoGGF7C5XO0LHo/UIKL9jY9kFy0BSQbT5Pz+1y8r6Fn0eCqyH6bBexDGuMGbeFnRJuBtwI1NROq2E4w6+3X2MQl+4TCtC049gAOwIgwwYyafk+L8SvHNa/x+rzOPSGdgUIQfkgdebtIkRsBWDQqz/rCVWTp3MYRW0N4kZgFJbJZiNtv9O8ue9+Ar1gu5PSNtM2nbmKgZhT8k2yZKpeYA7Dg9JjK3fIOLHIBpAUzjRzkF05LCsh2d2lRzkPNDxhPMLNtSAIjQSfnV/eipvs5J2iDdB9/m2+w9N0eyWwSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSdhpdIFY/BUNL2KPiiab+YLI170g9vlizGWY0C00TU=;
 b=GR6cJg9GwMh0JJQ/yKaFPeyyjPtfgKn+e1claj8bzp+6MaVDU5qdtHEEJ6n5CEHHqOF6qKxBI2DhUFJqG5HYcSO/8bzgzj/I8mmhZW1n8h1eaRM/4QZ5mF9Ue/rqqgAHpdKt38U2w+YDaCymDPMNt+1hQEKXJFrXSiB+rh21QbKEo4hyIoOdPmgb2bT/S2hsJm6PQrJdvkefmgAG+TsFeJMjNFmlfEJH+Oo7BO2TxU9roHVAKkSWt+xElGz54tkN2GS49RqKQqxmrYf2NtCfvAYm645Mm3IehQ6aGjVIFwbgUd8ULLhyMI0MtTJcmKFbwYlOK+gMSDY623vh2r5fAg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB4516.namprd20.prod.outlook.com (2603:10b6:806:23d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 04:36:02 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 04:36:02 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Liu Gui <kenneth.liu@sophgo.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 RESEND 0/3] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Mon, 29 Jul 2024 12:35:37 +0800
Message-ID:
 <IA1PR20MB49535EC188F8EE3F8FD0B68DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fmjuxwUoloLA8W1zDaR2bPY01FRSXtxehJazvoC6+WE=]
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240729043538.897754-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d74a90d-ba64-46ed-c4c4-08dcaf87f38d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599006|19110799003|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	4Y5GEAx+oZbUWAg19I/37jQJXHYti/psl7koGYD/JqEsJ6nnti+DDi6o64D/GT9ljMuwSy2n4fI6DYlvChAII+8zELJK7mtF0jfSUwNI2ZCMtK3sy98VfY0pO8qpUmxr5E55q1QV7mnLpOh3XTCZ+h3wKvkzaS8zmANVe4PYr4oZHr3ayqmpmSsAZ81NGqwKrEAv83VycUTvDBxWGzGOcR6dF6tOkAsFVee3vDS2nt6j1avT37mHYH5euh54p6S7nV+7NYBFC/84DPg4bDe+0gVaTnJrGuNJ4v/fNqJC1PoG8dfmjmbCLbGxczAc+YMTNpN2J3rJdjddzk2GHhs0DLmO5z0kkyKWIZ40j/ieg9tJMV6P3d2JUSL/YkGdgmmsRp3B6qd5+zYs6wBTIRcxKsM7D83X5VJR9bHgt6O6hdDvmxj+pitQIwzJ9Dhi2cNyd1aU/kzeGU/ZR+1Dbd9yQD0Fok+/YViiefz4+zihHtLXD9ZXMT5kRimLHr8qgS88Q2U1dFZvRGwFFmnWgRDm8TkvUp77U24pcQvc02U8FFrTmMa55ogfcDp1YtcB/gbQUQP/aBmTaZ52UXFYkiBd2I/r57obVwvE5OydSKtyU8Yi0UPLLpCcF863L2HC57NrMCFjBJ0pTH/GfJyaYsV51voewBm3EgK3rGtSRNoRsO7y0cX996ZdSvdmmFScT8v7dcoDmPxVLZ24D19eYwjEhw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dYZZAEEgY3wVA8EYYao/aX9FRaama4a+QwC0rxH11VBP3AkZMZXcvBG06I+5?=
 =?us-ascii?Q?zfOO7T2i8YhGPGS1DcMoEATK8KqabvMnIU7PgmOGldI7yA7pd1jMQjdAMrym?=
 =?us-ascii?Q?nAwHMQupvjxl+QCD9jzOTMvHD86TRnptk1RgnYa4jNCE4VkC+je9ie+d2V7o?=
 =?us-ascii?Q?kXz7fvZKXbUrnl26UMPjVDgwR68WPRX5JD1QfxNzwKkAy6YX4xB8FDHRiXz3?=
 =?us-ascii?Q?cZuamO3ZZvp4JPZ45+QLWYLCIo5IxvcVL6BR8wJCMpnvB7bm5ZDshFTmDvku?=
 =?us-ascii?Q?Jyibf3AI18mxxQQRjN4WQAH8I9lQ1A3+vG46Ep8SitP0hVsl2Z2a6tZTt90P?=
 =?us-ascii?Q?F+VOtlsNLkTR/z1ELQM0fPFyag5PfjV3USk1CmNjaAbd/Msj0yj0/3c9HfXo?=
 =?us-ascii?Q?mQ9jk72CHDoe/+YctsqnrZA2BtWOAVa5/pUoIlEKpntgZg5qItmhArUhkr0Y?=
 =?us-ascii?Q?v9bq6IHKgQ2aPjKxIgYiw5zH+RbdH1H0PVS2+uKY7belXRAavtNi3VuRNmzT?=
 =?us-ascii?Q?z+3zfzIkBc0nr2j410P2rwDrdZd4uU3R5e+go/Rkpo5wwyZIhV6am0n8wMmS?=
 =?us-ascii?Q?iDU007R6mMLVfBqJ1xFoqAyY1Zj2iOtNsjTBo08Z1I96wAb0VyivrYR2tcrB?=
 =?us-ascii?Q?xGK2HX9UnRpyqvc206+RNEG36aVjc1hUIEfemHNPtu2W2itjfg57eU5gOPd+?=
 =?us-ascii?Q?YCjkoH8zHv8j523QqBiR/FjYjWByQa1m6vp/POeZ204OXQXJ39OvmpCiQGk9?=
 =?us-ascii?Q?H6WmsgdzHKTlY1+EW/0aPb+HEmL8iV8dHD9xafT1U3CA2r8zFnKBbzFbLHZb?=
 =?us-ascii?Q?3gWs2d3ejO5hyKqfBBYpGEgdO/lfo5iSQbD6R1L8BTjEp5TdFj+qZKGLNbdi?=
 =?us-ascii?Q?KUwvLONrfT9LSSkWsVRaQdOyuJRoP7HzQGs6Ua6Mhj3xu3ib6MoG1cuujkV0?=
 =?us-ascii?Q?Si4fWp65GJdeRmgHvaxTkB24ZT8CHxctienCh1lkefcmP0w57+n00DxusTaN?=
 =?us-ascii?Q?VOK/tqpyg8RW+fSNHU6EKNV248pIOVEQKnr/vgEWVODj1cEy98LLiOifPx7L?=
 =?us-ascii?Q?/ZUrArOByNx//oIFskcWdZ8IJCl1nZKslh9UmzdtTDrbOJnSc+J0sKDeBkG5?=
 =?us-ascii?Q?2sCeNEH0DbziTqo1NlD9JT3Oadus3gJ5U3bp19Lybz6Ca2oDQmDhUtctNrtO?=
 =?us-ascii?Q?q5O6sCTgRHHyjBaqs23/L+YVf0J8brvsDiy0pBAEVnDO2gzIKlxv6x8UpUcY?=
 =?us-ascii?Q?uyB9s5WrX4xRnIP+qm9E?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d74a90d-ba64-46ed-c4c4-08dcaf87f38d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 04:36:02.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4516

Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.

As the syscon device of CV1800 have a usb phy subdevices. The
binding of the syscon can not be complete without the usb phy
is finished. As a result, the binding of syscon is removed
and will be evolved in its original series after the usb phy
binding is fully explored.

Changed from v7:
1. remove unused variable

Changed from v6:
1. fix copyright time.
2. driver only output mapping info in when debugging.
3. remove dma-master check in the driver init since the binding
always require it.

Changed from v5:
1. remove dead binding header.
2. make "reg" required so the syscon binding can have the same
example node of the dmamux binding.

Changed from v4:
1. remove the syscon binding since it can not be complete (still
lack some subdevices)
2. add reg description for the binding,
3. remove the fixed channel assign for dmamux binding
3. driver adopt to the binding change. Now the driver allocates all the
channel when initing and maps the request chan to the channel dynamicly.

Changed from v3:
1. fix dt-binding address issue.

Changed from v2:
1. add reg property of dmamux node in the binding of patch 2

Changed from v1:
1. fix wrong title of patch 2.


Inochi Amaoto (3):
  dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series
    SoC
  soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
  dmaengine: add driver for Sophgo CV18XX/SG200X dmamux

 .../bindings/dma/sophgo,cv1800-dmamux.yaml    |  51 ++++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/cv1800-dmamux.c                   | 259 ++++++++++++++++++
 include/soc/sophgo/cv1800-sysctl.h            |  30 ++
 5 files changed, 350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 drivers/dma/cv1800-dmamux.c
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

--
2.44.0


