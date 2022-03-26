Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A0C4E80C3
	for <lists+dmaengine@lfdr.de>; Sat, 26 Mar 2022 13:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiCZM0C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 26 Mar 2022 08:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiCZM0B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 26 Mar 2022 08:26:01 -0400
X-Greylist: delayed 455 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Mar 2022 05:24:15 PDT
Received: from mail-m17637.qiye.163.com (mail-m17637.qiye.163.com [59.111.176.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B4211987A;
        Sat, 26 Mar 2022 05:24:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id BD5AE98029A;
        Sat, 26 Mar 2022 20:16:37 +0800 (CST)
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     vkoul@kernel.org
Cc:     Sugar Zhang <sugar.zhang@rock-chips.com>,
        Huibin Hong <huibin.hong@rock-chips.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: pl330: Fix unbalanced runtime PM
Date:   Sat, 26 Mar 2022 20:16:28 +0800
Message-Id: <1648296988-45745-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlKS0tKN1dZLVlBSVdZDwkaFQgSH1lBWUMZTh1WSkxOSBhLTE
        ofTh5CVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OU06Ejo5FD4DLxY1IT40HBYe
        NjkaCR9VSlVKTU9DSUJNQkJDSkhDVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
        WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSE9CTTcG
X-HM-Tid: 0a7fc628340ed992kuwsbd5ae98029a
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This driver use runtime PM autosuspend mechanism to manager clk.

  pm_runtime_use_autosuspend(&adev->dev);
  pm_runtime_set_autosuspend_delay(&adev->dev, PL330_AUTOSUSPEND_DELAY);

So, after ref count reached to zero, it will enter suspend
after the delay time elapsed.

The unbalanced PM:

* May cause dmac the next start failed.
* May cause dmac read unexpected state.
* May cause dmac stall if power down happen at the middle of the transfer.
  e.g. may lose ack from AXI bus and stall.

Considering the following situation:

      DMA TERMINATE               TASKLET ROUTINE
            |                            |
            |                       issue_pending
            |                            |
            |                     pch->active = true
            |                       pm_runtime_get
  pm_runtime_put(if active)              |
    pch->active = false                  |
            |                      work_list empty
            |                            |
            |                     pm_runtime_put(force)
            |                            |

At this point, it's unbalanced(1 get / 2 put).

After this patch:

      DMA TERMINATE               TASKLET ROUTINE
            |                            |
            |                       issue_pending
            |                            |
            |                     pch->active = true
            |                       pm_runtime_get
  pm_runtime_put(if active)              |
    pch->active = false                  |
            |                      work_list empty
            |                            |
            |                   pm_runtime_put(if active)
            |                            |

Now, it's balanced(1 get / 1 put).

Fixes:
commit 5c9e6c2b2ba3 ("dmaengine: pl330: Fix runtime PM support for terminated transfers")
commit ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 858400e..ccd430e 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2084,7 +2084,7 @@ static void pl330_tasklet(struct tasklet_struct *t)
 		spin_lock(&pch->thread->dmac->lock);
 		_stop(pch->thread);
 		spin_unlock(&pch->thread->dmac->lock);
-		power_down = true;
+		power_down = pch->active;
 		pch->active = false;
 	} else {
 		/* Make sure the PL330 Channel thread is active */
-- 
2.7.4

