Return-Path: <dmaengine+bounces-9317-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHa5Mfqaq2kJewEAu9opvQ
	(envelope-from <dmaengine+bounces-9317-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 07 Mar 2026 04:26:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E547229E77
	for <lists+dmaengine@lfdr.de>; Sat, 07 Mar 2026 04:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49A60306A536
	for <lists+dmaengine@lfdr.de>; Sat,  7 Mar 2026 03:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928730E821;
	Sat,  7 Mar 2026 03:25:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0704230DED5;
	Sat,  7 Mar 2026 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853959; cv=none; b=RVG50h6dN/ui9vyiW1WXagO9lwbyMaQsO6lrjyi/ZoXdCSPavBGoEaH5nejnUBURiMSUFbYsHZpBtsSNOl6YSZPrz4Qyy6yd2kUFQaQE3Hxv5Fa2Tt50Kmo50bq/QiajZHc89PT5OPVtZNRlu1vrTwKG3XRmtAzLv7Iu1rcnUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853959; c=relaxed/simple;
	bh=T49GWU/JBBstZpm7vDNuXZQYyFrM3JpKwHY+TOELNZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R639K1uA5KObC+1Dla7UTC59KpslYyuncNEwG5Q6zNk5aG2ihLtChG444ARxf9yPIAiuiYuiBMxbZejJZdj8EEreLfMH9kam4V9yuqLSsKfN9hx6xHaJ2x0uNXJeF4KqA2/By45aEXf8JbonNpS8hPosT5u52NjFxsDzNt8KZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.227])
	by gateway (Coremail) with SMTP id _____8Ax_6nAmqtpRGcYAA--.13570S3;
	Sat, 07 Mar 2026 11:25:52 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.227])
	by front1 (Coremail) with SMTP id qMiowJDxD8O4mqtpK+BPAA--.21629S4;
	Sat, 07 Mar 2026 11:25:49 +0800 (CST)
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
Subject: [PATCH v4 6/6] dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller
Date: Sat,  7 Mar 2026 11:25:37 +0800
Message-ID: <73bc32ba6249f1eef94fec9b349bc9efa98278ea.1772853681.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1772853681.git.zhoubinbin@loongson.cn>
References: <cover.1772853681.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxD8O4mqtpK+BPAA--.21629S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQETCGmqbMIY2AAAs2
X-Coremail-Antispam: 1Uk129KBj9fXoWfZF1kAr13Gr4fuw1rWw17Jwc_yoW5XF15Xo
	ZxZFnxW3yrXw1xWay2gFyftrW7XFyUZ34vkwn3Ar4qvrZ0yFy5AFWUGrnrGFy7JFy3tFWU
	C34SqFWxXa17JF45l-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jqRRiUUUUU=
X-Rspamd-Queue-Id: 6E547229E77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-9317-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com,loongson.cn,nxp.com];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.870];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,loongson.cn:mid,loongson.cn:email]
X-Rspamd-Action: no action

This DMA controller appears in Loongson-2K0300 and Loongson-2K3000.

It is a chain multi-channel controller that enables data transfers from
memory to memory, device to memory, and memory to device, as well as
channel prioritization configurable through the channel configuration
registers.

In addition, there are slight differences between Loongson-2K0300 and
Loongson-2K3000, such as channel register offsets and the number of
channels.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 MAINTAINERS                                  |   1 +
 drivers/dma/loongson/Kconfig                 |  11 +
 drivers/dma/loongson/Makefile                |   1 +
 drivers/dma/loongson/loongson2-apb-cmc-dma.c | 730 +++++++++++++++++++
 4 files changed, 743 insertions(+)
 create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aea29c28d865..af9fbb3b43e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14954,6 +14954,7 @@ L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
 F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
+F:	drivers/dma/loongson/loongson2-apb-cmc-dma.c
 F:	drivers/dma/loongson/loongson2-apb-dma.c
 
 LOONGSON LS2X I2C DRIVER
diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
index 0a865a8fd3a6..c4e62dce5d4f 100644
--- a/drivers/dma/loongson/Kconfig
+++ b/drivers/dma/loongson/Kconfig
@@ -27,4 +27,15 @@ config LOONGSON2_APB_DMA
 	  This DMA controller transfers data from memory to peripheral fifo.
 	  It does not support memory to memory data transfer.
 
+config LOONGSON2_APB_CMC_DMA
+	tristate "Loongson2 Chain Multi-Channel DMA support"
+	depends on MACH_LOONGSON64 || COMPILE_TEST
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Support for the Loongson Chain Multi-Channel DMA controller driver.
+	  It is discovered on the Loongson-2K chip (Loongson-2K0300/Loongson-2K3000),
+	  which has 4/8 channels internally, enabling bidirectional data transfer
+	  between devices and memory.
+
 endif
diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makefile
index 6cdd08065e92..48c19781e729 100644
--- a/drivers/dma/loongson/Makefile
+++ b/drivers/dma/loongson/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
 obj-$(CONFIG_LOONGSON2_APB_DMA) += loongson2-apb-dma.o
+obj-$(CONFIG_LOONGSON2_APB_CMC_DMA) += loongson2-apb-cmc-dma.o
diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
new file mode 100644
index 000000000000..2f2ef51e41b6
--- /dev/null
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -0,0 +1,730 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Looongson-2 Chain Multi-Channel DMA Controller driver
+ *
+ * Copyright (C) 2024-2026 Loongson Technology Corporation Limited
+ */
+
+#include <linux/acpi.h>
+#include <linux/acpi_dma.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+
+#define LOONGSON2_CMCDMA_ISR		0x0	/* DMA Interrupt Status Register */
+#define LOONGSON2_CMCDMA_IFCR		0x4	/* DMA Interrupt Flag Clear Register */
+#define LOONGSON2_CMCDMA_CCR		0x8	/* DMA Channel Configuration Register */
+#define LOONGSON2_CMCDMA_CNDTR		0xc	/* DMA Channel Transmit Count Register */
+#define LOONGSON2_CMCDMA_CPAR		0x10	/* DMA Channel Peripheral Address Register */
+#define LOONGSON2_CMCDMA_CMAR		0x14	/* DMA Channel Memory Address Register */
+
+/* Bitfields of DMA interrupt status register */
+#define LOONGSON2_CMCDMA_TCI		BIT(1) /* Transfer Complete Interrupt */
+#define LOONGSON2_CMCDMA_HTI		BIT(2) /* Half Transfer Interrupt */
+#define LOONGSON2_CMCDMA_TEI		BIT(3) /* Transfer Error Interrupt */
+
+#define LOONGSON2_CMCDMA_MASKI		\
+	(LOONGSON2_CMCDMA_TCI | LOONGSON2_CMCDMA_HTI | LOONGSON2_CMCDMA_TEI)
+
+/* Bitfields of DMA channel x Configuration Register */
+#define LOONGSON2_CMCDMA_CCR_EN		BIT(0) /* Stream Enable */
+#define LOONGSON2_CMCDMA_CCR_TCIE	BIT(1) /* Transfer Complete Interrupt Enable */
+#define LOONGSON2_CMCDMA_CCR_HTIE	BIT(2) /* Half Transfer Complete Interrupt Enable */
+#define LOONGSON2_CMCDMA_CCR_TEIE	BIT(3) /* Transfer Error Interrupt Enable */
+#define LOONGSON2_CMCDMA_CCR_DIR	BIT(4) /* Data Transfer Direction */
+#define LOONGSON2_CMCDMA_CCR_CIRC	BIT(5) /* Circular mode */
+#define LOONGSON2_CMCDMA_CCR_PINC	BIT(6) /* Peripheral increment mode */
+#define LOONGSON2_CMCDMA_CCR_MINC	BIT(7) /* Memory increment mode */
+#define LOONGSON2_CMCDMA_CCR_PSIZE_MASK	GENMASK(9, 8)
+#define LOONGSON2_CMCDMA_CCR_MSIZE_MASK	GENMASK(11, 10)
+#define LOONGSON2_CMCDMA_CCR_PL_MASK	GENMASK(13, 12)
+#define LOONGSON2_CMCDMA_CCR_M2M	BIT(14)
+
+#define LOONGSON2_CMCDMA_CCR_CFG_MASK	\
+	(LOONGSON2_CMCDMA_CCR_PINC | LOONGSON2_CMCDMA_CCR_MINC | LOONGSON2_CMCDMA_CCR_PL_MASK)
+
+#define LOONGSON2_CMCDMA_CCR_IRQ_MASK	\
+	(LOONGSON2_CMCDMA_CCR_TCIE | LOONGSON2_CMCDMA_CCR_HTIE | LOONGSON2_CMCDMA_CCR_TEIE)
+
+#define LOONGSON2_CMCDMA_STREAM_MASK	\
+	(LOONGSON2_CMCDMA_CCR_CFG_MASK | LOONGSON2_CMCDMA_CCR_IRQ_MASK)
+
+#define LOONGSON2_CMCDMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
+					 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+					 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
+
+#define LOONSON2_CMCDMA_MAX_DATA_ITEMS	SZ_64K
+
+struct loongson2_cmc_dma_chan_reg {
+	u32 ccr;
+	u32 cndtr;
+	u32 cpar;
+	u32 cmar;
+};
+
+struct loongson2_cmc_dma_sg_req {
+	u32 len;
+	struct loongson2_cmc_dma_chan_reg chan_reg;
+};
+
+struct loongson2_cmc_dma_desc {
+	struct virt_dma_desc vdesc;
+	bool cyclic;
+	u32 num_sgs;
+	struct loongson2_cmc_dma_sg_req sg_req[] __counted_by(num_sgs);
+};
+
+struct loongson2_cmc_dma_chan {
+	struct virt_dma_chan vchan;
+	struct dma_slave_config	dma_sconfig;
+	struct loongson2_cmc_dma_desc *desc;
+	u32 id;
+	u32 irq;
+	u32 next_sg;
+	struct loongson2_cmc_dma_chan_reg chan_reg;
+};
+
+struct loongson2_cmc_dma_dev {
+	struct dma_device ddev;
+	struct clk *dma_clk;
+	void __iomem *base;
+	u32 nr_channels;
+	u32 chan_reg_offset;
+	struct loongson2_cmc_dma_chan chan[] __counted_by(nr_channels);
+};
+
+struct loongson2_cmc_dma_config {
+	u32 max_channels;
+	u32 chan_reg_offset;
+};
+
+static const struct loongson2_cmc_dma_config ls2k0300_cmc_dma_config = {
+	.max_channels = 8,
+	.chan_reg_offset = 0x14,
+};
+
+static const struct loongson2_cmc_dma_config ls2k3000_cmc_dma_config = {
+	.max_channels = 4,
+	.chan_reg_offset = 0x18,
+};
+
+static struct loongson2_cmc_dma_dev *lmdma_get_dev(struct loongson2_cmc_dma_chan *lchan)
+{
+	return container_of(lchan->vchan.chan.device, struct loongson2_cmc_dma_dev, ddev);
+}
+
+static struct loongson2_cmc_dma_chan *to_lmdma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct loongson2_cmc_dma_chan, vchan.chan);
+}
+
+static struct loongson2_cmc_dma_desc *to_lmdma_desc(struct virt_dma_desc *vdesc)
+{
+	return container_of(vdesc, struct loongson2_cmc_dma_desc, vdesc);
+}
+
+static struct device *chan2dev(struct loongson2_cmc_dma_chan *lchan)
+{
+	return &lchan->vchan.chan.dev->device;
+}
+
+static u32 loongson2_cmc_dma_read(struct loongson2_cmc_dma_dev *lddev, u32 reg, u32 id)
+{
+	return readl(lddev->base + (reg + lddev->chan_reg_offset * id));
+}
+
+static void loongson2_cmc_dma_write(struct loongson2_cmc_dma_dev *lddev, u32 reg, u32 id, u32 val)
+{
+	writel(val, lddev->base + (reg + lddev->chan_reg_offset * id));
+}
+
+static int loongson2_cmc_dma_get_width(enum dma_slave_buswidth width)
+{
+	switch (width) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		return ffs(width) - 1;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int loongson2_cmc_dma_slave_config(struct dma_chan *chan, struct dma_slave_config *config)
+{
+	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
+
+	memcpy(&lchan->dma_sconfig, config, sizeof(*config));
+
+	return 0;
+}
+
+static void loongson2_cmc_dma_irq_clear(struct loongson2_cmc_dma_chan *lchan, u32 flags)
+{
+	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
+	u32 ifcr;
+
+	ifcr = flags << (4 * lchan->id);
+	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_IFCR, 0, ifcr);
+}
+
+static void loongson2_cmc_dma_stop(struct loongson2_cmc_dma_chan *lchan)
+{
+	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
+	u32 ccr;
+
+	ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan->id);
+	ccr &= ~(LOONGSON2_CMCDMA_CCR_IRQ_MASK | LOONGSON2_CMCDMA_CCR_EN);
+	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, ccr);
+
+	loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_MASKI);
+}
+
+static int loongson2_cmc_dma_terminate_all(struct dma_chan *chan)
+{
+	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
+
+	LIST_HEAD(head);
+
+	scoped_guard(spinlock_irqsave, &lchan->vchan.lock) {
+		if (lchan->desc) {
+			vchan_terminate_vdesc(&lchan->desc->vdesc);
+			loongson2_cmc_dma_stop(lchan);
+			lchan->desc = NULL;
+		}
+		vchan_get_all_descriptors(&lchan->vchan, &head);
+	}
+
+	vchan_dma_desc_free_list(&lchan->vchan, &head);
+
+	return 0;
+}
+
+static void loongson2_cmc_dma_synchronize(struct dma_chan *chan)
+{
+	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
+
+	vchan_synchronize(&lchan->vchan);
+}
+
+static void loongson2_cmc_dma_start_transfer(struct loongson2_cmc_dma_chan *lchan)
+{
+	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
+	struct loongson2_cmc_dma_sg_req *sg_req;
+	struct loongson2_cmc_dma_chan_reg *reg;
+	struct virt_dma_desc *vdesc;
+
+	loongson2_cmc_dma_stop(lchan);
+
+	if (!lchan->desc) {
+		vdesc = vchan_next_desc(&lchan->vchan);
+		if (!vdesc)
+			return;
+
+		list_del(&vdesc->node);
+		lchan->desc = to_lmdma_desc(vdesc);
+		lchan->next_sg = 0;
+	}
+
+	if (lchan->next_sg == lchan->desc->num_sgs)
+		lchan->next_sg = 0;
+
+	sg_req = &lchan->desc->sg_req[lchan->next_sg];
+	reg = &sg_req->chan_reg;
+
+	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, reg->ccr);
+	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id, reg->cndtr);
+	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CPAR, lchan->id, reg->cpar);
+	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, lchan->id, reg->cmar);
+
+	lchan->next_sg++;
+
+	/* Start DMA */
+	reg->ccr |= LOONGSON2_CMCDMA_CCR_EN;
+	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, reg->ccr);
+}
+
+static void loongson2_cmc_dma_configure_next_sg(struct loongson2_cmc_dma_chan *lchan)
+{
+	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
+	struct loongson2_cmc_dma_sg_req *sg_req;
+	u32 ccr, id = lchan->id;
+
+	if (lchan->next_sg == lchan->desc->num_sgs)
+		lchan->next_sg = 0;
+
+	/* Stop to update mem addr */
+	ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, id);
+	ccr &= ~LOONGSON2_CMCDMA_CCR_EN;
+	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, id, ccr);
+
+	sg_req = &lchan->desc->sg_req[lchan->next_sg];
+	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, id, sg_req->chan_reg.cmar);
+
+	/* Start transition */
+	ccr |= LOONGSON2_CMCDMA_CCR_EN;
+	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, id, ccr);
+}
+
+static void loongson2_cmc_dma_handle_chan_done(struct loongson2_cmc_dma_chan *lchan)
+{
+	if (!lchan->desc)
+		return;
+
+	if (lchan->desc->cyclic) {
+		vchan_cyclic_callback(&lchan->desc->vdesc);
+		/* LOONGSON2_CMCDMA_CCR_CIRC mode don't need update register */
+		if (lchan->desc->num_sgs == 1)
+			return;
+		loongson2_cmc_dma_configure_next_sg(lchan);
+		lchan->next_sg++;
+	} else {
+		if (lchan->next_sg == lchan->desc->num_sgs) {
+			vchan_cookie_complete(&lchan->desc->vdesc);
+			lchan->desc = NULL;
+		}
+		loongson2_cmc_dma_start_transfer(lchan);
+	}
+}
+
+static irqreturn_t loongson2_cmc_dma_chan_irq(int irq, void *devid)
+{
+	struct loongson2_cmc_dma_chan *lchan = devid;
+	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
+	struct device *dev = chan2dev(lchan);
+	u32 ists, status, ccr;
+
+	scoped_guard(spinlock, &lchan->vchan.lock) {
+		ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan->id);
+		ists = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_ISR, 0);
+		status = (ists >> (4 * lchan->id)) & LOONGSON2_CMCDMA_MASKI;
+
+		loongson2_cmc_dma_irq_clear(lchan, status);
+
+		if (status & LOONGSON2_CMCDMA_TCI) {
+			loongson2_cmc_dma_handle_chan_done(lchan);
+			status &= ~LOONGSON2_CMCDMA_TCI;
+		}
+
+		if (status & LOONGSON2_CMCDMA_HTI)
+			status &= ~LOONGSON2_CMCDMA_HTI;
+
+		if (status & LOONGSON2_CMCDMA_TEI) {
+			dev_err(dev, "DMA Transform Error.\n");
+			if (!(ccr & LOONGSON2_CMCDMA_CCR_EN))
+				dev_err(dev, "Channel disabled by HW.\n");
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void loongson2_cmc_dma_issue_pending(struct dma_chan *chan)
+{
+	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
+
+	guard(spinlock_irqsave)(&lchan->vchan.lock);
+
+	if (vchan_issue_pending(&lchan->vchan) && !lchan->desc) {
+		dev_dbg(chan2dev(lchan), "vchan %pK: issued\n", &lchan->vchan);
+		loongson2_cmc_dma_start_transfer(lchan);
+	}
+}
+
+static int loongson2_cmc_dma_set_xfer_param(struct loongson2_cmc_dma_chan *lchan,
+					    enum dma_transfer_direction direction,
+					    enum dma_slave_buswidth *buswidth, u32 buf_len)
+{
+	struct dma_slave_config	sconfig = lchan->dma_sconfig;
+	struct device *dev = chan2dev(lchan);
+	int dev_width;
+	u32 ccr;
+
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		dev_width = loongson2_cmc_dma_get_width(sconfig.dst_addr_width);
+		if (dev_width < 0) {
+			dev_err(dev, "DMA_MEM_TO_DEV bus width not supported\n");
+			return dev_width;
+		}
+		lchan->chan_reg.cpar = sconfig.dst_addr;
+		ccr = LOONGSON2_CMCDMA_CCR_DIR;
+		*buswidth = sconfig.dst_addr_width;
+		break;
+	case DMA_DEV_TO_MEM:
+		dev_width = loongson2_cmc_dma_get_width(sconfig.src_addr_width);
+		if (dev_width < 0) {
+			dev_err(dev, "DMA_DEV_TO_MEM bus width not supported\n");
+			return dev_width;
+		}
+		lchan->chan_reg.cpar = sconfig.src_addr;
+		ccr = LOONGSON2_CMCDMA_CCR_MINC;
+		*buswidth = sconfig.src_addr_width;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ccr |= FIELD_PREP(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, dev_width) |
+	       FIELD_PREP(LOONGSON2_CMCDMA_CCR_MSIZE_MASK, dev_width);
+
+	/* Set DMA control register */
+	lchan->chan_reg.ccr &= ~(LOONGSON2_CMCDMA_CCR_PSIZE_MASK | LOONGSON2_CMCDMA_CCR_MSIZE_MASK);
+	lchan->chan_reg.ccr |= ccr;
+
+	return 0;
+}
+
+static struct dma_async_tx_descriptor *
+loongson2_cmc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl, u32 sg_len,
+				enum dma_transfer_direction direction,
+				unsigned long flags, void *context)
+{
+	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
+	struct loongson2_cmc_dma_desc *desc;
+	enum dma_slave_buswidth buswidth;
+	struct scatterlist *sg;
+	u32 num_items, i;
+	int ret;
+
+	desc = kzalloc_flex(*desc, sg_req, sg_len, GFP_NOWAIT);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		ret = loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswidth, sg_dma_len(sg));
+		if (ret)
+			return ERR_PTR(ret);
+
+		num_items = DIV_ROUND_UP(sg_dma_len(sg), buswidth);
+		if (num_items >= LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
+			dev_err(chan2dev(lchan), "Number of items not supported\n");
+			kfree(desc);
+			return ERR_PTR(-EINVAL);
+		}
+
+		desc->sg_req[i].len = sg_dma_len(sg);
+		desc->sg_req[i].chan_reg.ccr = lchan->chan_reg.ccr;
+		desc->sg_req[i].chan_reg.cpar = lchan->chan_reg.cpar;
+		desc->sg_req[i].chan_reg.cmar = sg_dma_address(sg);
+		desc->sg_req[i].chan_reg.cndtr = num_items;
+	}
+
+	desc->num_sgs = sg_len;
+	desc->cyclic = false;
+
+	return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
+}
+
+static struct dma_async_tx_descriptor *
+loongson2_cmc_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
+				  size_t period_len, enum dma_transfer_direction direction,
+				  unsigned long flags)
+{
+	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
+	struct loongson2_cmc_dma_desc *desc;
+	enum dma_slave_buswidth buswidth;
+	u32 num_periods, num_items, i;
+	int ret;
+
+	if (unlikely(buf_len % period_len))
+		return ERR_PTR(-EINVAL);
+
+	ret = loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswidth, period_len);
+	if (ret)
+		return ERR_PTR(ret);
+
+	num_items = DIV_ROUND_UP(period_len, buswidth);
+	if (num_items >= LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
+		dev_err(chan2dev(lchan), "Number of items not supported\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Enable Circular mode */
+	if (buf_len == period_len)
+		lchan->chan_reg.ccr |= LOONGSON2_CMCDMA_CCR_CIRC;
+
+	num_periods = DIV_ROUND_UP(buf_len, period_len);
+	desc = kzalloc_flex(*desc, sg_req, num_periods, GFP_NOWAIT);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < num_periods; i++) {
+		desc->sg_req[i].len = period_len;
+		desc->sg_req[i].chan_reg.ccr = lchan->chan_reg.ccr;
+		desc->sg_req[i].chan_reg.cpar = lchan->chan_reg.cpar;
+		desc->sg_req[i].chan_reg.cmar = buf_addr;
+		desc->sg_req[i].chan_reg.cndtr = num_items;
+		buf_addr += period_len;
+	}
+
+	desc->num_sgs = num_periods;
+	desc->cyclic = true;
+
+	return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
+}
+
+static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_chan *lchan,
+					     struct loongson2_cmc_dma_desc *desc, u32 next_sg)
+{
+	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
+	u32 residue, width, ndtr, ccr, i;
+
+	ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan->id);
+	width = FIELD_GET(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, ccr);
+
+	ndtr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id);
+	residue = ndtr << width;
+
+	if (lchan->desc->cyclic && next_sg == 0)
+		return residue;
+
+	for (i = next_sg; i < desc->num_sgs; i++)
+		residue += desc->sg_req[i].len;
+
+	return residue;
+}
+
+static enum dma_status loongson2_cmc_dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
+						   struct dma_tx_state *state)
+{
+	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
+	struct virt_dma_desc *vdesc;
+	enum dma_status status;
+
+	status = dma_cookie_status(chan, cookie, state);
+	if (status == DMA_COMPLETE || !state)
+		return status;
+
+	scoped_guard(spinlock_irqsave, &lchan->vchan.lock) {
+		vdesc = vchan_find_desc(&lchan->vchan, cookie);
+		if (lchan->desc && cookie == lchan->desc->vdesc.tx.cookie)
+			state->residue = loongson2_cmc_dma_desc_residue(lchan, lchan->desc,
+									lchan->next_sg);
+		else if (vdesc)
+			state->residue = loongson2_cmc_dma_desc_residue(lchan,
+									to_lmdma_desc(vdesc), 0);
+	}
+
+	return status;
+}
+
+static void loongson2_cmc_dma_free_chan_resources(struct dma_chan *chan)
+{
+	vchan_free_chan_resources(to_virt_chan(chan));
+}
+
+static void loongson2_cmc_dma_desc_free(struct virt_dma_desc *vdesc)
+{
+	kfree(to_lmdma_desc(vdesc));
+}
+
+static bool loongson2_cmc_dma_acpi_filter(struct dma_chan *chan, void *param)
+{
+	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
+	struct acpi_dma_spec *dma_spec = param;
+
+	memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_reg));
+	lchan->chan_reg.ccr = dma_spec->chan_id & LOONGSON2_CMCDMA_STREAM_MASK;
+
+	return true;
+}
+
+static int loongson2_cmc_dma_acpi_controller_register(struct loongson2_cmc_dma_dev *lddev)
+{
+	struct device *dev = lddev->ddev.dev;
+	struct acpi_dma_filter_info *info;
+
+	if (!is_acpi_node(dev_fwnode(dev)))
+		return 0;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	dma_cap_zero(info->dma_cap);
+	info->dma_cap = lddev->ddev.cap_mask;
+	info->filter_fn = loongson2_cmc_dma_acpi_filter;
+
+	return devm_acpi_dma_controller_register(dev, acpi_dma_simple_xlate, info);
+}
+
+static struct dma_chan *loongson2_cmc_dma_of_xlate(struct of_phandle_args *dma_spec,
+						   struct of_dma *ofdma)
+{
+	struct loongson2_cmc_dma_dev *lddev = ofdma->of_dma_data;
+	struct device *dev = lddev->ddev.dev;
+	struct loongson2_cmc_dma_chan *lchan;
+	struct dma_chan *chan;
+
+	if (dma_spec->args_count < 2)
+		return ERR_PTR(-EINVAL);
+
+	if (dma_spec->args[0] >= lddev->nr_channels) {
+		dev_err(dev, "Invalid channel id.\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	lchan = &lddev->chan[dma_spec->args[0]];
+	chan = dma_get_slave_channel(&lchan->vchan.chan);
+	if (!chan) {
+		dev_err(dev, "No more channels available.\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_reg));
+	lchan->chan_reg.ccr = dma_spec->args[1] & LOONGSON2_CMCDMA_STREAM_MASK;
+
+	return chan;
+}
+
+static int loongson2_cmc_dma_of_controller_register(struct loongson2_cmc_dma_dev *lddev)
+{
+	struct device *dev = lddev->ddev.dev;
+
+	if (!is_of_node(dev_fwnode(dev)))
+		return 0;
+
+	return of_dma_controller_register(dev->of_node, loongson2_cmc_dma_of_xlate, lddev);
+}
+
+static int loongson2_cmc_dma_probe(struct platform_device *pdev)
+{
+	const struct loongson2_cmc_dma_config *config;
+	struct loongson2_cmc_dma_chan *lchan;
+	struct loongson2_cmc_dma_dev *lddev;
+	struct device *dev = &pdev->dev;
+	struct dma_device *ddev;
+	u32 nr_chans, i;
+	int ret;
+
+	config = (const struct loongson2_cmc_dma_config *)device_get_match_data(dev);
+	if (!config)
+		return -EINVAL;
+
+	ret = device_property_read_u32(dev, "dma-channels", &nr_chans);
+	if (ret || nr_chans > config->max_channels) {
+		dev_err(dev, "missing or invalid dma-channels property\n");
+		nr_chans = config->max_channels;
+	}
+
+	lddev = devm_kzalloc(dev, struct_size(lddev, chan, nr_chans), GFP_KERNEL);
+	if (!lddev)
+		return -ENOMEM;
+
+	lddev->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(lddev->base))
+		return PTR_ERR(lddev->base);
+
+	platform_set_drvdata(pdev, lddev);
+	lddev->nr_channels = nr_chans;
+	lddev->chan_reg_offset = config->chan_reg_offset;
+
+	lddev->dma_clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(lddev->dma_clk))
+		return dev_err_probe(dev, PTR_ERR(lddev->dma_clk), "Failed to get dma clock\n");
+
+	ddev = &lddev->ddev;
+	ddev->dev = dev;
+
+	dma_cap_zero(ddev->cap_mask);
+	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
+	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
+	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
+
+	ddev->device_free_chan_resources = loongson2_cmc_dma_free_chan_resources;
+	ddev->device_config = loongson2_cmc_dma_slave_config;
+	ddev->device_prep_slave_sg = loongson2_cmc_dma_prep_slave_sg;
+	ddev->device_prep_dma_cyclic = loongson2_cmc_dma_prep_dma_cyclic;
+	ddev->device_issue_pending = loongson2_cmc_dma_issue_pending;
+	ddev->device_synchronize = loongson2_cmc_dma_synchronize;
+	ddev->device_tx_status = loongson2_cmc_dma_tx_status;
+	ddev->device_terminate_all = loongson2_cmc_dma_terminate_all;
+
+	ddev->max_sg_burst = LOONSON2_CMCDMA_MAX_DATA_ITEMS;
+	ddev->src_addr_widths = LOONGSON2_CMCDMA_BUSWIDTHS;
+	ddev->dst_addr_widths = LOONGSON2_CMCDMA_BUSWIDTHS;
+	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	INIT_LIST_HEAD(&ddev->channels);
+
+	for (i = 0; i < nr_chans; i++) {
+		lchan = &lddev->chan[i];
+
+		lchan->id = i;
+		lchan->vchan.desc_free = loongson2_cmc_dma_desc_free;
+		vchan_init(&lchan->vchan, ddev);
+	}
+
+	ret = dmaenginem_async_device_register(ddev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register DMA engine device.\n");
+
+	for (i = 0; i < nr_chans; i++) {
+		lchan = &lddev->chan[i];
+
+		lchan->irq = platform_get_irq(pdev, i);
+		if (lchan->irq < 0)
+			return lchan->irq;
+
+		ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
+				       dev_name(chan2dev(lchan)), lchan);
+		if (ret)
+			return ret;
+	}
+
+	ret = loongson2_cmc_dma_acpi_controller_register(lddev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register dma controller with ACPI.\n");
+
+	ret = loongson2_cmc_dma_of_controller_register(lddev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register dma controller with FDT.\n");
+
+	dev_info(dev, "Loongson-2 Multi-Channel DMA Controller registered successfully.\n");
+
+	return 0;
+}
+
+static void loongson2_cmc_dma_remove(struct platform_device *pdev)
+{
+	of_dma_controller_free(pdev->dev.of_node);
+}
+
+static const struct of_device_id loongson2_cmc_dma_of_match[] = {
+	{ .compatible = "loongson,ls2k0300-dma", .data = &ls2k0300_cmc_dma_config },
+	{ .compatible = "loongson,ls2k3000-dma", .data = &ls2k3000_cmc_dma_config },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, loongson2_cmc_dma_of_match);
+
+static const struct acpi_device_id loongson2_cmc_dma_acpi_match[] = {
+	{ "LOON0014", .driver_data = (kernel_ulong_t)&ls2k3000_cmc_dma_config },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, loongson2_cmc_dma_acpi_match);
+
+static struct platform_driver loongson2_cmc_dma_driver = {
+	.driver = {
+		.name = "loongson2-apb-cmc-dma",
+		.of_match_table = loongson2_cmc_dma_of_match,
+		.acpi_match_table = loongson2_cmc_dma_acpi_match,
+	},
+	.probe = loongson2_cmc_dma_probe,
+	.remove = loongson2_cmc_dma_remove,
+};
+module_platform_driver(loongson2_cmc_dma_driver);
+
+MODULE_DESCRIPTION("Looongson-2 Chain Multi-Channel DMA Controller driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited");
+MODULE_LICENSE("GPL");
-- 
2.52.0


