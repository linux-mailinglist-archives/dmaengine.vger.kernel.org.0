Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BB82C43F8
	for <lists+dmaengine@lfdr.de>; Wed, 25 Nov 2020 16:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbgKYPjb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Nov 2020 10:39:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731286AbgKYPiE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Nov 2020 10:38:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828B92220B;
        Wed, 25 Nov 2020 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606318683;
        bh=tYfM9353ynPnCSgC24c73sUw9VqoNZX7YeATcD4fYK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPei4biwCKpjQSRlAl/gM2pozl894Hq9Vc/6ygne6cSkyj0HojSRvb6Qg5Z3olo4+
         swKg1RrKhRKfMSesV/s4ndhTVKDtbmxXr+Hy1oOSEhrdOnqDIih8HDusTndV+24PMx
         4ohAiM67kxs36+uke9BUFFlr202Pmmz2rgiRTVzM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sugar Zhang <sugar.zhang@rock-chips.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/10] dmaengine: pl330: _prep_dma_memcpy: Fix wrong burst size
Date:   Wed, 25 Nov 2020 10:37:50 -0500
Message-Id: <20201125153753.810973-7-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201125153753.810973-1-sashal@kernel.org>
References: <20201125153753.810973-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sugar Zhang <sugar.zhang@rock-chips.com>

[ Upstream commit e773ca7da8beeca7f17fe4c9d1284a2b66839cc1 ]

Actually, burst size is equal to '1 << desc->rqcfg.brst_size'.
we should use burst size, not desc->rqcfg.brst_size.

dma memcpy performance on Rockchip RV1126
@ 1512MHz A7, 1056MHz LPDDR3, 200MHz DMA:

dmatest:

/# echo dma0chan0 > /sys/module/dmatest/parameters/channel
/# echo 4194304 > /sys/module/dmatest/parameters/test_buf_size
/# echo 8 > /sys/module/dmatest/parameters/iterations
/# echo y > /sys/module/dmatest/parameters/norandom
/# echo y > /sys/module/dmatest/parameters/verbose
/# echo 1 > /sys/module/dmatest/parameters/run

dmatest: dma0chan0-copy0: result #1: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
dmatest: dma0chan0-copy0: result #2: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
dmatest: dma0chan0-copy0: result #3: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
dmatest: dma0chan0-copy0: result #4: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
dmatest: dma0chan0-copy0: result #5: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
dmatest: dma0chan0-copy0: result #6: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
dmatest: dma0chan0-copy0: result #7: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
dmatest: dma0chan0-copy0: result #8: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000

Before:

  dmatest: dma0chan0-copy0: summary 8 tests, 0 failures 48 iops 200338 KB/s (0)

After this patch:

  dmatest: dma0chan0-copy0: summary 8 tests, 0 failures 179 iops 734873 KB/s (0)

After this patch and increase dma clk to 400MHz:

  dmatest: dma0chan0-copy0: summary 8 tests, 0 failures 259 iops 1062929 KB/s (0)

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Link: https://lore.kernel.org/r/1605326106-55681-1-git-send-email-sugar.zhang@rock-chips.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 16c08846ea0e1..f5a9bb1231882 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2682,7 +2682,7 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	 * If burst size is smaller than bus width then make sure we only
 	 * transfer one at a time to avoid a burst stradling an MFIFO entry.
 	 */
-	if (desc->rqcfg.brst_size * 8 < pl330->pcfg.data_bus_width)
+	if (burst * 8 < pl330->pcfg.data_bus_width)
 		desc->rqcfg.brst_len = 1;
 
 	desc->bytes_requested = len;
-- 
2.27.0

