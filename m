Return-Path: <dmaengine+bounces-2698-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB5393102E
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2024 10:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C98B216E8
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2024 08:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECDF18732E;
	Mon, 15 Jul 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM2yj4ZE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7D187328;
	Mon, 15 Jul 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032805; cv=none; b=nKVnnc4C0OqZaI1JPgnqtrgksV5ULGy4baV4Rn+5oDmlJKap6TVBVL/txjhVqBdka3MYlV8b62LZzrFvVoWIskrgd9veRp04klynWbDhfzXNp5ojrcePUPy8a3ikxC6lPcmz+gH83JrZltR4Fp+PQsL6uU1dbtuDMhlcHc+T/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032805; c=relaxed/simple;
	bh=y2IxKtzUhXnXpBUVRkzQENsuJPq31K5nZgVywAEhZnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBap0JPHAiYqTfnVo1fpyr771owjYXLYkzNnm8HhmqATqscygdre0Bn2LVMCqRC+e0ingw9YG+/1XkNXFzUTAO6iYxahpue1inYkCTsF0q+qwxJ/KXET5hUgl2hEdUyQ0yL0f59Dc+0Pc+Vs4IahzPW2lVo1g50JKB/XJRVIGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM2yj4ZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85C7CC4AF10;
	Mon, 15 Jul 2024 08:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032805;
	bh=y2IxKtzUhXnXpBUVRkzQENsuJPq31K5nZgVywAEhZnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CM2yj4ZEAoBnzkYdHYoX2kh+N2QiXUApUkja7V5RTKDaruHXmVqN7wK6FQC8aVDFQ
	 YD3WDjSyJWDo+MPfcTMuN8yhDIUMIVa0q+078gtdXapCF8THaFxEFtNV7VmV5SFYQ0
	 7W0UYlXKX/EzRBRsbseWk2uvXOvhzt3U69+bJ3/u/BZJrwFzP22c5ExpCdUCg+2dkt
	 2ApVrt9jWGuZOss9c3blzuk20dDlyu3RDn6KlFG9qw5Y2oU33+o44YYZi1WocAU4ow
	 TT5sztkgTW1kYwxSvIJ/kDNhaWJf+13cavRCW4a93cvemLDdSALX42kS15qNTTQPSC
	 WWJ1bvmBoV6kQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B87FC3DA59;
	Mon, 15 Jul 2024 08:40:05 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 15 Jul 2024 11:38:42 +0300
Subject: [PATCH v11 38/38] dmaengine: cirrus: remove platform code
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-ep93xx-v11-38-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
To: Vinod Koul <vkoul@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721032800; l=6076;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=qbQ0k1cwlr7iv0JKjGQW+rzyy6spZcOEIpiufkU6/UM=;
 b=WMPqh1SifiYBS+sJ0DL54/q99WbOs4Le3kfFcKidpOt9cYcsyAdMSSBp3iiVGliA8eIQACJHzVhy
 zEvvtsjzDmu9h8asVynI1LQl2jcf5itdK8xgiPs4J09Sh7dYiylm
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Remove DMA platform header, from now on we use device tree for DMA
clients.

Acked-by: Vinod Koul <vkoul@kernel.org>
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



