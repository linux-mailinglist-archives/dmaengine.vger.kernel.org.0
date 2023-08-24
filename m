Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4375678754C
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 18:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242448AbjHXQ0r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbjHXQ0Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 12:26:16 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803E21BE;
        Thu, 24 Aug 2023 09:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcdFwRQjXO6ph7Wj188qczsRCw1LctRbKW92uqoB4JiPot1E7ldwhyMTpB4mVGHCJU6Pt3yeOC7anFiHKN3aLaddkLEToU8E4niGu2eYWWmVDdqmdZc+OfbfW+EecBXBwCl6i4EjYReU6kf90HD2kILbQO757rgWTUIm4JWk9L8IJ7O2N1EznwUZx9BtyQMeofCwApU+/NdQL0GMyrkAR2UlvUXZWRiACGYkt2oMKO0jmpNNgWzvfhsSNqr5YLgarjjnM1eWXMHTBqg2ulQQWnCghZMUWG+joLMI/O6E9jaMdmoRId14gtY/Fr+7g+X2klQLdFp4Tp24TYhZTJ6HXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeOsqgZafWe7JXJudPD0OiJcqcuBVmiM30CcNoOokDA=;
 b=mZJeEX87fvTgMWLxCUc9trX31pb2t8+zCnrxQlKNFfDBmyNKWiwfE3G7MBEwenxT0XGFG5Aca3KBC/sV1je52sH2Tw5Ur5uKVGq08DK23XrlcA0BsLp2iw8YvcLRBFYEvo9hnDSJApF9QukzWPDYGfmbd9dZLUskESCCbjZUpXR7CDnlSwrJwDb9jc3M3X9HRuQR4O/++tJmCIahY/2C6slVsKQmiEGvGkEvfKn4SIuWRGPPalEhIdznKjqPcDcyi3tMi5UnwPbvcPPWV0rpd9JS3Kb2IJMtwB4tKObCtMDYw25PVdG+ot2T3AaL7SoURiLuJE/XEKVfkOa6vUQ3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeOsqgZafWe7JXJudPD0OiJcqcuBVmiM30CcNoOokDA=;
 b=clfdy3F6poriIlJHVMP2Sbqo/Ws8uzQHNZziO6XRloSTrePpAkifkrMf4udtc48bFCcy4aw9lcoBNYkoMHLPWdXSXuOKE7I3UWBpGC0/pW4x/v5PaL3YZg/cUdKj0kMqz40EcbqkKco7yIz2+JzoyZq3AkKUrsBIO2B2l4jP06E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9656.eurprd04.prod.outlook.com (2603:10a6:20b:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:26:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:26:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH 2/2] dmaengine: fsl-edma: add trace event support
Date:   Thu, 24 Aug 2023 12:25:48 -0400
Message-Id: <20230824162548.2940355-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824162548.2940355-1-Frank.Li@nxp.com>
References: <20230824162548.2940355-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::47) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5623e5-4c0a-4b0a-a26a-08dba4bed3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rYfSxV5mzNNrdfCabfED3V7WvF8PKfkJjCOHQ0FEKpzNx/lIS0W9l0qLfMnMg9/jm/41e8yQoM8YrYwpalhI97twdWMgr8xU6TWX7eMNhr7jHWJZp9vuVGdQTiyAJnlZMf9cpCoWRw4oypUzAoXLJFyYSiXodPhvSqkn6I1QH6dSKAIYn6ZbFPVb5FXDmQ9l1UzNqoNqlStH+7hH2TxFM2+CkH4VB0aXQYVm4ZF9ze4bmmMlZXCJ6Qmou2R4owNmwhDn/H2ZjTQaQK4rOkN5fq73OAlVPBxH0+yMnfPPZTOFxIAYCzlMOFrsNc8zdKUEAgEYi608lhh/CCVRacK9BC2p6SlZmqCCu6mjMy9+GKNkpNUmuYZHwNv4WD0z2ewJ0gfgKJqHeMLihQYiRW4SvYoQQVk7oGNyJBnsFBtqDKwI08TR/2geG6wgk7z5dT0COYi5lPyEV9FELcnTuXcY2IU3WYGMJjlzptHOr//ztc8/xQf9lt8FWmYH3Vuhg6Si4a9Uiq5A7cGECh4ofW4qxfsJZNDDsBDrtRXEB+YBpZlVuBL473V0Fs8UOUfmBM2mGuMoUJ1mqTRl4WOutmD7QLm6TPKO+/lDZbxFAkhhdC/DNXh2p0J1gmghnEDuR6t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(34206002)(8676002)(8936002)(4326008)(36756003)(83380400001)(26005)(38350700002)(38100700002)(6666004)(37006003)(66556008)(66946007)(66476007)(316002)(478600001)(41300700001)(6506007)(6512007)(2906002)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pFfpdKNN4ogx7qGgeI9FRqeCbemIv/g9as+QNjCotaBnLkxpT/GPQTtafEyv?=
 =?us-ascii?Q?aC6SflYW1B6ajiwTozUdHUjf/PYoobfnKn9L907zYIJBpCLtYGiO/5i5Nvlq?=
 =?us-ascii?Q?r+wGwt3T+Sc6djxVcHimNryj3HKlBgk78F0VhGy7LtbnZhjItBJohM+H5QHv?=
 =?us-ascii?Q?Cfv87Cb2o2v9idcE9HJEhDawaA4UHS9n4wgmC6QcKExv0gCsj9PKqrZh/Xcd?=
 =?us-ascii?Q?xZcmyqY2nzNrlI0TenuyDe37sIH//sLTm4UXyJ/3HayIm3ADLFkhK5u8Q/NJ?=
 =?us-ascii?Q?zZevFjADRExVIgfkSoAijQjN21cymmcdA/8zL6LvBW0p2inAm6ENDd4T/ybz?=
 =?us-ascii?Q?+3y8Mm4DCW7+AdHOC+zcAZVhejz0ReHfEByyO4j4t6tsvNq8us4MpCugvcw0?=
 =?us-ascii?Q?dOrlbQyRVewWfjQi6fnzj5m/dFeBhhWkB40RVA1rQYxK+C7RCcX8aTyxWzUp?=
 =?us-ascii?Q?3SlpWgX0SQI85aJnEUJCD3jyqO8hwnmGkwr01kLXi0CdZ2g3WRGnG0U56QUM?=
 =?us-ascii?Q?PyIR88oAdfJyGvuCRVIBB8mScpmYt43kKkmlKjwv8PCS9q8zj87NY2Bw12TV?=
 =?us-ascii?Q?wbsYAY4TUI4qvGT9aD1ZcrIjZecV9We3O1imepT3wWCQ9raZkT0BfIlzSe0i?=
 =?us-ascii?Q?ECP4IKwlhS0+ILL18tMC+XiOBaRLkYVhZdA7xxDxz9cr+19+GF7aanLADubx?=
 =?us-ascii?Q?MECm1OwpMVbU6cG+phKFs1t+/gmaC+Wym+zMY1rWxHfgI5HWCNYyvS3bFSd/?=
 =?us-ascii?Q?/ROjTVfuqoCrIb/VAlRLrBhdQ0av2J3ItdGBA1nnfnNkPDABpMPLpIXbAN02?=
 =?us-ascii?Q?nL74B/ZE5q/NyIFf7m6+H959lBXdnvz5tWyzyqCw8/AYfqchShH7Sed3KtNj?=
 =?us-ascii?Q?nHS1ovi3zKDMEYXCfQ2ctOS2i6ybFjMxuX486Ibvf6Tst6eYohnMV60EG9mw?=
 =?us-ascii?Q?3RBIQz8wihcMOHHMKyJaMIc8Z/6Ux47Jt/OjS5r502rhoEv68LPtmQMZl7qs?=
 =?us-ascii?Q?0u1Pt5ueqOKV6pyNdKKEbh3hLiVkW54VNBoijns6o5BaGGztDzrn3W4EY8R/?=
 =?us-ascii?Q?iadAoBJXqOKWzxBNjY4k9GMyICZTf/lOeGZlA2r0yvFcquGH24ma9a8rrUBS?=
 =?us-ascii?Q?OkTOUmQcGUH5bUSPneTJVGHKiN8a1YHzxHsWXvWb38A2gGziM+pzwtFi0Vts?=
 =?us-ascii?Q?YXRsVN6lcmJpe52SSfCtL6SkVnfML6eD7QH1Q5UllCIkBRHl53B1BNFvs4+v?=
 =?us-ascii?Q?63oFcEmT/f6UdW3A5ozZ2Nj6Fjlsv+iZVbgbmL7ECO0mZ3eIEmv+30rQfTbP?=
 =?us-ascii?Q?0tKJ98T1fndkn6E/51QxgqANY0lXk7gGdDVG24PaOzmjAB0DPTrU2SiAzCqm?=
 =?us-ascii?Q?Y4PZYf2t/GdbmkJWeFbB9GmIMyBCWGXMDP6+6DecOgwmQ53cDgzrtL9PyJHw?=
 =?us-ascii?Q?JLINNUEuY+nPIITAMZa2laf9n0j3rw3GpJbVC2BQDcVMAiem8cRK+oV65HtR?=
 =?us-ascii?Q?MGXg5cynnuKazgMzDwd0OufnkrVZ+7WtvGRc2vvVjG8wZh/G79BbZ5GHW3vq?=
 =?us-ascii?Q?vjl6bpheUsVo/CnmSw1Sl5RJsYJ36gPZpezU4gXd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5623e5-4c0a-4b0a-a26a-08dba4bed3dc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:26:10.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDowyAwd9BN/cHuF6L1X3LpqUGW+va9RsN2rztmvVzE7G7QQn4bOZz4Cxn3Jg3Ff0EfeE5pcKdvs29L24eSJhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9656
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
 drivers/dma/fsl-edma-common.h |  29 +++++++--
 drivers/dma/fsl-edma-trace.c  |   4 ++
 drivers/dma/fsl-edma-trace.h  | 113 ++++++++++++++++++++++++++++++++++
 5 files changed, 148 insertions(+), 6 deletions(-)
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
index edb92fa93315..70e24e76d73b 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -527,6 +527,8 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 		csr |= EDMA_TCD_CSR_START;
 
 	tcd->csr = cpu_to_le16(csr);
+
+	trace_edma_fill_tcd(fsl_chan->edma, tcd);
 }
 
 static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index ecaba563d489..a9e27110ac7d 100644
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
index 000000000000..2a11cccb76e7
--- /dev/null
+++ b/drivers/dma/fsl-edma-trace.h
@@ -0,0 +1,113 @@
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
+		__field(struct fsl_edma_hw_tcd *, tcd)
+	),
+	TP_fast_assign(
+		__entry->edma = edma;
+		__entry->tcd = tcd;
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
+		__entry->tcd->saddr,
+		__entry->tcd->soff,
+		__entry->tcd->attr,
+		__entry->tcd->nbytes,
+		__entry->tcd->slast,
+		__entry->tcd->daddr,
+		__entry->tcd->doff,
+		__entry->tcd->citer,
+		__entry->tcd->dlast_sga,
+		__entry->tcd->csr,
+		__entry->tcd->biter)
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

