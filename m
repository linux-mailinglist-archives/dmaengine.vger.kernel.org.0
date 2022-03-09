Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5D24D3BCC
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 22:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiCIVNo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 16:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiCIVNn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 16:13:43 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B34C398;
        Wed,  9 Mar 2022 13:12:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us78s1J+yiTmJPZMoUqu5NZufMgQGFv/kJ48wPc4QJShxNXh3BnxbaUo+cgc/omRmYWwOMi73aBlvq2YS4eIp71ewzvz8ZLyOx9E2kO83pT2ZOVaDb8IuHd5lJTxfzQdAFJEJNUVgDBKUGnO99sBVag2IobYr579yoqB/yYY5RCNcGr/uhLUoHMLvNV+qJ8yjOqcYDirPzTDAJmnH6yO4/9Lk7Tz50lUK/mUXpMoQC3aAQlPLDFzyUrdECAu05b7xWKyqGRX0PhrVRIPkFoOu8+A3SY5/9fbvmhLYhI0SPiAkLaD7pY7hhIRJs0CSWYy1PhFp4ExgXKsb5tUKEhF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHT11MjgnE39rNrGnEtyOgi/lFFnnixX5FddCpJpqJ0=;
 b=WlZ2qceqBc10sEWP6Tq1DqX/MpZR2OfxuUm3egLlo7rv/DeaicaDemb1jf1DHuFopbNC4urM5SKLqmvuFRIP8KlWuNG0Xv+lPd7BuGeUqlMH1dDrXsnREW6dcgBHc4MCq5ToR4kqY0i+/q+Dyc7wAEcFS0wqHfK9+Br02SlS2hlmosz5Nu+PZwjDPj5xoKulBVHgdYbnsLTYi0FBVSCyqd+gcYDaojg++6AVDLJS/avXtHljQ2MoGbg3K2j2myqfg/exvAKLsKugKhJWn0aMi8lKawSFVg1ZfS0FY4UFMwdBDXH9d+qGmp21aPsFSLZmpGwYQTsAQvgNy9zeRbJJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHT11MjgnE39rNrGnEtyOgi/lFFnnixX5FddCpJpqJ0=;
 b=TWM2AI6u7ZfVqzAvurJgxX/0LLFQWi6KxSK9V0NMJr2l143wr/oGEKg5Tj1i/Y6QYCm75aY/LRlduTBXKHIW5ATM+l6iiPp4Vlx/dvmPK4aJl6Ht6rfKmjSEDiSxuncZ7HzEHlkvDrTCTg38mYFw+ASgQOnRmBt+U+c8RSW43fU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 21:12:40 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 21:12:40 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v4 3/8] dmaengine: dw-edma: change rg_region to reg_base in struct dw_edma_chip
Date:   Wed,  9 Mar 2022 15:11:59 -0600
Message-Id: <20220309211204.26050-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220309211204.26050-1-Frank.Li@nxp.com>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1e724a0-159b-4c0b-5094-08da02118b6c
X-MS-TrafficTypeDiagnostic: AS8PR04MB8358:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8358C4A1339A2185E0BDFA07880A9@AS8PR04MB8358.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Sc7rnibeJzuQJGLQ9X+VtY/wIynWgyY3NXIIv928wXSJQ6ub/Ij4SjwwcyNz0SUHjVVP3TpL8qaw8AlPeLTBD4mvulvsWPiaZ9bvY5wPPNq/x8ALNTPJP3OvTLBeRI0gvnih+SodeQSTdkiOY+0UaTJkYlLWiTho7G25PYL8/gBD167S//REc/jAGHFnreZ30KFJ8SZ0vCfaPSUN/kVlXRMkfzMo5NGiHm9BFtQdGf4pB/oq09IwiB9tOmRbBlizK0gbAhZM/QpenZzvqSNllze5P5yqMt2BijWsbEUeggK5ewMabIX4fJTTDsM/Gp7Mq3sd6h3njQr6cRpgvRZiwQQumguHoor0vqbnEcVewsfxSaxqwUwI99z0Zix/LzHfFQ97vtubHmG7uF47R9drTm0i4lLv56vUjPEw+iQ42xRvxLsD0to4OXCfXkx/wmYX/6IJeI6518+NJdEhoWcMiRad3lI84gISFRBY9Z0quhwyvYCW0MKeALHa4fVQjXPhWKfum6/1uPQJ7HcIhx0OYEyuwXFPjSytWIghl9xWu4d8BXtM1mlYtZj0LpgF4VIJiJSJwQmIH/41dc9Kj3h0gUWjpPm31aIFScBrz3EowhUtpdtexLBmnXTCqOdHZ5486cOOkJa90GyY9rL7S3sl3NSPhXKZsr/pfhmqXxcUJADTEJFOjw/HYcoQHb5TBZ2i+iSJugFqGHsFtLy80Jfog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(508600001)(2616005)(1076003)(316002)(83380400001)(6512007)(66946007)(86362001)(66556008)(52116002)(66476007)(8676002)(6506007)(4326008)(36756003)(2906002)(38350700002)(38100700002)(6486002)(5660300002)(6666004)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4h8ee4tBh8EB9kreyhDuwNtonhJ9NRTnkdTUU9sSFKev/ofH4bRZYdz0LURy?=
 =?us-ascii?Q?f9vG3Feivw89DOnBvX0NfNoRmQkTgR7uRTqqWcRxyL/AmQ122ogYyh9LhvOn?=
 =?us-ascii?Q?ortEwjuA1DJuJnLyScBkg9XXVr5dohe/KAygbxVo/3EdWaCBY9zvnf6JkGCY?=
 =?us-ascii?Q?hRSQr+J5QTJ7dK/OxGqaTmpeSIbBd0xIJXRSJcxQzoId6VC21XL786GdiiCu?=
 =?us-ascii?Q?6TiNBvaz/puMi5OKLsRQUbOzpU+UPINRAmDh1HyaXiOYDtdU//jdSq82kBfj?=
 =?us-ascii?Q?q++jWKvU1KrN/6MWRVJ73dOnUVHJsN3C2uSXzhyF69dAQmCTEjJTjNrsnSpL?=
 =?us-ascii?Q?HqdmcQp1TN7TK6HAl6PV6lmttmyIE3t38XmX4F99esfK1v36L4jeokEYfM2V?=
 =?us-ascii?Q?Jy7EsPCcUOx5BVcLH6keLnL4KCMJTDaw98FBvTRRBfjvFJoxj8ZgtQKvE1zW?=
 =?us-ascii?Q?n6wbb6mZfr79fScZySCpEiUqHmBYspB3kgE8XZOL4k6jzE2LtkzIXpAFtSYB?=
 =?us-ascii?Q?PIPtJgAaBq25Sk0N4WLB3JefsVVIN51JKDLt13Tyl2LSKXiVNhB8U8Ft8NpF?=
 =?us-ascii?Q?lBaErwxCjhmsS9sk+blwcrAtETA/wVYz/58clJeWlHGr73pVYkPHbtC0YXJS?=
 =?us-ascii?Q?Z3Jt73pkqQturjr/IqXVeoMU+Ve8Qq+eKjStUeqCi39AtHNw2l5tICQZp7eY?=
 =?us-ascii?Q?5nm6wPh2UhHjieThenyuN7AYGhsvNmo+Z45IgQItC7IEy6lqMkzwYEB/7JFR?=
 =?us-ascii?Q?JgJeX31sR51MLNnxIaqNhhjhnxfoNOGtA4O1VkuWMOF4Dk1QxtkgTg1BbJtZ?=
 =?us-ascii?Q?1mktwTQ8o99ibkTA0/4INORrd7pdWnVDrSIdCZjFEoExoLEB/LKVO9/KfcBM?=
 =?us-ascii?Q?SCSvWXOUI9SkvEjm6PWyGBHC+rQoJChJBHbz/HAZnO8x4JUaedngNfE7+i1U?=
 =?us-ascii?Q?URXtJnwv7XLGtRgdgEX+n6cjClagqC07SdD5bMzQ49bmc0nAhGQnzzIKkOHV?=
 =?us-ascii?Q?OQ6NnFHAn2ZeCIrUWcxjaBCRyG8PlhAY0VeDlJxr4+kyJArc6+qMUSZzIuqF?=
 =?us-ascii?Q?4yzEhCVcYfBhywlIuqzUmxMS6Q78A4v5Q0euTrnGbKhQb+kJcdcTlhz6CchW?=
 =?us-ascii?Q?eAF/yDydrT5KgafM3lvgSlGko3ZWG2b0uhheiZkRwrEsUoGFwrDrJpm+OPWw?=
 =?us-ascii?Q?5xM+b4I2HNEb2wGDK1bFJ/vFS5x0gFUOXHKbMEhqe8cNWvC+s9Gqe8oYNaZ5?=
 =?us-ascii?Q?okk9H4Mny/OsMypX1y6uwT0RJ2eWVBdp95VP5VmJssKHw9wvPyjgLUUPbl1o?=
 =?us-ascii?Q?b7yNz4oGcj5I1I4EYPmdINsI9L77n3VVYukD267+YiXbOel9/5xj7hjq89Gz?=
 =?us-ascii?Q?77ic+b8uEuz9R3MFp6lMeZ+/qSc9rOa9O6kKFwH//KHHDF7m3PYIfjeFj1vu?=
 =?us-ascii?Q?fqNnEB82wRjxxAR0wJklKtIBDT9j4h1vSVQPZUa5tgNMGz8VSkFq07SM+3rY?=
 =?us-ascii?Q?a3DpmPgx47ta+yoCd7IU8eS27weLI9dZSizwV7XCf67VRv8YMw+npHv3H6/M?=
 =?us-ascii?Q?m+hwVGNas0EXzdjCzLjeLDyR3jEftOU0stCsH9IUl2wRlFdrwygLfueUhzKe?=
 =?us-ascii?Q?jVsSyVl/Ze6fD9VyuQUR5uw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e724a0-159b-4c0b-5094-08da02118b6c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:12:40.5209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSds4LPPnOOks0vkHNh5BA6KZ0lnw4CJfqOLq1/QTNiHizBY/89GE7xVnDVK4s9r9iXGSgSp4awgwfBS1dDgIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8358
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
---
New patch at v4

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

