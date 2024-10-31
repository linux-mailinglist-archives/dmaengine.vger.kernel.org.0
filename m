Return-Path: <dmaengine+bounces-3662-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8399B80B9
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 17:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DA61F21BFB
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00191B5ED6;
	Thu, 31 Oct 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="e/KVZ0d5"
X-Original-To: dmaengine@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F11A0B00
	for <dmaengine@vger.kernel.org>; Thu, 31 Oct 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393932; cv=none; b=h0BpWAvS+GyLPzWbKzP3x8CEz2OVV5SRQFYmboWhuV4BXj5FOF3/7ZvF4u+NprNRf5HmisyFNRUCYYfKLlbTOL9BM6P+Xv64JW1KpzF7V8mSYL5ZlGiz6cbMjyMWOQtdauJJizyamOqsXeXhczCrTW1N9Gi7KQKh0XWyH9CvncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393932; c=relaxed/simple;
	bh=6aEflDDZo6uaaBK1+9nl6iBRHsLoC+VYGmB5kVNq+xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VzXeuEfRTFTeUYmoLlbZZX8pN7GOoDXc1YN8ppJ6h3Y2yFqAXgoSMRfVZlGAkT0UITJZo2CBMlTImx5bZosu7CHuDT/h4OzzCrU4Qri4LY+hVMd3y6Nofp5ZzirFcQRQSZ5NLIHChrG+1u4qY0AW3LMjO+PQCIVUfKbvTG9hlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=e/KVZ0d5; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5A7CE892B5;
	Thu, 31 Oct 2024 17:58:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730393928;
	bh=rNPcUKdGGxyVAjLTUAVNJvowXUyU1UZgOz+u8/qucgg=;
	h=From:To:Cc:Subject:Date:From;
	b=e/KVZ0d5hriqIOOnMRtFr+JjxtQMCsMib6CaeN8DeHUAt0tBFrgLJqcTZgQI9txxv
	 NgkDS8PY1emtfD885Ya51vF//LwD5DO6iA8o311SOEpOSloZ8ttWrmoWwhdq+a8qH1
	 Dtb7VyuZfQiWArb1ABVg4cEymhZPMO8bdq4vSHm+1AxggXh+ZIVG4cQVnhxi9Dy7UD
	 IjwJt7BG691JTgO1xQUMT7KtC8RlW+Lq9wcFawDA58p46FCTvMFXaPAr+MaLnzz/1z
	 w51rFbjbOCE4b6MNuDwrL76l0PZH+PCufIVlHKMU7jOMOaInl9ZvB1qpiz8oHzAmrR
	 oPo2el9xfsp1g==
From: Marek Vasut <marex@denx.de>
To: dmaengine@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Michal Simek <michal.simek@amd.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dmaengine: xilinx_dma: Fix freeup active list based on descriptor completion bit
Date: Thu, 31 Oct 2024 17:58:20 +0100
Message-ID: <20241031165835.55065-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The xilinx_dma is completely broken since the referenced commit,
because if the (seg->hw.status & XILINX_DMA_BD_COMP_MASK) is not
set for whatever reason, the current descriptor is never moved to
the done list, and the DMA stops moving data.

Isolate the newly added check to DMA which does implement irq_delay,
that way the new check is matching what is likely some new bit in a
new core, without breaking the DMA for older versions of the same
core.

Fixes: 7bcdaa658102 ("dmaengine: xilinx_dma: Freeup active list based on descriptor completion bit")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@baylibre.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Peter Korsgaard <peter@korsgaard.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/dma/xilinx/xilinx_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 1bdd57de87a6e..48647c8a64a5b 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1718,7 +1718,8 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 		return;
 
 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
-		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA &&
+		    chan->irq_delay) {
 			struct xilinx_axidma_tx_segment *seg;
 
 			seg = list_last_entry(&desc->segments,
-- 
2.45.2


