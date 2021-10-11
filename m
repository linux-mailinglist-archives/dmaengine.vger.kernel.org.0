Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E05429231
	for <lists+dmaengine@lfdr.de>; Mon, 11 Oct 2021 16:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbhJKOlD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 10:41:03 -0400
Received: from aposti.net ([89.234.176.197]:46660 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243614AbhJKOjx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Oct 2021 10:39:53 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/5] dmaengine: jz4780: Work around hardware bug on JZ4760 SoCs
Date:   Mon, 11 Oct 2021 16:36:50 +0200
Message-Id: <20211011143652.51976-4-paul@crapouillou.net>
In-Reply-To: <20211011143652.51976-1-paul@crapouillou.net>
References: <20211011143652.51976-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The JZ4760 SoC has a hardware problem with chan0 not enabling properly
if it's enabled before chan1, after a reset (works fine afterwards).
This is worked around in the probe function by just enabling then
disabling chan1.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index ebee94dbd630..d71bc7235959 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -937,6 +937,14 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		jzchan->vchan.desc_free = jz4780_dma_desc_free;
 	}
 
+	/*
+	 * On JZ4760, chan0 won't enable properly the first time.
+	 * Enabling then disabling chan1 will magically make chan0 work
+	 * correctly.
+	 */
+	jz4780_dma_chan_enable(jzdma, 1);
+	jz4780_dma_chan_disable(jzdma, 1);
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		goto err_disable_clk;
-- 
2.33.0

