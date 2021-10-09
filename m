Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F434278A0
	for <lists+dmaengine@lfdr.de>; Sat,  9 Oct 2021 11:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhJIJ7I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Oct 2021 05:59:08 -0400
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:2986
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231853AbhJIJ7I (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 9 Oct 2021 05:59:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyRKkFwjLFogr7h38aHTHsCqKH1jiVY0/1tqCjX7eCrTb9gRnChE29/dqIAO3dSp74VSJwKjhSb55YfL4OOnRGKUvipSIvhEc8Q/3m3dqlAP+YZ+KbZ/8fnTUb5jVdAAc59ZmEAcV4cy0+xTxAbkhY/6T05IqdVoHKf2cO3MHWD33QZYWshzzI9FPE5gCdbFrQ4YUPWLgzby+yF0GemELvnIC1ai4YRdLmjEgsUkz8X9X17hkkXSUBOEJ3M1sI9+OIemiOvB6Xpz9q8fNzljpEbnc87XOhinzonnuKJDFsE17sz7LiqJRhsncVwmp82hJzYHIvj1Mi2ApGIHXhicOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFEVaHhSsC3MpABSX8BggE8lnId4BuSGVTXWZ4AEb+k=;
 b=Wrb0T/lO2iFxXoy2UlEsmlI3qWRYPUFoIS7pPEApIRbl4zOanMX1ccWZApZaXwelyeAGeWa0gjMQJSfR29JTFClxd8ITbNXSH99qi750QdZ4rg1bwreoV2987vyhxe+uSPCbGin6zXnredohN5YP/9qRiO8ysuQgU9v+u9fQko7PfIplKEnHzp51kU+IwierAkpW/aLHjiy+JmWmHDWG9KwwBh9Q5aBtcMDH61GNv3mgFc5xFTq5GLUu002yPjfs1UU9g+nx1O6MCAk4f8F9ayn40h3vgxNmTcBFIj6U5bWPp6A0kxkBbl3HXtq03gx2tnkOZWl+S6ZtALr+r0qdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFEVaHhSsC3MpABSX8BggE8lnId4BuSGVTXWZ4AEb+k=;
 b=SEHC4UvoOef6EDF8jFfk8D4XdmCaobzRzfnhsZT6xGPoaoJb4sHo2roaxpRaEcsiiVq3FqF4xMtFEQYGZ3WSEs5uiAYeg5UD8qKbyOoO+N1QmwPSi4m6IuVD9f1tHMKejJWvfLN2VZvS0QMawqtbiHLygN10iMChzYtieWHwk/Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DBAPR04MB7446.eurprd04.prod.outlook.com (2603:10a6:10:1aa::10)
 by DBBPR04MB7532.eurprd04.prod.outlook.com (2603:10a6:10:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Sat, 9 Oct
 2021 09:57:09 +0000
Received: from DBAPR04MB7446.eurprd04.prod.outlook.com
 ([fe80::1f0:61d9:3ea:11cb]) by DBAPR04MB7446.eurprd04.prod.outlook.com
 ([fe80::1f0:61d9:3ea:11cb%3]) with mapi id 15.20.4587.024; Sat, 9 Oct 2021
 09:57:09 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dmaengine: fsl-edma: support edma memcpy
Date:   Sat,  9 Oct 2021 17:55:02 +0800
Message-Id: <20211009095502.1230805-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DBAPR04MB7446.eurprd04.prod.outlook.com
 (2603:10a6:10:1aa::10)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by SI2PR04CA0011.apcprd04.prod.outlook.com (2603:1096:4:197::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Sat, 9 Oct 2021 09:57:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 575d867f-389c-4168-8358-08d98b0b2874
X-MS-TrafficTypeDiagnostic: DBBPR04MB7532:
X-Microsoft-Antispam-PRVS: <DBBPR04MB7532175685196848CCC88DAAE1B39@DBBPR04MB7532.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHn/TMkEgprhyygHqa3Ekym55At3e/dM1aeV5rkonkO4OxjJh/SQ4M9Y9PCb3fvpq9VZ2H6KgEqXLQAjOAAIZ1b+csOCmBXjr0QQnTLeBomjSLTF4REwM3NoE+w8pcgzE86ecDrrjxbinYdBJRBJH/Rtp8dMI717EXzzHYqRhGXM3bVbb70fV/HVQN+/wwpDkpEZpJuJJuRMQtcvBrayLB90EKtIv3LpcbUSSLKYZPWyud3tjq7yq1vmFJKMfN18QhzhWjTGHNE5ArJq8E9kIzoNA5Q/UV315baAaihSUlWnG6MwICR+odbhr9WHac5DJpt+5ZLy5b1ylzJ2PJi4XLo5z0H9z4NbxDRRVmZCcTPvYESQhxFuldOIdi1CxkpVZ5+GmKaoIgr6S0p0+8L7lEDRTRIuzvlifmBYxk+ySO77qzujysE+SV3x5Bu6Nnj97wm+x9xlVsGBlgmmFEArUnQNsMCe1r3BzRGMG/ISVajw/+DWfTM2B/P8jNNIdxPm71CslZ6AtFrO3GQrkqZWhag0DZVomAip5P2MPLlO9aT4WGLrDR0kVD73guiWqBGtNE/nNNhHKD4lUOYCCPKwx3RZZ43ZhPyzDshVfQxPs4KQERfFbiSgvjIRLBX/IY4UVD6si8dPhFZtht7NpdAjoHQOw/d9QuaHCiJUoBFIvnUfVf3cdWcjXIFPSHv/o+mBKqvimDjm3KUjFRuoeHDGNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7446.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(6486002)(66946007)(4326008)(6916009)(508600001)(36756003)(6666004)(2906002)(38350700002)(38100700002)(1076003)(8936002)(52116002)(86362001)(26005)(66556008)(8676002)(44832011)(66476007)(5660300002)(316002)(186003)(956004)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8b5TeFjS28hDMSFQJmOtuPC4bGsUrezUhYbiieCjZVLUvxL1+qCb+1JE5WC/?=
 =?us-ascii?Q?/0LlFjp3qYA4QcEeZPmmqr+DXYiZ1PIBFUSkO7CVw95ROdze1u66oaC/bXI+?=
 =?us-ascii?Q?s8/BEBORl/FxccvY88kS8nCDgFveqH96Jg/BnLuhBo8JpOPvIzxsBA78XoJn?=
 =?us-ascii?Q?hs3mBYv5QGLA8yFHcn/RG3n+xSOTZ9gCOzamwlN6uFxniRmcW2C/fflSmbWM?=
 =?us-ascii?Q?aVe5G8QQUy/k4zowivKYA7fx+2KPrbYEv+MEYpDqXiwWf9ec/MIcz/bxP38v?=
 =?us-ascii?Q?K/B54ewd30xv1dWAuempaU8ItbgsOGp3M+XOdd3ZQEmakUv17R+mmB5x4fap?=
 =?us-ascii?Q?NDcfzAQU/H1bAp658oBoJeOkb/48QxB1dEfn71LcguW5Hs3u3N5IZXw6uI2b?=
 =?us-ascii?Q?qPSw5F+YMerYczh6NUghARjyzJCwtWju1gRXoSUWNTn/Dk9Eum1y+BooxA5P?=
 =?us-ascii?Q?EXVw0SEkZb8Cr2YvXn68gqKIlwscvDMHQ/0wrAL6HwjrAYbJ+IHS0ulOXrvh?=
 =?us-ascii?Q?gZZPyQhBEFimXBOB16MEtVvTKNRAORr3Yb3N6v6jlijpErVwBzx1TjBIBi8m?=
 =?us-ascii?Q?8G4S4JgwDr6bVa7Wp8wRTptf7K/G17PmyECLpji5J0dtbZHvTQ1plNNXts8k?=
 =?us-ascii?Q?y7MtNqH8aREOdK45vSruo/cZV0YdlfEV6jfdHyPZZorXUQRRnkAsMQuSI0Yu?=
 =?us-ascii?Q?3HcY+MmmP+vu3r1fR+I/r10PQHwVCtOTr9A5R879dL2NIpRO/Hxn/Ll5T4UP?=
 =?us-ascii?Q?Vd7IT4pRC1sKz7+BSrFS3RU8KadKFYgoe37WlUpy02xAteKGZyOBe/vmi3Vs?=
 =?us-ascii?Q?V0WUf5hD+JR6q7XS5yj3M4X9xvy9Klw90uqkuJ9N6hsSEXk+SqPXg1OeWxK0?=
 =?us-ascii?Q?fDG/dUVj82hhrGpEax2YT26z15QARMZ4FWBAjC2+sWG2dJhf9bgcu+i4RfKG?=
 =?us-ascii?Q?mRwA61XJR62gc2081MX8Fb+TMvy0/oH3qzZ+Cviad5fA+Wt9lp/U9zCQX032?=
 =?us-ascii?Q?4XlgUSrq2XvKRZQRgu9E/qnU2FPVSElnp0pTRXyNsWyBzer7r8TuoD8sWtp+?=
 =?us-ascii?Q?lO1ic3nwlnnwD0l7U21cTfNlNGKX68pghnMbSi33EkyZ7VM5XhkZ9WUAMPcY?=
 =?us-ascii?Q?VhWpM6I+Fi3EWiMIKPhV+XzR10Jm5z+jCj6PyK3XRH4zMootZCoOBciNL7Pn?=
 =?us-ascii?Q?r4ABWlDn6uEy4i4oJFeV85iMFGcX+nsyaVu81N2w+YyBTHRtkldZ4GYPF0HP?=
 =?us-ascii?Q?rBs+N+NiJhnM44hlZs0PN7mt3XtTWhYmMGSA8OP4K3TnXAh7GzeRzNzjnERJ?=
 =?us-ascii?Q?AWQghED8Jv9TwWQvbcPk7D+r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575d867f-389c-4168-8358-08d98b0b2874
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7446.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2021 09:57:09.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Al7bsOTSXrkYBG5thneAq8i5eb+0QCoCjDtYHvozAFN5yBDAth3JY+IMcnO7Gl7Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7532
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

add memcpy in edma.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 27 +++++++++++++++++++++++++++
 drivers/dma/fsl-edma-common.h |  4 ++++
 drivers/dma/fsl-edma.c        |  7 +++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 930ae268c497..9b12cb60c432 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -373,6 +373,9 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	edma_writel(edma, (s32)tcd->dlast_sga,
 			&regs->tcd[ch].dlast_sga);
 
+	if (fsl_chan->is_sw)
+		tcd->csr |= EDMA_TCD_CSR_START;
+
 	edma_writew(edma, (s16)tcd->csr, &regs->tcd[ch].csr);
 }
 
@@ -587,6 +590,29 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 }
 EXPORT_SYMBOL_GPL(fsl_edma_prep_slave_sg);
 
+struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(
+		struct dma_chan *chan, dma_addr_t dma_dst,
+		dma_addr_t dma_src, size_t len, unsigned long flags)
+{
+	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	struct fsl_edma_desc *fsl_desc;
+
+	fsl_desc = fsl_edma_alloc_desc(fsl_chan, 1);
+	if (!fsl_desc)
+		return NULL;
+	fsl_desc->iscyclic = false;
+
+	fsl_chan->is_sw = true;
+
+	/* To match with copy_align and max_seg_size so 1 tcd is enough */
+	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
+			EDMA_TCD_ATTR_SSIZE_32BYTE | EDMA_TCD_ATTR_DSIZE_32BYTE,
+			32, len, 0, 1, 1, 32, 0, true, true, false);
+
+	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+}
+EXPORT_SYMBOL_GPL(fsl_edma_prep_memcpy);
+
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 {
 	struct virt_dma_desc *vdesc;
@@ -652,6 +678,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 	dma_pool_destroy(fsl_chan->tcd_pool);
 	fsl_chan->tcd_pool = NULL;
+	fsl_chan->is_sw = false;
 }
 EXPORT_SYMBOL_GPL(fsl_edma_free_chan_resources);
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index ec1169741de1..004ec4a6bc86 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -121,6 +121,7 @@ struct fsl_edma_chan {
 	struct fsl_edma_desc		*edesc;
 	struct dma_slave_config		cfg;
 	u32				attr;
+	bool                            is_sw;
 	struct dma_pool			*tcd_pool;
 	dma_addr_t			dma_dev_addr;
 	u32				dma_dev_size;
@@ -240,6 +241,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flags, void *context);
+struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(
+		struct dma_chan *chan, dma_addr_t dma_dst, dma_addr_t dma_src,
+		size_t len, unsigned long flags);
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_issue_pending(struct dma_chan *chan);
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan);
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 90bb72af306c..76cbf54aec58 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_dma.h>
+#include <linux/dma-mapping.h>
 
 #include "fsl-edma-common.h"
 
@@ -372,6 +373,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
+	dma_cap_set(DMA_MEMCPY, fsl_edma->dma_dev.cap_mask);
 
 	fsl_edma->dma_dev.dev = &pdev->dev;
 	fsl_edma->dma_dev.device_alloc_chan_resources
@@ -381,6 +383,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
 	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
 	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
+	fsl_edma->dma_dev.device_prep_dma_memcpy = fsl_edma_prep_memcpy;
 	fsl_edma->dma_dev.device_config = fsl_edma_slave_config;
 	fsl_edma->dma_dev.device_pause = fsl_edma_pause;
 	fsl_edma->dma_dev.device_resume = fsl_edma_resume;
@@ -392,6 +395,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
 	fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 
+	fsl_edma->dma_dev.copy_align = DMAENGINE_ALIGN_32_BYTES;
+	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
+	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
+
 	platform_set_drvdata(pdev, fsl_edma);
 
 	ret = dma_async_device_register(&fsl_edma->dma_dev);
-- 
2.25.1

