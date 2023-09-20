Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120367A8DB5
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 22:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjITUTb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 16:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjITUT3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 16:19:29 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DAEAB;
        Wed, 20 Sep 2023 13:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGipreT8gJOMWE7Zw1+9SYCy0IbzObS3Dk+ESZNSdmAUieT7vqQFZg+ziRkZnvjUfN+qgGPP4ppkXmLNU/dPLswDcnKU13/q1Gyp9zbWyUsMe5Kw077wyZnsZRLIoO80JPcENUWlTwrtHTEZVcMSxM8MM3UTUrrcE3IUxFg8dOimOiopfuSWeR6MR5mRel3gOXm5vOC9V6QsBiojD+WqC1GMMFoZIf2i1NsIJV5Ec0mHjV7I2bgLLKuphJv8KiHEgx87WYvHVFqD7rAEaZLLUtzwKew5g3j2IB5oHhjKIFoil8vwbqWHD0b9QKmGjcWyoMXgbI3MwxmHxkE2kXLR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vgbk7kH87jFTITs4CUnmnZveS7YfRb7Z54TRYp/gSk=;
 b=l5NY3NSXmZ6JN+MDtogdg0fTzlvy3eORpDtEsfIWkzNrCmFs8Mb5w1XMwMOrRL+sUAbLQbRfXP8AGNRrebVYqpVoVCWQI0PmSJSP41h5WaZkBUrPhvc3Bxjhov4oqoXSBr0uegFsq2NbmC9DXBUIv/tTA3dnIPfBue7NN5+v7orkkxi7H67MV2jTWrrKGwzAQVlz3/lZkzswrNUbcW5FEmdONiwqoLIuP89jy7z43MNNwnKUqjUZ7rvTzN4jRLCCYzbMtfjDQJqxBCAhF2f8tT3k6Z/6NoZlTLfGG28wcxqkEP7sy34N+ZeXF5Opa3Z/zphvb7EMtv0fhE8F3uzAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vgbk7kH87jFTITs4CUnmnZveS7YfRb7Z54TRYp/gSk=;
 b=b65r8V+joudWXowC1YcNKaBSC67wPy2CDGbREQ53MpccB7POJvPOzROVzH6tzbCzibhYFGaqop6OMX0mm2X7COLrVjyb0/8YfbBGGAj9CudsuHGeDvlZIzAg8tQCO1PvCnoUT0vPxTPEnIWbl/1UCKRKJWx50r7Smqk3T0+902A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 20:19:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 20:19:17 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lkp@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Frank.Li@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        vkoul@kernel.org
Subject: [PATCH v3 3/3] dmaengine: fsl-edma: add trace event support
Date:   Wed, 20 Sep 2023 16:18:52 -0400
Message-Id: <20230920201852.3170104-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920201852.3170104-1-Frank.Li@nxp.com>
References: <20230920201852.3170104-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 11643bb1-8e2f-4600-1d54-08dbba16dd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEWaNTsm3t0+qIi0aGd+3TIRxUDsEEPX1EpQTfESy/apJZ1b/f8xJ3t3B3f1oI4dDmAlpxHIsIY1XVsInPy3B4V5zKwCglcox2MYUr5Zbova1HPaUIRB4+RW+Q5GV3QsmDnOEP5XTSWaQJFKquucMhAqOpwPr3IZT+I9QB1XFZglMOg2n8CSDHemxkx7gYAans3Rq1R3m6RkRAGg+FXGm1KrfrQawGITiOZx5pUKa1kxVf5az72SoBWxydnh+Pgf32gzXsVncV5lKJEwGguNMm9VIpmKEazDHdKEDrOMQhopk7Y55CaO7pYvWvwQXxUY9h48pLJ8UGwwLOa1uzRJy7YLVt+Lb5MP+61/4vxSv+55jJ6O5AUnEJHyB2/oa+yL7CdOUPRvx5zoTLTDhTRWNbXvg5MwtzR1FW0uTw5FuC0AzggShEF3kkpplXTTq4uceh1+Yb2DQJpQZgPJUJ6K4jvPSklTT3Ct+MUGCvU4pDPl4tG+/qzdP8oSDEffZMJDyplPzsuPnp7aGes/Pm5MokSB+colBrFNtRUsQ+xJrHm/xaDEo9wzbDAZQThaayT6JgNx8CoMXRiW4MIKZ4AnrDZEI1Y/hyGEF60dY3SyUhfkxZZOTA8BQ+ebjTYaSs/K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199024)(1800799009)(186009)(6512007)(52116002)(6486002)(6506007)(6666004)(38350700002)(86362001)(38100700002)(83380400001)(36756003)(2616005)(1076003)(26005)(66476007)(316002)(66946007)(66556008)(41300700001)(2906002)(5660300002)(8936002)(8676002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BpCMY4aWBVKnXMjQXB0SGIiOZv6B9Lo2yAF3arrmF4v7t0c6QIv9U7Qb1qH/?=
 =?us-ascii?Q?c720Wpfc5RcO+RCpefso9HrDoNUhN3p3QcgOjA4EDRk5AXCIe9dFx0dtbTdK?=
 =?us-ascii?Q?dwOGTxBOIj76YVRXOSmnIQuxSFLsbnyEN56q/LBJw0zyQnlduGt+hXd/sEiY?=
 =?us-ascii?Q?DejN3kT5HnHx8OfOcq5bQPWoeHiIxrRaSRZB/pzmgmjOxILnSBnGPSeJDL9g?=
 =?us-ascii?Q?oaM+iSLoEHaig3TtVxTqh43MBfPVAp0AGbFD8gKrimMIrw2Iw3xqa4xOJqni?=
 =?us-ascii?Q?+1RGlp+tSx96TpfM1JPrqUabi+b3XC/FpCqdMLWeVKW33Pr3671oqkkH9rWu?=
 =?us-ascii?Q?6U6mSGXhdrVa5pDOvjqS81LeKGcpKeug/qdNnbFBUVV5thdGKy0ix7mSLxWj?=
 =?us-ascii?Q?6cB0pC2+K8eqsmZRrBNpxPT2SjvM2G3TAzUgZ3o3IZCN2DHrpKVq6Zyw6SAr?=
 =?us-ascii?Q?IpD6tZEkMxzn7br3oeTMFYQkl2r8AXQBb/QVci5gl6w791Ms6keQmbsQZGm9?=
 =?us-ascii?Q?lyZW5KVsZoquJ+RedeW38kYU+eWlFEeRroO2B9DjzC7Hhv1zhplm3FHKXmHq?=
 =?us-ascii?Q?mtn0pS52s92NuidSWOgAPqKQ5YiTU/DLQeN2LpnUVBLHabLus348AsLKhRrG?=
 =?us-ascii?Q?dZDkVZUVkivHiik8jXHZEoAX6+npYNJ+EB/2X7iGkxU2XcHohN5haergKW8f?=
 =?us-ascii?Q?hpEGgwffdm3U3xve0Af7KsyzNFNtBP59kR5YHTCSuAFHl98wDc5D6XcFpiy8?=
 =?us-ascii?Q?vaYstzyccM172V8oSjH4/8G9xGLlKsQ7HAnIkKYO43YDEL/ud+R0Du2yE3cM?=
 =?us-ascii?Q?yW6jV2EOpwKyzagtjynTQ4KHGDCYbnGX1TA/4SVGZwQVlWlR0CjhrSwfULd3?=
 =?us-ascii?Q?mqoLnbvgIjgNQGUjmrTHZRYGzqDZ4WpeLk4DicXyD/2II5VeIZi8LswmGhPB?=
 =?us-ascii?Q?FEpTryF6TkleJ/OFxWWyYYFhWxgi+2UkpVWMv3FPK37q5JEw4rR4cPd+R3Ru?=
 =?us-ascii?Q?+FRhXJO5ZVD67MVZA8gCriVMAOE7lH6awpl5S8oN6fwIB7AYpD5wU3tk69e5?=
 =?us-ascii?Q?VftmNMCiL0WnlgQ0+6Syd8y/oStyf5hwaN15M+xxYoZYoD3i4CC4eO7P2n/v?=
 =?us-ascii?Q?DRHw4uB7ZkjqMx7/KSktS3ItUIHIUPfKAwDIJPKki9n1E9v89+DTwzQO6ukQ?=
 =?us-ascii?Q?fqUQGytTvro9icudktzwdJaeIjIB/B9JzdTUI6we3R/INvV79g/Z9Lhlypjp?=
 =?us-ascii?Q?CuGQRZIPPGLsvMo8jp6bch4L+V5cPTl+MvLjKNtvFIgimhDOAyNnLB4g9oJ+?=
 =?us-ascii?Q?no7D6vzYcogwG1zAn2v0y27Zu3VaP6sNTlXUAzE0ycnq/eDY8vawrmCzwiOK?=
 =?us-ascii?Q?fZKBYQDglhC3soGE8yaMEycq86A2jrqW8qGRlKQvXnHFLIm5FmmaKtc1+8VZ?=
 =?us-ascii?Q?9TuXUA1UXk3peRGfz0GtK968v3E3P+i0TtH5OXrYXlypQDKJ7wwVynKQ3X+a?=
 =?us-ascii?Q?gDk3Jf9B50H7fUSWIIG9qnfNrlz7Q3ckbMbVaDBEWmPM6ZRrqCNUBUMhEU0v?=
 =?us-ascii?Q?1JtAoiOdsTFZ9hY0L37As8RZZ5KMYQ3oIrWSq5wD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11643bb1-8e2f-4600-1d54-08dbba16dd63
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:19:17.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5x2U3oNtM5IHpmtWZR52ZO7oMOPWheK9Rt3wkgWwGd9yK413faKYUyd1a99A8hgYNa7cHXTQd/BESxSR5ALg3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index a51c6397bcad0..40b2dd554e5dc 100644
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
index a0f5741abcc47..0182e2695fdc0 100644
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
index ecaba563d4897..a9e27110ac7d7 100644
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
index 0000000000000..28300ad80bb75
--- /dev/null
+++ b/drivers/dma/fsl-edma-trace.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define CREATE_TRACE_POINTS
+#include "fsl-edma-common.h"
diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
new file mode 100644
index 0000000000000..9dd08a42ad54a
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

