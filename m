Return-Path: <dmaengine+bounces-2700-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 698AD931E57
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2024 03:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142E11F22CAB
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2024 01:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A94E4428;
	Tue, 16 Jul 2024 01:15:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63482139B;
	Tue, 16 Jul 2024 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092539; cv=none; b=kUI7bkJQkfpf2k4uKRAfpX3AaOr1dxlfpEJBke7DcKdAkR6b/IlJAJmIBqJO+BLb3Dw0NZg4Tb1Y5vn4Mc1YY0m1Z0xwIbRUS9Z7X8wB5W6T3ZJqEud4I4yl8IziDgHu7+Uziql64SOeh6VNO1lLcuwOrZ0MEEx5CUWkXDZZGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092539; c=relaxed/simple;
	bh=HfmL+jij8vewrcmj7SBDT+i8LR2xrxjrtVjSihG4aJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lgE50rNPAAjwvnm+xKkOmtzCR0oCRuuatG5RHOPJbeNrgdGkQAu73E6m9NqGTrR/+SmRvW/ntP1aQhGPru+L13cO5GmaBnQjWuO8BZ+5MhlGymEWBDHQ8wVuSUUA+egZz6yRiVhK5LWgu5vJyQQq/mpdFovcai2YyWzTH45K6ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADnuSGoyZVmnlaJAw--.49929S2;
	Tue, 16 Jul 2024 09:15:29 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] dmaengine: moxart: handle irq_of_parse_and_map() errors
Date: Tue, 16 Jul 2024 09:15:18 +0800
Message-Id: <20240716011518.3957126-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnuSGoyZVmnlaJAw--.49929S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWfuF17Kr4DCr4ktFy7Wrg_yoW3JFgEk3
	Z2gFWfZr1vqF1a9wn8Aw1SyFy0vF15uFs7uF90qwnIkFyUWFn09rWxZFn7Jr4UZFy0kry2
	yr9F9ryfuFW7CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5sqWUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Zero and negative number is not a valid IRQ for in-kernel code and the
irq_of_parse_and_map() function returns zero on error.  So this check for
valid IRQs should only accept values > 0.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/dma/moxart-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index c48d68cbff92..0690ccab431d 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -573,7 +573,7 @@ static int moxart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (!irq) {
+	if (irq <= 0) {
 		dev_err(dev, "no IRQ resource\n");
 		return -EINVAL;
 	}
-- 
2.25.1


