Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9547692D8
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 12:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjGaKOu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjGaKOt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 06:14:49 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27BEE5A;
        Mon, 31 Jul 2023 03:14:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06CCB1BF20C;
        Mon, 31 Jul 2023 10:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690798487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pk8udpJ2M7pKGiqvni22vLIqee3xOn8qP+AR1XeBzeg=;
        b=nhgtgOEAp2Ka9sIunlLyncFOSrqdEp9ZMLYSt7wd6EiMI84MRkrp5DfZOvkns1YGCxUwZp
        WRlaag9tAhod7M/EJRl24LvM3nD5GLq1tWOPcVtUu7j1Hl4BirzBA5QfP+bPXtvCXQA7Jr
        Cp0T/MLh5Qg+JSkndDoyooebc0/bm/noEpZEguG6H+j8KuHGB1h3ELxxDtjUqm7PaOZcOQ
        MjUqO3Ic6J2c8mBIJBnojGdMX4TBmuq9nHh5SGk2M44obnaPUwpu/ZFVJIYfYsJ2xvkLBe
        NEjp3OCB8UewtZ8cZzqXuorOhZaL4hZeMC7Rc3F/AhtB3ra979ZwhUyW8IDhlg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/4] dmaengine: xilinx: xdma: Fix interrupt vector setting
Date:   Mon, 31 Jul 2023 12:14:39 +0200
Message-Id: <20230731101442.792514-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731101442.792514-1-miquel.raynal@bootlin.com>
References: <20230731101442.792514-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

A couple of hardware registers need to be set to reflect which
interrupts have been allocated to the device. Each register is 32-bit
wide and can receive four 8-bit values. If we provide any other interrupt
number than four, the irq_num variable will never be 0 within the while
check and the while block will loop forever.

There is an easy way to prevent this: just break the for loop
when we reach "irq_num == 0", which anyway means all interrupts have
been processed.

Cc: stable@vger.kernel.org
Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/xilinx/xdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 93ee298d52b8..359123526dd0 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -668,6 +668,8 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
 			val |= irq_start << shift;
 			irq_start++;
 			irq_num--;
+			if (!irq_num)
+				break;
 		}
 
 		/* write IRQ register */
-- 
2.34.1

