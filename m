Return-Path: <dmaengine+bounces-6885-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AFBBF2979
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E6E4273AD
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1389330329;
	Mon, 20 Oct 2025 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMSPhd9x"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1D33030B;
	Mon, 20 Oct 2025 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979714; cv=none; b=X6icC+lcxxN7D0ZW9Br3pjrQKAyYhEA3M4kc06D7u/hLDJmwrjUn27CEIZU2SDeCB52pA0xUBXiMy7dgeye9+ec2CHGH8gIOwYrX77g85bmHvN2WRSWviUaKrvVaRPZ9sHdxJ2LNP8fqDORNJY/IlKHFLJmRemoOtSQd+K/2U9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979714; c=relaxed/simple;
	bh=70yn7mGVqzvbk0wNOdWe6Ex6JjVwgt08GC05AbsLvbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EaiqdCwJWED4un/y2I3WKKnFho03z23VBVAIjrOVh9rmoMB2Mvz3WzB5e9W+pA2Bteb/ueIfvBYqBCNjWEDnTyWGi/nI7RV05QA8wK/IffqJ4nDdK58hm7SVBM2MDc7exuimkpPys46u1hUYLH+w5uow07PetqnkGWjT6PuyCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMSPhd9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E96C113D0;
	Mon, 20 Oct 2025 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979714;
	bh=70yn7mGVqzvbk0wNOdWe6Ex6JjVwgt08GC05AbsLvbE=;
	h=From:To:Cc:Subject:Date:From;
	b=fMSPhd9xOCtLOxZ69PwVB4aYYjeVU3UacJZITkzQYtPpjLh97/bDeOoPUL0YYxjo7
	 3CwUFQsThjTtW/55U1MVom3TiuwunCUtH2WX2ggtvpvP9eFyiklLq2iT9U2Fkt8jMh
	 v+7fr+6dwqSEkFZ+bvjZuRZsmGMDYaRVn25hf84eMfKJkS8ATOE3eBiAVqRNSqA4s8
	 +bczBe8MGOwwLstKdmY8+X2I54aUcFNBNrXGmWcsUWC1tohGGA0tfbHv0TYLfRJBjU
	 frOF7eWUnmtkdP2Wz/9gZN6+H68EMCNAM57MCjeMM7phH6/mLreW5zAinF27SV12dC
	 ZDU006Ku03gGA==
Received: by wens.tw (Postfix, from userid 1000)
	id B224A5FDC3; Tue, 21 Oct 2025 01:01:51 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: sun6i: Add debug messages for cyclic DMA prepare
Date: Tue, 21 Oct 2025 01:01:45 +0800
Message-ID: <20251020170147.2783867-1-wens@kernel.org>
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

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
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


