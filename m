Return-Path: <dmaengine+bounces-2277-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285FF8FCC2A
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 14:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004B12849A3
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8122A1B29D3;
	Wed,  5 Jun 2024 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED+4V6to"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6B1B29CE;
	Wed,  5 Jun 2024 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588462; cv=none; b=YYSjhTQkBlSKO//WOP13efUvWnrt18OHfHuVJGUKOgzw5bh1JWBnSbB9J6V4PrVVb3bFuKVku66vTdjeAnmNhV8zUEuh6HpFl7HjeBT9kg+JUD2Ugg9TbcHPFkZoQNGL3kvQlM+9EdxT7IRwfXgNxV6saJvXRbMofl5AqJPhrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588462; c=relaxed/simple;
	bh=SqE/7ZxjoRP7Qu6WCwbjJ2CVGqfrbJ5xVIFIQFVoSHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpEAffRVQRUMneFLwPYh/JyH21RyRBn0HTUfiP53J8NyA7I2CE2k0vJAhYLIQCgAFiUnBHj1grdxopJVK0ucPOY5AKBD2CFF1TyfP1VKtRgl3netgo23O7JvFiZ/MB0S31i+12g3N2pMajSafq3Hpckw1IM1GDbrfg8Gv0So9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED+4V6to; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094C6C3277B;
	Wed,  5 Jun 2024 11:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588461;
	bh=SqE/7ZxjoRP7Qu6WCwbjJ2CVGqfrbJ5xVIFIQFVoSHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ED+4V6tolaJx9JGgcTTMKy/Wc5F+MgETjZLWeP4AHOooB452dBNBMHXjH0kc7tpLN
	 5rtnrz7PvxA0XIUYtE0qhJ0SCen2t4oEiLtLkVYzjEYWYsrSW7KFEBO8TB4eE6qt3+
	 SxeaOa7feSyzu2pBHO2VK4MQ62Tc803dBoLMzwdPLq09yWvUE/GdqFhs0y2vPE+2zi
	 RXBWuvzvU01V6UycmxmBfpsWLxsNu9vv/qVbNbu2g/b/06DZIJpIPygkovfo9TzDNr
	 N0hodnRj2L2YJVzdIam6DMnh/6+U84egxzpsaiiiI1/BfnKswRjNNmRB/f9WD4djLR
	 FiWtVNrUmL8Gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Eugeniy.Paltsev@synopsys.com,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/9] Avoid hw_desc array overrun in dw-axi-dmac
Date: Wed,  5 Jun 2024 07:54:01 -0400
Message-ID: <20240605115415.2964165-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115415.2964165-1-sashal@kernel.org>
References: <20240605115415.2964165-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit

From: Joao Pinto <Joao.Pinto@synopsys.com>

[ Upstream commit 333e11bf47fa8d477db90e2900b1ed3c9ae9b697 ]

I have a use case where nr_buffers = 3 and in which each descriptor is composed by 3
segments, resulting in the DMA channel descs_allocated to be 9. Since axi_desc_put()
handles the hw_desc considering the descs_allocated, this scenario would result in a
kernel panic (hw_desc array will be overrun).

To fix this, the proposal is to add a new member to the axi_dma_desc structure,
where we keep the number of allocated hw_descs (axi_desc_alloc()) and use it in
axi_desc_put() to handle the hw_desc array correctly.

Additionally I propose to remove the axi_chan_start_first_queued() call after completing
the transfer, since it was identified that unbalance can occur (started descriptors can
be interrupted and transfer ignored due to DMA channel not being enabled).

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
Link: https://lore.kernel.org/r/1711536564-12919-1-git-send-email-jpinto@synopsys.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 6 ++----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 1 +
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index cfc47efcb5d93..6715ade391aa1 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -213,6 +213,7 @@ static struct axi_dma_desc *axi_desc_alloc(u32 num)
 		kfree(desc);
 		return NULL;
 	}
+	desc->nr_hw_descs = num;
 
 	return desc;
 }
@@ -239,7 +240,7 @@ static struct axi_dma_lli *axi_desc_get(struct axi_dma_chan *chan,
 static void axi_desc_put(struct axi_dma_desc *desc)
 {
 	struct axi_dma_chan *chan = desc->chan;
-	int count = atomic_read(&chan->descs_allocated);
+	int count = desc->nr_hw_descs;
 	struct axi_dma_hw_desc *hw_desc;
 	int descs_put;
 
@@ -1049,9 +1050,6 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 		/* Remove the completed descriptor from issued list before completing */
 		list_del(&vd->node);
 		vchan_cookie_complete(vd);
-
-		/* Submit queued descriptors after processing the completed ones */
-		axi_chan_start_first_queued(chan);
 	}
 
 out:
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 380005afde160..58fc6310ee364 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -101,6 +101,7 @@ struct axi_dma_desc {
 	u32				completed_blocks;
 	u32				length;
 	u32				period_len;
+	u32				nr_hw_descs;
 };
 
 static inline struct device *dchan2dev(struct dma_chan *dchan)
-- 
2.43.0


