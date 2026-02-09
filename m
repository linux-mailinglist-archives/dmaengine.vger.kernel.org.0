Return-Path: <dmaengine+bounces-8820-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id u/2yNNtOiWmb6QQAu9opvQ
	(envelope-from <dmaengine+bounces-8820-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 04:04:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3985510B4A7
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 04:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E699300567C
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 03:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0672EAB83;
	Mon,  9 Feb 2026 03:04:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E345E2EA169;
	Mon,  9 Feb 2026 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606296; cv=none; b=hcnAoyKpKBFlTvLrFoHBZtNBFWmm9gZhOvIDWapCSCuxdCZFIFprfk78qAM9wcGos1YGrHKwA6V40JaOwWCE095Eu0yMxaU5xicc6kkSTlZQxXuQt1Y+qs0q8kVKP7/hBQWmtLXEP8rFrabJWpnHtKWp+T3FrofOMmbXWuRuVmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606296; c=relaxed/simple;
	bh=oiqBC0fKRtBmtjrlzdY83eKsHkD/An3cOay/EVy9gPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XT8uOQydA+dZkIBG48tPayWRdrSBb2+uZtNvfAu7WYtQCBBYcIrQ/it5NzZMpd1UlnCNFVCX6PlManBhVhGSNIwqTOK84jhNIhJhm6SpfkXUP0SXE4lgP7ZLKj1ZDxUIkgAYhpIv2aUOEaTEQZQ+PlCoikIg9OUujR7ORATGOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8AxDMPOTolpA_kQAA--.54559S3;
	Mon, 09 Feb 2026 11:04:46 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJBxKMHHTolpRO1CAA--.46046S4;
	Mon, 09 Feb 2026 11:04:46 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Xiaochuang Mao <maoxiaochuan@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org,
	jeffbai@aosc.io,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 2/4] dmaengine: loongson: loongson2-apb: Convert to dmaenginem_async_device_register()
Date: Mon,  9 Feb 2026 11:04:19 +0800
Message-ID: <3e48916fed24d995cd558b4df3841d2fa5189a27.1770605931.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770605931.git.zhoubinbin@loongson.cn>
References: <cover.1770605931.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKMHHTolpRO1CAA--.46046S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQENCGmIJbsGoQAAsd
X-Coremail-Antispam: 1Uk129KBj93XoW7tr4UCrWrWryrJFWkGFWkXwc_yoW8Wr1kpa
	4fGa4fGrW0qF429an8JrWUZFy2kFy3XayxZa1xJw1UC3sxJ34vgF18ZF9rXF4DArW8CayS
	qa4vkayruF47GrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jzc_-UUUUU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-8820-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com,aosc.io];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.860];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3985510B4A7
X-Rspamd-Action: no action

Use new dmaenginem_async_device_register() helper to simplify the code.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/dma/loongson/loongson2-apb-dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
index 0cb607595d04..5e9a13ad9aa2 100644
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


