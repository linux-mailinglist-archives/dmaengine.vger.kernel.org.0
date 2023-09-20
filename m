Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7377A8DB4
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 22:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjITUT3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 16:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjITUT0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 16:19:26 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E4ACC;
        Wed, 20 Sep 2023 13:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiQR1A39DOwSrHwG60xvJbzei7itFLO3QmLlNZNWUpBdxXPtF9CHB3IjAkHo9GKEYGRXBcbqob0vAr7BWtf3uYwohewI3Ie/ZMNM8G3GYyEQdskw5/G9je45xsR8AIHEEg7qh42gzATY3hXftaQeChewG3389v5SWMRT3JqR5SSv5X68vlNtxoAwVMQhwi3tCKiyv17jgLdBYnI94/UJgxlVJORE4FSW+66+R16xlPPKUAZCaarpqWOAfkoy172X46JiyrX+gkz0q+v5ZWgfg1nE5hctwHDctFofVSKzvdlG9/L38SsNt36XgWA3wTx8y8riBiUy67CYaOgcWgp0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFCTSLcpmM+MOulIMZ9dkDY4lIv3hK0bLVZeMw//GpM=;
 b=jn5QU4CI4rFNAAYxpiD9dHS4Gj+UXsj2PB4CfFNjDXUy64vJfyUVe7QALUGdZMVNGHryQOmATu9XNzSjuaq7+V9ImamaUeGO/W+HM2JnWTikiDu84nfYcMq+sRrRyjyQyAaLqyqk2YJGm+mOHbFm0onRHUIog6gyQX5L9dvX9x04xDNAoOzK1bB8zCduTGPuHRiwuI2Ua7BKofEvgxGb64rh69oSozBomSjqunHtVA1vCIn4xoc/npeDpmbiPOYwp1cztFRvW8iv8RL2FzXvGhaA10uCopCVtmCVXXXfAMMzbgUibU91JIAZgpQyiYixQF3E+txuFcuKE3X0To/J0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFCTSLcpmM+MOulIMZ9dkDY4lIv3hK0bLVZeMw//GpM=;
 b=Pc8BNKkyJPryBqyBXj96+QQaNcBgvsic+9PXk+BNx3awj8iDCNas1BAvB9uNGLXUdobWqwW/Jc2dDWFXrZjAu/yNhmnpi5/82HPq7eURRe7w25hM7pEt9irrho0kZ1JpfO29R67Pncy48xckkd+P8tIZdAjZ2rCL/0fWYfbdZ3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 20:19:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 20:19:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lkp@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Frank.Li@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        vkoul@kernel.org
Subject: [PATCH v3 2/3] dmaengine: fsl-emda: add debugfs support
Date:   Wed, 20 Sep 2023 16:18:51 -0400
Message-Id: <20230920201852.3170104-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bc913e6e-ef2a-419c-c064-08dbba16dbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8YYf8QUklOKX1QQkMMuZ9Q05UcQD1EBBdTZd+MC8hkiQtbrK3tq0H7MfLn8D1JM+typ/BcGZJ14vT6+rlIqQHEwh1PWPr7UWQoCIP57ThD6fTsUcFFtqH2uLgiFb8K2r2azIscSv+lYLrYKG33/svz740bVhv4y7PqxIKu3wgZ++2GYyvT0Lfw+6fGow6UfnuqQUQnhvnidsRC3ztsFqxaAHpAz4Hnr8l7JXd6TTp8EJlSnSc6bpOxUr2s47grBj1xon6Xdy/ChRyr/DbdlimBpyO73f+l4CRZVgrnQMjRAlDq05wR86P9IQKGyt7cX75Me2MQASb1kzOtOAS+A20mCg3SZk/y4gTXVXMbq8XDWHD47CLRKUuX2uaquixrTj8M0YemuL9c9Q05fqaeCtyJGKunzGdXsFzh5MZcnmI88wHWBaY32vUuTM6yQhOHfVTMqeXAS22UD0gLhRcSa4OJNr7inhbEwd1OWdzntnG1QW3KgfBeu0Jh4p2q77ylxOxljqyKovU79+wI0lk0002p9InC/q8gQM50Xqo/o9db3HWKeVjRTkfskkqBoXvgAu1+lFRx/0ME40eOD5OTcUWqzCtX1mez/h+sCnlyV7grh54/psxYLQQhIXEUwqPqz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199024)(1800799009)(186009)(6512007)(52116002)(6486002)(6506007)(6666004)(38350700002)(86362001)(38100700002)(83380400001)(36756003)(2616005)(1076003)(26005)(66476007)(316002)(66946007)(66556008)(41300700001)(2906002)(5660300002)(8936002)(8676002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2nW48WEDnXGB2zu9zG5c1DbTvKG11E1wUds933ifFiyssu4e2IIt3pVTjBJ9?=
 =?us-ascii?Q?7v3RyDeCIpihPYsPhbrD64xzzkglJt32bPLiPdcotl1YQTTRzWw8kDTzFt9o?=
 =?us-ascii?Q?ZXY9JANJkl9imZzya5Yj7Bwn2OxH/L7bwuMBXdAuSVvpAJT+CGqGVh4Efbps?=
 =?us-ascii?Q?Y8mVhrIMfv5ALrZwmcTEykdyYBS63bFYCcu2BidEvv5ApU6a4gqNEfH1SXlf?=
 =?us-ascii?Q?IWPMLx4UwVRg4e8cjSe66oCqs5dihVkKhB8EVWOCP+LhoNN6AXZPyU+jujA2?=
 =?us-ascii?Q?A8XXhPgVAQfuNP/la0UGh2G5zQMGRCCJaoR93RCeZhRUQntyCLo0o9KX4K6z?=
 =?us-ascii?Q?6NWVNun7hIZDg/hLfPYmcIgy9I85oMBfFXFqa0PxhrsoFt1AO0/7yA/QIsCk?=
 =?us-ascii?Q?zwLQSaR/rgITpKjwvbKW0sip93PRoP7pAzrToDuxH5dhU7UIrIcwMDuxW0eN?=
 =?us-ascii?Q?LI8T9kFenEuB+UN8ctrMMkGDM/zniN06qRtVzQfthAOJ8uM/Xqf6aL8HbQ70?=
 =?us-ascii?Q?QBWSccau83RexSI/bhzGET6wEa+ndfmArD77v57WXZeutJz1TdUq4d141jRl?=
 =?us-ascii?Q?3Z7c/Uhs/8mg/tDybWQl06yGnqh7tJeFvajCv0VgE9M9+UmGhIy8CD3fkdNT?=
 =?us-ascii?Q?6IqEzmaA0SEQrOOBqcxJdW0j9DcKACoRfB+JwW7MytDonXXBeHhCkcLAD0QZ?=
 =?us-ascii?Q?6Cn+IIljDhxIqqvyBdB7N0VvARCf0neCj4aXjXrKaDQG1KxEifOgGBRDh+Pt?=
 =?us-ascii?Q?gKiNIUAfbgxSABNxLSVwq3OeXrPaTNQKbG0rTJY0VHa9XHAygowzSfRxgUmV?=
 =?us-ascii?Q?uQBAxsDJNSPYsSgAs9wWAH/lDXvVIcB55DM6w3w/tN8H3XnG/A1JhLcaD6Ac?=
 =?us-ascii?Q?9g8y6ivJ2S4M1OmXbp0iBsKRi+RgerNT7J4OEEzGhEQVbWZcf4UEKLzGUgzw?=
 =?us-ascii?Q?yQ8wTuBalSiaY3Ih881mOafQ/xyMTm3EzwgsgKQ/7Qg0thhmUVxr/EnaeLST?=
 =?us-ascii?Q?Zm67E9YslnuXoetgt2JLaSv/F3eFnpftoqnN6GPXtkWHwblI3vx8xF4Gixq8?=
 =?us-ascii?Q?+zIW0CBJ213tiYCW//fdQ0lXOKqc8h5dGXol6GmPeDjaaA8AgebGdjuor9t2?=
 =?us-ascii?Q?JPivwJT2G7ho0/5rRhr155LBvPjdOxnJJKon3iSeX24e3Fkc7UyQeQZOKKep?=
 =?us-ascii?Q?lje7IRO0dKeQtHScygzitBC2FlWMW+Znmq72lP/HJOrpTjkUvWwzNnDD9Zqq?=
 =?us-ascii?Q?/SpzKL43ocYqHZ68Za2K2xadNhRqfDBL+e9iTQBkGPwglwfUXaxYMU9gNM99?=
 =?us-ascii?Q?acRH/I/m1hnw5ujBzj+/NFmV86TpwfJvki6jA9LMOHtByxff2x0RwQWx0XUb?=
 =?us-ascii?Q?zoXj1ZgMyUP1ywX0pJb2TP/8UHFj7dCuTrMb+K4Q97eT9IQSGJWo4jpR/Za0?=
 =?us-ascii?Q?n68esdJPpoP027RcY/U4zhEFhAsTSP2vJeWplAApPf1AaVybC5VdgwE0gxUH?=
 =?us-ascii?Q?0Wim/MqOQL3A2qFdLB8Qrbp6REfNz35EhPtGTxgcLPu/jsq8ICtnLoQFISig?=
 =?us-ascii?Q?aFQOcbToYHzN6UKBQxJWiPloSQjhA1bnVlkdY6O7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc913e6e-ef2a-419c-c064-08dbba16dbd9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:19:14.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmq7526wvEPU6nhzlOiQ3jslfWyeWezFbGetKpfXYd5C4ZU24omV/ovedGlzBviYUV9HRn3zF1kfumGu9I0aCQ==
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

Add debugfs support to fsl-edma to enable dumping of register states.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Makefile           |   5 +-
 drivers/dma/fsl-edma-common.h  |   8 ++
 drivers/dma/fsl-edma-debugfs.c | 200 +++++++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-main.c    |   2 +
 4 files changed, 213 insertions(+), 2 deletions(-)
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
index 0000000000000..99f34198dae05
--- /dev/null
+++ b/drivers/dma/fsl-edma-debugfs.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/debugfs.h>
+#include <linux/bitfield.h>
+
+#include "fsl-edma-common.h"
+
+#define fsl_edma_debugfs_reg(reg, b, _s, __name)	\
+do {	reg->name = __stringify(__name);		\
+	reg->offset = offsetof(struct _s, __name);	\
+	reg->size = sizeof(((struct _s *)0)->__name);	\
+	reg->bigendian = b;				\
+	reg++;						\
+} while (0)
+
+#define fsl_edma_debugfs_regv1(reg, edma, __name)	\
+do {	reg->name = __stringify(__name);		\
+	reg->offset = edma->regs.__name - edma->membase;\
+	reg->bigendian = edma->big_endian;		\
+	reg++;						\
+} while (0)
+
+static void fsl_edma_debufs_tcdreg(struct fsl_edma_chan *chan, struct dentry *dir)
+{
+	struct debugfs_regset *regset;
+	struct debugfs_reg *reg;
+	struct device *dev;
+	int be;
+
+	be = chan->edma->big_endian;
+
+	dev = &chan->pdev->dev;
+
+	regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->dev = dev;
+	regset->base = chan->tcd;
+
+	/* sizeof(struct fsl_edma_hw_tcd)/sizeof(u16) is enough for hold all registers */
+	reg = devm_kcalloc(dev, sizeof(struct fsl_edma_hw_tcd)/sizeof(u16),
+			   sizeof(*reg), GFP_KERNEL);
+
+	if (!reg)
+		return;
+
+	regset->regs = reg;
+
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, saddr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, soff);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, attr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, nbytes);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, slast);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, daddr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, doff);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, citer);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, dlast_sga);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, csr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, biter);
+
+	regset->nregs = reg - regset->regs;
+
+	debugfs_create_regset("tcd", 0444, dir, regset);
+}
+
+static void fsl_edma3_debufs_chan(struct fsl_edma_chan *chan, struct dentry *entry)
+{
+	struct debugfs_regset *regset;
+	struct debugfs_reg *reg;
+	struct device *dev;
+	int be;
+
+	be = chan->edma->big_endian;
+
+	dev = &chan->pdev->dev;
+
+	regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->dev = dev;
+
+	reg = devm_kcalloc(dev, sizeof(struct fsl_edma3_ch_reg)/sizeof(u32),
+			   sizeof(*reg), GFP_KERNEL);
+
+	if (!reg)
+		return;
+
+	regset->base = chan->tcd;
+	regset->base -= offsetof(struct fsl_edma3_ch_reg, tcd);
+
+	regset->regs = reg;
+
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_csr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_es);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_int);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_sbr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_pri);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_mux);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_mattr);
+
+	regset->nregs = reg - regset->regs;
+	debugfs_create_regset("regs", 0444, entry, regset);
+
+	fsl_edma_debufs_tcdreg(chan, entry);
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
+	struct debugfs_regset *regset;
+	struct fsl_edma_chan *chan;
+	struct debugfs_reg *reg;
+	struct dentry *dir;
+	struct device *dev;
+	int i;
+
+	dev = edma->dma_dev.dev;
+
+	regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->dev = dev;
+
+	reg = devm_kcalloc(dev, sizeof(struct edma_regs)/sizeof(void *), sizeof(*reg), GFP_KERNEL);
+
+	if (!reg)
+		return;
+
+	regset->regs = reg;
+	regset->base = edma->membase;
+
+	fsl_edma_debugfs_regv1(reg, edma, cr);
+	fsl_edma_debugfs_regv1(reg, edma, es);
+	fsl_edma_debugfs_regv1(reg, edma, erqh);
+	fsl_edma_debugfs_regv1(reg, edma, erql);
+	fsl_edma_debugfs_regv1(reg, edma, eeih);
+	fsl_edma_debugfs_regv1(reg, edma, eeil);
+	fsl_edma_debugfs_regv1(reg, edma, seei);
+	fsl_edma_debugfs_regv1(reg, edma, ceei);
+	fsl_edma_debugfs_regv1(reg, edma, serq);
+	fsl_edma_debugfs_regv1(reg, edma, cerq);
+	fsl_edma_debugfs_regv1(reg, edma, cint);
+	fsl_edma_debugfs_regv1(reg, edma, cerr);
+	fsl_edma_debugfs_regv1(reg, edma, ssrt);
+	fsl_edma_debugfs_regv1(reg, edma, cdne);
+	fsl_edma_debugfs_regv1(reg, edma, inth);
+	fsl_edma_debugfs_regv1(reg, edma, errh);
+	fsl_edma_debugfs_regv1(reg, edma, errl);
+
+	regset->nregs = reg - regset->regs;
+
+	debugfs_create_regset("regs", 0444, edma->dma_dev.dbg_dev_root, regset);
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

