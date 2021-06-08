Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD44439F295
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jun 2021 11:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFHJkZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Jun 2021 05:40:25 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52058 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230293AbhFHJkX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Jun 2021 05:40:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UbkgnjE_1623145105;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UbkgnjE_1623145105)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Jun 2021 17:38:27 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     hyun.kwon@xilinx.com
Cc:     laurent.pinchart@ideasonboard.com, vkoul@kernel.org,
        michal.simek@xilinx.com, nathan@kernel.org,
        ndesaulniers@google.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] dmaengine: xilinx: dpdma: fix kernel-doc
Date:   Tue,  8 Jun 2021 17:36:56 +0800
Message-Id: <1623145017-104752-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix function name in xilinx/xilinx_dpdma.c kernel-doc comment
to remove a warning found by clang(make W=1 LLVM=1).

drivers/dma/xilinx/xilinx_dpdma.c:935: warning: expecting prototype for
xilinx_dpdma_chan_no_ostand(). Prototype was for
xilinx_dpdma_chan_notify_no_ostand() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 70b29bd..0c8739a 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -915,7 +915,7 @@ static u32 xilinx_dpdma_chan_ostand(struct xilinx_dpdma_chan *chan)
 }
 
 /**
- * xilinx_dpdma_chan_no_ostand - Notify no outstanding transaction event
+ * xilinx_dpdma_chan_notify_no_ostand - Notify no outstanding transaction event
  * @chan: DPDMA channel
  *
  * Notify waiters for no outstanding event, so waiters can stop the channel
-- 
1.8.3.1

