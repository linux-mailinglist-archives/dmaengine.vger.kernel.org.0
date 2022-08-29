Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531D05A5091
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiH2Psc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 11:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiH2PsQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 11:48:16 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3864E9677B;
        Mon, 29 Aug 2022 08:48:13 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TCoJ8f025061;
        Mon, 29 Aug 2022 17:48:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=fQkDSe4YJDnm5bdjjWIF+vwsj55oeTNPgJCPMUTOmgE=;
 b=8Gjc6irfIt3FMR/9/jQk85RwT6KNLiXDStOpQdpYYBX9pJr/RtP1/yiiRq0bQsN500RY
 kRN0SXlsgMUyQGNg5fIKYhQQmTlCbQkyalgjcIBKXmn8E0XqD+wnx6sl0vhIU1njCs9J
 kN5f3dy8speH114Zwh5BC5eTRBO8H+svKd/pGoLbBj9w3RrPLdajp1e4j55RIE1EKb20
 Lnst2zrHDmqEPTHYflYGKT1m+tGgUQM7lXSJRQF80jX8MxhQhNLK8Bpe6QN/qZ0ZoBav
 /V6gQ5S8h8kKxWpjJKjFuR/FXSOVVVpvDXkO9LbIiMwV/0cvlKz9KNr9HiAABKkK2W2v FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3j7am0tcub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 17:48:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5FA810002A;
        Mon, 29 Aug 2022 17:48:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D081B236935;
        Mon, 29 Aug 2022 17:48:00 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.7; Mon, 29 Aug
 2022 17:48:00 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-doc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [RESEND PATCH v3 6/6] dmaengine: stm32-mdma: add support to be triggered by STM32 DMA
Date:   Mon, 29 Aug 2022 17:46:46 +0200
Message-ID: <20220829154646.29867-7-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829154646.29867-1-amelie.delaunay@foss.st.com>
References: <20220829154646.29867-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

STM32 MDMA can be triggered by STM32 DMA channels transfer complete.

In case of non-null struct dma_slave_config .peripheral_size, it means the
DMA client wants the DMA to trigger the MDMA.

stm32-mdma driver gets the request id, the mask_addr, and the mask_data in
struct stm32_mdma_dma_config passed by DMA with struct dma_slave_config
.peripheral_config/.peripheral_size.

Then, as DMA is configured in Double-Buffer mode, and MDMA channel will
transfer data from/to SRAM to/from DDR, then bursts are optimized.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-mdma.c | 70 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index b11927ed4367..e28acbcb53f4 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -199,6 +199,7 @@ struct stm32_mdma_chan_config {
 	u32 transfer_config;
 	u32 mask_addr;
 	u32 mask_data;
+	bool m2m_hw; /* True when MDMA is triggered by STM32 DMA */
 };
 
 struct stm32_mdma_hwdesc {
@@ -227,6 +228,12 @@ struct stm32_mdma_desc {
 	struct stm32_mdma_desc_node node[];
 };
 
+struct stm32_mdma_dma_config {
+	u32 request;	/* STM32 DMA channel stream id, triggering MDMA */
+	u32 cmar;	/* STM32 DMA interrupt flag clear register address */
+	u32 cmdr;	/* STM32 DMA Transfer Complete flag */
+};
+
 struct stm32_mdma_chan {
 	struct virt_dma_chan vchan;
 	struct dma_pool *desc_pool;
@@ -539,13 +546,23 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 		dst_addr = chan->dma_config.dst_addr;
 
 		/* Set device data size */
+		if (chan_config->m2m_hw)
+			dst_addr_width = stm32_mdma_get_max_width(dst_addr, buf_len,
+								  STM32_MDMA_MAX_BUF_LEN);
 		dst_bus_width = stm32_mdma_get_width(chan, dst_addr_width);
 		if (dst_bus_width < 0)
 			return dst_bus_width;
 		ctcr &= ~STM32_MDMA_CTCR_DSIZE_MASK;
 		ctcr |= STM32_MDMA_CTCR_DSIZE(dst_bus_width);
+		if (chan_config->m2m_hw) {
+			ctcr &= ~STM32_MDMA_CTCR_DINCOS_MASK;
+			ctcr |= STM32_MDMA_CTCR_DINCOS(dst_bus_width);
+		}
 
 		/* Set device burst value */
+		if (chan_config->m2m_hw)
+			dst_maxburst = STM32_MDMA_MAX_BUF_LEN / dst_addr_width;
+
 		dst_best_burst = stm32_mdma_get_best_burst(buf_len, tlen,
 							   dst_maxburst,
 							   dst_addr_width);
@@ -588,13 +605,24 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 		src_addr = chan->dma_config.src_addr;
 
 		/* Set device data size */
+		if (chan_config->m2m_hw)
+			src_addr_width = stm32_mdma_get_max_width(src_addr, buf_len,
+								  STM32_MDMA_MAX_BUF_LEN);
+
 		src_bus_width = stm32_mdma_get_width(chan, src_addr_width);
 		if (src_bus_width < 0)
 			return src_bus_width;
 		ctcr &= ~STM32_MDMA_CTCR_SSIZE_MASK;
 		ctcr |= STM32_MDMA_CTCR_SSIZE(src_bus_width);
+		if (chan_config->m2m_hw) {
+			ctcr &= ~STM32_MDMA_CTCR_SINCOS_MASK;
+			ctcr |= STM32_MDMA_CTCR_SINCOS(src_bus_width);
+		}
 
 		/* Set device burst value */
+		if (chan_config->m2m_hw)
+			src_maxburst = STM32_MDMA_MAX_BUF_LEN / src_addr_width;
+
 		src_best_burst = stm32_mdma_get_best_burst(buf_len, tlen,
 							   src_maxburst,
 							   src_addr_width);
@@ -702,11 +730,15 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
 {
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	struct dma_slave_config *dma_config = &chan->dma_config;
+	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
 	struct scatterlist *sg;
 	dma_addr_t src_addr, dst_addr;
-	u32 ccr, ctcr, ctbr;
+	u32 m2m_hw_period, ccr, ctcr, ctbr;
 	int i, ret = 0;
 
+	if (chan_config->m2m_hw)
+		m2m_hw_period = sg_dma_len(sgl);
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		if (sg_dma_len(sg) > STM32_MDMA_MAX_BLOCK_LEN) {
 			dev_err(chan2dev(chan), "Invalid block len\n");
@@ -716,6 +748,8 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
 		if (direction == DMA_MEM_TO_DEV) {
 			src_addr = sg_dma_address(sg);
 			dst_addr = dma_config->dst_addr;
+			if (chan_config->m2m_hw && (i & 1))
+				dst_addr += m2m_hw_period;
 			ret = stm32_mdma_set_xfer_param(chan, direction, &ccr,
 							&ctcr, &ctbr, src_addr,
 							sg_dma_len(sg));
@@ -723,6 +757,8 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
 					   src_addr);
 		} else {
 			src_addr = dma_config->src_addr;
+			if (chan_config->m2m_hw && (i & 1))
+				src_addr += m2m_hw_period;
 			dst_addr = sg_dma_address(sg);
 			ret = stm32_mdma_set_xfer_param(chan, direction, &ccr,
 							&ctcr, &ctbr, dst_addr,
@@ -755,6 +791,7 @@ stm32_mdma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
 			 unsigned long flags, void *context)
 {
 	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
+	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
 	struct stm32_mdma_desc *desc;
 	int i, ret;
 
@@ -777,6 +814,21 @@ stm32_mdma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
 	if (ret < 0)
 		goto xfer_setup_err;
 
+	/*
+	 * In case of M2M HW transfer triggered by STM32 DMA, we do not have to clear the
+	 * transfer complete flag by hardware in order to let the CPU rearm the STM32 DMA
+	 * with the next sg element and update some data in dmaengine framework.
+	 */
+	if (chan_config->m2m_hw && direction == DMA_MEM_TO_DEV) {
+		struct stm32_mdma_hwdesc *hwdesc;
+
+		for (i = 0; i < sg_len; i++) {
+			hwdesc = desc->node[i].hwdesc;
+			hwdesc->cmar = 0;
+			hwdesc->cmdr = 0;
+		}
+	}
+
 	desc->cyclic = false;
 
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
@@ -798,6 +850,7 @@ stm32_mdma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
 	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	struct dma_slave_config *dma_config = &chan->dma_config;
+	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
 	struct stm32_mdma_desc *desc;
 	dma_addr_t src_addr, dst_addr;
 	u32 ccr, ctcr, ctbr, count;
@@ -858,8 +911,12 @@ stm32_mdma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
 		if (direction == DMA_MEM_TO_DEV) {
 			src_addr = buf_addr + i * period_len;
 			dst_addr = dma_config->dst_addr;
+			if (chan_config->m2m_hw && (i & 1))
+				dst_addr += period_len;
 		} else {
 			src_addr = dma_config->src_addr;
+			if (chan_config->m2m_hw && (i & 1))
+				src_addr += period_len;
 			dst_addr = buf_addr + i * period_len;
 		}
 
@@ -1244,6 +1301,17 @@ static int stm32_mdma_slave_config(struct dma_chan *c,
 
 	memcpy(&chan->dma_config, config, sizeof(*config));
 
+	/* Check if user is requesting STM32 DMA to trigger MDMA */
+	if (config->peripheral_size) {
+		struct stm32_mdma_dma_config *mdma_config;
+
+		mdma_config = (struct stm32_mdma_dma_config *)chan->dma_config.peripheral_config;
+		chan->chan_config.request = mdma_config->request;
+		chan->chan_config.mask_addr = mdma_config->cmar;
+		chan->chan_config.mask_data = mdma_config->cmdr;
+		chan->chan_config.m2m_hw = true;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

