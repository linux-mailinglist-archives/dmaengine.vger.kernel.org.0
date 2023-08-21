Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3E782E36
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbjHUQTH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjHUQTH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:19:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AD110D;
        Mon, 21 Aug 2023 09:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLkl0/B3DzmFfWzevugCdeKiSMelKs6UGFZimdPIHZ/Y5qlBko1im+8yuaEJdhYjoLsum5x5vRaTsT4JMO6GesIX1GBbY8eWU5jIBt7rNYt4qw7LzMYWtleYSwI4wzro1HeeIDITThDWWPJOQNQHDYfKOVbk2It9fcMgT+XP5Sp1sCNfEvjefaLpgcWNJgp2kwkt6J47uRRf2shLgz744R0mgUBKQJuiWVB4VFoKp5TK2UViU7nAF7zzJ+VzgUK3DMncPXn73H3FTHwlrEII/vQsildbv6/aKGppXMphBLzgIkbAwQEqf2Cwn9zp6QtFFlWo3wMfA3CUuO3FTVNWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pi9Y59wPJmHsWKVP9Mlh8mftip6Pvn0mevR7ITbLMg=;
 b=HyBkhulrb7pBXnqwWdOfBoPSdxeFqMhIkKWYu8M0Yoo9iOgvFiyR1TSlXaTAioba8S3/54+3AUvGCvScllb5FB2QUW3kMvYY8In3pC6uZLLpY8yy0jcpejgwtBzRWVEv2Baid/9ipNmpeDRklArJEe/sVocy/R0roeimSafdhge6Brrrn+DkaOI962ezRigwWaPe2y/mWlUj5OngUcII14lqtZznS/S5BFVSAQtNXFMR2kuABnNyUBdGR2e0hLaS2egk720CyBZ/g8UovP+5DQnL+0EckRiZntWvHyddZfTiJziPAQIOTeDow/MEUAeDqW06NppC32XCEWkPIDLeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Pi9Y59wPJmHsWKVP9Mlh8mftip6Pvn0mevR7ITbLMg=;
 b=meS/9UKiEr6KJ6HccXRj16Mv2w4aHkyQyw04m/Q1cpPqVjwk3600ZBhdZVWu5AGph4PlRQ/5zVoVnG/YDurHRO7m34k3Qmz2BM1cyURBA1qzqKPE2VthejRxo+225p5UQ5up3Mjw9uZp97SfrKYoA3qbdixNRCB61/Q/VR0bonk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:17:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:17:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 12/12] dmaengine: fsl-edma: integrate v3 support
Date:   Mon, 21 Aug 2023 12:16:17 -0400
Message-Id: <20230821161617.2142561-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161617.2142561-1-Frank.Li@nxp.com>
References: <20230821161617.2142561-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10042:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c43f72-65e5-4926-23a7-08dba26214d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3oi57ckGUnJsvciRWXEpl0e0EpOCFSv8em3CKlop2rqLMRUlYgC56wt2uynaO5vJkpZ+8kGAxuQAnJgo02JygElze5Ul01liiPS5eDmxX4SPtBG+eSNpZ7nlcKRcRrQdeWy6VeHoFWxXEjRRMbn3oT0s4tZqBze+Qz4WL+cmXXoTEFBp00YWGevJ2wI3kj7+2xTJlCEEo8sfA0D5GDZkFv+EYOgeWtG5qn1zibMfB1k002OBC35mfyNjaYxDZw8v+Pqh2LNlyRPjz34+mtXe/lR84eJshtrlKTj9q4azxUdbHApTVn+h7vVU3+YzP11CMTanjX4WI13gUhkR3ctRjKLSxq/tM8HCa9IR+czGRHhboBJTha98kSgQJqq4k4ZN1BjMzQqKqlLq08fCPXQQ+aRdFXTLMpugEbDi2bWGfiUNWBXUYdDqgn0AoSsjuzGJ0NbkbqeynzYtIcAZ57np/YtLbKt3KZRBSJHvMjYXFe15udo9UCWpTvjZir1dVFXO0ZgWId4dc60NGvWxgwgD8TvBUdVVBeVSoQOhsuaWJ1FCGe8yyzhGGL6E3toQx4MNvH3placK2MgnB8DBJZtZB0W7RxgpHb703BAdy56MI8tUDWQeuezhZFKNL2v/r6T2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(30864003)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V0hAN8Whqe+3mbJp584bRhjsfWxlmpxP9VJ1cdtwr+5MLivmKEyOkmRg9ZO/?=
 =?us-ascii?Q?7DHIyfqLKnMo+3G1oynAoSCRaSlSNFwKxjto8rJPlA2mxVmUTmCMzq3InQtr?=
 =?us-ascii?Q?BZbDJH6FxXtXQ9pPgxDePmBXxWuudjDL+EQIUbO3kKfAmsjN4aGvPbYQIrKD?=
 =?us-ascii?Q?5QJdiPoPlxj1LHLSvms9MOS6mT92H5mIkV9RnA+GLMvVxi0uMBgyVq4BdbIq?=
 =?us-ascii?Q?fbErf6lM20FIyJ2G4V+yGbFvPpg5e40Lweul/uKFlxRFa+xR+NIUn4BYe4+n?=
 =?us-ascii?Q?mY93mSOTAZwou44t4WDJAxDSzxZzfZWP8M5AWWXIWJYwCkJkAsIYSeJxlsCb?=
 =?us-ascii?Q?ddFsbCnnfvJy3ACnLwVfC6oDzkDISRYskKtU2+SYLk5EHoa2tEHUpOcsBBu5?=
 =?us-ascii?Q?d4LpDKYKmpXtYgRDQJiW0HlzYJLSYmvdyILhn1HaghoQVugmU4V9v2mgtvm1?=
 =?us-ascii?Q?hoq4duqT+nLcx+87MMU6tSl/x33XALtz38J8KxAa4g//mNjb8Jwbkhv+hDOC?=
 =?us-ascii?Q?tVFuX70MlLCvfPMPbdKgC+qOOyzzRp1IRuk+FkwN8gal6r3CyzXhqwIzuTEr?=
 =?us-ascii?Q?nwcqNq4UVYRqyInFgEp1Ky+24XGWdVCw+FkWsXKRxEikiqrs7DtNVTbPrVtr?=
 =?us-ascii?Q?ix8uuw+QZQmu5MLIcZswhPjoZ4zIe6AKEREzYHkU9HAFwGsTj0UCkazGcN21?=
 =?us-ascii?Q?NGu54mfI0VmBJapvhm7FcotJsnNESGkHNgAcBrvZTHdhMS+RhCJAMgcBGBqa?=
 =?us-ascii?Q?+CIVEpv5I6VOHTigxeJN+XcRI6iD73yK5NKDgcqZ3S03okVKv/IvULv9dPk9?=
 =?us-ascii?Q?/7W13MXE0yVYamnvyFxNcJ5qahkqsKBXGaI9FJn+qHzDLIlhUNb6hG3Z1hKg?=
 =?us-ascii?Q?oftdLMShB7TmrUHdJI+lEHK/R5tPOd+XW/X8QXdX8Ipv5PQwPkORiAMsFa5O?=
 =?us-ascii?Q?50zNq+9+CotoU54s572GmiUGxJHIfQVaqSDWO91MIPN8vy+oHxjExvBOnwKU?=
 =?us-ascii?Q?Hc3cVBpCMxixZyo18dlG8FiufZGc6+FR/dv4T1REdqdR0xGK5Mo7mIVzovIY?=
 =?us-ascii?Q?koLRWXPxzI/PIXCZ2m6fMJ/9jJX8M1Q27EJ1HcLowYWC81rS9MD98cIRDw2Y?=
 =?us-ascii?Q?xOPD0giW4CksQ8WzQoZF0uAaamqU+HzqdEod5S57j0St6WvUBrv3oGXuu2SN?=
 =?us-ascii?Q?/YlQNeWI7fZpG+Dfv1NaeWQEiMR4xbPRr+lTwgBZbRTw/SIVH87UbMNRdVIO?=
 =?us-ascii?Q?wgSeeWXjmw3rd697jgStJSbJDz7aOtKkuwEpNdnyyhcQW3FrFK6F+L3Vy+FY?=
 =?us-ascii?Q?Pjzr1KibkXfsGTfxZNScuhh0b5IkU7STZHpaAUoRutJ+jNc9TzCtDbLqNd++?=
 =?us-ascii?Q?4XOMAM+FR5cjGbzLBsf22yBqHJ06miThqXgV9YnzxvEWSYdEQq+j9tnioTh/?=
 =?us-ascii?Q?ha8//3Kt3fUsGB8m7XqvU/uecwVcISq8hSS6ROmvupj0H/L4INPCmtYTbA/0?=
 =?us-ascii?Q?Ie9NYHbw1cncpqiystuKy1LB9hUf/mxS4Y96X9CltlVf9GF0dJv84VT0gBuo?=
 =?us-ascii?Q?1KrhYOV+pqtSiSWyIqk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c43f72-65e5-4926-23a7-08dba26214d6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:17:14.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDXwRSLGmNR/XI+eNHxa2jBczDA3bf169VVOLuBndxMAJgo7bhjNqzTub/Wstd8h89YMgDOa3ytiCImPLNH7Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Significant alterations have been made to the EDMA v3's register layout.
Now, each channel possesses a separate address space, encapsulating all
channel-related controls and statuses, including IRQs. There are changes
in bit position definitions as well. However, the fundamental control flow
remains analogous to the previous versions.

EDMA v3 was utilized in imx8qm, imx93, and will be in forthcoming chips.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 158 +++++++++++++++++++---
 drivers/dma/fsl-edma-common.h |  73 +++++++++-
 drivers/dma/fsl-edma-main.c   | 245 +++++++++++++++++++++++++++++++++-
 3 files changed, 453 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 13c328728025..a0f5741abcc4 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -7,6 +7,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 
 #include "fsl-edma-common.h"
 
@@ -66,11 +68,46 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
 	spin_unlock(&fsl_chan->vchan.lock);
 }
 
+static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
+{
+	u32 val, flags;
+
+	flags = fsl_edma_drvflags(fsl_chan);
+	val = edma_readl_chreg(fsl_chan, ch_sbr);
+	/* Remote/local swapped wrongly on iMX8 QM Audio edma */
+	if (flags & FSL_EDMA_DRV_QUIRK_SWAPPED) {
+		if (!fsl_chan->is_rxchan)
+			val |= EDMA_V3_CH_SBR_RD;
+		else
+			val |= EDMA_V3_CH_SBR_WR;
+	} else {
+		if (fsl_chan->is_rxchan)
+			val |= EDMA_V3_CH_SBR_RD;
+		else
+			val |= EDMA_V3_CH_SBR_WR;
+	}
+
+	if (fsl_chan->is_remote)
+		val &= ~(EDMA_V3_CH_SBR_RD | EDMA_V3_CH_SBR_WR);
+
+	edma_writel_chreg(fsl_chan, val, ch_sbr);
+
+	if (flags & FSL_EDMA_DRV_HAS_CHMUX)
+		edma_writel_chreg(fsl_chan, fsl_chan->srcid, ch_mux);
+
+	val = edma_readl_chreg(fsl_chan, ch_csr);
+	val |= EDMA_V3_CH_CSR_ERQ;
+	edma_writel_chreg(fsl_chan, val, ch_csr);
+}
+
 static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 {
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_SPLIT_REG)
+		return fsl_edma3_enable_request(fsl_chan);
+
 	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
 		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
 		edma_writeb(fsl_chan->edma, ch, regs->serq);
@@ -83,11 +120,28 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 	}
 }
 
+static void fsl_edma3_disable_request(struct fsl_edma_chan *fsl_chan)
+{
+	u32 val = edma_readl_chreg(fsl_chan, ch_csr);
+	u32 flags;
+
+	flags = fsl_edma_drvflags(fsl_chan);
+
+	if (flags & FSL_EDMA_DRV_HAS_CHMUX)
+		edma_writel_chreg(fsl_chan, 0, ch_mux);
+
+	val &= ~EDMA_V3_CH_CSR_ERQ;
+	edma_writel_chreg(fsl_chan, val, ch_csr);
+}
+
 void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 {
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_SPLIT_REG)
+		return fsl_edma3_disable_request(fsl_chan);
+
 	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
 		edma_writeb(fsl_chan->edma, ch, regs->cerq);
 		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
@@ -135,6 +189,9 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	int endian_diff[4] = {3, 1, -1, -3};
 	u32 dmamux_nr = fsl_chan->edma->drvdata->dmamuxs;
 
+	if (!dmamux_nr)
+		return;
+
 	chans_per_mux = fsl_chan->edma->n_chans / dmamux_nr;
 	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
 
@@ -186,6 +243,10 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
+
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
+		pm_runtime_allow(fsl_chan->pd_dev);
+
 	return 0;
 }
 
@@ -286,12 +347,16 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 	enum dma_transfer_direction dir = edesc->dirn;
 	dma_addr_t cur_addr, dma_addr;
 	size_t len, size;
+	u32 nbytes = 0;
 	int i;
 
 	/* calculate the total size in this desc */
-	for (len = i = 0; i < fsl_chan->edesc->n_tcds; i++)
-		len += le32_to_cpu(edesc->tcd[i].vtcd->nbytes)
-			* le16_to_cpu(edesc->tcd[i].vtcd->biter);
+	for (len = i = 0; i < fsl_chan->edesc->n_tcds; i++) {
+		nbytes = le32_to_cpu(edesc->tcd[i].vtcd->nbytes);
+		if (nbytes & (EDMA_V3_TCD_NBYTES_DMLOE | EDMA_V3_TCD_NBYTES_SMLOE))
+			nbytes = EDMA_V3_TCD_NBYTES_MLOFF_NBYTES(nbytes);
+		len += nbytes * le16_to_cpu(edesc->tcd[i].vtcd->biter);
+	}
 
 	if (!in_progress)
 		return len;
@@ -303,8 +368,12 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 
 	/* figure out the finished and calculate the residue */
 	for (i = 0; i < fsl_chan->edesc->n_tcds; i++) {
-		size = le32_to_cpu(edesc->tcd[i].vtcd->nbytes)
-			* le16_to_cpu(edesc->tcd[i].vtcd->biter);
+		nbytes = le32_to_cpu(edesc->tcd[i].vtcd->nbytes);
+		if (nbytes & (EDMA_V3_TCD_NBYTES_DMLOE | EDMA_V3_TCD_NBYTES_SMLOE))
+			nbytes = EDMA_V3_TCD_NBYTES_MLOFF_NBYTES(nbytes);
+
+		size = nbytes * le16_to_cpu(edesc->tcd[i].vtcd->biter);
+
 		if (dir == DMA_MEM_TO_DEV)
 			dma_addr = le32_to_cpu(edesc->tcd[i].vtcd->saddr);
 		else
@@ -389,12 +458,15 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 }
 
 static inline
-void fsl_edma_fill_tcd(struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
+void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
+		       struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
 		       u16 attr, u16 soff, u32 nbytes, u32 slast, u16 citer,
 		       u16 biter, u16 doff, u32 dlast_sga, bool major_int,
 		       bool disable_req, bool enable_sg)
 {
+	struct dma_slave_config *cfg = &fsl_chan->cfg;
 	u16 csr = 0;
+	u32 burst;
 
 	/*
 	 * eDMA hardware SGs require the TCDs to be stored in little
@@ -409,6 +481,21 @@ void fsl_edma_fill_tcd(struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
 
 	tcd->soff = cpu_to_le16(soff);
 
+	if (fsl_chan->is_multi_fifo) {
+		/* set mloff to support multiple fifo */
+		burst = cfg->direction == DMA_DEV_TO_MEM ?
+				cfg->src_addr_width : cfg->dst_addr_width;
+		nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-(burst * 4));
+		/* enable DMLOE/SMLOE */
+		if (cfg->direction == DMA_MEM_TO_DEV) {
+			nbytes |= EDMA_V3_TCD_NBYTES_DMLOE;
+			nbytes &= ~EDMA_V3_TCD_NBYTES_SMLOE;
+		} else {
+			nbytes |= EDMA_V3_TCD_NBYTES_SMLOE;
+			nbytes &= ~EDMA_V3_TCD_NBYTES_DMLOE;
+		}
+	}
+
 	tcd->nbytes = cpu_to_le32(nbytes);
 	tcd->slast = cpu_to_le32(slast);
 
@@ -427,6 +514,12 @@ void fsl_edma_fill_tcd(struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
 	if (enable_sg)
 		csr |= EDMA_TCD_CSR_E_SG;
 
+	if (fsl_chan->is_rxchan)
+		csr |= EDMA_TCD_CSR_ACTIVE;
+
+	if (fsl_chan->is_sw)
+		csr |= EDMA_TCD_CSR_START;
+
 	tcd->csr = cpu_to_le16(csr);
 }
 
@@ -466,6 +559,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	struct fsl_edma_desc *fsl_desc;
 	dma_addr_t dma_buf_next;
+	bool major_int = true;
 	int sg_len, i;
 	u32 src_addr, dst_addr, last_sg, nbytes;
 	u16 soff, doff, iter;
@@ -509,17 +603,23 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 			src_addr = dma_buf_next;
 			dst_addr = fsl_chan->dma_dev_addr;
 			soff = fsl_chan->cfg.dst_addr_width;
-			doff = 0;
-		} else {
+			doff = fsl_chan->is_multi_fifo ? 4 : 0;
+		} else if (direction == DMA_DEV_TO_MEM) {
 			src_addr = fsl_chan->dma_dev_addr;
 			dst_addr = dma_buf_next;
-			soff = 0;
+			soff = fsl_chan->is_multi_fifo ? 4 : 0;
 			doff = fsl_chan->cfg.src_addr_width;
+		} else {
+			/* DMA_DEV_TO_DEV */
+			src_addr = fsl_chan->cfg.src_addr;
+			dst_addr = fsl_chan->cfg.dst_addr;
+			soff = doff = 0;
+			major_int = false;
 		}
 
-		fsl_edma_fill_tcd(fsl_desc->tcd[i].vtcd, src_addr, dst_addr,
+		fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr, dst_addr,
 				  fsl_chan->attr, soff, nbytes, 0, iter,
-				  iter, doff, last_sg, true, false, true);
+				  iter, doff, last_sg, major_int, false, true);
 		dma_buf_next += period_len;
 	}
 
@@ -568,23 +668,51 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 			dst_addr = fsl_chan->dma_dev_addr;
 			soff = fsl_chan->cfg.dst_addr_width;
 			doff = 0;
-		} else {
+		} else if (direction == DMA_DEV_TO_MEM) {
 			src_addr = fsl_chan->dma_dev_addr;
 			dst_addr = sg_dma_address(sg);
 			soff = 0;
 			doff = fsl_chan->cfg.src_addr_width;
+		} else {
+			/* DMA_DEV_TO_DEV */
+			src_addr = fsl_chan->cfg.src_addr;
+			dst_addr = fsl_chan->cfg.dst_addr;
+			soff = 0;
+			doff = 0;
 		}
 
+		/*
+		 * Choose the suitable burst length if sg_dma_len is not
+		 * multiple of burst length so that the whole transfer length is
+		 * multiple of minor loop(burst length).
+		 */
+		if (sg_dma_len(sg) % nbytes) {
+			u32 width = (direction == DMA_DEV_TO_MEM) ? doff : soff;
+			u32 burst = (direction == DMA_DEV_TO_MEM) ?
+						fsl_chan->cfg.src_maxburst :
+						fsl_chan->cfg.dst_maxburst;
+			int j;
+
+			for (j = burst; j > 1; j--) {
+				if (!(sg_dma_len(sg) % (j * width))) {
+					nbytes = j * width;
+					break;
+				}
+			}
+			/* Set burst size as 1 if there's no suitable one */
+			if (j == 1)
+				nbytes = width;
+		}
 		iter = sg_dma_len(sg) / nbytes;
 		if (i < sg_len - 1) {
 			last_sg = fsl_desc->tcd[(i + 1)].ptcd;
-			fsl_edma_fill_tcd(fsl_desc->tcd[i].vtcd, src_addr,
+			fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
 					  dst_addr, fsl_chan->attr, soff,
 					  nbytes, 0, iter, iter, doff, last_sg,
 					  false, false, true);
 		} else {
 			last_sg = 0;
-			fsl_edma_fill_tcd(fsl_desc->tcd[i].vtcd, src_addr,
+			fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
 					  dst_addr, fsl_chan->attr, soff,
 					  nbytes, 0, iter, iter, doff, last_sg,
 					  true, true, false);
@@ -609,7 +737,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 	fsl_chan->is_sw = true;
 
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
-	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
+	fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
 			fsl_edma_get_tcd_attr(DMA_SLAVE_BUSWIDTH_32_BYTES),
 			32, len, 0, 1, 1, 32, 0, true, true, false);
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index cfc41915eaa1..3cc0cc8fc2d0 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -42,6 +42,11 @@
 #define EDMA_TCD_CSR_ACTIVE		BIT(6)
 #define EDMA_TCD_CSR_DONE		BIT(7)
 
+#define EDMA_V3_TCD_NBYTES_MLOFF_NBYTES(x) ((x) & GENMASK(9, 0))
+#define EDMA_V3_TCD_NBYTES_MLOFF(x)        (x << 10)
+#define EDMA_V3_TCD_NBYTES_DMLOE           (1 << 30)
+#define EDMA_V3_TCD_NBYTES_SMLOE           (1 << 31)
+
 #define EDMAMUX_CHCFG_DIS		0x0
 #define EDMAMUX_CHCFG_ENBL		0x80
 #define EDMAMUX_CHCFG_SOURCE(n)		((n) & 0x3F)
@@ -54,6 +59,15 @@
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
+
+#define EDMA_V3_CH_SBR_RD          BIT(22)
+#define EDMA_V3_CH_SBR_WR          BIT(21)
+#define EDMA_V3_CH_CSR_ERQ         BIT(0)
+#define EDMA_V3_CH_CSR_EARQ        BIT(1)
+#define EDMA_V3_CH_CSR_EEI         BIT(2)
+#define EDMA_V3_CH_CSR_DONE        BIT(30)
+#define EDMA_V3_CH_CSR_ACTIVE      BIT(31)
+
 enum fsl_edma_pm_state {
 	RUNNING = 0,
 	SUSPENDED,
@@ -73,6 +87,18 @@ struct fsl_edma_hw_tcd {
 	__le16	biter;
 };
 
+struct fsl_edma3_ch_reg {
+	__le32	ch_csr;
+	__le32	ch_es;
+	__le32	ch_int;
+	__le32	ch_sbr;
+	__le32	ch_pri;
+	__le32	ch_mux;
+	__le32  ch_mattr; /* edma4, reserved for edma3 */
+	__le32  ch_reserved;
+	struct fsl_edma_hw_tcd tcd;
+} __packed;
+
 /*
  * These are iomem pointers, for both v32 and v64.
  */
@@ -119,6 +145,18 @@ struct fsl_edma_chan {
 	enum dma_data_direction		dma_dir;
 	char				chan_name[32];
 	struct fsl_edma_hw_tcd __iomem *tcd;
+	u32				real_count;
+	struct work_struct		issue_worker;
+	struct platform_device		*pdev;
+	struct device			*pd_dev;
+	u32				srcid;
+	struct clk			*clk;
+	int                             priority;
+	int				hw_chanid;
+	int				txirq;
+	bool				is_rxchan;
+	bool				is_remote;
+	bool				is_multi_fifo;
 };
 
 struct fsl_edma_desc {
@@ -135,8 +173,26 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_CONFIG32		BIT(2)
 #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
 #define FSL_EDMA_DRV_EDMA64		BIT(4)
+#define FSL_EDMA_DRV_HAS_PD		BIT(5)
+#define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
+#define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
+/* imx8 QM audio edma remote local swapped */
+#define FSL_EDMA_DRV_QUIRK_SWAPPED	BIT(8)
+/* control and status register is in tcd address space, edma3 reg layout */
+#define FSL_EDMA_DRV_SPLIT_REG		BIT(9)
+#define FSL_EDMA_DRV_BUS_8BYTE		BIT(10)
+#define FSL_EDMA_DRV_DEV_TO_DEV		BIT(11)
+#define FSL_EDMA_DRV_ALIGN_64BYTE	BIT(12)
+
+#define FSL_EDMA_DRV_EDMA3	(FSL_EDMA_DRV_SPLIT_REG |	\
+				 FSL_EDMA_DRV_BUS_8BYTE |	\
+				 FSL_EDMA_DRV_DEV_TO_DEV |	\
+				 FSL_EDMA_DRV_ALIGN_64BYTE)
+
 struct fsl_edma_drvdata {
-	u32			dmamuxs;
+	u32			dmamuxs; /* only used before v3 */
+	u32			chreg_off;
+	u32			chreg_space_sz;
 	u32			flags;
 	int			(*setup_irq)(struct platform_device *pdev,
 					     struct fsl_edma_engine *fsl_edma);
@@ -148,6 +204,7 @@ struct fsl_edma_engine {
 	void __iomem		*muxbase[DMAMUX_NR];
 	struct clk		*muxclk[DMAMUX_NR];
 	struct clk		*dmaclk;
+	struct clk		*chclk;
 	struct mutex		fsl_edma_mutex;
 	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
@@ -155,6 +212,7 @@ struct fsl_edma_engine {
 	int			errirq;
 	bool			big_endian;
 	struct edma_regs	regs;
+	u64			chan_masked;
 	struct fsl_edma_chan	chans[];
 };
 
@@ -168,6 +226,14 @@ struct fsl_edma_engine {
 	edma_writel(chan->edma, (u32 __force)val, &chan->tcd->__name) :	\
 	edma_writew(chan->edma, (u16 __force)val, &chan->tcd->__name))
 
+#define edma_readl_chreg(chan, __name)				\
+	edma_readl(chan->edma,					\
+		   (void __iomem *)&(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
+
+#define edma_writel_chreg(chan, val,  __name)			\
+	edma_writel(chan->edma, val,				\
+		   (void __iomem *)&(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
@@ -224,6 +290,11 @@ static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
 	return container_of(chan, struct fsl_edma_chan, vchan.chan);
 }
 
+static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
+{
+	return fsl_chan->edma->drvdata->flags;
+}
+
 static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
 {
 	return container_of(vd, struct fsl_edma_desc, vdesc);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 72b7587226df..63d48d046f04 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -18,9 +18,15 @@
 #include <linux/of_irq.h>
 #include <linux/of_dma.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 
 #include "fsl-edma-common.h"
 
+#define ARGS_RX                         BIT(0)
+#define ARGS_REMOTE                     BIT(1)
+#define ARGS_MULTI_FIFO                 BIT(2)
+
 static void fsl_edma_synchronize(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
@@ -47,6 +53,22 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t fsl_edma3_tx_handler(int irq, void *dev_id)
+{
+	struct fsl_edma_chan *fsl_chan = dev_id;
+	unsigned int intr;
+
+	intr = edma_readl_chreg(fsl_chan, ch_int);
+	if (!intr)
+		return IRQ_HANDLED;
+
+	edma_writel_chreg(fsl_chan, 1, ch_int);
+
+	fsl_edma_tx_chan_handler(fsl_chan);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *fsl_edma = dev_id;
@@ -108,6 +130,51 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 	return NULL;
 }
 
+static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
+					struct of_dma *ofdma)
+{
+	struct fsl_edma_engine *fsl_edma = ofdma->of_dma_data;
+	struct dma_chan *chan, *_chan;
+	struct fsl_edma_chan *fsl_chan;
+	bool b_chmux;
+	int i;
+
+	if (dma_spec->args_count != 3)
+		return NULL;
+
+	b_chmux = !!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHMUX);
+
+	mutex_lock(&fsl_edma->fsl_edma_mutex);
+	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels,
+					device_node) {
+
+		if (chan->client_count)
+			continue;
+
+		fsl_chan = to_fsl_edma_chan(chan);
+		i = fsl_chan - fsl_edma->chans;
+
+		chan = dma_get_slave_channel(chan);
+		chan->device->privatecnt++;
+		fsl_chan->priority = dma_spec->args[1];
+		fsl_chan->is_rxchan = dma_spec->args[2] & ARGS_RX;
+		fsl_chan->is_remote = dma_spec->args[2] & ARGS_REMOTE;
+		fsl_chan->is_multi_fifo = dma_spec->args[2] & ARGS_MULTI_FIFO;
+
+		if (!b_chmux && i == dma_spec->args[0]) {
+			mutex_unlock(&fsl_edma->fsl_edma_mutex);
+			return chan;
+		} else if (b_chmux && !fsl_chan->srcid) {
+			/* if controller support channel mux, choose a free channel */
+			fsl_chan->srcid = dma_spec->args[0];
+			mutex_unlock(&fsl_edma->fsl_edma_mutex);
+			return chan;
+		}
+	}
+	mutex_unlock(&fsl_edma->fsl_edma_mutex);
+	return NULL;
+}
+
 static int
 fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
@@ -149,6 +216,37 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 	return 0;
 }
 
+static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+
+		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
+
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
+
+		/* request channel irq */
+		fsl_chan->txirq = platform_get_irq(pdev, i);
+		if (fsl_chan->txirq < 0) {
+			dev_err(&pdev->dev, "Can't get chan %d's irq.\n", i);
+			return  -EINVAL;
+		}
+
+		ret = devm_request_irq(&pdev->dev, fsl_chan->txirq,
+			fsl_edma3_tx_handler, IRQF_SHARED,
+			fsl_chan->chan_name, fsl_chan);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't register chan%d's IRQ.\n", i);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int
 fsl_edma2_irq_init(struct platform_device *pdev,
 		   struct fsl_edma_engine *fsl_edma)
@@ -214,29 +312,108 @@ static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
 static struct fsl_edma_drvdata vf610_data = {
 	.dmamuxs = DMAMUX_NR,
 	.flags = FSL_EDMA_DRV_WRAP_IO,
+	.chreg_off = EDMA_TCD,
+	.chreg_space_sz = sizeof(struct fsl_edma_hw_tcd),
 	.setup_irq = fsl_edma_irq_init,
 };
 
 static struct fsl_edma_drvdata ls1028a_data = {
 	.dmamuxs = DMAMUX_NR,
 	.flags = FSL_EDMA_DRV_MUX_SWAP | FSL_EDMA_DRV_WRAP_IO,
+	.chreg_off = EDMA_TCD,
+	.chreg_space_sz = sizeof(struct fsl_edma_hw_tcd),
 	.setup_irq = fsl_edma_irq_init,
 };
 
 static struct fsl_edma_drvdata imx7ulp_data = {
 	.dmamuxs = 1,
+	.chreg_off = EDMA_TCD,
+	.chreg_space_sz = sizeof(struct fsl_edma_hw_tcd),
 	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_CONFIG32,
 	.setup_irq = fsl_edma2_irq_init,
 };
 
+static struct fsl_edma_drvdata imx8qm_data = {
+	.flags = FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3,
+	.chreg_space_sz = 0x10000,
+	.chreg_off = 0x10000,
+	.setup_irq = fsl_edma3_irq_init,
+};
+
+static struct fsl_edma_drvdata imx8qm_audio_data = {
+	.flags = FSL_EDMA_DRV_QUIRK_SWAPPED | FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3,
+	.chreg_space_sz = 0x10000,
+	.chreg_off = 0x10000,
+	.setup_irq = fsl_edma3_irq_init,
+};
+
+static struct fsl_edma_drvdata imx93_data3 = {
+	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
+	.chreg_space_sz = 0x10000,
+	.chreg_off = 0x10000,
+	.setup_irq = fsl_edma3_irq_init,
+};
+
+static struct fsl_edma_drvdata imx93_data4 = {
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
+	.chreg_space_sz = 0x8000,
+	.chreg_off = 0x10000,
+	.setup_irq = fsl_edma3_irq_init,
+};
+
 static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,vf610-edma", .data = &vf610_data},
 	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
 	{ .compatible = "fsl,imx7ulp-edma", .data = &imx7ulp_data},
+	{ .compatible = "fsl,imx8qm-edma", .data = &imx8qm_data},
+	{ .compatible = "fsl,imx8qm-adma", .data = &imx8qm_audio_data},
+	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
+	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
 
+static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
+{
+	struct fsl_edma_chan *fsl_chan;
+	struct device_link *link;
+	struct device *pd_chan;
+	struct device *dev;
+	int i;
+
+	dev = &pdev->dev;
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
+
+		fsl_chan = &fsl_edma->chans[i];
+
+		pd_chan = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR_OR_NULL(pd_chan)) {
+			dev_err(dev, "Failed attach pd %d\n", i);
+			return -EINVAL;
+		}
+
+		link = device_link_add(dev, pd_chan, DL_FLAG_STATELESS |
+					     DL_FLAG_PM_RUNTIME |
+					     DL_FLAG_RPM_ACTIVE);
+		if (IS_ERR(link)) {
+			dev_err(dev, "Failed to add device_link to %d: %ld\n", i,
+				PTR_ERR(link));
+			return -EINVAL;
+		}
+
+		fsl_chan->pd_dev = pd_chan;
+
+		pm_runtime_use_autosuspend(fsl_chan->pd_dev);
+		pm_runtime_set_autosuspend_delay(fsl_chan->pd_dev, 200);
+		pm_runtime_set_active(fsl_chan->pd_dev);
+	}
+
+	return 0;
+}
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
@@ -244,6 +421,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma;
 	const struct fsl_edma_drvdata *drvdata = NULL;
+	u32 chan_mask[2] = {0, 0};
 	struct edma_regs *regs;
 	int chans;
 	int ret, i;
@@ -274,8 +452,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (IS_ERR(fsl_edma->membase))
 		return PTR_ERR(fsl_edma->membase);
 
-	fsl_edma_setup_regs(fsl_edma);
-	regs = &fsl_edma->regs;
+	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)) {
+		fsl_edma_setup_regs(fsl_edma);
+		regs = &fsl_edma->regs;
+	}
 
 	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
 		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
@@ -285,9 +465,29 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
+		fsl_edma->chclk = devm_clk_get_enabled(&pdev->dev, "mp");
+		if (IS_ERR(fsl_edma->chclk)) {
+			dev_err(&pdev->dev, "Missing MP block clock.\n");
+			return PTR_ERR(fsl_edma->chclk);
+		}
+	}
+
+	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
+
+	if (ret > 0) {
+		fsl_edma->chan_masked = chan_mask[1];
+		fsl_edma->chan_masked <<= 32;
+		fsl_edma->chan_masked |= chan_mask[0];
+	}
+
 	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
 		char clkname[32];
 
+		/* eDMAv3 mux register move to TCD area if ch_mux exist */
+		if (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)
+			break;
+
 		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
 								      1 + i);
 		if (IS_ERR(fsl_edma->muxbase[i])) {
@@ -307,9 +507,19 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
 
+	if (drvdata->flags & FSL_EDMA_DRV_HAS_PD) {
+		ret = fsl_edma3_attach_pd(pdev, fsl_edma);
+		if (ret)
+			return ret;
+	}
+
 	INIT_LIST_HEAD(&fsl_edma->dma_dev.channels);
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
+		int len;
+
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
 
 		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
 							   dev_name(&pdev->dev), i);
@@ -320,8 +530,13 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->idle = true;
 		fsl_chan->dma_dir = DMA_NONE;
 		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
-		fsl_chan->tcd = fsl_edma->membase + EDMA_TCD
-				+ i * sizeof(struct fsl_edma_hw_tcd);
+
+		len = (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) ?
+				offsetof(struct fsl_edma3_ch_reg, tcd) : 0;
+		fsl_chan->tcd = fsl_edma->membase
+				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
+
+		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
 		edma_write_tcdreg(fsl_chan, 0, csr);
@@ -355,12 +570,25 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	fsl_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
 	fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
+
+	if (drvdata->flags & FSL_EDMA_DRV_BUS_8BYTE) {
+		fsl_edma->dma_dev.src_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		fsl_edma->dma_dev.dst_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	}
+
 	fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	if (drvdata->flags & FSL_EDMA_DRV_DEV_TO_DEV)
+		fsl_edma->dma_dev.directions |= BIT(DMA_DEV_TO_DEV);
+
+	fsl_edma->dma_dev.copy_align = drvdata->flags & FSL_EDMA_DRV_ALIGN_64BYTE ?
+					DMAENGINE_ALIGN_64_BYTES :
+					DMAENGINE_ALIGN_32_BYTES;
 
-	fsl_edma->dma_dev.copy_align = DMAENGINE_ALIGN_32_BYTES;
 	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
 	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
 
+	fsl_edma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+
 	platform_set_drvdata(pdev, fsl_edma);
 
 	ret = dma_async_device_register(&fsl_edma->dma_dev);
@@ -370,7 +598,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_dma_controller_register(np, fsl_edma_xlate, fsl_edma);
+	ret = of_dma_controller_register(np,
+			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
+			fsl_edma);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
@@ -379,7 +609,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	}
 
 	/* enable round robin arbitration */
-	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
+	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
+		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
 
 	return 0;
 }
-- 
2.34.1

