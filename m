Return-Path: <dmaengine+bounces-9045-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM8hK5mnnmmrWgQAu9opvQ
	(envelope-from <dmaengine+bounces-9045-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 08:41:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F11939D5
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 08:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03A243014687
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 07:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C7B3016E5;
	Wed, 25 Feb 2026 07:41:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3F2FFF81;
	Wed, 25 Feb 2026 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772005269; cv=none; b=agGz1jLQD2VchGYxMC0dFbIuKd8+FQtUuyoWp5RTpAx+NyeSoN0802GYdaHvZ3AI4MDcvoX6cPGOwHqsXAf0izRgclkywsD/zH9cekqv5H7fEFKeyaEZdxY36ISAlSA8AR01r6NFVr9BBgfMXBtpISynE+l1MlCcpvU2LU06VEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772005269; c=relaxed/simple;
	bh=+zavlZAcI3vqcaccCnPJtVeS9jrVg0d/AQOQW8OdM8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VE05fZyv1Kan+TsTastNeOCKdNw7mEKEyunkhq4kDkAP0a6djEFZmSp0OIO5qN3x+Yxv+ko1GSpZ3RHeqzLGA7nsasfvmucql9v9lSZ0ew7pd98WrOqEv4d5HwKlcT7z/MGYuv3E3ekm3xW7UTvohSVwIdE6LU18nnvQhL77g6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.227])
	by gateway (Coremail) with SMTP id _____8CxIMCQp55p6P0UAA--.5161S3;
	Wed, 25 Feb 2026 15:41:04 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.227])
	by front1 (Coremail) with SMTP id qMiowJCxGOCIp55pFMRKAA--.9627S4;
	Wed, 25 Feb 2026 15:41:03 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 2/6] dmaengine: loongson: loongson2-apb: Convert to dmaenginem_async_device_register()
Date: Wed, 25 Feb 2026 15:40:40 +0800
Message-ID: <ff40ab8f25bac37cd4528f5189f55d86d6d9717c.1771989596.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771989595.git.zhoubinbin@loongson.cn>
References: <cover.1771989595.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxGOCIp55pFMRKAA--.9627S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEJCGmejz8BjwAAsI
X-Coremail-Antispam: 1Uk129KBj93XoW7WF4xZw4xKw1xKr43uw4rWFX_yoW8WFy5pa
	s3Ca4fGrW0qF429ws8JrWUZFy3KFy3XayxZay7Jw1UC3sxJ340gF18JFyxXF4UArW8Kaya
	qa4vkayruF4UCrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6VbgUUUUU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9045-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com,loongson.cn,nxp.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 278F11939D5
X-Rspamd-Action: no action

Use the dmaenginem_async_device_register() helper function to simplify
the probe routine.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/dma/loongson/loongson2-apb-dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
index fc7d9f4a96ec..2d16842e1658 100644
--- a/drivers/dma/loongson/loongson2-apb-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-dma.c
@@ -650,21 +650,19 @@ static int ls2x_dma_probe(struct platform_device *pdev)
 	ddev->dst_addr_widths = LDMA_SLAVE_BUSWIDTHS;
 	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 
-	ret = dma_async_device_register(&priv->ddev);
+	ret = dmaenginem_async_device_register(&priv->ddev);
 	if (ret < 0)
 		goto disable_clk;
 
 	ret = of_dma_controller_register(dev->of_node, of_dma_xlate_by_chan_id, priv);
 	if (ret < 0)
-		goto unregister_dmac;
+		goto disable_clk;
 
 	platform_set_drvdata(pdev, priv);
 
 	dev_info(dev, "Loongson LS2X APB DMA driver registered successfully.\n");
 	return 0;
 
-unregister_dmac:
-	dma_async_device_unregister(&priv->ddev);
 disable_clk:
 	clk_disable_unprepare(priv->dma_clk);
 
@@ -680,7 +678,6 @@ static void ls2x_dma_remove(struct platform_device *pdev)
 	struct ls2x_dma_priv *priv = platform_get_drvdata(pdev);
 
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&priv->ddev);
 	clk_disable_unprepare(priv->dma_clk);
 }
 
-- 
2.52.0


