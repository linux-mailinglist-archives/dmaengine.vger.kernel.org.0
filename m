Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C14142B72
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2020 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgATNDl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jan 2020 08:03:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgATNDl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 20 Jan 2020 08:03:41 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4503E6A5299E923BEBF9;
        Mon, 20 Jan 2020 21:03:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 21:03:33 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>
CC:     <peng.ma@nxp.com>, <wen.he_1@nxp.com>, <jiaheng.fan@nxp.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] dmaengine: fsl-qdma: fix duplicated argument to &&
Date:   Mon, 20 Jan 2020 20:58:43 +0800
Message-ID: <20200120125843.34398-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is duplicated argument to && in function fsl_qdma_free_chan_resources,
which looks like a typo, pointer fsl_queue->desc_pool also needs NULL check,
fix it.
Detected with coccinelle.

Fixes: b092529e0aa0 ("dmaengine: fsl-qdma: Add qDMA controller driver for Layerscape SoCs")
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/dma/fsl-qdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 8979208..95cc025 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -304,7 +304,7 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
 
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 
-	if (!fsl_queue->comp_pool && !fsl_queue->comp_pool)
+	if (!fsl_queue->comp_pool && !fsl_queue->desc_pool)
 		return;
 
 	list_for_each_entry_safe(comp_temp, _comp_temp,
-- 
2.7.4

