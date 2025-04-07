Return-Path: <dmaengine+bounces-4848-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03136A7EA33
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 20:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0F1441C90
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBB825D21D;
	Mon,  7 Apr 2025 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7+SgSTr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0725D215;
	Mon,  7 Apr 2025 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049572; cv=none; b=tIj4PgcAXg84iuDXZnZjTtZyAkRrJozzLWtnTZphytFXMJM6w/J5aL1x/Fj50KW9XeZfU/F3NOvU6UO0sNjeiOtVNRUS2JCmYHCzp82x28uCJKj+DkNNtKE9mavJY5Hd32l6o0LBGEhCRq1BSAQyfx81Be+/dq5OkytO/YgdTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049572; c=relaxed/simple;
	bh=7fgsslfvBe3tzNlmDD3af8QNsw9Qtuj0fhgyeOJEPN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9kvK86a/hhsHMtZW1OUBTZdvjd6m2sWntqWz1Bb1LUaa261Z4w7l9eSQU6DDID1nxPZSMhS5zTUEKnanHglCztfa3sMlF8g7bEJpsK45cGxfPRFPxDLoRSHcpGpiILGG/mWK9ZWL5EiuHYUhYK34PMTf8ik86ejuI3wtBwUKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7+SgSTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2484C4CEE7;
	Mon,  7 Apr 2025 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049571;
	bh=7fgsslfvBe3tzNlmDD3af8QNsw9Qtuj0fhgyeOJEPN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7+SgSTrvXdSNQl0pos8E95niihgThoVAqPx1P5swC1Lb7amGYC1V/+eNrnoTHygI
	 I6r+1VlmMycdGkc8VNmSTJDBiZ0B8PXKo6VxBHtGI/lIwPzDVmmYdrFco4xfLAFn1N
	 4kGaqDhj7kY70OTvuXt0lXRfylylGL1oE5dkgDaAsVtVfhMwF9tdoQX3FhNe9oZ0r+
	 vmW9VjNJI8Lk3HsMIRakRXC/UTpucD5iFcYtoRb3UxtPjOTvWNm9BeIWtuQHHFNPfq
	 5A1UlLBDa4TycZQIEqBUDXOp3nZ9q0MT2B1EchEJ8UTaNQIyG30dGnox1vto8oYJED
	 XcrA0EA7Mz84g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	kernel test robot <oliver.sang@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 14/28] dmaengine: dmatest: Fix dmatest waiting less when interrupted
Date: Mon,  7 Apr 2025 14:12:04 -0400
Message-Id: <20250407181224.3180941-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
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
index 91b2fbc0b8647..d891dfca358e2 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -841,9 +841,9 @@ static int dmatest_func(void *data)
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


