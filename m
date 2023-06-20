Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D597375DA
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjFTUPH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjFTUOo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:14:44 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A5F1FE1;
        Tue, 20 Jun 2023 13:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9oyWpTYAvdaWVFBnFAX/buFOgwK2CD5+x7+ZmdcoouA6AqE7UBJUQb2cnprvKs0t0lxMya7U8zfNzxLRCl50fM6Mhgs0TtxSuYdV2h6++cLh2c/QdroLc9tCNeGZ0bmCXBNIeDxJj6o+v9qW1NZqTPGQSsT6NDVMb04bWtfLzrkEcU+kg4EYV9FVHxmVldfzXAHcOny2RTVQLFU5OXbvtGzbq3OEUHgie7oxzXADsnPLBgioJXvRS8yap9K82eV3zu+246hJUUyNv3X+hwZLDuI+4HGLrEGuVK8PhNvGKK7Bxmdbkaux5NI1o15V+O6gyJMd/PFIJ+OjGD8qXbVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=b6gd/iymS4AHdx0UaiIJa4UOASEVBBeUtkd+FyDwalaMKm+/383mf4HAU1AM9S4uPKVDSBQk9qDg3CKuENZ/jvAanTAbWD4jpUHdrifCfxfTA0WnOL+9gHn1wOs03sJ+ORC+tpalIkXNVKF2pWuXi5GYNkQS/JYTu1brMZC4M+LA3BiZKwUrvvui4fQKg193sfs2meLDuH7wpsJHpG4FYl27CmIO/03JUzSUPRgXzwhV27PE1B77uMLKrJ2HqUZVmnjSrmkB6QnD+L45ZAfq0hTZheYJCFwXuTrmMfLYtnkRaeql2caWoAPoxHKFKqk/7uyUR8qi239HltWNFGmevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=kTxt1VhQ+db6VbtGc40ufrw0utoksElyUyHJQr7HQiKpc2XmUZXrdwCL1Sl78iM1OkrDkfsSaSXm5Knf4ZHmv+Z5sTWlksLeaEaN8ABD9tIaIqXqbnehBzEr7JAn/TiT9pqn2U0i89ATIGOggWCdHQHQsTIzUTptfE51dXU1MF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:13:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:13:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 11/13] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
Date:   Tue, 20 Jun 2023 16:12:19 -0400
Message-Id: <20230620201221.2580428-12-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620201221.2580428-1-Frank.Li@nxp.com>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f46712-0b54-44c9-99ac-08db71cac35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoiU76dCcJNPEYvMlMo8LwRxmaWgW9jQfLc+YbMOnZbh47/quN+kUAZ+cDcWf4Y5EzvdIG053Jbrk5LKk6Ix8XvrJiOsE0W0sLyBOCNG4cBbcdGOyTA9vjOiadWGuqUjDjZk3I6x8PfDbEdi4mFoOnm7nzeWqfuTIevfKKpyg1NSEkC1iAaOHitfz9GBvLQHQnIv916lF369uc2QO/cyqgSlcPM7VYTThDwae9Djjx4A+NwHY3RC4vOIr+h4dVbNcJukNT99jE0LjNO27FoXGG5Wz8uFdbn9GzvFFU9EI4yPPOxFEkCCgI6f9ZqpR1L2osR4jHaL01HziBGoiEuKZxyQNArTacRSIaXHwc2DyLHjtvkErukD5mY12RwupkHmbajWcuo4OEj0BhCX4p7ZSeQMS4OwM98JkzglvyqoJlsQvU9+U7zhJRbIB6LzQ/velNmtqYh9TyZpwz4+g8REQAUNlLcUotjm7xyd5jtrQrPC360xIQf2KBr7Wp7B5izg2riC8Dz+V0NlWOVfJiOJXM8L+ywLqt3W8SYvisrJr805xaEM/fAuOoLD2yh/ZFhwc8Cx1VeBxikeOgFBmkoNCHEuRDgvX+Sf+Sgibm0y6eKoBJ6NZnJYWJBT2Pl1nvK3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(966005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9obVFexMGZpmAr+rUoprcQYlInxqZYjFh7iQtdY7eQrPIiHZfCJkA9XTl+pH?=
 =?us-ascii?Q?LQaSxp0DvYBLIJPrQ+T2HPZkQjlqB7olp4FgzjGOOrYurmJrQnIs6avgg0WD?=
 =?us-ascii?Q?dfVmwmh372+li3f37dLKDmwCtv6QDql/gmwNcHGe6vbEvsTaOC0URaJndy3W?=
 =?us-ascii?Q?4qGvvkJzFHfY+tLM/iulXsksgRQcadVifb+nrakA/EqFIYJTI41D/4GLiRi1?=
 =?us-ascii?Q?0IeIuLfhdOTPvBV0GE3/wmq+VhZbu8z8QPTD29eHNOWWu+aov5UXyEC5DluK?=
 =?us-ascii?Q?NQwRwAjWV2jHQP7utaTsZb93mkTLWQiKLmJrLhqrUnBnGhJEyJ4DA+lzII/q?=
 =?us-ascii?Q?68FdRkt9CieoKsjCD1EQJLDXwR5xw/GYCF0lU5ENBybo/HiIWN6UQekecMzB?=
 =?us-ascii?Q?gmsTm1QqaGiSPdAGLG64z6wLN44bNFXq7/HMtflvlJxXhE9hDeDB2qPtFc9V?=
 =?us-ascii?Q?y0j+cH88qGnjZJ35wKP70u51931CJQcVbuOof6H38d5oGVFOi1+wP7ukNrvI?=
 =?us-ascii?Q?ABPR2FkJS74GeY1FMCUQv165TepTY2DXSSNpz0CUp68IKKOLblePK3Ydf877?=
 =?us-ascii?Q?QcQPOiKIjGgyCzrIREHISl6+JMYS1w17/PbkdX0ZrUE7QEkVzG7rGcZfuwD0?=
 =?us-ascii?Q?sd6AzrM7AVWmWaOxer8eaIphQ6OZxrCudmR4T7QcyyrihNIS9v+qvRGV3dFO?=
 =?us-ascii?Q?v1xJe5XQ0SMubMNxQ2B0GM7ljrmBVG5ixOBod+ee40bbntyU+GqvqUpSv8FP?=
 =?us-ascii?Q?kkmNa9wQON3Jf4W3ulgvMV9XGvuxTTaHNO3yi2ffso825+M1dp3A1t293dCX?=
 =?us-ascii?Q?oVgLm43SxRmM+L11gST2tAFCZ0FAnzvfYyU43MUPC1VargMD8d0WzttZNozl?=
 =?us-ascii?Q?uJvi9GVlH1daF7Z19438X7BRdDTUkQMOR/XisbdJnrWXPcXX/GwWlsKnPXdu?=
 =?us-ascii?Q?r7CJxx6ps6TxpfKcLjC36aeZhN4DrkDZzhzKEgi9wgeBSm6kBdYATfoTBbYX?=
 =?us-ascii?Q?VIKUFVPzlvrxVCBjE8MGVghNSxQuA5P4jVCxs10ZPuhHKp6sOk8YSEIb54Lx?=
 =?us-ascii?Q?Kl4z6BqEADRCkzp+yZvNgUyOMqHilleF0pdBgQyYWYQX6GtLLaFoddcQCXgO?=
 =?us-ascii?Q?rjcNVyUiGAxROsf5c6Ty+NiYVOtCllTyNFackt24IfcGyau60S48HG56ClEt?=
 =?us-ascii?Q?paDYFpOlmoCmYknI1pPQRr0UpZDMEmdlubLspAQEjf8sEK59LIKSj61Ufvq/?=
 =?us-ascii?Q?tKC2X9/D2isVivmoTEW5ywgX4IxsjTdnNo0Z+0dxLH/Yh52Y8ILLFeQrrjj0?=
 =?us-ascii?Q?P3hF2I7gJlSJEpSUWxYqrjXRQBcazT4xjtAve0D5jvejbx3nrUFexkAt2LjG?=
 =?us-ascii?Q?cyfUWcTZk2R/gBtLbzEow+dloTJdHKWpq/klqe+cymtSfeo4bX836vt4Aa+6?=
 =?us-ascii?Q?I8lB6P9as/jPS6Knvb45bdENyXe/DDMQ4SrWKyREDim2DFPhV0FiHi7IQeKf?=
 =?us-ascii?Q?FQ0uIP9J/ycBT+wX1mC31xV1ELnoKqgnLpVXFdar8wIaEkv5BiTK06CYlG8w?=
 =?us-ascii?Q?iVybvmuQ2SvgNNHtMI69Cv30qd1Vv/nQUuJtkxUR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f46712-0b54-44c9-99ac-08db71cac35d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:13:07.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrMDcRJIEGKsmIgEEiO5QDdSIH8ypc+4AqB8+nvCqiBcamhJ3qR5zp6gSn9/2FQJjVWHQYn7acWJm50wHzwI/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index e2fbfaf9155d..8ba705080f5d 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -310,9 +310,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
 
@@ -419,7 +421,7 @@ static int fsl_edma_resume_early(struct device *dev)
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

