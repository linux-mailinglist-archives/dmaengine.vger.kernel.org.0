Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E91532D5D
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiEXPXW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiEXPXD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 11:23:03 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B69C9E9DA;
        Tue, 24 May 2022 08:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QC261s8OOhqVe9G9bH+3KtJFENmNh8/XTcLn8hoUTzS615ydvzHUz9X4WQnVB+9T6yWGKTbbCe1rUd8tADU0ZaRdFLB4sm7pvsF8WGTbBBQ6qFp+pJMQ6ZQrghoAVQ0qjuZk5Q60rXto3bTlnp6FatfdZjyrat/dl3xwJqbM/V9VTXEiBJ+eE90WTTZi8IGfSJ3fyYlZmStqmdkpqwulDs+Vavi+uQM3lCgngOsgUAFUNguQmJ2l5mosyGvGKTkpY+3S5KUV0JmoxUvuTIH54UNyXKyj3j6FAe4/uoodDnfH0fKgyAcK2lAJwdrUBMyajhG8wL52RoCM0O+55jg4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fHfKStKCIND70Y7qYZIBayS2AiLFEuv7NF99z+l/vE=;
 b=U6bhzO3uVRpMxZHzho8yF/Y4PnU+92BJcIkYN4pfaNuTKiXTapJ1kDkJsWHXKr/RtXWGtoTxMkxj3rFuB+9IK5w5sOz2sZ+p5cXLLgiFWP6XAaTGshTbq2qXMrO5jCwD0ATQz14QyFOwlh4TwgI/jnrhixxpmnkqBZYKYIKDBmewbEsrYH2sl8P1PtmpDDfXstzbTamarpvoD7dqFNu34Xu8VHCR9I3o8j2vzBudH0yvv+jmE2QY5j1TIFAZ7UN/GJmSzUpkt6n7muDuJqE2LynHOg57yn9xe0De1sds3ljnDWIKT0iANTDiy4rluSoqEKbFaWjljpdEwMSnkLU9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fHfKStKCIND70Y7qYZIBayS2AiLFEuv7NF99z+l/vE=;
 b=gqzXxUsEVnILf4Xk2MGHtwCGew8iv59IvBCSkslHfgLObnqFAdq5yFz2Kl3egUqZh1DBa/2AyF+UZhQRFL/KrgXSTPCmoRtUhWGj57SnvlWDybh5G1o9rgE7RsaLtx8TesapDmeCYxZRnLR3zXzTirEUmE+9DykGIBecxBLlP0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB5672.eurprd04.prod.outlook.com (2603:10a6:20b:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 15:22:35 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 15:22:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v12 4/8] dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct dw_edma_chip
Date:   Tue, 24 May 2022 10:21:55 -0500
Message-Id: <20220524152159.2370739-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524152159.2370739-1-Frank.Li@nxp.com>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a98c565-a24d-4659-bf66-08da3d993adc
X-MS-TrafficTypeDiagnostic: AM6PR04MB5672:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5672BC922EEF7DB522554BA188D79@AM6PR04MB5672.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEfqEb9ExqC6UV4o5P/+o+A/TECSQ78J9ZkbC9ROrFualzh5mfPwC2PhRUukSrbhkZcLiHb9syb1a6XsoB5STyBO2J2mowodn4OSTJLLX3W/I1mQKK4465l+Hc4UuReRLLMnovuyxf1sLrQic50emfHQVlMMydkE/e+pDKPV7Hj4v4TuGgWGEFqYG054Ii/5Uq2XAKMycHz/nt0K0olIhfjn/sC16lLEYmMIx/LOEdSgpauK5GjZf7MMNeduKbHIvP/ycVeHBTCSMqce3oePggkd5Og4XtAbqFyMybHUoIQ0ZOwJW5q4ljqXNPlygE2czdXAT6MuH02i7LAZqSsY7GNAnxrK0fNDu+rMR3UHrfq+c+4Neh+Qo8mO7Zm23tJZ5qNgeZVBumF/QjB7/Yc1ZYLXPNCvrdiNXg6Hp/hIr5g1E/8XHZUk63i8gUbttxrEktzuGUF+SQo3BQEKeJIJA/eW1GkjriBn3ys8YEoahwX/gnIJ499M128SqjIjOylQklJE6v7RJnU3pISB1gzkOBzBKr1zllVU94kqQ1SjbgZvL850+98DXxm+O0fGRYm1jgZx/T32L5SDc2MVF1vmu26d8ydpK8RTX0iAW2+96QWrxgEsSoG+FbsZb9UtEbTOF0MY+Ops23dFEUEYIc423YIEm6m3uP3Mg1+KzspHLIVyoA8Yc2JYj8KCrFU3S1zmh8xmnGZ9gPJ3sOD3TN2zpZk7SLXR2otsbNpsFs6QtHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(8676002)(7416002)(316002)(38100700002)(38350700002)(6506007)(6486002)(66556008)(26005)(66946007)(508600001)(8936002)(2906002)(5660300002)(186003)(4326008)(6512007)(921005)(1076003)(83380400001)(52116002)(2616005)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kjr0oRM5a3U3BMtyPCtQHFDcJloaQu3vv4l47M35zreTm3fe7TElzcjwYfYU?=
 =?us-ascii?Q?8TRnE7m4q3HUicvekgbDawP4cQ9LRLigkmG030oFtuYN0myS0DnebuRAn3Aw?=
 =?us-ascii?Q?ovxCc0JpHNrICFKbb1MB5/a7tOQxjiELy8wvOuswA7wy1eMWz4yPwPXhxfgB?=
 =?us-ascii?Q?yIxFyFHUXEa3ecq2WsubUkrhdB4x2QwwbXfRF9M+e0bhaHeV+nIQAkiJdyBv?=
 =?us-ascii?Q?FjMiXji8sqaNmPXSb76Pj/v8KMflH8Yy1gtZr3QwvZrhElU4z/FFkSI+iM63?=
 =?us-ascii?Q?jH1Va76hha7ip6JYg14mHRQMixFQVLh5nU2PBDoMgK/MA+/3LC56HwPUTV1e?=
 =?us-ascii?Q?Irn34pAQl7iMISxgpvNgot+z36Eizw2PkINpLm/AGJ0qx0GlAJC7W7XUbGTh?=
 =?us-ascii?Q?mjMGYbMS9xkUwetoGNXvLW4y2VO22brKKD/YWmRWfgXwh5puOP6w3mdjWh7c?=
 =?us-ascii?Q?VS5nRGtUIOgWwW/WHmmGlPnbAieUtGLISIhYBmGlcGnN89/6+PHuo38RwWuU?=
 =?us-ascii?Q?ly5AvKFBMCr6ywnYPeBrx1j4ZCxJPgCPjTdSQLlE7BBOIZn9zXHTpqo4WnzB?=
 =?us-ascii?Q?rVaQ6e2LtVwDvlFlFK/RWoPohSW3M5bSyMpjrKaC1OvyHsk0MiyuiBwW9npT?=
 =?us-ascii?Q?VIC3eGv5e5VwrGf1jESE2pL2gb27ohLATTsd3yy9DxQVFm0QITLeE0vLKDIT?=
 =?us-ascii?Q?pXvXM2iinFB0EFlUeohRvQsJ9WCJA/tewMUCqc7SgySv39RLT7UlSJqxUrL7?=
 =?us-ascii?Q?nPGbAfL9kByJQOBe+AnS8PLsoP2zt/8/R+QfeEwKiFj8Cr0c7+L4EMkpaM3V?=
 =?us-ascii?Q?LtClXWpf2LnQ4QD8T896w4p8KWJ2KOc4pkcgSbEQ+eUxehctCFRwHlQiJL2Y?=
 =?us-ascii?Q?ntqqnUomKOo7PZHHIXVqXd05JLKeSlGlIDUt6+kZ0nr1Hs1nrPzt5jXvM7jc?=
 =?us-ascii?Q?3Z2PJbXbMNRozS3uY7Ccoc87jFZKm82CR9OWxQgIPTYIkizU5eiqoGpkB5A9?=
 =?us-ascii?Q?UAv7Iq/rWLpgE9kTOQDNXoIaSG5EUW7/Sq3kbiLHxrG40+F67X+zB4Q+J0ox?=
 =?us-ascii?Q?MVGo4PE9umoX8MmFQ2uBYSOB+/gvN4a66J6S8cvsehhMsQoX9W0XgRccv0Wz?=
 =?us-ascii?Q?7778G1iB4eo3aBsiHZEkf7j6VvId0toTkcy172zluE4w+j3aWLpScOX1dBTA?=
 =?us-ascii?Q?/VUT5/HOFbSobJyYUd5GvAsVNai70/91X1/ccs/hGXrmu3+iQYyMIOwu6eJ5?=
 =?us-ascii?Q?+mChJFrD+E5D2PqDVYzHYXCcpw+BQGrUxKO54VgDTh2QYcD80ejQD+5BBnUn?=
 =?us-ascii?Q?KNJNb18EYsF4ZtGDiuQTLpC9KZEA3jQPSFtNfWAcR54R89+arO7+gMWwKFBu?=
 =?us-ascii?Q?AYudIFEIT2TVUZC7j/YAZFaZJ8irV3neKsmG6E+P8/Wg9L3Em7BsZaja6LgK?=
 =?us-ascii?Q?5ak7NZL/zUfP1WZJus5mZmurPslXAJrEOLzGyu+EWtZu7mvXblEzhyHm/Fyd?=
 =?us-ascii?Q?9/xiWWln75DetjYNLSADHSXHxMpX0fXtyQWH3TttSD50MlHtybGsMqwgq52T?=
 =?us-ascii?Q?r3UL/YMU+jeyi64SqO5dQRSkU9QT7odseK2FAHvfpeWo1toK+/6KqKUTW7O2?=
 =?us-ascii?Q?TpTRGz9/6pW6ceGVvL/yn1PR/DmUdUoA0ZMsmrARSnHtho1IW8BoxadDJlGX?=
 =?us-ascii?Q?2r+tHLmJcox6gdRP32vIau2DxmI8tewqlm/8z7scmub2QJZ+hpTngIfFWP5p?=
 =?us-ascii?Q?hdP+Xpxg8w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a98c565-a24d-4659-bf66-08da3d993adc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:22:35.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krA4a3gFEHz4EnmoRtj2Dg2nfsotUBZB0+4iICTiU/Qvw4mLeF03pANshLGPCYyj0dPOWwNspIcLDcgM5gCS3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Change from v10 to v12
 - none
Change from v9 to v10
 - Change comment for ll_wr(rd)_cnt
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
index 58e91fe384282..1ef326f7151a3 100644
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
index 195ee1e47f21d..c8b479f1d4da7 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -40,8 +40,8 @@ enum dw_edma_map_format {
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
  * @reg_base		 DMA register base address
- * @wr_ch_cnt		 DMA write channel number
- * @rd_ch_cnt		 DMA read channel number
+ * @ll_wr_cnt		 DMA write link list count
+ * @ll_rd_cnt		 DMA read link list count
  * @rg_region		 DMA register region
  * @ll_region_wr	 DMA descriptor link list memory for write channel
  * @ll_region_rd	 DMA descriptor link list memory for read channel
@@ -58,8 +58,8 @@ struct dw_edma_chip {
 
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

