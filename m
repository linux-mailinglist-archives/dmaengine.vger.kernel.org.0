Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C850926D450
	for <lists+dmaengine@lfdr.de>; Thu, 17 Sep 2020 09:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIQHLZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 03:11:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbgIQHLY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Sep 2020 03:11:24 -0400
X-Greylist: delayed 948 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 03:11:22 EDT
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D5AEC96FAD640423BE27;
        Thu, 17 Sep 2020 14:55:32 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 14:55:23 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] dmaengine: sf-pdma: Remove set but not used variable "desc"
Date:   Thu, 17 Sep 2020 15:17:56 +0800
Message-ID: <20200917071756.1915449-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/dma/sf-pdma/sf-pdma.c: In function 'sf_pdma_donebh_tasklet':
drivers/dma/sf-pdma/sf-pdma.c:287:23: warning: unused variable 'desc' [-Wunused-variable]

After commit 8f6b6d060602 ("dmaengine: sf-pdma: Fix an error that calls callback twice"),
variable 'desc' is never used. Remove it to avoid build warning.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 754994087e5f..1e66c6990d81 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -284,7 +284,6 @@ static void sf_pdma_free_desc(struct virt_dma_desc *vdesc)
 static void sf_pdma_donebh_tasklet(unsigned long arg)
 {
 	struct sf_pdma_chan *chan = (struct sf_pdma_chan *)arg;
-	struct sf_pdma_desc *desc = chan->desc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->lock, flags);
-- 
2.25.1

