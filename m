Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109EC71504E
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjE2UHR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjE2UHP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:07:15 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A020FF;
        Mon, 29 May 2023 13:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b25xXy5Rw6GgYS4ef/HFlhHwpMetip+1U7OxKSwI+H6HpgM5Km1PtI0YW1A+nn8WImRJVtFHYdvssc/rB24dBkiK4cbExygj2RLDC4lCbxjZni4IYvpJ/gEwFuJR5tsft3JmqhK/UqMriM7MZD6nSTdKpP+Gw6+y+ELyYP3vthnfmlYHUZ47E8lCn0mPOR/YtzJD7WvA8g9GugU+uPyPiCJJ4hFxwkIzQLd3pN/bB+SZlYupDcbiFeOQHzbteKhJxfj2oeL3eou3rSR8E8Wx7rC2yUvxJ2QnwcZApv1BmbIMXVgcOI1R7Nq39rGebRGJeOdtKHL31xugRtrROI6TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZQBBtSk4cUImx65qukNzrsozHrl9czSuN5Y3QoTWkY=;
 b=aZ4J8wNW79y11UEgZPfDOcdNBx2qqUl+CabMZyaxZJrPlM3Ncqm8cIOT7s6ystGbxEq1Ma8pYQ+S65s59meqABcF0x8qE9s8foW+gQksJzMvu//3UD/PENmaoKfXv+WjAtdNq74Nb79hFCeoPK/OQGSLVGiYoA6xLYLVc6mvIzsLBoz7FJfVUxi4c3LjOug5/R4z1CCOgjMEqkhQPyDWN67MGBUCRoZzFxMf+tTcBgD2mJ7JkPO2/K2zRxuvQatQR66onTzLEwbXLi12w75rISvmpfiMbkfojBnXjf+bf7U3i5ktWiQUmp5AlIVu4xSxBYlkUM3mvmMHiXxcFJcasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZQBBtSk4cUImx65qukNzrsozHrl9czSuN5Y3QoTWkY=;
 b=RC5Cdqja4UMsgx4HMcnmGg2sVOuh/52C87ESD+rxXmFiu6EIkmxOWIYgC6cnVIpSfrjeMMYTHVcclYjia9U2jKvPjBHGpOVTaOMbkCdjFQEsM2Nu1DoWAmi5WWa6dI27/aeYc/VtWL5sErO4VJKFyYeEw6vbp/t8IBD9BOAcmvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
Date:   Mon, 29 May 2023 16:04:51 -0400
Message-Id: <20230529200453.1423796-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529200453.1423796-1-Frank.Li@nxp.com>
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 970da16f-3230-45e2-ad23-08db608014ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agGlemy/ChCsYECnyvye5yOUX46V6PVUiuhDKVZWt2Ig47baU2GgKNtqbxn91OE4eTLPerk1GPQaNuxkQOLjR1yZ8jsKzqnc36FKq7/JgmY1svYAZs56UcsMQiEKSXP6b3EnZvctble65NLfbXFm8sytO60oWyPFek6aqtC49jutQJTbuZ0zCpOSa1vE3YIPgHPRip/qSfNgma+yKEqt3cmFYdJRZDKvFyGPuDd9fU4GYBDUl+KicrrXQ5ZFhk0QeesaS3NuVBQejHI1ezpul+EYubkhbTII1KxPR8Bc5ILETRrJJAF8BjXOcFw0AjOJ/jEG/5oZmMNjs/H218Zh0+hG5H40eQxKvJngGFxoftve28v3xU0UgaiaEeSamDphpOtTDuGNudbGONZSfOAodtEnv+FhNbc10XHpfgYMQcol/9QWWsYBfFsEdMloYV5pFILwFLPI691qtZwZeK6bliIrE576BbRe+4urj50wiWHvPQlvA8ryiP48RWSWD5A9exaMQVEIFIgiGNVTpGr2fmSEND1yfpo5BgIGMvuipSVjSPKUc3c8BizfiTKQB5UOkJnZ5xarT2fDAtb1gOZENL5UGAICAgdP74FtmZvjKCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(966005)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q33fXZ/CpbLbEb3n03l+1ACKDrdXpt7hy3+nuuWfdewS6ly8qxGQ+bUGo/ID?=
 =?us-ascii?Q?+boSmz//9I0IYULvvhkLjpeMr/aM7Uk+tAMvophQFAQFLp9rcHMV4Ua83fDp?=
 =?us-ascii?Q?y1GXt9FvYUC1Rnru3ZAo16ZsolT1WEPc14OWjZE16XJOtccRTsZkLyyfBrRY?=
 =?us-ascii?Q?OzaS9m64ArtjFAU09SDZwY8c1UtS0z+XDZYfcC4289LZmgbfGU6Nb3LG2Lui?=
 =?us-ascii?Q?Vxssu3xZTyDg4PgWOOJT4pdpwCIENJUJPA9+/dmAkLq+lMc+4QWaaptc04/v?=
 =?us-ascii?Q?gF0+n2tPg3GUhiH+Ej0NE1xQvYJPqy2MxSNF6JtQrsWDbUwRl9mvExLYMUgr?=
 =?us-ascii?Q?20MeGwupgUzgyY8J58jhLSWD89dIT8y3LhTlGlt/bWUk/fJswI1szjaiqjzu?=
 =?us-ascii?Q?EingM0BzAJ4MaWM6+yMi/y0+5J5OAKk6y+hKorHs3W9GLYTYd+VqQHQoEss9?=
 =?us-ascii?Q?CbmVg9vfokVUxMMAZmLXJmH3sEiOlQ6lst6PqRsm9/Okk4hz9ScjoXUlaWRN?=
 =?us-ascii?Q?lub6vFmAHg/VVOFhSH5uGyppCNNZ1X2PE820ZfmdHTubmwZzdMMR2iy/oFyW?=
 =?us-ascii?Q?Pt38KfGkT0aBZ1v9MAMOe4NsWcudM9Ta4ryaaw148XCAEjvdkIhTKAeWfzhM?=
 =?us-ascii?Q?0UZb97YNH9kVsBTkeOTfDtCmQQ9gHCbH+yZq5nryYSv1o0pQQipD29v68slR?=
 =?us-ascii?Q?m+Pyt8wMb3vgM8CZJY6kV/iiEsEY1NKPttdGHR5Ano2u6iR8qb4SgSzNxS2O?=
 =?us-ascii?Q?SYprmi8fAdfVYEareU8By2YccTloMmN1Fp8ByQO5yF9amrtoSNVYzIEXDOeO?=
 =?us-ascii?Q?jd2ET7pcm8oxg1ZPCOI20yWmeS4bWEfzTOFJllugJIc/kz4NV3XcARjcBji7?=
 =?us-ascii?Q?eMlXOzc6LF70SRtsFI/mLFq63Qm8VekLKsarFrQdtLk7253iUesMpO8rfm/O?=
 =?us-ascii?Q?YvB50jOicfDyFqbDJHB0x/AVqtVdPzylRqDVQRrLHsKRGcSaJB7SWKVyHnRx?=
 =?us-ascii?Q?v+8splGAn/Wodk+DjiedQvSXuN6CjOplp/8HF+YpJbgIHHZhUafad/p+9rR/?=
 =?us-ascii?Q?HQLWP/2bKNnWcw8GvLK2aQddjnFWALDt4DI2ZxFyn77uhDNoNWt3m2nWHEmW?=
 =?us-ascii?Q?oLRgtAzC2Rgv+iXfF3d1wThrmFbzfH0wkYrueU9molhaVCHHcOu+Mu3pQR9s?=
 =?us-ascii?Q?Q7bt/5mDkHLYQst0Xt+BNpdbGQkqjG27LsHl5joHULJMTzeubyDRLQbaDjQV?=
 =?us-ascii?Q?qhKaJtJertddsKjN61pW5vrNwqZX6/mXWpPwL/nQWBQyB2QBxQhnMzu7U8j/?=
 =?us-ascii?Q?5b2/5mcgvJPDHmH6SPRrX7edjDZxdgNJI7vgaG6MLbVGwzKxedbwCcFDPioj?=
 =?us-ascii?Q?m6+GXceoi/BWt0eoRh9j5mlvJWTTG7EQOQvEZC9DHN3c+v/KGhyPAUQv1GBU?=
 =?us-ascii?Q?KmzCROsn8Rc5LeLViNRnYtr320lrrZindDwyAnhsOY/YPi0HhV/f9WjwzZ+D?=
 =?us-ascii?Q?iYCpb7c1p1IoAECEjhIBbU1rQjaMlJAahOUlLc3BohP2cX/xK49i137Z8WsO?=
 =?us-ascii?Q?xLQ9hUDtVNrkoKgm15GVuwZ7RHbhvJHZa/zGlOHE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970da16f-3230-45e2-ad23-08db608014ba
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:42.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTmlVV7q2Vuq/LYzL37LaqKag3LUjd4X5d2HoluMfJFqVX615mP5Bi0n/7O+wNoU7TH+MNcdVj09EdcnpfgsgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Relocates the tcd into the fsl_dma_chan structure. This adjustment reduces
the need to reference back to fsl_edma_engine, paving the way for EDMA V3
support.

Unified the edma_writel and edma_writew functions for accessing TCD
(Transfer Control Descriptor) registers. A new macro is added that can
automatically detect whether a 32-bit or 16-bit access should be used
based on the structure field definition. This provide better support
64-bit TCD with future v5 version.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305271951.gmRobs3a-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 38 +++++++++++++----------------------
 drivers/dma/fsl-edma-common.h | 22 +++++++++++++++++++-
 drivers/dma/fsl-edma-main.c   |  6 ++++--
 drivers/dma/mcf-edma-main.c   |  4 +++-
 4 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 659bef4a3b23..d56b100a8358 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -40,8 +40,6 @@
 #define EDMA64_ERRH		0x28
 #define EDMA64_ERRL		0x2c
 
-#define EDMA_TCD		0x1000
-
 void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
 {
 	spin_lock(&fsl_chan->vchan.lock);
@@ -285,8 +283,6 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 		struct virt_dma_desc *vdesc, bool in_progress)
 {
 	struct fsl_edma_desc *edesc = fsl_chan->edesc;
-	struct edma_regs *regs = &fsl_chan->edma->regs;
-	u32 ch = fsl_chan->vchan.chan.chan_id;
 	enum dma_transfer_direction dir = edesc->dirn;
 	dma_addr_t cur_addr, dma_addr;
 	size_t len, size;
@@ -301,9 +297,9 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 		return len;
 
 	if (dir == DMA_MEM_TO_DEV)
-		cur_addr = edma_readl(fsl_chan->edma, &regs->tcd[ch].saddr);
+		cur_addr = edma_read_tcdreg(fsl_chan, saddr);
 	else
-		cur_addr = edma_readl(fsl_chan->edma, &regs->tcd[ch].daddr);
+		cur_addr = edma_read_tcdreg(fsl_chan, daddr);
 
 	/* figure out the finished and calculate the residue */
 	for (i = 0; i < fsl_chan->edesc->n_tcds; i++) {
@@ -358,9 +354,6 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 				  struct fsl_edma_hw_tcd *tcd)
 {
-	struct fsl_edma_engine *edma = fsl_chan->edma;
-	struct edma_regs *regs = &fsl_chan->edma->regs;
-	u32 ch = fsl_chan->vchan.chan.chan_id;
 	u16 csr = 0;
 
 	/*
@@ -369,23 +362,22 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	 * big- or little-endian obeying the eDMA engine model endian,
 	 * and this is performed from specific edma_write functions
 	 */
-	edma_writew(edma, 0,  &regs->tcd[ch].csr);
+	edma_write_tcdreg(fsl_chan, 0, csr);
 
-	edma_writel(edma, (s32)tcd->saddr, &regs->tcd[ch].saddr);
-	edma_writel(edma, (s32)tcd->daddr, &regs->tcd[ch].daddr);
+	edma_write_tcdreg(fsl_chan, tcd->saddr, saddr);
+	edma_write_tcdreg(fsl_chan, tcd->daddr, daddr);
 
-	edma_writew(edma, (s16)tcd->attr, &regs->tcd[ch].attr);
-	edma_writew(edma, tcd->soff, &regs->tcd[ch].soff);
+	edma_write_tcdreg(fsl_chan, tcd->attr, attr);
+	edma_write_tcdreg(fsl_chan, tcd->soff, soff);
 
-	edma_writel(edma, (s32)tcd->nbytes, &regs->tcd[ch].nbytes);
-	edma_writel(edma, (s32)tcd->slast, &regs->tcd[ch].slast);
+	edma_write_tcdreg(fsl_chan, tcd->nbytes, nbytes);
+	edma_write_tcdreg(fsl_chan, tcd->slast, slast);
 
-	edma_writew(edma, (s16)tcd->citer, &regs->tcd[ch].citer);
-	edma_writew(edma, (s16)tcd->biter, &regs->tcd[ch].biter);
-	edma_writew(edma, (s16)tcd->doff, &regs->tcd[ch].doff);
+	edma_write_tcdreg(fsl_chan, tcd->citer, citer);
+	edma_write_tcdreg(fsl_chan, tcd->biter, biter);
+	edma_write_tcdreg(fsl_chan, tcd->doff, doff);
 
-	edma_writel(edma, (s32)tcd->dlast_sga,
-			&regs->tcd[ch].dlast_sga);
+	edma_write_tcdreg(fsl_chan, tcd->dlast_sga, dlast_sga);
 
 	if (fsl_chan->is_sw) {
 		csr = le16_to_cpu(tcd->csr);
@@ -393,7 +385,7 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 		tcd->csr = cpu_to_le16(csr);
 	}
 
-	edma_writew(edma, (s16)tcd->csr, &regs->tcd[ch].csr);
+	edma_write_tcdreg(fsl_chan, tcd->csr, csr);
 }
 
 static inline
@@ -745,7 +737,5 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 		edma->regs.errh = edma->membase + EDMA64_ERRH;
 		edma->regs.inth = edma->membase + EDMA64_INTH;
 	}
-
-	edma->regs.tcd = edma->membase + EDMA_TCD;
 }
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 39b5f903ba87..991408d59e3e 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -48,6 +48,8 @@
 
 #define DMAMUX_NR	2
 
+#define EDMA_TCD                0x1000
+
 #define FSL_EDMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
@@ -93,7 +95,6 @@ struct edma_regs {
 	void __iomem *intl;
 	void __iomem *errh;
 	void __iomem *errl;
-	struct fsl_edma_hw_tcd __iomem *tcd;
 };
 
 struct fsl_edma_sw_tcd {
@@ -117,6 +118,7 @@ struct fsl_edma_chan {
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
 	char				chan_name[32];
+	struct fsl_edma_hw_tcd __iomem *tcd;
 };
 
 struct fsl_edma_desc {
@@ -160,6 +162,16 @@ struct fsl_edma_engine {
 	struct fsl_edma_chan	chans[];
 };
 
+#define edma_read_tcdreg(chan, __name)				\
+(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
+	edma_readl(chan->edma, &chan->tcd->__name) :		\
+	edma_readw(chan->edma, &chan->tcd->__name))
+
+#define edma_write_tcdreg(chan, val, __name)			\
+(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
+	edma_writel(chan->edma, (u32 __force)val, &chan->tcd->__name) :	\
+	edma_writew(chan->edma, (u16 __force)val, &chan->tcd->__name))
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
@@ -174,6 +186,14 @@ static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
 		return ioread32(addr);
 }
 
+static inline u16 edma_readw(struct fsl_edma_engine *edma, void __iomem *addr)
+{
+	if (edma->big_endian)
+		return ioread16be(addr);
+	else
+		return ioread16(addr);
+}
+
 static inline void edma_writeb(struct fsl_edma_engine *edma,
 			       u8 val, void __iomem *addr)
 {
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 722ebecdc894..8d1d0100f6e6 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -312,9 +312,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->idle = true;
 		fsl_chan->dma_dir = DMA_NONE;
 		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
+		fsl_chan->tcd = fsl_edma->membase + EDMA_TCD
+				+ i * sizeof(struct fsl_edma_hw_tcd);
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
-		edma_writew(fsl_edma, 0x0, &regs->tcd[i].csr);
+		edma_write_tcdreg(fsl_chan, 0, csr);
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
@@ -421,7 +423,7 @@ static int fsl_edma_resume_early(struct device *dev)
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
 		fsl_chan->pm_state = RUNNING;
-		edma_writew(fsl_edma, 0x0, &regs->tcd[i].csr);
+		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->slave_id != 0)
 			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
 	}
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index af1b0e8a3021..d79a04a03fda 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -200,7 +200,9 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		mcf_chan->dma_dir = DMA_NONE;
 		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
 		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
-		iowrite32(0x0, &regs->tcd[i].csr);
+		mcf_chan->tcd = mcf_edma->membase + EDMA_TCD
+				+ i * sizeof(struct fsl_edma_hw_tcd);
+		iowrite32(0x0, &mcf_chan->tcd->csr);
 	}
 
 	iowrite32(~0, regs->inth);
-- 
2.34.1

