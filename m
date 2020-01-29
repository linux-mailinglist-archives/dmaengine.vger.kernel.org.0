Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD9614CD8A
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 16:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgA2Pg5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 10:36:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29528 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgA2Pg4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 10:36:56 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TFNArm019435;
        Wed, 29 Jan 2020 16:36:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=vGtBudjNx6L0Bif2GlT7GRdzDPa/Yv2/z0Y5HH4v5qQ=;
 b=nm7n2Cr43o+71a44OQNGZea0xkO4CYasOZfS080j2NeTorJxpdBswUuvJPUx2t33cSZN
 J0amRXk72bn6UXTbyP+4udi2p6wBWsJU3t/7utE0OphCdR1oTDNudbAgurah/rManvqG
 i/1rIUUwjl02EIDIMIXceqWNzZG08Ov8TOI/xVwE+4DiV0LZONiqiN0U2c28xtMLr/dI
 Zo1u3qi7CKeMpcpf1ezM0HdlMrPIxPmS2qXjtdwP6Ir015mS1KqiVILjQ4/5KFLFgrRs
 HlIL5ymie/2ZuqFtepdZ71FaeUW2ZnGaJLR9stpCzQlFLlT4jaQnjHa0WPJ53tF/Bf7q 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcay3vbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 16:36:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9A22C10002A;
        Wed, 29 Jan 2020 16:36:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 899062BC7C2;
        Wed, 29 Jan 2020 16:36:39 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 29 Jan 2020 16:36:39
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
Subject: [PATCH 8/8] dmaengine: stm32-dma: use vchan_terminate_vdesc() in .terminate_all
Date:   Wed, 29 Jan 2020 16:36:28 +0100
Message-ID: <20200129153628.29329-9-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129153628.29329-1-amelie.delaunay@st.com>
References: <20200129153628.29329-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_03:2020-01-28,2020-01-29 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Move vdesc->node list_del in stm32_dma_start_transfer instead of in
stm32_mdma_chan_complete to avoid another race in vchan_dma_desc_free_list.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index b585e11c2168..0ddbaa4b4f0b 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -478,8 +478,10 @@ static int stm32_dma_terminate_all(struct dma_chan *c)
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 
-	if (chan->busy) {
-		stm32_dma_stop(chan);
+	if (chan->desc) {
+		vchan_terminate_vdesc(&chan->desc->vdesc);
+		if (chan->busy)
+			stm32_dma_stop(chan);
 		chan->desc = NULL;
 	}
 
@@ -535,6 +537,8 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 		if (!vdesc)
 			return;
 
+		list_del(&vdesc->node);
+
 		chan->desc = to_stm32_dma_desc(vdesc);
 		chan->next_sg = 0;
 	}
@@ -613,7 +617,6 @@ static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan)
 		} else {
 			chan->busy = false;
 			if (chan->next_sg == chan->desc->num_sgs) {
-				list_del(&chan->desc->vdesc.node);
 				vchan_cookie_complete(&chan->desc->vdesc);
 				chan->desc = NULL;
 			}
-- 
2.17.1

