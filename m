Return-Path: <dmaengine+bounces-855-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C4B840B54
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 17:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557751C2292D
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1087157047;
	Mon, 29 Jan 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z/PZCM9X"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4115696E;
	Mon, 29 Jan 2024 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545572; cv=none; b=JmprdtgxrHKNl+pN8eyCPADhrZQfjyaLC7Bkz4YAbLSZQ0br4jR2vGCgy2nTa8GgrwD9xM2oF8BssMsivdOEnrTIA8ph7KlE3FDTRYkd/1LGVHGJs9GhuvlEPQmVa3mIABmOEhWD7t3dmHZ6MEYjehCHG/wT2+QEbwvzyan8Upk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545572; c=relaxed/simple;
	bh=x47cesg/6O6mFEGId7nMSQjKtzbnwyjiAJgM1rfNKwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vgupcv1aGY4EQEHJQIsYRfkUppTej8Mawib14bdRkixk9keeac10CDutaCMuePIqFgpXXcmS/JrqmYEwIEX5nxFsKqkNPaej98PvjnRBdeWkM6I6V3zk9frC9R1WFnlUBK3jjMN2SbpUSj3g3cXGlfb99jk8B2aytClKjleqGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z/PZCM9X; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 48A5FE0013;
	Mon, 29 Jan 2024 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706545568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppALPMc1pFTIFQzwRMW+tmzwmtQj10e6/dO7SG+F1wI=;
	b=Z/PZCM9XZQ+0pHNBkgC7DcZmmNkE0NvU9jCHkgzF3yWHCmxDNzwo50FZTQx3XS4TiPgOWe
	bpieuxk7/MuoiNSEuY17Fu0fn8Mlaw/BDC7HvL8nHPUM7oIym0S1XeqsIipMIi1KU/3Iz6
	zLsS3/chykKR6FJ1GduyBpiw5NSnbp5TaQ8S4do5O50RYxfM0qD3aqmwg1DHWRZMXSEliq
	4S/VF6Zsi3wiSkBiEMsq1FIb19qQtldI/PmKWxoXD70n4nXTUDCZO58nRuoYTZzIy3UvyL
	Ucl/pm4GiwBcewYVcDeCOQrfaxH9G5lhQJBkKqE8msGclGxL/61lRZaW69wciw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 29 Jan 2024 17:26:01 +0100
Subject: [PATCH v7 5/6] dmaengine: dw-edma: HDMA: Add sync read before
 starting the DMA transfer in remote setup
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-b4-feature_hdma_mainline-v7-5-8e8c1acb7a46@bootlin.com>
References: <20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com>
In-Reply-To: <20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Cai Huoqing <cai.huoqing@linux.dev>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Herve Codina <herve.codina@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

The Linked list element and pointer are not stored in the same memory as
the HDMA controller register. If the doorbell register is toggled before
the full write of the linked list a race condition error will occur.
In remote setup we can only use a readl to the memory to assure the full
write has occurred.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Move the sync read in a function.
- Add commments

Changes in v4:
- Update git commit message.

Changes in v6:
- Fix comment typos.
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 04b0bcb6ded9..10e8f0715114 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -222,6 +222,20 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
 }
 
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+{
+	/*
+	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internal
+	 * configuration registers and application memory are normally accessed
+	 * over different buses. Ensure LL-data reaches the memory before the
+	 * doorbell register is toggled by issuing the dummy-read from the remote
+	 * LL memory in a hope that the MRd TLP will return only after the
+	 * last MWr TLP is completed
+	 */
+	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chunk->ll_region.vaddr.io);
+}
+
 static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -252,6 +266,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	/* Set consumer cycle */
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
+
+	dw_hdma_v0_sync_ll_data(chunk);
+
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }

-- 
2.25.1


