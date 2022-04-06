Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC4B4F679F
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiDFRZy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 13:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbiDFRZn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 13:25:43 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D72926367C;
        Wed,  6 Apr 2022 08:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGdxmZyxmQF5FJLX72Oy2j17ilS0sqoEQXOjQQTrnjI+TXoxba4wetCn7DGIIFizRLcc3lzmJ4pT9w/aiRH/X1gSqbfYd7IItRSj4w27Kj/78LLVByov4BX/i5Y1taKOEAfPX5kTeMJfsCgDaJjF5Goa2H/aNlo+hmZk1+T00lZRa9nZE85v5uGlbqoYkQRLC705oxhKmnBiLQMPsiSCzQq3pyRH/SgH++lvD/YAAO7o1qxpLoBXL1Csz1vRp7JvNNP3QE34qjFSGqyZuXXQyniMSaY23Oq9EaJRjPVj4etv74UhBlyTCe2pDxSZnUukEtGPQCF0ZvhjJEvlD8Piiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nCi4p4m7POLJTd2ebfAdGlzBYu3wFkr0iWssfe2aME=;
 b=VdoFKarloAD+tNJLXBvAYZmb9fJ1Wrz9X70WsRqYec4wAeVH1a3uTdAGObbTtPYXF7+9MqlhlFDkRh3eZPsyLtHD6OblxUI6rvHnzcx7auZfanPdt0hjLufW2SRnvR4Z2eBNcQu0gDPVRrOnQTfqqlR/15AZG2KlRD5PM+sm7Sy0N89I2UGdg9Q99GcEmWBoJFqLIOGnA8qwspm8Ud62pqtgeQKJ7/CjeJyILQn7yMjXhLvApcSeLtJy7b00rOzzJ+9VI4SXnGKg/YSFY/TmYe4gNGLWPb6aePCzgGsQDVZndX8fxPLpKNSMDniswUeVFbiLfFOSlDySJ9REfDGT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nCi4p4m7POLJTd2ebfAdGlzBYu3wFkr0iWssfe2aME=;
 b=eysTRaufgBZZ/WSwoxrO9DP7eau+odzCkAYoIxNnWXX08ot63q422FkrOX2ybiT5ab/2GGShkcF4AxQVDR5CcvxCBXbQm0xtqOnkIDkkuD3xLCI0nIQh6rFI+qVjZreKIAruYI2TwnfOGnWpzffZhmmMxlwDARDZD8qR6EYvwlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VE1PR04MB7343.eurprd04.prod.outlook.com (2603:10a6:800:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 15:24:36 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:24:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v6 4/9] dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct dw_edma_chip
Date:   Wed,  6 Apr 2022 10:23:42 -0500
Message-Id: <20220406152347.85908-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406152347.85908-1-Frank.Li@nxp.com>
References: <20220406152347.85908-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:a03:80::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7565c8cd-4463-414e-935f-08da17e18f05
X-MS-TrafficTypeDiagnostic: VE1PR04MB7343:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB7343196599B6FF8F8415C65588E79@VE1PR04MB7343.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rvSyKPImxIkilCrETYpIBDFBBkNhrxw0o5HwBJIKsvL6olJAAOloyQUupIm093Z6CcMiOFh4BrsppVYobxiP1m/lgZgT84TAGITtf6M2AcFjyPVrhGljERn1m3hT0GBWB7iq3tB/VzqbT9WNY5iUbr/6Kg/6Tg+xmkA2djzxyAasRxXVOLBevNjftzhMylXUgYpEpWD3kCtRXNi4IOE11l3l1kB9lQyBJ5eLP4Pbt86x10aIymnXSgqaeBmGmq+k130p4fRZtYoZTpuzW875P3ZlOwuKq53gLyhPz/QhUQPol1RlP7FqLKq+egOTxLotfy2MQNGzRWDXNYdTGBaqE5BNSEld0feYvtFQp86vIyk6Tndw9JEWErFwUe+43pqKUlxErpNKCN6Wp6r0CystJFzsaQ9MDjSqsuoEuumAVGvmQiDZyrdhDJlkZdIfqYLeaQyhK3nWA6XmbrQVxlWYzNmbVdnDPKjQsNeX6ZIUIovVUBqWL6XHlCWEHSIxpXHYMYeaRBsWTZPM92oFi4Gxbo+EPBCBux8qcbixKCODr4jEGVR/UTS4EUftuwrOtuH8J0D+WtAB/SrcAEO/vLX/dIOqN5pILUaNVoXKuA3otsym6S90fEMeIKj3VPXM8u3iyxvaL6XjrgdTT/n95+7etwD8VOaMJvwSqTO/RbSVNYIydhVH1WOHlbkS/6c0Rz4O0USQzLNle+OnWOBaXhu5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6512007)(7416002)(6666004)(36756003)(66476007)(66946007)(66556008)(8676002)(86362001)(83380400001)(4326008)(52116002)(8936002)(26005)(5660300002)(186003)(2906002)(316002)(38350700002)(2616005)(38100700002)(1076003)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0coxEEXZh1efmm+ODB21X5oaq2Wj720SwxxMOpqsUDvT0LsShOPBcGSEraDK?=
 =?us-ascii?Q?VPDTx7Yd/fxOCVuVuDCr2WWsX2EnY68DA9xX6Y93hDn7yZBaXVjgVxOzmA6S?=
 =?us-ascii?Q?gCCFjeTm7wK006RAoZFO/3vtj3yXwLq7A8kotPnGG7QtyAVsyNGjnBn/k1AA?=
 =?us-ascii?Q?EuFeSv8mO+lGADL0Fg8FKzsW6b38z5GPdkT08bzDkGGSwAhui2yUCN/B6qFi?=
 =?us-ascii?Q?XHiOpUSeI4/N9OG7ZVUJ8TIecUuGUnztmomqX1SwNl4KljNkv2LnS5+ACVLg?=
 =?us-ascii?Q?IdDFdsDxOCAXbNICPDWOs9LOzCyATcJJ/9xGMVc9EhjpmT022R0BVj6kHeHH?=
 =?us-ascii?Q?vMUkb8adZF9AQ739lfSgoafuZUmMEmsdmfu8HVKDzbTE3Kfr/elRL4+UhufT?=
 =?us-ascii?Q?MTHpZzdAMbQJTCwpL49/GSKyBM3X2Gk56wHsrRe1jiUcK1lf8d51EGn4NemM?=
 =?us-ascii?Q?0Cf2jiN3JrcV4s9TxLTnkaTDHSdgWxysAjMtbsICo08oLF2DG8E31ykyt8Tr?=
 =?us-ascii?Q?Xogq0NBVXTa9XNfpON0Dw6krSRVSqMDtJJHvRhqcLW2rhwhH1VuUSaYHRiZ0?=
 =?us-ascii?Q?Eh3hpQCquhFtnSznsY3N7Y5RuHzfqh0pWNmVVkzVFe3QRKugzvuVzwsXPg2Q?=
 =?us-ascii?Q?U/Po1vDJJ9pCgLzljwKKblXmjRIOyPT3bVMpgvurXYDKe+L8icHSF1m/BuMZ?=
 =?us-ascii?Q?79Qwj5jSlxlisqRVRMbCfXlvDBR5cyXd9WSMeYbRfPrMoqBo9oHORbtrPoR2?=
 =?us-ascii?Q?qR5eG1uk1AWzy25ssymGTpCIM0gKldGripF79pkBWYiQ7R1WhXz1I7aUsJa/?=
 =?us-ascii?Q?cO3AWzqEwwHcf7hgZUrLKcazL6p1nmJXxIWfZY/sGTAdMdgMLI9dROXpYdd7?=
 =?us-ascii?Q?129ysH1IYiPGBgb1FoYbx+ZtheAzRApY+dYqf+Ld50bMAT43MjfHveInBaNS?=
 =?us-ascii?Q?pQniiijHIbGUCm7zykIRtgu4kjOSyIG3qSJl/mVXle7oKcUlHwTLLcSGZcuJ?=
 =?us-ascii?Q?5n7HO0nrxjYfZ3qkLvVqWyxhOdncjxAiDgZJmr4vAFqmn+qF6pZEsBq4pBcy?=
 =?us-ascii?Q?B5x/xD5gAjjgmJrXc3mz//9TwU1ivw9jLw6qJpzMqjQBnsspOqk2Z9g17RPA?=
 =?us-ascii?Q?9fCGrFPkpPxcO9c9HTSivQ4LdKhcFPiVejxNXPU2VOJCgdjjQQ3047LfOr9z?=
 =?us-ascii?Q?kiivFan34teYVmfp4fPocgKbPXCdwLKvUnJos1JtASF8/PyXgh2+FHXpUqme?=
 =?us-ascii?Q?+KEgzsNmLfntMr1qqv+Pes44U8/GihTm3VdN3tSSm4LiRWB9ndKmSi4Zt11F?=
 =?us-ascii?Q?x1mEoZ598RiIxx+cMR3ptH73UPWY0YG4QHstcQMmya1azsRFF+PCNvFqtslT?=
 =?us-ascii?Q?REK/CLpyAB5QERcUsGdqkHDcJitlGsdJPDXhFBS00qig6tb0Y4xPy1Tm3nfc?=
 =?us-ascii?Q?blTjSplJGEMclILDyCoZONaAVG4QDO4NqZSQuln6bGgxFPM72UKVrxEtML9U?=
 =?us-ascii?Q?XoP72p1TyE5OB61zDm4fGNszpkFo+9i/MBLaULZUQLJwuyeWliMRur8aTwhv?=
 =?us-ascii?Q?MX9lfjCoticPshPOLaL7b5CDYPteqaeS/pVEtl7OT3n6crI4/YZq7CPnbMov?=
 =?us-ascii?Q?KwbPg3Abp3PP4pnqu4mZ0qZkjPLE71/WC+D9nMGC8FfCRv2//7GFWkxdN0bm?=
 =?us-ascii?Q?U9MCdiycaDkLOHnEaZ1kBBevm9BQisqWWminLGuAAjoOVZNjxtNlX23VWRrD?=
 =?us-ascii?Q?ll4YnpO6qA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7565c8cd-4463-414e-935f-08da17e18f05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:24:36.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3YM6y4WaAZrC71WL9YvK9BADek0ERM4qImxXYXjLKsLs86+/+eQ4NmWXEb3IifV30zmT5ocFGawytUhyhQoSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are same name wr(rd)_ch_cnt in struct dw_edma. EDMA driver get
write(read) channel number from register, then save these into dw_edma.
Old wr(rd)_ch_cnt in dw_edma_chip actuall means how many link list memory
are available in ll_region_wr(rd)[EDMA_MAX_WR_CH]. So rename it to
ll_wr(rd)_cnt to indicate actual usage.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v5 to v6
 - s/rename/Rename/ at subject
new patch at v4

 drivers/dma/dw-edma/dw-edma-core.c |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
 include/linux/dma/edma.h           |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 9e88797916268..cfd1cdaa4c1db 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -913,11 +913,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 	raw_spin_lock_init(&dw->lock);
 
-	dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
+	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
 			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
 	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
 
-	dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt,
+	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
 			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
 	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
 
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index ae42bad24dd5a..7732537f96086 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -230,14 +230,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_core_ops;
 
-	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
-	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
+	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
+	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
 
 	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->wr_ch_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
@@ -262,7 +262,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->rd_ch_cnt; i++) {
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
@@ -302,7 +302,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		chip->reg_base);
 
 
-	for (i = 0; i < chip->wr_ch_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_wr[i].bar,
 			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
@@ -314,7 +314,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
 	}
 
-	for (i = 0; i < chip->rd_ch_cnt; i++) {
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_rd[i].bar,
 			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index e9ce652b88233..c2039246fc08c 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -40,8 +40,8 @@ enum dw_edma_map_format {
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
  * @reg_base		 DMA register base address
- * @wr_ch_cnt		 DMA write channel number
- * @rd_ch_cnt		 DMA read channel number
+ * @ll_wr_cnt		 DMA write link list number
+ * @ll_rd_cnt		 DMA read link list number
  * @rg_region		 DMA register region
  * @ll_region_wr	 DMA descriptor link list memory for write channel
  * @ll_region_rd	 DMA descriptor link list memory for read channel
@@ -56,8 +56,8 @@ struct dw_edma_chip {
 
 	void __iomem		*reg_base;
 
-	u16			wr_ch_cnt;
-	u16			rd_ch_cnt;
+	u16			ll_wr_cnt;
+	u16			ll_rd_cnt;
 	/* link list address */
 	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
 	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
-- 
2.35.1

