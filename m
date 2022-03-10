Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EADB4D51F8
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiCJT0e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 14:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiCJT0d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 14:26:33 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFC7136EEB;
        Thu, 10 Mar 2022 11:25:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHQ9F7t1wxl/PdjbwiwMbPclntDtxgWtJ7B4NLC2+QigYx1EunZ/4Vec5cxd36+x5jeHBmK+8h7mBmDymD9cMCcLr4KHeJzaRnzG+91kc35KY7bfoSUcLcynTTwqfX9e3RzJFeAUqb16rrZnh7vxXQQiucko+QZGT7+lo5A7GSQoJu4QRFAQdsbxpb5ECQkJGcNnzX04KyDnWn50TWBqqpqEckmwwZp+iwV5TMNuv+XkIT0m4APmKXRXm/ojmVWv5Haru2/JtyF4oBYu/Bmo3YuoW5KbiKk3Mp3a1qGCJ1zY2mEyAWUddixniofgHgTH0AZsAwyKq5A04U2Os+Gziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeasK1dTjuEvl76APKErmWDRMk5VOYUISu3D94dQ9Mc=;
 b=hreuAk6ZLwxjM3SATKmng6r5v71w4Qm2G4lEn4oey3I1Xn6rI+KrNeyS8686I+GRsdVVJEbcyyE4hjAk4/ZdZ4hL88oDzhHNX0r6gV1rtpuGoZ58gCZ0JeXkCbk6/TJGwBn3dska8wmXpSos5damQ/S16TLeqBPhf6akBxTF6CbvD8s+AbF/R1iTkAoQ6MWW4PzYI/oZ/o0JOl8Rne+I9yW8TSK1NLqDLZJoEdvMsk3YLvRRvB8/NnQBZ2dmYNq7Q5oDDcNQPR80UZ/T3nv+zQrTokPSWgeTGKQC1KLXoP+sYZk7USKpqYJUUJI4DJqpqVzEd1Ggd4LHCYK78e3rhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeasK1dTjuEvl76APKErmWDRMk5VOYUISu3D94dQ9Mc=;
 b=r4K9VU0OU5wDlQD1AAgBieScelP58+1zPjWAN6W3LHaGfqoYTbYZaUec9sUOxBaGZo43l+rARl5L4dN6FwpI5tMvVZsOGp9C1wmmMSgT+c4veGV/hOqmdDyM4xOUug52xaV3AozUZAIJGSxM2cBxZplbBTSQQoUI7LviR3S8PUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4858.eurprd04.prod.outlook.com (2603:10a6:10:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 19:25:29 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 19:25:29 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v5 3/9] dmaengine: dw-edma: change rg_region to reg_base in struct dw_edma_chip
Date:   Thu, 10 Mar 2022 13:24:51 -0600
Message-Id: <20220310192457.3090-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8c4ba5ba-1160-4dc0-a8ac-08da02cbbc62
X-MS-TrafficTypeDiagnostic: DB7PR04MB4858:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4858638C3527DC48D2A41ED2880B9@DB7PR04MB4858.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/wsEt72sthr0kEsChO1puLwALKoPZ9yBK+lMe7ml5HmBxMeenwRZztQjxso1rqkhCV3iBW9Uobu1EGQ5LYe2EetTIeJT2AkH4bLiaE3KvIzFGRCzqQKQXEzXTIxEmiZ4p8UmdMEfnFMAxgPZ7yWqR1HbChmF+N3FN8LfF9S/SzovdRPLkDcA0LYDnwKJ+ic1LDyBitsRbsHJD3G2ahuPRNB3KdWO+cVxIC8FJsRu75LIcHAy64c74pa7+YnMwe7DOkNwzFQpdG+wOMeXKt6JdJbJ5Oe4D+NgNuR9u7RRZtQ8KgPtn82HunGPfn4HFphDoTypkh2NVFP5MK3ty9/Z5zgCWlXIw4WtnQYvFbMz80QdSJpXYIACv5pcM4YHwAiCyLjDZBkwBrCj7+jgExG2c9F/ANOYfoYb0yI09+WQWV0t3OoCEZKlJKHjojv3D15MNlHVrJYkDFggeDwf5tq8AfMsSNeJ8BouENEBPiRnjZRyDlgL2KQ6Eoyj6mf3XL2HbFHIANXA5HubQlJmnSkj5X7uw9orJRcpFqlqMmmhkIRqIjz/56vFYM2zHFF6srb8jI5QkXB75FtaYuq0Tt5yIQPE+80uM+4sx7c++PP6trEkBaGy1TYCoz5yZn8k91JBpvFiuCvJw7rrvXjvLltbD82dWAGK4hJs/GEFLpHnlvKc/4yxIW36BxJYup/8WBbS+FwnpZiM8GHFg597pG57Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(7416002)(6506007)(6512007)(36756003)(186003)(5660300002)(66476007)(52116002)(6666004)(2906002)(2616005)(86362001)(4326008)(8676002)(66556008)(83380400001)(26005)(66946007)(8936002)(38350700002)(6486002)(498600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MHf4UIDhfkUXnIf/5/MpdJY3eH0MGKXP3LUqNjzSQqi/Xog1/Ifig+Y/udau?=
 =?us-ascii?Q?Zn9bMMlGoBqqfneM/26N1vDQjJzUn05VEkqNkpgnsm2TsHAGyFrSSiKJ/HoJ?=
 =?us-ascii?Q?c0BMqEG92jNj+BK6KCV6rdZ5wcJBk2GSI2xHvRPq+EvA3IUJkpdR8nl69wE4?=
 =?us-ascii?Q?wbL0FDrqXimVpRsNEbIlUqSYb1uYKO5c1U6EQJEvnlW8MsgU3Vw+fXvOWk4P?=
 =?us-ascii?Q?WZsbZtUn49e/7OKDFzqzH6S4K1MspK6baCKDePJwJqDmJJkUBaQx/8tLyGyH?=
 =?us-ascii?Q?aqAHQokKzPUhHHA5kaIh60nvLUEJ3NH7yJSHM2D3OfD+TPyBLK6rQfUpEDxL?=
 =?us-ascii?Q?dNffNCw31wgpYFSy1QYBE81n32jqwOrfLMKj9uTaj+msRxEmY3PCnKXPIZcB?=
 =?us-ascii?Q?a1YifirG0iVyxKOJlAds76b2nCaDVTnVUtQLV3WvshQmp23FapJJNBB33vmu?=
 =?us-ascii?Q?nS98JnfATSSjwci/U/JnSZ9dl7DZ/MVlExliIiZR9KUZ8eTGiraf1S8eLUQX?=
 =?us-ascii?Q?KVi6+3pG9dB2XKLvbcBLJK11ZHbNPAykXojw8NtlsTnhQ3yWES9MbLKf7SrE?=
 =?us-ascii?Q?8VQspp6jl9ObQx0m239e1y0fa9BNuf0m1HI98DdtB8cWMqjUjTvfyq2z7wMD?=
 =?us-ascii?Q?NI5cLaxh0Ljk1f4MklfYi56/IgDoeVf04VzB63WYTqXIm9j/Bm51VymJeVFP?=
 =?us-ascii?Q?yVl8bxNwb97X09TBdoizJYwIp9uIVgHDb8LaJ494hwccx1ryCGP1DYL8JLgo?=
 =?us-ascii?Q?sh2oAh4z3KGiOtvKLKXIb72uSyMeogOVol5eXj5xP9BmLOgXxgYmyQdK5hJt?=
 =?us-ascii?Q?AnE6utPdzqgeRDi6ttwV+TnkvLo8UiXOKeYeZVogxmRNa7TPy1YUqlwUbK2h?=
 =?us-ascii?Q?JA8pUMBQOueTmwJQc3ntxxXGc7iPQ+gXhUIQwLxVn+I2sfVXhU7ZtXetvH/X?=
 =?us-ascii?Q?DEr8+VjzNRFVEV9qtWaVdMVZXdhC+TCeRaKPmx99qsfQGlXCQpMA/MsixUSA?=
 =?us-ascii?Q?cFOEz5Aj0RD889ew88126elIseyAt5gzCGUvlE8lAcGp18LdSQf4plb9bm/h?=
 =?us-ascii?Q?IW5/mWpdvUDlT+Mn1t8a5rT20Tqs2urBotymf43hhoedN2A03UbLgZKwA2no?=
 =?us-ascii?Q?iZjYWVfrDUfL4kaOl4JU73y3hLTk0tggQOaBsxM2f5rQDkJSEOqmE3UaROgt?=
 =?us-ascii?Q?n3JCXP7cS+DGkf5nJZ94d9RbhDHct1LpwafFctgD+6CviAAjgpyGjuasgjKi?=
 =?us-ascii?Q?KFD6odtVz+S4T7rp50Ekeev2QMIVcEiRu8gTXazY+f3sSBq9mP2bqcFXai8H?=
 =?us-ascii?Q?WaKGVaIOviA4wIIgzw7+kO3rlWRfy/kalq0lKOyE7TxU6wJWKFI1ou5Xahll?=
 =?us-ascii?Q?ZfliJM9Ohj9FxqIJifYtJy4qyUG4Ut8BQsb2qaFWvFaYFImaCGkpFDO9zgiE?=
 =?us-ascii?Q?ed8DZP1lNKCaydOMidUoHyu/nk59KwRm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4ba5ba-1160-4dc0-a8ac-08da02cbbc62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:25:29.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaK6LiwCkM0Ahd6FvBJ0ux5c5Rsr2Oh9tHmq/G1SAo8z8o1PN1gSWCVDexUzXf1hobjw/gOTw0+2DvPZjGC45g==
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

struct dw_edma_region rg_region included virtual address, physical
address and size informaiton. But only virtual address is used by EDMA
driver. Change it to void __iomem *reg_base to clean up code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
No change since V4

 drivers/dma/dw-edma/dw-edma-pcie.c       | 6 +++---
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 2 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 2 +-
 include/linux/dma/edma.h                 | 3 ++-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 2c1c5fa4e9f28..ae42bad24dd5a 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -233,8 +233,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
 	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
 
-	chip->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
-	if (!chip->rg_region.vaddr)
+	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
+	if (!chip->reg_base)
 		return -ENOMEM;
 
 	for (i = 0; i < chip->wr_ch_cnt; i++) {
@@ -299,7 +299,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
 		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
-		chip->rg_region.vaddr);
+		chip->reg_base);
 
 
 	for (i = 0; i < chip->wr_ch_cnt; i++) {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index e507e076fad16..35f2adac93e46 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -25,7 +25,7 @@ enum dw_edma_control {
 
 static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 {
-	return dw->chip->rg_region.vaddr;
+	return dw->chip->reg_base;
 }
 
 #define SET_32(dw, name, value)				\
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index edb7e137cb35a..3a899f7f4e8d8 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -288,7 +288,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!dw)
 		return;
 
-	regs = dw->chip->rg_region.vaddr;
+	regs = dw->chip->reg_base;
 	if (!regs)
 		return;
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 6fd374cc72c8e..e9ce652b88233 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -39,6 +39,7 @@ enum dw_edma_map_format {
  * @id:			 instance ID
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
+ * @reg_base		 DMA register base address
  * @wr_ch_cnt		 DMA write channel number
  * @rd_ch_cnt		 DMA read channel number
  * @rg_region		 DMA register region
@@ -53,7 +54,7 @@ struct dw_edma_chip {
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
 
-	struct dw_edma_region	rg_region;
+	void __iomem		*reg_base;
 
 	u16			wr_ch_cnt;
 	u16			rd_ch_cnt;
-- 
2.24.0.rc1

