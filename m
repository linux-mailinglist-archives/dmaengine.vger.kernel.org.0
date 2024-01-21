Return-Path: <dmaengine+bounces-772-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6678354C6
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jan 2024 08:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95A51C20A65
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jan 2024 07:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DBF364A2;
	Sun, 21 Jan 2024 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ch+cFsQy"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC946364A0;
	Sun, 21 Jan 2024 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705820425; cv=none; b=TOe1F39+YB3eV5tuFjNwj6sXX7NSXJ2PLIN+J/BKmg1cdzZeVj7RGtvN8kwa7azY2uL2tlp5fqVEscVkr11olsY0fHegO4imLimKcqlKmZuJWogyQyOWiON/cfCMFVlFnwcphrOggtwpXfM89ZPyToP7pM9aZkboHmvwQssjAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705820425; c=relaxed/simple;
	bh=we4FNiUjJnIGC37EiOVvIviIC5Y3lu2ss1MNi0OD9UE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3waG3kJkyVAbQUYg/keFFbZygrBj+467tcYC5y+dzAPbYI+8OU0gpX9UqzScnZ9bXS9uZIC8U3klAm2wyXcdIWX+QLEQqGJRMHgw0iaTgLy3LEasI/MfiAcg8C4puCC9j2VSIKDC3H4HCxmQf00r7Okd9mVLeHxbEPvuI6atyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ch+cFsQy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ViLFSGgTnFViD2oXyb+K2dtpJF8U2KZpqNpM8ttFUS8=; b=Ch+cFsQyDfdV6LqLCWJi0LTWmK
	R8LNC0OQr/YBWelCwjBdoGYodvzLZ5ty2bcjy57ScLubAN/ewzBzxBeODg3R2GP04uWZ0vPP4DYvj
	zh+Ddn4uKHe5f/NDnUHsEhkgerMlATkghHGUAk/PYCRFd0TTrfCW0g0wl+lZdDtPfY/soIh76w2q2
	NSRhbmZAvHNbJ5bfQ+AIyODQtvfwMTq/NRkADkNOmYQ2tsSbgw3zbslTQALrjQikhCT2k5KBuBURv
	g+ISCeJCumDCSSRVlLzDTfpMqeYAyJYFs43HZ/xxns2tEHf+3q69lVn0G26FUEBLleaXN5Mx6b2kB
	hc19k5NQ==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRRoc-008zF0-1r;
	Sun, 21 Jan 2024 07:00:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: at_hdmac: fix some kernel-doc warnings
Date: Sat, 20 Jan 2024 23:00:21 -0800
Message-ID: <20240121070021.25365-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some kernel-doc format warnings:

at_hdmac.c:243: warning: Excess struct member 'sg_len' description in 'at_desc'
at_hdmac.c:252: warning: cannot understand function prototype: 'enum atc_status '
ez
at_hdmac.c:351: warning: Excess struct member 'atdma_devtype' description in 'at_dma'
at_hdmac.c:351: warning: Excess struct member 'ch_regs' description in 'at_dma'
at_hdmac.c:664: warning: contents before sections

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/at_hdmac.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff -- a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -222,7 +222,7 @@ struct atdma_sg {
  * @vd: pointer to the virtual dma descriptor.
  * @atchan: pointer to the atmel dma channel.
  * @total_len: total transaction byte count
- * @sg_len: number of sg entries.
+ * @sglen: number of sg entries.
  * @sg: array of sgs.
  */
 struct at_desc {
@@ -245,7 +245,7 @@ struct at_desc {
 /*--  Channels  --------------------------------------------------------*/
 
 /**
- * atc_status - information bits stored in channel status flag
+ * enum atc_status - information bits stored in channel status flag
  *
  * Manipulated with atomic operations.
  */
@@ -328,8 +328,7 @@ static inline u8 convert_buswidth(enum d
 /**
  * struct at_dma - internal representation of an Atmel HDMA Controller
  * @dma_device: dmaengine dma_device object members
- * @atdma_devtype: identifier of DMA controller compatibility
- * @ch_regs: memory mapped register base
+ * @regs: memory mapped register base
  * @clk: dma controller clock
  * @save_imr: interrupt mask register that is saved on suspend/resume cycle
  * @all_chan_mask: all channels availlable in a mask
@@ -626,6 +625,9 @@ static inline u32 atc_calc_bytes_left(u3
 
 /**
  * atc_get_llis_residue - Get residue for a hardware linked list transfer
+ * @atchan: pointer to an atmel hdmac channel.
+ * @desc: pointer to the descriptor for which the residue is calculated.
+ * @residue: residue to be set to dma_tx_state.
  *
  * Calculate the residue by removing the length of the Linked List Item (LLI)
  * already transferred from the total length. To get the current LLI we can use
@@ -661,10 +663,8 @@ static inline u32 atc_calc_bytes_left(u3
  * two DSCR values are different, we read again the CTRLA then the DSCR till two
  * consecutive read values from DSCR are equal or till the maximum trials is
  * reach. This algorithm is very unlikely not to find a stable value for DSCR.
- * @atchan: pointer to an atmel hdmac channel.
- * @desc: pointer to the descriptor for which the residue is calculated.
- * @residue: residue to be set to dma_tx_state.
- * Returns 0 on success, -errno otherwise.
+ *
+ * Returns: %0 on success, -errno otherwise.
  */
 static int atc_get_llis_residue(struct at_dma_chan *atchan,
 				struct at_desc *desc, u32 *residue)
@@ -731,7 +731,8 @@ static int atc_get_llis_residue(struct a
  * @chan: DMA channel
  * @cookie: transaction identifier to check status of
  * @residue: residue to be updated.
- * Return 0 on success, -errono otherwise.
+ *
+ * Return: %0 on success, -errno otherwise.
  */
 static int atc_get_residue(struct dma_chan *chan, dma_cookie_t cookie,
 			   u32 *residue)
@@ -1710,7 +1711,7 @@ static void atc_issue_pending(struct dma
  * atc_alloc_chan_resources - allocate resources for DMA channel
  * @chan: allocate descriptor resources for this channel
  *
- * return - the number of allocated descriptors
+ * Return: the number of allocated descriptors
  */
 static int atc_alloc_chan_resources(struct dma_chan *chan)
 {

