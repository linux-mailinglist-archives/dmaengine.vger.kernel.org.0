Return-Path: <dmaengine+bounces-2382-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B579990A9F6
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 11:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822551C21650
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 09:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91D0195395;
	Mon, 17 Jun 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUQFEN30"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79470195385;
	Mon, 17 Jun 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617106; cv=none; b=rD2+5/FR3zS1+Yb3YIpVulkcT8Cm+eCTzyNtc6Mwkb7O3Br734XL4aEW7LIptHmprIYGKoIG4CykUlvaJtXPouuggJcevzMwSjou0cxYyfgb/RQ/75UiBaSnxD0NjxcbEZuiHbZbjyjE5Z89OHp0XfNYYsR9VzuiKw2p0m69BU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617106; c=relaxed/simple;
	bh=zI05ebigLL7N6f3sXqMqhzsK28Pw7x4WApkpZvz6too=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQ/5EW1Fl2zeIdFqLuLhU/TEEhrFbz9XpAIzULu+UoJUM9c2cTubez6QknCAexSHXNLxrb6Ta62qUdHW7BXe53/PU0BPuX8jyC5n8b+nGyDomo+93CCQTEfkXdRypmyto3zI9eS3uWxOKnCXNkJ0Ywv3sjtZWlDVdEi6l3LWIaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUQFEN30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A66BC4DDE9;
	Mon, 17 Jun 2024 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718617106;
	bh=zI05ebigLL7N6f3sXqMqhzsK28Pw7x4WApkpZvz6too=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lUQFEN30XhqTfT7IQQ4qIisjXDkFp7PtRCZuJ0L8K3dDDw6njTygwm/NyupcGkBI+
	 wpKtno3GV9fBIXmwtHq1p9xeQvb0cAIewMXe8JGti0T5RU3piopgEsyfEiE4ANVOUw
	 ntrod8MjIM3la0TmXdOKrK73L4q6/5Tf5F5BtVKzeZFQEqowY4DYnfMPIwupU+hCbt
	 CfbpTrDN2cXIPsdZJSLda0VIEkhHHcgvWx/kOVdUoOcz2XyzYW0sNSKL4b7VC34tRX
	 zM4/ONmThLD1orqV9Tu8m605jpoApB+PjzQTp+HvacUEc3MWwgNBvthW17/ErGWzyY
	 kYMMqukh4yXTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8DBC2BA1A;
	Mon, 17 Jun 2024 09:38:26 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 17 Jun 2024 12:37:12 +0300
Subject: [PATCH v10 38/38] dmaengine: cirrus: remove platform code
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-ep93xx-v10-38-662e640ed811@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
In-Reply-To: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
To: Vinod Koul <vkoul@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718617100; l=6035;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=gcVvzgliElNyoUeXsoUh8/tTM1CO0hurjz+xqTW1O7o=;
 b=weQ8E5DbI6cgQuaTgkOZMdX+CYDNMSQMp/0AXXzTKz0P9GTlIDu8ZB7addXXhlODVsAulejMqyfM
 6cQBwZMLBJt5wcUDRgsPfw7vYQF15wQcJ5EzCuopq0a0NgZ7bU/0
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Remove DMA platform header, from now on we use device tree for DMA
clients.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/dma/ep93xx_dma.c                 |  48 ++++++++++++++-
 include/linux/platform_data/dma-ep93xx.h | 100 -------------------------------
 2 files changed, 46 insertions(+), 102 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 17c8e2badee2..43c4241af7f5 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -25,8 +26,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <linux/platform_data/dma-ep93xx.h>
-
 #include "dmaengine.h"
 
 /* M2P registers */
@@ -106,6 +105,26 @@
 #define DMA_MAX_CHAN_BYTES		0xffff
 #define DMA_MAX_CHAN_DESCRIPTORS	32
 
+/*
+ * M2P channels.
+ *
+ * Note that these values are also directly used for setting the PPALLOC
+ * register.
+ */
+#define EP93XX_DMA_I2S1			0
+#define EP93XX_DMA_I2S2			1
+#define EP93XX_DMA_AAC1			2
+#define EP93XX_DMA_AAC2			3
+#define EP93XX_DMA_AAC3			4
+#define EP93XX_DMA_I2S3			5
+#define EP93XX_DMA_UART1		6
+#define EP93XX_DMA_UART2		7
+#define EP93XX_DMA_UART3		8
+#define EP93XX_DMA_IRDA			9
+/* M2M channels */
+#define EP93XX_DMA_SSP			10
+#define EP93XX_DMA_IDE			11
+
 enum ep93xx_dma_type {
 	M2P_DMA,
 	M2M_DMA,
@@ -242,6 +261,31 @@ static struct ep93xx_dma_chan *to_ep93xx_dma_chan(struct dma_chan *chan)
 	return container_of(chan, struct ep93xx_dma_chan, chan);
 }
 
+static inline bool ep93xx_dma_chan_is_m2p(struct dma_chan *chan)
+{
+	if (device_is_compatible(chan->device->dev, "cirrus,ep9301-dma-m2p"))
+		return true;
+
+	return !strcmp(dev_name(chan->device->dev), "ep93xx-dma-m2p");
+}
+
+/*
+ * ep93xx_dma_chan_direction - returns direction the channel can be used
+ *
+ * This function can be used in filter functions to find out whether the
+ * channel supports given DMA direction. Only M2P channels have such
+ * limitation, for M2M channels the direction is configurable.
+ */
+static inline enum dma_transfer_direction
+ep93xx_dma_chan_direction(struct dma_chan *chan)
+{
+	if (!ep93xx_dma_chan_is_m2p(chan))
+		return DMA_TRANS_NONE;
+
+	/* even channels are for TX, odd for RX */
+	return (chan->chan_id % 2 == 0) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+}
+
 /**
  * ep93xx_dma_set_active - set new active descriptor chain
  * @edmac: channel
diff --git a/include/linux/platform_data/dma-ep93xx.h b/include/linux/platform_data/dma-ep93xx.h
deleted file mode 100644
index 9ec5cdd5a1eb..000000000000
--- a/include/linux/platform_data/dma-ep93xx.h
+++ /dev/null
@@ -1,100 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_ARCH_DMA_H
-#define __ASM_ARCH_DMA_H
-
-#include <linux/types.h>
-#include <linux/device.h>
-#include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
-#include <linux/property.h>
-#include <linux/string.h>
-
-/*
- * M2P channels.
- *
- * Note that these values are also directly used for setting the PPALLOC
- * register.
- */
-#define EP93XX_DMA_I2S1		0
-#define EP93XX_DMA_I2S2		1
-#define EP93XX_DMA_AAC1		2
-#define EP93XX_DMA_AAC2		3
-#define EP93XX_DMA_AAC3		4
-#define EP93XX_DMA_I2S3		5
-#define EP93XX_DMA_UART1	6
-#define EP93XX_DMA_UART2	7
-#define EP93XX_DMA_UART3	8
-#define EP93XX_DMA_IRDA		9
-/* M2M channels */
-#define EP93XX_DMA_SSP		10
-#define EP93XX_DMA_IDE		11
-
-/**
- * struct ep93xx_dma_data - configuration data for the EP93xx dmaengine
- * @port: peripheral which is requesting the channel
- * @direction: TX/RX channel
- * @name: optional name for the channel, this is displayed in /proc/interrupts
- *
- * This information is passed as private channel parameter in a filter
- * function. Note that this is only needed for slave/cyclic channels.  For
- * memcpy channels %NULL data should be passed.
- */
-struct ep93xx_dma_data {
-	int				port;
-	enum dma_transfer_direction	direction;
-	const char			*name;
-};
-
-/**
- * struct ep93xx_dma_chan_data - platform specific data for a DMA channel
- * @name: name of the channel, used for getting the right clock for the channel
- * @base: mapped registers
- * @irq: interrupt number used by this channel
- */
-struct ep93xx_dma_chan_data {
-	const char			*name;
-	void __iomem			*base;
-	int				irq;
-};
-
-/**
- * struct ep93xx_dma_platform_data - platform data for the dmaengine driver
- * @channels: array of channels which are passed to the driver
- * @num_channels: number of channels in the array
- *
- * This structure is passed to the DMA engine driver via platform data. For
- * M2P channels, contract is that even channels are for TX and odd for RX.
- * There is no requirement for the M2M channels.
- */
-struct ep93xx_dma_platform_data {
-	struct ep93xx_dma_chan_data	*channels;
-	size_t				num_channels;
-};
-
-static inline bool ep93xx_dma_chan_is_m2p(struct dma_chan *chan)
-{
-	if (device_is_compatible(chan->device->dev, "cirrus,ep9301-dma-m2p"))
-		return true;
-
-	return !strcmp(dev_name(chan->device->dev), "ep93xx-dma-m2p");
-}
-
-/**
- * ep93xx_dma_chan_direction - returns direction the channel can be used
- * @chan: channel
- *
- * This function can be used in filter functions to find out whether the
- * channel supports given DMA direction. Only M2P channels have such
- * limitation, for M2M channels the direction is configurable.
- */
-static inline enum dma_transfer_direction
-ep93xx_dma_chan_direction(struct dma_chan *chan)
-{
-	if (!ep93xx_dma_chan_is_m2p(chan))
-		return DMA_TRANS_NONE;
-
-	/* even channels are for TX, odd for RX */
-	return (chan->chan_id % 2 == 0) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-}
-
-#endif /* __ASM_ARCH_DMA_H */

-- 
2.43.2



