Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B73354F04
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 10:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244591AbhDFIvE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 04:51:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15553 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhDFIvE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 04:51:04 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF1Q21CjHzPnc2;
        Tue,  6 Apr 2021 16:48:10 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Tue, 6 Apr 2021
 16:50:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>, <eugen.hristev@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dmaengine: at_xdmac: Remove unused inline function at_xdmac_csize()
Date:   Tue, 6 Apr 2021 16:50:43 +0800
Message-ID: <20210406085043.32544-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

765c37d87669 ("dmaengine: at_xdmac: rework slave configuration part")
left behind this, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/at_xdmac.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index fe45ad5d06c4..64a52bf4d737 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -344,17 +344,6 @@ static inline int at_xdmac_chan_is_paused(struct at_xdmac_chan *atchan)
 	return test_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
 }
 
-static inline int at_xdmac_csize(u32 maxburst)
-{
-	int csize;
-
-	csize = ffs(maxburst) - 1;
-	if (csize > 4)
-		csize = -EINVAL;
-
-	return csize;
-};
-
 static inline bool at_xdmac_chan_is_peripheral_xfer(u32 cfg)
 {
 	return cfg & AT_XDMAC_CC_TYPE_PER_TRAN;
-- 
2.17.1

