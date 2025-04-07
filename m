Return-Path: <dmaengine+bounces-4851-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926B4A7EAFD
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 20:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CAC3AB766
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7BA222597;
	Mon,  7 Apr 2025 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8dwK1lF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A7267F53;
	Mon,  7 Apr 2025 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049702; cv=none; b=CEsG8pMc4gOsoyWH3q3PmpKFva3rHLid0TXmOFIYlhilNGj7oMF8rVcPkOud8DrfoUPsK9bEEeNXni4lDGqW7oRauYHpj8J1KKz19wVR8jRRRAm+EdiRl8qvCHsVkpL3pkvTOEWjxswNShjYQDhmkIollBaL0yhpMsBvbZPsSUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049702; c=relaxed/simple;
	bh=I7+BtqBSwD/aOxp3UhQs48Eo2OuppKK93/3YUDNmij4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dPT9f392G1ddVCTeAvkVdGRr97kry1fFZUDafZ2jEu2BF8HnVPtxqvlmM2REYlbqaWdYTjvfWLpH/16giNqbKBe9tTJCGqmopBRVIYTF9C/jiDdE039CDbeXU7tdvMTYCHzgUuyuA6IH6u9BqksunoaMW73rMGyvZUj7tPQw2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8dwK1lF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77348C4CEDD;
	Mon,  7 Apr 2025 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049701;
	bh=I7+BtqBSwD/aOxp3UhQs48Eo2OuppKK93/3YUDNmij4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8dwK1lF0iNB/lG2u47e560yglKy+1BVyn2hqmrKhJ4WGEXLUnDb0RFY1ATrq7xeC
	 810+abg8m9pOFiDgt8+PyFm2YFAt7spUHhOU4B4qDADaTjYR9cJlEdGHdd74spFWNF
	 lkYvEVdyct9Hl0vzF8BBtpKGcsfYm7QQAdzPmoZTg0t2PUgvE8/DfaxTndC+ur4G2z
	 fXrtykBzFOtRKJWCx7y78xSP9FAiMUE+mmDEFD1Fdw/YeJe5S3hnsAI2aRu0JRRl5i
	 qXwJtFp7APQm/WIJRlB+FRm4XoiYpm+eRkMyaEyd9KdGhjMyV6hCbNAXQ/f3PspjkK
	 +Mfx6KVQIcWSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	kernel test robot <oliver.sang@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/13] dmaengine: dmatest: Fix dmatest waiting less when interrupted
Date: Mon,  7 Apr 2025 14:14:40 -0400
Message-Id: <20250407181449.3183687-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181449.3183687-1-sashal@kernel.org>
References: <20250407181449.3183687-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
Content-Transfer-Encoding: 8bit

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit e87ca16e99118ab4e130a41bdf12abbf6a87656c ]

Change the "wait for operation finish" logic to take interrupts into
account.

When using dmatest with idxd DMA engine, it's possible that during
longer tests, the interrupt notifying the finish of an operation
happens during wait_event_freezable_timeout(), which causes dmatest to
cleanup all the resources, some of which might still be in use.

This fix ensures that the wait logic correctly handles interrupts,
preventing premature cleanup of resources.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502171134.8c403348-lkp@intel.com
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20250305230007.590178-1-vinicius.gomes@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dmatest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index ffe621695e472..78b8a97b23637 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -827,9 +827,9 @@ static int dmatest_func(void *data)
 		} else {
 			dma_async_issue_pending(chan);
 
-			wait_event_freezable_timeout(thread->done_wait,
-					done->done,
-					msecs_to_jiffies(params->timeout));
+			wait_event_timeout(thread->done_wait,
+					   done->done,
+					   msecs_to_jiffies(params->timeout));
 
 			status = dma_async_is_tx_complete(chan, cookie, NULL,
 							  NULL);
-- 
2.39.5


