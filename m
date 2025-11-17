Return-Path: <dmaengine+bounces-7220-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3394C650FA
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8C14F28CCD
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B91B2D063E;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsoCOm5A"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572772C326A;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=BU7Zqw1Lfw8n6mIDVhe43Froh6Y+B9x9RbVMM2eaHZtsH8dchMP6tJlmus6qvdOjrSW/kZkCbWr5kFbZjB1MaxkRSPkF5kUVVTyveMuunHOnuOH8K323nbsjby7lLb/Pyr9uDHTibPXa+UjnS+Sw1n+W0Lfj1hVARosRgYrkXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=6GuL0jGSTkjc+0hA4Khl/ddCHp/8iIPhZ1fuBFVHStE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxWmuJLVYz9zZAoCkJRAf3v2piVTPH60tnnMcKS6waq6DULbNkGByhkluHw6FAQGJT18qnm3UAVNIzAOfR5EpIqFmjfY2RYuLFLnTabARzSISMDhyY/AtdczG1VBc2Xkf315s/BapIkLe3U2q09GvxH4mPBs+14EkhpO6NhyjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsoCOm5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F58C116B1;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396005;
	bh=6GuL0jGSTkjc+0hA4Khl/ddCHp/8iIPhZ1fuBFVHStE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsoCOm5AoPtWQ7AxjyyjLkJqoPymDW6LgSyFrfuEEDcqQ7WN6D1fMpPtL5oUTsg+S
	 Qs7HAviy7B6bOQycgTjLs9VNuVP8EDU9mTm+54E4W4hTrIjttN+yv8Y3F3AdnTn+TN
	 gAp3CjAxNNLmzc9QLxUQAFRtyXTQpjyO3wS4TIBTV+a39YbFvsyJMdl0CPnX5UzAmo
	 veXlMGtyAXy+3fQkWOxjI/jStF6NqT9szCBZOpZ538jGW9sW4V7SJNe8N3OGaTK1Af
	 Sh8lvLqzQeVM528VVhb9jk3ewrNJCT2/hPjN0OFvNOuyZtUSbthvmO9gBWPdNgUPnL
	 RpOTJqTTEhEMQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r1-000000002o5-0sEj;
	Mon, 17 Nov 2025 17:13:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Subject: [PATCH 10/15] dmaengine: stm32: dmamux: fix OF node leak on route allocation failure
Date: Mon, 17 Nov 2025 17:12:53 +0100
Message-ID: <20251117161258.10679-12-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117161258.10679-1-johan@kernel.org>
References: <20251117161258.10679-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the DMA master OF node also on
late route allocation failures.

Fixes: df7e762db5f6 ("dmaengine: Add STM32 DMAMUX driver")
Cc: stable@vger.kernel.org      # 4.15
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/stm32/stm32-dmamux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
index 791179760782..2bd218dbabbb 100644
--- a/drivers/dma/stm32/stm32-dmamux.c
+++ b/drivers/dma/stm32/stm32-dmamux.c
@@ -143,7 +143,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		spin_unlock_irqrestore(&dmamux->lock, flags);
-		goto error;
+		goto err_put_dma_spec_np;
 	}
 	spin_unlock_irqrestore(&dmamux->lock, flags);
 
@@ -165,6 +165,8 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 	return mux;
 
+err_put_dma_spec_np:
+	of_node_put(dma_spec->np);
 error:
 	clear_bit(mux->chan_id, dmamux->dma_inuse);
 
-- 
2.51.0


