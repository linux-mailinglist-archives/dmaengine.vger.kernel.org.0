Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7BE14CD95
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 16:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgA2PhJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 10:37:09 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48539 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726842AbgA2Pg4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 10:36:56 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TFNBY8019444;
        Wed, 29 Jan 2020 16:36:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=AftG5z+N17+/aKK5rA8xT7aJNL2Vyvyl7T7R+UeirkA=;
 b=DDpHNdKJ02FAGVPens/IbVD4G5USzy1RxDXJLEQ55d/zr6gldzhDUX3PizE9xvyUlzJw
 cWDF+fjHZXHq8SDKPlB4jiJ4uhuCebTVzh681T3oun0q+JTqtUPZgaGGErk411egmX1C
 9pjOE96zV/gX6o1nLLzF+eMh7jvySoqOmADVbChz4I3IxpeqKzaCMwkTYQddjU65cW5E
 BrZp7Qa4BYjDfUgaalLPMp2yv8IBvVuT2hCmOLvDYCw5F1iRNXmMwRj+T9PER5XJoUTq
 FZvav89dlKtRxFpoP3JiWgjcCqP8RJtcLznnwpmf8k3ZrXXXq+3Nhc+68Wx9flQ480Y5 /A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcay3vb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 16:36:37 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DF04100034;
        Wed, 29 Jan 2020 16:36:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10CD72BC7C2;
        Wed, 29 Jan 2020 16:36:37 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 29 Jan 2020 16:36:36
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
Subject: [PATCH 4/8] dmaengine: stm32-dma: enable descriptor_reuse
Date:   Wed, 29 Jan 2020 16:36:24 +0100
Message-ID: <20200129153628.29329-5-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129153628.29329-1-amelie.delaunay@st.com>
References: <20200129153628.29329-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_03:2020-01-28,2020-01-29 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Enable client to resubmit already processed descriptors
in order to save descriptor creation time.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index c8bbe08b8e32..25f7281932bd 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -554,6 +554,7 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 	sg_req = &chan->desc->sg_req[chan->next_sg];
 	reg = &sg_req->chan_reg;
 
+	reg->dma_scr &= ~STM32_DMA_SCR_EN;
 	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg->dma_scr);
 	stm32_dma_write(dmadev, STM32_DMA_SPAR(chan->id), reg->dma_spar);
 	stm32_dma_write(dmadev, STM32_DMA_SM0AR(chan->id), reg->dma_sm0ar);
@@ -1343,6 +1344,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	dd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	dd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	dd->max_burst = STM32_DMA_MAX_BURST;
+	dd->descriptor_reuse = true;
 	dd->dev = &pdev->dev;
 	INIT_LIST_HEAD(&dd->channels);
 
-- 
2.17.1

