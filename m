Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B83C1DAB29
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2020 08:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgETG4c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 May 2020 02:56:32 -0400
Received: from v6.sk ([167.172.42.174]:59870 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgETG4c (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 May 2020 02:56:32 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id F17D161300;
        Wed, 20 May 2020 06:56:29 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dmaengine: mmp_pdma: Do not warn when IRQ is shared by all chans
Date:   Wed, 20 May 2020 08:56:26 +0200
Message-Id: <20200520065626.2119120-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When there's a single interrupt for all the DMA channels, the
unsuccessful attempt to request separate IRQs emits useless warnings:

  [    1.370381] mmp-pdma d4000000.dma: IRQ index 1 not found
  ...
  [    1.412398] mmp-pdma d4000000.dma: IRQ index 15 not found
  [    1.418308] mmp-pdma d4000000.dma: initialized 16 channels

Avoid that, treating the IRQs as optional.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/mmp_pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index ad06f260e907..41c542eaa23a 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1060,7 +1060,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 	pdev->dma_channels = dma_channels;
 
 	for (i = 0; i < dma_channels; i++) {
-		if (platform_get_irq(op, i) > 0)
+		if (platform_get_irq_optional(op, i) > 0)
 			irq_num++;
 	}
 
-- 
2.26.2

