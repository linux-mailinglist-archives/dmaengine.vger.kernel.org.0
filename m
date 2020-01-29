Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E386714CD9A
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 16:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgA2Pgy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 10:36:54 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29562 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbgA2Pgx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 10:36:53 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TFNBY9019444;
        Wed, 29 Jan 2020 16:36:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=wgw0wJHxD0KqntR0Tj8TO+wUsOBJhHj4e4NzjycWHY0=;
 b=DnNqfCFPPQOr0IV5DnGJH2VN3Olbe6oSMkOAWI+gSpdh1nP60QH26H7a8sFhzOptAXOU
 j7GOsZE7S6GdLcpwcY/9TOi+EZGkGnKY6EfwUBJpyTXDW+sovjABpkKBrXHGoICXj+yw
 U9vJ1fnl/qVKTsXLsVh0G/3HSE2iFYbfwqDKzmlxEfR1RQCV42t1fi1fBmu9wHHzKmgT
 HvXuXa23hPeO2LOZ6YTHq9fkjFnV1Jh6GBFew5yAj4GjqXtNvGejnGMHiwd14Txk7JYL
 rXzHcjXe5Ojv2yc7A4+uvz1q1fwq72vzHWR5BsQrUsgA77QAhxq2a8nxoacqAecW9DPT GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcay3vb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 16:36:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A580A10002A;
        Wed, 29 Jan 2020 16:36:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 986FD2BC7C2;
        Wed, 29 Jan 2020 16:36:37 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
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
Subject: [PATCH 5/8] dmaengine: stm32-dma: use dma_set_max_seg_size to set the sg limit
Date:   Wed, 29 Jan 2020 16:36:25 +0100
Message-ID: <20200129153628.29329-6-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129153628.29329-1-amelie.delaunay@st.com>
References: <20200129153628.29329-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_03:2020-01-28,2020-01-29 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch adds dma_set_max_seg_size to define sg dma constraint.
This constraint may be taken into account by client to scatter/gather
its buffer.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 25f7281932bd..b7e18cfcd439 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1323,6 +1323,8 @@ static int stm32_dma_probe(struct platform_device *pdev)
 		reset_control_deassert(rst);
 	}
 
+	dma_set_max_seg_size(&pdev->dev, STM32_DMA_ALIGNED_MAX_DATA_ITEMS);
+
 	dma_cap_set(DMA_SLAVE, dd->cap_mask);
 	dma_cap_set(DMA_PRIVATE, dd->cap_mask);
 	dma_cap_set(DMA_CYCLIC, dd->cap_mask);
-- 
2.17.1

