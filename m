Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA2F52A5F2
	for <lists+dmaengine@lfdr.de>; Tue, 17 May 2022 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349839AbiEQPUG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 May 2022 11:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349884AbiEQPUB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 May 2022 11:20:01 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150072.outbound.protection.outlook.com [40.107.15.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549C74BFFB;
        Tue, 17 May 2022 08:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE+xoHnSqcBXOkJxs8GPcPZzxo56YIz2ZENNriQgczWLiOFg0MqgeWoC387Zk7z58cQefyIYmtDkOXglDqMv6MFLWANX4iemnEzfXTwdGE20inBg2HsTym5bq+JFHPOIYh5BV/sWg86craRHTWjb0n8FyjhGuXKnmpqRvYgWsE7N9M+F4uaDN62HAI7B7TI90GCPx2mM0jQNC/1XEG1bOd4kDFpxZEpM8hhEUmVuuYrULGax8gQlWYbKl3yMuMja3ABhM4QUAWN8+X2wEFUxPBSN+1xU6Of2XDtlqDBad5IaDEwKpM0Ea3bFX0FqxIhdWOXz+HjpF+rpq+4pIuMPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YxEu1DR2+kf49JzrRx+aDqnPOyVjwxZ9oBTDJzYZUU=;
 b=XaZAL5fn3GrJSsaKwt/AabBi3uJmLsioud/6FUFIlyT0DvTaKqvizs6zrLXWkGVtjrHkFtxJ/A1cwPVg7QLPaQP77U7pis3W6yu/PFO6h5wfsuMxVKF/c7xPVx7jRyjIW9lgtsWkThbMAqUezYQAAis0ICFCpoXaesXgpI4+TuNuQcy7xIeCAwhXnErCD0uUDNlzYoG6NJk8XGBcK/eG7XCxaWHjHMDZKlT9uRgNWAlJ17wbxJV+Y7zHw+0JdcszizIpOPDJYUpD3ekRgUDqlOnda1sYpXIvO/Vj/msKI/LGgaCn4/96uJRdQwbmFhX7FDJ7hThMtAx0BQ8CC4Qwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YxEu1DR2+kf49JzrRx+aDqnPOyVjwxZ9oBTDJzYZUU=;
 b=JgONn7TShE78up7eqIvln8xL9JgYyOymVo832XEapHWMEDPbx62hlJX1R97dl8OrJIVqgRw/mktBqD6cJK7QR3RnjY+rbl4OLasDOaKtQlXAXRTJhELsjmUq41QLGs/ViS2eEvX8BsuA5bJ6S/UlK1E31cNGesl1ZyIYlWRy5Ic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR0401MB2285.eurprd04.prod.outlook.com (2603:10a6:800:2a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:19:55 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 17 May 2022
 15:19:55 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v11 4/8] dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct dw_edma_chip
Date:   Tue, 17 May 2022 10:19:11 -0500
Message-Id: <20220517151915.2212838-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517151915.2212838-1-Frank.Li@nxp.com>
References: <20220517151915.2212838-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eeafa70-4870-4608-534f-08da3818b295
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2285:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2285C6842EB1A819015C2A2D88CE9@VI1PR0401MB2285.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4trQOMZsw//g6VLgE3N7sUxVmvrinP68YC2UnY0vaI1ckI+D1EJsGrVwgkvR9LC1mbtuIJrSIEwSl8ni1TItsXBD6K8AvhZnPBpOtb+gGXevw2zqIowHai3jpAlVc9y/HjoQSqb2T4IEGF7z/ON75DpLS3PL1SSqQvegfOyp4FPAbGE2AucuQK3MHu+3f8JALA9UelYrDLcHiGsntiwPr7bD5exrhz6pf8sIegGd56XpjvgF9mMvKWQ+3zQkf48JkgjC3WO7vZRwiuzXYH7nr2uOkuRyZrjM2YVc2LEyG0LkTyx2ejQaLExc4eRcg/QG/qdSUgnoLc0gbO+PDGxyEYPCsUU4WOjjw0EeFnvAg6rH3+k60vjoYxNjTsjYlge67HAeFyhkMHRqG+NTukFTmUC17tAJMiqu2NMPTdLGrfzDktAgWgn8cjka36nghyQIt2dWLvgNuIpIAQ354j254NXj7ENUsKACHonkFD2HzzMMTleyNiWDBAEvgOu2uoaSq1MwERU2cHEXwXX5hsmi/ibGn079r//tnV7eGumIC/yz9coLFueDsfRkmWWvVQPd6tg+oc8NaUFMMrKTujshWtxQjY4n7q43byARyth1DyPl4p69vHltSPQHoQDLvEkmy9uZyduMW/TDblct2KP+KzbCGSQzLNdsdIRw5FuKwv1+gC7AOJ0iprkYNQZkqyJPMwCH6xfdwVBPtzju21gDr7iteMUIRFBCEW2i3exafS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6666004)(52116002)(8676002)(6506007)(66556008)(86362001)(36756003)(6486002)(316002)(508600001)(38350700002)(38100700002)(2616005)(1076003)(186003)(921005)(83380400001)(8936002)(2906002)(6512007)(66476007)(26005)(5660300002)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mzGi9j3IPyFg9TihvDE4wy7RtUw92HiSvDJaQhQnJmdSpnJgUcPyur8H8oDr?=
 =?us-ascii?Q?hhOTAc2isFCe/zDp4iM/Fuy9MlNWX6nJTttZ0t3dKP52BtAs3qmQ61FDsSAV?=
 =?us-ascii?Q?FZbIoBAffFU0IYtzg3OOCC1QXkojpmMeePanx162zOgjJ3gZbwcjHuK7Z+a8?=
 =?us-ascii?Q?xNlnzsz27t0iT7wNg7/humjOm8p3sW0uY0NXIY6UmzfhkXODJq3Ga+7IsvG+?=
 =?us-ascii?Q?Tqg0I0T550heGdsuiwTqNU+6uWmeSkxx4sUX/sVOqEInbNyLXsAn+uCHxrvq?=
 =?us-ascii?Q?fMnr5BZYxFvitP154k9x/IX3l0DQo35WIrh76x3PYxDBYCgqr7MBAxMBDvnJ?=
 =?us-ascii?Q?7v926FVnl5Bopkdak68zBEtAskeyh5D5JRqK7UDdOQ62PCOSnEF2hMxnNPwd?=
 =?us-ascii?Q?bSfMU1uSLSK7CR36AZCBAZCf1nUAqc0M6ay2SJlIT+b5MJaxRV82wz8JLZ6d?=
 =?us-ascii?Q?vdKXk5cmEIBqnervFypotrwofZ0MI3wK+czEg/dhcWeJ1+LmbO1y9sLox8lp?=
 =?us-ascii?Q?27bk91H7uVfqrIa6iCUr3n6kjv/Un9NGtW/XICGxjc/V3nzaIBIpN8gZzIVc?=
 =?us-ascii?Q?8dfanCWbOWLcPpOUuyeTpcGBt2IBNj84B1uFfkLL22NTXiqNhNxkp+t6XWSU?=
 =?us-ascii?Q?hkBWmfdnbnh1LgE59hVI8MDC5RpouLJ/1bVT/QiiGr//xvjA6gRpkVRwLbNF?=
 =?us-ascii?Q?kPObbQVS4UeiLNiIm97gDylvYdmLSSKM4s/avDrgHMAlXFY0/ZvacyeqPF9t?=
 =?us-ascii?Q?6WhP6f+NhoxikeaF8/R5L6U5gmGhyXq08telg58mJsz6AhAvYRkdgWAPSYA8?=
 =?us-ascii?Q?69fo/sBdNv9wFPGmE93y777DA8CIZOE6QvB+Oj41MwzVLAL+MVNVe2Trt/ee?=
 =?us-ascii?Q?ZVDQqpfLxWliv4DF2rjiAlGxxY4r9wLK6jGz7qBPAFhAh6zSAhCTFnooGvTY?=
 =?us-ascii?Q?Ni3G61TkGjy3gfIXjFTKA1MS8ctMmt91n4iZq6t+FVsLBLNtxkKXkeL/4eeO?=
 =?us-ascii?Q?EosmNmF2YC8ZKQn3Pn/bR2otzC/ihqBh9Ka9Eto5GO0PcFS33t4n1z9TWT1V?=
 =?us-ascii?Q?2kWoe9r9t0lV6Va3fEUg6fWVeMmTnnPHSVsevjKQkOB46fKRPOovW1i/GXcu?=
 =?us-ascii?Q?dV8Ma1AX5+LbNrfm4cHNpOKrHJvXrcPcr1e+UPdgyIAG1QBRXnkzwQ9+RxcE?=
 =?us-ascii?Q?T080UOhy4+Hq72+Jsfr0qAZnuw1RcC5k36uDTXOPWCh1JWqy5ob+Zdhcr0Uk?=
 =?us-ascii?Q?I4bgf+9zrVWyaJckjlVFisFbXsFHgada/lqNPxzMcYKRDzUqrZGGkENES9jq?=
 =?us-ascii?Q?Ou2s0PAGS6f4uoU/rfyiUIKVaASg/FrlZwkKCeyAhxAuW6DyvPfR3s7ZHnCz?=
 =?us-ascii?Q?GNECHjNCdk7geJyD1L1bgA8EBeo7eh1M+ds9NBOgOuYm5yrX1XNAY7Bptgdy?=
 =?us-ascii?Q?UeelS5/UMDKZCLzi84d9j7UdotcqWyv/3LIxC7COIekf9Aq/qLqPonYrqchc?=
 =?us-ascii?Q?hOVGo2hgNIeaT2UxbnB2t3Q9fChqjbUQB+2XP4lNBNlHdJTDpdj5oMkuOTPO?=
 =?us-ascii?Q?yVJ9eIy10tnvmq3xDtHVzfSje33wkOe9BLnVQ6S3zcsLem8l6aemPGhhqySX?=
 =?us-ascii?Q?JwmqSkukmX4mBuWhL70Hnw6p3bfn8OEGIIIOiYkh79HgiA0ObL03//XA6m+b?=
 =?us-ascii?Q?CjKnoC0ugEszFTpZ9kws93ifQEDqETaZUblP4AVVg8BMIr7LY9nMHnc8JmFk?=
 =?us-ascii?Q?shk/b/VLAg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeafa70-4870-4608-534f-08da3818b295
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 15:19:55.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NgHV8KuNF7hgKpa6Fzg6bvotsUnjK8mxUi6X6zA+FggUF/+Z1nBLhu9+9ZOJbCAVrWO13Ultz9akbt9VULDRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2285
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
Change from v10 to v11
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

