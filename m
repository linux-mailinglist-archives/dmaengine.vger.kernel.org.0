Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAD63FAE4B
	for <lists+dmaengine@lfdr.de>; Sun, 29 Aug 2021 21:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhH2T72 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Aug 2021 15:59:28 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57111 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhH2T72 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Aug 2021 15:59:28 -0400
Received: (Authenticated sender: contact@artur-rojek.eu)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 184E620006;
        Sun, 29 Aug 2021 19:58:32 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH] dmaengine: jz4780: Set max number of SGs per burst
Date:   Sun, 29 Aug 2021 21:58:05 +0200
Message-Id: <20210829195805.148964-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Total amount of SG list entries executed in a single burst is limited by
the number of available DMA descriptors.
This information is useful for device drivers utilizing this DMA engine.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/dma/dma-jz4780.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index ebee94dbd630..96701dedcac8 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -915,6 +915,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	dd->dst_addr_widths = JZ_DMA_BUSWIDTHS;
 	dd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	dd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	dd->max_sg_burst = JZ_DMA_MAX_DESC;
 
 	/*
 	 * Enable DMA controller, mark all channels as not programmable.
-- 
2.33.0

