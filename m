Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CD27A2E23
	for <lists+dmaengine@lfdr.de>; Sat, 16 Sep 2023 08:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbjIPGGo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 16 Sep 2023 02:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbjIPGGm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 16 Sep 2023 02:06:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEBF1BD3
        for <dmaengine@vger.kernel.org>; Fri, 15 Sep 2023 23:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694844397; x=1726380397;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SGYEUKoghyqQg7EgVlgtaVFL9bq8AjOE6SYCHIx4rno=;
  b=ZV0ENC8g4+yFGfuwXXaDHGE65WPA8q/lxj7T41StWFe15WXX36tgVJh7
   3HRVSrLiKbHaguWyGiwmpV++I6ASIlkgIvwjsU1CAA6kC+WR3IAweKLjr
   XwpX+R5oYb54iUgtsTb7mEUiiozaycnvtcUmxHfo3BFhrkJaglnZvIxke
   zGbgYh0dggkiPmzxtCpbPR6bwDbSpT0XMvRFvwdSQ2FoMYb3XUFqo4JSH
   8FGLzwm/4UjGbuk1qzPwgHsgrvINpBxBlcvgJXQrXOaD3UCrOFpMUDP2P
   YF6vM22Ub+ax2DT2McVoreEdwLKSNIUeA0qL9LqWVy/CTE4OXsmikKBqH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="382121934"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="382121934"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 23:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="815408656"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="815408656"
Received: from rex-z390-aorus-pro.sh.intel.com ([10.239.161.21])
  by fmsmga004.fm.intel.com with ESMTP; 15 Sep 2023 23:06:34 -0700
From:   Rex Zhang <rex.zhang@intel.com>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     fenghua.yu@intel.com, dave.jiang@intel.com, lijun.pan@intel.com,
        rex.zhang@intel.com
Subject: [PATCH] dmaengine: idxd: use spin_lock_irqsave before wait_event_lock_irq
Date:   Sat, 16 Sep 2023 14:06:19 +0800
Message-Id: <20230916060619.3744220-1-rex.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In idxd_cmd_exec(), wait_event_lock_irq() explicitly calls
spin_unlock_irq()/spin_lock_irq(). If the interrupt is on before entering
wait_event_lock_irq(), it will become off status after
wait_event_lock_irq() is called. Later, wait_for_completion() may go to
sleep but irq is disabled. The scenario is warned in might_sleep().

Fix it by using spin_lock_irqsave() instead of the primitive spin_lock()
to save the irq status before entering wait_event_lock_irq() and using
spin_unlock_irqrestore() instead of the primitive spin_unlock() to restore
the irq status before entering wait_for_completion().

Before the change:
idxd_cmd_exec() {
interrupt is on
spin_lock()                        // interrupt is on
	wait_event_lock_irq()
		spin_unlock_irq()  // interrupt is enabled
		...
		spin_lock_irq()    // interrupt is disabled
spin_unlock()                      // interrupt is still disabled
wait_for_completion()              // report "BUG: sleeping function
				   // called from invalid context...
				   // in_atomic() irqs_disabled()"
}

After applying spin_lock_irqsave():
idxd_cmd_exec() {
interrupt is on
spin_lock_irqsave()                // save the on state
				   // interrupt is disabled
	wait_event_lock_irq()
		spin_unlock_irq()  // interrupt is enabled
		...
		spin_lock_irq()    // interrupt is disabled
spin_unlock_irqrestore()           // interrupt is restored to on
wait_for_completion()              // No Call trace
}

Fixes: f9f4082dbc56 ("dmaengine: idxd: remove interrupt disable for cmd_lock")
Signed-off-by: Rex Zhang <rex.zhang@intel.com>
Signed-off-by: Lijun Pan <lijun.pan@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 22d6f4e455b7..8f754f922217 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -477,6 +477,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	union idxd_command_reg cmd;
 	DECLARE_COMPLETION_ONSTACK(done);
 	u32 stat;
+	unsigned long flags;
 
 	if (idxd_device_is_halted(idxd)) {
 		dev_warn(&idxd->pdev->dev, "Device is HALTED!\n");
@@ -490,7 +491,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	cmd.operand = operand;
 	cmd.int_req = 1;
 
-	spin_lock(&idxd->cmd_lock);
+	spin_lock_irqsave(&idxd->cmd_lock, flags);
 	wait_event_lock_irq(idxd->cmd_waitq,
 			    !test_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags),
 			    idxd->cmd_lock);
@@ -507,7 +508,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	 * After command submitted, release lock and go to sleep until
 	 * the command completes via interrupt.
 	 */
-	spin_unlock(&idxd->cmd_lock);
+	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
 	wait_for_completion(&done);
 	stat = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
 	spin_lock(&idxd->cmd_lock);
-- 
2.25.1

