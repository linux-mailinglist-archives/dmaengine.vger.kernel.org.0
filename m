Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3AD50A2FC
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 16:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389140AbiDUOrt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389618AbiDUOrZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 10:47:25 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136C42EEE;
        Thu, 21 Apr 2022 07:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOWBmvLL461QbXsFL34f5aSqMtukooK7kzgCiFBxptHcRlgRALn8AnXuHJimLDTlWJ2vVNmlI18e+Gi/htaj40yQEf8WX2aCxDuRM+C0AuKQFAOkOi+pTyMeboQkeotdY91gnP+YB7FX6G+rNdC6cRYYJDPmtv6g45ZjVlIA0FsOcCNxhkBqOBr1wH68IZ0Qfju7r2VMDiZiaTErFL/yQb274TMiZYY5X1c68brzyleBrP94HLvCriNfYiiiF37XgYNmpCWMpqXMX0X2D7APCXBeujQf9I5QdzWRxYOcLLgmq03hnAuHQ4F6kaxdecepOhcpASFLqVAUOXEqzThgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDU+S5+FcN6oB8ZOhlLsu5F1lAkxRxFM2CpVESA8iRg=;
 b=bzxEsQI1UJWsPXmjxyYkQMe4dSzGUmUHcH01lIwUsrqRim7oF+Laf4txkFWpEfPoSXLNQ/bLOcCcvHvgM0gd780wgNSDwkUQEX+lj0SRCZyLHAZwXdD7XxZyX6Mh+HILXiTMMsprOfbwqtfNo8JZaHNXV03j6X6cadAFGuW1VM2wwy3dkiIeUJduvn/kl8c+UyiVwRyurvOy3IeMpagEgqcZ+D1k6XV9XlthqLmmlqSbn2wUHWjwBTP83oi2Fgciyki461ljsWIwogcjKkuWmot/knA73CKj8EyBMA0MxOy4zM2/YOJLK4yRYAmOOpSP1hoZ6SJ/Y2MGXuMUd36l0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDU+S5+FcN6oB8ZOhlLsu5F1lAkxRxFM2CpVESA8iRg=;
 b=l/IrX8orfLyml2WEVERBcum94cqIiXp45j0pxVfJDTx5YV706tH8reXB9i6nLpdQ9G+ZLQ+rHaoYplk0Ub/Ku3lB7iT63030597t06CaQgUb0qsOpntUAYxRmKYYjEBiT+CTo/3v8QctOvHHghBVjyDddsnrI2tRfKN2l4Wmsys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:44:31 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:44:31 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v8 4/9] dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct dw_edma_chip
Date:   Thu, 21 Apr 2022 09:43:44 -0500
Message-Id: <20220421144349.690115-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421144349.690115-1-Frank.Li@nxp.com>
References: <20220421144349.690115-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 554dc92f-eb21-4adf-22e2-08da23a571b1
X-MS-TrafficTypeDiagnostic: AS8PR04MB8689:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8689314DFAB5E889F8BCEBFD88F49@AS8PR04MB8689.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Phpy6clHu0UxVmtccl5TJK36Qa3s43nPzUd0GiucvoiKtH9Ep1wkjfNEu7CizoNaL4ZfxV+mJ/eUpjd1NrYLdkOV73xLR5QZQsIvrOp05d5kY2qNaqsU5shTzKu0hPBnuEh+wUOQ1FARHV82/mXvWOZo+MXg6+fs3rRQAQo/SZoZCxIvs50G8C+i/lGrGr19FqjF6qLZIbhlgQkM4/A+w67RCtTm+3wOBLeoONOl4HA9xmDMJTwQL1Mx+XNjdxEWtJ3nid3oUdzBER/PEm06U1M1b8mtHkWvlTvhkXUpmvj00Qd2AlzswDSafbLiQKlYgdaOScKbWE4bVk4Sb9RbTl+oWVjabWwFEo6nGQmYtS+vk3Rl3jFUJQmZKQPC2yo8gXdps+yHoIvSTxQOqoiK2wRnaaVdz0XGdMsOYDVRjntAM/vo25BbmAMbqUBG/j2yuYPI+lTzaw7c8qzS70ZIFSOM/RCuks4+EQabBaP3xptd2hSgwB78yEDKdS8MlPbbpFvhD0PVrXWkFxRwkT2xrYbvKhncUiywwQbJuSNVgJbfL30DixoGbOdjYye77wELlQnYT/4gO7whd0+X6Oidz4zyHR3tw+nucHo/0d3vBdCQUdj85MkBqT3PEubWKVOVT8OkQhTF/DK/ISL2J+3sDmoh/Tex01/H4JWDmddLl2xPLMb/JU2yvJDIyH3X8OImB50FeKLV5cUlKaIRXusmDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(6512007)(508600001)(4326008)(316002)(26005)(66556008)(8676002)(52116002)(6666004)(6506007)(6486002)(83380400001)(86362001)(38350700002)(38100700002)(186003)(8936002)(2906002)(2616005)(7416002)(36756003)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HPOgdVkFZluYycgixhE0be/MFPxsoQlFaZ20/X7z9LcNbuo+FmGYtaDIVhQh?=
 =?us-ascii?Q?0a9piTsDlh40t3wwJRt3qgIbgi29jEf28KVEmBMBWdAbJ40XQqZjWTla8oKM?=
 =?us-ascii?Q?ubAssffZDB1hOVdk2rmcBFgbGJdNZnzUJL3HzS0CLhQ/fKd8VnSvMu3CGPzE?=
 =?us-ascii?Q?pxllaiFd2FD7JCzpfq5kSPZ8z6dv/LoiyNC98DEn1HqjNUPYc1ep7O3p4/hS?=
 =?us-ascii?Q?6aOWW7/1oX+/ErBEga7W/HyWEABoO4VtVur4qE6L/j3eLpLZI3+bkS4UqXU7?=
 =?us-ascii?Q?HIpXj6N99Rh5LXC+WgEypXBeIhyFjo1h/w2zCq2X7Cj2zQA/K2yCGT/qL/Fx?=
 =?us-ascii?Q?xA9qa0A612aWMI+FHnzqcFnTmiOSUYkM3KkFKSZGo3asH6pppCxd8Q+51S2c?=
 =?us-ascii?Q?OlS+4MJW8k4LH8UNEUzMS462VP1jtQ94SssQrGyHiiw1Uz8BrllhaO2Wol7c?=
 =?us-ascii?Q?nQhSZHGN9O5ZhHWL+5XLLnIFARE1nZqufj9MSCHlsomwlyjtbj0teV3zBKc3?=
 =?us-ascii?Q?txGkz3KPMUkoZKwyhAHuyOCKmbI3xRq/JkZBF5PiLTWJg37qdrzbB1++MDIt?=
 =?us-ascii?Q?ioGM9pk2t6oLW8Y0Miq7+xmCR3x6eDnMuGEZ2szmzdsXdvT4TX4Twp1uBGNr?=
 =?us-ascii?Q?Tlvfpt88K7wuC/vOMtD3HFDn9qe/ooIfZgs+NV8zUTxznQ0DFp1TMzgP1TTO?=
 =?us-ascii?Q?bqUjBR5idFOG6p4tPB5n3Up1wLS6XH0OOP90N+WUzkMDVItId1UARQvwTQeT?=
 =?us-ascii?Q?FKAFt4zROm9uP0BniTzoi4SfamqWm8VZbgrniRirdcDrMxnPddAjXbnpXuBl?=
 =?us-ascii?Q?543W1Xw++cs0hz2+hih1PIb0Yw9sESMb5wFTV9ZdjJ4bLOAGCOydH9zCQWj+?=
 =?us-ascii?Q?aKshRyr3bJURQjDMJevJ0RFHDqFrdnO9rM7swIlwAbUb0d08iOwAKnRQNEfQ?=
 =?us-ascii?Q?iHbtGH5o6WoG4NppJinRNKlnqkvlgTtjmxBG8fK3yg6P+5lUl1g2Y9U0Isqi?=
 =?us-ascii?Q?ndPiITrdMObZrbwG424v7BtWOyxfAFcZgSUQDKM33Z4mqwk/OYlDA3VKYKN5?=
 =?us-ascii?Q?EzR+Ag8uzaMn0PUca5s+xy5v719HWcBLAd0N+hDOcp5i0kzNPHho8ITe/ERw?=
 =?us-ascii?Q?FPQLjEeb3vqm+XEP3wD109knUDs0WTWunPCd04LuKipod2VH8OB5cOdJmBVw?=
 =?us-ascii?Q?5fwY3egGXOacUFz2TawHdN/5/26VdKtbWBZitvnBe1v4J/TiFQajuy8U8ST7?=
 =?us-ascii?Q?vaINVUhClUuaYX/RvPdz/gS677qZSw2vZTnttG/cxzpoKEq7mJLwrVP4wG4s?=
 =?us-ascii?Q?H0ZTf3TZo4i9v7oaKRg7QvXVQoP+3lYU+aRGFNOlWMMP6nbJH2PISQMwQaum?=
 =?us-ascii?Q?sr7qaTH9SHh4IaxvM7V/U3KZLcd2MOl6xPFdUJGiBBUu+QyoYIfZ/pEOjh88?=
 =?us-ascii?Q?yrQK9yJwU9Tls666qihR1fWEh5I1wB9wXWG/sIKA7qwdtWDo94NwP6wewY70?=
 =?us-ascii?Q?vlF6N2EJ84RgAHX+VB777r5oSGa72j4HJlGES+A+mi7pAMEhTMS312+/5Qef?=
 =?us-ascii?Q?vaSQc1ZJJZNpDH5aH8gDkt4ZfszuuMydkRj+pJ2KWR1oBf7QdIi1fccvyrc+?=
 =?us-ascii?Q?Skwair6vSdyTbHgJxEk0zE8UqkaU4Jk9IttmekNo8sqZu+0B7HtRpN1BiX0Y?=
 =?us-ascii?Q?ofLQhE6n2Eb+F60OoBLb5XhKpWynz+NtC1rnsc2RSeSMS+C3OQ+X9O4L+SpQ?=
 =?us-ascii?Q?ZEpUOsTjVA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554dc92f-eb21-4adf-22e2-08da23a571b1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:44:31.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP4pSaCX7mIVM7jGWv4ieft21tp+Gox7PHOqYs7EF5jACzBVMrK/8VKTW+mkoxT2RatQPF22yQR39LAcOm02fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689
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
Change from v6 to v8
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

