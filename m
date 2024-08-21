Return-Path: <dmaengine+bounces-2932-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 938FA95A31C
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 18:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62EF1C21A36
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A12192D99;
	Wed, 21 Aug 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OI5nBATW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7331613635E;
	Wed, 21 Aug 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258803; cv=none; b=Zh4JfbICRib7lMupYwzOQLcg/VYUEg+N8U2Ba1kBfv1eT7VyxDvIiW17NHxTVwJeC0NQpS4hTLNyxn+ZYGXgngMI/cI/agX+Uv5LKaNMIohBNgK6miyzSUo9fi0/QaaWocMs/tJDAfmr93QPPP7DrSc5t//vj7WI2Qj16vjiatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258803; c=relaxed/simple;
	bh=iMZObZERm4fJJ8crxvfeNEVv8zkTt+E2Sabqsr00by8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7mjvJpFavxkqdInBedkbBWANT1C0FmPsDOUdmo3B6N0jYxf4yoRNKpb53yzuDGzgIrzkaTEV3J3y8BA9wcgy2hnEP316ABSyjGG067UwPxVuteRofm5E+y9lQHvozokEipXPyxroziP3GUHLEcJsBHypyox+1d5+Z/OCrf3Ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OI5nBATW; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id goTksgXNgS3tRgoTlsOuWT; Wed, 21 Aug 2024 18:46:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724258797;
	bh=VF5cX0senQLhld6HFUuwDuqB5R9U72LTGbLDKI77h1g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=OI5nBATW1v1jnqi+ktVbRB12xo0MTD2GhllHXDWyLFIKAqeSArMoZ4OgeosnA2Mm3
	 H/a0JTA+6xxLhgYN6RACPNCx9l9U18mw7wKg9d4vS01nFEN94sELtvO1iz7k4XIB7M
	 pcuFoJqi2oFaEQmMlWnN6gPeyoTsGWUAHQH4sdaiHEnhTdsPZbOLRsZCUNllXWp+Gg
	 L8UGYWKQN6Wdq3MNgxpssNlO6oat9132SIQQtySxRYkLsBMxfT2nH5aM5BdWqpVBIS
	 qijCOf907gOmUxvad33VtvM4L0cYeH+H17KSP/nbLyswqaw9yhang9zcfolJWjyC9d
	 GaWieot2Aj8QQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 21 Aug 2024 18:46:37 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dmaengine@vger.kernel.org
Subject: [PATCH] dma: ipu: Remove include/linux/dma/ipu-dma.h
Date: Wed, 21 Aug 2024 18:46:33 +0200
Message-ID: <532e7e2816ccf226f3ab1fa76ec7873bc09299d0.1724258714.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When this file was renamed in commit b8a6d9980f75 ("dma: ipu: rename
mach/ipu.h to include/linux/dma/ipu-dma.h"), 4 .c files have been modified
accordingly:

  drivers/dma/ipu/ipu_idmac.c
  drivers/dma/ipu/ipu_irq.c
  --> removed in commit f1de55ff7c70 ("dmaengine: ipu: Remove the driver")
      in 2023-08

  drivers/media/platform/soc_camera/mx3_camera.c
  --> removed in commit c93cc61475eb ("[media] staging/media: remove
      deprecated mx3 driver") in 2016-06

  drivers/video/mx3fb.c
  --> removed in commit bfac19e239a7 ("fbdev: mx3fb: Remove the driver")
      in 2023-08

Now include/linux/dma/ipu-dma.h is unused and can be removed as-well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
$ git grep ipu-dma
returns nothing
---
 include/linux/dma/ipu-dma.h | 174 ------------------------------------
 1 file changed, 174 deletions(-)
 delete mode 100644 include/linux/dma/ipu-dma.h

diff --git a/include/linux/dma/ipu-dma.h b/include/linux/dma/ipu-dma.h
deleted file mode 100644
index 6969391580d2..000000000000
--- a/include/linux/dma/ipu-dma.h
+++ /dev/null
@@ -1,174 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2008
- * Guennadi Liakhovetski, DENX Software Engineering, <lg@denx.de>
- *
- * Copyright (C) 2005-2007 Freescale Semiconductor, Inc.
- */
-
-#ifndef __LINUX_DMA_IPU_DMA_H
-#define __LINUX_DMA_IPU_DMA_H
-
-#include <linux/types.h>
-#include <linux/dmaengine.h>
-
-/* IPU DMA Controller channel definitions. */
-enum ipu_channel {
-	IDMAC_IC_0 = 0,		/* IC (encoding task) to memory */
-	IDMAC_IC_1 = 1,		/* IC (viewfinder task) to memory */
-	IDMAC_ADC_0 = 1,
-	IDMAC_IC_2 = 2,
-	IDMAC_ADC_1 = 2,
-	IDMAC_IC_3 = 3,
-	IDMAC_IC_4 = 4,
-	IDMAC_IC_5 = 5,
-	IDMAC_IC_6 = 6,
-	IDMAC_IC_7 = 7,		/* IC (sensor data) to memory */
-	IDMAC_IC_8 = 8,
-	IDMAC_IC_9 = 9,
-	IDMAC_IC_10 = 10,
-	IDMAC_IC_11 = 11,
-	IDMAC_IC_12 = 12,
-	IDMAC_IC_13 = 13,
-	IDMAC_SDC_0 = 14,	/* Background synchronous display data */
-	IDMAC_SDC_1 = 15,	/* Foreground data (overlay) */
-	IDMAC_SDC_2 = 16,
-	IDMAC_SDC_3 = 17,
-	IDMAC_ADC_2 = 18,
-	IDMAC_ADC_3 = 19,
-	IDMAC_ADC_4 = 20,
-	IDMAC_ADC_5 = 21,
-	IDMAC_ADC_6 = 22,
-	IDMAC_ADC_7 = 23,
-	IDMAC_PF_0 = 24,
-	IDMAC_PF_1 = 25,
-	IDMAC_PF_2 = 26,
-	IDMAC_PF_3 = 27,
-	IDMAC_PF_4 = 28,
-	IDMAC_PF_5 = 29,
-	IDMAC_PF_6 = 30,
-	IDMAC_PF_7 = 31,
-};
-
-/* Order significant! */
-enum ipu_channel_status {
-	IPU_CHANNEL_FREE,
-	IPU_CHANNEL_INITIALIZED,
-	IPU_CHANNEL_READY,
-	IPU_CHANNEL_ENABLED,
-};
-
-#define IPU_CHANNELS_NUM 32
-
-enum pixel_fmt {
-	/* 1 byte */
-	IPU_PIX_FMT_GENERIC,
-	IPU_PIX_FMT_RGB332,
-	IPU_PIX_FMT_YUV420P,
-	IPU_PIX_FMT_YUV422P,
-	IPU_PIX_FMT_YUV420P2,
-	IPU_PIX_FMT_YVU422P,
-	/* 2 bytes */
-	IPU_PIX_FMT_RGB565,
-	IPU_PIX_FMT_RGB666,
-	IPU_PIX_FMT_BGR666,
-	IPU_PIX_FMT_YUYV,
-	IPU_PIX_FMT_UYVY,
-	/* 3 bytes */
-	IPU_PIX_FMT_RGB24,
-	IPU_PIX_FMT_BGR24,
-	/* 4 bytes */
-	IPU_PIX_FMT_GENERIC_32,
-	IPU_PIX_FMT_RGB32,
-	IPU_PIX_FMT_BGR32,
-	IPU_PIX_FMT_ABGR32,
-	IPU_PIX_FMT_BGRA32,
-	IPU_PIX_FMT_RGBA32,
-};
-
-enum ipu_color_space {
-	IPU_COLORSPACE_RGB,
-	IPU_COLORSPACE_YCBCR,
-	IPU_COLORSPACE_YUV
-};
-
-/*
- * Enumeration of IPU rotation modes
- */
-enum ipu_rotate_mode {
-	/* Note the enum values correspond to BAM value */
-	IPU_ROTATE_NONE = 0,
-	IPU_ROTATE_VERT_FLIP = 1,
-	IPU_ROTATE_HORIZ_FLIP = 2,
-	IPU_ROTATE_180 = 3,
-	IPU_ROTATE_90_RIGHT = 4,
-	IPU_ROTATE_90_RIGHT_VFLIP = 5,
-	IPU_ROTATE_90_RIGHT_HFLIP = 6,
-	IPU_ROTATE_90_LEFT = 7,
-};
-
-/*
- * Enumeration of DI ports for ADC.
- */
-enum display_port {
-	DISP0,
-	DISP1,
-	DISP2,
-	DISP3
-};
-
-struct idmac_video_param {
-	unsigned short		in_width;
-	unsigned short		in_height;
-	uint32_t		in_pixel_fmt;
-	unsigned short		out_width;
-	unsigned short		out_height;
-	uint32_t		out_pixel_fmt;
-	unsigned short		out_stride;
-	bool			graphics_combine_en;
-	bool			global_alpha_en;
-	bool			key_color_en;
-	enum display_port	disp;
-	unsigned short		out_left;
-	unsigned short		out_top;
-};
-
-/*
- * Union of initialization parameters for a logical channel. So far only video
- * parameters are used.
- */
-union ipu_channel_param {
-	struct idmac_video_param video;
-};
-
-struct idmac_tx_desc {
-	struct dma_async_tx_descriptor	txd;
-	struct scatterlist		*sg;	/* scatterlist for this */
-	unsigned int			sg_len;	/* tx-descriptor. */
-	struct list_head		list;
-};
-
-struct idmac_channel {
-	struct dma_chan		dma_chan;
-	dma_cookie_t		completed;	/* last completed cookie	   */
-	union ipu_channel_param	params;
-	enum ipu_channel	link;	/* input channel, linked to the output	   */
-	enum ipu_channel_status	status;
-	void			*client;	/* Only one client per channel	   */
-	unsigned int		n_tx_desc;
-	struct idmac_tx_desc	*desc;		/* allocated tx-descriptors	   */
-	struct scatterlist	*sg[2];	/* scatterlist elements in buffer-0 and -1 */
-	struct list_head	free_list;	/* free tx-descriptors		   */
-	struct list_head	queue;		/* queued tx-descriptors	   */
-	spinlock_t		lock;		/* protects sg[0,1], queue	   */
-	struct mutex		chan_mutex; /* protects status, cookie, free_list  */
-	bool			sec_chan_en;
-	int			active_buffer;
-	unsigned int		eof_irq;
-	char			eof_name[16];	/* EOF IRQ name for request_irq()  */
-};
-
-#define to_tx_desc(tx) container_of(tx, struct idmac_tx_desc, txd)
-#define to_idmac_chan(c) container_of(c, struct idmac_channel, dma_chan)
-
-#endif /* __LINUX_DMA_IPU_DMA_H */
-- 
2.46.0


