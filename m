Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D157FA32F
	for <lists+dmaengine@lfdr.de>; Wed, 13 Nov 2019 03:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfKMB76 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 20:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbfKMB75 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Nov 2019 20:59:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0ED4222CF;
        Wed, 13 Nov 2019 01:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610396;
        bh=S42pxMw6/wYTxvLBzsja1ndTqzGbyWY3pPEbYY4F1S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqvpvX4LVU8BZeGVfoSnFpMjTywlm0qAAktL2OBFj1GOPLkOWy6C1S20igHzfwouh
         bMWSyoaXAzPJelPvXEChAlAHtAvC5kNDMM4qZANxWFtxHinD4TmJZmI9mdzdVwmvfE
         th5pEdBlim5zNeMHe/ABFhXwBAn+KmTXfrwDl1cs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.9 15/68] dmaengine: timb_dma: Use proper enum in td_prep_slave_sg
Date:   Tue, 12 Nov 2019 20:58:39 -0500
Message-Id: <20191113015932.12655-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 5e621f5d538985f010035c6f3e28c22829d36db1 ]

Clang warns when implicitly converting from one enumerated type to
another. Avoid this by using the equivalent value from the expected
type.

drivers/dma/timb_dma.c:548:27: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
                td_desc->desc_list_len, DMA_MEM_TO_DEV);
                                        ^~~~~~~~~~~~~~
1 warning generated.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/timb_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 896bafb7a5324..cf6588cc3efdc 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -545,7 +545,7 @@ static struct dma_async_tx_descriptor *td_prep_slave_sg(struct dma_chan *chan,
 	}
 
 	dma_sync_single_for_device(chan2dmadev(chan), td_desc->txd.phys,
-		td_desc->desc_list_len, DMA_MEM_TO_DEV);
+		td_desc->desc_list_len, DMA_TO_DEVICE);
 
 	return &td_desc->txd;
 }
-- 
2.20.1

