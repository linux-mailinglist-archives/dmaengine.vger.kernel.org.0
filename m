Return-Path: <dmaengine+bounces-2724-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11674938F30
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2024 14:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A43B21067
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2024 12:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD616C86D;
	Mon, 22 Jul 2024 12:41:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756A322E;
	Mon, 22 Jul 2024 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652062; cv=none; b=KyyWLBOl/w5xSyG9gzfO6y8IOihEglwfUMSjPn5bvu1w6r6edFgOI6svkOVwKoxPWa9Dfm0vE/usmJTZ7Ast7O1/kXeaqUvl5zcxQQydV3XKrq1IrTObDptsBmpVvLZ4JSqrs6GY6iVstpRwk+FIxvuM7DCURrrD2TjVSqd50hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652062; c=relaxed/simple;
	bh=7PQyttfz5mKhOZY5laP84us7YF+vOdgYrC9DgUrA1/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T0mixE49DphNkvaOEqO4n5c0l8vSo5nQmaOowrMG0nfOYu3tfM8Z5VeaqEIgHakDp2HTtUEOcZNHXqtJS+kmrwrOnnLk7znuUGSY8TAvyXzSmXykWexO5fH3WSOkt2ozqIQXLG97++kcBzN5Wt9pVpWMRlJjSn07z5jPl0050eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAD34MFPU55mgdxhAA--.23388S2;
	Mon, 22 Jul 2024 20:40:55 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: vkoul@kernel.org,
	arnd@arndb.de
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] dmaengine: moxart: handle irq_of_parse_and_map() errors
Date: Mon, 22 Jul 2024 20:40:45 +0800
Message-Id: <20240722124045.372902-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD34MFPU55mgdxhAA--.23388S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWfuF17Kr4DCryUJw47urg_yoWfWrgEg3
	WIgFWfur1DtF1j9w15AwsayFy0vF1UWFs29F1qq34akry5Jr1Y9rWxZFs3Jr1DuFyvkry2
	kryq9ryfuFW7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUYSoXUUUUU
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


