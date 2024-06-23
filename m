Return-Path: <dmaengine+bounces-2506-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3472C9138FA
	for <lists+dmaengine@lfdr.de>; Sun, 23 Jun 2024 10:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D931F1F21A1E
	for <lists+dmaengine@lfdr.de>; Sun, 23 Jun 2024 08:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67312E7C;
	Sun, 23 Jun 2024 08:17:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD72030B;
	Sun, 23 Jun 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719130624; cv=none; b=JkUpE8crz3HxbmG2LnH32fY3jGQptLe0x6HkA313FbfPhlRpSNSMX7XUJIygec31Wj2dDCU8gvVhC6Xm2+QkMAK4+2qTRlsYHEZIHX97FtlUX3/iEeMAqD7jfcXzYVqjgMKRb1zjbGnb4R0AYUc3vEMbBjXlp4WghlGA08FK3Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719130624; c=relaxed/simple;
	bh=f9uKGh9XaoDO7/wNKoqyEKZNvkDja4CrhL5Z9VskeM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rwASWgTZ+MaZb5XUvJ4eiIkNI8SxAVKwWbJHvEi0CpkAOqLEvx3O+eOnw8dwVbETtM0xxqFdHlzAC5ghJxxn9r3ko3xN/pkMQDmFF4pgKUwXhhF0vw2uoY2gd8IIiRRBQwp7lDYzSUYp97XqtV8oL1WJywpUB0HCxcqlzUJ18Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowABHTpru2XdmbDz5EQ--.47109S2;
	Sun, 23 Jun 2024 16:16:55 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: lars@metafoo.de,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] dmaengine: axi-dmac: Add check for dma_set_max_seg_size
Date: Sun, 23 Jun 2024 16:16:44 +0800
Message-Id: <20240623081644.2089695-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHTpru2XdmbDz5EQ--.47109S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4rKw47WrWrtw4kCF1rJFb_yoW3uwcEkr
	17uryfXr1qgw4xKwn8Kr1avrZFvryDZr4jqFn7K34Syr1UGFn8K39rZFZ5XF45ZayxGFW0
	krnrXrWrtF4fXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5sqWUU
	UUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

To avoid possible failure of the dma_set_max_seg_size(), we should
better check the return value of the dma_set_max_seg_size().

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/dma/dma-axi-dmac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index bdb752f11869..93543c2f1bd7 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -1051,7 +1051,9 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&dmac->chan.active_descs);
 
-	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
+	ret = dma_set_max_seg_size(&pdev->dev, UINT_MAX);
+	if (ret)
+		return ret;
 
 	dma_dev = &dmac->dma_dev;
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
-- 
2.25.1


