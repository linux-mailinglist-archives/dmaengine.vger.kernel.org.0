Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB3C782E1E
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjHUQRP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjHUQRO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:17:14 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946CB1A1;
        Mon, 21 Aug 2023 09:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+9vTiaVIFVgU7+duZu6Oi3TkHr0lXuK863VR8E0IWVXkd90y/NEiQ+YfSNYfkMOfnFVGLrwoiHHKVxzlej57o3YoV1SJ8a7KswtfrChAnbPU+lEPns3W+b7HpWxfeSZWS5ATJo11Z+fh5uFQ/RI4PW8RP6szxfxygAxjvGJly6hI9cdZqmReCvB1IiPHcDy0loR6z92xYwwoZaj4QhAFCiZ/390PKpzJAtqd9+gQGvyULbdfhhTl5LDXqSiARVswrkpXBltwHSMSzbEmc+A7g5/3RmlC2DlgQekcH9ZLt0uA0TG477oH/jJXbYPd6YG/WBl5UgFMBuTW4x2xwgSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WK5TTtZ5tb4zUnicum+BhzHCLwGst4nN9ehPi4rkwU4=;
 b=bYAm5xlJUIEg34FkqqTSQYuBMeeTyMYEjtt7dHTlR10S57YS3wPIlIkximkUBHL2YDLbvtNs0C7kLrDDwvO5FSQ+W3S/1lAr6o5CeEWhdhtNW5YaVk3jI0SFkFO3V4lcuscOVPKcuV29Tdp9ysuTY0euVtVUZAYu/5LYNpXtnCjWP6V/+pFeV6pdNevvE6FAp2LfhHbwHqZndokdi14sGWQP0lJImdYk+vK/TVq/qZnGVgM/QJ2/Wh0n3wIXfn5Ib16bPzYHRza6KINwDgx0P4mBukltO9oOmnGFmgDBJrffJ8to4ddONfyl/S1GUXeXuXHu7EMZ2JB5yUlVsF1iHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK5TTtZ5tb4zUnicum+BhzHCLwGst4nN9ehPi4rkwU4=;
 b=I42/pVbpP9nCpR5VxIwWaQU6hshIetARAkLbsJBzv+uGCkngUk4L8/WpRYF76gPU5GIAJILf9ARfHEwvxXnA3SxDrj+eBxBxkFTYSC513f8tC0BXo6KOTnXizLsCm8HVTRh3pDOHLtvIjCdGZW238YsEkFCOLHfEHIFYmEOrKSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:16:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:16:51 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 05/12] dmaengine: fsl-edma: move common IRQ handler to common.c
Date:   Mon, 21 Aug 2023 12:16:10 -0400
Message-Id: <20230821161617.2142561-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: baae12d6-afa1-46d3-556e-08dba26206f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTJGRQ6lEffa0jZl8FcQA3+V8r2gzgJTaeYVmaJxBLPbJMiGd89cEYs7zcDRpuagHEtm2e3mZEuI1+lTGI8pz8hvQ98LXmEhj9Hqhq1rIZSRW2oTCy8YT3crPaZjqqMcW+ukZEfhevEma0OdumuQzdgovTCTmIavS452NjyW1AxBQtVnJfr7WizxfAcwib4Xs14Rv3+zzwpXLZnHnQ0Tn3727Q50czh9yjnghmYmUX+VjG4tXTlpYGdBKWHrdeje5kEv4lxD91ed3xWihRuDAF6chIYi2CZSRE56uHmo58j5YrChdZHGTybdvUPUn08lH5LgNmMv5Yv0zmiAS5/TcMfswsBvL24ZbZfoVVu6xxYh5NxeRzyjq0JN2LxKhaqI00kEtzXli6gPYz5YSbamCThoOFg/675XsaPh7HJ5+aPjGsD7XX1g88339sP6X89N35zngiPH6aT9JxvtI0mjrQhq7i5DaUPE5duKm3B1MTz/6tp2VTd8b5R0ilo8rlQ2wHJH0tcLg/IGaldEQyBiEkX1SuTthCTxsUP0wbD3xeQi6m92IABWPAgmq6GfjF1GgTqZpGbZ6V8jsiktoVTBd2eGN1y7HCmxtv1jxgJlPpilfscBfX2lIWPu80Q0n+R8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l3IPwSqIYSXjUyIwh8kThwdUcDjj6Vi+kqhReVJ6Wp+jrYhVvJQAhN5F+loT?=
 =?us-ascii?Q?FVjzvUlARaYzoYNCVqW3zUzZqalUnVqX3wuqMnR3eBHunKVD7e2HSsUL0u1C?=
 =?us-ascii?Q?UaQBbZpKxNkVDoaEqmTlbYUXgS7tlPc5lSN+xd6d5vZ6BoWDvzyrdSOdS8K9?=
 =?us-ascii?Q?NdQiCEkfept5rpJp+yd5lYIjITmiEQQCLVdpqR+GJydZJTamhO8uYarQCCZB?=
 =?us-ascii?Q?5qoji4HJRhSxKgc3vXuOEMzI64aP6whlylvAUNey7mpjda7D38utmM2fYgYL?=
 =?us-ascii?Q?HKYKnG+lHsy/PGbEpLX+wwTkH5h9CUXwSqiyDA5G0LvrOKwECjT5f4Jb3YlD?=
 =?us-ascii?Q?f3jFa9W8K0tkMOtczYKuPNKhSHyzvHjPSOCFk0BFkojgnqKzrILWyFPuoTxy?=
 =?us-ascii?Q?uwiYIiRf1lhK6p4kv+6BwocrhODE4lzzlDlBZf/1h0DB17OOJJu++hPkD5eq?=
 =?us-ascii?Q?IGkoKLq+7k2sHpPq9x4GXY5hOjqdIOocKJYzyveWxinP3uWwGYq792cuBKdV?=
 =?us-ascii?Q?JymUe4BEjFYynHPqRuJvchd8XZD4rYI+ek4iGr4vOjn70C0PnvU4WkFmb1gk?=
 =?us-ascii?Q?n/dh+RdTtkVQWuwZ7pM3SweYazRlQ4hGnsxZ3F6tAckTnv3p9TZ9OTUa1x6B?=
 =?us-ascii?Q?4U98TZpeKzvVvXioj4esCmN2tX5i1ZPo2i6dzCF8CnJW2YvtZViAHbququRl?=
 =?us-ascii?Q?hUckhd2HhK91zJL/HnE75qTjTMSnifySSC4w6B67myDe6dDJzzecv0C7+y7G?=
 =?us-ascii?Q?HoGM9wFU8bQOOVPh1qyd56J/uue8QoKySV5CCdX0YnraGevioeepXaghnt76?=
 =?us-ascii?Q?qO3zw69R7u7GHmjg66AuXsgTDhQAKlP0hmgyPNalZ03Pblnpf3rjdozMvhg9?=
 =?us-ascii?Q?tNFcNiZDQW5zIDYFl68M+DtXCIirw43AVkerX0LiVpI5tvrkMs9+vfjOdtWA?=
 =?us-ascii?Q?r9v1nZ23TYl3ee9PshE2glFXhbXRHjT6q5Xi+XI+phlK+b+XTjt9xUpEEKiS?=
 =?us-ascii?Q?t0OEt3wKQDeArFzexvum3bnIdIMRvWUaCT4dzFo8O1srnTF1zOZH9JKj0tKv?=
 =?us-ascii?Q?9B162ZLUb8WDiULvpOAlao2c3oolApm2I+Lamx13iqFCGqBNFeSzRPkVwrcF?=
 =?us-ascii?Q?cyNH4RxXGu18KsbbdlIhQQOcM26YQfYykDLmbkZmZXit1XyitP+V46QeY8BV?=
 =?us-ascii?Q?zS5R6y5TTy6XJIOTnmQj6P5n0/btaQiqV0VPWoL0H6RkmqlpWksTg0H/N1br?=
 =?us-ascii?Q?LhlPuc06UHyvVSYQB5ra/xBcVrPBXjVj2Vj4hBJmk1y0gt/UTZvsMHfZoXPO?=
 =?us-ascii?Q?CeOKiygKj0XlaMSa1SpglkOv5BX59g7pIt3U3NxlYk29WKKX/XDOYgOZIfWc?=
 =?us-ascii?Q?44wQeL5/UAUejVEmk/ZiuvANuxJxSVuH3lNtNSwrpNPgTqyDr5BQeAm9TGAF?=
 =?us-ascii?Q?HHgebBptaABECADvi56YxGu+PFv1F4ftOOUeVkXqL9kbWbW6SJQdy+0WuIVs?=
 =?us-ascii?Q?qLwWJJF7Sbdy3a4N33Ew+W3FPXTc/GlWzfDIp2aI9AyEPJiAWHDvBRTPEHXZ?=
 =?us-ascii?Q?rKsQoDuNi8Tlq+LIf6U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baae12d6-afa1-46d3-556e-08dba26206f8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:16:51.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iS5nhsGIKKKKViNY+RpYNZYmIpX6wsKC4H77WXViV7VyKW5qwJ3+5qGf06RCo/MQi9Hs+hK6+qPjSqHCk8OSoQ==
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

Move the common part of IRQ handler from fsl-edma-main.c and
mcf-edma-main.c to fsl-edma-common.c. This eliminates redundant code, as
the both files contains mostly identical code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 26 ++++++++++++++++++++++++++
 drivers/dma/fsl-edma-common.h |  7 +++++++
 drivers/dma/fsl-edma-main.c   | 30 ++----------------------------
 drivers/dma/mcf-edma-main.c   | 30 ++----------------------------
 4 files changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 5800747b8fb3..2b91863502d4 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -42,6 +42,32 @@
 
 #define EDMA_TCD		0x1000
 
+void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
+{
+	spin_lock(&fsl_chan->vchan.lock);
+
+	if (!fsl_chan->edesc) {
+		/* terminate_all called before */
+		spin_unlock(&fsl_chan->vchan.lock);
+		return;
+	}
+
+	if (!fsl_chan->edesc->iscyclic) {
+		list_del(&fsl_chan->edesc->vdesc.node);
+		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
+		fsl_chan->edesc = NULL;
+		fsl_chan->status = DMA_COMPLETE;
+		fsl_chan->idle = true;
+	} else {
+		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
+	}
+
+	if (!fsl_chan->edesc)
+		fsl_edma_xfer_desc(fsl_chan);
+
+	spin_unlock(&fsl_chan->vchan.lock);
+}
+
 static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 {
 	struct edma_regs *regs = &fsl_chan->edma->regs;
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 5f3fcb991b5e..242ab7df8993 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -219,6 +219,13 @@ static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
 	return container_of(vd, struct fsl_edma_desc, vdesc);
 }
 
+static inline void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan)
+{
+	fsl_chan->status = DMA_ERROR;
+	fsl_chan->idle = true;
+}
+
+void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 			unsigned int slot, bool enable);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 389e5f9875dc..c8b9f2eff111 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -33,7 +33,6 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 	struct fsl_edma_engine *fsl_edma = dev_id;
 	unsigned int intr, ch;
 	struct edma_regs *regs = &fsl_edma->regs;
-	struct fsl_edma_chan *fsl_chan;
 
 	intr = edma_readl(fsl_edma, regs->intl);
 	if (!intr)
@@ -42,31 +41,7 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
 		if (intr & (0x1 << ch)) {
 			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch), regs->cint);
-
-			fsl_chan = &fsl_edma->chans[ch];
-
-			spin_lock(&fsl_chan->vchan.lock);
-
-			if (!fsl_chan->edesc) {
-				/* terminate_all called before */
-				spin_unlock(&fsl_chan->vchan.lock);
-				continue;
-			}
-
-			if (!fsl_chan->edesc->iscyclic) {
-				list_del(&fsl_chan->edesc->vdesc.node);
-				vchan_cookie_complete(&fsl_chan->edesc->vdesc);
-				fsl_chan->edesc = NULL;
-				fsl_chan->status = DMA_COMPLETE;
-				fsl_chan->idle = true;
-			} else {
-				vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
-			}
-
-			if (!fsl_chan->edesc)
-				fsl_edma_xfer_desc(fsl_chan);
-
-			spin_unlock(&fsl_chan->vchan.lock);
+			fsl_edma_tx_chan_handler(&fsl_edma->chans[ch]);
 		}
 	}
 	return IRQ_HANDLED;
@@ -86,8 +61,7 @@ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 		if (err & (0x1 << ch)) {
 			fsl_edma_disable_request(&fsl_edma->chans[ch]);
 			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch), regs->cerr);
-			fsl_edma->chans[ch].status = DMA_ERROR;
-			fsl_edma->chans[ch].idle = true;
+			fsl_edma_err_chan_handler(&fsl_edma->chans[ch]);
 		}
 	}
 	return IRQ_HANDLED;
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index aec22711b654..ec8a8e1930b5 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -19,7 +19,6 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 	struct fsl_edma_engine *mcf_edma = dev_id;
 	struct edma_regs *regs = &mcf_edma->regs;
 	unsigned int ch;
-	struct fsl_edma_chan *mcf_chan;
 	u64 intmap;
 
 	intmap = ioread32(regs->inth);
@@ -31,31 +30,7 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
 		if (intmap & BIT(ch)) {
 			iowrite8(EDMA_MASK_CH(ch), regs->cint);
-
-			mcf_chan = &mcf_edma->chans[ch];
-
-			spin_lock(&mcf_chan->vchan.lock);
-
-			if (!mcf_chan->edesc) {
-				/* terminate_all called before */
-				spin_unlock(&mcf_chan->vchan.lock);
-				continue;
-			}
-
-			if (!mcf_chan->edesc->iscyclic) {
-				list_del(&mcf_chan->edesc->vdesc.node);
-				vchan_cookie_complete(&mcf_chan->edesc->vdesc);
-				mcf_chan->edesc = NULL;
-				mcf_chan->status = DMA_COMPLETE;
-				mcf_chan->idle = true;
-			} else {
-				vchan_cyclic_callback(&mcf_chan->edesc->vdesc);
-			}
-
-			if (!mcf_chan->edesc)
-				fsl_edma_xfer_desc(mcf_chan);
-
-			spin_unlock(&mcf_chan->vchan.lock);
+			fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
 		}
 	}
 
@@ -76,8 +51,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 		if (err & BIT(ch)) {
 			fsl_edma_disable_request(&mcf_edma->chans[ch]);
 			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
-			mcf_edma->chans[ch].status = DMA_ERROR;
-			mcf_edma->chans[ch].idle = true;
+			fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
 		}
 	}
 
-- 
2.34.1

