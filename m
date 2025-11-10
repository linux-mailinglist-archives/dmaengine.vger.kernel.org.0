Return-Path: <dmaengine+bounces-7102-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14CEC45735
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 09:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048A43AB770
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9F52FD7B1;
	Mon, 10 Nov 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="SEsYRy3t"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21E248891;
	Mon, 10 Nov 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764732; cv=none; b=KHLCLv3K5bMM57Zh+gQq18am2rG/cjk7O5pg0vLYSEsH76O3Aacs4yj95L6oXiq8dsewv9S/AAfpvcfz47tmcOX3Xpn+FgEq31ktay4+yqjEyS+Hd9uFN32LV2+AmZWrsWHZgj17aBlfMBaKUxy+/Va5W0wk/yv91pKKNtmAwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764732; c=relaxed/simple;
	bh=K+XaybmtfpqHcjKaCkJr8J+VLm4wYXeR6iV5x1IR+HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X/Gvpx6YIRYNmTq1iqTpmk8Af5g8+xw28q4qcOOolcU8itvcUWoV4OLiEOKyvusHvrf590Aj6oYqelkCUpIlICp/h3ewovMMHf4AtkOPva1I0b2BPsDsNXdfbCXeG8N9L+ml01zBnGa4YDGu0pckRUqnrWvVxhdtMttAlAdXd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=SEsYRy3t; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29056feac;
	Mon, 10 Nov 2025 16:52:01 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: keguang.zhang@gmail.com
Cc: vkoul@kernel.org,
	linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] dmaengine: Loongson1: Fix memory leak in ls1x_dma_prep_dma_cyclic()
Date: Mon, 10 Nov 2025 08:51:59 +0000
Message-Id: <20251110085159.754528-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a6cf70cca03a1kunm6f9f71c9a59337
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkNCVhlOGRhITEhPT0lLTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SEsYRy3t70QomWfnKUNX5YgGVIArj7EpAQYHNlAYLTj1Io55hjZYFyRRHCw3arKl81YBcSDxEmgUteCqvuawSlBur7Ji5HoEj3dBs7q8T8qCpHsIEaMmSu1FWjXc7f0ZVF4d467rQdyDZGAvMssDqyl1Mfh1q4T93tvbEO6dc3o=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=diZNDUepMPp6k3NXFNNQrzxv9BkBiMSl8tvoJAuqeyo=;
	h=date:mime-version:subject:message-id:from;

In ls1x_dma_prep_dma_cyclic(), a descriptor is allocated with
ls1x_dma_alloc_desc(). If the subsequent allocation for the scatterlist
fails, the function returns NULL without freeing the descriptor, which
causes a memory leak.

Fix this by calling ls1x_dma_free_desc() in the error path to ensure
the descriptor is freed.

Fixes: e06c432312148 ("dmaengine: Loongson1: Add Loongson-1 APB DMA driver")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/dma/loongson1-apb-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson1-apb-dma.c
index 255fe7eca212..5ee829bc5c77 100644
--- a/drivers/dma/loongson1-apb-dma.c
+++ b/drivers/dma/loongson1-apb-dma.c
@@ -336,8 +336,10 @@ ls1x_dma_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t buf_addr,
 	/* allocate the scatterlist */
 	sg_len = buf_len / period_len;
 	sgl = kmalloc_array(sg_len, sizeof(*sgl), GFP_NOWAIT);
-	if (!sgl)
+	if (!sgl) {
+		ls1x_dma_free_desc(&desc->vd);
 		return NULL;
+	}
 
 	sg_init_table(sgl, sg_len);
 	for (i = 0; i < sg_len; ++i) {
-- 
2.34.1


