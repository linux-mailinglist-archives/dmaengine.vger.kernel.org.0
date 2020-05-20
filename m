Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C171A1DAB2B
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2020 08:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgETG4z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 May 2020 02:56:55 -0400
Received: from v6.sk ([167.172.42.174]:59872 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgETG4y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 May 2020 02:56:54 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 37DF6610A8;
        Wed, 20 May 2020 06:56:23 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dmaengine: mmp_tdma: share the IRQ line
Date:   Wed, 20 May 2020 08:56:17 +0200
Message-Id: <20200520065617.2119028-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On a MMP2, the DMA interrupt is shared by all channels of the peripheral
DMA controller and the audio DMA controller. Both drivers can identify
their interrupts, but only the PDMA driver marks the line shared:

  [    1.185782] mmp-pdma d4000000.dma: initialized 16 channels
  [    1.186808] mmp-tdma d42a0800.adma: IRQ index 1 not found
  [    1.194317] genirq: Flags mismatch irq 64. 00000000 (tdma) vs. 00000080 (pdma)
  [    1.197894] mmp-tdma: probe of d42a0800.adma failed with error -16

Let's turn on IRQF_SHARED in the ADMA driver as well.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/mmp_tdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index dbc6a48424fa..960c7c40aef7 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -682,7 +682,7 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 	if (irq_num != chan_num) {
 		irq = platform_get_irq(pdev, 0);
 		ret = devm_request_irq(&pdev->dev, irq,
-			mmp_tdma_int_handler, 0, "tdma", tdev);
+			mmp_tdma_int_handler, IRQF_SHARED, "tdma", tdev);
 		if (ret)
 			return ret;
 	}
-- 
2.26.2

