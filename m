Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE28535032
	for <lists+dmaengine@lfdr.de>; Thu, 26 May 2022 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiEZNvc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 May 2022 09:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiEZNva (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 May 2022 09:51:30 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC8B1D0F1;
        Thu, 26 May 2022 06:51:26 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 242DA2223B;
        Thu, 26 May 2022 15:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653573084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hDfeXGLxT1ATlD4gcVOQndFKZO4YnK6PdKkSbYlL/Og=;
        b=CCpFv7RWHTo3w7QRPFcEETAptNX4XXn7LP2Vu8rfu01uYdu+SbF2G44dTPWil5zt1+P0lM
        Upbf3ZQ3XdvLaAwwBIt60PDyyBv+SuauAv5aKWY1Guk2i5HM43gj+8PnMNtWmGTQcGKfHa
        axdBgMTsDObYND+xqaIMgYxfSX1Fpts=
From:   Michael Walle <michael@walle.cc>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] dmaengine: at_xdma: handle errors of at_xdmac_alloc_desc() correctly
Date:   Thu, 26 May 2022 15:51:11 +0200
Message-Id: <20220526135111.1470926-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It seems that it is valid to have less than the requested number of
descriptors. But what is not valid and leads to subsequent errors is to
have zero descriptors. In that case, abort the probing.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Michael Walle <michael@walle.cc>
---
This was noticed with the atmel i2c driver:

[    2.488878] cma: cma_alloc: reserved: alloc failed, req-size: 1 pages, ret: -16
[    2.488934] dma dma0chan0: only 0 descriptors have been allocated
[    2.558378] cma: cma_alloc: reserved: alloc failed, req-size: 1 pages, ret: -16
[    2.558428] dma dma0chan1: only 0 descriptors have been allocated
[    2.558509] at91_i2c e0070600.i2c: using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
[    2.558906] at91_i2c e0070600.i2c: AT91 i2c bus driver (hw version: 0x820).
..
[    7.393971] ------------[ cut here ]------------
[    7.393998] WARNING: CPU: 0 PID: 48 at arch/arm/mm/dma-mapping.c:492 pool_allocator_alloc+0xa0/0xa4
[    7.404940] coherent pool not initialised!
[    7.409018] Modules linked in:
[    7.412060] CPU: 0 PID: 48 Comm: kworker/0:6 Not tainted 5.18.0-next-20220526+ #639
[    7.419694] Hardware name: Generic DT based system
[    7.424472] Workqueue: events_power_efficient sfp_timeout
..
[    7.755103] dma dma0chan1: can't get descriptor
[    7.755239] at91_i2c e0070600.i2c: dma prep slave sg failed
[    8.133324] at91_i2c e0070600.i2c: controller timed out

Please note that this doesn't fix the underlying problem. It will just
handle that one gracefully.

 drivers/dma/at_xdmac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 3e9d726504e2..7b3e6030f7b4 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1900,6 +1900,11 @@ static int at_xdmac_alloc_chan_resources(struct dma_chan *chan)
 	for (i = 0; i < init_nr_desc_per_channel; i++) {
 		desc = at_xdmac_alloc_desc(chan, GFP_KERNEL);
 		if (!desc) {
+			if (i == 0) {
+				dev_warn(chan2dev(chan),
+					 "can't allocate any descriptors\n");
+				return -EIO;
+			}
 			dev_warn(chan2dev(chan),
 				"only %d descriptors have been allocated\n", i);
 			break;
-- 
2.30.2

