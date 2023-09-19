Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6467A67C7
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjISPPE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjISPPB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 11:15:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71C011A;
        Tue, 19 Sep 2023 08:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1o1m+sFFVlqDdoHl9jqyJq1Xrp2ugp6oXMdrV2UXRNKTxEOr+NEU/XXCuTTwWQ9XneDznZfaRUUaABXDR0pkGcWJW/lBecb3tGp3gp8IMReKc2LbMKEVgsOxiDNHtiU7eTJgIzgDAMr1jOy9QXNG9ISofzhI3ZnAwf48ssY/doEp3Zm8Loff6WI/F2WLrIpX2gRPB7ko59O6IyQH5JRbc0pRr3EX2p8egxbBnyTiRf1fA6qwtjTIxCoC4eRrJTJt0XI7hkQpUm4QR8LD9P2XlbZnQjD0ezhb5zxnFwLdsz/Nf47a0ZEy3cgK69Os2bqItZFrzPC/KunU7VbQMFcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpEc1Ms+p3C7DZca+oD81/SeTjHRAuq1zpspSFi0zfc=;
 b=BKbGe1D120xsYZWKyGAVpxU7v5yeyQvrYb70+pvJh7d4zYV+ZNiIXYN54UkqtatjRDE0G7uFvkh9cgpFKAJXaqaqHPQByTxv0T43d6XRZD4xH7e0jDmTSxamzoo2Yo96/gZbFLjbk/shWN58quMdTjj7hIaVI/gHGt2Q4+W1jbbLUV8FdrlKtI7jFO23lRX38OwUckpzXC7ggk+3Zx9pFoFoE6gNViskGRKSHlM89CBni5mvFAFgN0+YH7g+AWL9W+8EHzYI0W/utKAXD24NNEhzyWPuzt3mJ2+yggG6qX1d0GNU4khYqohyEmzrb8BL+s4WIfZRj6iHl/lDkxsjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpEc1Ms+p3C7DZca+oD81/SeTjHRAuq1zpspSFi0zfc=;
 b=oO24DBuRvoP9aAUEfe3IXrndyVGa7uTiQm3p1snOPd9n4luJNwSiM7+2vEXItZLQ+P+ahGXotCBHdVEbJ8Gi0eXl4XZLEDBSG1M+u1lY4i2+xjrPDuyDYJx2aDS1znCkHwLEz+o7R06eVHgJ6jsiOyLpRUZyRbSQmM2pqU2zcp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8457.eurprd04.prod.outlook.com (2603:10a6:102:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 15:14:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:14:51 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH v2 1/2] dmaengine: fsl-emda: add debugfs support
Date:   Tue, 19 Sep 2023 11:14:29 -0400
Message-Id: <20230919151430.2919042-2-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7bd284-2001-4db5-fa35-08dbb9232b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reGsxz0UmaO3qZvD67C0BfDeNRTa+bpbsndhQ1MeIY+LVywBBlq+oCgOKSdeVTtUNC8CYSHUaU2TMYPIzXD3z8s6NS7N2X6mF4+FfuKYKx2Yh3icC+AbKTJev0BxvcmSELhZPiH7xfBAUsfjykwvxMWIM5vsYodEGKXf8kjpiTV48lu3IIc6KzYef1mI5wse5Y1pC2hF+tO3KKdoUHU/CwemJyGa0Sjifq0uQiLlbe/NCo12fm7b4PE79jNZtSo2Qk3TIS/390lZPoGYFrEITJ7o341KJjdgyKwLxmjihKTHWiY3kkpX7TQXGkNOcZ0J2feA8IwvuwYTq6q6rBCnAthdWcRwJusFnzrnno+A4FoP6SWxFB/+J1tbqD86srS0vNSXhAuIpgcMHspgx83PUv1bULhjyvsnnI+t0mtGjREcsg1z6xdy3qyt3ZteACoWjxZTXVlWrZoym/TI0y5hE6H0UcNjf03+na3fBS7jbnaSerxiAAOKNB2r5S96ktKdavYpbRKsDASwllBuEfS23AwVb8qStEtZyGXAF4HArq4ZtcG7mVr5ovCYjowMOY2JYUix2T124nvvnM1lEPtTvyFHHA+oOUTy4/B2mJ181d1G49irCMUiCpqemWcKiU4y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(5660300002)(8676002)(8936002)(1076003)(41300700001)(316002)(66556008)(66476007)(66946007)(478600001)(6666004)(52116002)(6506007)(6486002)(2616005)(26005)(83380400001)(6512007)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HKtwtRDN5cwF8NZQzbjAHvv9N2X6sP0ZXdEy1lTj0MOR/lKtHKAsgqvbCu1s?=
 =?us-ascii?Q?1N2M/mdqIznfZbejhnOEb5FYYh3Xaw51fvIWJMAB0xfS3Lfph7HUcHwDSDju?=
 =?us-ascii?Q?c0LSUmCuDPPpDsva/kuyH+W9DYbTegL/X3JpNqMJlwODvg7XLKCPL75J6fLH?=
 =?us-ascii?Q?wCK0LZzUENONOe3ILNYjZOoByvLa+uj1YXfrxEVP7O7HEYmgBweOIR4qGT5K?=
 =?us-ascii?Q?KAmByOmkyP0d7MCh9eAUP2N7DG6YgiPTP6VMYl6BTizWqbwK41yHIspJjC8W?=
 =?us-ascii?Q?0EW5BsoAgTzfnus/vjh0koNQGt5MBJA1YC3Be53zQvWdz8/e14kBlEqJ1djF?=
 =?us-ascii?Q?kN2sFY4bFDElKhpgkCOBsXqQCYTWBI3J7n92Gm4aGWSGpQEk4XF2ueNd9V4w?=
 =?us-ascii?Q?CqOEi+AYHOIKcn3S3psiANtkV7JHzpI1gfc/fl7qpNJZMctJlxHLmQWM74xo?=
 =?us-ascii?Q?rH7xrimJr/iLbbZCLyfIY/Elg3kxIAFOozpSrP+9ZT+gKBeuxj64DYUPBUBg?=
 =?us-ascii?Q?JA6x24GsfgQ9jtvj3YX1ZsbN2szUqXptzvtXsxDTZcyYWl63XIzwH363ukx3?=
 =?us-ascii?Q?2OxThxyDuA0RyVTBGvPjaDSL3hTUD0/dYHQJCjziD8E2H+rdO7ygmkqj5UiB?=
 =?us-ascii?Q?iaCT8Q81g/04XsgjjzW1eD9EeXhFpOfnjLRIwciTNKQgZSx9Y0y5mPc+0Z0/?=
 =?us-ascii?Q?fO3Nyu1RYVcH6IBolX+m0/aNL2+hKiBNNi0F6So3I84AgJai76brzZCTpr4S?=
 =?us-ascii?Q?K8iM+3/fzv8plfso5z79M8BdcuI3IECkqHZoF8MKlhvAydo7gjKnmxOwFqrV?=
 =?us-ascii?Q?Al3RGmB2NzC+cdbiQ07BuGDm89aV9Wk4Lfwnpk6LcSGQDc1fsTJ4Lpy+h/Va?=
 =?us-ascii?Q?JnC4qv3RHpi9Tp8ktPsz6tklxvHJDoasXqsP9OCQlBPyFJP/zf/fjBNnMZ4P?=
 =?us-ascii?Q?Qd2w/EQ7U/MtQt6JV9gHdNTfWRUIL7en0hN9dp9nVgsK8fTu/pC+MaY0uQRa?=
 =?us-ascii?Q?083QtTiJYZ3r6rNeN9ZA8txqhtupXyk53hc7zlmCITk6WbFrg9Qnx/xYoMhX?=
 =?us-ascii?Q?uoL+tKfo4joHg3RrY+Au4clewWAb5oidyVn4xvoAOV7H5N6TalXUgBXbPynt?=
 =?us-ascii?Q?XrsZxwkgeAw3KtB7OwzrjOZZ9P9ZQjXTJImK7drMBXpGwnT7g6RCesQwKauE?=
 =?us-ascii?Q?Zb7lUwEjuQCh1loPzSLLITzT892dukSZjr7nrjdOetMzPB/aRevduPpBWuSk?=
 =?us-ascii?Q?sNneSDFFbiaPVLkLyEK8QdFj3zETGVlwcjkVaW1vBva7h2r7KSgjVE2gjE23?=
 =?us-ascii?Q?O2a5NgEW+Sr89yWf0iKiUyY72l20zp2zckQtJj7Ue9Yxq8S4fHcpSG3pCsIO?=
 =?us-ascii?Q?A5VRP0vJtMa1A+9HpOy2YoYSNxE94gRjFOpBwcT2ndJBtctS/RkLxuUSEDdh?=
 =?us-ascii?Q?Z+hCWhc/LTxzV3NtzhwHONjobtDjDXqsUUS7JzR+5lhwGBaCmM7voLSV8EvQ?=
 =?us-ascii?Q?yhRi+u5t0/pqnf2tb+8BlmPtoelUfZMZuNDcdWmroyc+LcE7bmgY/ARz04JL?=
 =?us-ascii?Q?X5ievTzFoUfO07F+8gM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7bd284-2001-4db5-fa35-08dbb9232b68
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:14:51.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfqP4mNMKfS3xxBEeYAiNhPvIYWlbW4Nozgz+dS+skcMRarH9oiPgpztVJn6JMPFV486K9OFULBk9m6luACDlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8457
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add debugfs support to fsl-edma to enable dumping of register states.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Makefile           |   5 +-
 drivers/dma/fsl-edma-common.h  |   8 +++
 drivers/dma/fsl-edma-debugfs.c | 116 +++++++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-main.c    |   2 +
 4 files changed, 129 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-debugfs.c

diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 83553a97a010e..a51c6397bcad0 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -31,10 +31,11 @@ obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
 obj-$(CONFIG_DW_DMAC_CORE) += dw/
 obj-$(CONFIG_DW_EDMA) += dw-edma/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
+fsl-edma-debugfs-$(CONFIG_DEBUG_FS) := fsl-edma-debugfs.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
-fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o
+fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y)
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
-mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o
+mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y)
 obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
 obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 3cc0cc8fc2d05..ecaba563d4897 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -336,4 +336,12 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan);
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
 void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
 
+#ifdef CONFIG_DEBUG_FS
+void fsl_edma_debugfs_on(struct fsl_edma_engine *edma);
+#else
+static inline void fsl_edma_debugfs_on(struct dw_edma *edma)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 #endif /* _FSL_EDMA_COMMON_H_ */
diff --git a/drivers/dma/fsl-edma-debugfs.c b/drivers/dma/fsl-edma-debugfs.c
new file mode 100644
index 0000000000000..dadb8b29d0977
--- /dev/null
+++ b/drivers/dma/fsl-edma-debugfs.c
@@ -0,0 +1,116 @@
+#include <linux/debugfs.h>
+#include <linux/bitfield.h>
+
+#include "fsl-edma-common.h"
+
+#define fsl_edma_debugfs_reg(reg, dir, __name)						\
+((sizeof(reg->__name) == sizeof(u32)) ?							\
+	debugfs_create_x32(__stringify(__name), 0644, dir, (u32 *)&reg->__name) :	\
+	debugfs_create_x16(__stringify(__name), 0644, dir, (u16 *)&reg->__name)		\
+)
+
+#define fsl_edma_debugfs_regv1(reg, dir, __name)				\
+	debugfs_create_x32(__stringify(__name), 0644, dir, reg.__name)
+
+static void fsl_edma_debufs_tcdreg(struct fsl_edma_chan *chan, struct dentry *dir)
+{
+	fsl_edma_debugfs_reg(chan->tcd, dir, saddr);
+	fsl_edma_debugfs_reg(chan->tcd, dir, soff);
+	fsl_edma_debugfs_reg(chan->tcd, dir, attr);
+	fsl_edma_debugfs_reg(chan->tcd, dir, nbytes);
+	fsl_edma_debugfs_reg(chan->tcd, dir, slast);
+	fsl_edma_debugfs_reg(chan->tcd, dir, daddr);
+	fsl_edma_debugfs_reg(chan->tcd, dir, doff);
+	fsl_edma_debugfs_reg(chan->tcd, dir, citer);
+	fsl_edma_debugfs_reg(chan->tcd, dir, dlast_sga);
+	fsl_edma_debugfs_reg(chan->tcd, dir, csr);
+	fsl_edma_debugfs_reg(chan->tcd, dir, biter);
+}
+
+static void fsl_edma3_debufs_chan(struct fsl_edma_chan *chan, struct dentry *entry)
+{
+	struct fsl_edma3_ch_reg *reg;
+	struct dentry *dir;
+
+	reg = container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd);
+	fsl_edma_debugfs_reg(reg, entry, ch_csr);
+	fsl_edma_debugfs_reg(reg, entry, ch_int);
+	fsl_edma_debugfs_reg(reg, entry, ch_sbr);
+	fsl_edma_debugfs_reg(reg, entry, ch_pri);
+	fsl_edma_debugfs_reg(reg, entry, ch_mux);
+	fsl_edma_debugfs_reg(reg, entry, ch_mattr);
+
+	dir = debugfs_create_dir("tcd_regs", entry);
+
+	fsl_edma_debufs_tcdreg(chan, dir);
+}
+
+static void fsl_edma3_debugfs_init(struct fsl_edma_engine *edma)
+{
+	struct fsl_edma_chan *chan;
+	struct dentry *dir;
+	int i;
+
+	for (i = 0; i < edma->n_chans; i++) {
+		if (edma->chan_masked & BIT(i))
+			continue;
+
+		chan = &edma->chans[i];
+		dir = debugfs_create_dir(chan->chan_name, edma->dma_dev.dbg_dev_root);
+
+		fsl_edma3_debufs_chan(chan, dir);
+	}
+
+}
+
+static void fsl_edma_debugfs_init(struct fsl_edma_engine *edma)
+{
+	struct fsl_edma_chan *chan;
+	struct dentry *dir;
+	int i;
+
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cr);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, es);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, erqh);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, erql);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, eeih);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, eeil);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, seei);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, ceei);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, serq);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cerq);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cint);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cerr);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, ssrt);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cdne);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, inth);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, errh);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, errl);
+
+	for (i = 0; i < edma->n_chans; i++) {
+		if (edma->chan_masked & BIT(i))
+			continue;
+
+		chan = &edma->chans[i];
+		dir = debugfs_create_dir(chan->chan_name, edma->dma_dev.dbg_dev_root);
+
+		fsl_edma_debufs_tcdreg(chan, dir);
+	}
+}
+
+void fsl_edma_debugfs_on(struct fsl_edma_engine *edma)
+{
+	if (!debugfs_initialized())
+		return;
+
+	debugfs_create_bool("big_endian", 0444, edma->dma_dev.dbg_dev_root, &edma->big_endian);
+	debugfs_create_x64("chan_mask", 0444, edma->dma_dev.dbg_dev_root, &edma->chan_masked);
+	debugfs_create_x32("n_chans", 0444, edma->dma_dev.dbg_dev_root, &edma->n_chans);
+
+	if (edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)
+		fsl_edma3_debugfs_init(edma);
+	else
+		fsl_edma_debugfs_init(edma);
+}
+
+
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 63d48d046f046..029a72872821d 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -612,6 +612,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
 		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
 
+	fsl_edma_debugfs_on(fsl_edma);
+
 	return 0;
 }
 
-- 
2.34.1

