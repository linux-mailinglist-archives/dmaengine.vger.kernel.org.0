Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9579615EA6
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfEGHzB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 03:55:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:63656 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726103AbfEGHzB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 03:55:01 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x477jvb0032724;
        Tue, 7 May 2019 09:54:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=AlqiG9FZWPVqrG1oTH9valNYZcTMSDs6ZUsTY9A5bUw=;
 b=Ti0HEmX/Gtmc7eCiXXBV2n0s7AmSiaiCChqHmOXaBN6wH1n1ZUQTt3mQjjK42gmhKBaj
 8yvPTkc4uSNe/Z22Jm/bGrz2R9H+56hOXzzxcqZr6lWcIKVrVsiYkZjo8bW4+/npS2lp
 HWQwmH17XuvJPb+tXAr7iHHA+9jSsPtEYnYLNOVjw0LV31/tFEqwfEubmiXsZVvk114r
 Y3lwoLqp2HSfPbHd07xDPeeKNx81/2k5+cI64P9G8pudwSEWG+8KvG6MTzvT9aeSrEa/
 We4h2f1WHeHtlcOq4XWoc1bTZrTm98K3rno4T7vNn/yoktwGObaZUFrVj6J4nnd70oru LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2s94cde0yv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 07 May 2019 09:54:44 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F1BDD3F;
        Tue,  7 May 2019 07:54:42 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A55561490;
        Tue,  7 May 2019 07:54:42 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 7 May 2019
 09:54:42 +0200
Received: from localhost (10.201.20.5) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 7 May 2019 09:54:42 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH] dmaengine: stm32-dma: Fix redundant call to platform_get_irq
Date:   Tue, 7 May 2019 09:54:41 +0200
Message-ID: <1557215681-18541-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_04:,,
 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit c6504be53972 ("dmaengine: stm32-dma: Fix unsigned variable compared
with zero") duplicated the call to platform_get_irq.
So remove the first call to platform_get_irq.

Fixes: c6504be53972 ("dmaengine: stm32-dma: Fix unsigned variable compared with zero")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 88d9c6c..67fdd02 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1366,7 +1366,6 @@ static int stm32_dma_probe(struct platform_device *pdev)
 
 	for (i = 0; i < STM32_DMA_MAX_CHANNELS; i++) {
 		chan = &dmadev->chan[i];
-		chan->irq = platform_get_irq(pdev, i);
 		ret = platform_get_irq(pdev, i);
 		if (ret < 0)  {
 			if (ret != -EPROBE_DEFER)
-- 
2.7.4

