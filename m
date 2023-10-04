Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594FA7B856B
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 18:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbjJDQgR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 12:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjJDQgQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 12:36:16 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBA4C0;
        Wed,  4 Oct 2023 09:36:11 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394CT3GR008905;
        Wed, 4 Oct 2023 18:35:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=Z53DfuJZW+Q+VIEyVMKQjbTggimV1KXI0jR6FczH0GA=; b=mc
        rRFYZ9lYhyhVQ3xjC9bRAQGnhylVdtdfjfmU2fREquAnso1HI5dnglaJSS9SAeGL
        lropzWprYap2aprXttHdw609ifdzDP4o3xNKHHJYSvmg7nh025bnFow8fEgvRRhN
        Evr+Wxift+2OfjHCTq0uaigoF8eNw1s5zuFli8CSpwLJL7/4QVdVkNWabP4+a5ln
        DKGNCZmkCd9ViwDWREBZf62Z8PeF4y8+9VxFJz1dCN+TaizOiZQD5US1LVgWW9lw
        oSSrOvr4oiJ5fA/QvqS4XbIDP2G2J1jdVciGy1tQ9MuZb+zgHD7LTsnE3ZFn+xvK
        WjwCTcQ2s2LmbSF/aryw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3te8t528du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 18:35:57 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1ED66100053;
        Wed,  4 Oct 2023 18:35:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 16084281EB6;
        Wed,  4 Oct 2023 18:35:57 +0200 (CEST)
Received: from localhost (10.252.26.61) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 18:35:56 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
CC:     <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] dmaengine: stm32-mdma: set in_flight_bytes in case CRQA flag is set
Date:   Wed, 4 Oct 2023 18:35:30 +0200
Message-ID: <20231004163531.2864160-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004163531.2864160-1-amelie.delaunay@foss.st.com>
References: <20231004163531.2864160-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.26.61]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_08,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

CRQA flag is set by hardware when the channel request become active and
the channel is enabled. It is cleared by hardware, when the channel request
is completed.
So when it is set, it means MDMA is transferring bytes.
This information is useful in case of STM32 DMA and MDMA chaining,
especially when the user pauses DMA before stopping it, to trig one last
MDMA transfer to get the latest bytes of the SRAM buffer to the
destination buffer.
STM32 DCMI driver can then use this to know if the last MDMA transfer in
case of chaining is done.

Fixes: 696874322771 ("dmaengine: stm32-mdma: add support to be triggered by STM32 DMA")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: stable@vger.kernel.org
---
 drivers/dma/stm32-mdma.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index da73e13b8c9d..bae08b3f55c7 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1318,7 +1318,8 @@ static int stm32_mdma_slave_config(struct dma_chan *c,
 
 static size_t stm32_mdma_desc_residue(struct stm32_mdma_chan *chan,
 				      struct stm32_mdma_desc *desc,
-				      u32 curr_hwdesc)
+				      u32 curr_hwdesc,
+				      struct dma_tx_state *state)
 {
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	struct stm32_mdma_hwdesc *hwdesc;
@@ -1342,6 +1343,10 @@ static size_t stm32_mdma_desc_residue(struct stm32_mdma_chan *chan,
 	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));
 	residue += cbndtr & STM32_MDMA_CBNDTR_BNDT_MASK;
 
+	state->in_flight_bytes = 0;
+	if (chan->chan_config.m2m_hw && (cisr & STM32_MDMA_CISR_CRQA))
+		state->in_flight_bytes = cbndtr & STM32_MDMA_CBNDTR_BNDT_MASK;
+
 	if (!chan->mem_burst)
 		return residue;
 
@@ -1371,11 +1376,10 @@ static enum dma_status stm32_mdma_tx_status(struct dma_chan *c,
 
 	vdesc = vchan_find_desc(&chan->vchan, cookie);
 	if (chan->desc && cookie == chan->desc->vdesc.tx.cookie)
-		residue = stm32_mdma_desc_residue(chan, chan->desc,
-						  chan->curr_hwdesc);
+		residue = stm32_mdma_desc_residue(chan, chan->desc, chan->curr_hwdesc, state);
 	else if (vdesc)
-		residue = stm32_mdma_desc_residue(chan,
-						  to_stm32_mdma_desc(vdesc), 0);
+		residue = stm32_mdma_desc_residue(chan, to_stm32_mdma_desc(vdesc), 0, state);
+
 	dma_set_residue(state, residue);
 
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
-- 
2.25.1

