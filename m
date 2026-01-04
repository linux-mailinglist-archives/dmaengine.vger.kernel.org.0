Return-Path: <dmaengine+bounces-8004-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C181ACF0CB0
	for <lists+dmaengine@lfdr.de>; Sun, 04 Jan 2026 10:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 865E2300A1C4
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jan 2026 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BDE25BEF8;
	Sun,  4 Jan 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kti7j3mb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5322F772
	for <dmaengine@vger.kernel.org>; Sun,  4 Jan 2026 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519337; cv=none; b=M9zpFZcox56JNjxBoruaa3kCkNGFayPyX9ZR7n/zGi48ONVZ8pt/L1f12ApKQsURxW16Femz/lVk8Hpy1fFR0TOrgX+LH1QHTWrV4Ji7nJHOYcAyX4VO4Iwxbh5eh0ua8RMIQHLQMkGjDGl4GK1VaEfWifCnJAl/85I7Np0ENPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519337; c=relaxed/simple;
	bh=SuFOO/tNySxoNgXbPXHSomgCAtOj4ixZJQRd+GaxQDE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t1tTgPTY8o6ff6KOyp5ywtRchMmZfXWiRTBW0ZeYv2Df5wlCmpeQ7DAKvo6n0GogjZJtlxbOMdVn07W3IKmhuVmi4qzsge3qIEEF115wwljHA6gt5i5QSinwrmWPZ81hTqrg0yVIzFRT78kN0+wEf4j8WNxqqX7zD1YkvUa/xyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kti7j3mb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0d52768ccso164067465ad.1
        for <dmaengine@vger.kernel.org>; Sun, 04 Jan 2026 01:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767519335; x=1768124135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l37PyB/W+FDuQ2CynzBQFMBqus2VgISaBdkZtBkXNYU=;
        b=Kti7j3mbUh6R1T+EtI9e9N5mBSq++rX2OQJr7a11vQ90p0oR7AYn7Xsys3wMyohYYF
         FMg8kCo6LK+xeTOG494ign08P1Gp7v/3KcsLmXHy+6iDNrSCcnOTVXmXOnrroTa/HDMp
         b4ns+sn1Mk1eI9ts6a+NJ0JBTUgD8ZyPQyKaiBP7gr6Q7CU1bGzhmnhb3WoMAHJ5E3aL
         KjZn1f/xmK8vXL6htDjnTj7OXQ9rM4zOIm1WKPfmaJWpOnWZRwJ4QSKuS7vvblSzeSq6
         SVaMYwE5zvVKHg9kc61aplgB2i62uJc9lj0Hd5DFSyJ8jTLWL+kyll15qesbqRccKKL+
         InnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767519335; x=1768124135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l37PyB/W+FDuQ2CynzBQFMBqus2VgISaBdkZtBkXNYU=;
        b=jgf02Uolbp/48eVBu72wWeC6nNV6jv9dfu32WEbq0mxckAXAouQwuA2KhtrmdtNUu6
         wFCGEROiiST6q2N3A3mVFjArhsbObUb+VEqleU9qOh4bwlezzy19T7qRsOcYo1ZpwBn3
         ExD9QmZqPcurA/DwghVlLkuT2LrHL0KG3VFVi12MgluBv4SP3vHBn8maLj792F4fApfq
         ea4w69AY8mNzpOqi3HpCFwj2GRYlwPylcDJL70vpl+Ho+iEJPw44vJO60vTpPHrb3AvE
         ttmTvMf6iyFn9hRqJsQ1Ln3j0vbIWyInlAd58Tz0d6bUwGIFigRZ2H2Eq67jFtZvpuP3
         MDnA==
X-Forwarded-Encrypted: i=1; AJvYcCWXzGyMG51m+DbErq3SI5aj0QWvQrx8ZZu1X0GubUNCePtobh6EyBRgdMu9MsYihXswOKcovBE4uHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaUUCsM6dEyholb93t8J2GLbMI3V0mW/EN1WEP3dYFE3jyP3h5
	Bvx32IcR69irXoZgqVX3OhZkV5QjWRILkIrqqLgS2etJY8tz45wtbk66
X-Gm-Gg: AY/fxX7m5Z+x23KeflXlwNEF1hW4XfDlHjLbdzZbvVLz17HJZZA40qjddXpobh4OIxY
	G9r3aUydpA+WFJZIKrCspCfE/7Z+DOiCFVEV/ydCJjES9/lWJi7aoDZaGs5PL7TNaDli4BMotM6
	TPgrER7gvVJrk14Egkf6qRIEsEjfIUJVk6nz86U8TSF+NEk2RLLiZF6JWhrVOsFQXDl2IjEollm
	SgO1UnKFVdzyftHubnUSPUmtrHvWnLyWh/Kt3PREoYLsUGViUJ8EMmwdfIMJ54wd/v8xgFygV7+
	TfdFLigKwmIIiehPlYT5Lo0174r+pzj8ELbqIaMFjwwEhcq7vQVUiqaniInBzPx+UjEnym1952k
	9C75lmrnbeQ1VGQM17ykwXtbZNaPM2HNXqbxF/2h11q5ult4QkNQZnSw5ttdKQoHtfOfqgwcT0B
	HkKX4zatS4sjtNPNcHZNWHNLcT+tTOFsph8IE=
X-Google-Smtp-Source: AGHT+IHrtadIdvCnb84ZovbrmnJBPh89J+gLlQqCflxPNThF2rz+Kh+bAU2dRDpzA/sQbxFYkDnhjw==
X-Received: by 2002:a17:903:284:b0:299:e215:f62d with SMTP id d9443c01a7336-2a2f2202faamr485342125ad.5.1767519334877;
        Sun, 04 Jan 2026 01:35:34 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476ec328sm3469546a91.2.2026.01.04.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 01:35:34 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH 1/1] dmaengine: dw-axi-dmac: fixed alignment, blank line and not useful return warning
Date: Sun,  4 Jan 2026 17:35:29 +0800
Message-ID: <20260104093529.40913-1-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the scripts/checkpatch.pl warning in
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:345
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:356
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:422
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:494
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:597
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1167
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1456
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1650

Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..501d3342414a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -342,8 +342,8 @@ static void axi_desc_put(struct axi_dma_desc *desc)
 	kfree(desc);
 	atomic_sub(descs_put, &chan->descs_allocated);
 	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
-		axi_chan_name(chan), descs_put,
-		atomic_read(&chan->descs_allocated));
+		 axi_chan_name(chan), descs_put,
+		 atomic_read(&chan->descs_allocated));
 }
 
 static void vchan_desc_put(struct virt_dma_desc *vdesc)
@@ -353,7 +353,7 @@ static void vchan_desc_put(struct virt_dma_desc *vdesc)
 
 static enum dma_status
 dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
-		  struct dma_tx_state *txstate)
+		   struct dma_tx_state *txstate)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	struct virt_dma_desc *vdesc;
@@ -419,6 +419,7 @@ static void dw_axi_dma_set_byte_halfword(struct axi_dma_chan *chan, bool set)
 
 	iowrite32(val, chan->chip->apb_regs + offset);
 }
+
 /* Called in chan locked context */
 static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 				      struct axi_dma_desc *first)
@@ -491,7 +492,7 @@ static void axi_chan_start_first_queued(struct axi_dma_chan *chan)
 
 	desc = vd_to_axi_desc(vd);
 	dev_vdbg(chan2dev(chan), "%s: started %u\n", axi_chan_name(chan),
-		vd->tx.cookie);
+		 vd->tx.cookie);
 	axi_chan_block_xfer_start(chan, desc);
 }
 
@@ -592,8 +593,6 @@ static void dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool set)
 			(chan->id * DMA_APB_HS_SEL_BIT_SIZE));
 	reg_value |= (val << (chan->id * DMA_APB_HS_SEL_BIT_SIZE));
 	lo_hi_writeq(reg_value, chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
-
-	return;
 }
 
 /*
@@ -1164,7 +1163,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 		axi_chan_irq_clear(chan, status);
 
 		dev_vdbg(chip->dev, "%s %u IRQ status: 0x%08x\n",
-			axi_chan_name(chan), i, status);
+			 axi_chan_name(chan), i, status);
 
 		if (status & DWAXIDMAC_IRQ_ALL_ERR)
 			axi_chan_handle_err(chan, status);
@@ -1453,7 +1452,7 @@ static int axi_req_irqs(struct platform_device *pdev, struct axi_dma_chip *chip)
 		if (chip->irq[i] < 0)
 			return chip->irq[i];
 		ret = devm_request_irq(chip->dev, chip->irq[i], dw_axi_dma_interrupt,
-				IRQF_SHARED, KBUILD_MODNAME, chip);
+				       IRQF_SHARED, KBUILD_MODNAME, chip);
 		if (ret < 0)
 			return ret;
 	}
@@ -1647,7 +1646,7 @@ static void dw_remove(struct platform_device *pdev)
 	of_dma_controller_free(chip->dev->of_node);
 
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
-			vc.chan.device_node) {
+				 vc.chan.device_node) {
 		list_del(&chan->vc.chan.device_node);
 		tasklet_kill(&chan->vc.task);
 	}
-- 
2.43.0


