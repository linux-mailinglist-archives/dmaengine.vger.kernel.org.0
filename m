Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5787D50A2F7
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 16:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348009AbiDUOrs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389614AbiDUOrZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 10:47:25 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5A4427F5;
        Thu, 21 Apr 2022 07:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXFkdcWmi1F6PeeWhKqe1clP9CxSc4PANLOL2VwACBOd70gSCvlAXIqiwiFdKtQPeloW6YmJ7PTi+0OLnHySOm+6Fc+JRWESs4REwUFz6MCHjT8Y/7o8+DLSpXMZkI8ZikWofgfOo+AGSIPANPQ1Q02qhs2KElbY0f6EZyLmUrHbpR0bYAD1Sp7MYCFlSnyshyHpS6FANHw8zunWFTBCDMrNEqaehpQDPUlUDk1ivPoxoeIPuoDOAKZEY/KRb5vGhhACuaYjouo2BFrKrUcAy40qugrK2dcxGoQCkBmrDDyjxnLSRDNd6shbmKJ6KiXjxU933F6qwAVz6q32hyvqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0JgMx0wytWoHxVoQUBFYj0wEe5jDMgWqsPp46aLqFU=;
 b=i4t9jnTnFdOx1dwXLA2pudNBdBF52jYTrq4eY1+Wt8tWvac7yCf+zPrUXV+JUKBcryibtIEnmfP0IkYC24GPFb1FGD1z8vB0QQ1Sf5McOHHbzg00Hu8CwOKfopsd0bEKE+jJ8f2ohUTsU9GPEnuxqRWcSm8IKXetmWZ1tM3EwzENhVZYCpNzqSPjCmobg5XswIk1iHmYRyH6czt53n+moGsyxYkc5NWkelxcbNOc52Vtjtx9ZdV34FvYD9dnQyswav/XZ+m3nlzoHbRnp5DJDfAGIMfUTEezrGxNZUBEbhdGRmLZAo4jIOJzCmnvy05h5y4jQJq59dRWG3yD9zeAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0JgMx0wytWoHxVoQUBFYj0wEe5jDMgWqsPp46aLqFU=;
 b=h5CPQvFFvQZ/cc775WrZ0fgJAAMdxTGrZtirrvWgiTNoiU8keRs1Shlf9xgS5jNBVCRjlidGp/rZz4o2PCiwqljIBYpWgFNqcuC+LFsEhAox+/Q2DsgozrsZ0afwDk5ZyF6c1GkEKL1dmE6BFAqCEZFzmamuVojuuJOK729DUEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:44:27 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:44:26 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v8 3/9] dmaengine: dw-edma: Change rg_region to reg_base in struct dw_edma_chip
Date:   Thu, 21 Apr 2022 09:43:43 -0500
Message-Id: <20220421144349.690115-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f9b72c4b-5c5f-4b90-d85f-08da23a56f19
X-MS-TrafficTypeDiagnostic: AS8PR04MB8689:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB868914767D9D2F1DA5B4D11F88F49@AS8PR04MB8689.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7flz0SHw9Ftju7GHox5gl2TkgBIZIkMqu30pK+iJKq8uCa5djO185KTt29up/TdiWJWbbVnhdugm5LKN51Vkka0ccSGCBjIg+YXQRt23Rz81+wzOpcnS3/j2RTMkvu8LJIeSmqyXuC5ryXJvzk5XF+KenyuB8l/Vsf5ARHpBN+hBA7INwIFZe3N9C0BKCzXptXpQ7xIDzAZG3JS4ZKEeqzc37naGE2U6/zCOqygEkZp3WuJieA7q00q85zEeF65vEExec3iMfof+Aqw0Ere/+8sNvqnNPvm8KI105ktMcynmPTU4K07QXDBErh2f37b9DQlt61CuuTHUDm9uccINm5eohVPcxucohKKPyk/T04YxEAepLLkQa8LKsJQOOM0CYpGU1jQNUyDrK/IZett53tMMUTWDRzghS1w/wA3oUvKKLLPBzZ00s4p9AfVvTe4IvQ3j11yrGUilofiK8GBH9RL5ncjpNSgGMl9z+tZRt2f3qgJcq4ciemDRlGC7hCUDyIcGjRMIISRO+FVzGeGvHrTiHHXTvlfffFlT+V0QWr7VLjorAgvJuwtdsLwxX3ooV042O7uFYGpnFhkC07/ftjfu6MoUPB3IuVVhYwpeEFsLjpioreiOn7bJOInHDbdNxCpXez5j2uEn4Z5y931vBogBSMh06kqQzwoo+GUWkpOHk0sw7mm6Rhv/g6tJ/N6UhkayM/4fj6m1nHdNqXQzwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(6512007)(508600001)(4326008)(316002)(26005)(66556008)(8676002)(52116002)(6666004)(6506007)(6486002)(83380400001)(86362001)(38350700002)(38100700002)(186003)(8936002)(2906002)(2616005)(7416002)(36756003)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cGu4zZfnKgjnv78k6/hJJzDTfzRr3M8YaPxPWLD8yW1TiwBEYUDRHFwVrVk6?=
 =?us-ascii?Q?nPbBv4k7Y2izVsKzsHiaY7BqA2+LispSXt20etDeMMfadU3sVvsPzJ+UgVxM?=
 =?us-ascii?Q?KCuiXKa+X6fnzRG00wTK8GoOXZc7oViPYLD5bXMGzru0YmGG7s4wN1wdALTO?=
 =?us-ascii?Q?AxpoSs25716OToAAPj3kPQpb7EDu6r3/OOSsYVehlYsY1iTqd/xzkYbSq6y0?=
 =?us-ascii?Q?67eA5Bq4z6f1W9/tpSvFfTn2VBqW7k7D9CXJPYRMR2KUPR1NjW6buKWUuGKT?=
 =?us-ascii?Q?D99HMXozfs+dnRS6cnDQW2P6RniM3xtGMc3ybXSf+pas2OsosVQErXDnoZwI?=
 =?us-ascii?Q?krVZgOD+9NcfpJiSwe2I2FppbxKwhMoBG7PhfSzoWDY0oev0lwc1Rp1ld5wt?=
 =?us-ascii?Q?ACkGSQNWkpm0MyKLz7TAY2Y5MhiXVYKvPiIJJvgat2A0Pnn+dgE2vJAsVehF?=
 =?us-ascii?Q?/Ug0OjuUcp2+t0JjEIpMzoeterYdaBgDdvKwbsDULREUYV/HCMP+AvTTJBAs?=
 =?us-ascii?Q?s2VpfEX5iu05uVL84Je9rZk3yd384/BcyXaCwpjBpkDDFJ3EsesIUp0rQHiV?=
 =?us-ascii?Q?IeqPEyN/hVmqu0juXyJQYj+h4MvmwmkA+0MEp3r1qcU34lLmW1tt2VyBTlbz?=
 =?us-ascii?Q?PMEP4PCsT+f3v67ldrzzL4lN0aALG92sbVfXS2sOPh5uYXkiFbvrQ1Q22hYd?=
 =?us-ascii?Q?n+H9/isXvOzB4aUVAxKh/L11qB+HBPwqOacFP46BQ1kIGITFAMD8XNm6mq1/?=
 =?us-ascii?Q?KhNxBfxtB4OYT8DusBiSwZjJ7WeQVV94aMxtATYAiVDqDkqna0KaNd3KdtJq?=
 =?us-ascii?Q?rIchuIFuBceWtBP5RvfutN5wrtjlYJUFVeWQe/z3zFBSBCxUQV/ZUuSOFAWm?=
 =?us-ascii?Q?NmDN1whsWpjrGN1M2FQz1in/mH1zTWPwkbO5BB3p7vxJWh8W1rzT5+rbSbeu?=
 =?us-ascii?Q?I3VMYOaHJVppLsEV7teUm9TP6AqbgtbZnEITKtVzrEE0iSGwum4arWP+11Iz?=
 =?us-ascii?Q?JAq9OWOQuEnf9FQANY2T2gSO5yYfCeZFap2u7Vfrq2ZvfgVS7HJZ5d8DW92i?=
 =?us-ascii?Q?F+1NrMIiG15pmKiYnvrkgr9F1S8QKziXuE6l0EoCw8Wu7iqnGA9/NxC+8r3/?=
 =?us-ascii?Q?KlRc2P+pOOeHJWihQ1A5i275klmIOEnQDSZlB+2/LOUDi+1EU18CnKzIT1AC?=
 =?us-ascii?Q?BiaeeqDj3g3jLOoItq3HO3tjPkbC7oAzlWCBcv4ASEktm4qE/PQjCq9Jz/WT?=
 =?us-ascii?Q?GfiPk3TPkppPG2NZA9Ayu7gJp2Ri+/pPmKos8/0Dh5VpayOwZaKI4e9qJ7Dm?=
 =?us-ascii?Q?nlc+7HsE5dmvx0ObwD5YNyMfenau7jvgDNJky2kFVbgoqn/qz5VWqYvcpi5J?=
 =?us-ascii?Q?+++iEwQsOkZcR9nfUTJwEAsabpQu9WdZSMIEktxVVMFGFaNymaUaVzq/KryU?=
 =?us-ascii?Q?sC7kL96CvAUSeAzdogD3gjpoLX3kFRGBFvlwYtdR4ayB0AfPFX6HNafWEPe5?=
 =?us-ascii?Q?tNxXT9aCszEnz6d1W5oFrfvVmY48yyRerSRu/7NVKaUd8o5TlEkHHOKlQhbZ?=
 =?us-ascii?Q?X++i9zCc4IOOXlyt5/l30XMGWDDdHBijkkvuQGeAoNrwrYznvmNknbTrOt/0?=
 =?us-ascii?Q?+J/MNRJ0LRfmjsTdFYmgJDV/H/pyCiCPs+8oxNciU6TsU4BKRhIdDDSMgGx1?=
 =?us-ascii?Q?ju9+87Cti9KzTYo3cUqrgkhknUcA/ykxAh3zaPhfgc3KVjunoEEjO6pNFJ2v?=
 =?us-ascii?Q?MGoe+W/Zwg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b72c4b-5c5f-4b90-d85f-08da23a56f19
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:44:26.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZWP1UUSuZcLbHIqKMqI11wlmjOF2Eh0cpFC4k98AHHmoroWV8mf8ph8NfttzfB+NGLesmxvScncMUTzc1PBmA==
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

struct dw_edma_region rg_region included virtual address, physical
address and size informaiton. But only virtual address is used by EDMA
driver. Change it to void __iomem *reg_base to clean up code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v6 to v8:
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
index da88958399a95..f59e7c37feac3 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -287,7 +287,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma *dw)
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

