Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B3252A5EC
	for <lists+dmaengine@lfdr.de>; Tue, 17 May 2022 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349844AbiEQPUD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 May 2022 11:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349861AbiEQPUB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 May 2022 11:20:01 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42864B856;
        Tue, 17 May 2022 08:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O72gi4qEPVCcqh46NiyEkY5VFmPVTjaB9oJnBOAn0FtXd6IdFXbQfS8vXLwvXL/LOjkUP3jH1sSOaPC+DRXgzL4yFPRXjAvHKDb04egpUmXuFd7pbI1jNqtvBeQyFH6GFmFwWQIeeyzJqtGTTQZaLjgWbkFOFnb7kcLqABG9IDcXTffczDJlB5X9IcYKry/eUIgcfRNaSiERmBv4naft1fa1k4YBt6VP2g4IIdp8bTxPgdfotQR8uc+lmGPll8ucTmlwEzuBE/ANnamqbE+5zOM1r9Yzw/e9C9KR6QJLs60kSp69iXjRlDD5AAPI5KuZg18CeaHXPNbYQ1qvPY6+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvCC0s6AMnUQAuAKBzF++06HQkwR1Y07FxRbcP9jh9Y=;
 b=N8t1/mkxn5jFPqWLl0r2bzcOdk7vQ6VYECbytCM4istG38CO2Grb8yoYQeWC+As0IX6YhuviIO+M12aezZy0yJCzisp19Nk/skfXJ840LOfaRE3eBA6Fd5po1NI0C3sDATJgamLx8zVVh56Mf2kzhprVDJs0eJZsf5Ub/E7V2CkaUoR112bT8mPdtJuPNxgasW5msbSOtLRQ6aZYJEBH7VA8Tw09DioMmcgN4giC6vk+ByohV2MxmVMDjiObLDz5CV4isAokEXNFmApILZRq5ScF34kNGOfRSk8x2ibwSHunDPdIBAEuXMc4+rlXriT0k8R27QRpLtJInLpO+DYqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvCC0s6AMnUQAuAKBzF++06HQkwR1Y07FxRbcP9jh9Y=;
 b=SUXE2DhVUqMkfw56WaI4tPi4DdFvgvUGvbjeVDtmFICux3frSAyASu7fXRGq2peYv8+nQ9tILWKBm2RzoZgLceVu484PAVhxdPgFvgL/sC2m/XFRE9Ii1n/nk41lxp23AJA1hivJZ6nFI0M3vUJOxIhWJVVvy25mb100thxznEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR0401MB2285.eurprd04.prod.outlook.com (2603:10a6:800:2a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:19:51 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 17 May 2022
 15:19:51 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v11 3/8] dmaengine: dw-edma: Change rg_region to reg_base in struct dw_edma_chip
Date:   Tue, 17 May 2022 10:19:10 -0500
Message-Id: <20220517151915.2212838-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7599504-bd4a-4817-d624-08da3818aff4
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2285:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2285ECF53BBF5DBB059AE8E688CE9@VI1PR0401MB2285.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01AYUtx8wz11kR3StMzoXTNz/duS6F9S1Hai4NZ3DmMx9I/8LOU+SS8WIaOdd4EjUmhD3AwMuUd3IjY1XjMLeDSbAiZ12yleKlBVjqlXkFZ0LYDg3LZ9NlGFE+dr5g2JcvF3CKVl+uTBXa9Aj2gw5LygvfeV++JtQsE26l6x0IQVBV61ge5kz+e2mmzgsKuSmFX9DQ7GN9uZAz/L/ORwUh8tRC4lHoL7Bo7smDB9jvPsr02TXXhP/vStTuD5ksSOoV0g132jZ7m++qseYOOgT5qPqUM3bSr8H/x+qW8WpfR0Sa0BXL3RYY4n7uUfwKBDNIRf3anObO1YCEvHmznwrsQmfbAIc+AdLocPDr5k/69SdaZfQqQ/lFxXvDVmNGFFdkZQSZ/fDbatGgkKAPpeGgRanDFsnwLqFzj2lgLf13kBqF6JfA1RTjp9+QOoJeDAdTZcZBmuslyCfv5L7/oMs5xx0ho4OWL+sam7WauwVnUiksMHRuYm0GQPHFwtdV1+bnv6uAXM+jE5JB63iX+f6cmtD9Wxr4DevW//4l5eJzBc7GYYJJvy5I+gaZzF6aXAO/qWg0dbqWcPXZ+yD+oeL4ciSxXCieeWeQoihMBISdGDPIFYM+oEMKE0QkGw1VMq2ikgo412dy2ppsXBV1d57ZY+CRZPDpD2BHDB1Eue50+5lR7OXs1Zl+wzTCdpgcExPmOnCc+L/dlbEt6AmoYXh0DSGGK9Cb6+MIjEqwo5sG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6666004)(52116002)(8676002)(6506007)(66556008)(86362001)(36756003)(6486002)(316002)(508600001)(38350700002)(38100700002)(2616005)(1076003)(186003)(921005)(83380400001)(8936002)(2906002)(6512007)(66476007)(26005)(5660300002)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZE/IaRiPQ2phhvqqt3LR3tDwnW4KGaZQgzyV/Phx61C3HpnjhorpnTM+6Gfx?=
 =?us-ascii?Q?NBV+oA938oM3blNNyqCEedsQTzNdyCUkwqARkC9pxbICvYi/pp5Xqfocctuk?=
 =?us-ascii?Q?oZfORsJdkcb9lZ5aUKgoIz4yjhzg59+Id0I7Vxim4eVGlNWbQQIT7rXN5c8B?=
 =?us-ascii?Q?rRIMkjGbn5UJxidagwe92Ns3oFfm7jG4mzpchCvPy1HmZisfS2vtDHMg0AX8?=
 =?us-ascii?Q?511jbKXyNJ2sXqxXenCxla7BLy5ak+ZvRV3T5MJ+QHgpeQu738oUjb0JPCWb?=
 =?us-ascii?Q?6T2gWhdxFselnnLJrQ1f1cAqAslKJ2qUQ/hgJm3CB121hl417P3sCFOQejeX?=
 =?us-ascii?Q?gqRLBUYhB2brnXYV7C3/7N4hnDNkCR0+LMF8f/g8KIKqLHAAbekd+IBMyKiN?=
 =?us-ascii?Q?twgEpb1I4e8bZbc+KoIDZbyGxcUGVpO3BX/82dxbJO9LHuavc7efw9VkIXEy?=
 =?us-ascii?Q?B2tzgMA41s98G7dZjFjlPsaVcNm8D7l1LgEKyHpVkNOL4f3d/3vkAGQae9PL?=
 =?us-ascii?Q?3fFY+ri6FA2IV1doxLD3Id0FH3c6wSh5LTP2vogQbsM0k9AcPd32Tf2ZVshm?=
 =?us-ascii?Q?b+kfLh3yqYDyw0YKBySwDF6ckHOdYbOKrhgP0ZxyTu5SD66SyD2fuj4/3Zdp?=
 =?us-ascii?Q?KmpQXkbwLclERiR8AG8TfvcPkyFFFTaZsLBW7+sp96/+uuePWx8kmD1LN1NB?=
 =?us-ascii?Q?stukpbjh+LWsHqBy4KIg5H+M+wsFHCJmnW1vGEj2i16rJj+7L3cBbzRcQzvB?=
 =?us-ascii?Q?flU+9ZtntXjekHn/K4m7nzl7jRkoDhW3RiQbAwxWTl5DIq+qa61AyFeZpS8h?=
 =?us-ascii?Q?MhcwadRgP+7tL37GM/CvcJIs5myCEaArtivz2YCEa33XjxJYjhuZf43OjvrF?=
 =?us-ascii?Q?rjDoEEXMnW6ib4DutERGfGlHYmV40p8lA5WXdtvYLm2ilgsyFFnaDz2OVN23?=
 =?us-ascii?Q?9nowIFe81V1jOhl7lNsKz4tp1WzcP0WqJhvkcE3WlaXgsnzZk/gdFZzeLR3r?=
 =?us-ascii?Q?/Sx6b9enTaBteHnJhDwjhSCjGGBYMfLfVvRtuuAr/CrkiS7RAdn6QlugEFvB?=
 =?us-ascii?Q?AM6WrB+Uih/LEp9mllupf3ZSS/C8VGuMTle8AaCdzs8wrqIR4oj+CNvtkehd?=
 =?us-ascii?Q?qz3OH7sq3sAt71bXoU2e8L8y4jxVY+4N8BuTW6itHqQGGJXmU4VA65baE5Gm?=
 =?us-ascii?Q?jFI8YOHIYljA0kgJawqfd6lV9U6lJ22k3V1wllQ3VndX9rX58nYJ57ghwwcx?=
 =?us-ascii?Q?5V96lrDCtS2HYV9q7OJtXnGxMJvxQkekc64xlR7RvD2rphNEFEM21mUEt7QY?=
 =?us-ascii?Q?bNwNnZd1w+F8ETqSKIqWCniinSSYPaH+nztubnFoXZRV5K7POlh8XCIkV12j?=
 =?us-ascii?Q?JvQ7/WcXPmY+ixUrwFpQXfITenjExL/DmjzJ92pNsDO3pMIFLlqaBVai53PL?=
 =?us-ascii?Q?bL3Svp5V5a/wf5uySLFzT90FQOzkM60h71yFqY0DK/Euo27cbA3YNAYrUvfH?=
 =?us-ascii?Q?wkc0sNUoP+L3wCJG/Q7+n4YRwi5iRkgBT7APHSWh/aDo87iPfjLRBjmpovAJ?=
 =?us-ascii?Q?VZ0z2dZito/7LSGBqeZyjhqMB9S3/beO1tSIJA8zi5Lb5rWEFg5bncsrAe39?=
 =?us-ascii?Q?pf8Bq85Dr1L8T/SGdwocGPXfRhVKYsqL8rWeAZX+Xf7Pa9sgCHfzPrXyR5dM?=
 =?us-ascii?Q?rtTPTEPm9njHIyeHfBNOd8LSc1yY+5mtbo323Lvxsige9KG9o1XjQ97ADqb8?=
 =?us-ascii?Q?bePTOp9FYg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7599504-bd4a-4817-d624-08da3818aff4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 15:19:51.1899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAj7EdinG43n2cke00ZvuzAa6nl2S5Kaew/+v6YMuBZDldYIVyWkEqvJGXPmgXcF2cbNVR2/BbodcH1tc9Tgkw==
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

struct dw_edma_region rg_region included virtual address, physical
address and size information. But only virtual address is used by EDMA
driver. Change it to void __iomem *reg_base to clean up code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Change from v6 to v11:
 - none
Change from v5 to v6:
 -s/change/Change at subject
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
index 999e038961866..403ade40c1b1b 100644
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
index b765adb969998..5226c9014703c 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -288,7 +288,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma *_dw)
 	if (!dw)
 		return;
 
-	regs = dw->chip->rg_region.vaddr;
+	regs = dw->chip->reg_base;
 	if (!regs)
 		return;
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 86697d33e0610..195ee1e47f21d 100644
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
@@ -55,7 +56,7 @@ struct dw_edma_chip {
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
 
-	struct dw_edma_region	rg_region;
+	void __iomem		*reg_base;
 
 	u16			wr_ch_cnt;
 	u16			rd_ch_cnt;
-- 
2.35.1

