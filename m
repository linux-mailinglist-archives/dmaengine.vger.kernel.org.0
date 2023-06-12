Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EC072D0A1
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbjFLUf3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbjFLUfS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:35:18 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D4C1701;
        Mon, 12 Jun 2023 13:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbgN8OsXKp4kaEC5weVK1RqWB0BDvmNNr4uewSZ2nCRYmnqJvi4OdycMpNR6/TltiS2W9k+Ch8q2bFrQXHYLwkFCcUfZypgNqiEk+t6Kn/ydPFe6vXPSuIHpdop47r93u9TznEn9/xY1w5K7TgzbbjkrlponWuHOx82nruM9qBSERwjDaNdfg5Nic6R3Dq3FfWvV9kfbMwjt0+gObzS17R3EzqWepFe6F4qgPWM3ndiZt6UcBMrCEi2mSlh8OjK5xfJ15ca0BNYkx6+sNzpBbHMhzfI8haLhq/1Rh1IYOz1kZObUfpOel6NzYbzDJl4IpjqZDgV65arLHX0+hHswNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=YNfsRT118tsmZ4WUCwcCCj5GWRq1ZTnuhSW9KCn8pZc0B4MAqtjA7/Nija8/bN/QqtLJ6/nDGjIINhA8txKkNQ/hASb9RiRzxaPX2wxH/4zuJdwDYswf1C9CyNb5YE+rTng6CCdZKk1xoWcNqiNOK5jyUsIRNtYwrqU2dfx2sHxvt+NYIyBFDqRt8i1Sd22Ykb5P5oQOUTONVC/rXlZlMLctnR9guzgJjypyTwYSroQs558J0rciwM20hDrK/KJWniHriGgUV37b4qeKosIzCh7PnH7+w4Y5NAUmFUoWfVLCUmXhC54XTeVpCdFIX34iauyvjmfqRqvUJvrMRxzCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=DSJBwIook2UFSGg9A4hSFOXrhn4TO1J/G5RKURFIbOGKFoknHMiR7vIsrKzffFDCdrF90pH8W5B9xoEZHkr04BYxzHTNEJ7TfL4sulyjRXjM1zlJyFpCGtya6VoWO3HO30BiVxWpds6p+Q1NFSZYhr5vsBRAtE1JMDM8RshhQus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:35:07 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:35:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
Date:   Mon, 12 Jun 2023 16:34:16 -0400
Message-Id: <20230612203418.2017769-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612203418.2017769-1-Frank.Li@nxp.com>
References: <20230612203418.2017769-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AS8PR04MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: af7d6b02-bcba-471a-639b-08db6b84828e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OW23S6uPJluEFj9nOQT2hDRzieEphMKOxmpmfJ1Ug6O5/yDijzW6TT/R7Ew3S8tEYSMKVEpUBaMceB97B4ZQSSVzPUl8Rf9ORdnaJ48dH28d+IT1LaPXPtK+h6AKYZ7wVX608SFK0gY2ethvfKvKkahEM2A2buAQTj4CK2uHetaR0iGcb6z/b8Axmk/NbAOQ4r/z+c1jqV5SzKuB/Z0ASKVVVz1iDxnFi4IC/lrgzZr2oaAbY9OKlHkWGH20hruwwZWnrZJ6pLDbGqJcvG63BnO8gJmivkAMWEZ9IuoMj4xmVIUwew2f7gtpi2sfT9oF/g76ds8Zl9dAMrhGdJOFwi8BJgDerStJcKmttKVxlZbVBd5wIeT5omrHHaTUrdgm/cLlUpqEXsiNAcvepSwyr9FrgKolkLnGpbcuo7Y1Aljxcsonan7sKWl3sVKuqcwTdFvteB3075YUqIkxfQfoWOXBiytr7Xuk7kfO2E6UKEM4xoWIDk5gX79tiTl/ZrclYXEuwQQi3MMcaAwq8LXFUWWB8BMTNnQ5Nl94sYiIZKzmbE6v6CaZ65ch4uYqnBdK05nQ5DSVHgHGHLPLbQ/4ddFChIWvmhjoYLO0j/1dBj3bU3oO3uA0ULHH18TgA22k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(36756003)(1076003)(26005)(6512007)(186003)(5660300002)(41300700001)(6506007)(478600001)(8676002)(2616005)(966005)(66556008)(66946007)(83380400001)(66476007)(6666004)(8936002)(2906002)(6486002)(38350700002)(38100700002)(316002)(86362001)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pif95yWgiVWwOszr4WkA2NuEQdEp9Q4el8jHz2xAB/hw4vGgys0xE7JBBgxw?=
 =?us-ascii?Q?nvcbmoutxdFq4+olApQVqMyPnw4lLkWbOnQbvSQMUklyu0ucBDT+VJcYq3w0?=
 =?us-ascii?Q?6hSJF8XxFrz5eSRiNb7wUaIkePPt8uaCSbgPbNP+HAX1TFI827lG1QcXvrpw?=
 =?us-ascii?Q?Lw2Fj+t5jlZQOz4SHlLeYVSRBezzxtXY87HZdashgAT1mperwR+84l6gIlRJ?=
 =?us-ascii?Q?kPiJElx2hD/mBVtEzbi17zVo1zFnN/6ZAuZyE5kGEN12rS5ajd0svjiTdew2?=
 =?us-ascii?Q?kGIinZdpbjpmAac9gEEJWeRGS+ni3XWrnzYYsAK3I6tixoho7/85etuCxalp?=
 =?us-ascii?Q?chLeDUondOzBedJCH1QwZ/PcibYSiBN07UoHFyp6xnknvBZBHynHG+FSs1cI?=
 =?us-ascii?Q?tLJe/56IDa3xFeJ2wrZ4QpJ6TArQ4WWWnI2mA3IZq2edxWNfnfhSi0rA/8cl?=
 =?us-ascii?Q?amB3zkTGN2YUrfatISBqOm841sfcctYpZSGW2K+UUFIUFJycw+GdbL4rhXLD?=
 =?us-ascii?Q?PZ8S7kJQN3AVf5Ml8KzmUm3Qdfp7SQHfkf1mLuJ/XDkH4QMxaltNFqAkgSP/?=
 =?us-ascii?Q?hRCTDaEtkmKjzAVzi8x+/IuR1q7suSjOTNX4KPeOzLCgEoRQrmhIbfMw9g+w?=
 =?us-ascii?Q?5pywd+Q0cH1seCE7gsF8mU71dWSaDp6CV9K2gEB4Zg/uBDuD7KyyXmWEiJ7o?=
 =?us-ascii?Q?WVfi/Li6+VbHl6SKqlHoP1MaOHlvfE1K9uvOzFcBndy8DwruyjDaCkY0yCJL?=
 =?us-ascii?Q?Rf1/icxmVMe2XjDifBU7gN0EEI93MRrlREJsThHodsTgv/qU18LbZuh2nQBQ?=
 =?us-ascii?Q?2Tt/lPR9RpwyNuPFbgwAnzVdyq5N4FbCCS6rjsBJXsWsqHejTvK7VQUGl/Aa?=
 =?us-ascii?Q?BYH3QNj8dn3nl0uBW/WWBPj5NUDniZAODMvYbJqVrMqj3H/+K8MddTApder9?=
 =?us-ascii?Q?EPLK+V4jSfWq3vrgVWnManQz6LOCgVRG4Vxeqjj3+qMob8yFWsP1kW7q+0Yj?=
 =?us-ascii?Q?ZEthIyajUi7A2Vlt3IeOLZDx4nxkNrVGqDgfvCmQqdrT3rQ//bpy5hSaX7C+?=
 =?us-ascii?Q?zWAFlckOdBAITXUDOm0lQjQxFtohf3Q8d4v9sFi5mYSE0veonrbwKRxZwiYI?=
 =?us-ascii?Q?Cveh1IGJPDB0tn4M93adnrvDw6tU1aDSWhqUVK6nuuY39VHwWzV2kqK37LoE?=
 =?us-ascii?Q?cJ/3VJHv9qY0VPVcEPi/6n5P2BP9qf/bQ00f+mkLkutWhVBPcQBsxt/+C0Sr?=
 =?us-ascii?Q?9HqmxeRysQAULu5aiAX7Dol68BKgyZL58BC3BFYlXQK0b3VKxYMVt11uCpCI?=
 =?us-ascii?Q?g2UBQiAjJTbG9vZjlzQzXFBFsCQCYG9Ke9UqaqWOmPebCNzXZ0FcZ8cC9DMj?=
 =?us-ascii?Q?WQvO7wgKXqW5L7G2gw/nl8WGztuYvw84JTUnoQJnnn1WVULxyiiT6fEUJH5p?=
 =?us-ascii?Q?K4Al5Ek0G3Ws3yPNcUuEtR1ymBoqcxkbRSg3iY8IgLut6T2i1C3bQqZ1rO82?=
 =?us-ascii?Q?FEwXnfuMnmL+VE+H9NYN7Q2G2IAsCIjaZN2UwcP8IQee8HmcRblvDzqwhmYh?=
 =?us-ascii?Q?36ine5/K5CvWsEIh5aqT4xZU3tOSNZXJFSspad81?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7d6b02-bcba-471a-639b-08db6b84828e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:35:07.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ro8J10YpHDiEPar/vfNS4XyhWbMwJzLlFkRXwBtzsr0s87kfl5vU07bqZyltitecL98FHOd8UeJBDPrdEKB91w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975
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
index 51fbd7531c74..eead6a4765f7 100644
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
@@ -736,7 +728,5 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 		edma->regs.errh = edma->membase + EDMA64_ERRH;
 		edma->regs.inth = edma->membase + EDMA64_INTH;
 	}
-
-	edma->regs.tcd = edma->membase + EDMA_TCD;
 }
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 316df42ae5cb..cfc41915eaa1 100644
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
@@ -156,6 +158,16 @@ struct fsl_edma_engine {
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
@@ -170,6 +182,14 @@ static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
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
index e2fbfaf9155d..8ba705080f5d 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -310,9 +310,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
 
@@ -419,7 +421,7 @@ static int fsl_edma_resume_early(struct device *dev)
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
 		fsl_chan->pm_state = RUNNING;
-		edma_writew(fsl_edma, 0x0, &regs->tcd[i].csr);
+		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->slave_id != 0)
 			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
 	}
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 316e637b00c4..bccb5448e492 100644
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

