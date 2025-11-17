Return-Path: <dmaengine+bounces-7212-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D80C650EE
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id EFA2F28AA0
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2716E2C2372;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1cCgSQh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8C2C178D;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=N5TkUQNymhLcyTHXYiYE+acOECp8WgT1xvYpZpZI2J8CkoKWTcwxqRGTpE6+9ZX1JDfUjvq0H2AR0tUMHKgYA5dlyXZtTTHUg40cYUVi+xzlHxcQjCX6OQxs5P8sw1WIZu9kaDoLCj0pOD+mjTt9s8Vl5UXV/ESoQr81bOQIpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=JU5H6HzpmYMdelWGOYxXN2hreX6TM79xCo8vhX30ZwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DX6njqb3agu5t11McE3b8HPLD+grvvxfWCsGWGN/YJDWTQt8OB68a2kOjMvHpJ+VQO1rkThD3VRuKNfRgM2taLdzDpIplGRqku6wHg6uf9sIR/bDZQjmS09kRahElSx3z85jpSGlQW6Bb198gSUloCzea9wBVrH5MiZVU1Pg0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1cCgSQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8257FC2BCB0;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396004;
	bh=JU5H6HzpmYMdelWGOYxXN2hreX6TM79xCo8vhX30ZwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1cCgSQhfV0qhT6mFaFgEIkguoEpECx/rToTAYzsJqeGAIsE5m2pybvanaeEUoUme
	 00dTKQ2xl1xZqQ2DjkV4NhO26i+KWvVTHntCySEJ026fOT/gJAB7xxEHDpE5bUzvH+
	 DFIGA+BaP5S73IGZmh0L7mvgUAKdn+jpVblJyJCWRHAgn85AakDj6Md1R5P8zTpOJI
	 UYmu78bU+q/iFohmUdhSFILywTSug3d8g+pOE5TbbqLmpKoHsH36lQ2gd9bABfED/4
	 9yNNg720sJ+FuvR4v+c4bRqkr6VC+Zv+jR/63uxz9OClpYpLH4Zhluds8SyChyU3Qu
	 vqx7cDuhXJnNQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r0-000000002nU-1MKk;
	Mon, 17 Nov 2025 17:13:22 +0100
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
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 01/15] dmaengine: at_hdmac: fix device leak on of_dma_xlate()
Date: Mon, 17 Nov 2025 17:12:43 +0100
Message-ID: <20251117161258.10679-2-johan@kernel.org>
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

Make sure to drop the reference taken when looking up the DMA platform
device during of_dma_xlate() when releasing channel resources.

Note that commit 3832b78b3ec2 ("dmaengine: at_hdmac: add missing
put_device() call in at_dma_xlate()") fixed the leak in a couple of
error paths but the reference is still leaking on successful allocation.

Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Fixes: 3832b78b3ec2 ("dmaengine: at_hdmac: add missing put_device() call in at_dma_xlate()")
Cc: stable@vger.kernel.org	# 3.10: 3832b78b3ec2
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/at_hdmac.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 2d147712cbc6..dffe5becd6c3 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1765,6 +1765,7 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
 static void atc_free_chan_resources(struct dma_chan *chan)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
+	struct at_dma_slave	*atslave;
 
 	BUG_ON(atc_chan_is_enabled(atchan));
 
@@ -1774,8 +1775,12 @@ static void atc_free_chan_resources(struct dma_chan *chan)
 	/*
 	 * Free atslave allocated in at_dma_xlate()
 	 */
-	kfree(chan->private);
-	chan->private = NULL;
+	atslave = chan->private;
+	if (atslave) {
+		put_device(atslave->dma_dev);
+		kfree(atslave);
+		chan->private = NULL;
+	}
 
 	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
 }
-- 
2.51.0


