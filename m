Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7A211C36
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 08:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGBGyM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 02:54:12 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:12347
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726953AbgGBGyL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 02:54:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGrumqfDFtu3PNqLrnij6luDekgYdoS4wZB9iRD1ZaNbaw7wEM9OD2LE6hNbqK5wrDhHwnetDbwLPvPlMiMjqEX2tm+WdCLqCaOFiO31jwbKfSudIWETuphhDz6WPMOq0tyrM0iutXR5GDO762FMFylMuD7qg7Znlxg0uJKwPjOmXQKr8gBwTe4IsFyO+ozt5INqNb3CtzPuV2L9kKQhRlU+HmXXr2M5Gjo9yR2wS3P7ZhA7HnstGfKKe5JLxEkD6gnUG7d0Y2SXlfh6zApSW6S29ezwmbH5EGQFeX1nBmr1PPMd14atZPlm47cbo+cTDOH5rGhX5KEkx1XA1Iqixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zslP4HxkVzYfUuPlpN/W5Vo9U1G2YbWRickvtI8V7A=;
 b=fWZx8VZEaI9N87mon+VF57Zv25DUNvXjoDb//i34aD4h3eTkD/SJuGIgIN/JhPcnjcJBo1E1O0JIflxULGnOScDSG5lCIF8HND43BojGGEgU7+HC8pqmdmJ1up1WtpALLuDeHne7MbTr0clWu5LUDQvKshXyzT1xjHVfxQcTuQQjuhkEQUrJMoerRmSR7fj3FaK9tBvzHanuti6PZGDEvgboeP9Rs4TPG1vCBi8AurOKihfI5xdv27LvlWpt1o4R8HTidxcFWyefXL/lo42xwALuevOptmZlkwbk1X3H7ajOpmL92AF0vTG54QE0HmA3F0Clz0Vn7huiHhrvihE+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zslP4HxkVzYfUuPlpN/W5Vo9U1G2YbWRickvtI8V7A=;
 b=qiXatHglFYyKJJBcxcxcEJEF1zbj6uy84pkTk61zpi6rsmDu9QwIyIy7o96Bzar7KmeQ4vPNGvHrhfSxzf2HnZoeVjQAQdj4qSn+h3zyK8N3fiVMPdd/4QjNT2tXyKKIJKAgruBjyq/PiG9WTsexX/6AUTT22xv/hsFTMAi7k4Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 06:54:01 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.024; Thu, 2 Jul 2020
 06:54:01 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 5/9] dmaengine: fsl-edma3: add fsl-edma3 driver
Date:   Thu,  2 Jul 2020 23:08:05 +0800
Message-Id: <1593702489-21648-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
References: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0172.apcprd01.prod.exchangelabs.com (2603:1096:4:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 06:53:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be768faa-dd27-486a-993e-08d81e54b34f
X-MS-TrafficTypeDiagnostic: VI1PR04MB6943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6943A406AF0478BBF3AAEF5C896D0@VI1PR04MB6943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUVrI55rIE/uPpv/gVkf96l5iUrTVqg5Yqw7IVHLDNWBE9eEu7IO6J5/fTKmFpo/NSc/dIc+PD6L90GKA3UinJyRdLQy1iuzA0c3q4XnZLkm+CJOeHkYHHj1X733p7GPkBfD7wXMZBRqfYpFPRxboO42wG7sJvUJIBycIJ19oqPl4KFNNlBopaHyTYNMUFq/C6+/HFl97pz1eh+z4PqDPygBvxu7Wp4TlkWbi76bWetp2WB2oyjqrdXZnKc90qf+AlzzP+LsVmaoF2wk6pRaZkHPTbyYHm7Xyc1gfWocfqrlTgH2j50jSmbnJn5r7rBv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(83380400001)(66476007)(6666004)(66946007)(66556008)(52116002)(36756003)(8936002)(2616005)(6486002)(956004)(6512007)(186003)(7416002)(4326008)(26005)(2906002)(8676002)(86362001)(30864003)(16526019)(478600001)(6506007)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zxrtPN16hxJBK0yDnJRrcjPtldQrFdox3ORqPgrXX/+pvU8AbkUPluSn+wphl+a1oARM0+2ZCs7l2eOFRijUYHDBgBsmjYXS0UoxbJbB9ZdDbqt2gS8UGY76yk/2OM+fUZoNb4xzGF/RVOk7IPvG3EkhRTnSeFteZK4BfYx8uuSONIxe9ph0VoJ9w9XLz5D2CC/lKg5m/1Z5yndPXzQnz4NVgBBFSMoNpKTE20g7BCHMzJaKz2CvzMZ4HWGqb46pJ6eiqm0pS/41OLlfNhhVM3PXh83U7wVBn68GImSOCTe53CEwvA4uQFr1PmrIIoU11e0PbAQgGQRYd9bpTbzcUZ8L3VGLk05vvi4OpCtHk670JfychnMgeVVIhn67nz2sL1AfuBF2pLffUyXtQTMaGFfS8tCiMTJxuE1pYqET9rQ2bw+zEd2i//eCFvQdj/xCoL+BWWsvn4Jz+kb0hUTDbm7X5fChxiSSMANXmXGD3MU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be768faa-dd27-486a-993e-08d81e54b34f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 06:54:01.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAwJiy7O49FqNX+JnUJf5cPOKEj8c4gu7hMK3zVbqcEuFJ5nG/LO3vPqBG8STCl2+KvkTUfsN39WKcMtInWjlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

add fsl-edma3 driver since there are big differences with legacy fsl-edma
including below major items:
1. split memory address for per channel, while all channels share the same
   memory address and the same control registers CR/INT..etc.
2. all TCD registers of channels are continuous on legacy edma but split on
   edma3.
3. per interrupt per channel on edma3.
4. totally different register layer and add some register such as SBR
5. power domain support, per domain per channel.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/Kconfig           |  12 +
 drivers/dma/Makefile          |   1 +
 drivers/dma/fsl-edma-common.c | 105 ++++++++-
 drivers/dma/fsl-edma-common.h |  25 +++
 drivers/dma/fsl-edma3.c       | 493 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 631 insertions(+), 5 deletions(-)
 create mode 100644 drivers/dma/fsl-edma3.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index b70e907..bd39e6b 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -214,6 +214,18 @@ config FSL_EDMA
 	  multiplexing capability for DMA request sources(slot).
 	  This module can be found on Freescale Vybrid and LS-1 SoCs.
 
+config FSL_EDMA3
+	tristate "Freescale eDMA3 engine support"
+	depends on OF
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Support the Freescale/NXP eDMA v3 engine with programmable channel.
+	  This driver is based on FSL_EDMA but big changes come such as
+	  different interrupt for different channel, different register
+	  scope for different channel.
+	  This module can be found on Freescale i.MX8QM/QXP/ULP
+
 config FSL_QDMA
 	tristate "NXP Layerscape qDMA engine support"
 	depends on ARM || ARM64
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index e60f813..f3a21a0 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_DW_EDMA) += dw-edma/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
+obj-$(CONFIG_FSL_EDMA3) += fsl-edma3.o fsl-edma-common.o
 obj-$(CONFIG_MCF_EDMA) += mcf-edma.o fsl-edma-common.o
 obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 05d56d8..e07880c 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -40,6 +40,13 @@
 #define EDMA64_ERRH		0x28
 #define EDMA64_ERRL		0x2c
 
+#define EDMA3_CSR		0x00
+#define EDMA3_ES		0x04
+#define EDMA3_INT		0x08
+#define EDMA3_SBR		0x0C
+#define EDMA3_PRI		0x10
+#define EDMA3_TCD		0x20
+
 #define EDMA_TCD		0x1000
 
 void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
@@ -78,6 +85,38 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 }
 EXPORT_SYMBOL_GPL(fsl_edma_disable_request);
 
+void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
+{
+	struct edma_regs *regs = &fsl_chan->regs;
+	u32 val;
+
+	val = edma_readl(fsl_chan->edma, regs->sbr);
+	if (fsl_chan->is_rx)
+		val |= EDMA3_SBR_RD;
+	else
+		val |= EDMA3_SBR_WR;
+
+	if (fsl_chan->is_remote)
+		val &= ~(EDMA3_SBR_RD | EDMA3_SBR_RD);
+
+	edma_writel(fsl_chan->edma, val, regs->sbr);
+
+	val = edma_readl(fsl_chan->edma, regs->cr);
+	val |= EDMA3_CSR_ERQ;
+	edma_writel(fsl_chan->edma, val, regs->cr);
+}
+EXPORT_SYMBOL_GPL(fsl_edma3_enable_request);
+
+void fsl_edma3_disable_request(struct fsl_edma_chan *fsl_chan)
+{
+	struct edma_regs *regs = &fsl_chan->regs;
+	u32 val = edma_readl(fsl_chan->edma, regs->cr);
+
+	val &= ~EDMA3_CSR_ERQ;
+	edma_writel(fsl_chan->edma, val, regs->cr);
+}
+EXPORT_SYMBOL_GPL(fsl_edma3_disable_request);
+
 static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
 			   u32 off, u32 slot, bool enable)
 {
@@ -272,13 +311,21 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 		struct virt_dma_desc *vdesc, bool in_progress)
 {
 	struct fsl_edma_desc *edesc = fsl_chan->edesc;
-	struct edma_regs *regs = &fsl_chan->edma->regs;
-	u32 ch = fsl_chan->vchan.chan.chan_id;
+	struct edma_regs *regs;
+	u32 ch;
 	enum dma_transfer_direction dir = edesc->dirn;
 	dma_addr_t cur_addr, dma_addr;
 	size_t len, size;
 	int i;
 
+	if (fsl_chan->edma->drvdata->is_split) {
+		regs = &fsl_chan->regs;
+		ch = 0;
+	} else {
+		regs = &fsl_chan->edma->regs;
+		ch = fsl_chan->vchan.chan.chan_id;
+	}
+
 	/* calculate the total size in this desc */
 	for (len = i = 0; i < fsl_chan->edesc->n_tcds; i++)
 		len += le32_to_cpu(edesc->tcd[i].vtcd->nbytes)
@@ -304,6 +351,7 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 		len -= size;
 		if (cur_addr >= dma_addr && cur_addr < dma_addr + size) {
 			len += dma_addr + size - cur_addr;
+			fsl_chan->processed = i;
 			break;
 		}
 	}
@@ -311,6 +359,15 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 	return len;
 }
 
+/*
+ * For saving real count for edma3 eeop since thereal count may not be the
+ * transfer size when the edma channel done interrupt triggered.
+ */
+void fsl_edma_get_realcnt(struct fsl_edma_chan *fsl_chan)
+{
+	fsl_chan->chn_real_count = fsl_edma_desc_residue(fsl_chan, NULL, true);
+}
+
 enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 		dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
@@ -320,8 +377,12 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 	unsigned long flags;
 
 	status = dma_cookie_status(chan, cookie, txstate);
-	if (status == DMA_COMPLETE)
+	if (status == DMA_COMPLETE) {
+		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
+		txstate->residue = fsl_chan->chn_real_count;
+		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 		return status;
+	}
 
 	if (!txstate)
 		return fsl_chan->status;
@@ -347,8 +408,16 @@ void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 				  struct fsl_edma_hw_tcd *tcd)
 {
 	struct fsl_edma_engine *edma = fsl_chan->edma;
-	struct edma_regs *regs = &fsl_chan->edma->regs;
-	u32 ch = fsl_chan->vchan.chan.chan_id;
+	struct edma_regs *regs;
+	u32 ch;
+
+	if (edma->drvdata->is_split) {
+		regs = &fsl_chan->regs;
+		ch = 0;
+	} else {
+		regs = &fsl_chan->edma->regs;
+		ch = fsl_chan->vchan.chan.chan_id;
+	}
 
 	/*
 	 * TCD parameters are stored in struct fsl_edma_hw_tcd in little
@@ -372,6 +441,10 @@ void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	edma_writel(edma, le32_to_cpu(tcd->dlast_sga),
 			&regs->tcd[ch].dlast_sga);
 
+	/* Clear CHa_CSR[DONE] bit before enable TCDa_CSR[ESG] for edma3 */
+	if (edma->drvdata->is_split)
+		edma_writel(edma, edma_readl(edma, regs->cr), regs->cr);
+
 	edma_writew(edma, le16_to_cpu(tcd->csr), &regs->tcd[ch].csr);
 }
 EXPORT_SYMBOL_GPL(fsl_edma_set_tcd_regs);
@@ -416,6 +489,10 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	if (enable_sg)
 		csr |= EDMA_TCD_CSR_E_SG;
 
+	/* EEOP for bit6 on edma3 */
+	if (fsl_chan->is_rx && fsl_chan->edma->drvdata->is_split)
+		csr |= EDMA_TCD_CSR_ACTIVE;
+
 	tcd->csr = cpu_to_le16(csr);
 }
 
@@ -602,6 +679,7 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 	fsl_chan->edma->drvdata->en_req(fsl_chan);
 	fsl_chan->status = DMA_IN_PROGRESS;
 	fsl_chan->idle = false;
+	fsl_chan->chn_real_count = 0;
 }
 EXPORT_SYMBOL_GPL(fsl_edma_xfer_desc);
 
@@ -632,6 +710,10 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				sizeof(struct fsl_edma_hw_tcd),
 				32, 0);
+
+	if (fsl_chan->edma->drvdata->is_split)
+		fsl_chan->edma->drvdata->request_irq(fsl_chan);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fsl_edma_alloc_chan_resources);
@@ -655,6 +737,10 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 	dma_pool_destroy(fsl_chan->tcd_pool);
+
+	if (fsl_chan->edma->drvdata->is_split)
+		fsl_chan->edma->drvdata->free_irq(fsl_chan);
+
 	fsl_chan->tcd_pool = NULL;
 }
 EXPORT_SYMBOL_GPL(fsl_edma_free_chan_resources);
@@ -719,4 +805,13 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 }
 EXPORT_SYMBOL_GPL(fsl_edma_setup_regs);
 
+void fsl_edma3_setup_regs(struct fsl_edma_chan *fsl_chan)
+{
+	fsl_chan->regs.cr = fsl_chan->chan_base + EDMA3_CSR;
+	fsl_chan->regs.intl = fsl_chan->chan_base + EDMA3_INT;
+	fsl_chan->regs.sbr = fsl_chan->chan_base + EDMA3_SBR;
+	fsl_chan->regs.tcd = fsl_chan->chan_base + EDMA3_TCD;
+}
+EXPORT_SYMBOL_GPL(fsl_edma3_setup_regs);
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 56f29f3..624f1db 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -25,6 +25,10 @@
 #define EDMA_CINT_CINT(x)	((x) & GENMASK(4, 0))
 #define EDMA_CERR_CERR(x)	((x) & GENMASK(4, 0))
 
+#define EDMA3_SBR_RD		BIT(22)
+#define EDMA3_SBR_WR		BIT(21)
+#define EDMA3_CSR_ERQ		BIT(0)
+
 #define EDMA_TCD_ATTR_DSIZE(x)		(((x) & GENMASK(2, 0)))
 #define EDMA_TCD_ATTR_DMOD(x)		(((x) & GENMASK(4, 0)) << 3)
 #define EDMA_TCD_ATTR_SSIZE(x)		(((x) & GENMASK(2, 0)) << 8)
@@ -103,6 +107,7 @@ struct edma_regs {
 	void __iomem *intl;
 	void __iomem *errh;
 	void __iomem *errl;
+	void __iomem *sbr;
 	struct fsl_edma_hw_tcd __iomem *tcd;
 };
 
@@ -126,6 +131,18 @@ struct fsl_edma_chan {
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
 	char				chan_name[16];
+	/* real transfered count saved for eeop */
+	u32				chn_real_count;
+	/* No. of processed tcd in cyclic */
+	u32				processed;
+	void __iomem			*chan_base;
+	int				hw_chanid;
+	int				priority;
+	int				txirq;
+	struct device			*dev;
+	bool				is_rx;
+	bool				is_remote;
+	struct edma_regs		regs;
 };
 
 struct fsl_edma_desc {
@@ -141,10 +158,12 @@ enum edma_version {
 	v1, /* 32ch, Vybrid, mpc57x, etc */
 	v2, /* 64ch Coldfire */
 	v3, /* 32ch, i.mx7ulp */
+	v4, /* 32ch, i.mx8qm/qxp */
 };
 
 struct fsl_edma_drvdata {
 	enum edma_version	version;
+	bool			is_split;
 	u32			dmamuxs;
 	bool			has_dmaclk;
 	bool			mux_swap;
@@ -152,6 +171,8 @@ struct fsl_edma_drvdata {
 					     struct fsl_edma_engine *fsl_edma);
 	void			(*en_req)(struct fsl_edma_chan *fsl_chan);
 	void			(*dis_req)(struct fsl_edma_chan *fsl_chan);
+	int			(*request_irq)(struct fsl_edma_chan *fsl_chan);
+	int			(*free_irq)(struct fsl_edma_chan *fsl_chan);
 };
 
 struct fsl_edma_engine {
@@ -225,6 +246,8 @@ static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
 
 void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan);
+void fsl_edma3_disable_request(struct fsl_edma_chan *fsl_chan);
+void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 			unsigned int slot, bool enable);
 void fsl_edma_free_desc(struct virt_dma_desc *vdesc);
@@ -233,6 +256,7 @@ int fsl_edma_pause(struct dma_chan *chan);
 int fsl_edma_resume(struct dma_chan *chan);
 int fsl_edma_slave_config(struct dma_chan *chan,
 				 struct dma_slave_config *cfg);
+void fsl_edma_get_realcnt(struct fsl_edma_chan *fsl_chan);
 enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 		dma_cookie_t cookie, struct dma_tx_state *txstate);
 struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
@@ -249,6 +273,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan);
 void fsl_edma_free_chan_resources(struct dma_chan *chan);
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
 void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
+void fsl_edma3_setup_regs(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 				struct fsl_edma_hw_tcd *tcd);
 
diff --git a/drivers/dma/fsl-edma3.c b/drivers/dma/fsl-edma3.c
new file mode 100644
index 00000000..1415682
--- /dev/null
+++ b/drivers/dma/fsl-edma3.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * drivers/dma/fsl-edma3.c
+ *
+ * Copyright 2020 NXP
+ *
+ * Driver for NXP eDMA3 engine which is based on fsl-edma.c. eDMA3 could
+ * be found on i.mx8qm/qxp/8ulp etc.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_dma.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
+
+#include "fsl-edma-common.h"
+
+#define ARGS_RX				BIT(0)
+#define ARGS_REMOTE			BIT(1)
+
+/* channel name template define in dts */
+#define CHAN_PREFIX			"edma0-chan"
+#define CHAN_POSFIX			"-tx"
+
+struct fsl_edma3_engine {
+	unsigned long		irqflag;
+	struct fsl_edma_engine fsl_edma;
+};
+
+static struct fsl_edma3_engine *to_fsl_edma3(struct fsl_edma_engine *t)
+{
+	return container_of(t, struct fsl_edma3_engine, fsl_edma);
+}
+
+static irqreturn_t fsl_edma3_irq_handler(int irq, void *dev_id)
+{
+	struct fsl_edma_chan *fsl_chan = dev_id;
+	struct fsl_edma_engine *fsl_edma = fsl_chan->edma;
+	struct edma_regs *regs = &fsl_chan->regs;
+	unsigned int intr;
+	irqreturn_t ret = IRQ_HANDLED;
+
+	spin_lock(&fsl_chan->vchan.lock);
+
+	/* Ignore this interrupt if this channels has been free-ed */
+	if (!fsl_chan->tcd_pool)
+		goto irq_handled;
+
+	intr = edma_readl(fsl_edma, regs->intl);
+	if (!intr) {
+		ret = IRQ_NONE;
+		goto irq_handled;
+	}
+
+	edma_writel(fsl_edma, 1, regs->intl);
+
+	/* Ignore this interrupt since channel has been disabled already */
+	if (!fsl_chan->edesc)
+		goto irq_handled;
+
+	if (!fsl_chan->edesc->iscyclic) {
+		fsl_edma_get_realcnt(fsl_chan);
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
+irq_handled:
+	spin_unlock(&fsl_chan->vchan.lock);
+
+	return ret;
+}
+
+
+static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
+		struct of_dma *ofdma)
+{
+	struct fsl_edma_engine *fsl_edma = ofdma->of_dma_data;
+	struct dma_chan *chan, *_chan;
+	struct fsl_edma_chan *fsl_chan;
+
+	if (dma_spec->args_count != 3)
+		return NULL;
+
+	mutex_lock(&fsl_edma->fsl_edma_mutex);
+	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels,
+					device_node) {
+		if (chan->client_count)
+			continue;
+		fsl_chan = to_fsl_edma_chan(chan);
+		if (fsl_chan->hw_chanid == dma_spec->args[0]) {
+			chan = dma_get_slave_channel(chan);
+			chan->device->privatecnt++;
+			fsl_chan->priority = dma_spec->args[1];
+			fsl_chan->is_rx = dma_spec->args[2] & ARGS_RX;
+			fsl_chan->is_remote = dma_spec->args[2] & ARGS_REMOTE;
+			mutex_unlock(&fsl_edma->fsl_edma_mutex);
+			return chan;
+		}
+	}
+	mutex_unlock(&fsl_edma->fsl_edma_mutex);
+
+	return NULL;
+}
+
+static int
+fsl_edma3_parse_chanirq(struct platform_device *pdev,
+		   struct fsl_edma_chan *fsl_chan, int i)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const char *txirq_name;
+	char chanid[3], id_len = 0;
+	struct resource *res;
+	unsigned long hwid;
+	int ret;
+	/* Get per channel membase */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+	fsl_chan->chan_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(fsl_chan->chan_base))
+		return PTR_ERR(fsl_chan->chan_base);
+
+	/* Get the hardware chanel id by the channel membase
+	 * channel0:0x10000, channel1:0x20000... total 32 channels
+	 */
+	fsl_chan->hw_chanid = (res->start >> 16) & 0x1f;
+
+	ret = of_property_read_string_index(np, "interrupt-names", i,
+						&txirq_name);
+	if (ret) {
+		dev_err(&pdev->dev, "read interrupt-names fail.\n");
+		return ret;
+	}
+	/* Get channel id length from dts, one-digit or double-digit */
+	id_len = strlen(txirq_name) - strlen(CHAN_PREFIX) -
+		 strlen(CHAN_POSFIX);
+	if (id_len != 2 && id_len != 1) {
+		dev_err(&pdev->dev, "%s is edmaX-chanX-tx in dts?\n",
+			res->name);
+		return -EINVAL;
+	}
+	/* Grab channel id from txirq_name */
+	strlcpy(chanid, txirq_name + strlen(CHAN_PREFIX), id_len + 1);
+
+	/* check if the channel id match well with hw_chanid */
+	ret = kstrtoul(chanid, 0, &hwid);
+	if (ret || hwid != fsl_chan->hw_chanid) {
+		dev_err(&pdev->dev, "%s,mismatch id/address!\n", txirq_name);
+		return -EINVAL;
+	}
+
+	fsl_chan->txirq = platform_get_irq_byname(pdev, txirq_name);
+	if (fsl_chan->txirq < 0) {
+		dev_err(&pdev->dev, "Can't get %s irq.\n", txirq_name);
+		return -EINVAL;
+	}
+
+	memcpy(fsl_chan->chan_name, txirq_name, strlen(txirq_name));
+
+	fsl_edma3_setup_regs(fsl_chan);
+
+	return 0;
+}
+
+static int fsl_edma3_request_chanirq(struct fsl_edma_chan *fsl_chan)
+{
+	struct fsl_edma3_engine *fsl_edma3 = to_fsl_edma3(fsl_chan->edma);
+	struct device *fsl_edma3_dev = fsl_edma3->fsl_edma.dma_dev.dev;
+	const char *txirq_name = fsl_chan->chan_name;
+	int ret;
+
+	pm_runtime_get_sync(fsl_chan->dev);
+
+	/* clear meaningless pending irq anyway */
+	if (edma_readl(&fsl_edma3->fsl_edma, fsl_chan->regs.intl))
+		edma_writel(&fsl_edma3->fsl_edma, 1, fsl_chan->regs.intl);
+
+	ret = devm_request_irq(fsl_edma3_dev, fsl_chan->txirq,
+			fsl_edma3_irq_handler, fsl_edma3->irqflag, txirq_name,
+			fsl_chan);
+	if (ret) {
+		dev_err(fsl_edma3_dev, "Can't register %s IRQ.\n",
+			txirq_name);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int fsl_edma3_free_chanirq(struct fsl_edma_chan *fsl_chan)
+{
+	struct fsl_edma3_engine *fsl_edma3 = to_fsl_edma3(fsl_chan->edma);
+	struct device *fsl_edma3_dev = fsl_edma3->fsl_edma.dma_dev.dev;
+	unsigned long flags;
+
+	devm_free_irq(fsl_edma3_dev, fsl_chan->txirq, fsl_chan);
+
+	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
+
+	fsl_chan->tcd_pool = NULL;
+
+	if (edma_readl(&fsl_edma3->fsl_edma, fsl_chan->regs.intl))
+		edma_writel(&fsl_edma3->fsl_edma, 1, fsl_chan->regs.intl);
+
+	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
+
+	pm_runtime_put_sync(fsl_chan->dev);
+
+	return 0;
+}
+
+static struct fsl_edma_drvdata imx8q_data = {
+	.version = v4,
+	.is_split = true,
+	.en_req = fsl_edma3_enable_request,
+	.dis_req = fsl_edma3_disable_request,
+	.request_irq = fsl_edma3_request_chanirq,
+	.free_irq = fsl_edma3_free_chanirq,
+};
+
+static const struct of_device_id fsl_edma3_dt_ids[] = {
+	{ .compatible = "fsl,imx8qm-edma", .data = &imx8q_data},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fsl_edma3_dt_ids);
+
+static int fsl_edma3_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+			of_match_device(fsl_edma3_dt_ids, &pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
+	struct fsl_edma3_engine *fsl_edma3;
+	struct fsl_edma_engine *fsl_edma;
+	const struct fsl_edma_drvdata *drvdata = NULL;
+	struct fsl_edma_chan *fsl_chan;
+	int len, chans;
+	int ret, i;
+
+	if (of_id)
+		drvdata = of_id->data;
+	if (!drvdata) {
+		dev_err(&pdev->dev, "unable to find driver data\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "dma-channels", &chans);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't get dma-channels.\n");
+		return ret;
+	}
+
+	len = sizeof(*fsl_edma3) + sizeof(*fsl_chan) * chans;
+	fsl_edma3 = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	if (!fsl_edma3)
+		return -ENOMEM;
+
+	/* Audio edma rx/tx channel shared interrupt */
+	if (of_property_read_bool(np, "shared-interrupt"))
+		fsl_edma3->irqflag = IRQF_SHARED;
+
+	fsl_edma = &fsl_edma3->fsl_edma;
+	fsl_edma->drvdata = drvdata;
+	fsl_edma->n_chans = chans;
+	mutex_init(&fsl_edma->fsl_edma_mutex);
+
+	INIT_LIST_HEAD(&fsl_edma->dma_dev.channels);
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
+
+		fsl_chan->edma = fsl_edma;
+		fsl_chan->pm_state = RUNNING;
+		fsl_chan->idle = true;
+		fsl_chan->dma_dir = DMA_NONE;
+		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
+
+		ret = fsl_edma3_parse_chanirq(pdev, fsl_chan, i);
+		if (ret)
+			return ret;
+
+		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
+	}
+
+	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
+	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
+	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
+
+	fsl_edma->dma_dev.dev = &pdev->dev;
+	fsl_edma->dma_dev.device_alloc_chan_resources
+		= fsl_edma_alloc_chan_resources;
+	fsl_edma->dma_dev.device_free_chan_resources
+		= fsl_edma_free_chan_resources;
+	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
+	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
+	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
+	fsl_edma->dma_dev.device_config = fsl_edma_slave_config;
+	fsl_edma->dma_dev.device_pause = fsl_edma_pause;
+	fsl_edma->dma_dev.device_resume = fsl_edma_resume;
+	fsl_edma->dma_dev.device_terminate_all = fsl_edma_terminate_all;
+	fsl_edma->dma_dev.device_issue_pending = fsl_edma_issue_pending;
+
+	fsl_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
+	fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
+	fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) |
+				       BIT(DMA_MEM_TO_DEV);
+
+	platform_set_drvdata(pdev, fsl_edma3);
+
+	ret = dma_async_device_register(&fsl_edma->dma_dev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Can't register Freescale eDMA engine. (%d)\n", ret);
+		return ret;
+	}
+
+	/* Attach power domains from dts for each dma chanel device */
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
+		const char *domn = "edma0-chan01";
+		struct device_link *link;
+		struct device *dev;
+
+		ret = of_property_read_string_index(np, "power-domain-names",
+						    i, &domn);
+		if (ret) {
+			dev_err(dev, "parse domain names error.(%d)\n", ret);
+			ret = -EINVAL;
+			goto failed_after_register;
+		}
+
+		dev = dev_pm_domain_attach_by_name(&pdev->dev, domn);
+		if (IS_ERR_OR_NULL(dev)) {
+			if (PTR_ERR(dev) == -EPROBE_DEFER) {
+				ret = -EPROBE_DEFER;
+				goto failed_after_register;
+			}
+
+			dev_err(&pdev->dev, "edma channel attach failed.\n");
+			ret = -EINVAL;
+			goto failed_after_register;
+		}
+		link = device_link_add(&pdev->dev, dev, DL_FLAG_STATELESS |
+				       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+		if (IS_ERR(link)) {
+			dev_err(&pdev->dev, "Failed to add link to %s: %ld\n",
+				domn, PTR_ERR(link));
+			ret = -EINVAL;
+			goto failed_after_register;
+		}
+
+		fsl_chan->dev = dev;
+		/* clear meaningless pending irq anyway */
+		edma_writel(fsl_edma, 1, fsl_chan->regs.intl);
+		pm_runtime_put_sync(dev);
+	}
+
+	ret = of_dma_controller_register(np, fsl_edma3_xlate, fsl_edma);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
+		goto failed_after_register;
+	}
+
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+failed_after_register:
+	dma_async_device_unregister(&fsl_edma->dma_dev);
+	return ret;
+}
+
+static int fsl_edma3_remove(struct platform_device *pdev)
+{
+	struct fsl_edma3_engine *fsl_edma3 = platform_get_drvdata(pdev);
+	struct fsl_edma_engine *fsl_edma = &fsl_edma3->fsl_edma;
+	struct device_node *np = pdev->dev.of_node;
+
+	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
+	of_dma_controller_free(np);
+	dma_async_device_unregister(&fsl_edma->dma_dev);
+
+	return 0;
+}
+
+static int fsl_edma3_suspend_late(struct device *dev)
+{
+	struct fsl_edma3_engine *fsl_edma3 = dev_get_drvdata(dev);
+	struct fsl_edma_engine *fsl_edma = &fsl_edma3->fsl_edma;
+	struct fsl_edma_chan *fsl_chan;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		fsl_chan = &fsl_edma->chans[i];
+
+		if (pm_runtime_status_suspended(fsl_chan->dev))
+			continue;
+
+		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
+		/* Make sure chan is idle or will force disable. */
+		if (unlikely(!fsl_chan->idle)) {
+			dev_warn(dev, "WARN: There is non-idle channel.");
+			fsl_edma3_disable_request(fsl_chan);
+		}
+		/* Get the processed tcd number for resume back */
+		if (fsl_chan->edesc)
+			fsl_edma_get_realcnt(fsl_chan);
+
+		fsl_chan->pm_state = SUSPENDED;
+		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
+	}
+
+	return 0;
+}
+
+static int fsl_edma3_resume_early(struct device *dev)
+{
+	struct fsl_edma3_engine *fsl_edma3 = dev_get_drvdata(dev);
+	struct fsl_edma_engine *fsl_edma = &fsl_edma3->fsl_edma;
+	struct fsl_edma_chan *fsl_chan;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		fsl_chan = &fsl_edma->chans[i];
+
+		if (pm_runtime_status_suspended(fsl_chan->dev))
+			continue;
+
+		/* setup tcd before channel resume in case it's paused */
+		if (fsl_chan->edesc) {
+			u32 next = (fsl_chan->processed + 1) %
+				    fsl_chan->edesc->n_tcds;
+
+			fsl_edma_set_tcd_regs(fsl_chan,
+					fsl_chan->edesc->tcd[next].vtcd);
+		}
+
+		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
+		fsl_chan->pm_state = RUNNING;
+		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
+	}
+
+	return 0;
+}
+
+/*
+ * eDMA provides the service to others, so it should be suspend late
+ * and resume early. When eDMA suspend, all of the clients should stop
+ * the DMA data transmission and let the channel idle.
+ */
+static const struct dev_pm_ops fsl_edma3_pm_ops = {
+	.suspend_late   = fsl_edma3_suspend_late,
+	.resume_early   = fsl_edma3_resume_early,
+};
+
+static struct platform_driver fsl_edma3_driver = {
+	.driver		= {
+		.name	= "imx8qm-edma",
+		.of_match_table = fsl_edma3_dt_ids,
+		.pm     = &fsl_edma3_pm_ops,
+	},
+	.probe          = fsl_edma3_probe,
+	.remove		= fsl_edma3_remove,
+};
+
+static int __init fsl_edma3_init(void)
+{
+	return platform_driver_register(&fsl_edma3_driver);
+}
+subsys_initcall(fsl_edma3_init);
+
+static void __exit fsl_edma3_exit(void)
+{
+	platform_driver_unregister(&fsl_edma3_driver);
+}
+module_exit(fsl_edma3_exit);
+
+MODULE_ALIAS("platform:imx8qm-edma");
+MODULE_DESCRIPTION("NXP i.mx8qm/qxp eDMA engine driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

