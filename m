Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9203C4D0B65
	for <lists+dmaengine@lfdr.de>; Mon,  7 Mar 2022 23:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbiCGWtP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Mar 2022 17:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiCGWtP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Mar 2022 17:49:15 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30049.outbound.protection.outlook.com [40.107.3.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36498427DA;
        Mon,  7 Mar 2022 14:48:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoB3HFnnIVy49Lee6AIBwXMnpPXVqbKyrs9hqsRWMEGFLKjigvBQjtDCWkG68tCwMLNC0uX1RUJNe4TJPt/+baljHfh8yt6iYCFpRwb3ZUP3xXh/jhiqKcr+lJGfLV3cqGRqj+2FAtTvmPLSgXefh/lu5BxRlbB+87xgQJHqrwAXKz1m5wdum17hkhKrq6jp5k0KniFwC4fQD+zGKoQGpYB0F9C2Bfmj1nLLA3vutTENe0LhvEzc/HegKrihdThuQGszLrF4VHqjtSV3IsmCaqxdaMbjCYHqjMcbTVLTtDy1QDwVmdbKuz1pMlMN9isKogjJFfBGgfFaY2dOrmCkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Na2Jn1mnd+uVQ/dr1ZxQQdm3fD6ZbASMttQxtoRvPJI=;
 b=RzqCMYkjvfTdSyaVTcAJLOeM6dn75qDu02zdrlAOPHHycesiieEo8i4WbSXmqRtYWU2o3llOoiQcge+4l/VGrDXATelqTtk4XYDsFVc/VESo1nJAuF6w2pDhN34XL2fcRu0eMP5zZZoIxb8wpz4+xP14uPkY7g4Fmk/IG5DAsxZ8DHCCdAkfCeXTQduefoNNsd8WhDseE4nVejkiSp3wiyo0PE86ZfpCayy/cGyqyPw6QpI4HRRNm73SbQkiBxNV8UNXHMQSAialgbYTdaGsv3L3LU3Gi2KeoHGeng/T9IEL+zuepVS4HjEwknzZVM2q3usSSPtvK3Ci7uv/pE+/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Na2Jn1mnd+uVQ/dr1ZxQQdm3fD6ZbASMttQxtoRvPJI=;
 b=brlk1T7UYpjoJG4U499rfvjE6QQT67guAwjtwx61D8VpPKkRbq9xQWJ8NtVSB/BqPdH2nFyoVDiVm9lWB0D7G7iXf4N9z2KZoS5tRZ3uydXOpQ965hm+vFQXj/IUVy9ZEx6Z10LtvCuxBiE4R0XY2zxOWiIcm3ewQObPLbzrPzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4946.eurprd04.prod.outlook.com (2603:10a6:208:c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 22:48:15 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 22:48:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v3 2/6] dmaengine: dw-edma-pcie: don't touch internal struct dw_edma
Date:   Mon,  7 Mar 2022 16:47:46 -0600
Message-Id: <20220307224750.18055-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220307224750.18055-1-Frank.Li@nxp.com>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fda10d0-f38c-4262-d720-08da008c9079
X-MS-TrafficTypeDiagnostic: AM0PR04MB4946:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB49463AB60761E2C8D88689D588089@AM0PR04MB4946.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tslT/+DgEQvAw/i9Lnni0ngrvC5Tj/89MLTLJBEjan6oK9ncAf4CY6Wdl/DhpB5wm42Pdw/SBxoxfv/n7D9lP+I5DU7v0EA4mP+M+PS3eXDYHD33kxQ9GDNDBagpMiVtEnHSNMWLn8p3FtehDi3kQDqGsib4I+w7TZiiNdGAUm3TVIUDttgqdh1Q9UhZldAPR40uQib4mn4zYYQdG8loHXdZvs7iYGJYSkAkRPXJG9X6TOkpidIejHo1kSahdFHWcxpsSgKqVBffESzV2lrY936EPgFclJsb4UeUMDZiCMWaWlOwpXRQaMDxl7/JOQ8R+oT3JllVmStvvl5fYtdbtx4tW6lkFUfLdZ9yun8yYTpBxxkoO42cPXD5Mrw0WYsbmyTxRuL3nBR4BkMFkjzszyE8J3L8XScSsWySPetAXjOtAuEr3m3+IWadUUOh9hLMGqv0OZlP3BpdtAapNYumBpm0RXow8OB0tXGn5E2//zVNOce/cc/SPeWfwCPQTkLSNMrHueLAah5UUmlLLDcxd4ygXKPNGu10dTxKAs0DwxU+Ay7ZMXGeCLzqV3vs38wOpiQSJ74bYmp4eV4zFDjCn70yg9kb+zZrcszNwrZg2nFlSg5ecDSAqhZ5+rjlZV4RIyERhaIWJjed1axGnE2hyXtGPUZhmZ3kxQWT/5cFFXi4wjqzu9DUB82glustkaBRMJei6DDdc9alAU4kP8ULIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(86362001)(8676002)(508600001)(7416002)(66476007)(66946007)(66556008)(4326008)(6512007)(8936002)(6486002)(6666004)(6506007)(52116002)(83380400001)(38350700002)(1076003)(186003)(26005)(36756003)(316002)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WSGkPGDG3zekNQQNocsYSsvk/VPeZI7To9Ft6rwLlTd2xvf9/RW3XmJ+3vnd?=
 =?us-ascii?Q?fojnnQaMqheDxa2xweiWIxDGbqhNvUVpqB425BsiuQAhWjJXajaw6PfFLhpg?=
 =?us-ascii?Q?b/eDclC1lMmqTiCfNbOn60FCKL8kkZI5AkI3R1/FFOcNvAgZbIUWDcaRbCtD?=
 =?us-ascii?Q?2Rxc3yceHpuE0suru7fBJbjTB+k/WbLNvo3OhNmwwmqYaxvtu6ZynLEKU4ty?=
 =?us-ascii?Q?tTUCQ+muwimcZOOstSB8FzmiXZZ7xWiJqYVjIArKpy//AdDmU5yhK6CV7H6q?=
 =?us-ascii?Q?IyYXzcKBu1QNof/t0jbnmyuhBDcArRzxji5yVn7lAgwd2l7rOECnVEQAWjS6?=
 =?us-ascii?Q?wW9a91vjhVCB+eR9tZMuLaF9acVY3Pw8aZIUGkhES1GGg/n4OzTxa7dGneyU?=
 =?us-ascii?Q?ytd4rjSWQoqvmExfbvrjv3Dc9MG+09e+mWcAJPTglIBpPOVV7ORIyTB4QRbl?=
 =?us-ascii?Q?ZMFCU8gnAFJ0Udes1020fd1D2Ktz4a1GQPdvQZfT+jm+LafGrAofR4djNvDu?=
 =?us-ascii?Q?ECURXzHTBmgqD+R/HOyfVTIl2cwyJXBNc7iNq8KZ3k/nMQy4RslHVmTAazMg?=
 =?us-ascii?Q?3yY6C9K7uH5lbwzcaM9/UpdhkPc/DNwUb/N7RFNk/XGpdIfqRiDUNQdpqcCj?=
 =?us-ascii?Q?K0+g9LOUcYMF9E3A/qspMyoSYdN8RTaSEcXq5Py1Je4AOtMywDmnKRhQRnl7?=
 =?us-ascii?Q?t3tx9kOoVF/SG8v+TiwZH/ZMWzm2pwx9OGEPHVk6sImyobo1ze5++GmkXEQG?=
 =?us-ascii?Q?aSpBYw4ZNwcWRwJj4s8GWIoYCuBDd6uEC0X8UdiG1F+ZC6fCckmEsk0cmAa+?=
 =?us-ascii?Q?yYbPu+VIY+ABC2oEuRk53KU/dzVajY0scb+r37vNq1oV7NVr6PrLo/v/8Mwr?=
 =?us-ascii?Q?uofopxAajEQuidflMsRq/HwArlqTFJ86Gw3ZTkxsIGV/2aK5dBdjKthPh3Yc?=
 =?us-ascii?Q?/KZfC4tSR9nwBtRfSHx7KddT6if4d1xBsywdxYT3iiAKf6rbQjGPR+UM0cUh?=
 =?us-ascii?Q?MHjvuS16Q2XF0Q5Be6BEJG0jx/Whwafg6wFmoyLLqklxiKclSI7myfV2VBMA?=
 =?us-ascii?Q?f2NNl/ThETw9TFU3hP+1vSxzbKg5t9akVZ+mLuReAlFGUgfKyufdRxnNcBxj?=
 =?us-ascii?Q?76cuR/zxapmni4MkFgc7YF9jME+y34p3aMEJIClHIBDsJm/cgQomxwl9fQwQ?=
 =?us-ascii?Q?QfxjEVlRVUL8uK1UgZdw7Ls8Sm5FQz75ifscA1mR4jTica+1lHVt8o7gSEBA?=
 =?us-ascii?Q?aM+qJVc6xARq2Bcisz7dsXOCNwccJhemx+//CydS25DFHDsP2s2GvODlwtQK?=
 =?us-ascii?Q?uiiUAKVu7lfZXwFGbiXIzgxhxvH2rIhopnq1kTbKtsbGSpKGLDWOVnN8Zr+P?=
 =?us-ascii?Q?xmHLW7NjcowG43KwX3lVZ2q7l+HW7r93fBtY6/DW4IpHzLzGHlzjnjpW/Yi0?=
 =?us-ascii?Q?/AvKdFVu/tHjdm/t/h5F8CgILTdSKvKuH8Rlbe9nTm7XL11tm8dJtiIZgyBd?=
 =?us-ascii?Q?JEYRdG7ubR8UlLqO5TKJsodJcXGqRsbnal65Q6mh+LMy/v65Kud7uT2u3teg?=
 =?us-ascii?Q?FI+sz2fU/PDp0ocFrqzBd7OFYb5009Hbey2euB/U0YDgdyDziOzBNpSbt7+u?=
 =?us-ascii?Q?N1hOwunlOn0IIU0M9jWRfdg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fda10d0-f38c-4262-d720-08da008c9079
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 22:48:14.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OevbTJxXdo99utnPYKH/MPQjTaDObJn1IN8+HSiYlFPuqT809sR6K2gPqK78IAK0ZRCuKDgji2GVwbspXct0+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

"struct dw_edma" is an internal structure of the eDMA core. This should not be
used by the eDMA controllers like "dw-edma-pcie" for passing the controller
specific information to the core.

Instead, use the fields local to the "struct dw_edma_chip" for passing the
controller specific info to the core.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Resend added dmaengine@vger.kernel.org

Change from v2 to v3:
 None

Change from v1 to v2:
 - rework commit message
 - rg_region only use virtual address. using chip->reg_base instead

 drivers/dma/dw-edma/dw-edma-pcie.c | 83 ++++++++++++------------------
 1 file changed, 34 insertions(+), 49 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 44f6e09bdb531..7732537f96086 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -148,7 +148,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_pcie_data vsec_data;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
-	struct dw_edma *dw;
 	int err, nr_irqs;
 	int i, mask;
 
@@ -214,10 +213,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip)
 		return -ENOMEM;
 
-	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
-	if (!dw)
-		return -ENOMEM;
-
 	/* IRQs allocation */
 	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data.irqs,
 					PCI_IRQ_MSI | PCI_IRQ_MSIX);
@@ -228,29 +223,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Data structure initialization */
-	chip->dw = dw;
 	chip->dev = dev;
 	chip->id = pdev->devfn;
-	chip->irq = pdev->irq;
 
-	dw->mf = vsec_data.mf;
-	dw->nr_irqs = nr_irqs;
-	dw->ops = &dw_edma_pcie_core_ops;
-	dw->wr_ch_cnt = vsec_data.wr_ch_cnt;
-	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
+	chip->mf = vsec_data.mf;
+	chip->nr_irqs = nr_irqs;
+	chip->ops = &dw_edma_pcie_core_ops;
 
-	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
-	if (!dw->rg_region.vaddr)
-		return -ENOMEM;
+	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
+	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
 
-	dw->rg_region.vaddr += vsec_data.rg.off;
-	dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
-	dw->rg_region.paddr += vsec_data.rg.off;
-	dw->rg_region.sz = vsec_data.rg.sz;
+	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
+	if (!chip->reg_base)
+		return -ENOMEM;
 
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
+	for (i = 0; i < chip->ll_wr_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
 
@@ -273,9 +262,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < dw->rd_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
 
@@ -299,45 +288,45 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Debug info */
-	if (dw->mf == EDMA_MF_EDMA_LEGACY)
-		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", dw->mf);
-	else if (dw->mf == EDMA_MF_EDMA_UNROLL)
-		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", dw->mf);
-	else if (dw->mf == EDMA_MF_HDMA_COMPAT)
-		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", dw->mf);
+	if (chip->mf == EDMA_MF_EDMA_LEGACY)
+		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", chip->mf);
+	else if (chip->mf == EDMA_MF_EDMA_UNROLL)
+		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
+	else if (chip->mf == EDMA_MF_HDMA_COMPAT)
+		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
 	else
-		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", dw->mf);
+		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
 
-	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
 		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
-		dw->rg_region.vaddr, &dw->rg_region.paddr);
+		chip->reg_base);
 
 
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_wr[i].bar,
-			vsec_data.ll_wr[i].off, dw->ll_region_wr[i].sz,
-			dw->ll_region_wr[i].vaddr, &dw->ll_region_wr[i].paddr);
+			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
+			chip->ll_region_wr[i].vaddr, &chip->ll_region_wr[i].paddr);
 
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.dt_wr[i].bar,
-			vsec_data.dt_wr[i].off, dw->dt_region_wr[i].sz,
-			dw->dt_region_wr[i].vaddr, &dw->dt_region_wr[i].paddr);
+			vsec_data.dt_wr[i].off, chip->dt_region_wr[i].sz,
+			chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
 	}
 
-	for (i = 0; i < dw->rd_ch_cnt; i++) {
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_rd[i].bar,
-			vsec_data.ll_rd[i].off, dw->ll_region_rd[i].sz,
-			dw->ll_region_rd[i].vaddr, &dw->ll_region_rd[i].paddr);
+			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
+			chip->ll_region_rd[i].vaddr, &chip->ll_region_rd[i].paddr);
 
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.dt_rd[i].bar,
-			vsec_data.dt_rd[i].off, dw->dt_region_rd[i].sz,
-			dw->dt_region_rd[i].vaddr, &dw->dt_region_rd[i].paddr);
+			vsec_data.dt_rd[i].off, chip->dt_region_rd[i].sz,
+			chip->dt_region_rd[i].vaddr, &chip->dt_region_rd[i].paddr);
 	}
 
-	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
+	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
 
 	/* Validating if PCI interrupts were enabled */
 	if (!pci_dev_msi_enabled(pdev)) {
@@ -345,10 +334,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return -EPERM;
 	}
 
-	dw->irq = devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
-	if (!dw->irq)
-		return -ENOMEM;
-
 	/* Starting eDMA driver */
 	err = dw_edma_probe(chip);
 	if (err) {
-- 
2.24.0.rc1

