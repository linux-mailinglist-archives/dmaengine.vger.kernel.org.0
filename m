Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CAA73478F
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjFRSLe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjFRSLd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:11:33 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95179E78;
        Sun, 18 Jun 2023 11:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd62V9JhQyTrPkOIIJmYo7n4/cfbyA0fZzQE5OvobgE9EPWgtOVqrtmUl7HVAQN9Dxgm5gZw1/rL0E5MZgSSLRiQsamOw+q8LSEX78WtfZaMWeptGlQQrPlH6xQDk+uYMbdm2qseSPPCpzcIBVm9nnl9AAa8+Xh5SJIw8OuXfGYp7oXsGuM++ynpbzFTJGuznHLPNmI2EhakIGtV8pQdg4n7vyAyRjORqzCUzBpaMUKhTbdI0nEoBwm2UsGBNq6aCIN56n+5UncOZrj11rt1EDhrHgQyrdSldHvknlCnAjf4bX/LErgQDu/fBxRJ37blJ2Uqf8UEaCnB4gzAzDBI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=dV7R0tRu3LHS0WHVMLWiu869SApCvbrn1UA1dVkZJ6Am79QT2/lDVBOldyfKqdCFx/tXQCiK75PHkIomPm2nH+u8ZFjlReI2Jg9gELAx829M2u7Q83Es904mvlXirodXMWIEeCDmM79g2ko0ujLRwHWp3a2VWJ+u8U8pC9CdV3KNL3TA8gkQGn21OvDEIyMb/pNB7yx9VO8mK6ItRC4f4t6ebBFENwklAzFOt8KfOMSQALYZcgP19TYHFMT4tNDyf7AEjkcBS9BaesZ8kw0yo/jakot9WLsl/wzSC8w8trwkWLdwb5CY+Xffini4U+A/QStEXAYeaW0g0iXpBvpBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=Wv318naIoLS4vp9odYatz5HgTF3NUNElhVgH91PT3xxJQblcUHhAl/tyxy7PD7CMZWb0p67uOAtUUCORWH072TZOq1MDkC8iAA6rPxGKJNRVe85Iv8BZv3bDopIRJkCsdpQpWHy2unJkCDERekVwrhcJsq3+AExsViwOKopc5kU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:10:16 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:10:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
Date:   Sun, 18 Jun 2023 14:09:23 -0400
Message-Id: <20230618180925.2350169-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618180925.2350169-1-Frank.Li@nxp.com>
References: <20230618180925.2350169-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f8e515-d595-42ac-8aaa-08db70274502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1YLcoNcoXKDafYgOnCE/NYPvxn3as4OqabfIfT5UHWCTJesI8V3SEwUpEQgPuOqXfKzLUtwKNU47b0FWPHQo4G5dnNCJDaz8dSTb5yV9PZ5/jFZVNmc/5Li7vkHOShG3S+bBIe9oru6PSWuuxina/VVPJqLI+1nxX+jiyekoqo/VQg9SyJ4ZY1TNi18iaB/Tuc+pBr/1ZM5O+wSdO1A/Hrerd5ZSl4je7+zOJjSweeTzjueWC5YCA+KeGrM/+0Xf66Qsj83j3VgzT/jfcnpSfFGOmyoIWCiXis9yhn4Uw+/nM6NzVWcM4pSB/h3N6PoPeSD/Y4kwpVT5eMHjYruzL1vMMTnn6A1+cPeEPzPml3XGtSc6m4uPc4sFBI2fUUUQME1fR4mCysTFlklB8mxp5/D5p7Hwjkaftgs+G6FE91R4tVsLYwId9u9V63EniaDd9zbP7LCeMAx4eWCKczvbNtutGa71Ue4ugN/03Dfuwu2LhpWjxUKGb1SphJcjoptouKMUzGhxRLYjHtZ26jC+8tfWhdYQT05o/iN4y1zsqmzxookVM/G4/K//E5Ir40YSaI3p9wV7qDS5u/DVBjwLiJ1AoEBfJAFEra0ykIbpR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(966005)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(6666004)(52116002)(38100700002)(38350700002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QCdgCmxe1kQRoFt5iecJgKbPBtz9WsybCYqP+E+p5zO+2Ps3+broHXJPH5KF?=
 =?us-ascii?Q?SofUAvjYcU4goD2x8249QCIYnIC46H1cvdjVKZef5WQlCkBPrJDufJHE7G16?=
 =?us-ascii?Q?8x+56SFyyGbON9HgZ5UdrCyiAqdXhQ+j9bc1JYpGckJJ8vFM1ypS+sVJc0tX?=
 =?us-ascii?Q?iW+AL2wbuDudE1jnNQSTtaVI2BD1mmaxGfWawsGjSb2z1/Q/r1D877fDC6bN?=
 =?us-ascii?Q?wKgNLjU9ncQzcIdHqb/DkMAKN7Zfums4sPloNCNarYI1rv+PVmGEXrbv3oXt?=
 =?us-ascii?Q?93I+uDKHEha2oJKrezSqEktI1DHpXhhZZtAUOp2M3OuXyGEZXb86rvY+fwxy?=
 =?us-ascii?Q?Dfab7GKF8pY5f6XYDnOaRgjLSp78nqGBUKc1cut2cJQFClO0isW2aEVmWdH1?=
 =?us-ascii?Q?QUXODgtxfHeGS7z2xDjcrBAvu5tCAbs1h5ejZfyI7+u8bO29FpMXYFOkdvLK?=
 =?us-ascii?Q?x20MKW21Eho1eA/vwo7wq+UXH+n9QHhUISINJkFQ1iwhvsvyh/PzyZ6VyhWC?=
 =?us-ascii?Q?zE4Bs2hEMxnpKrAAhTIgIraThEXEC6+uDouRwzZ22gePsoQXdAdm9F4Vw7Kb?=
 =?us-ascii?Q?FdAl3bKwZKsfbL8/WSLKftHnbRrTZqziUVaG8kMzuExAg1xsEbt2IYE5TPI1?=
 =?us-ascii?Q?GJKML5ORd2sSPDq154/6jvqZPN4Gp8yqE2SYbTvNMIgFTVQ6wg7ASWvQU0kN?=
 =?us-ascii?Q?Uln37upBd9lF/a07MpfuS55/vUC+ktsu6/7fOnW7q3oH71EXa5SGKM6bjrEA?=
 =?us-ascii?Q?7iYtIBUJYs8MaIFe5CAB/dDg0m7+Bn5RE+uOE3z7ZwLgLZQnQNaTfxw/Glw9?=
 =?us-ascii?Q?6Do88z3AA0ff+BsB9j+cNOJjw+k6jHZAeF8pFiXNPDVt616K1wRSFob+n6Ow?=
 =?us-ascii?Q?95B2GPzhbZQwlgTofnqQLuj/x3fOFfTt06LcVb/Mu8YpU+fRdfD6yg6mY4E6?=
 =?us-ascii?Q?vpVpWQ+yhHaKjxzsA5awrWHxogXd+hHr0V0eAJMLIwh+mDplZIQ99Fkk+yKY?=
 =?us-ascii?Q?R0fhdtBfdHZ1uGgBTFBJw2fz005JGudGOf8Volfu5uu2o5Pme25nl0neszg0?=
 =?us-ascii?Q?+3QJcQobFrVO5Qtgl/HtW90v56FAht0JcciCBdn8oGvTfrdXOeoTfzFxDG4P?=
 =?us-ascii?Q?2gfFYribIHiedQ7fzRqixkzeUx0Kwv6aG4CMYOKWQyoyOHnqejDwFudwTezH?=
 =?us-ascii?Q?1RHdO9cOWz+wtIv43U/VkGGDn2INy6zTAj53EsahbaVpS3IN8N5YfXVtUqHH?=
 =?us-ascii?Q?NpVybKyQ6zgS4YDVN3+g26l7ysS9j69eyW1bJ10gdDrnZr5J3O7aaK5fZm1T?=
 =?us-ascii?Q?d7lWuZBXnQrIxy7rLam3HWkNcJthH38T5ZKi6/EAeEN2dqbdrW2qv6vIzvCX?=
 =?us-ascii?Q?BQs57Q+5EtTNFuyKzgmYi3F/bA5LBphpq5Qbi920K3e9GTtRp27erTSkLzMf?=
 =?us-ascii?Q?QvNPAop891X8ZzLSM57BgC/f26H5rEbzXDwSFFVBNndM88i7M6cGMeqYxq/o?=
 =?us-ascii?Q?lMP23JQyTdgj/QzLjesF4b2OepJ3w3dOChvzXH39pBqLXbTii26WdYe9e1hv?=
 =?us-ascii?Q?/u+c99+HYMMIx0HihcG++5HCBw/7qlWYUYV4jXLM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f8e515-d595-42ac-8aaa-08db70274502
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:10:16.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRHo9XqiiGJukuuhtxlkUQ0yR/Xia+x+QgmKUTGQQRYvvv/yFC4VSivEa71Rb+kEndqH2MPkIGt5rZHaL2UKEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
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

