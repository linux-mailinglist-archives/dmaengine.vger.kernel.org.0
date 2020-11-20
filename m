Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF972BABF0
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 15:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKTOdt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 09:33:49 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26530 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727655AbgKTOdo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Nov 2020 09:33:44 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AKEXH9G018445;
        Fri, 20 Nov 2020 15:33:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=59iCytnGymJH0uJ5EK2z0sOlGCuFc+6x4wxAG7ErbAo=;
 b=u+b57zftothCtm3XEpszI5WJRg07SvAYq/+dw2XJNsxWNnny1wmUT1z4mQpKxaTckgXF
 cFfpl5gv4zKA+0tBa8iPNXqDyv+9+qK5DGbnNKoGNk6eXmrsJIEANRFn++PQDcM+JGY/
 JwkhlFIadUd7TVgn10QpXtdgUBS+JO3lb4lHZAFBk+JC1+K3xKlKFiCIBGA4Is5N1HUI
 zYF8/sza006dtzvNiYfE2quo4StVNu+Nl3374hDyNWRywfSsUIK8mhG1iMUP9bmwf/+t
 dChMR8sXONRgWd1xeKC11gM313VIrUzOkuevcnfvbETECuHn8FVzHnJWaXDE/q5eWWSO nQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t58d7uf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 15:33:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BDB7610002A;
        Fri, 20 Nov 2020 15:33:29 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B12422777DE;
        Fri, 20 Nov 2020 15:33:29 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Nov 2020 15:33:29
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH 3/4] dmaengine: stm32-dma: take address into account when computing max width
Date:   Fri, 20 Nov 2020 15:33:19 +0100
Message-ID: <20201120143320.30367-4-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120143320.30367-1-amelie.delaunay@st.com>
References: <20201120143320.30367-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_07:2020-11-20,2020-11-20 signatures=0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DMA_SxPAR or DMA_SxM0AR/M1AR registers have to be aligned on PSIZE or MSIZE
respectively. This means that bus width needs to be forced to 1 byte when
computed width is not aligned with address.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dma.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 62501e5d9e9d..f54ecb123a52 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -264,9 +264,11 @@ static int stm32_dma_get_width(struct stm32_dma_chan *chan,
 }
 
 static enum dma_slave_buswidth stm32_dma_get_max_width(u32 buf_len,
+						       dma_addr_t buf_addr,
 						       u32 threshold)
 {
 	enum dma_slave_buswidth max_width;
+	u64 addr = buf_addr;
 
 	if (threshold == STM32_DMA_FIFO_THRESHOLD_FULL)
 		max_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -277,6 +279,9 @@ static enum dma_slave_buswidth stm32_dma_get_max_width(u32 buf_len,
 	       max_width > DMA_SLAVE_BUSWIDTH_1_BYTE)
 		max_width = max_width >> 1;
 
+	if (do_div(addr, max_width))
+		max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
 	return max_width;
 }
 
@@ -707,7 +712,7 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
 static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 				    enum dma_transfer_direction direction,
 				    enum dma_slave_buswidth *buswidth,
-				    u32 buf_len)
+				    u32 buf_len, dma_addr_t buf_addr)
 {
 	enum dma_slave_buswidth src_addr_width, dst_addr_width;
 	int src_bus_width, dst_bus_width;
@@ -739,7 +744,8 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 			return dst_burst_size;
 
 		/* Set memory data size */
-		src_addr_width = stm32_dma_get_max_width(buf_len, fifoth);
+		src_addr_width = stm32_dma_get_max_width(buf_len, buf_addr,
+							 fifoth);
 		chan->mem_width = src_addr_width;
 		src_bus_width = stm32_dma_get_width(chan, src_addr_width);
 		if (src_bus_width < 0)
@@ -788,7 +794,8 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 			return src_burst_size;
 
 		/* Set memory data size */
-		dst_addr_width = stm32_dma_get_max_width(buf_len, fifoth);
+		dst_addr_width = stm32_dma_get_max_width(buf_len, buf_addr,
+							 fifoth);
 		chan->mem_width = dst_addr_width;
 		dst_bus_width = stm32_dma_get_width(chan, dst_addr_width);
 		if (dst_bus_width < 0)
@@ -876,7 +883,8 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		ret = stm32_dma_set_xfer_param(chan, direction, &buswidth,
-					       sg_dma_len(sg));
+					       sg_dma_len(sg),
+					       sg_dma_address(sg));
 		if (ret < 0)
 			goto err;
 
@@ -944,7 +952,8 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 		return NULL;
 	}
 
-	ret = stm32_dma_set_xfer_param(chan, direction, &buswidth, period_len);
+	ret = stm32_dma_set_xfer_param(chan, direction, &buswidth, period_len,
+				       buf_addr);
 	if (ret < 0)
 		return NULL;
 
-- 
2.17.1

