Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBB44D5259
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbiCJT0h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 14:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiCJT0g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 14:26:36 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA6A137032;
        Thu, 10 Mar 2022 11:25:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH63z8r17hl6cHRRh77r6lE8zfiS+8+kiHO6WWfKADYYbjEoMlUO/OZsz1RQHfUBLHnyBT1Ij99Phst2lOh3JFiOk8DzoERn3Jo6GqEurftNGUpppFhNrMmrgaVPWxvT4c+dh+HBa8m9/fi8YNwfo9Z8Y6jORvodq4esrfCjPZckjzgoVyWVGSfCjHlpk8dr6T+bDSFGKCgJ4BH2hLCZBvEuJLC2xY7yzal8OOLv0tkaLHrA1ToCCe+Z/C30LvP12cLRQHn7fDEthLaBnRryOTEDfYm9zRDFeQISpDH5nKgV8Q+O1beiwIiffrRPchDQojxizAYkIIQ3xn7bmEjH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBuf/46V/Ze9YP9pq6NwgXJ67ZwsOok+jFz0xvb5MZU=;
 b=cpSjcWVFafDwWEgxks+5ueY5jj4OSGfLDvmDip6rzqxFS9nI7Nw/e+euMfUvEewxjbBjaPZR5/aqv+H2ROwWeiq/jQt0T4DSzIMB2kWBz01ZQefAtGsBxzO0v3TMypXmf4ozwNst7gAqeuTk4cugdQusryfNl6clyKGtc3+l3FzQRxxaoF9+Ww/Q8r+l8jWnYWllWxmc1LsuV7gqzVKn8cOBRSBMcZDYOfVXQRjhvBVHoAVSbPXAzLs8RekylYX5vgXA+c5lOstZGiemMwezNG2CkZZn7rE+ZNfWog070RwAlFhbUqKq7to2lCAcpMxCeDh6QbPzbQk0DJfENhq7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBuf/46V/Ze9YP9pq6NwgXJ67ZwsOok+jFz0xvb5MZU=;
 b=DHuyjbLUJZYKm123b6DhAvHgPjhcnO9ShfgYZFaLdnDcpKfT4GXDpRrWwFz9EsLQGenXc60aATructGNAy7TBFxPDXzpVVZlTXN+Z760P9huZd19nSGcSkTiUIJZXlNezSPz+Mz0/ek25nR1HwdcnFyHszudTezieQwsKBdLsK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4858.eurprd04.prod.outlook.com (2603:10a6:10:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 19:25:32 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 19:25:32 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v5 4/9] dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct dw_edma_chip
Date:   Thu, 10 Mar 2022 13:24:52 -0600
Message-Id: <20220310192457.3090-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220310192457.3090-1-Frank.Li@nxp.com>
References: <20220310192457.3090-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 234e2d1f-0155-4765-41b1-08da02cbbe95
X-MS-TrafficTypeDiagnostic: DB7PR04MB4858:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4858CD15D2AABA2C10B2E5F3880B9@DB7PR04MB4858.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czuNe/ufirDy6fE0lov3Ia0+GaQnQQmPvI4d+eK4ndREkQb/mbgmeGJzs5pTDYILmwfokMN+h/a9k2ZEOum7xVvH1rgDCu2CsZtTb6M9m7/xFURuA+JcnCGtUR0fxVKJYYV3t1BRb/t0vjHvXqv7AMJo36IICi8UHufo5GaXQ6Uh4D96RJUie/l14jkT8wkpVqnFqPUdRpxYPDjJJyQcDEIS2RwAX9BzltIP5srmsexR0JcZiPsXReVlHORBfF/CHuB4ZNxezO99goAzof4HLFlBqmjFpwkfxnQ2o8BRPykwb94/ha1eotn8g8escPqeZ1GH4JpwO0xpquAA8ikZuH7dct7Mzz1UjcPXxMRZEQWxItrGDQlyI5KjfrExx/KukbjhwA+5BaFFAQKrXeMoNZx1zXuRkEOQoSKPXxp15yx/5wPipshOb39s1lHZMGPkGrxzP2G7MoI6URwZEHg0mwktPmbytQZ1I3ChReVJWXDBQGGC/muMfqB9i1bHg4IbahOP29Bh/YxofhZ0tKEM3gXFXR2ghYuDmCl/Tv9Q/5Jlx7SqgZMbbuy1gtYFiO/0ffFwUN5rWhJ9XAmrQEuaBl8cookzSTyKAve8qNI+rzJLCfjPEQnJbfJnhfKWZe+DMiRlNVa9ArVFkUB6nYfSgp+uPR9CIImYtMXWNjUjcu2G0Z+qaaxB5y92X5Pva1osPqT+fmGIy5H/TzAscjL/EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(7416002)(6506007)(6512007)(36756003)(186003)(5660300002)(66476007)(52116002)(6666004)(2906002)(2616005)(86362001)(4326008)(8676002)(66556008)(83380400001)(26005)(66946007)(8936002)(38350700002)(6486002)(498600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iF2wepOsehL1gfziHmr8aFRapXaGDW9sEz0xFDTVf4jI4J4GeYB4em+ePbRZ?=
 =?us-ascii?Q?qSG7He+KJtzme13rK0ro1u9BlKU7x1n3sogejMPzs7GbNhS6twaPw4nxeLur?=
 =?us-ascii?Q?Pi+AWfz1er6BCu6x/JTLzyZ5YMlXx1Nw+zz6aS3a08UdfkT69CgCliCye87y?=
 =?us-ascii?Q?8fjDNTGFwrp00NYdOk5TBX/Qi0aurY5+NjRHwLiRv43MmYAPl+B2DlHNDWin?=
 =?us-ascii?Q?LkiWQwQFM1aIYrS990JMtCIhenyJH8b0lwh+reelKUrLfh6Q5ECkwGMvptsS?=
 =?us-ascii?Q?NK5RDR+S/dHWbdK+V6iyIQBdDefzxqZi+z4+gtsXkna+1MzCOBKtqS0M+c0W?=
 =?us-ascii?Q?JAw6ROgaN2iuBad3eciUGNWdSfuKPijZ8+kbniL9o/zmAznRleDPYi6BwKj5?=
 =?us-ascii?Q?OctLAQofqfYsVYyXaXVeyGOgtedrpTryzdIKCWnYAFOcbiaP9d7oSbN7Xp4B?=
 =?us-ascii?Q?iXvk5cbZCeywJ2zLtv+4ZugeE+5e4SO+SdhEZMEOOZcj9affJ+9VBa8vHPkg?=
 =?us-ascii?Q?h2xAKM/YvrnKI2kQGnUJYmiyoFHY0hcxNPfwiUL4/aVP3vhfFuCBFs/4SdOn?=
 =?us-ascii?Q?IwiFq5RDaP4ZcLBrTu9L5zJ+1HYbRcymtXKVhoP22b4fgR2NPW8QM1dCGl8B?=
 =?us-ascii?Q?nzcHIi1AbscsN85qusonSjdWZ4ESVfxR4J5eMpQfwGQob4Tg9Yhjrat8Xmdt?=
 =?us-ascii?Q?y3ZRteX/JEPIQuom2OPbCstDup/8y0vpiINSRfbSAkvV5JfD8h+0dNRUgsvG?=
 =?us-ascii?Q?gAbPtj62bev7mP+DzgTACxAWRkLGUHCKxvPoP1KFx1o6Rhw1nmtZj9TvB4iV?=
 =?us-ascii?Q?bXoroDDQUwsbrNvp3To3YXPyv3mExz5ouBFCBxbjz+Cc6CjKAnZbn5JJyKIf?=
 =?us-ascii?Q?REDiu+a2f2lRUYLsxEBBPXuUi8rx1/tDgJHVGA3k7d1KKDx2fGR4IfTZhTSc?=
 =?us-ascii?Q?TNlrTV0oHL8YfyHnnK2ckUvE+yZV1mV9pxTcHcOUxq2aIk8Ka9UXfEyN5D71?=
 =?us-ascii?Q?CqUSCyIHSu7vDAf9K7DH6rBCwdJex1f3nGY3PXlEFkeMVpH01dW9aOHYA6dF?=
 =?us-ascii?Q?7fcL4ZjI/UQ1pige0LU5IIya3V9gn2GxijhllQo5ILJh1Tv4yN+DK2K+Cpp2?=
 =?us-ascii?Q?g8nkA9zHhiM1Fj15KlviB0I228A11h9ZT29KyoI+e92w4Ht8dWRuks4yh6bO?=
 =?us-ascii?Q?52cCPXTR4PrPt7cZSwdlkk3568YGnm8v4VPZkpglmJndTqbrOKV8sprHFXj3?=
 =?us-ascii?Q?lfU9fBL0TYt6X8UuKOLLKXzdZBdJx2Tz5q5ZpQT14oHRCxMRj2SQZ9QFyELy?=
 =?us-ascii?Q?nASC7gg6yp2Mny/zJqApHsXUGjrW+FPJRojA3Rck/fpw2kmck1TuplWWPFne?=
 =?us-ascii?Q?NoxuPtx9HRQfdWZQVHuQtZSgRoHHpbYHSQzugjvkPbJTTwJvIxop+H/FtIQ+?=
 =?us-ascii?Q?y5Jhj2gvdSro7xyxVtNAWrxjK4QEakuU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234e2d1f-0155-4765-41b1-08da02cbbe95
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:25:32.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqihSayEvOVOIoXFe0jRV4LBUeK7l0y5rQPQYbzXylFMGjOLgJTPIAa4/SfkjclDZDIP4hgEkB8e9nm0yCgMBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4858
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
are avaiable in ll_region_wr(rd)[EDMA_MAX_WR_CH]. So rename it to
ll_wr(rd)_cnt to indicate actual usage.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
No change since v4

 drivers/dma/dw-edma/dw-edma-core.c |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
 include/linux/dma/edma.h           |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 2503f1463f07c..3e4850cfa0b72 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -915,11 +915,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
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
2.24.0.rc1

