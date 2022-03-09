Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B41E4D3BCE
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 22:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbiCIVNs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 16:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbiCIVNr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 16:13:47 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150082.outbound.protection.outlook.com [40.107.15.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76F42F3;
        Wed,  9 Mar 2022 13:12:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjnWcyEGmFUN3kwed19fP587Wk27i79KDOFZA0Vdwa5KSOZElAXdie6VpRlxrjjF3AQRUK9V+Q8d5oeTyV2Pw66JdTksdLIbUUgh6L9WQEZqgLgxFdw8URK/wKm7jYi19XNC3pCxr3WIwt+HlsHqv84yVAQEBe5CE6SpxRXqNUR2kfBDUzPPDdxXe0C1GPvnTBrueuxtHSFuOx0R5ZFRL4UaI5H5LiG3MXnOp0bUODpEZddvQmH1tLB7l7l2o3lmbTExBDwPqfNB9MIoOUwbCYu1+idWD0qwAqrmv0IOaONKT59BuN/gdRWvsBqppcpKVjktHgmzp6C6muguDgY7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fM+4qJD50tUEvuhkEVHv9xN/oCjiAUk/rMYm1Ro1gc=;
 b=nLv6F0OixG6LvjqgWqPyvupeEniD/rqHDydY4BdbaExP8mKGnQp+b+p9foOYVQlB1CUoR5PZirNoUSNiGhKNEfoo9GRS/SYmRlfZWQlXuuE+1AUfQy9fB5XQK6cS3CWKfcaam6uTtTu6flxfknMvhiEq2M6gf/F6bJSgq9HNJSS4yCOZzyUav0l27yIlL2xbIjzmAkx16K+OJspoLVJZXyj5eMu2ZoBdOrtuvsl6Vjn/p+32MuSEmFxfPPN0tHuW9fqif3NaY2UvLIkD5/d/EkZfwIN+FNSOm0TKOwbRp21OMEGXVXXwclBUCc2zszpJKtpFuAEFNmyL7001miiy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fM+4qJD50tUEvuhkEVHv9xN/oCjiAUk/rMYm1Ro1gc=;
 b=sP9W+OdyDKi6cnqu7KQnQVfhiIzmt274f/XJVyoCXICcRydKiRw9Wv+e7R8vgIVIsdEt9IfGAXA4c16VM1JmTOV1te7AZc6DlSe+mZDrE6nYcYkEM1J/Tk9o49scSQlJ+wM7kCPWvwXhd70/TVQg/xA6Dbhz4MeiGM9qnNgW8lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 21:12:44 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 21:12:44 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v4 4/8] dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct dw_edma_chip
Date:   Wed,  9 Mar 2022 15:12:00 -0600
Message-Id: <20220309211204.26050-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 01796f26-0eaf-45d4-cc2b-08da02118de9
X-MS-TrafficTypeDiagnostic: AS8PR04MB8358:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8358B7D3A01640FB578B8ED6880A9@AS8PR04MB8358.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axbitCYhW+/z8tmjaMwJTwe87qwQzrl+4TFDsNVRBxoUJrC9WCj6Mn6v7oevnCukSQCm5YxpLbd1YbUnC4RNHUN81cI+dbiA1S/hn6AmtdO+nhB1nmJuCnD50TebLJPDJi1r+UInQXADE0cX/9Ai5GCM4OULmrEgZlvBCbKu7G9RXDqH+VAzwrj5Sls/RGJkPKqXdF6UHJ6Q0EKpvS/XhJ7Y3mvuOWhjMgYqfRr3yz82axdrQyF1GJeJOAvIxzcuvE/MZGoTsQBdwe9HXJKuEcA0Mycj0DMqla8qniotTW6LboqS9YXYjStQ+c3wlFKWq9FHilketi2NNfdGypkb4EVzqmbKMdFAeUK3bR1sas/R91SlEbtUWR/coOAXEwGaj8Za7qBuLDY3PQUWjyT0thyYWhDdTx8zpgOAZ6BcarTTv9i1l9cnlPDJ6VuN6G2Nxtiqle7eOlUjZKth5wkYif4iPpS0g93wv0NWX1Tdk8qZkTAe+isr6frxrmJBNjSSG30Dih/qu9k7Pkv2QdAZ8ytRowpa2jQUKmqdhW17nQ/whoxDZS+fLKpeI5stmGHodlIFLIQdskISqlcl2t8BQeyrD4lNpzrfMEGiFMItlrO727huhhXq6BLCRtvw/tE8PLnAGF3XjnO4QxolLRuy5UXqI4vBxlCy16ooxxztzuQEOqwx4DxD8oaIOw8jeIAasJ/0l6quu+y/WMKcTTxifA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(508600001)(2616005)(1076003)(316002)(83380400001)(6512007)(66946007)(86362001)(66556008)(52116002)(66476007)(8676002)(6506007)(4326008)(36756003)(2906002)(38350700002)(38100700002)(6486002)(5660300002)(6666004)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FFcu/q/JEps6/DvdPlGJMkouXaD5EeC5qOvEgR0pu197OLfOlT/JlEDZILFr?=
 =?us-ascii?Q?vvPxPWighB7eXSWrUDCkN15PO27A0o32z/w6sGZljFsh9GQfSUtCxTYsho8l?=
 =?us-ascii?Q?dirPkC7MwWdraqKQ1SbI8KQUZcvSUM1f9sY9ZiDAfHJVe/dDJ24/XEkBWzyF?=
 =?us-ascii?Q?MTUg/D6PBKmYYj6+u5mmK0fSvLeaVybWfO8JdOlkFJXcFwpQZNJARofcXq7b?=
 =?us-ascii?Q?uC+B01q4grV82XEKksA0Rb/GINYQCBVbMzSZpptZ/4fp4bePiUJGIJr9ygZI?=
 =?us-ascii?Q?UOPFEuzA0H67iI3s21YpZFw+2KJVrL78mWLTGcjHxp8H4p8pMrp4DC3qCoiD?=
 =?us-ascii?Q?Io6iCZBpqiLFXOtBIIs6sFjq3lCGYZIeWqBt/fIwx9O2MYj/RjzEzYMHutxy?=
 =?us-ascii?Q?sm8gm2eBWM1HMX7oyQMkcFLAs3dv9Y4JOG5u6iIaGE+dqpHwxdER2qBvE/Ti?=
 =?us-ascii?Q?GQH/O6kHGrXkjH8OAaH8yoqhyLl3PmgUzv8Hduv4b+IIwBjfII9odatvediE?=
 =?us-ascii?Q?rUGKLJHqYg63jaaJdFyKIoNtGijZbDEI8h69GxGofbLVx2+FFp3Lo0kIffve?=
 =?us-ascii?Q?cIg0RwjijiftxEyUhga60z936MXQTDIECMRXl20PS2B6Irdyf9eixJpvKMM7?=
 =?us-ascii?Q?RD5ThT6khZwLi99pvd5s5PKeOfvpiDz3oAJLKqmWA3DSJ0nB/gB2+xxsrSPW?=
 =?us-ascii?Q?kHn0C6Uq+2cAknO0osvhJ0PGQ4i3M9acn9Z0Vz78vnjbqFWXShNMIZqIFATE?=
 =?us-ascii?Q?QGWUuboTsbNRLBvC5HVZb8WNqVVBOLigAc56Ffce5pB2ZMgcWgZs625QSfFy?=
 =?us-ascii?Q?1utJZCu32bsrlCM72IXfXYc9SU8r5dqZX0J5NuAerEPM7/fOyRHkjmuCicww?=
 =?us-ascii?Q?wUNhtloWknQ9sDux+k9OQPLSt1qG9VYH8llXwe6rKyFgN6oQje2imQLj+LSl?=
 =?us-ascii?Q?012gVhs4bb4cdASm74lVKYA6F3u+k7RJKpU8TonqLdoOV06/jR7YKjFH+TQn?=
 =?us-ascii?Q?6lV5FhB6e6wBtN3sDIkMMuamCkF2v8ejjqV5/cS/Y6DGWIQ3OL8TxvBVA/Lo?=
 =?us-ascii?Q?ikkXeYjhrZnDdoGGY3vsCAqzJYNg2WC4aiayMaKnxRrCDwICs3YHLLJHvMuV?=
 =?us-ascii?Q?korsklVnTdDHeTdPp/6merfU85urKzpWzzp6Ak/tIEgQkEstaEKqG/HyxoUZ?=
 =?us-ascii?Q?f/OoWI1/bq+ydusNdA7D8gHyVE9i7umLa7UScIeZL2T4idYy9ELcjmkUOPoz?=
 =?us-ascii?Q?GtY1NFkERvgQAKMIBLlkuBAHYhax2O5msOkagq0+Ke2tLc8UoldvpMScfJcX?=
 =?us-ascii?Q?KLbHZQyY09nrIM106f4oPkeByzuMj/vu+l3iD8o5KrtD5mBQ3ArhjuCh9+UA?=
 =?us-ascii?Q?7ypZW+VTUgKOTGRW9FkIA0nno5enbPqBEjYWwpqw5DPd7INc1xrVHkxZyjMU?=
 =?us-ascii?Q?knlO2HUYRNk/d+b18ErUd8wj5jRWyeMQT36koU6IJJyeSYJ6yt/A4ntrQcHp?=
 =?us-ascii?Q?6Wt2gedVcsm6cRHZlWUoiuz+HJwBElmJ3Z1y+7jSyRaRJjQLZigRb4urTx/E?=
 =?us-ascii?Q?BvQZ5zC0vXrcrc3+qawBRE2Hqs0ffiXYDZkYkUtVBLV6JAa6tV1JGFFyCg9n?=
 =?us-ascii?Q?6qXUYhPcgabjG3QWPJfNBOc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01796f26-0eaf-45d4-cc2b-08da02118de9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:12:44.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7Azh2aSpYeDGt+NJE8vhSYlB6OUb/4PMlaYIiJL0v+1KnKRzGVKGRmdZ4caEDhPd6n7ebSJPplqCpuJnU0nHA==
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

There are same name wr(rd)_ch_cnt in struct dw_edma. EDMA driver get
write(read) channel number from register, then save these into dw_edma.
Old wr(rd)_ch_cnt in dw_edma_chip actuall means how many link list memory
are avaiable in ll_region_wr(rd)[EDMA_MAX_WR_CH]. So rename it to
ll_wr(rd)_cnt to indicate actual usage.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
new patch at v4

 drivers/dma/dw-edma/dw-edma-core.c |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
 include/linux/dma/edma.h           |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1abf41d49f75b..66dc650577919 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -918,11 +918,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
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

