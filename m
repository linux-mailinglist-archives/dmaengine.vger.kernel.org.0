Return-Path: <dmaengine+bounces-3626-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BB29B2B98
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 10:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5AB281F4D
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029CD18800D;
	Mon, 28 Oct 2024 09:34:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7807317DFF2
	for <dmaengine@vger.kernel.org>; Mon, 28 Oct 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108072; cv=none; b=sRtv4m6UlpMGu9qAC9mfPYKT2Cr0zR8mfEK4pReAbImo0xE1L/II4Bjs0/TqhwLDAiysmf0M6ApY+ARyvj767pV4MKcOi2wIBwaREVO3HRqAoM8AUcdVRqNY65LDWQyqrhe46c5+fkziQEHY/MO/KtdT0xckgG5SE+aUq0Ts1Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108072; c=relaxed/simple;
	bh=Z3vqjb/orKw8R4teFes9y7ATp36S3tsG7USNV57/Zuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fjvFESaH5/JGc4JCrm8EK6vao95hSxMuvuOW863eX6RNZhMeQJBe+PYt8m1zVTWcYlqNPWoT5e8G79+vNl6IocYKEmgGEAPWiZX0w6Sr7fr83yKMiZhYL+k+BX0huuKPyKVMKU8nYp4gxn224rqKb78zntaMearpNmgV9pAchzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.202])
	by gateway (Coremail) with SMTP id _____8Dx2uGiWh9n260YAA--.52053S3;
	Mon, 28 Oct 2024 17:34:26 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.202])
	by front1 (Coremail) with SMTP id qMiowMBxnkegWh9nFzAiAA--.14607S2;
	Mon, 28 Oct 2024 17:34:25 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] dmaengine: loongson2-apb: Change GENMASK to GENMASK_ULL
Date: Mon, 28 Oct 2024 17:34:13 +0800
Message-ID: <20241028093413.1145820-1-zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxnkegWh9nFzAiAA--.14607S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw4xWrW8Xw4kuF4fuF1xZwc_yoW8WF18pF
	y3W34IgrW5KF17Was5ta4YqFy3AasxJrW7uanFv34Uur93Zwn293s5tFs3XFyUAryUAFW2
	vF97t345AFZ7WacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jYSoJUUUUU=

Fix the following smatch static checker warning:

drivers/dma/loongson2-apb-dma.c:189 ls2x_dma_write_cmd()
warn: was expecting a 64 bit value instead of '~(((0)) + (((~((0))) - (((1)) << (0)) + 1) & (~((0)) >> ((8 * 4) - 1 - (4)))))'

The GENMASK macro used "unsigned long", which caused build issues when
using a 32-bit toolchain because it would try to access bits > 31. This
patch switches GENMASK to GENMASK_ULL, which uses "unsigned long long".

Fixes: 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA controller")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/87cdc025-7246-4548-85ca-3d36fdc2be2d@stanley.mountain/
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/dma/loongson2-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/loongson2-apb-dma.c b/drivers/dma/loongson2-apb-dma.c
index 367ed34ce4da..c528f02b9f84 100644
--- a/drivers/dma/loongson2-apb-dma.c
+++ b/drivers/dma/loongson2-apb-dma.c
@@ -31,7 +31,7 @@
 #define LDMA_ASK_VALID		BIT(2)
 #define LDMA_START		BIT(3) /* DMA start operation */
 #define LDMA_STOP		BIT(4) /* DMA stop operation */
-#define LDMA_CONFIG_MASK	GENMASK(4, 0) /* DMA controller config bits mask */
+#define LDMA_CONFIG_MASK	GENMASK_ULL(4, 0) /* DMA controller config bits mask */
 
 /* Bitfields in ndesc_addr field of HW descriptor */
 #define LDMA_DESC_EN		BIT(0) /*1: The next descriptor is valid */

base-commit: 8974f34de2ef173470a596a4dee22f4922583d1b
-- 
2.43.5


