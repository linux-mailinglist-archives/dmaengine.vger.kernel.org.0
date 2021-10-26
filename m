Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8834343B634
	for <lists+dmaengine@lfdr.de>; Tue, 26 Oct 2021 17:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhJZP6j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Oct 2021 11:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbhJZP6g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Oct 2021 11:58:36 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF464C061745
        for <dmaengine@vger.kernel.org>; Tue, 26 Oct 2021 08:56:11 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:441:6c1a:bc30:46e])
        by baptiste.telenet-ops.be with bizsmtp
        id AfwA260072hfXWm01fwAAi; Tue, 26 Oct 2021 17:56:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfOo5-0085p9-S4; Tue, 26 Oct 2021 17:56:09 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfOo5-00DVNG-1f; Tue, 26 Oct 2021 17:56:09 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dmaengine: dw-axi-dmac: Simplify assignment in dma_chan_pause()
Date:   Tue, 26 Oct 2021 17:56:07 +0200
Message-Id: <2abd0da35608c14689a919d47dd45898a8ab4297.1635263478.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Simplify assigning zero and performing a logical OR to a single
assignment.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index e8c98b16ae991a59..b907f3acf5c1f31e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1191,9 +1191,8 @@ static int dma_chan_pause(struct dma_chan *dchan)
 			BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT;
 		axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
 	} else {
-		val = 0;
-		val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
-			BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
+		val = BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
+		      BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
 		axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, val);
 	}
 
-- 
2.25.1

