Return-Path: <dmaengine+bounces-2274-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEB08FCB60
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 13:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD0028B522
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7218319E7FB;
	Wed,  5 Jun 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIEPzoZ4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13319E7F9;
	Wed,  5 Jun 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588273; cv=none; b=edKQcy2Iqt9cEm+SA6r8yIFp4HpNoajnK8L4uBt0yrtr9EK69X8l/KXnRnMhLVqv3vQ1tf8sePJoJk4thRYknkFKYSeRhmN0lw+pP5n4wVfN2mPBkS4Hm16GZvem/LcQrvl7ErkBA2zCnTixO6Pa1fRxuIiMgb0dLIL74iSNDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588273; c=relaxed/simple;
	bh=Qvyyt+366pQ234kcpBr110DHz4Z632wKKoIYCqa/E88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4Ecj+w15hvqOxkqLNpZdm5RnfhntpNuK3ZfIKLYRKymgJ9p1rNfA3MHrZRZJJoau7kD9WTswfAKv01h/N7wrIUNjBBjMhU6R9M8H6Yhk6ChZXExPO0U4C4yeXcCvz8D1oZ4MxljoKkUKxk9qvCUKhu9wO748CXvsJFgHRckjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIEPzoZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0620C32786;
	Wed,  5 Jun 2024 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588272;
	bh=Qvyyt+366pQ234kcpBr110DHz4Z632wKKoIYCqa/E88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIEPzoZ4lLP5oX1NpW9IK5VaDiGgTjafm9qj/Z9hbeLBaJVATKQDt6+lXLXg1r9Ds
	 r8o73D/+RwGrf/vuWFL7ROqUuGpUPrTe4E0ExxvFi2rVM4J9mrDnsytZIMn+zW8Ajf
	 ozKJ416HCCYBnqove4lPJeuJIBYrAKVWTQAT8+yB7015bW4BE1d7NrbJs7CEYVwT33
	 KjHFro9mUhvdcqj8+k4z3bX7zSfOhvdCVJS7DGgaa5EZfvWXjFFIhd+IfSzsZWVxhP
	 L6hdX2evChPUaUlBeBoGKjWEAFCfif/cSAcQ0FjWcLcZzPr3YACEGTv4b0WwdP/6Ri
	 3GiUi6MStTkTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Eugeniy.Paltsev@synopsys.com,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 05/24] Avoid hw_desc array overrun in dw-axi-dmac
Date: Wed,  5 Jun 2024 07:50:15 -0400
Message-ID: <20240605115101.2962372-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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


