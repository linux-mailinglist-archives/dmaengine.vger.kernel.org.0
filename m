Return-Path: <dmaengine+bounces-1800-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A7789E7B4
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 03:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23418B22091
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 01:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0391165C;
	Wed, 10 Apr 2024 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pf0mxnSE"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2023.outbound.protection.outlook.com [40.92.22.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3A4C94;
	Wed, 10 Apr 2024 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712079; cv=fail; b=BPZt56m1jz0UGXT5HKafXjSofv7zX00Wvf61KAfdwpAZ5xmij6HGAlQFOpcX+asA3yRxI1FXnB9qRLQz316IV4nbJg7aoMrO5a027vCVV99Xmp6X/Ad2MQLTnYn2pJZo6TLXxPv3WWanBiaFX4tilnGD8q49DpZ7yhrk4WC99gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712079; c=relaxed/simple;
	bh=8JgoSjCMgT+4YWgPAd3BpnSD8PgiKGpOWzslfEu2zi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=doUFTkULSdOBFGMhNea4PmX6DTNcoMn/+sBh/gR89sHDOTgoI0cJOpt6geo2hWJofS83e8MJ3YPF4xP/BucomGhf2YXCNkFwuJ2lCa2pnSoXDeB1ZcfuFuSWf7klQydEvzXpzQRq+EtEav3ywy7BYR6lUwvaQCSe9thoDelvu+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pf0mxnSE; arc=fail smtp.client-ip=40.92.22.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdFpsjRfdX6X+kgIR9oS+9S2+aOlX0WVInPQ5jWy2ua3NAfkrtK105lTJtOJhiPlJ/4/fSSGOGOVozqrS12A/76xElHel8aY/yNigx9gLa1i+zziT6uey3I2OoISA+xSMqPPyaP+HCTQlO3u+a+aj0ym1HO+y1iScCMFgpnle3qqcjCGlIxKTpxZQP6Uq4U9IwhqFM+YoiLSRpNEPLdPFqAjtw9+4Mgk6OsTD/s8KwckHXDjbnz7sDLQPDP5ZKTE964yeb3f58Lyh+j/ttI8IwQZqdMxKv1lDN2puOIMgOwP57fNH8jxjnParBIlM5fWxCW7KdiG/uYnrHRSmb+ElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS0KlR6sMzZ54c2Mbq9eCPI0GiPAwbDVfnXhdu/XLI8=;
 b=OjMtsWazq/atJwbqlq9uo8Ij8dY9lPFHoXrbH3z+xGcLOqX1HSaJofPkTrac+afe+PxKfI9oK/fuRzO49FcaOO8+WEYP7EBCA8idqHJ03cuV4bAOjcrRfU40pVWxe8bEGooFhaEclewegxd03XqTJ0nTldCeonRJFL4S3G/WiqtoKexfgrnartKJbizt1Olbt8gCtStLiFTmWLvqUZgBpaajey0ma2Dpa9r8WS0zY8sh5/5yump5yQ+0BXZBUTtxHBaG/nPDJa6lHWK1G4XG9Bt5ZsSAtRhypcDWlswge1C+s7WrproPdhxMo5A4jDm+oeqibGy4I4WyLdfcWn+CaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS0KlR6sMzZ54c2Mbq9eCPI0GiPAwbDVfnXhdu/XLI8=;
 b=pf0mxnSEw5L00M3Tg7KxaxMSpf09Da9RAqnH+mnU1Dw45C/qiHVCLvdBRQeJxVxNx5taq2FE3ZFTmimU4vIRPtvy3Wd9d4AbWBcwJcFHcyruSzPXMeaZVy5kpVmWaTzdqrBuoSu3AkWZqIAUu4HCwGlmRwYpNizauD+JCF3Ia1SfSHW62HJZyiMI8pEvKCy+4I5AGqF502nuglFwrEc/vV3KknBnnAFS9ROtpnc8PjalMOQNf0ky3uSRpo6yGRE/EdZQtxjyhQRjHPUUBLYijT5enI0DtlgIZkuuLN85Ebk5EbV5Xq8P7wSShHE9iKL0I5eQo1+oDQRU5JmNGM2KvA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CYYPR20MB6833.namprd20.prod.outlook.com (2603:10b6:930:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 01:21:16 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 01:21:16 +0000
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
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v7 2/3] soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
Date: Wed, 10 Apr 2024 09:21:21 +0800
Message-ID:
 <IA1PR20MB4953BAA0F8E06CB202C5C2FBBB062@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB49538A66B7AAE7801C5A7C04BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538A66B7AAE7801C5A7C04BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [xNXHwO/Bs2d5BGFIEGrJ5SXlvcEJym5Dvev2CUIWpQo=]
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240410012124.165438-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CYYPR20MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 0732feb2-36af-484e-4341-08dc58fc8485
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uYiqOFs+HNlawyTszX00V25Pi1AkfH25SL6UmofmH5hg00nxRj7smwRL05+WemK5y72xpoNRtzXlfKgbw/ldJuh7kNGg4cTCz2RSRV0iUjgTN4X+xnnYm90gcmKN6KWQXAt5BwkI+aFAESzpZBrIW1moxRMqwl4C4ld5nUld+VBZkePI3JAqg3vPXAVpO8X+JyTvu+iq9O5jJJkW/jWjqQlecYBk/s2vbXf+/JFBp8i2Gp/UxpdvDgwDvZuURnRbVwljaP2ENXW4eno2N/V/PJ7N5BkaZTL/7+AV3hfzsQg683zKjggO1XiEiEETiWmhZK7I6TRZ8v0giOXiefzCJu22hL5bsrGaRcgiazSHk8C6HP3LaRHlbGk/30a9DtTalzZeGC75xIKP7jhUSRuFZq2Oo2M62c18lUr7vhmXOJcaaHckGy5dxuIDI95LsuFhZ3GUN+pogov1LvnCvfra3pFfqtt5Tr+LjeFavE8AdBNC17oYMfQz6az59V2E5rWija6UcEH+S3aNrmVGAmyESH41lnnUES9yIs1lBA3bmF5W6bcJOai72bL7B9JT+Jh4We97lo608dj4b4O4OdFt254df+YrTLhmj0v2197exqLHUmn7MviNoW8pOyzjSxcY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tAFnjfa5UK5vMODpC6X61AbtdK2Wy1ILvdPcnCakXrGew6GZS0KRIpfN2u4O?=
 =?us-ascii?Q?w6GZTjqnzhYUuLHH4FRwCnZkDpYq/NBCpm5w5haH+r3kSe8YlG/NDBLkjmN/?=
 =?us-ascii?Q?/FZqul+rbYpHkZyIBYL3a8g9kNjcg1wNqqMSr23mIp+uAXT96kI4CZrcBwXW?=
 =?us-ascii?Q?nwU8Ho3Szzdq+xwR0wPvFZUA7xsie1Qavlfg6HjssaBapY5nUaOi0v1GdF19?=
 =?us-ascii?Q?uzqzWmcU2SIer2amF/KeMM40ggK2Z2hdANO35NdgLUeGAeerKk8UsHKK2kbj?=
 =?us-ascii?Q?xQnmx5ZW+RrpNdkFKGvKvPFOQpLCqk1Mmjdo8pKMl/J65sXBfaYFlhPmj24c?=
 =?us-ascii?Q?8jVakvyPGFG//bUAvpdNiK6KLbxxEjIls5i16jFTz2ycQHO17or9e/R5EXCh?=
 =?us-ascii?Q?TtldsT0qVGpikZqmAtD+VblH7EG8u7stIizgBt+MIL+XTGUfJjVUEOQhWFfH?=
 =?us-ascii?Q?kvnZEUl+kyUZS3sxN2a2rjJ4QaT1XGlR4fqzdwRtmgBpjJcpv3CYSas5aKto?=
 =?us-ascii?Q?ocxFl/ZNVFgXtZWtalA+c6rTs4cUNx4ELky/hRuZ6VdAxS9DGzpTbYakLVO3?=
 =?us-ascii?Q?OtV0qyaPGSeamStIqLBerL37ZGr1UJR3VmCzgSHK3DPxmvdeTXRu+lFvJIPS?=
 =?us-ascii?Q?D1GWHwQdIQHqYBHYHQLTyjcIDockS3jRRdigDMtMgYGJbCLvbtuu3J5GNlIY?=
 =?us-ascii?Q?Hcmi+r8C3J92gjUgjrqNrdhoYBkDwwszEd7Kx7UbA02df/oCQZ/Li/hA6uw6?=
 =?us-ascii?Q?lOcrS4qELcaSGjoGk4zlpQFpzN0Fxivy3gwlhBJEGO6M9K1bcBG+98ZHzmC9?=
 =?us-ascii?Q?DI2KKxRjFOFqkAKMYRkdDXQw2jcr7LI5wZ2YTe9/NkgkJOSWT2O/7rrXZbGV?=
 =?us-ascii?Q?c47JM0TmYotBc/S435sK7mcywDBX7H6eDlK3cQodL7o/5iORbmix7lw05NZ5?=
 =?us-ascii?Q?DjBW9Rz25ZhbcaN0Dc6zud82neaMWj6OfYoxL5aWqnxa1Plp0YxIk2d2tANG?=
 =?us-ascii?Q?LMEPu2AneqLDDLAOqU2aPxSpZ2HbxfcYEmNnx9x/6kvYmDRSTpsjmxPI4rBJ?=
 =?us-ascii?Q?OAE/WvvXiccDXMfPA2JQc1hLLMi/CEIKsJZrgU1GSOmkKTZO0HLUnPdYBtgm?=
 =?us-ascii?Q?7VUyKb0+3f2M9uIhsZOgKdM9MEyzfioeA4vA86WZh0HWHnB1uAcgxnH/C9r2?=
 =?us-ascii?Q?gTHPtiOC3iHBWHmbKCuEmHdu0ke0+R0DK7xRvgRfbZSyH3ovMQC7khnnpxaA?=
 =?us-ascii?Q?vweCMBgXf94NkwIMF7/q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0732feb2-36af-484e-4341-08dc58fc8485
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 01:21:16.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR20MB6833

The "top" system controller of CV18XX/SG200X exposes control
register access for various devices. Add soc header file to
describe it.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 include/soc/sophgo/cv1800-sysctl.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

diff --git a/include/soc/sophgo/cv1800-sysctl.h b/include/soc/sophgo/cv1800-sysctl.h
new file mode 100644
index 000000000000..b9396d33e240
--- /dev/null
+++ b/include/soc/sophgo/cv1800-sysctl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#ifndef CV1800_SYSCTL_H
+#define CV1800_SYSCTL_H
+
+/*
+ * SOPHGO CV1800/SG2000 SoC top system controller registers offsets.
+ */
+
+#define CV1800_CONF_INFO		0x004
+#define CV1800_SYS_CTRL_REG		0x008
+#define CV1800_USB_PHY_CTRL_REG		0x048
+#define CV1800_SDMA_DMA_CHANNEL_REMAP0	0x154
+#define CV1800_SDMA_DMA_CHANNEL_REMAP1	0x158
+#define CV1800_TOP_TIMER_CLK_SEL	0x1a0
+#define CV1800_TOP_WDT_CTRL		0x1a8
+#define CV1800_DDR_AXI_URGENT_OW	0x1b8
+#define CV1800_DDR_AXI_URGENT		0x1bc
+#define CV1800_DDR_AXI_QOS_0		0x1d8
+#define CV1800_DDR_AXI_QOS_1		0x1dc
+#define CV1800_SD_PWRSW_CTRL		0x1f4
+#define CV1800_SD_PWRSW_TIME		0x1f8
+#define CV1800_DDR_AXI_QOS_OW		0x23c
+#define CV1800_SD_CTRL_OPT		0x294
+#define CV1800_SDMA_DMA_INT_MUX		0x298
+
+#endif // CV1800_SYSCTL_H
--
2.44.0


