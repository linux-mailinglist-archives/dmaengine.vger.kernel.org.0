Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ED4517B74
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 03:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiECBMH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 21:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiECBMF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 21:12:05 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140073.outbound.protection.outlook.com [40.107.14.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C9832ECA;
        Mon,  2 May 2022 18:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REnwMZ7EQ6JKU8TwLyyUnSYdy7hyPjrVj1oJ7TqHhOEemozurqyYyDzTPDA+45Ks37qPvglzN71sJMt+U6jhYhtEtI+MQYieWdyibgOyM4W2rPgFXi0LtcIrUlDl7vTLaPGvnDqUNRk+C44o4A4u8bCs2MiExYXaTcO8bYlsDFO5AM6v5FJEfNoVtWtz5wz48lMXY/L+nFVe3LZb61PcLqqk/S95k8YTXX3SA2OqEADfhCBzWZaiHuXpQTTV/Clqy/rx+fd3sWxzeb2ElWlN7kJOR6jhzG28OshO067Kc0tePhf8AQzU7KAfzZpjphkKd5uMPs5S5jyeLJD+PNdvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N00VfS3Rx7hMWskB9IVckqm5cGfaKk6zx6S1bHHsJVI=;
 b=VFGdOGKrr0melfmTx+dsqGDp3Bn9V4ILq+WYcjiY1ZNB2HLrCailW9PtNAjCMxv3+zg+nJS6Ng2x+Ckgl0POu8WbUHpiQQLyCfz3yxCZHFfwO74TqU2kh+v7KO04Waezc0J/wx82xohiYgijP5+3Hxag4EAm9HFRzouBGWtaj+USbyoekSztFpPrFhVW1txunbAnDQ/dt3J9ZETMF3LDygzQjM4BpQn9+nBszuw70JINWRQMBxDt+BJ6lFBtybdIUnTYqirL6PQSWMUlQLuOQNRq3gfzwt3XWc1gBI9dZL12JpPG9MMF6hLqQDIpR2/uhF7kdl+gDX4k/9LeujJG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N00VfS3Rx7hMWskB9IVckqm5cGfaKk6zx6S1bHHsJVI=;
 b=CFZNMQqzIf/B7NW0tg3uJ+Xwb8mhjI+cbma+72UwoAsGfIgdN+ZEnAsPqAw154b50TvU4S6p0T0eXAY2WdF7RNIjWS0n7lQacMD6sRYlkK8ZHMnhuishF9X1pEy/HV7/t+rJsaVC2OQ4/4ze9HUMTtUHf4NgdU2DmDjMDwU9IXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7364.eurprd04.prod.outlook.com (2603:10a6:20b:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 00:58:37 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 3 May 2022
 00:58:37 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v10 4/9] dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct dw_edma_chip
Date:   Mon,  2 May 2022 19:57:56 -0500
Message-Id: <20220503005801.1714345-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1444a44f-24cf-4a1a-2656-08da2ca00e03
X-MS-TrafficTypeDiagnostic: AM8PR04MB7364:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB7364ED91AD8E92D8FF4FC17188C09@AM8PR04MB7364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZJ9hThrbOFnMQ6OBF/KC0GcEMO36QV9Wk6mhkSw8yEM8lYqMcPiJKdwX7+L3NJpoUKtrZGjHBKScb2YzKDjDgJkwweK0/LIbBiG2VE+z5Q7SfxIzKw9QmysdB+lcOQnGZs3L/e2UMPKi/uyHjmtgvrq+paZA2sKQ0e4u7b45ZXP3lY8j3UzUleXLhwQgdBh1tXGc+PqeZajm8j2FfOfktewJ21mJGOWcvqZTYyAreoCoXYAT2xvDH9xWdcRnwOH5o4L+KAfTBC8HDlBQZ0DbNQCrLudawmqzZb4UFgM6X5d0SzRzRN/djFQysT7p5uU6+4BkZ48jWq0o2ufPlZcQPG2WCp6xjtM9p7ScDLH8IHObUjl8Q6OGK/7tiK199D6t/aZGvLpgkwuJNxTeCv7Mj6y6MyAQHRNfAnp0McAZBDj6W8Jc8l9wSgtPF+XkJ/5PkevnR9CBlvSrG6u48B0M6cAO6Xn4Q+lqdCuB0gBSxGwKThcOOAFnFcbDLrs7o7GKrMJZWzgVVpxzGfKR0pVTXyjid+5zxzuHqdPQzO2ZzNAIeMuVzMOFc7j0OYdaQD5zqBQIBcT/H9maAinnvdUrqEdDY073RpIm9m0Jgo948i3khzXy+jRJrfFROU7nTEhZg8z8smSj7HHIDHXRqwh+/XG2wx05dMrG+SIke6IUARAOArLlCCChBFU0yhGZv2Rizp5aWDDzzsRSbqT9s/pTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66946007)(4326008)(2906002)(36756003)(66476007)(6512007)(6666004)(316002)(6506007)(26005)(83380400001)(1076003)(86362001)(186003)(38100700002)(7416002)(8936002)(38350700002)(508600001)(5660300002)(2616005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rypXVGmlf8l0N09VuEC5ESn3z8x3CO58mIWMScmYndZv4SWb7D74BeeWX3Px?=
 =?us-ascii?Q?WA5tJ1GuuSzJNSjfHItekkxotmOOGlk4JLTlHaOgZZ6TdSxuIrx4SFEWzVpL?=
 =?us-ascii?Q?X9mI1FUYsn12+KpyW5jE0rwG84Io3LOsipVSyIW+ZRnKdxWGbzlGg8THUKts?=
 =?us-ascii?Q?gLnou3kRwG259AEcGXpXutY1WRtKhRCgRAkoLUfBMT6sl3Gbry8nzoQ99lSc?=
 =?us-ascii?Q?Q1gqOXFcKvZNdJpeGLepFyblTuJemEhXqs70QG5tTeCUIlhAu1iTDAtvdGib?=
 =?us-ascii?Q?3Xqm/Lc0Md7vD/n6CGvns+Jg2so658t9SKgZ4sXZiT/PiDCxMn3Rprv1sm7I?=
 =?us-ascii?Q?sTBR0/1pkRKTQmTr7X9vbSaU3h2/JS1YAYLL/XdascEwOL2Az9lHLF3bzvVJ?=
 =?us-ascii?Q?2KoQQTm7hdahlDoqRrCuQXkiJQPcd918tb7Ct3b3KPiiJ7qcfU2SjtDvYiiX?=
 =?us-ascii?Q?RIAjvpQsMg29IUnwmfTbBdruVQNq9tu3y9mezCjhcCrCqLH/raTSpLkDKgAb?=
 =?us-ascii?Q?rsbdhaGDNBmtIxq2rmVjNdFNBL7B0tEt3L/ACY3R2hv3AZQqBkDUfGPJjMi1?=
 =?us-ascii?Q?5fbUAXqXwx+/ftsBqrie57TrGs+iu2PGkJnvPfNciFgB/fx/Xl747i9w2A6P?=
 =?us-ascii?Q?4Vy0291UrsXBzfqtN30yPjAzo6mQBfVGyUONbcATGDaag7LmfODF3Ei2+82k?=
 =?us-ascii?Q?zyAbCPR4p16jRPUH2N5UwmJjronHd6JuCUD86aL2i/xKRn9nhBcW5It3bRwW?=
 =?us-ascii?Q?ZXvSo4FqN3uSNKZI6aAGaumtlSJwnbNcbK81f8U5UwExMqeQAQjOp6SLZ7sy?=
 =?us-ascii?Q?IxYnoVDne84QChZwBn8bT3hutIKKvTzpMBMwqCqSdLW7cvPD2YP0PANu0aW6?=
 =?us-ascii?Q?YxrjH65NZ8WPeCsdVlIHbwl7DGTPGsF2J7N9wwTWVYn6sZvHVnk4X3KEqQjP?=
 =?us-ascii?Q?p8QW7sa+d7fHo7BcB0CZgYivdNGefO+TapaHgsoRcMD34VIFtMei3hV2bjes?=
 =?us-ascii?Q?bc591nhVXI4myMFCDFh+1xxO0altaMsWaCyZgU3c7OOUM5x/4QDDx5aHVBeT?=
 =?us-ascii?Q?TrBzXwj84ZMlU7muLHYSh0n1ww4QjRKeyE8SEb4HAfx5p6fOYqUAy4ndJerJ?=
 =?us-ascii?Q?JBrSvOtHeM7aGC/QcIGaUHnCbOfo1w2egesGylwoRLFHdDntq+Fl8um5Y4AA?=
 =?us-ascii?Q?YEavhlrzQulJLL0Hfln/wSdNloqvPwWhyG3yTYsJxHJioZTubjIQM5HXzZEh?=
 =?us-ascii?Q?gJkZGniMGmUxJz+RcHHe+E2M6Hpv2ykzSPnH25Z0OAo+whz69pzBEu0UKLzW?=
 =?us-ascii?Q?Fq92/yEM8+Ee5HPL5uRFwCDabFHPi+HRrAzJyWBbghaOqXre+tlWfsWuya9U?=
 =?us-ascii?Q?vYE9ezHKHQ7h4U5SjSxhtanfs513N2wZT7uNVSJ2ZfPJ1xN3NhDIdKk17eBU?=
 =?us-ascii?Q?JsuCVhL/1EajfaGhhVcyvxa7N1Gm1O++P2bwqL2Dt3EQq5BvRamFnB4o4lqR?=
 =?us-ascii?Q?vkYjj29YLKUrCq0w5euE88IhKRxet/s/Iq7ADt8/ZCeNb7PPJxocz53uBNSB?=
 =?us-ascii?Q?HUwNTTHKJH8KWXPdMIwpQEoll81XSq3l2tdQ7sP2+twV9NOsPf4zgoMUEs4F?=
 =?us-ascii?Q?iVYOeb1f8RSVXPqCYAxlzpr2BomlXecENFVVE5X83el2+pbHi0qRUcM8DEL2?=
 =?us-ascii?Q?am3InTdLnklX0MPe47DFxCjyyRvoOZ+kjSsDGwwF+qUA3cXgCTKaovTVOFKV?=
 =?us-ascii?Q?z8w+ULcKmg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1444a44f-24cf-4a1a-2656-08da2ca00e03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:58:36.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZ4PxYOFgnyeGqE610MJKaFSoxPW74NLaHKOVEZdtIjVCpkEkIYlBGhKJyAv4BqPD74xpFCiLOh/Tq+I0zK8nA==
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

There are same name wr(rd)_ch_cnt in struct dw_edma. EDMA driver get
write(read) channel number from register, then save these into dw_edma.
Old wr(rd)_ch_cnt in dw_edma_chip actuall means how many link list memory
are available in ll_region_wr(rd)[EDMA_MAX_WR_CH]. So rename it to
ll_wr(rd)_cnt to indicate actual usage.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v9 to v10
 - Change comment for ll_wr(rd)_cnt
Change from v6 to v9
 - none
Change from v5 to v6
 - s/rename/Rename/ at subject
new patch at v4

 drivers/dma/dw-edma/dw-edma-core.c |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
 include/linux/dma/edma.h           |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 58e91fe384282..1ef326f7151a3 100644
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
index 195ee1e47f21d..c8b479f1d4da7 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -40,8 +40,8 @@ enum dw_edma_map_format {
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
  * @reg_base		 DMA register base address
- * @wr_ch_cnt		 DMA write channel number
- * @rd_ch_cnt		 DMA read channel number
+ * @ll_wr_cnt		 DMA write link list count
+ * @ll_rd_cnt		 DMA read link list count
  * @rg_region		 DMA register region
  * @ll_region_wr	 DMA descriptor link list memory for write channel
  * @ll_region_rd	 DMA descriptor link list memory for read channel
@@ -58,8 +58,8 @@ struct dw_edma_chip {
 
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

