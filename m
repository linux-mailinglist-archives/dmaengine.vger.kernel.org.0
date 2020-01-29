Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3999D14CD88
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 16:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgA2Pgz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 10:36:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48567 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbgA2Pgx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 10:36:53 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TFNArl019435;
        Wed, 29 Jan 2020 16:36:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Z1Wgoe4EswiTX75HahUI/4xIRqX8EIbIqY4iMdzt30U=;
 b=kp+98DtPH1Friws1CwEvSRQyk2c1hlXw0nVpOQn5cOXcx7J6AO0IbqocKcB+JAChEQYN
 t7svnnRIBxYsy4QE5PwIhOko8c7k+AzzL1MQGV498SnjhA9qwAczFgM9q1bjuev7c3Yc
 HrLlvW1mlT7QerkxSPepzgSPfQ4uYIFreO5Tl/SlZOFJIjqSGCwGYiMT/3ND9ohBvh3x
 Zmv4P0bJT4cMfkP2NBugH1NVJEqMgdH13jszczY+A6huqs5ld5C3FeuKeV2l8Nv7HXGD
 4zbTAAT4eCI0pGimrJkki734FX06CabcYqgSI2AiLtvpxpucFaenSKgG4tQvtTGzhBX2 pQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcay3vb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 16:36:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F8D7100034;
        Wed, 29 Jan 2020 16:36:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 32EC52BC7C2;
        Wed, 29 Jan 2020 16:36:38 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 29 Jan 2020 16:36:37
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
Subject: [PATCH 6/8] dmaengine: stm32-dma: add copy_align constraint
Date:   Wed, 29 Jan 2020 16:36:26 +0100
Message-ID: <20200129153628.29329-7-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129153628.29329-1-amelie.delaunay@st.com>
References: <20200129153628.29329-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_03:2020-01-28,2020-01-29 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch adds copy_align property in accordance with hardware
restriction.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index b7e18cfcd439..01a2374ae03a 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1345,6 +1345,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	dd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	dd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	dd->copy_align = DMAENGINE_ALIGN_32_BYTES;
 	dd->max_burst = STM32_DMA_MAX_BURST;
 	dd->descriptor_reuse = true;
 	dd->dev = &pdev->dev;
-- 
2.17.1

