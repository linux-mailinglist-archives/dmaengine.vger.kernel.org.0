Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057D67B6C84
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbjJCO4j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240700AbjJCO4Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 10:56:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AEF4202;
        Tue,  3 Oct 2023 07:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPdbn2po5kwnQeCxg6L/CdugS4l1POgKfEfg/kHLZWSPADq2B3CbuXQQPoRieJMX0O8gc8ECT1iH2zyZrIaP7RsBP3/5s5mcKqGLTNEETW01vhRnHa8C+buyfatJxXid379qbn8fitGyDzbLfGGtrstbU+vlsMxq3VTXesGzztg8SDl71v0OwtzoCSug78cxPbKlp8WFuJ1vbDozskv9CLb0kQ686QZXygdBFNxHT3ieonzYRIAOuNKnycAwBjkywz26u7M3SVtmSKhIbDVYgczzxtV3lTvXEltfkEcxciSqpHLmChDz8V28iX6/zjdQIdZatZjHFAYNlc3dYKQTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrrRSsmz8JDYKRnhitxLdhGClwA1D4DSztdMBen7IAg=;
 b=Qg/+gWI3gqjMmMF5KrWZL5yoE3rMUJ75jYYP5Qhk0TPPFfDEEKv4EKXoyYQF4Zxk1d3BriBZMUC+KO3X+eBjSD87M8wVgnULx3E1KiCDk1Pg8TMUNWI41fqXCCLhNuZpngZJXsDRogb7/zzv4WxoUb2WiGmCaONkQYROMTNffYojLiuC3hc7lNG6wHjzc/hjxG1QuXtQw0SX/pHn1VO8IZb3zvXW9OrUvXwtj8mWfanSiXgAkJ5AXW5tct3DJzBw0SVigM+trGQnLgxJ7i3aYVDJMAH5XMTVzlX6z1HFxu1Ubmkrpi54s4Xj3Ynjo4JAxLzMVWK3v0J6578ZUZaWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrrRSsmz8JDYKRnhitxLdhGClwA1D4DSztdMBen7IAg=;
 b=VT0iKfZ8Psd78kI9Stp0yAivcHl6tdbR1Wz/9cs5Yt0IQHdoEbSut/KV3ZNDKNGcipXgn2a/b33OilChgDbnpD+4yJFwySuUCsdPgvrqpsCCueHIwlGyV3eIEy/GpRWTzECoAWEv8UDS4gWL+D4tiS2UjLaqFCFXbM3bMD/gDes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7526.eurprd04.prod.outlook.com (2603:10a6:20b:299::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 3 Oct
 2023 14:52:35 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 14:52:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     arnd@arndb.de, vkoul@kernel.org
Cc:     Frank.Li@nxp.com, bhe@redhat.com, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: [PATCH v6 2/3] dmaengine: fsl-emda: add debugfs support
Date:   Tue,  3 Oct 2023 10:52:11 -0400
Message-Id: <20231003145212.662955-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 46d53d70-505f-4ca8-6487-08dbc420618a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5goS1cGYK7Y8AStEyzxeBDql5hVGE/ogNUvCSD41NOYY2nq2FPp8aaBUjJbbONZhaX6ccNpJGPVTX1UJ3Qq4hfMZ/wwwTuSd/NHd+tWzKK2WU959GYUBN1pCQQdhik5LSZHaWufcelzw+jntglTNSK41DxRtVY6OGQg30G9uCLQl/LhIf/ZtAcW77op6irHtpCr/W4RLK3IKMqobBxZg52DoGDDFc8FpQituP0oA6fhDa0npjh8LiECsOvBREfyPbe2aPpp/qnqJzyd+D/8ePqyJoYPOp8LTkk4Tmm6EyWIiEF7gX1Qb8KqRz/6Y39AOUG44hpHbKK35PeNOCgJfCBapJH5Fc9vynvkiXyK4lHuJ5BYYufP3P3hBeAyPouecCOvF3ShTXZJ5MtUNtWDpiH+wIosLBxbeeX8KVrSHHvi9y6iZ+F/GmqN0j0rLtg+USrJm+Smuvswy0GGCwgoCSdEcgRUFkKzRqNl5F9MyxwaqN/zyr6StcdXQbeyFjDOQW4R+gO3wVe5MKiDdL5Vpviq36aW4teOE4iPeOSIJv73U71FEkjnZsuEErLzKh/GnQ7JoKPgPYDN/7V1/UcexNp4hJ9mnMAgoJe9o4ydeVL7SVkpPG2qiK3offRTF7Dcx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(38350700002)(86362001)(8676002)(66476007)(2616005)(1076003)(41300700001)(52116002)(8936002)(4326008)(66556008)(5660300002)(7416002)(2906002)(6486002)(83380400001)(6666004)(478600001)(6506007)(6512007)(316002)(26005)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N1TNStxdKTXIbv7gdL9wkNgFk50FijyVg7u5lp94MY2thHegQuf6dnoPbPxD?=
 =?us-ascii?Q?NcUNwhkg9mtaqXwvKu7vEoMCrCKpU+4oVoN1jymsew1rjG0jN496E2q49TgZ?=
 =?us-ascii?Q?LQhbs2ovwSRSuliralgQCUtyzT6yFktUdpv22JWQD6ClUtw14JmTzPYa3hTd?=
 =?us-ascii?Q?OgxHP+UfT8xKUKZfojYjCmXVzpjRLJrZeuvh08Odz2s2sZg9FJjvmSgAN0qX?=
 =?us-ascii?Q?XYgbaWIryMjJkjB1A4qhrMq9uY2549JX/kufSQ7tp+hGfNHwohbf+9//k+Zb?=
 =?us-ascii?Q?YTBphnCxJrurfANJmioQLMEfcdInCSQeNDOod/eviTvj8+pxy8LR2vh+N1vO?=
 =?us-ascii?Q?1qWzIt+XbmV+hgU4YG5INSy/8QN6cRE7XJaKZnwwWZPil+rKJE+wTvDtz+gc?=
 =?us-ascii?Q?o8AsKJ6eMlJ4LIhTcVBXSlLQ0FGm/d0l/9+rnwHcUIYl8CH1dW/fI1aAW5fz?=
 =?us-ascii?Q?JU8uwm1p0ARoncdFHyL/rXLBfe5Cz4RmMOE34mHE72wlJyjD/Jh9SYUybK0f?=
 =?us-ascii?Q?IdtD+QY8aqBiOQ1Vaiy4BNjpbG7lrnuIyl+f6Y4GAGJB2ht2zjUrh6EjeP70?=
 =?us-ascii?Q?53mbilT20MFGz6dqJXYNMXh8drhlZPANKdrNAXGkOnkobWQvlk0IZDzL3HVe?=
 =?us-ascii?Q?nw1C7v3kMWLhHXwufrWcTLSLLKa8lJJDuilNqpPAJqBeAQzGj33lTL1T1HA/?=
 =?us-ascii?Q?zdeEBzJxQH6S7K1if8Geqtx+YJ7LKY/3zQO4o9DDR6wYs68mZB6eyQqq0Unz?=
 =?us-ascii?Q?aPVNAUJ6k9W7KDbxNQ/o4raWu9Gvmb3O/vWXmECqy9hXU8Yi1fL6boOmbuX6?=
 =?us-ascii?Q?NQOFTThkSVan2ZcqGwJqMMa/VsbATUjRtGOPSPhHmeoW13QAAJGT6zyJXaZs?=
 =?us-ascii?Q?b+k2W6vwxffXjRBue5LufbfZ8U2oH8PPKtxUel0NzG//0JQxHU3GdrZSquuO?=
 =?us-ascii?Q?a/zf7KMMiDyEQvl76hFHwHHLuzV38BxYSLF5df+gNQYgAB2WFfgHYQ9ytPMP?=
 =?us-ascii?Q?HtSW90X3fUVKpf2BikA2KrI6YlfxOvtnKHB5wUhqO03aOgKq5CyYi/59OkXm?=
 =?us-ascii?Q?SRjcYMKnjnoWG/5Chx3+wcHSHYwIz7nN63976cwVNdgLHf+8GR4EIYXtGlhW?=
 =?us-ascii?Q?0qfF2CBpZqwx1tbOaRxjv7knJXGt3NwArZXDRiKEA/O6IYtnyM2rQQZqHBc8?=
 =?us-ascii?Q?eLdfBpZZZuOo4bIL97v9qKz72n4uEJLILW+3HaMNmpMw+33Xw8OaX4Nz1ydX?=
 =?us-ascii?Q?6cLwbcNCLhlmBSjtqBUZzPVwcxr6QBYVTKQX/ilFo2z0GBzfsfBX8pOJWXNs?=
 =?us-ascii?Q?R12Jk9K6ejdYCcGhrAJx1zGIBz+HjwUQ637331zOahvsKInmiEbD/tiA3Lj1?=
 =?us-ascii?Q?NVskHFTsoxAF5Y58fakj6eEVMSDYdxUdcDKV+RCO2xccpI0Wa1LvZtNSa3W7?=
 =?us-ascii?Q?3Za6+V38ExVQajBSMyezwhaglY8FPasgYYBbxK4ro5fIeUTEoGa61ATQhHQt?=
 =?us-ascii?Q?CJh5av6VXx89BGvtJEU8BNkm7nvsAMcjHGGDSdERTkEjSh5DYdPX19todeMa?=
 =?us-ascii?Q?cw4NlRNQrk57fKYhF3OZY4yFaPu5GmE5kVtkKtNJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d53d70-505f-4ca8-6487-08dbc420618a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:52:35.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGMrajtfvae4LyfA2QGEglELtU21uLXOz76zc6EilRaAsUVioR3Ymt4v//3OxSNa5htcsR+QkYElBIxDkTlh3g==
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
index 83553a97a010..a51c6397bcad 100644
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
index 3cc0cc8fc2d0..029197440bc3 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -336,4 +336,12 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan);
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
 void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
 
+#ifdef CONFIG_DEBUG_FS
+void fsl_edma_debugfs_on(struct fsl_edma_engine *edma);
+#else
+static inline void fsl_edma_debugfs_on(struct fsl_edma_engine *edma)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 #endif /* _FSL_EDMA_COMMON_H_ */
diff --git a/drivers/dma/fsl-edma-debugfs.c b/drivers/dma/fsl-edma-debugfs.c
new file mode 100644
index 000000000000..99f34198dae0
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
index 63d48d046f04..029a72872821 100644
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

