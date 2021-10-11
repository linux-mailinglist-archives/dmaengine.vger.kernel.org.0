Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B814289E6
	for <lists+dmaengine@lfdr.de>; Mon, 11 Oct 2021 11:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhJKJpS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 05:45:18 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51802 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235577AbhJKJpS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Oct 2021 05:45:18 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B80XNt014101;
        Mon, 11 Oct 2021 11:43:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=O0JMbw+qIeEBzzCCeApdP+Pra+K3FyzR/Sgp0B/Og3Y=;
 b=yJh92PjsvkcrAxXt82FJvTDRTmx2ZCBQVD/6/azsCHvrt1UFObw8R2z+rjV/ql+iuYL+
 qHBK7DZZd9zlpkwSJ2QxN4XNgat++JHaLDJpIAT8Ji2q4zV7U7N5NqoJiKlcV/kJ2MLp
 28+v+zdK8PuOD5GM+3UebymtJpUtMFTmil1dunvGliyykluQ2uHN9OJM85tVfkzkucNq
 n0Wgo6v37Cj8bTTCh62FXT3yUgo/Mn5bdhr9P+RKA48FM+36aYQOfddVWtJsHDY2rSLu
 vq/OwMFXP2Z9QqvztOfmJXIyoq9YbgL7smLxz8uLWzqjoXlZy7wXKuFbptBqJN6ZNMO0 BA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bmasq2mxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 11:43:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C96010002A;
        Mon, 11 Oct 2021 11:43:07 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 019FB21B50C;
        Mon, 11 Oct 2021 11:43:07 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 11 Oct 2021 11:43:06
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Pierre-Yves Mordret <pierre-yves.mordret@foss.st.com>
Subject: [PATCH 1/3] dmaengine: stm32-dma: mark pending descriptor complete in terminate_all
Date:   Mon, 11 Oct 2021 11:42:57 +0200
Message-ID: <20211011094259.315023-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011094259.315023-1-amelie.delaunay@foss.st.com>
References: <20211011094259.315023-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_03,2021-10-07_02,2020-04-07_01
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To prevent accidental repeated completion, mark pending descriptor
complete in terminate_all. It can be the case when terminate_all is called
while no end of transfer interrupt occurs.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 9063c727962e..a5ccf3fa95e0 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -497,6 +497,7 @@ static int stm32_dma_terminate_all(struct dma_chan *c)
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 
 	if (chan->desc) {
+		dma_cookie_complete(&chan->desc->vdesc.tx);
 		vchan_terminate_vdesc(&chan->desc->vdesc);
 		if (chan->busy)
 			stm32_dma_stop(chan);
-- 
2.25.1

