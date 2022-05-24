Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C00532D51
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 17:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbiEXPXG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbiEXPXC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 11:23:02 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867149D06A;
        Tue, 24 May 2022 08:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEeMpl71zRuehT8h6XD85RGj0ZX0QzFEA7YYkJj0xPHwXmhird3c/RPHQkmkdvBRYSeaySiseJVYOuoGGpRebBQu+f9y3I9TXZx7qTMHZh1O0hGOK2DUzCs689zynfRnr6/IHWRwOYLxB+up8vbgv36swlw3zO7fVh9twl5+rikdo3qYfGiGJMVJTcCCOpB+71zmUlD155Mp7dIblHpkrAX+0j5jAlpPsLN1xI5SxiL3/6oMF/whIh+aAJB3ub8LrkLzQikgg7LzqA/m73q6AGhpszX3GfUJg4aliAhkYDSWMjzOlA6vssW8ea+5CUYmu340DXPPlDiIS4m50hwJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qVnCoI7AHidEFTKprgXQD03f/PEuEsiRhs0/Lb2mZ0=;
 b=TZnTJ64KDA2tJL3XO+FLluOfR2/3l8K8ly9jlT8C0eO6PNIrQ4tX12iJadW3lXyzwWCn+e+/3LTeSPz6NjzEegEbKNmuyxHVRRF65DQ14L5wiJ8O+l31kiIk5QsyRAlfQSfUtlqON9iRqbhKaLQxGjJWEl77UFns2VuYAhYaq8ppi6GszD1FE8ow3WwSTOg2AriAQWavj5HEJ9/ailSUDTFFec6jODZqTFLlljDUvmbITvwia5tQs1GELMErSVrOVAn9atLOXNfQ2hjYPzajvHq6y/cqxu48DhzETO9qkPnOPgygPX7pZpEdBBOKYQmI2QcfD0HTOabzwi78MFDwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qVnCoI7AHidEFTKprgXQD03f/PEuEsiRhs0/Lb2mZ0=;
 b=bAn3zCUwrquCp22Ayy07NQIlqGpPGoL2lL43SOVTFKXFH2LqGQaKAqIr3evhJ5ojuSDqsrLdPCDX3BwXtAz/ptTYEokgYZ/w+e/BTR7Oa69xl+uWrMjCqS5xrvWn8pS3tZYnk8UMNH/WdtoXcpZLe1gTL3MVJR/58iF7GEYxnPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB5672.eurprd04.prod.outlook.com (2603:10a6:20b:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 15:22:31 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 15:22:31 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v12 3/8] dmaengine: dw-edma: Change rg_region to reg_base in struct dw_edma_chip
Date:   Tue, 24 May 2022 10:21:54 -0500
Message-Id: <20220524152159.2370739-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524152159.2370739-1-Frank.Li@nxp.com>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0976a3c-74c0-4a9e-0f56-08da3d993854
X-MS-TrafficTypeDiagnostic: AM6PR04MB5672:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5672D55D07A24449962CE72288D79@AM6PR04MB5672.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0x1LkMYjHEpRqLV9x5QmHzN7cdNddgs5fzOQ1TLtOyuExRbolPMGAxIXucRChuLIXIFaJ7iF5LT3OZ3S1EMzOdRwByB1zI7CTgxRHSrbEpNxegq8weCr4Ns2jOScUz5RRjeId5I9J1b/LYg3qXS3PFKYAlNvUkiVYELODXpCaN48idsudkeHtd39FN6929sN7ozeoef8+3mEhoJ38KQSr1I1RxTKVKjfKgjTHCaGyTCbF0sBtEuiMQg93yzUIh+VEoNDVdQW6TGCRb1MNLoHiTEUoMZIJeQ50DKbf+zIS6hgq83o30hdh6Ek+EivN/BJMf7n9L0hlHkO5DSneV9BRStdsqkwUWi6ur06hXhvU3v5fQDOszQ187pfugs+UmSYRJP1ypI/nAjLsSg133X90v52taVPzjjlWq2RkETORJR0LCKhn+w0rTz/E4TdIzzjWquYw2iog2yolBnwuaLK0io1KtwUL+f9vRD4yH3ZITQkHSftpjOs0QDn/9giJNIGYw+7Fe+4WGg+24NdTUjRqsH7nhaCfS9zOYjZZJkLmwo2Uag0cwtoTXU9nrx7gSHjRNsvkx1WznKvCjVp+RyUDEQZhhySAkhlcTymd+RG7N+kqNncRIQa/o6pIrZBq8Xw6wMETJ3RdkZT+xuUN7gNzbQyqX3lB6SMdOHogFg2WdxHm83UDEc82fCZ+UaOkqUPagLlSOwWCkAkVNPtp4sYQZy4aINbI3gMy9APIPdiAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(8676002)(7416002)(316002)(38100700002)(38350700002)(6506007)(6486002)(66556008)(26005)(66946007)(508600001)(8936002)(2906002)(5660300002)(186003)(4326008)(6512007)(921005)(1076003)(83380400001)(52116002)(2616005)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cgR1oha1nqkCV/CsIbiThc9u3x3r0RjM4tb5xvGT5nNUyUGobTDxLSL4sPET?=
 =?us-ascii?Q?0VLRmMuEavQvPUgRzYQVjieTfpj3tpOdHy/UsmF8Bg9J1MfjdAUu8QiATo6J?=
 =?us-ascii?Q?NysuI5wHoWIP+G7VlchTHY2gGb84PxBVwmDseunVrsbyd5tga67JGFbnRnkt?=
 =?us-ascii?Q?Ygt8cYVs8f0QaiTU3OzdOl+GE9IjXrMWDZdkb6Cl5Q58khF1iB+EkMnGwkTD?=
 =?us-ascii?Q?F9BUkicOtdI6IvtiOtek4TltmWD0WQH1HgRv0vFjy3aAhXjKl5Wv/QB6F0Sf?=
 =?us-ascii?Q?etNxWbBE8wsXhSs9hbynN3RLd1qfJegT8O30GoAHY/XMVEBnlxRHnHtGc87Q?=
 =?us-ascii?Q?Bdoqgo22wHLV742pVOYlt4vnQ10rOsCLdvvIMJwlM8J8H3D2T0GQQQZW8Rkk?=
 =?us-ascii?Q?aKGOCJ+9PP8ktMOWkscKapSmKRWs9lfBlgWxoqiSTJDcU69tkKX8+o1wSL9F?=
 =?us-ascii?Q?IKAvnOtcQXlqIBwmGWvFtiGvAbDnvF/uMVQkMWwpkjbVLQ9YsTHJsyinK5cH?=
 =?us-ascii?Q?y2+Hj1YSOSA4GuHKjMrloQsAAIwSYAlJNesqzdtOH2AU6r6cUQ3Iij/DpS9j?=
 =?us-ascii?Q?2FbzsqVqlHT97qQ1BRqVE3O4heCL2GEbeEZHvY9kF9iPGekSsNLVAmKCtIlF?=
 =?us-ascii?Q?ijCYTKTde5gZ1zksBaQeNqQhpMosYIPwTzVy/lFfYFIT0F257DL4Gh3Iacbr?=
 =?us-ascii?Q?4yjId8cgENQaVDQ5bO3xVSx1PqhRYp0nepQBeqzfQP+Ex56yR4/b9Uz1YULU?=
 =?us-ascii?Q?uAlUqQEOoJBnIIuyo7fNztrr4xnsCRfhAoHj1DAJN1bJ6C4FarmIovhmUYfz?=
 =?us-ascii?Q?ALI3b4EdG5JhTHCQ9cA9sJlASibr3clCKMPE72er8U6dWi/edwwfyx1jLN/N?=
 =?us-ascii?Q?JOh+YFMdj86GN7uBtCGYDGNTENhUfwZMElRzIoP4rrPYzAq9jV5bUceDuNsl?=
 =?us-ascii?Q?hqiRLWKB17gV456A8uEb8eD1YxPPX52L0z/6InQcRJ34lJXHTFkXp790u/TN?=
 =?us-ascii?Q?v0JqOv+c8/F9KAuYka+0ugCnLFXHDvldELvW85tyKu3Q6oL6++BqdqmRzCWF?=
 =?us-ascii?Q?6aU2FGCaKiv/EM6fBk9Wok76ht2i1tdD6CzrnuA7O2gE0IH8VnAzwXVHjqLV?=
 =?us-ascii?Q?wVl4zm7JdevidGf8TN2iYf7Y0zILnrtbv7zfUPkQ8Lf7eHqsE7uQ43xmSZ6V?=
 =?us-ascii?Q?Fx7SPYr8gQbW8gooP3HRkjbNDz2wIRLaJmZltKmd5BI7otzI+eoWlpgtUHF2?=
 =?us-ascii?Q?RkTcHL8r5Qo5J/GeHTLVol12kZcz0JcupdZxQYpftKKDROuAyAaNf7PpDD4Z?=
 =?us-ascii?Q?XkV5BSTMvxipsnNLK4xuNm5v6XQ65+FeT2wynaD7RBOFdAicCJovxYIbL30S?=
 =?us-ascii?Q?g4sm7Kr3RXyB1WCygoW6ifG0+QWrq3zc77EbvEkxi7LsQrOjZOTQ+sJghqB2?=
 =?us-ascii?Q?EUOB7qVa3icLP7y96Gm/PSJMQVyG9+oSba4q8KKnkGZW6lmaqhPikAS2Fgbd?=
 =?us-ascii?Q?AS2Mbu74i+lv9cD18A1aqIoSJSzyX0J2oBXeTGiSouQ0XGg1sSAno8gqjscp?=
 =?us-ascii?Q?ItRx0NTaCCpeNkKRvEAszSU9oC1RgAGQcgF9CsAOZDFsvj741bFGhg5TPUCZ?=
 =?us-ascii?Q?1FFQs68vC4VoJtXwzh0W35vEN9FmhWKEXAa1QfqFoUJ37Pyc0E7fCh1KrklO?=
 =?us-ascii?Q?43uppO7wHN7FZ1KzG+xiDhRLCY9INbuOXdXUqGsaEUoj/TAExRaCrSTQYGG4?=
 =?us-ascii?Q?NPaz6T6PMQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0976a3c-74c0-4a9e-0f56-08da3d993854
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:22:31.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNQIyA+usAsVCNbIRKjmVN4smg8N3Jn2FtSdALvoQ3yuJyhbLFSE12TV278MUJr+h4EtxQ/rIHPCNltV4yPPhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5672
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
Change from v6 to v12:
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

