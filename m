Return-Path: <dmaengine+bounces-2771-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D089456BA
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 05:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F3C1C23CC9
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 03:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD0917BB7;
	Fri,  2 Aug 2024 03:46:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76098256D;
	Fri,  2 Aug 2024 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722570366; cv=none; b=E3RMeBw0fT6J5EXYPY1OUElFinLZt/cHzOytGYocOowG6JdL/ZaRwrYM5wlL8y3dq6Bxqvl+FJ1qW3eQjqjYl40YlMdWhGZkKHgLWtaMdMnZe3FiOKIWfeTaeht+6EIuLFzZLwcXHwsyjJQs/xsJpA290xaGWRT0EZ9SVE97Bp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722570366; c=relaxed/simple;
	bh=HqMyy66LHQV6gSj10sZaDnxWJrqtK+uKA3sR+t8lYVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WRpUxSKv3DPCi41+3RuqVWNeIZWzVv2Emq1XhpaIm/21wUzpFi9LnS03ySz74u/IakXdFiaCpymCpVlkYUqqgevhtwPMNrkA1a3ttENwOSYHBSpmhCP9Ms8E9FSvt43aBrRNK/xwZ04wUK29+ySPCl/+UhmMzAFSs9QpPp2ovZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowACnzQBvVqxmQiLqAg--.51161S2;
	Fri, 02 Aug 2024 11:45:59 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: vkoul@kernel.org,
	arnd@arndb.de
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] dmaengine: moxart: handle irq_of_parse_and_map() errors
Date: Fri,  2 Aug 2024 11:45:49 +0800
Message-Id: <20240802034549.1561123-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnzQBvVqxmQiLqAg--.51161S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWfuF17Kr4DCryUJw47urg_yoWfWrgEk3
	WI9FWfZr1DJF1j9w15AwsavFy0kF1rWrsa9Fn0q3sIkryUJF1avrWxZFn3JryDWF1v9rW2
	kryq9ryfuFW7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUvAp5UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Zero and negative number is not a valid IRQ for in-kernel code and the
irq_of_parse_and_map() function returns zero on error.  So this check for
valid IRQs should only accept values > 0.

Cc: stable@vger.kernel.org
Fixes: 2d9e31b9412c ("dmaengine: moxart: remove NO_IRQ")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- added Cc stable line;
- added Fixes line.
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


