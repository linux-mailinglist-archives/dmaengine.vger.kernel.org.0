Return-Path: <dmaengine+bounces-7228-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E40C651D3
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0E414EF4EC
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1A2C3251;
	Mon, 17 Nov 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyqTXesj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89CE260585;
	Mon, 17 Nov 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396226; cv=none; b=duot/AURyscqozv91us+hKLkYe0k2OJk68DNAk7nfb/IjtJl9rIVlNTIZJWbtoVDg3MD6XZdHgmKXqQ7h7oPMq07+LwQ9kjkG7lOZhd/0du0yK2oJ0zoWtRwqU2yp79XR2DtTkfgEhHLWLQ3veJY2aTsEDatUpUCgKnOqiDjflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396226; c=relaxed/simple;
	bh=Mq/Dyz52gCUe7xZZ0HxDwp+4YFfjbjMO2jdJ+iiWz8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETI/2EwMK599/ntyQ7jifeYMRu+0v6M25jOp9I+xksJX/TNOPn/Xmw+cFnCw5xKNz+yEJsqYQAmWvT4S2Hg4bX25FSg5qBP+7giGWeLTP5s0wUOt79ke3B5XWOtcHC4QKBcBGQ2IjSSLkV2JFFZ0T0MGx23B6jvbetKLO9uwts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyqTXesj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3572DC19423;
	Mon, 17 Nov 2025 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396226;
	bh=Mq/Dyz52gCUe7xZZ0HxDwp+4YFfjbjMO2jdJ+iiWz8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pyqTXesjWOTKF7MX4hR++1eLjZ/vTY2FAnZmQI3ksgtU8GZc2LVTw96cgFCbBUtxc
	 gHpPvZ5ToRAVkCjJZXVIAWjYPW11J6qnxUEmsyaM7fvEBlq2q7vVVhG+o56tZx7G/y
	 h+WiRO9oM6yj2TyrSCtpVXQ8JEOVrGSkmTV0rGVbb1v8c7nRaJPt4l95PfM2vxYZDT
	 7SIE9IaSsy4cPcii6LHqvahzEbm3Y25IcbFY/6ISx8bmx1xWVwMij6WqtJJ0IjDr1q
	 QOOMqGOJp1CKQZ8EK4nJFr44+h2IPcHSIXSh3Fc0GoFMD84dgw6FBxlkp0XR2C2Uez
	 APAdSRzrfGqqA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1ua-000000002t9-0yBz;
	Mon, 17 Nov 2025 17:17:04 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] dmaengine: at_hdmac: fix size_t format specifier mismatches
Date: Mon, 17 Nov 2025 17:16:56 +0100
Message-ID: <20251117161657.11083-2-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117161657.11083-1-johan@kernel.org>
References: <20251117161657.11083-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix printk size_t format specifiers which did not match their arguments
to allow compile-testing on 64-bit hosts without warnings.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/at_hdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index dffe5becd6c3..c394bb00098b 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -887,7 +887,7 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 	first = xt->sgl;
 
 	dev_info(chan2dev(chan),
-		 "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
+		 "%s: src=%pad, dest=%pad, numf=%zu, frame_size=%zu, flags=0x%lx\n",
 		__func__, &xt->src_start, &xt->dst_start, xt->numf,
 		xt->frame_size, flags);
 
@@ -1174,7 +1174,7 @@ atc_prep_dma_memset_sg(struct dma_chan *chan,
 	int			i;
 	int			ret;
 
-	dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%zx f0x%lx\n", __func__,
+	dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%ux f0x%lx\n", __func__,
 		 value, sg_len, flags);
 
 	if (unlikely(!sgl || !sg_len)) {
@@ -1503,7 +1503,7 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	unsigned int		periods = buf_len / period_len;
 	unsigned int		i;
 
-	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%d/%d)\n",
+	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%zu/%zu)\n",
 			direction == DMA_MEM_TO_DEV ? "TO DEVICE" : "FROM DEVICE",
 			&buf_addr,
 			periods, buf_len, period_len);
-- 
2.51.0


