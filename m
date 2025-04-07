Return-Path: <dmaengine+bounces-4849-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE1A7EA52
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 20:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EDA18889DB
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC2A262814;
	Mon,  7 Apr 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNwPEyKk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BDF262808;
	Mon,  7 Apr 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049633; cv=none; b=W4CznONV5lwOeFj1Y6zMoCWeiqKQ9mnp+NR+Nlda988W8tox5bGhGS4ve4Q3sQNaWiTN3HVz8WN/M5Bypfc77HhdGacUsowdT1/Rgl+MCL+5vH4fyX4U7GKufJuTsZpjCtLuOUH8lTILThzYL9LFm8y1TJxBaXPxWHgjXb28iK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049633; c=relaxed/simple;
	bh=7fgsslfvBe3tzNlmDD3af8QNsw9Qtuj0fhgyeOJEPN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/f6ViH0nQFjlTeGVue9Le8e6L6/McZ0kLBW6Id79CbAYpM1GjjAYwTO68OXQlEGym82Nt1FULZULke7i7L/ligwg26kC/SpzgnV1MceEpUe7E+DVce9QCoCmibZjKj1ymYDZX6WIKgF9kOSw1l75D5R18sxTI0PULZjDtFrJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNwPEyKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAA9C4CEE7;
	Mon,  7 Apr 2025 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049632;
	bh=7fgsslfvBe3tzNlmDD3af8QNsw9Qtuj0fhgyeOJEPN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNwPEyKkV+LB6WAnMbfLqPE9uOoBFOxdECTfwBOyuRh8/yXRErUFKro/aZjCDYW5y
	 86S7pwisFfINrdZYxgYsRVzhnZvP/Z/lsRUAhHMAmcaOfsCMprX+sT4HoZl5y1AJ37
	 6ltzNyzvW0O7GS9+a4//7zucYhG4p+if58MmPYOLsfyjp5leg/L5Pm9MsrZM3Rrs2c
	 dWtlw5N/4TZWg1yQdBXHTDdoduGzKR8lPf2xgBZ/V/YOsZuss8DOcDYIxapD8dgneB
	 sS1/M+4F+vm1DNyCNSBmPpTHumA/Kguoy8yedAMpFDYOtL1FpAmNmWvkSJkZ8GTc9K
	 mME/DgREIuqCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	kernel test robot <oliver.sang@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 11/22] dmaengine: dmatest: Fix dmatest waiting less when interrupted
Date: Mon,  7 Apr 2025 14:13:21 -0400
Message-Id: <20250407181333.3182622-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181333.3182622-1-sashal@kernel.org>
References: <20250407181333.3182622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
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


