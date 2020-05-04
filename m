Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACA51C383F
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 13:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgEDLey (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 07:34:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726756AbgEDLey (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 May 2020 07:34:54 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 96B418D5E6CF843B1EDC;
        Mon,  4 May 2020 19:34:52 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 4 May 2020
 19:34:43 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <okaya@kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] dmaengine: qcom_hidma: use true,false for bool variable
Date:   Mon, 4 May 2020 19:34:06 +0800
Message-ID: <20200504113406.41530-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix the following coccicheck warning:

drivers/dma/qcom/hidma.c:553:1-17: WARNING: Assignment of 0/1 to bool
variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/dma/qcom/hidma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 87490e125bc3..0a6d3ea08c78 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -550,7 +550,7 @@ static void hidma_free_chan_resources(struct dma_chan *dmach)
 		kfree(mdesc);
 	}
 
-	mchan->allocated = 0;
+	mchan->allocated = false;
 	spin_unlock_irqrestore(&mchan->lock, irqflags);
 }
 
-- 
2.21.1

