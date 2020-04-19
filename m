Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C259E1AFC29
	for <lists+dmaengine@lfdr.de>; Sun, 19 Apr 2020 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgDSQtd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Apr 2020 12:49:33 -0400
Received: from v6.sk ([167.172.42.174]:43706 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgDSQtc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 19 Apr 2020 12:49:32 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 498B2610AD;
        Sun, 19 Apr 2020 16:49:31 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 6/7] dmaengine: mmp_tdma: Fill in slave capabilities
Date:   Sun, 19 Apr 2020 18:49:11 +0200
Message-Id: <20200419164912.670973-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419164912.670973-1-lkundrak@v3.sk>
References: <20200419164912.670973-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This makes dma_get_slave_caps() work with the device so that it could
actually be used with soc-generic-dmaengine-pcm.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/mmp_tdma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 191640f26246d..38f2298879881 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -725,6 +725,17 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 	tdev->device.device_terminate_all = mmp_tdma_terminate_all;
 	tdev->device.copy_align = DMAENGINE_ALIGN_8_BYTES;
 
+	tdev->device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	if (type == MMP_AUD_TDMA) {
+		tdev->device.max_burst = SZ_128;
+		tdev->device.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+		tdev->device.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	} else if (type == PXA910_SQU) {
+		tdev->device.max_burst = SZ_32;
+	}
+	tdev->device.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	tdev->device.descriptor_reuse = true;
+
 	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 	platform_set_drvdata(pdev, tdev);
 
-- 
2.26.0

