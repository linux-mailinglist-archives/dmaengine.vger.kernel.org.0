Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7E71A083
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjFAOmB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjFAOls (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:41:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971B21B1;
        Thu,  1 Jun 2023 07:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKwctUW+OlNYgCIMinDZSuNKs9cTj2nmSJ5mqnn8dkx1k6kUUuIRmEonTXHlpR9zBkuQMC93/vJQeeOnliItLq9GhounSKGTMAxxirnrRXueLw17/wmZrR9a3tv1LNfTfDEwUsjS6KJH8NXPMut7RMJFwWZW/ASv/FETVCPmfwgIXW6nruHcn3lcc3n49dx4tr4Vo8oXRZdI1VygNHKN4884YBoJXiu54n6O5/fnc2oEJyDqpxl6at2YvVW/DUmc96Z09VLygCQLXbWefyZDARSW7LHxfphetiTIjN8hWiLa+DthzFIfkcVFHa1zh0W1Jd5e0nl6dS72wfBslBRmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IPht6dxRF/kpeNVTtT5w7ymmGtWfKCQH7SKL0OEaWg=;
 b=T7OJIPktaSNGnj5jn17U1Z2X/pSn8GYNDmEO4/hZmObDqVBsYu3YrKbqTFYKBwz20eV8yu09lUliBinmxbkig1t2KRAOpOv87E60ZS/OxF63VIlw4q2iDdpUjef9XzQA6VRXGTEppgFCIll9y/zAv6kX2859Zkweu4Lu+ZcTIiKFVegAB8x8/n4dnVMpPutI5c7kwYszKcgOuAWPnrI0TuNcyh2cIE99tMkklCxvAuSuXKamccb1obwuHnGzJbKO5fNg8cLJsUbhAD4rCDpNwFkIxJS0Tt7CvH0kKPeBuUV3xsG/MhPv4OyNxqFehJXQACwh5UvMDMXnJtdrqNF91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IPht6dxRF/kpeNVTtT5w7ymmGtWfKCQH7SKL0OEaWg=;
 b=ZMhE7+V8egeTRkFzI3Tq+FpMFjayy2Eg9anii8tcDS6sSJG/vStlbNFWaYhMG8/jQf8d7kuH2hrHy3qHTLt4eeCqn62R6GcdeKKZCmFMpiI49hpG/Tcw7oYJryzuPpznbdQK4O9qdRHw3yG4UKFtKrJf72Qpf5y7W8XGacWHMfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:41:40 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:41:40 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 05/12] dmaengine: fsl-edma: move common IRQ handler to common.c
Date:   Thu,  1 Jun 2023 10:41:00 -0400
Message-Id: <20230601144107.1636833-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601144107.1636833-1-Frank.Li@nxp.com>
References: <20230601144107.1636833-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 179d0b79-e719-4184-6570-08db62ae4fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/PU4mHYjreWQZ2/9QFr9DTv7DJVm668pT0m0jZJy+Ho6eAn8R7Tfimgtim6JsZ/qr1bfXofnrsQ5Q9lmwm3yEnS9s1TiNSm4OH1C4Q25bYOq3kMhiNHAyTUPw3poV0VvgZRa9T3QuItk/DKONvnsSv9x21fXZ0vc+2dBfPgmDIpQ68127E2aQJA8WwR4fIyQw15FeXS0s/QzyINvpkc3JAVf1DjaLVbceXfJ3ACMfeaOH9ei/B4KgKLWePDi7fFnvmbvO32GMEfoK1BAwTZOp8hR792wVER2UKX/tym3fGxl7xZlRaVpOvsakDIMFgWjE3UIANj3QtaZ7g0axXqbMCPVV9AwE3o/fy4CicWPIbdyvRDwD8UzzXtAfAnDWFiviBtYIgD5/0aiTUR26VHvzNqYW+AO319qDEmG/H/UR2vpBWJqLKSmI/TujEFWzQ6Q542YrTcEd+xPJYnu9CQU5WCyaLBPZqxmY1yhlUU4JlEJcUe12iVT9RCyid0WuLh3mzyqgA4smiuuVAEy9D2rSdAUmMyV7VIVgnrY7DszLAxbuJfi/dEdI4XfoDmkkfKZFYDDywNuJGamC/xQEnxVJe/pA+pEkZ6be+sy/5pcB/inH3fDM89dpMwxuqa5MRWhsZzKiAsynr989boQ6SlFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(26005)(36756003)(6506007)(1076003)(6512007)(2616005)(86362001)(186003)(2906002)(478600001)(66946007)(66476007)(66556008)(5660300002)(52116002)(83380400001)(8936002)(6486002)(41300700001)(921005)(38100700002)(8676002)(316002)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FO9HyvZj5skDvurTAsyCYrh61HEr6Z+4jaTGAkY/+CwJxgJlZBZwaqpJSJWJ?=
 =?us-ascii?Q?3z8f8cimr/aR79fVyPiMGHYNJ64JbZL3rRlLiptH9lU6ytvFocq9/AqLbzNv?=
 =?us-ascii?Q?QxT+JQdiAvV5l+/XWq+LgsgpoXVQX2/SS7eubfei4pfIB9VPF62RUzgZn/wX?=
 =?us-ascii?Q?07bFN1PUCDWvT/wa/lTLY+r2NPf7ZQH34TEk1TRhY2rFhCR9ucT66WRcJuaa?=
 =?us-ascii?Q?P5l2+ENyHWsHJiUdi/ZFJMbcNu6cMzEsyZjfmWXDcasz97eSX7RlZM8D3+aj?=
 =?us-ascii?Q?/c6enhm9M2mfWHFJ3OUSCW7PXOr+GbDmixx0eGotHQGmrGUmM63i85ToSBPs?=
 =?us-ascii?Q?AuUu0G31XXUN9q92pP+gwsp5qVVA2I8XrZuJH5kob2q/mjEujL2Lr8kzX4bV?=
 =?us-ascii?Q?In5Z+0GB2XFC1CjDBOBdg9NZJwFs+0fP91RJE9xjQRT9nNvhdJgiBVopso64?=
 =?us-ascii?Q?NJmXnTMKWf7h8WMnmKiFXaA6saL4+9ls60Cq15GT1QpIdpQR0p4MynFSM49X?=
 =?us-ascii?Q?iWMMBwFX7ZRurM+PK1zaNj+ckIjuuBLTwFm/YqJP9x1RvtdqJnVZIHTsXVo3?=
 =?us-ascii?Q?zpcrRS2v4YXGkvHFpfkCnsmIyTiO9KszaSTy1bzmsI8a1MsIBkiSmWAFPxiz?=
 =?us-ascii?Q?15KLdDjDrAKW2q0TAkzUTg4ZBOiP3RdI+fvUNRgENtuXui11csLzh66PL/DZ?=
 =?us-ascii?Q?f/nr7ZG+IV6sXr4elxsfWE5OB9JGX4z5aRyIHdIDLMMYkep3QBTtoc4d6FGn?=
 =?us-ascii?Q?iU9WyFkVPKkW9leYmr9uVtaHRDKupUeDcOOAgKkytIjOQ44pZNuz+S0t+cvv?=
 =?us-ascii?Q?mc5vIlNEL7j0iqkUvcZ6O2VLS+WgArTjhZXfRrQoIy4vO3QzF5ZThxoBxRlt?=
 =?us-ascii?Q?raeSgpLjmki+PtCoxOAoXTKRxBB7cct0/8nRWh3myukqhTjDO5DTwvNxBZzd?=
 =?us-ascii?Q?CxZ6PLzCMtMQLAdp7I3fsaabypVrHJ4nlhPxF2M9p3WqbPAopAExsrSC+tdM?=
 =?us-ascii?Q?/lN3YwQ5TIco4R/RpExKX5ZufRR8mOxbwBMAs+X/3J/DHV/1VAg7PjlPdj31?=
 =?us-ascii?Q?3Lsacp/yN/1sx0rJdTYFMeypBeGUP8SpNHzup8P2x0zDa/6Lmb1kK9R7K4tr?=
 =?us-ascii?Q?1v41/0kvqgNPsWUpbLcRlmxEGz0kPOaorbjmx8LpE/t+tOf9ibkibxVFxvf6?=
 =?us-ascii?Q?eteVfhxhgUTWXCtOiHlhOvabE/qhFydygbk58hyNtu1rCEf5+yto1DwtkYjt?=
 =?us-ascii?Q?kQa0Gzfx0TP3mgSx1ZhX6BRlB+SXnxerhzUhGuIE1ew0LzMxgAfL/y+9Mxn7?=
 =?us-ascii?Q?Kz2dDoC1or0JsPTbVHFv8GTBBclIBxutjoUz+75FS1CaD73+rJ0jaXWv2m4S?=
 =?us-ascii?Q?JBLzZQJ2gt41iTF/dsJlkuFUmXC4P2AQ17pQzN1zzccGmvXgelM9zTQcUAxg?=
 =?us-ascii?Q?P/HWO9P0ANNvPmBtHVLSxQCd2C66mziDau3Wz1gsnsSx6G+2+2Raon4jVtFJ?=
 =?us-ascii?Q?5+C0sHjnX0iGxz7Q2HU1nIGClewFn8EpZalHB2B/lNk32XEQU8qTMUe37Njv?=
 =?us-ascii?Q?AdzEVXQZBTcBYOyKNE94/sw/xcW1gxlbRAgNnkhI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179d0b79-e719-4184-6570-08db62ae4fbf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:41:40.6519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4jv9U6zh2BbYoouou9ll4HtVWLMhXHnFdvbcN9XmI6MifBm1YbdP0oMMTJvAldRUgrwMpZ+ka1cpwfUpC00pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7603
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 9948babcadf6..a9d17cf142fc 100644
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
index c7f57edd2bb6..73178f250d0a 100644
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
index 7b05e303ba51..316e637b00c4 100644
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

