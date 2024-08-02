Return-Path: <dmaengine+bounces-2782-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09A29459F8
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 10:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DC31C232E3
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3E61C3792;
	Fri,  2 Aug 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="t5+8Yo8B"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2080.outbound.protection.outlook.com [40.92.18.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3508D1C3784;
	Fri,  2 Aug 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587608; cv=fail; b=tW1uH6hQOymDtKI/CWVsWFRsIpwU3lbdXjx/hFM8c7m9rNUqu3XUXLtF2jt6/jrp8nVSH4FAQOzTFNz+itoWkIRg6GrzJJpioDhnhNRUpnlXtIzmHp62iUgfhHL5zq5lXaxUlHkCU2YZayFNuSq9uCDNOhVLCCkmXbkjvCQcNeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587608; c=relaxed/simple;
	bh=X6CoxR80yFNipUDfRCA3Oal5qr+2KpNEfJ2Ay1/J2YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MvINKRHEhkDoMt5qKpUtLprCB4bSHmaUtPeiVczEe6nS6T9hVh88LiXHX6pyA5SEFw9Ceqa2xIdz/Ocu7x4SLgRu1f4mQTkmWv9McuddMNDKJWJWkJWd/51EDFTQqSBT4tT0dBbCT55eT1G4DrCZfQqixYo4E2gewMPBkoZaxUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=t5+8Yo8B; arc=fail smtp.client-ip=40.92.18.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ocm8QD1bI4pieqMuy1JPNeRUdym1KFzHxDGw5e6GIM8n9s1Ep4qRzxjyAVrEOV5WHXu5U2i7Y3nnaVbRj6SgvOmmhFjw6MVtK2uUByLnh6fExgaft2HtIqyo3YG5JWImvXhE3UOHr45LRXxOVUvcikLeP+cuRqPo8n0M/LSTewpYl0n6vQbieEwoeAHB600vTq01rtCuWMaWqJW8RyxuwuuHTK8nGzgMQW4FlQeK79VrouK2H4lv5bJUrujjCvMmbJcVgGedygEu0JzIRC89D3neswAlxqIEO0JehkeqIdN8Ifog9kGhXWE7Xb6YfVXyd/z8hnVXGs38J8pz0G9A/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8BiqYB/pmIIGwtoQCg80Q4LlvGH2VU5I5bg6jVgwmY=;
 b=Nfwxm/5wiX1pFDN0C00Ntb44vRP79a/TeVjvOJn56wdpimFX7jPUUknUMDK7BPV9fiJqXVXvQXxVCJ+PF/ercGp2kBYescQeTuSdaq8K/Xsr/jrw3BDPJoBFkzFIlXyCcqMqoENqQq5G0hOr97WbSe/ejfhjGRy02Tn8ERWYGKHl1824yPdz3SYf2qWFnCyfDWAL6qQb7wLUQAwkxtW0iJP6UKsayry4uKGypjB12QTIV9wZFK0C8bYq514CJH28nxNMOqzRCQNMA61BFwfRlfDNS0K/PW0W/HK4CJiFntO0Ivwpchr1H/U6UCAQqB+28PXYvtKKSE/nSMLimzXeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8BiqYB/pmIIGwtoQCg80Q4LlvGH2VU5I5bg6jVgwmY=;
 b=t5+8Yo8BDUE9nLITHLXxRggQXrF8bqpi7ifxXI4TagLNUpNiZIYv4zrU54QFnV1YkkJ78qxIWtgZGBSTJp4iBSZ1TmZYOxdRz1DzqimhB/BKCtomvrpskDI6wMjtISiZc/pD1sKBSkdGRjEtil6rpoucs6fJG0Zi20eSR9uIdZc3UHrOHYedDzyoR2xySF4jV3AiqmvA26FAnyjSVz6NeM7k4N1lbvuTm66PplV7JhC72OuMHUxPGwPanZ3DjitI2ggh1clGuS5aFwj2kuzVrR/NP5/7matS4csuc++Ah3+1/bc0n5AauyxVXGv2xZwbz3HNcCR8mEh20BE04xS8MQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7441.namprd20.prod.outlook.com (2603:10b6:610:1e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 08:33:24 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 08:33:24 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v9 2/3] soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
Date: Fri,  2 Aug 2024 16:32:48 +0800
Message-ID:
 <IA1PR20MB4953D23B369E5F51959CE767BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB495332ACF71E3E8D631508B2BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495332ACF71E3E8D631508B2BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [OYT987QCS9hdbS84KlajJZuQ+PkoCHEgaX9HZp6vqsM=]
X-ClientProxiedBy: TYCP286CA0112.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240802083252.1286244-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: e89210f8-1efd-44fc-e63c-08dcb2cdc63e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	I78xtI2z4R0U5xOqGR7WS7PwEqS1pPCea1Wrr1laskk/XyTuOWqQ3azKepB2OZ2V/Jm92rliwA41P9Ckfex/bGPoLdsBUGj+0F/OMIEoDdlTbdHzRuL1O36gAZFtB01/S5Z9ubMPoG3h1wFinZ7H+9tDVMypFPO5wSPGU2NaNruRSDuFoSZrFyjSaIjCzoUTBXdRJjSk5r1DTG3bVWutnNZfX2ibGC+DZxgSQ1o329KtPhxNiT1prA+rn23QE9DmSV0EhnAuIwY5Wju6U2XHFLrlJF9Tv8+9l9XTWyUSBrRJuvZW3zT1f9ii2yFOSJ4BFLnkTc6rV/55XRrFBMmJaRZolnQ/VYDCNDLfv4gbzk0bwDB3DFTHN69s7glx6fsF2Ey+khzDMp8eKJVAlPlNAn+b77CyiTnN+XG20I36GisGRAqp6GL64avwkcQY/VPbIsPZqEDWCdJV3xadE0ASgNp69Dy3WYo8oVI0UsaGaC0eqd/9iB86JWacd/wYhhPLJ64bCoVr3UW8CR8i0ZnfBaiWi5M3U5d2oQ+vKCBJtSltBg+18z4mx56gf31pK4NFB++xuExju0AmVDtOuf0saNeyp8gMD2kplf2iJlRzpRIr+oSEbbmhGjnG3ghDXL62ZuujlWMCy5oA0n5yRhMpYYbAjSsw1W7PIUli2Jap21C3UNnmlRHHwWwvlHcbcKLOyd8qjg7EGJO9oX4Sa2Z5Wg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/n7Ba+6r3ZdLS9BHMUB2Tns8WWV9eQBaO9wkwdp99BE/CWxHAR4xEmnV88Gl?=
 =?us-ascii?Q?ZT5o4BDQ3UVDLfZmJwvZmJ6JwC8MuzMXeQBb0mndckomrTq3rAUjPKfKsHMH?=
 =?us-ascii?Q?H0YmdB0/knFiI/t9BOW3sArgGRJTO3quPdJh4Zodg377cmTjlKYkzq/UlZI0?=
 =?us-ascii?Q?b7P+GEUPEv6OHsVkGiqFuCyXG6bSknrXMy/KX/gBFCeKciuP/dpSEaf2HN8F?=
 =?us-ascii?Q?0zqY3GDf7GZRWZPD0h+UKG5pexiJn4czaIvFn8KZhLLxiGg+1bNO34asnenl?=
 =?us-ascii?Q?wQSR25lMjyGd4K9dRwCvSXt/H2Ex9J8z9mmPwH8svhvmoKfcZ4I/ZZakOQb3?=
 =?us-ascii?Q?j5/GDivc1s11KnLmhVEUdoOX/b23+Qu7OmRnqudDIMPQ8oM3ujfx8Rz0G9gC?=
 =?us-ascii?Q?qbvdsFvaVKBEOFsIeW2eItwFQwGSvikw7PCJ2441Y7t2Mr+IZN409ApRpyiY?=
 =?us-ascii?Q?QrGeSK1QcvM2LVPC3g5V0ND+9QCwfxkrHHo7qHMCEm2y7OSdIc3b88vcJ66r?=
 =?us-ascii?Q?ChR4hx0fEKIHaMAT+CN8MHknkPEAMwqFrydEMZG8M/oX1MguMGfTcQnOAueH?=
 =?us-ascii?Q?DyOgtmQtIIuUfWQ1rRBh1ez3rrUDz0vdPfHRK5ubM3EKZ67wlZrTXgjQMCS9?=
 =?us-ascii?Q?IbEeps6pAZoYLAzG9G1906La1SwfDY5tAloRPVxh2n6QK1u/WktPJ4H0Xpzi?=
 =?us-ascii?Q?0BYmPBJIx2OMm8SRfeopiGHyqwk0k38VK2aFDGc9qUzYOONppkKm7n7lIspa?=
 =?us-ascii?Q?oDj2rNxNGOnM1pNJJRiw3+n9Rb9yrf7cWWVdXY0dicd48FGrwzjl9A5ScKWp?=
 =?us-ascii?Q?y5dK6pu8pctG+CcdbXTJi+71ecl5AdBawoxt5gatMof3UnjLB340tODbCAzo?=
 =?us-ascii?Q?SY38Z5Xm5ZbvErJ12EPrBMixW4yqlsHSJX8MaaBoRGMx7YXAajdo9ypliGdc?=
 =?us-ascii?Q?lKe1ziYTHdkZSlt1O6DNWxcL3O6uB8RNS4tooU7F6ZaQ27vm7cE5/0DMXrEZ?=
 =?us-ascii?Q?Tduf98jdjFkZ4LEwj19/Lq5FHKT6fsrK3YEprWvDqwkX/iKFjc5Q1AzTpG/Q?=
 =?us-ascii?Q?2yd0UI+EHoK4g3pnv3Eg9+uzpcQhH3xbsR3iw8fKJ1qjwyPremuP51XyS9eV?=
 =?us-ascii?Q?+WR2wSc5NzM0B2zWULGV0oEThNLvQ7eZ30pI47OJ75dOdvb5YzqBVSzWgkk0?=
 =?us-ascii?Q?vRrbuxhOeqNa56slAzmaxvOcXfjkX69GzfwLfvLVvN0id9FkS6PDGwqBrnGV?=
 =?us-ascii?Q?ZGqUNYsj1zYXSLTQA+ny?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89210f8-1efd-44fc-e63c-08dcb2cdc63e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 08:33:24.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7441

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
2.46.0


