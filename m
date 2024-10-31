Return-Path: <dmaengine+bounces-3663-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6332B9B80E7
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 18:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C071C2182C
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA301BC9ED;
	Thu, 31 Oct 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Aw4PvA1C"
X-Original-To: dmaengine@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0EB13AA5F
	for <dmaengine@vger.kernel.org>; Thu, 31 Oct 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394709; cv=none; b=a/0qfRC7Kr+S+Mn4eKCW1DxRhOlHHorG0vnJFJglBG3lvIQbGtKzR3OGlGbYgFZNpOyvh4G3rsAfwiw8aP9BqyJOWmYd647INgj/fU0C1ijW8d0CHawl2MLaugQbE9xbvPZg36pFGmZOgcKR20j86WSa03Padm4Tr9sYp9PV1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394709; c=relaxed/simple;
	bh=ccgdBx+gp3rWzJ2AYB05d0k248DQqUz0U21kkt1Uk+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e10GxX4E+qxM1/fES7WWGaHi+Q8j2WE/Mr3giRn5Uq7qdSGj76EmvO2f9fCQyRX0HY/KDUGiXWCJoAono2IFjRA+YmWDqt99l5F9jUCsB0krX0FFVm3yrlyvj/Vzy2ZgqTN4uzVNqI/jH9UXDnPJ1QJLnl1ihH1GXdnX9CW3WFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Aw4PvA1C; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7534188E0F;
	Thu, 31 Oct 2024 18:11:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730394705;
	bh=RGjnkOVVS4NDxcQ+kwEob4qlblcbsVxOufgw7Bg+4Sg=;
	h=From:To:Cc:Subject:Date:From;
	b=Aw4PvA1CgYnP0YOZDvR2KMlCeM9u3OQkDWe113KcdMOMaF8RmrIzpDsT24s5vU7oC
	 cfA5BwEE0mWaDyp0iCsSWoAmg4Ew4EGeHO/Ar2+UeZvKqtQiqQcboTsNQKSJZtggXt
	 o8EUGl7mcp+5CI9kGDl8IFBhgvnAtZQHodhDKSTX2RZoSxCfGjOoTYajCT4dxGLe5g
	 v70DudY+apXooGPzQ2heVtl9Rpfp/DVeODA/p/MdhrcJDi0lK8cbwW5+0rYUxW8YS8
	 DD7F6obKtKNldfUIR8YmSLy9Ywdn0dHp0P6ccOwmcGZanqSQMWJ+PsRZeFHHecTKeV
	 MeC6kSFSnpU/Q==
From: Marek Vasut <marex@denx.de>
To: dmaengine@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Michal Simek <michal.simek@amd.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dmaengine: xilinx_dma: Configure parking registers only if parking enabled
Date: Thu, 31 Oct 2024 18:11:04 +0100
Message-ID: <20241031171132.56861-1-marex@denx.de>
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

The VDMA can work in two modes, parking or circular. Do not program the
parking mode registers in case circular mode is used, it is useless.

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
 drivers/dma/xilinx/xilinx_dma.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 48647c8a64a5b..87db381ff1286 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1404,16 +1404,18 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 
 	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
-	j = chan->desc_submitcount;
-	reg = dma_read(chan, XILINX_DMA_REG_PARK_PTR);
-	if (chan->direction == DMA_MEM_TO_DEV) {
-		reg &= ~XILINX_DMA_PARK_PTR_RD_REF_MASK;
-		reg |= j << XILINX_DMA_PARK_PTR_RD_REF_SHIFT;
-	} else {
-		reg &= ~XILINX_DMA_PARK_PTR_WR_REF_MASK;
-		reg |= j << XILINX_DMA_PARK_PTR_WR_REF_SHIFT;
+	if (config->park) {
+		j = chan->desc_submitcount;
+		reg = dma_read(chan, XILINX_DMA_REG_PARK_PTR);
+		if (chan->direction == DMA_MEM_TO_DEV) {
+			reg &= ~XILINX_DMA_PARK_PTR_RD_REF_MASK;
+			reg |= j << XILINX_DMA_PARK_PTR_RD_REF_SHIFT;
+		} else {
+			reg &= ~XILINX_DMA_PARK_PTR_WR_REF_MASK;
+			reg |= j << XILINX_DMA_PARK_PTR_WR_REF_SHIFT;
+		}
+		dma_write(chan, XILINX_DMA_REG_PARK_PTR, reg);
 	}
-	dma_write(chan, XILINX_DMA_REG_PARK_PTR, reg);
 
 	/* Start the hardware */
 	xilinx_dma_start(chan);
-- 
2.45.2


