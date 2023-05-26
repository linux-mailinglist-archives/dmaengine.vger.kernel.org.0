Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7302C7128B6
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbjEZOkT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244028AbjEZOjy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:39:54 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38C51BB;
        Fri, 26 May 2023 07:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBsS3Uh0iAEKs191ktNi3dwkfkrpXmvWhvpD+HXaMYabYwwX4KgvWL1wueFXvyX5aUfqmcBWHDyFyDz6R4GlWTZkxroUqEse/apbrb8kllbPxRXu2xmrTRl+nGbPToae6OBsN5nvZ1u8Urue95mU4Z0prfDx/0J0ns1OTmlnZpGxU14BCPPjSh6c/uDH3yif0B9epA1rGQaPkryL8DQQuXCFW659zsfmmJOgC71JJGJXymd3HjXKk8GTcg+eXBmvP+DaKXnG4Zp2AxgWiix0UcspIuljgmAqNwrkmp1eH8i5AZICa+B33PRF6ZqsYz63MK/5SXr8Nht9o9KIAqns4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoyBP3o8tbGGMAFj8900HK96vampePzG8c9OuQqZf3A=;
 b=i+mULRnufFq+VEBgZOEO2q09nOUJ6FCq/y0d35IRCDGE80ziByXdkG2oNdXGlJxFhGex62o0EhHaWd5PbCxnwvEiyvq9cCksRknIYvOpcZSBJDCos4/We7TW6hzvLJAaTnlM01IKAI14V/bD7S5Pu18sKklDb5yYVrJPpczY7Dxqivz1GhYUXRaa4Neg41Qa+Tu8lTUQAppEr6uQwYelDhYKdj15qVtB34hpMrp6tnQOQAfPEGlntZ/djnsguKeZ9ytxMCInvUPqKYyH0BfK5m0GwI7J5aAiacDHUsu3oh5L0/557+HR5hoJC3Rz1gWeQX3HcJrqXT3QNHjJXpogyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoyBP3o8tbGGMAFj8900HK96vampePzG8c9OuQqZf3A=;
 b=XqhD+h+rCRfUUHPqw/JMXIl41sWx5pPzqI8UG6a/p0aCtlrlt3SdJu7nniGHoCWGhfR3R4Tw1KfYsMOShMAjgXg3GiSuLgRf7DLiWnLUGo1C60uTfaDpVW2QDj8iAdVr3+OFSNygTXQoHwBqZjVBJ4Gprt8irj1+TIDD+xnGZVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:29 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:29 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 11/12] dmaengine: fsl-edma: integrate v3 support
Date:   Fri, 26 May 2023 10:36:38 -0400
Message-Id: <20230526143639.1037099-12-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0fc936df-a9ba-4500-e345-08db5df6bb1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45OstT9ODqSYB+LM35Xd1IHx3cj+D1IxiSZp15KsHZjDzH3YXDl2ia3bGAu4wslGEuyD9HDKhMS1Xs/ayWDRh71DHhiGf/8al96FDP4WsqUI3xY6ZiW0LsxKtKgpBidZu+bQr98bLnUX6GYGh4RgS6qjslcT7GEhG2zgD2IdKGPTtb6NYPOXfQUq/J7/u8VoYcCACBRCfaJr7LHHLJeAibLVXyF0sArSe7c7Vg+bD0ogbRhVpIUhGk9PuOP/oHMRgg7GGdoghl6F88ohYM0wYESqmJdPaMQtxCMwoACfSI+GnE13Tzf+HtmL7OCCpzTxgExiz5hGEk/eucuL8ZymMgsu7uhTfHMURJnqpYTvWYtq4KG7VJtGGUQTeB3vh3YqYsWD5pQjfj2Tg+jq03Qc0etjUlIcg6ZnQxPkou1ZiIUTx/pvJ3/Uw6EZOjvc9NPv2MrH8oHXhXQ8Q0WICNrztrhqjIJBsfFU/5aKTgZGQ08Va/Wluwf/ajCKRHY69Yq+kEHxGcGgJItjbqSwyyJZmx929TxSH051t6BGkkcJo0ePHqQbguGtAL4T/+V6tUT9rkoyRKbp1ClDgF4vMtJEu4S6Uyx0OCLjcu2PhtXHeP2voK7adHteKlsO7zzYm+9bw2o7tkdObLp6Cx4SQ4ebmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(30864003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aFLKY2j25mVgdplXsZEZzSB6oYiXiXsANvAfEWdjvSWcF/VlsxWF/4R+ng+A?=
 =?us-ascii?Q?1iljt76wWjQCLJkdGPKLHp6T6HJ60wr5afOKvoaOWBT9I4ThFlW9f0yzjoNe?=
 =?us-ascii?Q?Xjvbfa9joh9p8boWLkjUp8cjbEP0170PRcTL8L9cPwYL2l3hwOc8MpbQFc+u?=
 =?us-ascii?Q?U1wGy195nYdhbkvpYf7mOTyVMa5idTJ8Pnmg38HBl5sqxV9fIF7I69+ozs4Y?=
 =?us-ascii?Q?VkZnLRocrJvqM8X5ZBph+44BrQ+mQmJiaGg3fj/hurWi327iLbkikDVBrZ9C?=
 =?us-ascii?Q?9MmFHfIiwtCGHpBc4PkvZGbrtijMr+y4Eg3+fgn2oS2FNPdgiNu+6+Rt05cP?=
 =?us-ascii?Q?9mrEGsTzd1dANevqlvMwco0B3/gWziPUSuoMDex2pcuGUwTX9gnpx/Idu68q?=
 =?us-ascii?Q?U4oovao6r4Vey4QT1/lqQgEvN+WBTai88fkdNqwRmINYmIqq14r3iQ5IY5zm?=
 =?us-ascii?Q?aJS9q4hkJph9a/buT/0wbQsJBOP/04iQcm/DTtBNMFBSHZdQpUcwUWerrJZj?=
 =?us-ascii?Q?c7HqcFJmGpifKDQIeL2qjewZPazwp31C/4gUK5KjPFqyY+NlXJG6f4f3yrH8?=
 =?us-ascii?Q?NfVF0IHjiI5Mq1YbPtmNbBBhGR4S5hVImxvIHzIvMJT+a2MndbyB3fLqdNPw?=
 =?us-ascii?Q?H8G1IDzU5moYDAaHup8vaGPoGyHUP6K96f4ZWXknsQ8WCHQd+u81MvIBRuR8?=
 =?us-ascii?Q?c5bmJpfrUFEIx6h9N62hbtcwo3p8eZq1yJm0/6sy57XPfRlctMWOaozECWXW?=
 =?us-ascii?Q?x3BkArgxb+brRk8hrB9CpBjfKOD89ZMKOk3iSaOFfpaBFLvsu4CAFXiLszYh?=
 =?us-ascii?Q?CB2G00Qan2ppnb+qdTycCAMkj5meLoQlzepr9j3lLD+h05PriRjF0//q2Z0c?=
 =?us-ascii?Q?eJKC7wTScVbFs97+g7+5bhsswDTTeNpquPaAjoE6OIXc/31Pluzc3+NkHDeG?=
 =?us-ascii?Q?CHvm9SveZV8YM8UpJw+4VziQ4h5UaUILymXhwnzmZH9V/zuIX9NVqMrwftBf?=
 =?us-ascii?Q?x4EJZ+qJSWRjHr0M4SmBRtSl+9QeZoiOqJx2ktns4JncYaoOSW0k0HzNw5fs?=
 =?us-ascii?Q?uNAVVZHDLX2NAyRe6cv1uZEcORDhCv0o5YXDODWiIiC3eXOdM4W5/0+RerWp?=
 =?us-ascii?Q?Lg4JDsg/I9aEzxUJ86qNDLw0j0gA9Kfc+8gd2HXgw/B6JgZ4DxXQ0zfwaWYd?=
 =?us-ascii?Q?iyPzY0GRuCESJBWrSvlkCifOA7bRiLBU0RCIlHycqdzDf9wRJOqiutyhfbB1?=
 =?us-ascii?Q?VoEn5Xsrv6pjTCnfC2/hN9uISJ6VrrR0etGSJ3WPVfB1q4QeCmyAcoPl1hDl?=
 =?us-ascii?Q?J6ZuKplQG/Ww7CCVWsdi66dmQKMtvT9JSUYbtOq6J666pmgyFl/PJxzClT+X?=
 =?us-ascii?Q?5Ap5fYdezBzKuG1gNPixycfZ9+k+NoJ6/DQ8BAu5LjpWv5iLfa+TspVyY0R7?=
 =?us-ascii?Q?HuDZNh2N/VF3wqZiuMhPKCSGOJ/YDeRky+HDHHmI6EQm1w8IElQD1Y0U07Dw?=
 =?us-ascii?Q?2arydpi1w4JDCWbZ8RCIeN53G1oUYxBcFL74A3ao7MsQp/MTp4p6Q6rIojjg?=
 =?us-ascii?Q?kHasjRSpvXAeQclzEvcxzsqcDs8pOsfSWE9R0Xld?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc936df-a9ba-4500-e345-08db5df6bb1b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:28.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNrplkRr9ln7nLj6XM0LAedWAAlAT3nB4PQOtHi7icM5l4MZbNO8y9TJfznKuJXXNy3GWjmvAI2lCQSD8X5IbQ==
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

Significant alterations have been made to the EDMA v3's register layout.
Now, each channel possesses a separate address space, encapsulating all
channel-related controls and statuses, including IRQs. There are changes
in bit position definitions as well. However, the fundamental control flow
remains analogous to the previous versions.

EDMA v3 was utilized in imx8qm, imx93, and will be in forthcoming chips.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 162 +++++++++++++++++++---
 drivers/dma/fsl-edma-common.h |  71 +++++++++-
 drivers/dma/fsl-edma-main.c   | 252 ++++++++++++++++++++++++++++++++--
 3 files changed, 456 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 186b5c41d07f..946db5733202 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -7,6 +7,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 
 #include "fsl-edma-common.h"
 
@@ -66,12 +68,48 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
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
+	if ((flags & (FSL_EDMA_DRV_AXI | FSL_EDMA_DRV_HAS_CHMUX)) &&
+	    fsl_chan->srcid && !edma_readl_chreg(fsl_chan, ch_mux))
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
 
-	if (fsl_chan->edma->drvdata->version == v1) {
+	if (fsl_edma_ver(fsl_chan) >= v3)
+		return fsl_edma3_enable_request(fsl_chan);
+
+	if (fsl_edma_ver(fsl_chan) == v1) {
 		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
 		edma_writeb(fsl_chan->edma, ch, regs->serq);
 	} else {
@@ -83,12 +121,30 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 	}
 }
 
+static void fsl_edma3_disable_request(struct fsl_edma_chan *fsl_chan)
+{
+	u32 val = edma_readl_chreg(fsl_chan, ch_csr);
+	u32 flags;
+
+	flags = fsl_edma_drvflags(fsl_chan);
+
+	if ((flags & (FSL_EDMA_DRV_AXI | FSL_EDMA_DRV_HAS_CHMUX)) &&
+	    fsl_chan->srcid)
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
 
-	if (fsl_chan->edma->drvdata->version == v1) {
+	if (fsl_edma_ver(fsl_chan) >= v3)
+		return fsl_edma3_disable_request(fsl_chan);
+
+	if (fsl_edma_ver(fsl_chan) == v1) {
 		edma_writeb(fsl_chan->edma, ch, regs->cerq);
 		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
 	} else {
@@ -186,6 +242,10 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
+
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
+		pm_runtime_allow(fsl_chan->pd_dev);
+
 	return 0;
 }
 
@@ -286,12 +346,16 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
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
@@ -303,8 +367,12 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 
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
@@ -389,13 +457,15 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
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
-
+	u32 burst;
 	/*
 	 * eDMA hardware SGs require the TCDs to be stored in little
 	 * endian format irrespective of the register endian model.
@@ -409,6 +479,21 @@ void fsl_edma_fill_tcd(struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
 
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
 
@@ -427,6 +512,12 @@ void fsl_edma_fill_tcd(struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
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
 
@@ -466,6 +557,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	struct fsl_edma_desc *fsl_desc;
 	dma_addr_t dma_buf_next;
+	bool major_int = true;
 	int sg_len, i;
 	u32 src_addr, dst_addr, last_sg, nbytes;
 	u16 soff, doff, iter;
@@ -509,17 +601,23 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
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
 
@@ -568,23 +666,51 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
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
@@ -609,7 +735,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 	fsl_chan->is_sw = true;
 
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
-	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
+	fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
 			fsl_edma_get_tcd_attr(DMA_SLAVE_BUSWIDTH_32_BYTES),
 			32, len, 0, 1, 1, 32, 0, true, true, false);
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 0a95fd5d74f5..32d403a63686 100644
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
@@ -131,16 +169,27 @@ struct fsl_edma_desc {
 };
 
 enum edma_version {
-	v1, /* 32ch, Vybrid, mpc57x, etc */
+	v1, /* 32ch, Vybrid, mpc57x, imx7ulp etc */
 	v2, /* 64ch Coldfire */
+	v3, /* imx8qm, imx8qxp, imx93 edma3 */
+	v4, /* imx93 edma4 */
 };
 
 #define FSL_EDMA_DRV_HAS_DMACLK		BIT(0)
 #define FSL_EDMA_DRV_MUX_SWAP		BIT(1)
 #define FSL_EDMA_DRV_CONFIG32		BIT(2)
+#define FSL_EDMA_DRV_HAS_PD		BIT(3)
+#define FSL_EDMA_DRV_HAS_CHCLK		BIT(4)
+#define FSL_EDMA_DRV_HAS_CHMUX		BIT(5)
+/* imx8 QM audio edma remote local swapped */
+#define FSL_EDMA_DRV_QUIRK_SWAPPED	BIT(6)
+#define FSL_EDMA_DRV_AXI		BIT(7)
+
 struct fsl_edma_drvdata {
 	enum edma_version	version;
 	u32			dmamuxs;
+	u32			chreg_off;
+	u32			chreg_space_sz;
 	u32			flags;
 	int			(*setup_irq)(struct platform_device *pdev,
 					     struct fsl_edma_engine *fsl_edma);
@@ -152,6 +201,7 @@ struct fsl_edma_engine {
 	void __iomem		*muxbase[DMAMUX_NR];
 	struct clk		*muxclk[DMAMUX_NR];
 	struct clk		*dmaclk;
+	struct clk		*chclk;
 	struct mutex		fsl_edma_mutex;
 	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
@@ -159,6 +209,7 @@ struct fsl_edma_engine {
 	int			errirq;
 	bool			big_endian;
 	struct edma_regs	regs;
+	u64			chan_masked;
 	struct fsl_edma_chan	chans[];
 };
 
@@ -172,6 +223,14 @@ struct fsl_edma_engine {
 	edma_writel(chan->edma, val, &chan->tcd->__name) :	\
 	edma_writew(chan->edma, val, &chan->tcd->__name))
 
+#define edma_readl_chreg(chan, __name)				\
+	edma_readl(chan->edma,					\
+		   &(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
+
+#define edma_writel_chreg(chan, val,  __name)			\
+	edma_writel(chan->edma, val,				\
+		   &(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
@@ -228,6 +287,16 @@ static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
 	return container_of(chan, struct fsl_edma_chan, vchan.chan);
 }
 
+static inline int fsl_edma_ver(struct fsl_edma_chan *fsl_chan)
+{
+	return fsl_chan->edma->drvdata->version;
+}
+
+static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
+{
+	return fsl_chan->edma->drvdata->flags;
+}
+
 static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
 {
 	return container_of(vd, struct fsl_edma_desc, vdesc);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 8d1d0100f6e6..b82a48226a11 100644
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
@@ -108,6 +130,52 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 	return NULL;
 }
 
+static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
+					struct of_dma *ofdma)
+{
+	struct fsl_edma_engine *fsl_edma = ofdma->of_dma_data;
+	struct dma_chan *chan, *_chan;
+	struct fsl_edma_chan *fsl_chan;
+	int i;
+
+	if (dma_spec->args_count != 3)
+		return NULL;
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
+		if (fsl_edma->drvdata->dmamuxs == 0 && i == dma_spec->args[0]) {
+			chan = dma_get_slave_channel(chan);
+			chan->device->privatecnt++;
+			fsl_chan->priority = dma_spec->args[1];
+			fsl_chan->is_rxchan = dma_spec->args[2] & ARGS_RX;
+			fsl_chan->is_remote = dma_spec->args[2] & ARGS_REMOTE;
+			fsl_chan->is_multi_fifo = dma_spec->args[2] & ARGS_MULTI_FIFO;
+			mutex_unlock(&fsl_edma->fsl_edma_mutex);
+			return chan;
+		} else if ((fsl_edma->drvdata->dmamuxs ||
+			   (fsl_edma->drvdata->flags & FSL_EDMA_DRV_AXI)) && !fsl_chan->srcid) {
+			chan = dma_get_slave_channel(chan);
+			chan->device->privatecnt++;
+			fsl_chan->priority = dma_spec->args[1];
+			fsl_chan->srcid = dma_spec->args[0];
+			fsl_chan->is_rxchan = dma_spec->args[2] & ARGS_RX;
+			fsl_chan->is_remote = dma_spec->args[2] & ARGS_REMOTE;
+			fsl_chan->is_multi_fifo = dma_spec->args[2] & ARGS_MULTI_FIFO;
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
@@ -149,6 +217,37 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
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
@@ -203,12 +302,16 @@ static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
 static struct fsl_edma_drvdata vf610_data = {
 	.version = v1,
 	.dmamuxs = DMAMUX_NR,
+	.chreg_off = EDMA_TCD,
+	.chreg_space_sz = sizeof(struct fsl_edma_hw_tcd),
 	.setup_irq = fsl_edma_irq_init,
 };
 
 static struct fsl_edma_drvdata ls1028a_data = {
 	.version = v1,
 	.dmamuxs = DMAMUX_NR,
+	.chreg_off = EDMA_TCD,
+	.chreg_space_sz = sizeof(struct fsl_edma_hw_tcd),
 	.flags = FSL_EDMA_DRV_MUX_SWAP,
 	.setup_irq = fsl_edma_irq_init,
 };
@@ -216,18 +319,100 @@ static struct fsl_edma_drvdata ls1028a_data = {
 static struct fsl_edma_drvdata imx7ulp_data = {
 	.version = v1,
 	.dmamuxs = 1,
+	.chreg_off = EDMA_TCD,
+	.chreg_space_sz = sizeof(struct fsl_edma_hw_tcd),
 	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_CONFIG32,
 	.setup_irq = fsl_edma2_irq_init,
 };
 
+static struct fsl_edma_drvdata imx8qm_data = {
+	.version = v3,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_PD,
+	.chreg_space_sz = 0x10000,
+	.chreg_off = 0x10000,
+	.setup_irq = fsl_edma3_irq_init,
+};
+
+static struct fsl_edma_drvdata imx8qm_audio_data = {
+	.version = v3,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_QUIRK_SWAPPED |
+		 FSL_EDMA_DRV_HAS_PD,
+	.chreg_space_sz = 0x10000,
+	.chreg_off = 0x10000,
+	.setup_irq = fsl_edma3_irq_init,
+};
+
+static struct fsl_edma_drvdata imx93_data3 = {
+	.version = v3,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK,
+	.chreg_space_sz = 0x10000,
+	.chreg_off = 0x10000,
+	.setup_irq = fsl_edma3_irq_init,
+};
+
+static struct fsl_edma_drvdata imx93_data4 = {
+	.version = v4,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK,
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
+
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
+		//pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
+	}
+
+	return 0;
+}
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
@@ -266,8 +451,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (IS_ERR(fsl_edma->membase))
 		return PTR_ERR(fsl_edma->membase);
 
-	fsl_edma_setup_regs(fsl_edma);
-	regs = &fsl_edma->regs;
+	if (drvdata->version < v3) {
+		fsl_edma_setup_regs(fsl_edma);
+		regs = &fsl_edma->regs;
+	}
 
 	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
 		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
@@ -277,6 +464,17 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
+	if (of_property_read_u64(np, "fsl,channel-mask", &fsl_edma->chan_masked))
+		fsl_edma->chan_masked = 0;
+
 	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
 		char clkname[32];
 
@@ -299,9 +497,18 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
 
+	if (drvdata->flags & FSL_EDMA_DRV_HAS_PD) {
+		ret = fsl_edma3_attach_pd(pdev, fsl_edma);
+		if (ret)
+			return ret;
+	}
+
 	INIT_LIST_HEAD(&fsl_edma->dma_dev.channels);
 	for (i = 0; i < fsl_edma->n_chans; i++) {
-		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
+		fsl_chan = &fsl_edma->chans[i];
+
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
 
 		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
 							   dev_name(&pdev->dev), i);
@@ -312,12 +519,18 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->idle = true;
 		fsl_chan->dma_dir = DMA_NONE;
 		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
-		fsl_chan->tcd = fsl_edma->membase + EDMA_TCD
-				+ i * sizeof(struct fsl_edma_hw_tcd);
+
+		len = (fsl_edma_ver(fsl_chan) >= v3) ? offsetof(struct fsl_edma3_ch_reg, tcd) : 0;
+		fsl_chan->tcd = fsl_edma->membase
+				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
+
+		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
 		edma_write_tcdreg(fsl_chan, 0, csr);
-		fsl_edma_chan_mux(fsl_chan, 0, false);
+
+		if (drvdata->dmamuxs)
+			fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
@@ -347,11 +560,27 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	fsl_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
 	fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
+
+	if (drvdata->version >= v3) {
+		fsl_edma->dma_dev.src_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		fsl_edma->dma_dev.dst_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	}
+
 	fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	if (drvdata->version >= v3)
+		fsl_edma->dma_dev.directions |= BIT(DMA_DEV_TO_DEV);
+
+	fsl_edma->dma_dev.copy_align = drvdata->version >= v3 ?
+					DMAENGINE_ALIGN_64_BYTES :
+					DMAENGINE_ALIGN_32_BYTES;
 
-	fsl_edma->dma_dev.copy_align = DMAENGINE_ALIGN_32_BYTES;
 	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
-	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
+	if (drvdata->version >= v3)
+		dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x7fff);
+	else
+		dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
+
+	fsl_edma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 
 	platform_set_drvdata(pdev, fsl_edma);
 
@@ -362,7 +591,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_dma_controller_register(np, fsl_edma_xlate, fsl_edma);
+	ret = of_dma_controller_register(np,
+			drvdata->version < v3 ? fsl_edma_xlate : fsl_edma3_xlate,
+			fsl_edma);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
@@ -371,7 +602,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	}
 
 	/* enable round robin arbitration */
-	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
+	if (drvdata->version < v3)
+		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
 
 	return 0;
 }
-- 
2.34.1

