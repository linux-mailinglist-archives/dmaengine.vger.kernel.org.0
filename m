Return-Path: <dmaengine+bounces-1487-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EE588B712
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 02:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974CA1F3E650
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 01:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B61D82D80;
	Tue, 26 Mar 2024 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MfLkbSEM"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2096.outbound.protection.outlook.com [40.92.22.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14EC80C1F;
	Tue, 26 Mar 2024 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417642; cv=fail; b=uYiUVZkIxw2ZGb5CGu1QuXN2j2raveXdHAhNSO2XzgRzqR4uCV3/6w1ksQcct4l63/N4E1g7rx/SGsGvMbJUfEPQhM4UdO8pXQNzT0/zp8T8OKE4//H4VObBSpkOp9MKpOFBBTEkeC5eaCjeMSkS/f3474vB6+AqOLMA5G+I0AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417642; c=relaxed/simple;
	bh=G402pF/C1xwkO3ddF4EGPf1HmaICEsd4RzlLSuDQAzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsgqFPFG/IR1lhuPXN8N2u+5+lFjQUl0u6wJguwOodzVwX0s1Rha+HVnvY5xxa1jomOMWF+OxTOOimq3k5dvsuIy3KUhFUh2GBaWg3wSzbueiVcn0jVsw9wWfhuUlqX7lZ79wpW8KZh4ksiqnHaeIP5EjoNycg8ziRasmRp8EtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MfLkbSEM; arc=fail smtp.client-ip=40.92.22.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv5uCfF5kmbgWR3xddYYDeOmV3jX3PcODDhGW4WCwUJL/wUuUOrLEZv1+TRKa2P2wR9eEToch4teZzW+dxO1X+XNJ5YHtAWT1kachp3r/giBI2RylTcYTEwIJtF/Fe7g0ZK16Pc8LGbDsVYdtqVS5f3WsgN3UiPFQRxM7igo5Nq/gOEzfOA7ZKtk9j6zkBUIMuvwBp5helJi9DQEpmW8gi/LFBDTxMRXpxmC9E7D+LHHYBCpcvlO6M6A4GZclRJbzckvhteQHRC9buC2aH+rJ4x0i7BhBrbXX/LUrp5cJFQ+ytDl1eZN5H1r3JSJOJaIxi+NGRqQkg+Y5hIyMpjVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLMOdrQygst76bvt6bKGJPcelvUQigBt2RtAuf8GQwA=;
 b=ZqMob0bqXzFCfatRJ0nHIzCozpAlSQ9P+Cji024c1dQa0iI0FI3PmOge83EZU2SG/sgyBtpN3c+8SUPHQa0i+geihq/Bt0/JjwTEwHeJLtOd9v7jzmehqjNTQhSU17zFywTS9twD+2/Rc9GRKFIn0t5EiTNK9aAKDRN3NgfzZ7723TjNdxwrzfRAL7R1tXbP7vVt4Fr0TMU1EPplbKoDUHV6ki8iCRmLJnWUADSUNNQXA9xWYn+JLB9Gpof7spUVmbUl/111uKbE7+gtyZ7KQd61H22ASQilJMv2uZ/7x8hS5gb+e4RAIGdIUN74WQGIWFxIKBrdkUovrzoKJqYkQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLMOdrQygst76bvt6bKGJPcelvUQigBt2RtAuf8GQwA=;
 b=MfLkbSEM0yiaz8Hs9/CfvqZd+kE/6T0cJY0jGf53FcFNJKPIh0FaC85qaknzVitFWEsot2Q2CN0K6NqNZxN3LnbTFkLNi6pWOOVfobCKMq9xSvJrpMXRJM8Ka1pn9e1ryFg7ri8D+vANCWG9IrJ7B1xVbkmKneeJr/t2VZSbLs1RWTGItDGkc0NhNj65vaThAKECBRBkwF8D33YcNCFJ9TxodQHuHOtxZZdBoAnTeDknATNrABQjxM5PfIKYa79V/OFIhFLYNUYUeoRFbEvgPMzrCLYLA1D3t2CxCeRRC+mRxTs3GjBrKnbg0kW3YDKP9O+CWqQqFhf3Bvu3zsDn1g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB6537.namprd20.prod.outlook.com (2603:10b6:610:154::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 01:47:17 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 01:47:17 +0000
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
Subject: [PATCH v5 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Tue, 26 Mar 2024 09:47:05 +0800
Message-ID:
 <IA1PR20MB49534FCC5AC11EDB3D74CE0CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [RmjrvbuV6JDAmctJ7cGRxemzpheBgOQKG8AHgNpq6Ng=]
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240326014707.327110-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5a4511-93b1-4382-48dd-08dc4d36ab3e
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3ghsXKwRy/t5h7NdWkXmzB0T5mqelZfSxrF8iYJzzinjnwdw+qKFn1FtVvTbo7Mu1KGBXbm1di+NQPYimvy/8RVu8TpSt9CfR7H6Sp6KauTysJgYFiKSJiWtJh4MekW6HAi6ZuT5+nToJ1TVi4JKB4j1AKLpUbqQlsUzQr4wkABoBjtJxmdYZqrCKsU4Rk6EWqbohfYCbvhXQlrASFXSPUpEec8L0aoHFbdkt1KUOnjLDfpjH31RJ5AN+MHz4fcUEw+jAR97r5s4lAf8B1Z9xxTxWY1XyeuW46PXVT6DN+gPiEfb5wLdkIR+CKF7vhRPtImYm4d6MT998s/hYSpmCWt5Wym+wrhnYcbmLVxjZLqIOYOd6gjEwTTsFzfY+mr6EQAes6ED9Org0EJ5gHIxcNDxyfweZQk5bVW6j512FBERMRUIhQrIvyBH51l22srak3xEhfqqxT2L3zM8bcYnAcIPH5tlfigolT0HvaL4lknAtpV3TU+q5kzToBrTxr2S2ya6VJ+6WDarLxDwo3+NyOfoatCgzXoZNAo0mg6SQ3GWtKcBiq8R1IxpLbofzXl3CnqC64xcQ9y2R25eWFCc1UEYmPh8yKmm/BE9W7ND7Kn7FFXoY91cSMQ75BwdVpak3ydmM35eM3t+wPoourGcYr7OqgynlZRsazreYrptw9FN0qNNuoG37D4d+JcUMgEEQgY7+m4Xl+oLEO08JJ8qwjKKWvYLBic4cT2hOeFeSP5Ra2UhubjULBfiQsiFi0YZQUyaf5WM1BnhddjIK0C3kjPVGWGE1wgaZA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j49TfSXAtpdRffossYF8OwA8JzAL8XaWpYTikigArRjPr59rXYAtwm4GrJblxOnOEVqx34pFYYoYwDtr1Hyubx7aUAIxs7nYT9ow0FCfNYcdahzWhYOasDEEy9PB4w+y3wBDtWDL+1IpBKrXQ7uHCBXEKtPt+4RLv91ICd+9Atd55Y9v7uhs5PRGq7lAj7xHPRqgYkm4Vo7yqTUpDwJoHexwIUtzT9O/sOihnw8YRq8tzYM3KJKt7tcb3i/C8eRXxckRLDkyd92DKFSxQFqDPpcQM0c6KqEBrw6xjl6Mnocdb0kRmb3qS3l7ncuGLsRrxH+1Y/rBebbc2AGA7SeJVvV+B3zPX7+sTpZrI8erSxVP9MAdppAjkwWTa8TE2p+JJVv8kBJUT4bqM2N9XD8v3S2JZ9eTZ2WJ7clL681JCx0JWYMmMBx81/ScSugNAi99hEUwUa6n1MWqaRITFMMsj8sb38TifGPIdATm9ZIAPWgimO2048tU8Zk7dcy106whmoRn65pxiSx36hhIbW3BYg1pZWMboJra7z/BFDanYlnbQxevqYN44RyjwiClNTFt57HMSALfGN+ZYk1RzuLFBf3BgJDmKd3ArsHZIewzuXBKlVDIYLKrSmkBBN0ObDg2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bLzwx5Z3memmyawh5yOxVl7bI25oA51hjsdg30q3bqLa3fU6jED22HzNh5ZL?=
 =?us-ascii?Q?jjektEYuixZtukaZB1f194LuDy3K+39UkFFNxCJj9t5Eohz4h1GBhoF80A4i?=
 =?us-ascii?Q?v8u1mD7Aa9el56d97nLjWzsgwyNoBue6L3AW52EY/XlpyiBFRjggGKT8Rk60?=
 =?us-ascii?Q?S0wHgPgTJJG2xH8rVpHoLPQHOmwtEOIUZ5vBcCyvf/ymJ6dDmWKLtIbjvlBL?=
 =?us-ascii?Q?qxe0uCcvMTjTaAmldW1l8mAIIm4V3u8Rn6h8I1MtuKt1O0nyYiwaW49bXFmb?=
 =?us-ascii?Q?4MF4bIwA/QMa8fZhHft+KigJgJyFiPeZmnLD0Wc+B8vkTX3JztH+/nB7Q222?=
 =?us-ascii?Q?IyMXgizX5vMweaQag/un9gWb5OmhtpgadYFCx9hT7UGl/aKv977BXhAVtWSM?=
 =?us-ascii?Q?lLX+6jYezX6EK48d9fS4LJgc+GE04GMT2hICXC8jGvrFCiqYy5nu8YhphVaN?=
 =?us-ascii?Q?pydyXWD4R7gVS9hGG8MTPuP7kfuNKUKDzOKjXrzz4ufMU9UNOh9ktD/UxVkv?=
 =?us-ascii?Q?RNcdzQSkySgVJoXkW2/QdvczN1ika0oYj4UF9OOrFH/owh/VT+VpSJkzYVhf?=
 =?us-ascii?Q?o56QJ2SJg7jrKewhNRDXEULD6qiGjjqqJNtBU/p2RFH0zpGavWdLQIOU8rxq?=
 =?us-ascii?Q?YtW0yWZOJo5itwM1DJItTFNyufB90QgpD+gvFNRlU99RCSeaO1viuth+Ef2e?=
 =?us-ascii?Q?epHLqgOTn2uKuQn+VMGCKJp95M5hanud0Q6j3qSHZ3+pHZuE+2eNkUPItbNX?=
 =?us-ascii?Q?QYI+I1+CfjowxxemWqp8VmILAThEEilLBp7LIQB58VccZMFQm0/yQEs8exYo?=
 =?us-ascii?Q?GF+dFjXF5hK3GsILKYJnC30Xws3jQPwH/JWX0eSe2NRQTPIMB0S6R6oJzEu1?=
 =?us-ascii?Q?w5nd8IWNZytC27KLTzSEZ90nYfMZA1CKUOh2miu0B77sSAigd2BTnjWpc0ne?=
 =?us-ascii?Q?YjB+lMVtOtpiDoQ2y1VlKEUS8vcEapX1DGh3wJJpQNh6ROA7evS8yyakO252?=
 =?us-ascii?Q?jNb6JYz07WdUu7E0f4LZ7uNU56YHIkpUKXsh5unN429x9d6WPj+EYhm527s2?=
 =?us-ascii?Q?vob2Oxeg+1uXXTDL/mU5G55Riu3aaLL7XhPdxQMi4gMGZyN71GfQ8c643Gt5?=
 =?us-ascii?Q?tqfLqqkb146Izn4X/8P6VDrwfH2l4xd8ve1I66UEMhvb0Y7wUN6L+laxNFmj?=
 =?us-ascii?Q?NbUcFfVBiBleEyb8Hsc8ZtMWKnn+Y/HXa38LV2bInXZiqkeoOZ5n7a9t8Y/E?=
 =?us-ascii?Q?Gor/hd1FH4rQA5XlMFb7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5a4511-93b1-4382-48dd-08dc4d36ab3e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 01:47:17.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB6537

Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
its request lines. The multiplexer supports at most 8 request lines.

Add driver for Sophgo CV18XX/SG200X DMA multiplexer.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/dma/Kconfig         |   9 ++
 drivers/dma/Makefile        |   1 +
 drivers/dma/cv1800-dmamux.c | 268 ++++++++++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100644 drivers/dma/cv1800-dmamux.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 002a5ec80620..cb31520b9f86 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -546,6 +546,15 @@ config PLX_DMA
 	  These are exposed via extra functions on the switch's
 	  upstream port. Each function exposes one DMA channel.

+config SOPHGO_CV1800_DMAMUX
+	tristate "Sophgo CV1800/SG2000 series SoC DMA multiplexer support"
+	depends on MFD_SYSCON
+	depends on ARCH_SOPHGO
+	help
+	  Support for the DMA multiplexer on Sophgo CV1800/SG2000
+	  series SoCs.
+	  Say Y here if your board have this soc.
+
 config STE_DMA40
 	bool "ST-Ericsson DMA40 support"
 	depends on ARCH_U8500
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index dfd40d14e408..7465f249ee47 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
 obj-$(CONFIG_PXA_DMA) += pxa_dma.o
 obj-$(CONFIG_RENESAS_DMA) += sh/
 obj-$(CONFIG_SF_PDMA) += sf-pdma/
+obj-$(CONFIG_SOPHGO_CV1800_DMAMUX) += cv1800-dmamux.o
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
 obj-$(CONFIG_STM32_DMA) += stm32-dma.o
 obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
diff --git a/drivers/dma/cv1800-dmamux.c b/drivers/dma/cv1800-dmamux.c
new file mode 100644
index 000000000000..9c01f157ab97
--- /dev/null
+++ b/drivers/dma/cv1800-dmamux.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/of_dma.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/llist.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+#include <linux/mfd/syscon.h>
+
+#include <soc/sophgo/cv1800-sysctl.h>
+#include <dt-bindings/dma/cv1800-dma.h>
+
+#define DMAMUX_NCELLS			2
+#define MAX_DMA_MAPPING_ID		DMA_SPI_NOR1
+#define MAX_DMA_CPU_ID			DMA_CPU_C906_1
+#define MAX_DMA_CH_ID			7
+
+#define DMAMUX_INTMUX_REGISTER_LEN	4
+#define DMAMUX_NR_CH_PER_REGISTER	4
+#define DMAMUX_BIT_PER_CH		8
+#define DMAMUX_CH_MASk			GENMASK(5, 0)
+#define DMAMUX_INT_BIT_PER_CPU		10
+#define DMAMUX_CH_UPDATE_BIT		BIT(31)
+
+#define DMAMUX_CH_REGPOS(chid) \
+	((chid) / DMAMUX_NR_CH_PER_REGISTER)
+#define DMAMUX_CH_REGOFF(chid) \
+	((chid) % DMAMUX_NR_CH_PER_REGISTER)
+#define DMAMUX_CH_REG(chid) \
+	((DMAMUX_CH_REGPOS(chid) * sizeof(u32)) + \
+	 CV1800_SDMA_DMA_CHANNEL_REMAP0)
+#define DMAMUX_CH_SET(chid, val) \
+	(((val) << (DMAMUX_CH_REGOFF(chid) * DMAMUX_BIT_PER_CH)) | \
+	 DMAMUX_CH_UPDATE_BIT)
+#define DMAMUX_CH_MASK(chid) \
+	DMAMUX_CH_SET(chid, DMAMUX_CH_MASk)
+
+#define DMAMUX_INT_BIT(chid, cpuid) \
+	BIT((cpuid) * DMAMUX_INT_BIT_PER_CPU + (chid))
+#define DMAMUX_INTEN_BIT(cpuid) \
+	DMAMUX_INT_BIT(8, cpuid)
+#define DMAMUX_INT_CH_BIT(chid, cpuid) \
+	(DMAMUX_INT_BIT(chid, cpuid) | DMAMUX_INTEN_BIT(cpuid))
+#define DMAMUX_INT_MASK(chid) \
+	(DMAMUX_INT_BIT(chid, DMA_CPU_A53) | \
+	 DMAMUX_INT_BIT(chid, DMA_CPU_C906_0) | \
+	 DMAMUX_INT_BIT(chid, DMA_CPU_C906_1))
+#define DMAMUX_INT_CH_MASK(chid, cpuid) \
+	(DMAMUX_INT_MASK(chid) | DMAMUX_INTEN_BIT(cpuid))
+
+struct cv1800_dmamux_data {
+	struct dma_router	dmarouter;
+	struct regmap		*regmap;
+	spinlock_t		lock;
+	struct llist_head	free_maps;
+	struct llist_head	reserve_maps;
+	DECLARE_BITMAP(mapped_peripherals, MAX_DMA_MAPPING_ID);
+};
+
+struct cv1800_dmamux_map {
+	struct llist_node node;
+	unsigned int channel;
+	unsigned int peripheral;
+	unsigned int cpu;
+};
+
+static void cv1800_dmamux_free(struct device *dev, void *route_data)
+{
+	struct cv1800_dmamux_data *dmamux = dev_get_drvdata(dev);
+	struct cv1800_dmamux_map *map = route_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmamux->lock, flags);
+
+	regmap_update_bits(dmamux->regmap,
+			   DMAMUX_CH_REG(map->channel),
+			   DMAMUX_CH_MASK(map->channel),
+			   DMAMUX_CH_UPDATE_BIT);
+
+	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
+			   DMAMUX_INT_CH_MASK(map->channel, map->cpu),
+			   DMAMUX_INTEN_BIT(map->cpu));
+
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+
+	dev_info(dev, "free channel %u for req %u (cpu %u)\n",
+		 map->channel, map->peripheral, map->cpu);
+}
+
+static void *cv1800_dmamux_route_allocate(struct of_phandle_args *dma_spec,
+					  struct of_dma *ofdma)
+{
+	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
+	struct cv1800_dmamux_data *dmamux = platform_get_drvdata(pdev);
+	struct cv1800_dmamux_map *map;
+	struct llist_node *node;
+	unsigned long flags;
+	unsigned int chid, devid, cpuid;
+	int ret;
+
+	if (dma_spec->args_count != DMAMUX_NCELLS) {
+		dev_err(&pdev->dev, "invalid number of dma mux args\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	devid = dma_spec->args[0];
+	cpuid = dma_spec->args[1];
+	dma_spec->args_count = 1;
+
+	if (devid > MAX_DMA_MAPPING_ID) {
+		dev_err(&pdev->dev, "invalid device id: %u\n", devid);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (cpuid > MAX_DMA_CPU_ID) {
+		dev_err(&pdev->dev, "invalid cpu id: %u\n", cpuid);
+		return ERR_PTR(-EINVAL);
+	}
+
+	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
+	if (!dma_spec->np) {
+		dev_err(&pdev->dev, "can't get dma master\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	spin_lock_irqsave(&dmamux->lock, flags);
+
+	if (test_bit(devid, dmamux->mapped_peripherals)) {
+		llist_for_each_entry(map, dmamux->reserve_maps.first, node) {
+			if (map->peripheral == devid && map->cpu == cpuid)
+				goto found;
+		}
+
+		ret = -EINVAL;
+		goto failed;
+	} else {
+		node = llist_del_first(&dmamux->free_maps);
+		if (!node) {
+			ret = -ENODEV;
+			goto failed;
+		}
+
+		map = llist_entry(node, struct cv1800_dmamux_map, node);
+		llist_add(&map->node, &dmamux->reserve_maps);
+		set_bit(devid, dmamux->mapped_peripherals);
+	}
+
+found:
+	chid = map->channel;
+	map->peripheral = devid;
+	map->cpu = cpuid;
+
+	regmap_set_bits(dmamux->regmap,
+			DMAMUX_CH_REG(chid),
+			DMAMUX_CH_SET(chid, devid));
+
+	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
+			   DMAMUX_INT_CH_MASK(chid, cpuid),
+			   DMAMUX_INT_CH_BIT(chid, cpuid));
+
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+
+	dma_spec->args[0] = chid;
+
+	dev_info(&pdev->dev, "register channel %u for req %u (cpu %u)\n",
+		 chid, devid, cpuid);
+
+	return map;
+
+failed:
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+	of_node_put(dma_spec->np);
+	dev_err(&pdev->dev, "errno %d\n", ret);
+	return ERR_PTR(ret);
+
+}
+
+static int cv1800_dmamux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *mux_node = dev->of_node;
+	struct cv1800_dmamux_data *data;
+	struct cv1800_dmamux_map *tmp;
+	struct device *parent = dev->parent;
+	struct device_node *dma_master;
+	struct regmap *regmap = NULL;
+	unsigned int i;
+
+	if (!parent)
+		return -ENODEV;
+
+	regmap = device_node_to_regmap(parent->of_node);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	dma_master = of_parse_phandle(mux_node, "dma-masters", 0);
+	if (!dma_master) {
+		dev_err(dev, "invalid dma-requests property\n");
+		return -ENODEV;
+	}
+	of_node_put(dma_master);
+
+	data = devm_kmalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&data->lock);
+	init_llist_head(&data->free_maps);
+
+	for (i = 0; i <= MAX_DMA_CH_ID; i++) {
+		tmp = devm_kmalloc(dev, sizeof(*tmp), GFP_KERNEL);
+		if (!tmp) {
+			/* It is OK for not allocating all channel */
+			dev_warn(dev, "can not allocate channel %u\n", i);
+			continue;
+		}
+
+		init_llist_node(&tmp->node);
+		tmp->channel = i;
+		llist_add(&tmp->node, &data->free_maps);
+	}
+
+	/* if no channel is allocated, the probe must fail */
+	if (llist_empty(&data->free_maps))
+		return -ENOMEM;
+
+	data->regmap = regmap;
+	data->dmarouter.dev = dev;
+	data->dmarouter.route_free = cv1800_dmamux_free;
+
+	platform_set_drvdata(pdev, data);
+
+	return of_dma_router_register(mux_node,
+				      cv1800_dmamux_route_allocate,
+				      &data->dmarouter);
+}
+
+static void cv1800_dmamux_remove(struct platform_device *pdev)
+{
+	of_dma_controller_free(pdev->dev.of_node);
+}
+
+static const struct of_device_id cv1800_dmamux_ids[] = {
+	{ .compatible = "sophgo,cv1800-dmamux", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cv1800_dmamux_ids);
+
+static struct platform_driver cv1800_dmamux_driver = {
+	.driver = {
+		.name = "cv1800-dmamux",
+		.of_match_table = cv1800_dmamux_ids,
+	},
+	.probe = cv1800_dmamux_probe,
+	.remove_new = cv1800_dmamux_remove,
+};
+module_platform_driver(cv1800_dmamux_driver);
+
+MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
+MODULE_DESCRIPTION("Sophgo CV1800/SG2000 Series Soc DMAMUX driver");
+MODULE_LICENSE("GPL");
--
2.44.0


