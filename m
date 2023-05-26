Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB297128B0
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbjEZOjn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbjEZOjj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:39:39 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24DF10DB;
        Fri, 26 May 2023 07:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsNWz2okCFOTYg7StKqAPityO2OR6NayOu8cJ+EqFK9asYkvS2WA+uPCeTfizeahXDUha0kMMq/sPGR6BKisUhQ8x4CJl5a1boKCFaPcnG/w+oC1dkc4hbdirC7MSI5fawfJTc2vJMNSmlA62VTv0uf5qMvRMXRSlVvWZoBx6H64hUdRrlywvQhS2sbkVRx3tHZWuidIGMeZ4gbkRGwhZU3tAglvN/ztRT3AD2lftIwQpE+OXBY1Yy6xpWxiCmczqyhNRO2FLmRrgn4ep4KMet2THcUdXeW36SOKmqbYGeFSv51i+J/UNSknR8+LDIV1fGvaZg7d35o2/a9Ee/dInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNjfU1dbjGe6WQ8dMx8AJBvEVMIU7B1H7pGqCNARUFM=;
 b=cSakRJwWIdW1aplhbe/HhnHhaBGXt5uAA+LXbf8cwj8ig7jA5nYOlm9dYaHanV1gbiTT7KltkiVI1pnJ/PgN/YUzgMojU9YrCUJSYc9SAoaP9NsEYFA5OX/UNa66zwN/cOK/r2nBI5faHXFGHaggZmPGZOdjel8ap+XvVayOY4IenUo5D1LwkAa8tBSCLRTCE8eJXV1E1RXcw5c6HeaGVpF8xbokLay4G1n7HXJ7SKIarhZUmrDfJNoIgBFDj9TjV4hNO1rt0PBU5TDWLTWg+wGuVcyt17liLdofYkrPsmAkvnYxJ71lHEgT4AwJuqhf+gq/MUCQANqiGI99acHdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNjfU1dbjGe6WQ8dMx8AJBvEVMIU7B1H7pGqCNARUFM=;
 b=Upf+C6QSHHHSk/ud5g18UlaQQEs7uF1HkgXmg5A5EiZqdW4sBUJm5SQCjGJxbS3AAD1u//y6kmZGKUEf+P3gApfBgj3zBMuvTSDeuYME8r9AWHcFao6xbhB2ocS/9GSnxAAcqQubVIKhKhK9DPLbceXmWwfmRtDBXp3BMqFsTU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:25 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
Date:   Fri, 26 May 2023 10:36:37 -0400
Message-Id: <20230526143639.1037099-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526143639.1037099-1-Frank.Li@nxp.com>
References: <20230526143639.1037099-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d24b9ce-930f-4ccb-63b0-08db5df6b94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2HcGqkzhsQK4qShn5IfrOU3dVoJX7n3ZJNmCiy1EpNQzwIHaL5FF5cGqCf8QMFG+mhQBbD7i1KxDVv9FhbSywvOk7NjKo3e1HGSxIghPQX0Bj0OBg06NXNTSbcRIAmfvyjhkEgUOPcyBlONjGz1edy7DqMLto57FxwBM1tYLqzWnrvxLg6sGN4FhGvWsDfSJcbdI22RjBw40rUzy8fq8B5Bmt1HaAaXl6SXmYowjPWfeXvY1Kd/IcwZOL6Z3cdlk154Lsp4kSfA+nigTlL23i339dJ3yiA5UdsIPRcKjxNH+ROC4EbjsPaRZAMPDwwDF9yly7Ysi5jhwZ8PmsV1r1Il7y93YoQ49DdI+puxKB2ZiM18+Xr3DdaGUN9QO0ugJGBfW0kda67yGeaw7TZLNN4RLGjX8pq1AHK+9GoPfjStRbZWxUuQaHj3wUBhR6Guo5zTW6GBNQnpfevcXtabTSWv7gilw6wsB2kCUVW7ZyI7S0WDQeMYTVuTnov1ObYQ4sVGZFAUnVs371d/tntxEdDHX6PJ/Pj4/Cr+yaahChrpLOyJgsQGoluFUj4tCzMnmDbTGbOA92fshda+iy6Ku40CDZnRcT6dAeHVC6oV1CEff73ZVc6SvOiOO+EMns6taHgP9sheOumwBSQUob/c4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ar153bedu21/LUybv21z1jXtdHyxZKa+BH9eglNuhvfOEI51wvqo4zTdlwyZ?=
 =?us-ascii?Q?71tQGDazJCStBL3u4fjp9MWpTB6lwG3u8N1IfYeXWKnfjhyxj9IKu9nUxoch?=
 =?us-ascii?Q?3GhpunTtAlPZlDIpXnJxC2NWFi5O1QQdwzfXA5al3mSj2+vweoOvDlYviMJp?=
 =?us-ascii?Q?zSyjUeIl5YOW3daMVouNGOeLplhePNjRk27R9ZIqKG5LhZnLDR1zTxrmLUeV?=
 =?us-ascii?Q?5Bl6vXwcgjM0euuU3W4b+jH5U/uXFuVmaSHljr3Mf0Ml/8M9tW/2aLTouiTj?=
 =?us-ascii?Q?bR6ShHgh0gECLQzSIkuYYdMp/gFi+k56QxHbVki4RmlA96mYkX1iOGKcPQiI?=
 =?us-ascii?Q?jsWZ7qpMWc9XUv+7FynwPSHC8itLzfdcux/GIKNQmeDkezKrk53sMRWxNiL9?=
 =?us-ascii?Q?hYKgjnxGaBhkYPBhmK2e9PmpiDEELXwAhJggV9TNUAcpMQhTpzCbAAJRyw8o?=
 =?us-ascii?Q?GPbKojfY9GqRcXOI87Dgxix4TU+C6sYNWIwXk0+cbcbw24TwyKLobDB9h029?=
 =?us-ascii?Q?75RXmklhRxZpyqsYZor8d5Ld22aAOOWm6WAI8fgUfMvIq3Y+4UJcEr1MW/Xy?=
 =?us-ascii?Q?2Gzd6OfOQ3Mmyz8ThiTRG5CDhMb9HxCMPMUGvkaG9mBiklJpxHF5nfUA72O2?=
 =?us-ascii?Q?h76FogMWGqGxgaaynTdcjjaHwuQfbcbo6lWAPeu5NcVWB1sbGX/0GxWgZnPG?=
 =?us-ascii?Q?ASYXvUNrI9yW14AXLtPb+Yl03OP5Zpd0SyiY/l8NyeFBpz+lT+mm0ZAr6xDi?=
 =?us-ascii?Q?yrI7e+nNcuB8yP9CZSWORT969ciGd2mvd5A7uhC93bK7xkxRvGQQx4Vt83l/?=
 =?us-ascii?Q?864X/L/2jSuE43GOHyvlLoUCm6idTno7rD/W+rPw/iQKD25cuQrKTjQw1Q+3?=
 =?us-ascii?Q?SSzabz771dum1NpYCTgKdvfaoSPWXs5UIjWz8Kxo097ZyfyuoooN0ubSfKMI?=
 =?us-ascii?Q?BVO5No2v8WGMRHBpDnnJAek8HN0UqD609EKbJmhvEPEFdYftiJI70QQfYweU?=
 =?us-ascii?Q?C6phCTbLXrmzWZ+e5X1FEYgH14e2mcFBWCkmDySy8xsJ0Or2HXo5dmCie57m?=
 =?us-ascii?Q?dbVlEswTiVkx+d5hKdvLYnxCbc9e6aCOp+vDZLfbUQcHCAmsEe+oLpfXrtm2?=
 =?us-ascii?Q?uYtj7293iI6/c3pA/Rfgnrzn+Pu2s/rWqyUjktwZEm4BxZu/B6wc1INO2UKS?=
 =?us-ascii?Q?lJMLQ+RXoFkjkqdJ893wtbdjrzSjT2KabN2LxRPBymtvhicgNR5LxZLGDy9M?=
 =?us-ascii?Q?uU2NredFTQoVG81yJ7vj5DECPE3HCAylrknwdl066vvadyijgQ5AWPGaZnON?=
 =?us-ascii?Q?/vPrWK41HezYbrSuBSHTEqN0zJILH+IyIfDT+D6wJZZfEKpV2M++jU9mRakc?=
 =?us-ascii?Q?7sLS/F92X3Mkq3iqgdpqJPjNotLGSKVEDqMBeylrHHbn8y/mIxuY+DpmZTwa?=
 =?us-ascii?Q?9IqgoVq2fDI9YmVnBUS1PYIMUg9b4yHF4xVZC+nSKUe66NA5pIOG3aRGpF9U?=
 =?us-ascii?Q?Pl2zSKDM7+ceeGgg5VWbgB3AkvsvzL9Q8b0Odp/XhdiEecK4Fv4dhYm0tMb1?=
 =?us-ascii?Q?NnIzv92p8JUNOJJwEkyQBXqIsNDvZcpLdsci1Fpv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d24b9ce-930f-4ccb-63b0-08db5df6b94d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:25.7870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDXE5E4DrjsDDgx5rxjHFRn8uk/nRLP8np05QBvqXtty8qImokAud9kG/bA72SUrRixagJICjpNkAnVLxXSzoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 38 +++++++++++++----------------------
 drivers/dma/fsl-edma-common.h | 22 +++++++++++++++++++-
 drivers/dma/fsl-edma-main.c   |  6 ++++--
 drivers/dma/mcf-edma-main.c   |  4 +++-
 4 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 659bef4a3b23..186b5c41d07f 100644
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
+	edma_write_tcdreg(fsl_chan, (s32)tcd->saddr, saddr);
+	edma_write_tcdreg(fsl_chan, (s32)tcd->daddr, daddr);
 
-	edma_writew(edma, (s16)tcd->attr, &regs->tcd[ch].attr);
-	edma_writew(edma, tcd->soff, &regs->tcd[ch].soff);
+	edma_write_tcdreg(fsl_chan, (s16)tcd->attr, attr);
+	edma_write_tcdreg(fsl_chan, tcd->soff, soff);
 
-	edma_writel(edma, (s32)tcd->nbytes, &regs->tcd[ch].nbytes);
-	edma_writel(edma, (s32)tcd->slast, &regs->tcd[ch].slast);
+	edma_write_tcdreg(fsl_chan, (s32)tcd->nbytes, nbytes);
+	edma_write_tcdreg(fsl_chan, (s32)tcd->slast, slast);
 
-	edma_writew(edma, (s16)tcd->citer, &regs->tcd[ch].citer);
-	edma_writew(edma, (s16)tcd->biter, &regs->tcd[ch].biter);
-	edma_writew(edma, (s16)tcd->doff, &regs->tcd[ch].doff);
+	edma_write_tcdreg(fsl_chan, (s16)tcd->citer, citer);
+	edma_write_tcdreg(fsl_chan, (s16)tcd->biter, biter);
+	edma_write_tcdreg(fsl_chan, (s16)tcd->doff, doff);
 
-	edma_writel(edma, (s32)tcd->dlast_sga,
-			&regs->tcd[ch].dlast_sga);
+	edma_write_tcdreg(fsl_chan, (s32)tcd->dlast_sga, dlast_sga);
 
 	if (fsl_chan->is_sw) {
 		csr = le16_to_cpu(tcd->csr);
@@ -393,7 +385,7 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 		tcd->csr = cpu_to_le16(csr);
 	}
 
-	edma_writew(edma, (s16)tcd->csr, &regs->tcd[ch].csr);
+	edma_write_tcdreg(fsl_chan, (s16)tcd->csr, csr);
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
index 39b5f903ba87..0a95fd5d74f5 100644
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
+	edma_writel(chan->edma, val, &chan->tcd->__name) :	\
+	edma_writew(chan->edma, val, &chan->tcd->__name))
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

