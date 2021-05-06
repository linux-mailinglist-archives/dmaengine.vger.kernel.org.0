Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6893752BB
	for <lists+dmaengine@lfdr.de>; Thu,  6 May 2021 13:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhEFLB4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 May 2021 07:01:56 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:57747 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234508AbhEFLBz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 May 2021 07:01:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UXxdEDe_1620298849;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UXxdEDe_1620298849)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 May 2021 19:00:56 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dave.jiang@intel.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] dmaengine: idxd: Remove redundant variable cdev_ctx
Date:   Thu,  6 May 2021 19:00:47 +0800
Message-Id: <1620298847-33127-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Variable cdev_ctx is set to '&ictx[wq->idxd->data->type]' but this
value is not used, hence it is a redundant assignment and can be
removed.

Clean up the following clang-analyzer warning:

drivers/dma/idxd/cdev.c:300:2: warning: Value stored to 'cdev_ctx' is
never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/dma/idxd/cdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 302cba5..6c72089 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -295,9 +295,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 void idxd_wq_del_cdev(struct idxd_wq *wq)
 {
 	struct idxd_cdev *idxd_cdev;
-	struct idxd_cdev_context *cdev_ctx;
 
-	cdev_ctx = &ictx[wq->idxd->data->type];
 	idxd_cdev = wq->idxd_cdev;
 	wq->idxd_cdev = NULL;
 	cdev_device_del(&idxd_cdev->cdev, &idxd_cdev->dev);
-- 
1.8.3.1

