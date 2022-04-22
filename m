Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9537550BA41
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 16:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448746AbiDVOkK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 10:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448738AbiDVOkJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 10:40:09 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20073.outbound.protection.outlook.com [40.107.2.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB485BD2C;
        Fri, 22 Apr 2022 07:37:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHqGu1EAokPNj8Nx0tSjGbv5l14BJqXbAco3z3sONQr0q2nXPaR599XjMT3Fk5qRyGghpmftT1cDzsvBXKG1kr3+C9gjGoZrlggzTR+tq7sbZNolpWPFtosGthsaTgIC7t+yhzFAb4Xj9Fgt+oeZ24SXE0xZQZubz9yAJTcxliZxzfcNvX4tLDOSCOCGObg/JkMIdMgAb5VnXG1ACR1nHqREEzEeCh/6MaacX10ET9GzRE0bIgUvtKN/pDnOO6KqVUGTP/uO7s0GehCmBQ498bPFCI1uZRQD1+RyYLUDuTgJAfHIGNJUzRn9B1rjJY+PFjKQeVakcIxMlEhg8OYTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k69QgamMlZuTFHgJ4SyEoyUfMhZC7RUGJdEkfH39M70=;
 b=iGSUPptl+QXnDcO9HmLYDOHqPxlLNPeeXrl2x1xqB8tibqw7U7pq6Xpu5LQxavzZysLVy3tIG7/pyotwgXlCMgv0Xe8+KzN+A29Pf9Bhwshrv8LFerDFWNeP2eTv8I5/IYdei1HKY4qsN6tSKbFmrKwyAzLey8g6HjHXhnGi5jYyMz4hdSM58SOzL8ogpTNNY3/gm58VSV+WgV5hZjPr/Dl6bseCBxm5cxMjdqp8QX9IhgyISiMozl2vPCgmkD1ovzzZegVz6sCuYxaVWKvR4U4MX4QBZtXgun9r5hX8js4dwnI98DoPd1wFHSXwaYYp5f6XkpT6nNE6yf3GwFajJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k69QgamMlZuTFHgJ4SyEoyUfMhZC7RUGJdEkfH39M70=;
 b=MsNMZ6C+Ac2GEN1tWwZ3mo/1sm+/wU495zl++nsXQwBh4vTwtbv/rnxqc9Q2AoajQlFKMrt3drDrCDqYTZKZi4Rv1C2+VCJR2IRyXIQhmVmBbAe0QjF2SM9tBOerHcf6+DSW65S6SgTibh045+p3jx3bwWIC3vAp//CG0IwX2QU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0401MB2644.eurprd04.prod.outlook.com (2603:10a6:203:38::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:37:13 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 14:37:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v9 4/9] dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct dw_edma_chip
Date:   Fri, 22 Apr 2022 09:36:38 -0500
Message-Id: <20220422143643.727871-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422143643.727871-1-Frank.Li@nxp.com>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c06aa293-c888-480b-f636-08da246d9709
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2644:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB264486D9894EDD5E9922ED4788F79@AM5PR0401MB2644.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIFrTHAJ7Ou0tJZNzbZRM4a2GqQwZiQA/MeH3VevRw+yIYUOruYYF6L0bv48/VCs5eVuaqFRm6ytO2VFZ4NrpWzJLubFpDLF/g7S9OU3TcjSZ0UM1/pnguv/M79H+GKItehTO6fmN+ERk7q3VqEnN3InUyIoFNfytfwENyplEcucSKWr9qTHfKRLGLiyfwelTBjsiY1wtnG5Ba+gjJKgxC7MCclG5ZjOdX0xUvTM+1SXrPfNDAk6nST0DDTfuLmFalmYTcF6DQ3wXOPXXCN8KYP2lWRDDYyqgvMCZo0yTqcW+PMoOUlRpPDbSymB5BnPbg1YhpHV6MwQQoAFJKc3oUWe8n1IYrIIwWVOdN8+5CbYnH0XkgFP6uCRbj/XhIl37pys09xL7A4yQt+ejmumdAibCk/7rX5k7GkdfhPnTz/ECv7GqKYvRfPBLMJkwEaZdyzNvbptwfn9IQrIqti/6Qsyw3wQmXieBGd69cYx6IepESS5gmQSNKU/74ocWOgQ13tBhM7/sxV10zU3uR7j5/mxrL3kIKtQIUSlmvCRtk7EnAsRtJDFFifqBqf5ZMR4p+ZqEAF3xdPLxAjz1WU+2uQCMwOA6K9alGWeo/v08la9kNak9UJPtZyeTPrUJHQBdU6GXJYZOWXL99pLF4Q62zjQnCc6Ae84RS6HqX8YO2x/UPEjcuJZ43E5/BRMwsXgvkr1ILWmKiIlzD68rBIkAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(316002)(4326008)(6666004)(66946007)(83380400001)(508600001)(5660300002)(6506007)(86362001)(38350700002)(6512007)(36756003)(52116002)(26005)(38100700002)(2616005)(6486002)(66556008)(7416002)(8676002)(66476007)(2906002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8WBHigxLGG8/Dd+oDV3KVpExnYyjXKhPxIMdjYFLZNiHIOSrv4geIySXtnBc?=
 =?us-ascii?Q?OsK7gupL5dfSq5HwBLTGZ8lxjdQR7AWL0jbxnAQgUHMLL2WTm09CQt/JDH2T?=
 =?us-ascii?Q?w1d4aJNriM2sMlDf0Zg0Ur/8iUv3IU32Qwj92rHjO7LYpovMxIOe7n8mVjdu?=
 =?us-ascii?Q?qXpFR8BwOGs5zPpsFk32f5hjEKVLXxEO2Ba7GY3q9lu5vDUn6QI60FE28hzd?=
 =?us-ascii?Q?0JxucR6rb9dDjiEvCrjwb6S3+7mr10fr/+GiilnGYbp4fd4t5UNZSzpIWnxQ?=
 =?us-ascii?Q?8dTJVVYcgawdCwTUigtTGwJhXGutIt+WmEjs/YDcGhksynu8/VJkjZ44WkFL?=
 =?us-ascii?Q?FYAfyBiNRwKCdVtV1y4c4yJqnldk1Zk1ah+8MOdkEU/FKr7HIpSPeM1z4fd1?=
 =?us-ascii?Q?RamjxE13oX82xnbSvvuCiSL8xhSouM/ROVvn3TZu79wy2i9IxRVI53y0pv5e?=
 =?us-ascii?Q?MC7DP2uXGHruWux0xTfEmdHbcMDkf9hjf6oDcQPziR5RcYKwprA835wm1Ymv?=
 =?us-ascii?Q?ZCGFtv52Y1p4MA1pBKUZDG3IvQMqezMtTqeCHdJZ92sDx9DA55NzfSy8XmsL?=
 =?us-ascii?Q?ebuei1akFjiJAPi3jdWzVXSmIiCm1OC9HueaL/a8D9HQ5maxU/0SlsLJYqCw?=
 =?us-ascii?Q?PtUSS8GmfzdMqmrct7f2uq/SbYp+QQMqvpBiVcF0uBOv0DEzO7wi57s22noE?=
 =?us-ascii?Q?MmfsGegY/EHMOIm46yY4K7tNMYej7Z/XooIgzxEijk2QeZsOTIJwvNhe98mW?=
 =?us-ascii?Q?fPcoz0zriX4OLDwfm7CXX55gPRjN/gus87vZJIy4Cw/WOolx+TbnQVmVHXsN?=
 =?us-ascii?Q?v++SiDaJq7vM+BVK1nfjf8m5wMaIjdiwSbdE0xog5mx2u2/al6Uic6ElMsqA?=
 =?us-ascii?Q?MbuhG5abSztZbov4lsGMZ/fxFTZ5m1aKeep45VoauWQdFXcpFSFtRvMBw6nt?=
 =?us-ascii?Q?GeA26+L/jvE/lsIyKxjt5J7t+W3HrP7BUzUU/X7kNyLEwbNsVClbN5bNrUB6?=
 =?us-ascii?Q?gQxWGcS8WuRDsRXhrrU6vVryU3+8M7h00GobqR7ln0OKK43nj1QbWyTfLoOn?=
 =?us-ascii?Q?YO822d6OI0j+AKtW0vKSGqk1HSH3hF7LaIJBsA8T20rjICzMDFHQRgJkx9ha?=
 =?us-ascii?Q?avBiZ+0V7ohhVWyW0gSl5ayb/NY5Hg4KlW3lKEQ1vOAJvhH74Tr4QKiLVhNF?=
 =?us-ascii?Q?fPB2+BjoDQqPEUdyn3R6b9szKarjR3wM7qk2ou5lfZgPgU7q3YQEBRmS3pa3?=
 =?us-ascii?Q?b4g70eesycpsJIUC/zDlaD82OymA7GBkU42eCvSjvunQtU5FfB2/99fkaXrx?=
 =?us-ascii?Q?YCCJj+/llCcfIg6odzb1PsCrUJ119K0oJn8gLxfvxFRU4XVpLFiQW4GFV0YL?=
 =?us-ascii?Q?eqm2aSBBm3NRnAlidjmgbgyggYJjN09uxCvRAE1P9WiK6+i2ChdcMW2Jb2wA?=
 =?us-ascii?Q?yPURoBnmt+n/9VbSHPhDcnPQEkIWGsMeK0qV7a1dNioG1tEy98hGOcZfRkxi?=
 =?us-ascii?Q?vadggHR0zji7bepOnnmn+uFQEW08iydoMwVBZlou2omiEQ6AIBeWa0RyJK37?=
 =?us-ascii?Q?DMaDXk/fi50xjVC+wA9ISF9l6MyiBadbENqWVk1IVBB9JOJIWVxh6vbcxk1r?=
 =?us-ascii?Q?+phdf4nqEsRJZo+n5C/E9X+nQ7FQPEWosM+QLMHFQkABcOIN4iTrIgY3sjaz?=
 =?us-ascii?Q?SCfo7A95MNBjehZABhc+szhfAmfhgnNGkVMHYK7oPi1SAHHIYqTF93V8T4BH?=
 =?us-ascii?Q?dUzMvL71ZA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06aa293-c888-480b-f636-08da246d9709
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:37:13.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBUYH39W3KmpiSiIA/zAG5CuIycCP3n+hDrJZG8392f8Azo7TMyDgPPn8r186Ib5c2J+m+cW7BFOt5Rssb9MrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Change from v6 to v9
 - none
Change from v5 to v6
 - s/rename/Rename/ at subject
new patch at v4

 drivers/dma/dw-edma/dw-edma-core.c |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
 include/linux/dma/edma.h           |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 435e4f2ab6575..1a0a98f6c5515 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -919,11 +919,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
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

