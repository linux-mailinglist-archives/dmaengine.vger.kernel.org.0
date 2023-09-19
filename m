Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B46E7A67C6
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjISPPI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 11:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjISPPH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 11:15:07 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2075.outbound.protection.outlook.com [40.107.14.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB39ED;
        Tue, 19 Sep 2023 08:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMQCBd+v27leOByNny07zo2N9bHgfUwlhF8QxIXTFdRFqCH6GBW2ePS2kP/wkkO7cglbeZZvDz0u4pTDLNoEf9BSg/QwNlx2GBK0YYms08jKIKWMp9pYjqWU0mTmTmJT8HvlyA7BMfpqplbzYS/BDu4rquhV6LUupG9SQSSJy8qsfIntE3U3kiMCpbD26nxf1xo2nyo+OK/pVoePyJhkzAdGOQufvRHJ7bW1N5DSJz91lrFInlQshyc3gDxxo6tCejpfIknxB7R4RJaIJnbuWV1bbfHmW6hMrMTA9HZgItklpM2fEX3HtImy0h9x2fx75ltyPwM+IXEqc3t93WxgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suFFO2JdZp+dTwCX7WssuZc+wZDZlUuPAkbBjIrxDjw=;
 b=bYmnylu0g0PH9c2icIFuMbMg/spGCDfROi2byp8VOt/3hTG3ubUO9lzGqQLyi59j9XoxXcCDxitLfOI8FPV+u/kdgF07eDS9BZpCcTV0ZzmhH5ufJfQrb5ZA0ky62mVhTbwwCYkDvuPe7F4t5vrOPuNa9pupb2kPIsihq71kPJCz4gsw4mOTWeDkglzvAXjLIt9eACvdG4DZopV4pLibJyG0YM/ripFcXuqMDIKFTiHCh0cPcjze+3KGVYFzk/xmAUJbCR0ufvyvQaWPZyIT2AgOjvh8X6mTNWCxjEPIhzEsfCrlxsIoeYZzlYnOSVze5DhT4Ak+9sHj4SMB+cn6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suFFO2JdZp+dTwCX7WssuZc+wZDZlUuPAkbBjIrxDjw=;
 b=l5HW/qv5nMM3rIyeypmDh2FEvwsFSvrfF6covNRIYvAkp6VHmKcdO9oj0R4Ej5fNVPLjj0L/znnxDHGLHZVPBwEWrmDDKax76spFIoBLSq5uQicwTfoXB7F/7sr6dULWVzxqKmpP24xhVMI+Agc4RyJk5N1PB6tAEWKtifBljlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GVXPR04MB9829.eurprd04.prod.outlook.com (2603:10a6:150:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 15:14:52 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:14:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH v2 2/2] dmaengine: fsl-edma: add trace event support
Date:   Tue, 19 Sep 2023 11:14:30 -0400
Message-Id: <20230919151430.2919042-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919151430.2919042-1-Frank.Li@nxp.com>
References: <20230919151430.2919042-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GVXPR04MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 456c5b86-d0f5-4d87-4a79-08dbb9232c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgS+7GOBdIFWSAbpTAN/8VV4Od0x5S/ZXcd4u09Mytv72HXCRuxBtxQj5DTwX0o4oiXrKm43eQA+ReEK+JaNLApar3YR99kFM/RdDHfiWRRgvqt8KzkidJNwFlBJi4ymcRx7DXibRDKA7evM2CB/DJlDDQYsruNgxoEqAPSX8ou4RK+c+aAatg7J7fEnZ1okvdTPhp3W5WbUABDxg4qGYIIsdaWAxuFHKg83eLys1qpAxHawD/f8CESQCB055N8SaLx4wHx+IGHnpYe3W/l+MRrUU1Aaqd4ncSOqv+9ghzu9Yezms1wwdBPEwTqihZ3nXV6+4x/Lpy7rqT2vSfrNiUrzsH+K8vZX3BMPpC7ybGHXQDrmGnwOH9C8T83md//MHZS2tJ5RXenFm1V2jMZItFvnyk+yXdGwyLfh36WDyds1mEv2QYfDxxyvSqaacik/ooLlFfQGU0a2aMVFE20DUQXqUWLRf2IS5mngS54VnGD/O9zH6L/goPqtto9SKk8HG8lGculMZDwh/4znT2kCCWZ28mPT/C3pzhWevQrXTax0EDaKDh5kE9Yr4eyJVaCHMuVk9ul8Wvp6l2vq1IkXgSPVyJQaPFyzXsHbWEkyTQpOJ/pzNEZHNEo7fSOlUgA6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(1800799009)(451199024)(186009)(38350700002)(38100700002)(36756003)(86362001)(6506007)(478600001)(52116002)(5660300002)(66946007)(66556008)(2906002)(6666004)(8936002)(8676002)(66476007)(83380400001)(6512007)(6486002)(316002)(41300700001)(2616005)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iT13DS5fK/WR49GXNUcEgQX+/mU+aRox4i2zv3PEQ6BQYUZjh8DKAMSlN5q+?=
 =?us-ascii?Q?by+cfANWIHtyPuquP5OXmaKwvtcxPnVxxL8wZlW+Kofn3Hp4WyEx5pnbKm4z?=
 =?us-ascii?Q?xe8Qfc2dcWgem5oDY3PGndZD8nrt4MYKV4QqKAzETwh6MzJ8JCx2CVN7vjNP?=
 =?us-ascii?Q?jCl58Sjw43NL8gfy9Fj81SgVPuVuRuhwo8I5EfO56NIgPeAbD9+h+zunnVLl?=
 =?us-ascii?Q?Z6f49b/JDI5gh+Iar30Hjd498II2UHgcYuUFMIxKB2E6EQgRWP392Vui8vaz?=
 =?us-ascii?Q?N/jj4xpR0i2RpsgpymeuMDLq6fJedUrEddJTC08qaXEBR89vQHiniHPgZ3vS?=
 =?us-ascii?Q?X24lLdVTiEsmJYs3DSHd+lO5hj7niHhkXNH7H7d+NqURNa/n2C7+cb5cMpqN?=
 =?us-ascii?Q?zFTOndBbEtG203vddnpRkq2XUik6Q+8SCXjviajDG97xUWyYBI7YIt96viR7?=
 =?us-ascii?Q?Q51otlnVaYL4LzE+6bUpyYyDM2ij9xURqHYIfAhz5TXtpzKQMm5smMsWRvJl?=
 =?us-ascii?Q?M3hNF9gm3vEJj2ZRz09Tmd57/zMHYI/vX49+T1DVB8pBLt426lC8zqVZsqjU?=
 =?us-ascii?Q?coGuVh6Sxv+ReuzhFRtHAZQ4BUMZO1GsfetDRnPpR2/qxMKeeeN4y0Omk3ci?=
 =?us-ascii?Q?JLzwmlO/hgQrVaYePfyDmgtimIq/wMjBA5OqmH2UglgVCFdm81MiKeozUyFQ?=
 =?us-ascii?Q?0eN8iTM5a0vizaj/8+FAefmyAFurlsdNCpycWIzqXNgFpH3b/Efn55zqlgDi?=
 =?us-ascii?Q?gPlJpgerhKyjCrq18ojH4KAhiuYFzPAHtAILkqGekHMoNzyr8/o8YxWD2N2+?=
 =?us-ascii?Q?miSIjiESOUI6di/z0ad64BaE2mH76VAqvfNWmwJEgQsMt/QBI9Hz1y+mAMBG?=
 =?us-ascii?Q?x+JTXp1H4kHGIRrNF+8V2p0GbuFHNmgX8jDgr7Jbmo2ANV1PPwQda7EZS0c+?=
 =?us-ascii?Q?2F03y6ItInfdt+A2QW7krOFYBFe4UQYL8xnbSX+EmS3dbsaIfeDQWQHVUR/y?=
 =?us-ascii?Q?7/1EsRdVZBK//+qWVD2m2Tl98Qok/4S65Cephn7NV1YhoBy8EdDtkQ0XpITL?=
 =?us-ascii?Q?F5UP34BCrignzmnoXbaRc+ERVjXVoTqXgaSqRzWievy/DeBAlaWeW0D5VDV8?=
 =?us-ascii?Q?H99HzOZxEsEgjaGmz+9eMy5Ug7i+js3gVYqUOBwoIdoHZHdSGwVJhNWSPHSt?=
 =?us-ascii?Q?o//6gqv7JEMFp+KozwNOWN8h0XZT/z5NLO0ax9NRee3PmGYgZgBfqwi4XmtD?=
 =?us-ascii?Q?h0LiwAjjU13dITnyIr1p8KfzovIGV7GQk5YYmwrL/6KfOJlavVcXu6LvtXqd?=
 =?us-ascii?Q?FpzgDiumuVk72qOJGJugv+0OA5XINSkjI6MaKUGgJtviofyIod9ePBG599Zl?=
 =?us-ascii?Q?pr34sDsjuji1Pbm/8oye7Ko+kx6FXZcCVdaYGfiyv2+7OwbTupoNKxb6gdas?=
 =?us-ascii?Q?L05T/hdUmN2+gcqNZOZx0rvpqHBfRgJlqJC35mxUhT8jADLwBttvPxL9uVoe?=
 =?us-ascii?Q?YnONZN0DEJsMRHYJt3jH/n+wc1Lt1QKc9fZCJ96ZT5vo4QUa/wYE7m1LZsj9?=
 =?us-ascii?Q?j7THxFPL51CJpr8iO8M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456c5b86-d0f5-4d87-4a79-08dbb9232c82
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:14:52.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7q0lxdwV/pQoAAaraUeMzdxpP7v5u8lcyb0eRGwvr+t6jog4UkvCDllzkN6YrdAqztKjFYh5jzY8sWWXWWJXog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9829
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
index 0000000000000..e982651c682f1
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
+	TP_printk("offset %08lx: value %08x",
+		__entry->addr - __entry->edma->membase, __entry->value)
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
+		__entry->saddr = tcd->saddr,
+		__entry->soff = tcd->soff,
+		__entry->attr = tcd->attr,
+		__entry->nbytes = tcd->nbytes,
+		__entry->slast = tcd->slast,
+		__entry->daddr = tcd->daddr,
+		__entry->doff = tcd->doff,
+		__entry->citer = tcd->citer,
+		__entry->dlast_sga = tcd->dlast_sga,
+		__entry->csr = tcd->csr,
+		__entry->biter = tcd->biter;
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

