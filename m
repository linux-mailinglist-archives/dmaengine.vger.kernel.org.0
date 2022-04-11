Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8971F4FBE47
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346885AbiDKOGn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 10:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346892AbiDKOGm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 10:06:42 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497EB326F7;
        Mon, 11 Apr 2022 07:04:26 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q11so18779669iod.6;
        Mon, 11 Apr 2022 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1B3YrGoPCoufe/mBnsPTr430tDZM1EFQW77g/ziRyJ4=;
        b=nmca+QVhs+M1EdUnH34aYk1Klp9c+hu5uqCQnCqkXA0VPGZMJM8cf1zrTWCC+72Kzg
         8DenjKQy9WLuDqGQIT/uD+GmRqes7vdOVt3L+mlMxWRWuWfTenHYKwFOpzM+yhuzZlJa
         LrtR25KWWVgQZ0eNDlQy3mfA0Kze4zE8is3rgXFpD49GnE9nVEMti4zypcZKkYbSKugJ
         MXlyNGj05RYz9cPKURdsy6zDLNJ0n0+gIbcQTyda0b88PXmYq4hvsNdS/FoJJjHaupte
         mqHgKgOSNRElaS22lt87i3PLA3mcFRtW6QVo2vYnP0kt88pW8icRRHG9k70t6NnIaWGe
         zLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1B3YrGoPCoufe/mBnsPTr430tDZM1EFQW77g/ziRyJ4=;
        b=JIv2GqO2mr5qyVSbpB60wJ2eAnqggvBtUDPqcSI4ucx2YiEEwV98BU+fkZwz29l83I
         oHfbwttAgwjxZwkMvcG3sre87YErbcAyUGFGU1ln0Jk4628ct1HHONAuf9lIiq52Reyg
         xkQuCwYJbfytDejlYrSo48SHFTmNn8xAnfjQEP718PXqEtioDaGr/Sq0kjx13Euhfo4b
         fXSTHtWvRhgTXOPsID8WHrL4iS9ZdfBbtoj91LB91RkFKF3AU9j9TkJVK0tBHVz2GPwT
         JKS5fiMnFYEEUUbnisQb+T2wG3m0T2tEdFoP7xAKl2rI3ZJwsI/GRfIB8gH+vppVWStm
         NRLw==
X-Gm-Message-State: AOAM532UvZZc3xrjOF+zyYBBtrRCbPCEUVAiW0XLPdV4rYXn62rS6ZF+
        TWvBuQVQ6iOIf8X/GZ869Y6YmJtiAMoohw==
X-Google-Smtp-Source: ABdhPJzvdlqpTKyIrYl7Y298HfDIM0/64C8m+JaKg1l+WlrcxEPy58kclVBOkk6w3EY3oAZqX8IWPA==
X-Received: by 2002:a05:6638:3043:b0:314:7ce2:4a6e with SMTP id u3-20020a056638304300b003147ce24a6emr15686074jak.258.1649685866130;
        Mon, 11 Apr 2022 07:04:26 -0700 (PDT)
Received: from nick-desktop.milestone.local (67-4-43-98.sxfl.qwest.net. [67.4.43.98])
        by smtp.gmail.com with ESMTPSA id a3-20020a5ec303000000b006496b4dd21csm19835785iok.5.2022.04.11.07.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 07:04:25 -0700 (PDT)
From:   Nicholas Graumann <nick.graumann@gmail.com>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Kedareswara rao Appana <appanad@xilinx.com>
Cc:     Nicholas Graumann <nick.graumann@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dmaengine: xilinx_dma: Free descriptor lists in order
Date:   Mon, 11 Apr 2022 09:03:48 -0500
Message-Id: <20220411140348.30252-1-nick.graumann@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If xilinx_dma_terminate_all is called while the AXI DMA is active, the
following error messages might be seen upon restarting the DMA:

[   72.556254] xilinx_dma_irq_handler: Channel d053cb5b has errors 10, cdr 2c049f80 tdr 2c04a000
[   72.557370] xilinx_dma_irq_handler: Channel d053cb5b has errors 100, cdr 2c049f80 tdr 2c049f80

From then on the AXI DMA won't process any more descriptors until the
DMA channel is released and requested again.

The following sequence of events is what causes this to happen:

1. Some descriptors are prepared with xilinx_dma_tx_submit (so they get
   added to pending_list).
2. The DMA is kicked off via call to xilinx_dma_tx_submit (the
   descriptors are moved to active_list).
3. While the transfer is active, another descriptor is prepared with
   xilinx_dma_tx_submit (so it goes onto the pending_list)
4. Before the transfers complete, xilinx_dma_terminate_all is called.
   That function resets the channel then calls
   xilinx_dma_free_descriptors to free the descriptors.

At that point, pending_list contains a descriptor that is newer (and
thus farther down the chain of descriptors) than the descriptors
prepared in (1). However, it gets placed onto the free_seg_list before
the older descriptors. From then on, the next pointers are no longer
valid because the order of the descriptors in free_seg_list does not
match the order in which the descriptors were allocated.

To remedy this, the descriptor lists need to be freed in order from
oldest to newest, otherwise segments could be added to the free segment
list in a different order than they were created. This is not an issue
for VDMA nor CDMA because the driver does not maintain a list of
descriptors to free.

Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access Engine")
Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3ff9fa3d8cd5..3b435449cd0c 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -884,9 +884,13 @@ static void xilinx_dma_free_descriptors(struct xilinx_dma_chan *chan)
 
 	spin_lock_irqsave(&chan->lock, flags);
 
-	xilinx_dma_free_desc_list(chan, &chan->pending_list);
+	/*
+	 * Descriptor lists must be freed from oldest to newest so that the
+	 * order of free_seg_list is maintained.
+	 */
 	xilinx_dma_free_desc_list(chan, &chan->done_list);
 	xilinx_dma_free_desc_list(chan, &chan->active_list);
+	xilinx_dma_free_desc_list(chan, &chan->pending_list);
 
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
-- 
2.35.1

