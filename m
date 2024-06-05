Return-Path: <dmaengine+bounces-2273-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797018FCAF1
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 13:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963FA1C227EB
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696A194A70;
	Wed,  5 Jun 2024 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpYfVibj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1201667C1;
	Wed,  5 Jun 2024 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588179; cv=none; b=i+ZtiG7GzA4cO+K1r3MBAs1YFKhzYp8ujq8KI864K84y8dLOeFuQiUhf24WnOFs2fjQqoALBZyT0A9vf4hqQp54v2k+igs0bDPfQwj9eDYvlAIEn65+oTyTaNuz/Weuxqs4LsNnVfJOWabB9ug9sva13/oCx4vnNFumzp3BO0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588179; c=relaxed/simple;
	bh=Qvyyt+366pQ234kcpBr110DHz4Z632wKKoIYCqa/E88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8eXOoMC3JVbYTs7gVhqkgKmuId1qhel8IzFZ/Q3N/xOiYuSjj8Z1HDT4E++0Ywk4t6v8Drvwmp7B6oGEli3cKLYBHula+3Ls6B7GeTSIU1AP1bOlqRA5/FOcQIjnqWtVgYoYNyeG3LuVrOmXM+60OnBRrdwKeIIJqeBlAb7Snc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpYfVibj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA643C32786;
	Wed,  5 Jun 2024 11:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588179;
	bh=Qvyyt+366pQ234kcpBr110DHz4Z632wKKoIYCqa/E88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpYfVibjeHy0U5w49kZqWFw0DGXed1l5ysLNe5LditXuEupPgLqoM0zhGy/BOznHg
	 BnTOIo5LPeZOElJiALsXhEso2sj/kqQhjzL/grRGNg9weHMCBkwsJA5ZdkJW2v9U2j
	 V6pn1RnINqGzVUXGf3HgPvh2pfQ0qF8zz+IbkURDO06UOdJS90AeMRmWgkfjuOg2aW
	 Ms/ajfmueo0GovbLkWG7OoMk7YoftWrPktO2RhGWxln3Hewqg02RHOkFuqHqERON30
	 waVH+VAx2+ZZODNZ9xhi0kqi+RF3gYp329WjGVGBJBGU8WbzCJC+bVxSPWBrErTlqQ
	 7cZs7sfdS6szQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Eugeniy.Paltsev@synopsys.com,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 06/28] Avoid hw_desc array overrun in dw-axi-dmac
Date: Wed,  5 Jun 2024 07:48:35 -0400
Message-ID: <20240605114927.2961639-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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
index a86a81ff0caa6..321446fdddbd7 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -302,6 +302,7 @@ static struct axi_dma_desc *axi_desc_alloc(u32 num)
 		kfree(desc);
 		return NULL;
 	}
+	desc->nr_hw_descs = num;
 
 	return desc;
 }
@@ -328,7 +329,7 @@ static struct axi_dma_lli *axi_desc_get(struct axi_dma_chan *chan,
 static void axi_desc_put(struct axi_dma_desc *desc)
 {
 	struct axi_dma_chan *chan = desc->chan;
-	int count = atomic_read(&chan->descs_allocated);
+	int count = desc->nr_hw_descs;
 	struct axi_dma_hw_desc *hw_desc;
 	int descs_put;
 
@@ -1139,9 +1140,6 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 		/* Remove the completed descriptor from issued list before completing */
 		list_del(&vd->node);
 		vchan_cookie_complete(vd);
-
-		/* Submit queued descriptors after processing the completed ones */
-		axi_chan_start_first_queued(chan);
 	}
 
 out:
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 454904d996540..ac571b413b21c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -104,6 +104,7 @@ struct axi_dma_desc {
 	u32				completed_blocks;
 	u32				length;
 	u32				period_len;
+	u32				nr_hw_descs;
 };
 
 struct axi_dma_chan_config {
-- 
2.43.0


