Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21068501F41
	for <lists+dmaengine@lfdr.de>; Fri, 15 Apr 2022 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347716AbiDNXkQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 19:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiDNXkP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 19:40:15 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140083.outbound.protection.outlook.com [40.107.14.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC27BBB922;
        Thu, 14 Apr 2022 16:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFXHgP+dsGRUbwTJn7Hn9NZAYW873mI/Fx5x0e9lxDZVv5pufMNab+AW1JfMkbUY8lwcb+ONJvkjPzr6hRnqOIqiM7OV64t4A7JhyHi+V1Ye6TzrWDshy5hDepEgNrCzPI2SahAkkGAagGrseP82QxCqYZCxRNgRQQOh98hIagPiiFbkCwu6IB0EskA5OE1ccpO+e+MeFx5msitgB9NjbAjN39+59+M9i8hGdZi/ij6Cpzl9Ar9M8XOEQnxux8d4/ISnXIDAmhkAT5bosaRnnJitYVRnpZdSbPGfCHM/+G8YpZEWnkKkiCxoSjvs1uaacPQOQ5xAF355P8ok6nOjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXnmQD9ma5SPGGUPjZjl3AR5tt/f8itLUAyMgo+Wy2I=;
 b=f8X6NW84Q+M2J4BS3j8nn4nykMM3TGcvlU/aXLKa+JMB1/hA2/7uD8fjcHsPCDus/YnSEckQNFhKKpu2P51+A3s9AFMyVirDKQDUPaVNuGgmF6xK5nSf03uBgd3PCKZOU2Fnm1Teioc0VO5JlKZMTVZ/CZjZtU6TbkRhKBJjBr4aaImfeGrA3RgysSXWpd1JTPmWjIHaIK7Q5Cdsm+TAiazSNEBYT5mXYmVEh7d3PEomPgt2cPrGUObSnAYnOkwpfCaO7CeUDf1Vn9RCUNfeJltO80p3v27wWSNPwSvb/LVgfN8OHpqufivKalyHK1OPUqqRXrTkNxbHdory+P7mJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXnmQD9ma5SPGGUPjZjl3AR5tt/f8itLUAyMgo+Wy2I=;
 b=NhsDhlRErCrqxPE8V4pPG3sDd3x5ZieTlFxGonXQD0UwCaDkbVLoD1oVc4ZMUd7rx+zHkxgS0QWQQKneHNOtqsZHtGE/lYlDo/rTHJTsFOoA5MwrZm3CdTpdd3jSyUMDApRgtft3BPsSurDMsNDQAK0m0cfErxi5nAt7APNoP/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:37:46 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 23:37:46 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v7 4/9] dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct dw_edma_chip
Date:   Thu, 14 Apr 2022 18:37:04 -0500
Message-Id: <20220414233709.412275-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414233709.412275-1-Frank.Li@nxp.com>
References: <20220414233709.412275-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::22) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b2fcb70-17bd-406e-4844-08da1e6fc72e
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB6043CC8A9E0AC338D2C979A288EF9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLv4H3+6WeKbSvuZkUNlIr1xB4OKIK5sNTY9iEMkpPoFpCna2uyKrX778RGqgZGVdgesqoEUXW1H1uk6q/17R6hxLHzdoKl1vs4I8cz/5XCdVjsf4R0WAvRuxSOT5cdvYrbkv7EoXRdWOSILBReq58PHuEQsSHiwoFpcuuOcZoSdM+XDn6THaorsd3b2hbjAkzHR+597QztO/AF/a+WeVeBa8854kcY8yu/4UZ0jwZr7FFICU9qK5nCLvrSyNnfESpuroMsRrdmjBpF0Q+mLRSAEoEi1t2pBWPYYul0qL3kHu8kSFF+9Md2t2O+BQU4/6pfCm3NGNxR5V5oT2eb1HJkyncqwWdm1AonOVuIXehzgcmjslPBRVu3vDzxAZXStsdRNw1199ljvFMnasM3cRCAWWsU4rXUi2JfEVfr2lstwavbgZA35bPn2Z2eIIAZBxaXT0g4pid9dwu4dyhXMkiugsXNCEs1sdEvOxq13TuCyoJItsL2DMUiT0Wdlh+s+MKfgxFrv6pjW3XV2LCDu4OC/EQ1n+W8Yna7t/UlexBHnPh/Gv7XdeDDAH8LHqxshukPS4x5Jsz4DKyPxpIump3tzVxnoMkKd+iCV4zWzcx4xlc7OmYXePFI1m4zMo+bAnR1rbEL0fJQUFRcBoMocTXU8SsIAt/erIsuNnmJ58W8tQcGtE9gGKs4O7EPySBODTK4xt7JFm7nRQZh+MAF6xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(8936002)(38350700002)(83380400001)(36756003)(38100700002)(508600001)(6486002)(2906002)(6512007)(6666004)(4326008)(8676002)(186003)(316002)(86362001)(7416002)(1076003)(52116002)(66556008)(26005)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/EPP2VFhfTbUNWkrsXMD/jpkGAlbCXhhF3LG7ZCTZUUEa0ti4ziLF/GuvTZH?=
 =?us-ascii?Q?+/YMwI6Vf5j+U3zDCCbSs3voPd7ElYdE57tvDDy4TxyMQKRqZMxzazzI4Ng4?=
 =?us-ascii?Q?yCAQE9QgqMIPtI45wLYbpZ0G4CqNOWRKKUdD7LnZn1kaQCXLxJ0o4YDjQf6d?=
 =?us-ascii?Q?j9Vyw2yr5jKTA9b3pDGCGGl0sz4pnRBrL7RAjEBjgIZD/GZelpVXX53Si1XO?=
 =?us-ascii?Q?WoycXZXfOe8BeT3I8/igwQqMW6raG6rDdrKGqjCtEegH87HgnzvraUeBmp6s?=
 =?us-ascii?Q?ihFE2hWj93gW4lwqncDz3R4xfprji0FfLchwP6kFNi/c3sAdzlNBgDqjsaPb?=
 =?us-ascii?Q?HONMw7ZSRqka1UB/l/8HLkWvN5kLWnFps+wO20J/AR3J7gzI/n4TinY4Kmue?=
 =?us-ascii?Q?e73vTDrqgMA6Cd5uTw+6V63TrB9mlT3t8MuIMv7B8Qny8yYLNTmBG2P8eAii?=
 =?us-ascii?Q?pdd/BsRhOo4mS1vQ19/9rDYsCqBN4IyLM/RlmSca10VsDEAVJCa29f1PWJkO?=
 =?us-ascii?Q?+TTYp/qa/V88BmVkL9M3iIwbKH1YXwnEO9q1sv6WyZ3DL7DEG1XUYrVfMoOI?=
 =?us-ascii?Q?h/i0vIIPA832Fy2Wc9sU10LAlL7++SHgL7qY5pW6wDS7EHTaL5D3Dfi5QeIL?=
 =?us-ascii?Q?L8Fa08ADMRlRLwcWrTos0m1jVYyxRT8c1bz+31kkINiCwPgnRNgqN4c3BYOp?=
 =?us-ascii?Q?PVaqlZT6k4hMDKgsF+IEVwmMy06pQ6SonB2+mAJ+m8zIUhK86fQTl2P2a9F/?=
 =?us-ascii?Q?VvHVsC55Dg1FQPazHuF/K3+MVXmW/isbBI+rbcF6b5IOwJP7lGKbsBy6Tbq7?=
 =?us-ascii?Q?WsEJpdhP4ZQ0ya0cmbeXqIoluo8R6zz3CybkEpx4oiMKhJU1iQiHhrm6AT+N?=
 =?us-ascii?Q?DkUfW17gR3pAJuuHruWbCiUAhUyycb9Vx+XKOc3lFIHeJLjz8VNMvC/k8Bzv?=
 =?us-ascii?Q?3EHoXHWGRf5iuGVUGyjcgQK/nYoCf1ZjIJJ1LyZ6klobAcXZSR78szR/x/XD?=
 =?us-ascii?Q?4vhVJV+7mcw5leLKE0IJWbeGRxPG80+uKOJG2f+KLTzqcK1C7vzzCqggiWZY?=
 =?us-ascii?Q?I84rub0GdzFxpI0y5mVBhv8lYQq5X2G5Yvy9DHVnCWm9m9929UyBmw6OjTLS?=
 =?us-ascii?Q?vFsvyH4fuwWaCIc8UHatwxVHAzAZPx9ColHaU1HT1PJ/MBNPqU4MF4KwA7qX?=
 =?us-ascii?Q?KABU+mKtwB5SuCYU/lyZ6iY0y5hUT/CuPbeq/DtKTcwcHv2P/pwrvYgfNuuf?=
 =?us-ascii?Q?5jmhas3MFYrrfApWb5whlTSnLmsNNjj0J2VsoScjb7Zdpho62GogyGyJUtw8?=
 =?us-ascii?Q?LpoesCzkS9qiYPp4L1zw7t9LEPFSJS6lY7qVgqu0NqyAMRO4RE3sdjua+PLb?=
 =?us-ascii?Q?l7FneTFgRv3n0r5xPFGj8AyYCb9rN3E7G2KWfrmbanWsRnLXJAKTkTeZCfYV?=
 =?us-ascii?Q?o5Ahz289o5nxXCwg1eoNcLDgebEbxp5AyQf8dCRAU71L+Y3nPX8nQ1izOdad?=
 =?us-ascii?Q?/b9rBXmCWMiUv4W2cEt5lUIMYM/m+1S7i4wth1oAOSQLFwmlFYH2zks0uv4B?=
 =?us-ascii?Q?iiFcjoCobjLYRfblHR6sJvOidAncpLcCeZnsGL5M3uo4lyU+G1h2BaqYShet?=
 =?us-ascii?Q?GyD56BM7POQEimfObT2HR22Fkn2y2HddBNnfYdG26t/DwGqmr2IsKzB9MHJB?=
 =?us-ascii?Q?nAkMYjkBUAuozXMB+d4AAH9In6gfGCWz/fFEKCW1Ewss5NdjvAh569x3J0jI?=
 =?us-ascii?Q?grrwAKHFDQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2fcb70-17bd-406e-4844-08da1e6fc72e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:37:45.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuMG00UJmyunjRVFub4ULzPl5phNF7eTYzbKljlLEtS+9KTiVfxfdUEu9x7f+O4O5DA5Vb/gRQnIyOnyYxxNpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6043
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
---
Change from v6 to v7
 - none
Change from v5 to v6
 - s/rename/Rename/ at subject
new patch at v4

 drivers/dma/dw-edma/dw-edma-core.c |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
 include/linux/dma/edma.h           |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8cdc66e17c069..8c440cd7ca0e2 100644
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

