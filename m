Return-Path: <dmaengine+bounces-8819-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGLBKzpPiWmb6QQAu9opvQ
	(envelope-from <dmaengine+bounces-8819-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 04:06:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 242AB10B502
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 04:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BBA1301BCD7
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 03:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3962EAB83;
	Mon,  9 Feb 2026 03:04:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DB92EBB99;
	Mon,  9 Feb 2026 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606294; cv=none; b=iRYSwE/PZcR8R1oAURK1tmEk8+Pv3lN9cq+C8vGfR+VHs4bR2pDFQDKRN53DsnOcUWCruJkL+5inHt5BFg2+nVXqxEs+W+GqneL2p+pSP6Yrv4wo47rrOhuo5/mkN571zMkYMQ0R1HCvSFnHV5FbniRvKBSTZhq6GcWcJO89ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606294; c=relaxed/simple;
	bh=m7Q9YNZPhO7mLG9J8++kAT0G12gc8vK3kigAMznH7yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwiQDJ+cpdffHFGEGq9MXeCb0EBGqxmtkM92N+P1TAi2RB1V5YX3LagmLZbon4yCBYHY4M72qs7ixsFTgnyHxS5HtuwhQ1A1VZN6AQnlC05oeiy+wF7es7WRxB00rFhbm1URg9e2keoNQyhbuZPduqOR0sqarLGQTXpOWlAsp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8CxJMHNTolp_vgQAA--.7222S3;
	Mon, 09 Feb 2026 11:04:45 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJBxKMHHTolpRO1CAA--.46046S3;
	Mon, 09 Feb 2026 11:04:43 +0800 (CST)
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
Subject: [PATCH v2 1/4] dmaengine: loongson: New directory for Loongson DMA controllers drivers
Date: Mon,  9 Feb 2026 11:04:18 +0800
Message-ID: <d62faafc653efab602c8d6bfcdcee1cb217171b9.1770605931.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJBxKMHHTolpRO1CAA--.46046S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgENCGmIJZ8GhgAAsd
X-Coremail-Antispam: 1Uk129KBj93XoWxtryUJr4UWry7Cr48ZF4DJrc_yoWxWFWkpF
	s3A3yfurWUtF47A3s5XFyUKry5Aas3Jr9ruay7Z34DurZ7Aa4UZw1ktFy0qr4UAryDJFW2
	qa48GrWUCF47GwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-8819-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com,aosc.io];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.851];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:mid,loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 242AB10B502
X-Rspamd-Action: no action

Gather the Loongson DMA controllers under drivers/dma/loongson/

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 MAINTAINERS                                   |  3 +-
 drivers/dma/Kconfig                           | 25 ++---------------
 drivers/dma/Makefile                          |  3 +-
 drivers/dma/loongson/Kconfig                  | 28 +++++++++++++++++++
 drivers/dma/loongson/Makefile                 |  3 ++
 .../dma/{ => loongson}/loongson1-apb-dma.c    |  4 +--
 .../dma/{ => loongson}/loongson2-apb-dma.c    |  4 +--
 7 files changed, 40 insertions(+), 30 deletions(-)
 create mode 100644 drivers/dma/loongson/Kconfig
 create mode 100644 drivers/dma/loongson/Makefile
 rename drivers/dma/{ => loongson}/loongson1-apb-dma.c (99%)
 rename drivers/dma/{ => loongson}/loongson2-apb-dma.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f630328ca6ae..27f77b68d596 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14777,7 +14777,7 @@ M:	Binbin Zhou <zhoubinbin@loongson.cn>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
-F:	drivers/dma/loongson2-apb-dma.c
+F:	drivers/dma/loongson/loongson2-apb-dma.c
 
 LOONGSON LS2X I2C DRIVER
 M:	Binbin Zhou <zhoubinbin@loongson.cn>
@@ -17515,6 +17515,7 @@ F:	arch/mips/boot/dts/loongson/loongson1*
 F:	arch/mips/configs/loongson1_defconfig
 F:	arch/mips/loongson32/
 F:	drivers/*/*loongson1*
+F:	drivers/dma/loongson/loongson1-apb-dma.c
 F:	drivers/mtd/nand/raw/loongson-nand-controller.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
 F:	sound/soc/loongson/loongson1_ac97.c
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 66cda7cc9f7a..1b84c5b11654 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -376,29 +376,6 @@ config K3_DMA
 	  Support the DMA engine for Hisilicon K3 platform
 	  devices.
 
-config LOONGSON1_APB_DMA
-	tristate "Loongson1 APB DMA support"
-	depends on MACH_LOONGSON32 || COMPILE_TEST
-	select DMA_ENGINE
-	select DMA_VIRTUAL_CHANNELS
-	help
-	  This selects support for the APB DMA controller in Loongson1 SoCs,
-	  which is required by Loongson1 NAND and audio support.
-
-config LOONGSON2_APB_DMA
-	tristate "Loongson2 APB DMA support"
-	depends on LOONGARCH || COMPILE_TEST
-	select DMA_ENGINE
-	select DMA_VIRTUAL_CHANNELS
-	help
-	  Support for the Loongson2 APB DMA controller driver. The
-	  DMA controller is having single DMA channel which can be
-	  configured for different peripherals like audio, nand, sdio
-	  etc which is in APB bus.
-
-	  This DMA controller transfers data from memory to peripheral fifo.
-	  It does not support memory to memory data transfer.
-
 config LPC18XX_DMAMUX
 	bool "NXP LPC18xx/43xx DMA MUX for PL080"
 	depends on ARCH_LPC18XX || COMPILE_TEST
@@ -774,6 +751,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
 
 source "drivers/dma/lgm/Kconfig"
 
+source "drivers/dma/loongson/Kconfig"
+
 source "drivers/dma/stm32/Kconfig"
 
 # clients
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a54d7688392b..a1c73415b79f 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -49,8 +49,6 @@ obj-$(CONFIG_INTEL_IDMA64) += idma64.o
 obj-$(CONFIG_INTEL_IOATDMA) += ioat/
 obj-y += idxd/
 obj-$(CONFIG_K3_DMA) += k3dma.o
-obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
-obj-$(CONFIG_LOONGSON2_APB_DMA) += loongson2-apb-dma.o
 obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
 obj-$(CONFIG_LPC32XX_DMAMUX) += lpc32xx-dmamux.o
 obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
@@ -88,6 +86,7 @@ obj-$(CONFIG_INTEL_LDMA) += lgm/
 
 obj-y += amd/
 obj-y += mediatek/
+obj-y += loongson/
 obj-y += qcom/
 obj-y += stm32/
 obj-y += ti/
diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
new file mode 100644
index 000000000000..9dbdaef5a59f
--- /dev/null
+++ b/drivers/dma/loongson/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Loongson DMA controllers drivers
+#
+if MACH_LOONGSON32 || MACH_LOONGSON64 || COMPILE_TEST
+
+config LOONGSON1_APB_DMA
+	tristate "Loongson1 APB DMA support"
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  This selects support for the APB DMA controller in Loongson1 SoCs,
+	  which is required by Loongson1 NAND and audio support.
+
+config LOONGSON2_APB_DMA
+	tristate "Loongson2 APB DMA support"
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Support for the Loongson2 APB DMA controller driver. The
+	  DMA controller is having single DMA channel which can be
+	  configured for different peripherals like audio, nand, sdio
+	  etc which is in APB bus.
+
+	  This DMA controller transfers data from memory to peripheral fifo.
+	  It does not support memory to memory data transfer.
+
+endif
diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makefile
new file mode 100644
index 000000000000..6cdd08065e92
--- /dev/null
+++ b/drivers/dma/loongson/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
+obj-$(CONFIG_LOONGSON2_APB_DMA) += loongson2-apb-dma.o
diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson/loongson1-apb-dma.c
similarity index 99%
rename from drivers/dma/loongson1-apb-dma.c
rename to drivers/dma/loongson/loongson1-apb-dma.c
index 255fe7eca212..e99247cf90c1 100644
--- a/drivers/dma/loongson1-apb-dma.c
+++ b/drivers/dma/loongson/loongson1-apb-dma.c
@@ -16,8 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "dmaengine.h"
-#include "virt-dma.h"
+#include "../dmaengine.h"
+#include "../virt-dma.h"
 
 /* Loongson-1 DMA Control Register */
 #define LS1X_DMA_CTRL		0x0
diff --git a/drivers/dma/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
similarity index 99%
rename from drivers/dma/loongson2-apb-dma.c
rename to drivers/dma/loongson/loongson2-apb-dma.c
index c528f02b9f84..0cb607595d04 100644
--- a/drivers/dma/loongson2-apb-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-dma.c
@@ -17,8 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "dmaengine.h"
-#include "virt-dma.h"
+#include "../dmaengine.h"
+#include "../virt-dma.h"
 
 /* Global Configuration Register */
 #define LDMA_ORDER_ERG		0x0
-- 
2.52.0


