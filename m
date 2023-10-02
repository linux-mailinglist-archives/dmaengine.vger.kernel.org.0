Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA47B5A61
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbjJBSid (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 14:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbjJBSi0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 14:38:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC94B0;
        Mon,  2 Oct 2023 11:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsrCa8/l7MaorwhrQfYdQtPfa/vw1ctoKdcPmDpVNNz0IG9NlQaujk7/kI3q8ZhQ60IFT4INGkSaAqzvyLhjP+W5oxAwkXDRRYoVEWpdANtTzYSK5E2fWLrdhlu1iOYwOuqQFWS5ogHwkuW+t+CvYmM7PNlkTIJxd4d8NZ2QRumSN9JGTpz9UMPGSxHYIrL0Yp/AShOmvratfS+iFa7qkvCryOfr6cjWSV3GL+tU3KHb3PRUKm9ZEK/OGG82ttVS8ZodQsxu5GFsIHDKWV0ZRJGKEVG0yMRumuMXGZcEy8heswjEQYqfy3A9HBBBUrx2njMwwbGxvNE1VXV7gpjpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSwA1bfeEHszTu5G6jeavumnHAM9N1N3W/jyFWLPiiA=;
 b=b5fmdybK6cJrSSQhNMYPA9VZeevOds5szGX+MZpzzftt33k6LkMW1UXVengoSmRrEeoOHi+ieDFW79T8sj79vpN2v/RQIHcVbuHoe04/chTFOExEiAGCIn16WuZVkSEIJvmB9jbJKh3a0llGD/w1JKHSJn5ZGygVgUizt+f4yUTSi0b2p0iKryHI4Hdaf63M1KoerE/r5kMDQtnJPxQDfUeJUuRgV2C9CVQGsy5XJsL6sr/bHr4gODpIOHPAiG251m4WgK+5T9nKqbAsoVk0ZDxkBUctOcqfUpZLugVpBwCZXXj7N0r3euonPZRvy2QonlxRuWAsRBw7M1ifiZjWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSwA1bfeEHszTu5G6jeavumnHAM9N1N3W/jyFWLPiiA=;
 b=W8XPc/r4FfP3C6YoiATuN8mJ6q8+JZtI3B9gwgzUjEWk/ZsYBHdYDjI4zqMymoYmRfUXvlKmqirFQVZ4ewrmDY1o63WM5ebe1J87W49Zh0wvw39TxNO+KDOR4F7D2NQLQzWq8+2zIEiQEjSpbrxTegDgCMfq+ezuTY7D2mCtJW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Mon, 2 Oct
 2023 18:38:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 18:38:21 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     arnd@arndb.de, vkoul@kernel.org
Cc:     Frank.Li@nxp.com, bhe@redhat.com, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: [PATCH v5 3/3] dmaengine: fsl-edma: add trace event support
Date:   Mon,  2 Oct 2023 14:37:50 -0400
Message-Id: <20231002183750.552759-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002183750.552759-1-Frank.Li@nxp.com>
References: <20231002183750.552759-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bd79af-5cb2-4756-e5ac-08dbc376c0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adIWI0coBcfLreARcb83saEjQBmQEReP51SBb/x0QDTPywsHnrG9AHYgPleItcTm85aF68rnPCkzbL3ku0HbbmvdhT359cLGg+gHt0iFEQKxfWI/4CKdZUlB+UOPABGUXJWALSRlFMushgp43iXXGWRaEtNLG/OASArSG44MyYQoDPmXApku/YqefzN2qO2ItNq05awPBY1rhqVY4VLs3pITAJzrokDYJe9n/QWDjhcM7dOCfGFTO2ifF6q5wwVNTmJO6sbwDBEF/avyVQ/kpYortm4K4gjPp39tR1wfga+uWZfpogPnXOH7LTpAnrsBVcMsp5r/cLESVa5AaRwWqM0kOnFT2ntCVJoYiUpCpdznQf9HbG4ssjSftI2MPWqsGJxCk8LwXZ3aBWv3AdYADbuceC6SSNtiPN8sodwzo0KKsg1aITYoBmAJVH1URYtmFOMbpP8wYehBTOCiuSnogtBNATMu4G6L7k7yl8yeIzvlFvqynHut3xfGW0dFrs9n7mow5lfDxRtohzNdkFOCe/zcsS+6R95H1yaOBAHxoFGaGby3+k7H3fwDbmJ1lEcYXrgCYfQ+eDJGBp1ci9gIlKEoMypvPyHeOEwj03lpvNjETGq1DoyaXWvKyEidx5We
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(52116002)(2906002)(7416002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(316002)(36756003)(66946007)(66556008)(6506007)(478600001)(6512007)(38100700002)(6666004)(1076003)(86362001)(38350700002)(2616005)(66476007)(83380400001)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iCis1cX0cfkU8Girjm+4KVlYhw24fwqb5wHySgl0yEXMIH4ICiGg6v1CQQ4z?=
 =?us-ascii?Q?DSSDP3donTwWy0pC4oj/dZ5SCYhoNnd1zz0NAyn4U619bLXSTMskTx3aRQKy?=
 =?us-ascii?Q?kahNpY2/tGlRVNmqHuwGukGriiEkB/w7BrYFBAMD8AbACCtKZoQ0YjRqIVg8?=
 =?us-ascii?Q?LjPDn9EY4l45lFv6BvoeraILtu9t3HLtfuo5Jef8AIzX4ZqcoJxOdToXClOu?=
 =?us-ascii?Q?9IHkfHK4ig7Y0zC3x01WKuhwZ7S1O92Bh079rrpobk2XB340eh0NrgWqDatm?=
 =?us-ascii?Q?jHhNIKOqub/wY1Xmm+d7zhpPWnA/ngfO2H+RRDKYU5HK3C+ptn+r0ZDLbMTj?=
 =?us-ascii?Q?bWJJSJfsHrZME5fEBjcOSSWtFtRd+oDWhqNd9JniP5jrIijc2eI8c5+01toQ?=
 =?us-ascii?Q?RnG0NHWZ+LvsfeYGRf037HOfzoFtPg0cOgsNfsX6N9hCCFOkvHRDVvupALOv?=
 =?us-ascii?Q?m+l1ztFvQ/x0Mi2cEtiR87LOGOmeDANQuMk9rnByXCU8Pi1Ld4oz272BlI/K?=
 =?us-ascii?Q?1TXce031xGHKCKU2NXXy7DsAh4Hhp20wHT/wtr01QBGpNVFHRyPtRoYVPuFT?=
 =?us-ascii?Q?7DD1d0pgiSfUGEnjj70HoNej8+b5BIzflv/TAJxAk1PMqpPy19kkeRmgJFdl?=
 =?us-ascii?Q?5WOayF90bee+ytjM9v6uE3AFG5f1S7v7kCD+BMxgDRERZ16Ct6547hbUjEpQ?=
 =?us-ascii?Q?eo+EvrIpvhIwkQT0t80Sw6vx32seBLe913/8awTK4huQuzXNiNe4C7PIFleX?=
 =?us-ascii?Q?vEVXzapmxStiaAJ30sAzFmcUgLk8IyfEf/4Egx5bhuBd81GH9GrtqIyjjOS4?=
 =?us-ascii?Q?uZxshOpuDUri9S8Wmnx9LSbpw7KwW7671vcfJI2vmMB9BYQ5oB1zXXpPU1QX?=
 =?us-ascii?Q?Pey+DxCnWMXu/X3rLiswbuWVqT1Hw0kG/toLwLsID0Qyf5NGBFI1z+VLPt+h?=
 =?us-ascii?Q?q+Z/nz/mpx0R0qDbwLNJBR2V49eS1aL6teJf9E3XZL8lY0lhJII3Q5pCnMq1?=
 =?us-ascii?Q?DhP/n3ErzMrnXK8LbhmXL8nD5Z1ig/fa85/spOrZi9iJwzqHygztc04pkw16?=
 =?us-ascii?Q?rAzuibB+VUnfQqR/vgkMDrkNwotK+PM+uFjTaAHfFFI6QutCVw9gU86ixn81?=
 =?us-ascii?Q?WH02K7vwEjAkizk6vsVKn6KhWHziUaluiTDjhfAUi8BPt8shxUSW1TkVZFx4?=
 =?us-ascii?Q?12aeo96zNO+6LmN1EuP6Go7t5xk0H5mMzryvnEw1Gp63wZVyXRiVsdRuoRW/?=
 =?us-ascii?Q?f7KW238BdeZqO26BvTL6tgS2lbjlqE/Y3xr9g14+EwbWI2SX/ua9QN7CjWvK?=
 =?us-ascii?Q?DFQdF6KW+yNlgrnbL0NJctebhlrtaVa7FX6gpodvJJjceuRDWyPQCZk3QwDj?=
 =?us-ascii?Q?H9AyhustALgtMS42Sfb3O9TO+mgNFdkCUATctKfr52HZcCRndUHY02RizO+O?=
 =?us-ascii?Q?ZJT5ibu2PZ9GhPaeADDkA5ueqvzveIQoXRfGKKOtlviDaDuibP+5sSTvQVDs?=
 =?us-ascii?Q?/YHO+nGhlv6KfoTJ3tGEvQKClp3ozyQoxvyxFRktyapicE6FualBHdxOYh0h?=
 =?us-ascii?Q?vDsTr0cxi78bUgfr2CNV6ZqoKnA96ehBj/XvNa/j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bd79af-5cb2-4756-e5ac-08dbc376c0ce
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:38:21.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttjfg9u6c5L3X7MU8JP/66Hh2IXUvM56kyRQvQvaXiFZfPUT7Rqp+D65b8H6FjBQQ/OPmVhmG9MYMxm4HhNWXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Implement trace event support to enhance logging functionality for
register access and the transfer control descriptor (TCD) context.
This will enable more comprehensive monitoring and analysis of system
activities

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Makefile          |   6 +-
 drivers/dma/fsl-edma-common.c |   2 +
 drivers/dma/fsl-edma-common.h |  29 +++++++-
 drivers/dma/fsl-edma-trace.c  |   4 +
 drivers/dma/fsl-edma-trace.h  | 134 ++++++++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+), 6 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-trace.c
 create mode 100644 drivers/dma/fsl-edma-trace.h

diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a51c6397bcad..40b2dd554e5d 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -32,10 +32,12 @@ obj-$(CONFIG_DW_DMAC_CORE) += dw/
 obj-$(CONFIG_DW_EDMA) += dw-edma/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
 fsl-edma-debugfs-$(CONFIG_DEBUG_FS) := fsl-edma-debugfs.o
+CFLAGS_fsl-edma-trace.o := -I$(src)
+fsl-edma-trace-$(CONFIG_TRACING) := fsl-edma-trace.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
-fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y)
+fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y) ${fsl-edma-trace-y}
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
-mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y)
+mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y) ${fsl-edma-trace-y}
 obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
 obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a0f5741abcc4..0182e2695fdc 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -521,6 +521,8 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 		csr |= EDMA_TCD_CSR_START;
 
 	tcd->csr = cpu_to_le16(csr);
+
+	trace_edma_fill_tcd(fsl_chan->edma, tcd);
 }
 
 static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 029197440bc3..453c997d0119 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -234,6 +234,9 @@ struct fsl_edma_engine {
 	edma_writel(chan->edma, val,				\
 		   (void __iomem *)&(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
 
+/* Need after struct defination */
+#include "fsl-edma-trace.h"
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
@@ -242,18 +245,30 @@ struct fsl_edma_engine {
  */
 static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
 {
+	u32 val;
+
 	if (edma->big_endian)
-		return ioread32be(addr);
+		val = ioread32be(addr);
 	else
-		return ioread32(addr);
+		val = ioread32(addr);
+
+	trace_edma_readl(edma, addr, val);
+
+	return val;
 }
 
 static inline u16 edma_readw(struct fsl_edma_engine *edma, void __iomem *addr)
 {
+	u16 val;
+
 	if (edma->big_endian)
-		return ioread16be(addr);
+		val = ioread16be(addr);
 	else
-		return ioread16(addr);
+		val = ioread16(addr);
+
+	trace_edma_readw(edma, addr, val);
+
+	return val;
 }
 
 static inline void edma_writeb(struct fsl_edma_engine *edma,
@@ -264,6 +279,8 @@ static inline void edma_writeb(struct fsl_edma_engine *edma,
 		iowrite8(val, (void __iomem *)((unsigned long)addr ^ 0x3));
 	else
 		iowrite8(val, addr);
+
+	trace_edma_writeb(edma, addr, val);
 }
 
 static inline void edma_writew(struct fsl_edma_engine *edma,
@@ -274,6 +291,8 @@ static inline void edma_writew(struct fsl_edma_engine *edma,
 		iowrite16be(val, (void __iomem *)((unsigned long)addr ^ 0x2));
 	else
 		iowrite16(val, addr);
+
+	trace_edma_writew(edma, addr, val);
 }
 
 static inline void edma_writel(struct fsl_edma_engine *edma,
@@ -283,6 +302,8 @@ static inline void edma_writel(struct fsl_edma_engine *edma,
 		iowrite32be(val, addr);
 	else
 		iowrite32(val, addr);
+
+	trace_edma_writel(edma, addr, val);
 }
 
 static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
diff --git a/drivers/dma/fsl-edma-trace.c b/drivers/dma/fsl-edma-trace.c
new file mode 100644
index 000000000000..28300ad80bb7
--- /dev/null
+++ b/drivers/dma/fsl-edma-trace.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define CREATE_TRACE_POINTS
+#include "fsl-edma-common.h"
diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
new file mode 100644
index 000000000000..9dd08a42ad54
--- /dev/null
+++ b/drivers/dma/fsl-edma-trace.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 NXP.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fsl_edma
+
+#if !defined(__LINUX_FSL_EDMA_TRACE) || defined(TRACE_HEADER_MULTI_READ)
+#define __LINUX_FSL_EDMA_TRACE
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(edma_log_io,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value),
+	TP_STRUCT__entry(
+		__field(struct fsl_edma_engine *, edma)
+		__field(void __iomem *, addr)
+		__field(u32, value)
+	),
+	TP_fast_assign(
+		__entry->edma = edma;
+		__entry->addr = addr;
+		__entry->value = value;
+	),
+	TP_printk("offset %08x: value %08x",
+		(u32)(__entry->addr - __entry->edma->membase), __entry->value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_readl,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_writel,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_readw,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_writew,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_readb,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_writeb,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DECLARE_EVENT_CLASS(edma_log_tcd,
+	TP_PROTO(struct fsl_edma_engine *edma, struct fsl_edma_hw_tcd *tcd),
+	TP_ARGS(edma, tcd),
+	TP_STRUCT__entry(
+		__field(struct fsl_edma_engine *, edma)
+		__field(u32, saddr)
+		__field(u16, soff)
+		__field(u16, attr)
+		__field(u32, nbytes)
+		__field(u32, slast)
+		__field(u32, daddr)
+		__field(u16, doff)
+		__field(u16, citer)
+		__field(u32, dlast_sga)
+		__field(u16, csr)
+		__field(u16, biter)
+
+	),
+	TP_fast_assign(
+		__entry->edma = edma;
+		__entry->saddr = le32_to_cpu(tcd->saddr),
+		__entry->soff = le16_to_cpu(tcd->soff),
+		__entry->attr = le16_to_cpu(tcd->attr),
+		__entry->nbytes = le32_to_cpu(tcd->nbytes),
+		__entry->slast = le32_to_cpu(tcd->slast),
+		__entry->daddr = le32_to_cpu(tcd->daddr),
+		__entry->doff = le16_to_cpu(tcd->doff),
+		__entry->citer = le16_to_cpu(tcd->citer),
+		__entry->dlast_sga = le32_to_cpu(tcd->dlast_sga),
+		__entry->csr = le16_to_cpu(tcd->csr),
+		__entry->biter = le16_to_cpu(tcd->biter);
+	),
+	TP_printk("\n==== TCD =====\n"
+		  "  saddr:  0x%08x\n"
+		  "  soff:       0x%04x\n"
+		  "  attr:       0x%04x\n"
+		  "  nbytes: 0x%08x\n"
+		  "  slast:  0x%08x\n"
+		  "  daddr:  0x%08x\n"
+		  "  doff:       0x%04x\n"
+		  "  citer:      0x%04x\n"
+		  "  dlast:  0x%08x\n"
+		  "  csr:        0x%04x\n"
+		  "  biter:      0x%04x\n",
+		__entry->saddr,
+		__entry->soff,
+		__entry->attr,
+		__entry->nbytes,
+		__entry->slast,
+		__entry->daddr,
+		__entry->doff,
+		__entry->citer,
+		__entry->dlast_sga,
+		__entry->csr,
+		__entry->biter)
+);
+
+DEFINE_EVENT(edma_log_tcd, edma_fill_tcd,
+	TP_PROTO(struct fsl_edma_engine *edma, struct fsl_edma_hw_tcd *tcd),
+	TP_ARGS(edma, tcd)
+);
+
+#endif
+
+/* this part must be outside header guard */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE fsl-edma-trace
+
+#include <trace/define_trace.h>
-- 
2.34.1

