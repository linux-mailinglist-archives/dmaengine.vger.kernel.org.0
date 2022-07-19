Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC7A57A327
	for <lists+dmaengine@lfdr.de>; Tue, 19 Jul 2022 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbiGSPby (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Jul 2022 11:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiGSPbq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Jul 2022 11:31:46 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722CC59242;
        Tue, 19 Jul 2022 08:31:45 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JFNHNr002662;
        Tue, 19 Jul 2022 17:31:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=OHdFWQNeifopdWbgdjW6jtZOq7tqozD7bw8FPdNUfnU=;
 b=JXo3L6+3lzGmJcau+v2xJiof+JzGt9nRHjRr9JN5xg3Lh0yA1bxKSaJfqfutBi0q97X2
 y/Qu8yaEsSVMUqi8FOzl0Wdc6m0rWKWkn9U/vx9a/gDJEuD07x1t0B3ZMCmu2KXnmL1c
 Q+JelY+LtIw2cuOLdV13QvnWZSFjYDs/nW9bQIQosGkqLvouZZx0vfDbkOswwUMM3VrY
 52jSTlhe8PDQchNtbb7B4XpOJm/QBlA6b0ukBUL5IdMxCePntQvsKCCUa26XHlzOxGB/
 G5d7rp9WWqV0ovX3gIQjbrv/7E+WquSdffkLh7URNbpLQqMjWZvYSEJiPEH2TVMJsqPo Qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hbnkg8p25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 17:31:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 10AE810002A;
        Tue, 19 Jul 2022 17:31:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0C80222AFE6;
        Tue, 19 Jul 2022 17:31:29 +0200 (CEST)
Received: from localhost (10.75.127.45) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 19 Jul
 2022 17:31:28 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-doc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v3 4/6] dmaengine: stm32-dmamux: set dmamux channel id in dma features bitfield
Date:   Tue, 19 Jul 2022 17:31:20 +0200
Message-ID: <20220719153122.620730-5-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719153122.620730-1-amelie.delaunay@foss.st.com>
References: <20220719153122.620730-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_04,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

STM32 DMAMUX is used with STM32 DMA1 and DMA2:
- DMAMUX channels 0 to 7 are connected to DMA1 channels 0 to 7
- DMAMUX channels 8 to 15 are connected to DMA2 channels 0 to 7

STM32 MDMA can be triggered by DMA1 and DMA2 channels transfer complete,
and the "request line number" is the DMAMUX channel id (e.g. DMA2 channel 0
triggers MDMA with request line 8).

To well configure MDMA, set DMAMUX channel id in DMA features bitfield,
so that DMA can update struct dma_slave_config peripheral_config properly.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
No changes in v3.

No changes in v2.
---
 drivers/dma/stm32-dmamux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index eee0c5aa5fb5..b431f9da9206 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -147,7 +147,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	mux->request = dma_spec->args[0];
 
 	/*  craft DMA spec */
-	dma_spec->args[3] = dma_spec->args[2];
+	dma_spec->args[3] = dma_spec->args[2] | mux->chan_id << 16;
 	dma_spec->args[2] = dma_spec->args[1];
 	dma_spec->args[1] = 0;
 	dma_spec->args[0] = mux->chan_id - min;
-- 
2.25.1

