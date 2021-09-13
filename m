Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B150940A0AE
	for <lists+dmaengine@lfdr.de>; Tue, 14 Sep 2021 00:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbhIMWlB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Sep 2021 18:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349307AbhIMWjF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Sep 2021 18:39:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6887661288;
        Mon, 13 Sep 2021 22:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631572539;
        bh=0imnu/QSbJlk6lBF4QOOnPSOOzd/NFLEAUPPiBEliOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdJeo7tiRAQVoGiB6cbU17TeOFyAcF4xpI9mWJZ6wu3cvGxz1x2XmSzqGV/IF/uS5
         P4EROL0brI+XWrDx3QEF3ozCx5NhU0mMp+XJFZKuHZIyH4Zxqd50oz7tPcwb2wwD9W
         VsQikXeydBxuanY5lp2O879MWTbNWQ/ieyQVf3MI4HSE1zln/scKBkP650M4MAKDa7
         nijqOB5o1oQLRSGn5rru3/MUrc6VGcWBNq9YkfRdsAo/YYDN2xCf5SD8jpbAivJ7fY
         fff4Rp6ycsXSbbw3nOCnSPTCtqLF96joCx+qSjtF6iHN7Q7AZKCcSi+gkUs6JaMekS
         4W/2cxSfTHcXQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 2/9] dmaengine: xilinx_dma: Set DMA mask for coherent APIs
Date:   Mon, 13 Sep 2021 18:35:28 -0400
Message-Id: <20210913223535.436405-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913223535.436405-1-sashal@kernel.org>
References: <20210913223535.436405-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

[ Upstream commit aac6c0f90799d66b8989be1e056408f33fd99fe6 ]

The xilinx dma driver uses the consistent allocations, so for correct
operation also set the DMA mask for coherent APIs. It fixes the below
kernel crash with dmatest client when DMA IP is configured with 64-bit
address width and linux is booted from high (>4GB) memory.

Call trace:
[  489.531257]  dma_alloc_from_pool+0x8c/0x1c0
[  489.535431]  dma_direct_alloc+0x284/0x330
[  489.539432]  dma_alloc_attrs+0x80/0xf0
[  489.543174]  dma_pool_alloc+0x160/0x2c0
[  489.547003]  xilinx_cdma_prep_memcpy+0xa4/0x180
[  489.551524]  dmatest_func+0x3cc/0x114c
[  489.555266]  kthread+0x124/0x130
[  489.558486]  ret_from_fork+0x10/0x3c
[  489.562051] ---[ end trace 248625b2d596a90a ]---

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Reviewed-by: Harini Katakam <harini.katakam@xilinx.com>
Link: https://lore.kernel.org/r/1629363528-30347-1-git-send-email-radhey.shyam.pandey@xilinx.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 21203e3a54fd..3c2084766a31 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2585,7 +2585,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		xdev->ext_addr = false;
 
 	/* Set the dma mask bits */
-	dma_set_mask(xdev->dev, DMA_BIT_MASK(addr_width));
+	dma_set_mask_and_coherent(xdev->dev, DMA_BIT_MASK(addr_width));
 
 	/* Initialize the DMA engine */
 	xdev->common.dev = &pdev->dev;
-- 
2.30.2

