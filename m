Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398C571A0A7
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjFAOnh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjFAOng (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:43:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F87E1AE;
        Thu,  1 Jun 2023 07:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cvgiv3ChNF6e7RrA6v+Y12PwtHq+fgNiUKg3zqYSUainFcCiKdRZqByBK3NbjuSiB9W0bUPMjCG/kRN6WXdyVlvfLEe2bjHBzaioIMOp6mZKMqM4jj68Xo1/qtE0D0vHtO3njuVCojCU7GM2ngV3O+qw1bJAq2pU9mbOcWMZVn5Xw0PiY1t9AjrAEvwpgMxcHVHzJSjb2n65ceJsnEPTy9HI/4NQRGRAmw72brKmZbH/a49NVzMEkrrOie+DgW1at5Bscxw1bsyUGZuxLHUHuMg9dFvWWw5V3eoJ07WlzH0dYou+YlnBlWB9xN9p/4Jw8xeKkmgc8DoDdvrTctnsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vS59yURE7KxXX2D7ahF4xGEuJ/fXbFVmDbviscoKnY8=;
 b=bmhdObmP6zEhxMpOYEvj5yyialnQrjoHRKxUs0HM4jHC3b4dGnpDSwDAP0n3JwjWyIbL1RR/myouX6AMVVi6IALJdeNmrUz2feULQwg80Y6e0jpA+sVtJ7zfZwZ0FMtZKFIdR5NaodWOCz6n8uzYkJv4jldqlTgLjmV9S8yXidcgcvxNCK9x70e5p+4qkuZLYWZ0Lu3FwgHlNMg9jwh+bPHynjEm+lUKBUU74qlqkvqf7YdJsgDEpH8I/e97SFet2SQQeqsT6/w84TnbEjvQWEVTKwZL4GsvUC1pyJHPReu5qGKHDOAYmzp+qzapGb3AYEXi08uXg0B3Vl3rnLxzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS59yURE7KxXX2D7ahF4xGEuJ/fXbFVmDbviscoKnY8=;
 b=dhGXaT6jMPaLJiQZZXB7EpoawrIGkFAETW6cXPS6+qMA0l6b4B9LJSma2V5Fd+KYq8ow+LP8pxIjsTJkfBiPyyASQMDpQkjauF2T61AYYcZHW8usOzzvURhhXwgADr1F8MEuuFNf2K5WGX8zr2mju+Lja15J8azWd998yemxcRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:41:55 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:41:55 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
Date:   Thu,  1 Jun 2023 10:41:05 -0400
Message-Id: <20230601144107.1636833-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601144107.1636833-1-Frank.Li@nxp.com>
References: <20230601144107.1636833-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 719c6dff-2baf-4553-c0c4-08db62ae5882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9sWS2JTLPtMF2xart1by+VLUl8cTj9Ds1hgoF2VcAN05KD2QpOHIN9iRT8H1EfESpx9g51RGkOr+ftOOroMARxMNoLHhB4CTcv9ekuMM7UXqlcIm8YjYQcLTKtW2NXeWxQHyAAyG37repAHzrsyPQW5V1MR59N5ds6B7knBuPx+YGholS7e2AxVbSUC1aCDSMkBEB6JSZU/qTxUOcG5uKdWXti6vBq9wcjBec/xYYMmX2v5dCGYWEzUDfmQBPzMSrmBy5jIVX8+8n/09GapolbgidkujQBjvJ6dITVJhSmV62zJKcTsF9eSGiHpPBDq73OEGqU74vSVaALhEHBHYYL9Zfgg1sqqVKqDQJ+SgQE+Nw7rm/1o7DI0pKStsV1cdL1SKj4YpsE9aYDqypNHctgJJSRaxLEcaiWB2y/F251it6ZpVrAD9Amvp3ImHAE2S3FI887VC3hXocTRtOAE1kVjD9ut/bXVUT7Zq/n8DoOBJ3AOH5TnmL8soPl+QUqy5nsRyJQdx5NiA3GHh4oLx8TqKBr2eW992RAcl+rmuwmtWSTlqfjJIuiVGFp6+oFb6hF8/XfqLdFv2VIAgcOebOaw1bnNLkXenKtg/b4nCYkRvKakhN8wEz8X2Tl57DZ5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(26005)(36756003)(6506007)(1076003)(6512007)(2616005)(86362001)(186003)(2906002)(478600001)(66946007)(66476007)(66556008)(5660300002)(52116002)(83380400001)(8936002)(966005)(6486002)(41300700001)(921005)(38100700002)(8676002)(316002)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wbClvcTN19EQy0i12vDF0vvYF6rBQOMUdvbCtSCS3KXs1DQkeU7zM0XQeaYt?=
 =?us-ascii?Q?OZLzCF86oGf2dXzsoiO8jPU/F3mcoEjAQTVesojyjNzzgXWdjxFIzdN1320a?=
 =?us-ascii?Q?Xhv+jhk9D1G8TNie2Eo6I6S4wnfD9v4TiDfgBWlvALNjAb2Uog1vp3cigXfo?=
 =?us-ascii?Q?DPQVKVO9iBJnCeWSEBlSuWPC/OE6X3Osh6Jqs2iLGxvuyi++hZiiUnj7w4k7?=
 =?us-ascii?Q?GrBFAYOW6tthwmbpXwL1OOkbnMIYGK5//ZwFbwEQOHhvWN91RPBbqlLEk04S?=
 =?us-ascii?Q?7B3ph7GUzwTFdC3PITkrv2DH+7QufK+TPMISixC9EgzLiA763tsav5As8THC?=
 =?us-ascii?Q?CSU8hthcYCz/IJieWGLP6eUpHpVKWboR9LqNG3MseT2k93rLuYNdTfccwd14?=
 =?us-ascii?Q?nj3EUZyPdfXIobCHiiW295/GMMA/vQWfAZLC1PZ+4XI05TBGa4WEntpAGrD9?=
 =?us-ascii?Q?ehGMjPs68AonB+DQeZLOVbuM9BxQluRY5puHWpigqJEylD9I3+2V1l7NhenD?=
 =?us-ascii?Q?qxZGlv+N+64Lpg2Ff06FA8lknvvTGAohkgVTatGEVpj+AO+uECTSo/pM0iow?=
 =?us-ascii?Q?d4e564gtbamszdy3uRHhg2EWFFiTZ9ekGLz71+FFk3vTqkEMftKOg5Aj/fnK?=
 =?us-ascii?Q?PELkF/L401m0qhm9Y9zYrxyn7u8fFowkXbIILVpkQO4ko/yw8T55rGeQFBm8?=
 =?us-ascii?Q?gv1S533oR100c5r6XNzkLH3gcnxhZYc4BoxQLWNZYbdbFfFiAaVTGOiix/wI?=
 =?us-ascii?Q?ZfPDFuBz5GdG2wzDj59MyzRiCK5S/VgvJo3FiNovzfa7Q92u/KQeNhG44JYw?=
 =?us-ascii?Q?MTti8ehlfmkxpis8nr6+EbbXQVlnPBB088NTAoLv/PfznotsaevDV230/W39?=
 =?us-ascii?Q?6MZsbm4itLACHsDfnxWn8zjVf5CycnzRtPVEd1Hr0/nHQ3UluV12thAPRqZH?=
 =?us-ascii?Q?TPOlM3EskXJMu3Jz+6zpfjLN9dQDWZAwwIDt9CAT/6ANfQ4aB0BGezOb53aj?=
 =?us-ascii?Q?yGjhKZZpYqVH8pe6OxODgrSn3Pu3dC1F9DzcZ91sck700pzYDskRcwAkdtyA?=
 =?us-ascii?Q?T7LE+rIy2/AruJy92m7EGhupDNnzjqHT7vWVTJCzYGdEwQPGNcPtRlb3COcE?=
 =?us-ascii?Q?1E82+3fJ+GY3iVWryO9C0PzTxPmdB0ABalH9IKk4+qhoNQSDaA9r6CgkEJxu?=
 =?us-ascii?Q?uOyMkGEEEEdeVLSl9+eElipAZXhKjPDq5kC3imTTuXTs+wiZlUk/jh3m+TK5?=
 =?us-ascii?Q?2gw/VCw2OFEvdbKnqccyt7pg+Yd5E1UpDoSJAnDNweIN/lbpZuZODnqwZabM?=
 =?us-ascii?Q?ZF+REwjMy9AIGjJwYcs0TWZZ+AWxCnmF4+WFRncTQk9Wf8Dl0gU/zyqdUqiJ?=
 =?us-ascii?Q?52g8GMtiQE+SwfISm390n0BmZ6qopba4bLRYt3HQ56GORWPVFm1vwURf3+yB?=
 =?us-ascii?Q?AX6VCNdRhFLN7l1szd31vlJb9ZMzXFRCBx5+vXTwh+5hCzbjZDvPbf7UvaEa?=
 =?us-ascii?Q?jKPqZPZErXUfm8PAgVO7KIjuqyBIglaols2p1lqOh1EtL6pRl2XwUr2kO2RO?=
 =?us-ascii?Q?hADkQZoo2V/HG+NXvKBruvKsmfwpm0/V5dcfHN6q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719c6dff-2baf-4553-c0c4-08db62ae5882
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:41:55.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnjySRGMPFYruMYdG/Z3pdnlXGV2G3AX0a/33bc20zXRyVmdIdu5KbTzmFBX9qRGjdGoVTtHIs0BznrZb01Z1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7603
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Relocates the tcd into the fsl_dma_chan structure. This adjustment reduces
the need to reference back to fsl_edma_engine, paving the way for EDMA V3
support.

Unified the edma_writel and edma_writew functions for accessing TCD
(Transfer Control Descriptor) registers. A new macro is added that can
automatically detect whether a 32-bit or 16-bit access should be used
based on the structure field definition. This provide better support
64-bit TCD with future v5 version.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305271951.gmRobs3a-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 38 +++++++++++++----------------------
 drivers/dma/fsl-edma-common.h | 22 +++++++++++++++++++-
 drivers/dma/fsl-edma-main.c   |  6 ++++--
 drivers/dma/mcf-edma-main.c   |  4 +++-
 4 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 51fbd7531c74..eead6a4765f7 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -40,8 +40,6 @@
 #define EDMA64_ERRH		0x28
 #define EDMA64_ERRL		0x2c
 
-#define EDMA_TCD		0x1000
-
 void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
 {
 	spin_lock(&fsl_chan->vchan.lock);
@@ -285,8 +283,6 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 		struct virt_dma_desc *vdesc, bool in_progress)
 {
 	struct fsl_edma_desc *edesc = fsl_chan->edesc;
-	struct edma_regs *regs = &fsl_chan->edma->regs;
-	u32 ch = fsl_chan->vchan.chan.chan_id;
 	enum dma_transfer_direction dir = edesc->dirn;
 	dma_addr_t cur_addr, dma_addr;
 	size_t len, size;
@@ -301,9 +297,9 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 		return len;
 
 	if (dir == DMA_MEM_TO_DEV)
-		cur_addr = edma_readl(fsl_chan->edma, &regs->tcd[ch].saddr);
+		cur_addr = edma_read_tcdreg(fsl_chan, saddr);
 	else
-		cur_addr = edma_readl(fsl_chan->edma, &regs->tcd[ch].daddr);
+		cur_addr = edma_read_tcdreg(fsl_chan, daddr);
 
 	/* figure out the finished and calculate the residue */
 	for (i = 0; i < fsl_chan->edesc->n_tcds; i++) {
@@ -358,9 +354,6 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 				  struct fsl_edma_hw_tcd *tcd)
 {
-	struct fsl_edma_engine *edma = fsl_chan->edma;
-	struct edma_regs *regs = &fsl_chan->edma->regs;
-	u32 ch = fsl_chan->vchan.chan.chan_id;
 	u16 csr = 0;
 
 	/*
@@ -369,23 +362,22 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	 * big- or little-endian obeying the eDMA engine model endian,
 	 * and this is performed from specific edma_write functions
 	 */
-	edma_writew(edma, 0,  &regs->tcd[ch].csr);
+	edma_write_tcdreg(fsl_chan, 0, csr);
 
-	edma_writel(edma, (s32)tcd->saddr, &regs->tcd[ch].saddr);
-	edma_writel(edma, (s32)tcd->daddr, &regs->tcd[ch].daddr);
+	edma_write_tcdreg(fsl_chan, tcd->saddr, saddr);
+	edma_write_tcdreg(fsl_chan, tcd->daddr, daddr);
 
-	edma_writew(edma, (s16)tcd->attr, &regs->tcd[ch].attr);
-	edma_writew(edma, tcd->soff, &regs->tcd[ch].soff);
+	edma_write_tcdreg(fsl_chan, tcd->attr, attr);
+	edma_write_tcdreg(fsl_chan, tcd->soff, soff);
 
-	edma_writel(edma, (s32)tcd->nbytes, &regs->tcd[ch].nbytes);
-	edma_writel(edma, (s32)tcd->slast, &regs->tcd[ch].slast);
+	edma_write_tcdreg(fsl_chan, tcd->nbytes, nbytes);
+	edma_write_tcdreg(fsl_chan, tcd->slast, slast);
 
-	edma_writew(edma, (s16)tcd->citer, &regs->tcd[ch].citer);
-	edma_writew(edma, (s16)tcd->biter, &regs->tcd[ch].biter);
-	edma_writew(edma, (s16)tcd->doff, &regs->tcd[ch].doff);
+	edma_write_tcdreg(fsl_chan, tcd->citer, citer);
+	edma_write_tcdreg(fsl_chan, tcd->biter, biter);
+	edma_write_tcdreg(fsl_chan, tcd->doff, doff);
 
-	edma_writel(edma, (s32)tcd->dlast_sga,
-			&regs->tcd[ch].dlast_sga);
+	edma_write_tcdreg(fsl_chan, tcd->dlast_sga, dlast_sga);
 
 	if (fsl_chan->is_sw) {
 		csr = le16_to_cpu(tcd->csr);
@@ -393,7 +385,7 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 		tcd->csr = cpu_to_le16(csr);
 	}
 
-	edma_writew(edma, (s16)tcd->csr, &regs->tcd[ch].csr);
+	edma_write_tcdreg(fsl_chan, tcd->csr, csr);
 }
 
 static inline
@@ -736,7 +728,5 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 		edma->regs.errh = edma->membase + EDMA64_ERRH;
 		edma->regs.inth = edma->membase + EDMA64_INTH;
 	}
-
-	edma->regs.tcd = edma->membase + EDMA_TCD;
 }
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 316df42ae5cb..cfc41915eaa1 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -48,6 +48,8 @@
 
 #define DMAMUX_NR	2
 
+#define EDMA_TCD                0x1000
+
 #define FSL_EDMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
@@ -93,7 +95,6 @@ struct edma_regs {
 	void __iomem *intl;
 	void __iomem *errh;
 	void __iomem *errl;
-	struct fsl_edma_hw_tcd __iomem *tcd;
 };
 
 struct fsl_edma_sw_tcd {
@@ -117,6 +118,7 @@ struct fsl_edma_chan {
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
 	char				chan_name[32];
+	struct fsl_edma_hw_tcd __iomem *tcd;
 };
 
 struct fsl_edma_desc {
@@ -156,6 +158,16 @@ struct fsl_edma_engine {
 	struct fsl_edma_chan	chans[];
 };
 
+#define edma_read_tcdreg(chan, __name)				\
+(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
+	edma_readl(chan->edma, &chan->tcd->__name) :		\
+	edma_readw(chan->edma, &chan->tcd->__name))
+
+#define edma_write_tcdreg(chan, val, __name)			\
+(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
+	edma_writel(chan->edma, (u32 __force)val, &chan->tcd->__name) :	\
+	edma_writew(chan->edma, (u16 __force)val, &chan->tcd->__name))
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
@@ -170,6 +182,14 @@ static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
 		return ioread32(addr);
 }
 
+static inline u16 edma_readw(struct fsl_edma_engine *edma, void __iomem *addr)
+{
+	if (edma->big_endian)
+		return ioread16be(addr);
+	else
+		return ioread16(addr);
+}
+
 static inline void edma_writeb(struct fsl_edma_engine *edma,
 			       u8 val, void __iomem *addr)
 {
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 6bbf9c2cea2f..e5f42dd974e8 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -309,9 +309,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->idle = true;
 		fsl_chan->dma_dir = DMA_NONE;
 		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
+		fsl_chan->tcd = fsl_edma->membase + EDMA_TCD
+				+ i * sizeof(struct fsl_edma_hw_tcd);
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
-		edma_writew(fsl_edma, 0x0, &regs->tcd[i].csr);
+		edma_write_tcdreg(fsl_chan, 0, csr);
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
@@ -418,7 +420,7 @@ static int fsl_edma_resume_early(struct device *dev)
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
 		fsl_chan->pm_state = RUNNING;
-		edma_writew(fsl_edma, 0x0, &regs->tcd[i].csr);
+		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->slave_id != 0)
 			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
 	}
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 316e637b00c4..bccb5448e492 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -200,7 +200,9 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		mcf_chan->dma_dir = DMA_NONE;
 		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
 		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
-		iowrite32(0x0, &regs->tcd[i].csr);
+		mcf_chan->tcd = mcf_edma->membase + EDMA_TCD
+				+ i * sizeof(struct fsl_edma_hw_tcd);
+		iowrite32(0x0, &mcf_chan->tcd->csr);
 	}
 
 	iowrite32(~0, regs->inth);
-- 
2.34.1

