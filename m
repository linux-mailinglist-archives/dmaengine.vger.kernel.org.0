Return-Path: <dmaengine+bounces-8687-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ns8OofqgWkFMAMAu9opvQ
	(envelope-from <dmaengine+bounces-8687-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:31:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A94AFD90AE
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1090E3077C6C
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEF4342C94;
	Tue,  3 Feb 2026 12:30:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682E340A6C;
	Tue,  3 Feb 2026 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121843; cv=none; b=LZeTGER6TIC+RYOXV1sxLwqtUa2RcAF011zWGwyBKes9dqplGpcUO3SWb25shHsUlZIIPc6k2YV0HmudYnrKcNxryuuCyIXHsbuKR/g4VwdcNo3O5xJ3gETJvyG2+QM0DdwrN7vQaenlBVesaQSFMzQcz2TKqfrzBWPMefMviH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121843; c=relaxed/simple;
	bh=gaozqkTKKBKgO4Hq2NQnyRn+teWqfFWcGbdxRmUj/XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfleHuk5RzShfdOKG99MnbH+cqWzX24JtwGBjwN86di5JyJsluNJlBf5dPC8eTfH1+HiV+5WamFeBDYUSPjvN7kOvdFOqV9chxcPgy2RpS7qLgLdn75BxYNUqQj58heOlhGrlvbrCUgmiYKVG7iLNUC03/73JapVGU/f8rHdWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8CxKMJs6oFpIV0PAA--.50048S3;
	Tue, 03 Feb 2026 20:30:36 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJBxKMFl6oFp7RY_AA--.38493S3;
	Tue, 03 Feb 2026 20:30:35 +0800 (CST)
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
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 1/3] dmaengine: loongson: New directory for Loongson DMA controllers drivers
Date: Tue,  3 Feb 2026 20:30:10 +0800
Message-ID: <d7a73d1fe8a3e4e57055a15a6ec03170f0d8ca21.1770119693.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770119693.git.zhoubinbin@loongson.cn>
References: <cover.1770119693.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKMFl6oFp7RY_AA--.38493S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEHCGmBjjoICwAAsQ
X-Coremail-Antispam: 1Uk129KBj93XoWxtryUAw1kuryDKw4xGFW5twc_yoWxJF4UpF
	s3A3yfurWUta17A3s5XFyUKry5Aas3Jr9ruay7Zw1DurZ7Aa4UZw1ktFyvqr4UAryDJFW2
	qa48GFWUCF47GwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcsjjDUUUU
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8687-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A94AFD90AE
X-Rspamd-Action: no action

Gather the Loongson DMA controllers under drivers/dma/loongson/

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 MAINTAINERS                                   |  2 +-
 drivers/dma/Kconfig                           | 25 ++---------------
 drivers/dma/Makefile                          |  3 +-
 drivers/dma/loongson/Kconfig                  | 28 +++++++++++++++++++
 drivers/dma/loongson/Makefile                 |  3 ++
 .../dma/{ => loongson}/loongson1-apb-dma.c    |  4 +--
 .../dma/{ => loongson}/loongson2-apb-dma.c    |  4 +--
 7 files changed, 39 insertions(+), 30 deletions(-)
 create mode 100644 drivers/dma/loongson/Kconfig
 create mode 100644 drivers/dma/loongson/Makefile
 rename drivers/dma/{ => loongson}/loongson1-apb-dma.c (99%)
 rename drivers/dma/{ => loongson}/loongson2-apb-dma.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..66807104af63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14776,7 +14776,7 @@ M:	Binbin Zhou <zhoubinbin@loongson.cn>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
-F:	drivers/dma/loongson2-apb-dma.c
+F:	drivers/dma/loongson/loongson2-apb-dma.c
 
 LOONGSON LS2X I2C DRIVER
 M:	Binbin Zhou <zhoubinbin@loongson.cn>
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
2.47.3


