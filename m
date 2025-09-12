Return-Path: <dmaengine+bounces-6489-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ACBB55294
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 17:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2252E3B7AE9
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84BF1DEFE9;
	Fri, 12 Sep 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="BrHK6BXK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73DA192D8A;
	Fri, 12 Sep 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689308; cv=none; b=Kop76HN20zoJquVkuWIIquiHTTW6w3PaJoUQtTi/juVmWvpJPZAUwhcZsekoxbqfuDitnZX4LgKBolLjf9tMpaPX5gyPFj/bdj0X4KvIfxeKGnHJDQbgPnW/0fBT0by7nTz6vF3YipquI1dK37Z+PDZ+dvNKcFwPQtvqTUAWNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689308; c=relaxed/simple;
	bh=fFmWwbLF1NYujbIy3EXx5QO/7xfiYsFX8VaGLaaO2R4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sZfjT5FB9+Z1BVWMNz80zGLS8zuwXAeNnDeITLFSDAD5kw8Quj5wZjXFLP4bwm3OLtDEAop2p0fnT3PJpny/XQaKHrMXIsPvodQPuVmZSc7VSjzfNe2agdBBEEa964yar0ev17AZCAco7Zpvskgnpm+fdD54VPIzBP9joAkNV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BrHK6BXK; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 22a119294;
	Fri, 12 Sep 2025 23:01:35 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] drivers/dma: replace dma_free_coherent with dma_free_wc
Date: Fri, 12 Sep 2025 15:01:32 +0000
Message-Id: <20250912150132.127135-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a993e72301f03a1kunme5a5fcbb2a1add
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGh5LVh5NTh0dGBpDSU1DSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSEpOQ0tVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BrHK6BXKYF2lHBwHVjPd3ZHU0tUdZbecCcL+lq9okGRJL2iC1nnXSTzUNeW5vYXqqemveCuikFuC14PquVNl9b0SEskTHJEIR7eytWZf7WexxQuvhwb+56zZdAC33JG17hocOQrM97qwyByyuF6MY3Lls1KIdWFdm35p7l/VayI=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=PR15YUH9Ayx9sbnffKLREV423yM3Lj/+PILzPjOJIgs=;
	h=date:mime-version:subject:message-id:from;

The memory for the DMA descriptor pool (dma_desc_pool_virt) is allocated
by dma_alloc_wc, but it is freed by dma_free_coherent in the error
handling path. This is incorrect as DMA allocation and free functions
should be paired.

Using mismatched functions may lead to undefined behavior, memory leaks,
or system instability.

The fix is to use dma_free_wc to match the allocation function.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/dma/mv_xor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 1fdcb0f5c9e7..58de208fc50d 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1163,7 +1163,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 err_free_irq:
 	free_irq(mv_chan->irq, mv_chan);
 err_free_dma:
-	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
+	dma_free_wc(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 err_unmap_dst:
 	dma_unmap_single(dma_dev->dev, mv_chan->dummy_dst_addr,
-- 
2.34.1


