Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14A501F37
	for <lists+dmaengine@lfdr.de>; Fri, 15 Apr 2022 01:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347714AbiDNXkL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 19:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbiDNXkJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 19:40:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60055.outbound.protection.outlook.com [40.107.6.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7077EBB922;
        Thu, 14 Apr 2022 16:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkJBvdGlOkUEI/7n7xbQwxKBAg9Obzi8H3CAR2H9ysbzDKMe2qDfN+lqtP0csOIEfSzsJxdG74RFIjz1ZyWCi5M9n439ppdV4uGueh6/t77AVZ7mbDWnNuggrg1G4LRY9lKb/qwlrdLseqsy5VX1EYZadsQMl0YLlagsy6IZajvRRdPUnFUU6LFDu3hb6Apo1oMU4KCly8H9G9c3SMB9aWxd6Hy9q/GIUDpuurylQz866r9eKckxWMVYAUVYwnKwQsGxo+Tp+/llbErlQ9Lnmcm0Zax6jDSCGKU6zKO/yGDh+Gk1i3wm9t4Pra8lovQMdrRZ36giKbxyMgMgRG3DYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2CyGTQBABSv/msMfywsSjN7c+y46Hjdw6vr2il8tos=;
 b=Knmhkr5VYpxCnENVElstSQh7aQZnNTc1Dzr4HZqVC1MfU1bsVDLnEnhPbHELmLepdpBS3jgx6PcCsaugLiizbowVvx7HRCgNmgxbuKVH8ueZCSAWlFw26JnQPxK0TaZIzjQ7uwplB6e51VZzBOlAGPBj4WSjBqbyVZNuawNHBN1r90WYI6BSmoIHegE3eDx5BP/FjwEaeYSkVHKFvezzEAbBZqDAOdtK0vucVH1GNU7pGg+TkOElNZ90a0H7TDLN66hYz+2wStsEZqnEvLkgMnn2Xq6XsWgJH4LsQ0rNWcK+jiny5xa1eQgahvLzv2XCQjSYCJ/O4o9CpC5tq29yTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2CyGTQBABSv/msMfywsSjN7c+y46Hjdw6vr2il8tos=;
 b=WZMZeRejXVn7zE2JtM5QeDKs56jm6TwOYZ7czs7W2GZEOyr5LESr37dfjqzYQCVvxKoJZeLHX33KhTsJZv771uUqaOZI++1tHuSUzlvQwgICWVYC57ec4jdANsrHZIgyQmsxPbMjUrvUZVnbajoIHP2CPHlNgNJG1ARq9b+ONnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:37:42 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 23:37:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v7 3/9] dmaengine: dw-edma: Change rg_region to reg_base in struct dw_edma_chip
Date:   Thu, 14 Apr 2022 18:37:03 -0500
Message-Id: <20220414233709.412275-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 49ca8efd-b65a-4123-9ef8-08da1e6fc4dc
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB604385C203BF8AE7DD76B07188EF9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCy/4cGye5gGy2mZY82IB4jOlmgUkviffz2Ii3w8bBm9NzOBiICufVIr1b48J1fiObc/I0iEwuci6BvD6gkq2WRu3qRS9Nlyafz6ibHyALg9Lns6ZlBk3g8RsatkRtX0b6DUjXVZqqcpoB5qkyvzBzrFS94QzMdyequA4dDY0RpOTSI0DqUdz5yZamC2h8F8LADa4HOxAqPnVPnBMKxhpIoeKnPYTFIjkaQHfeL7d6Y4gugiDIUZjKYSn3jw6He6GtreL1jmLkaa5mrdwNKLoFEDRIov4YDfinTmnyQFUUkZXEVwZHdtV8/H8H6bfK73gAvCKz9uvjEMjrTItHO+FX6/gE4lT692ailGev8WkGEbP6KG0bPjG1ZTqvE2EwlrgutQSxjBJRRKduh5uuswfAwPVjAemdP7m1DeXk9GAPKBBOHn6fkbsV3BDmIux4sujj9TPyVYywMvnCC22Fo3FxUFfpVMRmUSho6VTqKcvSW5hliox+9Z4UHluOwgJq5mKkvLHTzoUo2q79dQxApr8iOK4Oaa2rKwGBKjgi9k9QPrs55preQ92y3CYRIl2AWiYNTJ7Gd3aDmZA8Z4VML12MaThjYPReWGw/4+10v4sT8lPfzuKawj+KltiFXSffUEIHf1dW7D78pOIrtN4PM/eBCG8enQVGSTM44MROF76Y/CmTj2iYgwb40KdK1CPCLggxSTUw6y0H84BdpXCJnsEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(8936002)(38350700002)(83380400001)(36756003)(38100700002)(508600001)(6486002)(2906002)(6512007)(6666004)(4326008)(8676002)(186003)(316002)(86362001)(7416002)(1076003)(52116002)(66556008)(26005)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?31og2JdJIOEU88Mi+/tOADVUo6dzAEVghY/dFKbcsJkfiT6ziTXvKCKCQkRc?=
 =?us-ascii?Q?WcueJwHBjGWAjCFaX2d3lgYv8UD7dIjXJzoO5eXeDA8BbXM1Ssx7tuIUoTDp?=
 =?us-ascii?Q?jByXy+jqAizUD75SXjIztghHxDXxQaObl6tcLz3OIQusVvUEvdFOCkqURSx5?=
 =?us-ascii?Q?1YaE7NVz/4Fl8nN+j9zJIzQftot74HrOd3lIpzH/wXSEjtUYvPSJ7q40nqP7?=
 =?us-ascii?Q?F7ts6dNLJgaOcuXfIQ9zgsYSt1E0LKT6sr70MrsQ95khfiB0uEAP4JzRAqBE?=
 =?us-ascii?Q?FLwhhyBOtUP871ccTJ2v837U81YPF9NWGf9nLJJqOsZXtHtkmRL8qW2wKZ6g?=
 =?us-ascii?Q?xEDRlNkBRareDWw7r5dyQKJzuxWC2adVrGCewZpHQWcSRoLabNOlcXHB+aBk?=
 =?us-ascii?Q?X4rKro8GdKcjc3GEUY2IwuVMM3qh1a+w9NK619lY2ysY7anCutYYTLKQVtYa?=
 =?us-ascii?Q?GDqZkn3J4JOA5B+H9WuSfPCCG6bDWkPZG5kPQB0h6QjxvnuDIkqH0E9TnJOY?=
 =?us-ascii?Q?F7lFbg953HBY61bEOT33fLt5ipI0HOmfilpNiesiMb8tlBev6XpXSZQVAJJU?=
 =?us-ascii?Q?BmA7vjCw33fwOCRRwvTOavsnj0145658VmY7Z94h5lFRmwswdtAqao2iymif?=
 =?us-ascii?Q?0DZhqw4qSSUo1105FUA5JQZtc6Q2uuGzN8wGZfIrAgSQPkARqdZ9PMBaPHYE?=
 =?us-ascii?Q?G3IP64PUMN9wtYkn7cPdsm6t+jIEOj7FtGI0QK1GWLKVgpKLJySR9pNegsAT?=
 =?us-ascii?Q?j+zemtuj3KaKtDLFyo83layOx5LXWrkiDtOYM2dqxP9ggkpCHIG1D75iLN09?=
 =?us-ascii?Q?FVZBASgnnDD9+6VZeuNberMyna7ouT5R33R4j9iNWF3G5hYlVdg/IEWOpPmp?=
 =?us-ascii?Q?gGrSpNz75k12XZa/q5qM9d91OH1ZS74DW0Lb4G1nL1I5QdIsCXgB2DtajnPw?=
 =?us-ascii?Q?PMxhEYyhKAbBRqLhi4UAZa8svuTLFU6V5nIxwI3gOWsWzOQGY9aUWvee6DCS?=
 =?us-ascii?Q?w7KJZ/cUjXovwMmGcnsk9lHz+X5ljg6gNSQ5nj/yaYLs2P2yMWReJRdCHwL1?=
 =?us-ascii?Q?QSZbvboi2WPaiwnsbFZbxhk0rEooAv7n0QPxzoasKxB4bomed5T0OfzBjxNU?=
 =?us-ascii?Q?63fKyoKF+5FUxLQ2sj6rtYYh1/NnFvciGk8UUZ989lB+rP/DRahkaSavWfHj?=
 =?us-ascii?Q?OHANz4ufMh1Z4p8jPQXbw3avJE/JVY34WDAIKQsqyxugfuWRzy8I2uylYmxJ?=
 =?us-ascii?Q?/1Iw9PA8kZJn+6FD1if4EReZ7ulkob2X6fHTVxsA5dKRum4pwTh4pO7yoIIG?=
 =?us-ascii?Q?G0UdBXtAomEDsJsb2iDM61RivJotWRMwjLLiUITTvnw8ZG3gzjAN5w6tFcU0?=
 =?us-ascii?Q?Xw2vu5KxOFPINyaiKSMFBmWOT/Aw6bB6wDNKPStmTja4WDjvopiWyqKT7lyJ?=
 =?us-ascii?Q?fLJ0g6ZcjO+N0GDufQB02ywMeRJUNcRlkuGh/+dYBSh4X0tn2BQkSwN2COmf?=
 =?us-ascii?Q?zZ63yItNmSrApPWyPFvarLbqrZ0+WUSHQq5TxlR/jkNBlWrKFzPnmDVeJWe2?=
 =?us-ascii?Q?faC9O+YDVqtsx4as+tvztscGsCXjMA1My/Nf4DiO0vWy8x9YX/xb0BxHuSjG?=
 =?us-ascii?Q?Sv4+JM4mJJTTHrAapE/o5c012Ghr4IBjxteYmoLwLvDX+0wNI4VjMarj8aec?=
 =?us-ascii?Q?mianLAa3gdTZqYFLlkDM0s21YaomTEdQmgCC7vESuTgzx4ZrG4+TZb6QLwRR?=
 =?us-ascii?Q?sSZPxjuS5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ca8efd-b65a-4123-9ef8-08da1e6fc4dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:37:42.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQqxvh2qencUrdZddWHAjkF6bfuJR6Fe85hQYEi25GB2Rn5TBoKFWJAufk4lxZtONOwzN53uS0WdlhPgOaMtHw==
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

struct dw_edma_region rg_region included virtual address, physical
address and size informaiton. But only virtual address is used by EDMA
driver. Change it to void __iomem *reg_base to clean up code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v6 to v7:
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
index 082049d53ca73..8ddc537d11fd6 100644
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
2.35.1

