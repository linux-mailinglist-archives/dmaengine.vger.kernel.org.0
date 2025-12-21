Return-Path: <dmaengine+bounces-7855-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60539CD3C4A
	for <lists+dmaengine@lfdr.de>; Sun, 21 Dec 2025 07:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE620300A1C2
	for <lists+dmaengine@lfdr.de>; Sun, 21 Dec 2025 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E4A1EE7B9;
	Sun, 21 Dec 2025 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRbQfv5A"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4E13A258;
	Sun, 21 Dec 2025 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766299678; cv=none; b=n1LkcQVRLX33CWWDyuExohSK/0MZs76ZtVHWtt2UTheKCsF4ZVG8L1vTMzyzxDv/cKyF+1ZRh9MFVCoOaoEIN9DubgoBAcjtAKCHHk20MBDw5PoNCfcz2Okvk7MXEky+6DybYQFKeiapuA7Q6+ucYUwDu6b5wMbXjvRgR3Sg2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766299678; c=relaxed/simple;
	bh=dq4SjEE6XVIDRMreVqzrzH3io5MNY5o1sITwGmWprhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwL2LtZxz56r8s60j8+kR9lGCjW9ZJCSQ+i2hryoHihmUusw/Ipe8oUkZS6gGsyXQzRmuLVfUgA0uD8IVqOqZ769R12FQyx7bs8KSIpp0TUot9Z+IId4eDNHNz6bkVG2ZGopU3S1uvIIJpmywOIoAd/bhhBF0NN3N8ir9aupKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRbQfv5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96864C4CEFB;
	Sun, 21 Dec 2025 06:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766299677;
	bh=dq4SjEE6XVIDRMreVqzrzH3io5MNY5o1sITwGmWprhc=;
	h=From:To:Cc:Subject:Date:From;
	b=pRbQfv5A3j0G+9CBPGmKz1bqN+Wno5MhiZZTVaj09+xLi1etHeMCLlT+3tD55aY51
	 rk5KCqlSXv1c1HqjuWPvs0F7FbYjpVsUT36kZ2KJ28XMoLxYMRwkidtWB/faxPMFdr
	 qpk38TA6PWjqy9k7Z5FLp+474yB+TOzh552CszlCUOWNA2o3Dlr0umqOu4s7Ksho4h
	 lOGrf+Y03PE8iz6SFeCveZv+m9d6xmlEer9p8DklSzpifOGU8BntDvUdqQGQzzo2hH
	 xxBzyW2WoLjtcRpnJj0CdBedLi6wn/iH+Q2Jj+FvuqAQMRXz3KzgpX1ASoYJ+wnVSw
	 T29KUQcq3IcOg==
Received: by wens.tw (Postfix, from userid 1000)
	id 4AD3F5FDFB; Sun, 21 Dec 2025 14:47:55 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH RESEND] dmaengine: sun6i: Add debug messages for cyclic DMA prepare
Date: Sun, 21 Dec 2025 14:47:52 +0800
Message-ID: <20251221064754.1783369-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver already has debug messages for memcpy and linear transfers,
but is missing them for cyclic transfers.

Cyclic transfers are one of the main uses of the DMA controller, used
for audio data transfers. And since these are likely the first DMA
peripherals to be enabled, it helps to have these debug messages.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
Hi Vinod,

This patch seems to have fallen through the cracks.


 drivers/dma/sun6i-dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 2215ff877bf7..2e03c587bd2e 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -826,6 +826,11 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
 			sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, IO_MODE);
+			dev_dbg(chan2dev(chan),
+				"%s; chan: %d, dest: %pad, src: %pad, len: %zu. flags: 0x%08lx\n",
+				__func__, vchan->vc.chan.chan_id,
+				&sconfig->dst_addr, &buf_addr,
+				buf_len, flags);
 		} else {
 			sun6i_dma_set_addr(sdev, v_lli,
 					   sconfig->src_addr,
@@ -833,6 +838,11 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
 			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, LINEAR_MODE);
+			dev_dbg(chan2dev(chan),
+				"%s; chan: %d, dest: %pad, src: %pad, len: %zu. flags: 0x%08lx\n",
+				__func__, vchan->vc.chan.chan_id,
+				&buf_addr, &sconfig->src_addr,
+				buf_len, flags);
 		}
 
 		prev = sun6i_dma_lli_add(prev, v_lli, p_lli, txd);
-- 
2.47.3


