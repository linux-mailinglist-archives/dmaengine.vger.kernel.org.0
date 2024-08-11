Return-Path: <dmaengine+bounces-2839-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C0894DFDE
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 05:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8C7281B70
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 03:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE0DE541;
	Sun, 11 Aug 2024 03:44:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56CABA47;
	Sun, 11 Aug 2024 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723347863; cv=none; b=QG62rhUktqO0f5dtgIPUJC0EY7gF7of4MwSyAqQwAc+KdOZa98eamSw3htyVRniEyJuOaZbCGEafTvNDu0tqY6ZKZNkZWcfz/yLyHlZ8PIE8os/sZUVW19+N3iS/t29In+ClIHq0/XsVCGDZu7nh0/XX2RRjJHjvFjJS968D1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723347863; c=relaxed/simple;
	bh=yLmXaG/cKVhz7dTlSNAsmqnxExRJustnfBGAs+3vvSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pDXoMfxShehm6lAs6LMaZoO+v9K5QVDS+3BNFFfCRXa45uuEzh7vKg+M984bj8wZ8BJQbxJVJN/Fyl3yfgg9X3T7l8F+AgGyrn1NLC2Y9AxDaSZivBVQ0VMOC7mOlkhPuoL7TdvxedwyzzYULxP76XqMjdedhdl/ZrIQ1Z6q0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowABXXUl6M7hmxlZFBQ--.8961S2;
	Sun, 11 Aug 2024 11:44:04 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: vkoul@kernel.org,
	arnd@arndb.de,
	akpm@linux-foundation.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] dmaengine: moxart: handle irq_of_parse_and_map() errors
Date: Sun, 11 Aug 2024 11:43:53 +0800
Message-Id: <20240811034353.3481879-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXXUl6M7hmxlZFBQ--.8961S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWfuF17Kr4DCryUJw47urg_yoW3trgEk3
	WI9FWfZr1DJF1j9w1Yywn3AFy0yF1rWrn29Fn0q3sxCryUJF1avr4xZFn3Jr1DXry09ry2
	yrWDuryfua47CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUY3kuUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Zero and negative number is not a valid IRQ for in-kernel code and the
irq_of_parse_and_map() function returns zero on error.  So this check for
valid IRQs should only accept values > 0.

Cc: stable@vger.kernel.org
Fixes: 2d9e31b9412c ("dmaengine: moxart: remove NO_IRQ")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/dma/moxart-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 66dc6d31b603..16dd3c5aba4d 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -568,7 +568,7 @@ static int moxart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (!irq) {
+	if (irq <= 0) {
 		dev_err(dev, "no IRQ resource\n");
 		return -EINVAL;
 	}
-- 
2.25.1


