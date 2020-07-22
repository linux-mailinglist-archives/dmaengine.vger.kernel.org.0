Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A188229CF2
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jul 2020 18:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGVQSA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 12:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgGVQSA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jul 2020 12:18:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECDBC0619DC
        for <dmaengine@vger.kernel.org>; Wed, 22 Jul 2020 09:18:00 -0700 (PDT)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8E729329;
        Wed, 22 Jul 2020 18:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595434677;
        bh=VWOdb3OMhgJUj9Vg0H541Md5v46RytKjb8SwIOE/vhg=;
        h=From:To:Cc:Subject:Date:From;
        b=HI7KRf41sKXWFGe0PafjEorZ6tnQGgXEWo1uxlQAHccv5z3vT03jgyqhwQWc1J76F
         flj+Rm6TzrBeSR+l2v24fLS5s6vZyr37jlJJSlV5nEMx77hQaWhsfqYdFVZURTsPzz
         YFpflhudhHhrYJEkNbq2eNVkmNb/p/RBIZfMBbow=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] dmaengine: xilinx: dpdma: Fix kerneldoc warning
Date:   Wed, 22 Jul 2020 19:17:47 +0300
Message-Id: <20200722161747.30048-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document the struct xilinx_dpdma_chan desc field to fix a kerneldoc
undocumented member warning (which can be reproduced by compiling with
W=1).

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 47c9bb02ce3c..b8edd5bc065a 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -215,6 +215,7 @@ struct xilinx_dpdma_tx_desc {
  * @lock: lock to access struct xilinx_dpdma_chan
  * @desc_pool: descriptor allocation pool
  * @err_task: error IRQ bottom half handler
+ * @desc: References to descriptors being processed
  * @desc.pending: Descriptor schedule to the hardware, pending execution
  * @desc.active: Descriptor being executed by the hardware
  * @xdev: DPDMA device
-- 
Regards,

Laurent Pinchart

