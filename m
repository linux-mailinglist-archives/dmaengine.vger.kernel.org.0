Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917D8517B7F
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 03:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiECBKC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 21:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiECBKB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 21:10:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06564D9C0;
        Mon,  2 May 2022 18:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG4XEQr/+hUYw3K0JFX7A1MCGGw3CUVJT3jEqhzKQTNgjX5zPg06WdTG3PldGr3XQDBMQvr4St6d+NbpeF2+JcLABXqXK50qGxYev6dsO9EzMjCfwl5Zlbru2DWbqZxiftY1m4R8YMU+56mLJYMSiwwhYDbw0DBLhjWmKlrvDfKvSn0HcnVvt2p5YSrpXkX3XfezdSVlly9BOAZSIGs91mqtgP0CqKkOuHLpiIsreI81b1RfQrIqO7Cffld5/82kEi/yRSYdCbjXhEL7h3xvXSl2XQ7b4R21KtM4VRaW5M/2sbSFshOQWiZ+/S3kvXEjCilR/AyFeR8MsK/XosRHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlH3AETgHTHuoCEu3lF3xQ1YNUtINLey+i9nswYIzjg=;
 b=V1jGNkO2TPvJhOwE4x9O1hx9dk0uU1dghtqvrSvCx7KlAnSrFtvcq7gDKpT+AZOFDIVftc2+605KSiAXDpwGCu2cMQqj9had16914/ghLcBSbona+VTbOhBJtGOLWbckT7SM8xDa7nJIqbiEGAKfpZ7eJrZwR62SidXBS+/1bCkDQWLC8VvQfOZ31yCNupnV8gvFuQQZSUFwU++S2CFW8v8Io1JHcINpZKRQEefhYd+eYVXsAB/bmji7EmNE9jZ5jG1M78vf4dz/yitWoAwr3LCKGgPBMi3A/jGcpNKMeaWJnnvZmrMvsRtPKwOPYqFEs6LKM6TJLrRk9gK5i6DioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlH3AETgHTHuoCEu3lF3xQ1YNUtINLey+i9nswYIzjg=;
 b=oURM/k47bA/lX7Pt/3aVhIGN8hb4dQ1nHNyzIYqGVqjUoCcCc0f2tYC8FTLqwYKZKpO2xEFpfedkT0tNSd3dGK7dwajAJGILKU2uUCBGunumVJySgcJYcRC2LZApLuXNolJQ+p3dvoYw4bi29vUu9VXYzZIIE2fkZUBBE8C+hh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7364.eurprd04.prod.outlook.com (2603:10a6:20b:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 00:58:33 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 3 May 2022
 00:58:33 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v10 3/9] dmaengine: dw-edma: Change rg_region to reg_base in struct dw_edma_chip
Date:   Mon,  2 May 2022 19:57:55 -0500
Message-Id: <20220503005801.1714345-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503005801.1714345-1-Frank.Li@nxp.com>
References: <20220503005801.1714345-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e031379-5fe3-4cdd-a80e-08da2ca00bb3
X-MS-TrafficTypeDiagnostic: AM8PR04MB7364:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB7364CC4EAE1CE858A91BE89E88C09@AM8PR04MB7364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JazDPE6XY0q+RjmI64WUgAXm9zegB7ZsvhS1V8frzn/pZNScy+7RG6LZks45GW1X+iB/ppTSfUWH0tb1L13XCZdnwewD6dyg8rsa21+iz9W4YhliaUQDNt+zQQWTlDQJb0kWAfI4YbNmxYgg/y7OXsYTELSjAWjD0o9bN24emN1k7Cyq+lZJgXI1iW4t2/U1ecLe/eNdw+U0rPCQSGoaGAvR2cOxK7KYAwRVDHdLjxvciQiFGLNAG9zi7YAefuItZg7NwPPYYUa79x+/ArytU50dh9hWQxiSBZxqiLDxMZjXKK3+8Cowr6Ax22EvzjpZ4bI5gTDo0JZNEXJvHBLoQI0fiHDAn05iIgkbbm81gFdr4+Ar3TIPZFlrQLlA7wQCIA5islYsJlwJmGvkTzhfiYHaisD/E/zxi7PCYlE+b/WESPN+2KpH9wlwNK4cGZUmNnfl3Zq9B6ZoPk9JKYRo73m5dq95ej5d/HCZZhBRYBzcwsbOWc2SKsNa0M93GZGOWMx8C2GhSTJP5CfkWoI3m5IHvV3TVBsTKYWy3gjrcc42z6iNA1SII62uoL7ujyfldbcHN/9gFohagXfXaxAaDZ8+Ep2xH5fY/zng7+RueE6sOFVemyPHhjSc/eBD9iu/yS0146rP4YQJqRPO2c0Khxax4UIA47R94NYzPpHNYlxr3OU+dz8K2yradF0T4omdZPgszeKWg3awzE/25L5/Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66946007)(4326008)(2906002)(36756003)(66476007)(6512007)(6666004)(316002)(6506007)(26005)(83380400001)(1076003)(86362001)(186003)(38100700002)(7416002)(8936002)(38350700002)(508600001)(5660300002)(2616005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/mG+LxPSuMaJbEk+6dUFiNB9lg0kKm6LVw5ykbDzdrvz7wPdOLIZNErSQvcH?=
 =?us-ascii?Q?rr3dKOWPFbCXjRJN7257Bn0tZw3uyTSn27MJSrMY8hOvVVCoU3TDd9AhSqep?=
 =?us-ascii?Q?u+t8cJkrRNRAtk08XT+CiiKSIAcOIFrj4+je20/LCqhHfDOVkc2di7l9dSQc?=
 =?us-ascii?Q?Iejv+tXlctONSKMzK6E7hxR6Dhez0kMD+9/qwt5QQmCDJm5/ebpKh6GlWh7d?=
 =?us-ascii?Q?T39L4dn3ycPwo9nM1BmE1C3EJY3/L4scChDmylhYypNSbP9sZUzF+u/6s3gG?=
 =?us-ascii?Q?taCq6H9AdH9g278pYTE7aqonYI4+8qu57qLCjy199nZIrNqH9k1YbyyaykDE?=
 =?us-ascii?Q?sk8lzbEt2Z56BrOzkCjIHnbF+zsiilPAr/3Ri3z9rcay4Xox69RwqLmBfHap?=
 =?us-ascii?Q?C4U69gH/zFqK5+wjZQ+VnDGuPNuuCM7DjYWpGID0SClT5OUkPVVZrtjuxkNM?=
 =?us-ascii?Q?IzM8ZGO2wtE47/wA1CFd57D/0XjDwCKOPkZch3qWiV4NgnJqGNxwUkF/utTe?=
 =?us-ascii?Q?vlrFA+ixugbe9n/2VUcH2xQRUoepAXrPiJV/JYMJU+4qBK3Klsb1VPijGilR?=
 =?us-ascii?Q?9Ul1VKx9QjQ+T3oW2/vvyDpJT8NpLYjxmpPwnqziz9PPNG/zixv0l4r5wDcw?=
 =?us-ascii?Q?40y/MuZ3ZqZxzp/Xd/P/8TMzs8Fhsnk4pL9bGA4yIBlrgDdeqeUnPnUO4Bzq?=
 =?us-ascii?Q?1FkPhfvGHVxGG5jnrxly7HtvS6DxcjFZySgRzXlV86LARqyfJqHn4GBtgXL7?=
 =?us-ascii?Q?T3RCH0H+yUxVfStOJ79uncBdupA0JNSf7u7DVdVaBb8dOIY0UJ5UtS+zrX6p?=
 =?us-ascii?Q?pegrBRqfijijsXw6caaPxVxNmmTNs3whd4obpL0jOkIcAZsmGV+/EaAB6jMf?=
 =?us-ascii?Q?p10z7UuPF2tgRlF4COnbRG0HblDpPrEakAOEkhVRAkCvAxD8dHKURhpfNDtp?=
 =?us-ascii?Q?OlfiDaEjw/TOatHX4WrNaDrE/1mTIerSo6kGezsUa7Em1DbFldSxuAJpdlFP?=
 =?us-ascii?Q?kgdGov+Fxfd2gLBehKNLLNKlKsY+OIvV9Z8VllqSYPV8Udzif57tnaoKGUur?=
 =?us-ascii?Q?TE3eFYkNpfamn69dCcPmwLhAZgdvmPKBCbNx/sHp11/gzzCjNjurlseSthD1?=
 =?us-ascii?Q?+nGcknw1kHVqwSly6pkN8fwBNe+ZA042JXMY1LGwOMIVI1MI9sxVnfmES2Ez?=
 =?us-ascii?Q?FafcnOy2s5ycrHEd4wZxEEFven10BSnkElhHp69NoRJ9RAaGItDSJaAH+VMD?=
 =?us-ascii?Q?IVh+dAUlii6JeHVo5mvr6dtuVWehdX8rUY6+jJQsmB1S+pO95zut9oma4ann?=
 =?us-ascii?Q?OiLgHnYM4ClcfOA43hg47k66YqvKwAhvOVXB4fc02/Bn1MH0GBnHk4xsepKL?=
 =?us-ascii?Q?FPPdrU6wCyatGpDDNEdpMAkS3xbmxrlRTIQPjyUge3Evu5hmj8YqjmIIhmuG?=
 =?us-ascii?Q?CWqykM+hqrmOaBbd6PMl4euPm/Ek2ZIY82SIqrYKRL6cLoL8mXJa64PkqU0T?=
 =?us-ascii?Q?kaoNLbbtUP5a7tcliLgUulfyNTSpu6ga77d3b50TjOfczF1pq04cwwuWOC+u?=
 =?us-ascii?Q?3P9o5QQqUoz3Xa4g0zV3y19N5sXv4FmK8ea5PjraeRvBEmOQegdns8+21nE+?=
 =?us-ascii?Q?SYs1HBD6BN84LD1JG4hPr6H5L97VkO3XclO2XcyiWF4t4BpOr7puIxi11/Gr?=
 =?us-ascii?Q?QmknjjqfmnlGFeq+qZXDXzlubvCcR788OdMFTTnXGA9JEH1/i7oMLwFrj2+D?=
 =?us-ascii?Q?N3qJWcxIRA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e031379-5fe3-4cdd-a80e-08da2ca00bb3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:58:33.0777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqPO+CVNrT8Uwir3xb04TnS+xmM2M3WSnNwlxm3Mf9jHs8Lu720ZwtDdyK36jIWqiSNmu/Z+8AwQJ+4Xu6zoiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7364
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
---
Change from v6 to v10:
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
index 6cf6c28ce0cc9..c59e23b9f9fdb 100644
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

