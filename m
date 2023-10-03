Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E537B6C7F
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbjJCO4D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbjJCOz6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 10:55:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99174D7;
        Tue,  3 Oct 2023 07:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrPKwwBpU0iMFh80uTAzl5v9DN9pD6DgSKI7+tYD/GiNWfiPsiAPzTOowmCJVwzEW+uaXIxwo7O9Ujkl83VCqUkVSDFCCXGKp+95tS1YBKVV6vv4pu1iZ2t/Afy6MOIMk2U/qHC0oMo69dOK/l9CUTc0uw/6x2LQ6c40lHSHNcX45629TQ4eIuRQlxSuCIzEqmbi5TiVyMt656i1b1L2p/DtpKjjHkUWpOWDuMzDX2LuC8uoXBFiDDH9zGS8QP8IN/ulwyx8HhCPk/eugsEVMLYY8s8vf8e+Pvj1p0gYYFnKfBi9BDqT1B2SNYZ4WTEvl07u4V/+yKnFZGEkan3+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSwA1bfeEHszTu5G6jeavumnHAM9N1N3W/jyFWLPiiA=;
 b=fJ8G1PcMpgICT65drpWGku5PUHiKWIZVXRjsRt2+dgY/PCKn335UgEnkbB3CWvWIv1NXZwUmLRh5N26Qs176UYv/aRA1Tbaae3FvNmgcMG9OmzoVETOebB2TLJxQVP8NjJHKP7VE0EGnBVtpd52i2rDg7Uj2CfS7gMwVdi6KC6uUgWL0m+V4VFkjykMPJXUJR4iQlKgNniSwAS+LLMHR3YunOYoaJcX2S7QVOJinLpeArsBVEQSo4q4DTN9551RX75Sp6s547y9buNOikmhWII/DpE+7N+qmP5Ng1WfBa0S1S2G+X1PI9C7UFJCYV/napgegh9Qze2e61vgbusl90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSwA1bfeEHszTu5G6jeavumnHAM9N1N3W/jyFWLPiiA=;
 b=ZahUVLhBfq/B0noF/Tgu9VK/AszGLAHmbT6UhISRFQL+bGcUi0TtlbuYoNnYHXlXDgX2gMHcHfpQgGUtnCLpNvjeUVPOawhAwsej8v7K+VR28UDwGId8inwHcWYJgikldq05UjybT/ZjB3yrks9P6NEBvNR2Kw/78MH+rNuliAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7526.eurprd04.prod.outlook.com (2603:10a6:20b:299::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 3 Oct
 2023 14:52:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 14:52:39 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     arnd@arndb.de, vkoul@kernel.org
Cc:     Frank.Li@nxp.com, bhe@redhat.com, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: [PATCH v6 3/3] dmaengine: fsl-edma: add trace event support
Date:   Tue,  3 Oct 2023 10:52:12 -0400
Message-Id: <20231003145212.662955-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003145212.662955-1-Frank.Li@nxp.com>
References: <20231003145212.662955-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 51245aee-a80b-4c2f-81f9-08dbc4206356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUoQjmagccczRU+KR7MKIly5AlD5XeX0/RdZNF97i96BxAH/lvOXmTA37Yk4hRtgUqqoKrQeeRQmEWttTnA+J9DgfIoYRTkCzYecVj6JF89OZMkW1y3+NbSnbgV79DIOvPvevnI+XZE/k7AS/mWYRSJtdbDQWTsYflWHKHRkLac5vRMqMNK+kGISCXDjIOjui+j5ud2buQbvEZecV+k1roOhOI8Pk9MDb5PCGDDWSVu7qLt5YlCY21VMd2ipHpxWYZsha+phLZlTn8zPDcN96EDWQms51Fy1fuNxajiXHvyDafy6sdZfbPSKD83pfgVz6tpEOzkdJKapoCdB3sWnhsPop3e7jMZacntNsGM3S3IfPJkr0EcOVGDwRRQDpOCFB+pBnyMJkCSB6jgrny5mVF/oDjLnH4XUQ/tnqGbMbXccrNfJdVmRebHaK60LonK4LgajKk9Ou8X8uGYBOBYV2WkcArXWSHZOGb/T/dLYfG5SwRovmNNgg3cMhuhvKQUkeSdhjS6U2iWsFpBKvLZIQ0iw+8ezw7WREsvMYLmNSi+v2rd36P6kXYbM0G7cY9eHHdPolnaZB6/lF+7KU65K13TnsC7nm5GGuci5jGSj9izmJ5Y7X0Bi+YSW4I4mAw4J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(38350700002)(86362001)(8676002)(66476007)(2616005)(1076003)(41300700001)(52116002)(8936002)(4326008)(66556008)(5660300002)(7416002)(2906002)(6486002)(83380400001)(6666004)(478600001)(6506007)(6512007)(316002)(26005)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TONi1xaDgTbLfBpG+jG14KJqQ9bwBYjzWj2oD1VoKjqR/rJ9TELpj3daMwgt?=
 =?us-ascii?Q?zjNd0Z/MCotzEudcmR5rdfBvfLp1Jxj9hRgPtdjhYYSa9pg9Wk04m7CcoLyO?=
 =?us-ascii?Q?JgymRC1fMCUUtILv0kgON6s9NBs5G30g6SaLUu+nosWrj5IYNR5UI6MKBQz8?=
 =?us-ascii?Q?HhRAsIqD2GEyubb23wfTpvAiyZk8+6v0DPMYRb3Uj0xoUkYK5F8/MLwu9ifM?=
 =?us-ascii?Q?AajMzRV6hM0WKRIft9qtFWjwEmyBUHjfAfAmOo5Bpkb0fnpSWxYL+v8x8VQX?=
 =?us-ascii?Q?JPXeZ7L/DMC2cAGkwT/kapUFvOIN/bvKqVsGUQS2dYuAPLRthVUR2JW4E7bN?=
 =?us-ascii?Q?w6Lha1AV9uONxlNSbBWlyaEYheNlHjoQ63TE0PFTz/sfb0NfudGwbbQfD/e4?=
 =?us-ascii?Q?Qzq30RYL5wGMLCcZAsG+R8LdI3Atsf9mLE+ei0N3xtp4ViQRacak3kdDjeJe?=
 =?us-ascii?Q?7tKkr8K1BcyZJLo6B5Vvg2b71FUZnsbj9CSZZqpyXdbyDuOjABG566mj5Pfd?=
 =?us-ascii?Q?wQctFrqmG5gTRw7jKqjUiXnuHTiZ+g68b3PM2B1G28e9j/i/FLgr67Ld/dds?=
 =?us-ascii?Q?X+0f0JOvzScrbgoMsfJOoQzmDrLW35GG/Y/j7TgdRCfvD6+AN08332zhLrve?=
 =?us-ascii?Q?gAR1hQQbhJc4rTznnW4HNoiXz2u4au46WW7xo54703AO24xXPwNI+C5yFoRl?=
 =?us-ascii?Q?6pnaWwW+tw6nHa3Y5OoXEiUWkhAKv7xf910RRXnbC92rtUswZbi3BwglxG/S?=
 =?us-ascii?Q?eIVPjiG9riraN2Ni3ntUZTELXpClppsfc1rSx9gSWLtfdz4T2cuybn0R+pcs?=
 =?us-ascii?Q?73M2uZOtSVrzzEBLRNpFJn/dZDws+KXnw/tk4O+PSta6zWjPrPuKf1Gso8dV?=
 =?us-ascii?Q?iKkXPotY2Ri9Q+M/nWkRRvnzoMRA6q6yqsH5miTPVePm6QrBIOCK69rEkvRi?=
 =?us-ascii?Q?QrhrXmCtIFMmQs2cV0EgE4NX7P5c6zNH3CbmyzusWkIknH4jJfk2kEP+ASTI?=
 =?us-ascii?Q?NW3wwECoZHkSOeYjAbmIn2jlMshwOnqIfRr+i9yZ+iAxQWEkxfeXEnjwCZgo?=
 =?us-ascii?Q?yvthpR2viZjgBSrJAZwSlFSZAEHcRe1ksbNQQD1q7hx+c6O8e5w4FxnONx3r?=
 =?us-ascii?Q?OVQLysp3YdMhcE1TaJyf6KAwIIzbnvwPGgVETfCscZHcmQF0FSRV69r7aal5?=
 =?us-ascii?Q?q8qqczScuxmrMXWOevrp7Tcq0RwMY19nZ0YBJ1iDXGlFxOc9AMYXggoS01Li?=
 =?us-ascii?Q?pXavxrOHFsHo2yHY8vfwgSpMwieP9MbHMnuPe+qGCjKh382/z/5wGFWDaSXg?=
 =?us-ascii?Q?3Tv/BN0nWW/XK6XcXVARweTm0F8OW+UnFAYyNGvH4d5ZdiE7aEN9IX0FdtR7?=
 =?us-ascii?Q?GeWO1cNrefEYYsjJ7S6IIUY4unb9fwL3e0yLCKhjlLtfRQxi4qEiFkqJrVL8?=
 =?us-ascii?Q?SAHnSlDqJaA0NusDk+cFVYlLzmAAAcM2argae/NZupBExUUSYVDHfXezfMNS?=
 =?us-ascii?Q?nzQ0M3JZ1b71s1O07Iaj5VYfwXnc/pckruB4E59G4ywS38zhG/CEuO8/j0wK?=
 =?us-ascii?Q?XN+S5A6UqQngiVvBHB3z/+YCM4iyB4lvOcCauf4i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51245aee-a80b-4c2f-81f9-08dbc4206356
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:52:38.9267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFrloVFPonZSYNddqkixnOzUGvh+b4RUXxFQsedLmMwNVcQ9WOCP4dUoefirPgzyiYYC6ddJYkPrq1FlCeferg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7526
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

