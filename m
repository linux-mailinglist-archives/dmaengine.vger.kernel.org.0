Return-Path: <dmaengine+bounces-4853-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086DCA7EAE5
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 20:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6577A5B85
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDBF26AAA2;
	Mon,  7 Apr 2025 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq3995Fz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2F26AA9B;
	Mon,  7 Apr 2025 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049742; cv=none; b=DRm318DOiIiH0Xqx93q7ugKFZBKJwErSK+sUW3MNvKKnOEsSuXtYmRuV2gja74oMEWbMH34hp7lpuVvY8nKNJRSyDQTomaJtN7oUs8/zMq3ZhPvrlFSlfmbJjtbWCxxxqcTJANv0qm8pygM/vMPLAxJenPwQ4r6S32/4D9wIMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049742; c=relaxed/simple;
	bh=bKU4fsm3ABdtwrGzO/jCO7MgFHkMrzVGZTc9c995lsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rK2JegtqKYij+tzJYlPbR0gyMgCzSYEdfueAeFFQfuO4Lxpk9TBdf0wXSvQdTaqhAuCsCedMdLxiv5HtP7R4/tlSQewinTWwFm+WI+ZrLeVuuH7AuerZXLg/upbZEraD5CCxAfLWHqTO5D0WOwiuR8lp0R7bqY3COj4398aI+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq3995Fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4A6C4CEE7;
	Mon,  7 Apr 2025 18:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049742;
	bh=bKU4fsm3ABdtwrGzO/jCO7MgFHkMrzVGZTc9c995lsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tq3995FziTlgJBRWg2zqJVmA+IjzR9fjEEycZX019iYDS1rx6Nc2YfrtsxOwrKmUP
	 HINx0lJn5GZAyre3TtgWVxyzhMFbN+sAaDdHZ4IIL4huawnAS2oUsrh5d2/+ZQsMus
	 uZp6t+3SzDPTvHhRJP0TiBW0WlmML8V0JEZhCIC0FXN9IAsGIxkuYLfh2VwofNrwoq
	 SiRyPrNBBNfMf8CTB2cuTuOfS5yiZkob4q41hTcObQplQnq4lBtSzVXU6g3OUsa86Q
	 WzTbj2lXRUvbVnATLEj5gI7bj0Dx5LM7MUCyBTR3BdL2ZPEEA1eELDD7w9vfNBFi5W
	 CoDdQjYcOtTTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	kernel test robot <oliver.sang@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/4] dmaengine: dmatest: Fix dmatest waiting less when interrupted
Date: Mon,  7 Apr 2025 14:15:32 -0400
Message-Id: <20250407181536.3183979-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181536.3183979-1-sashal@kernel.org>
References: <20250407181536.3183979-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index a3a172173e345..915724fd7ea6f 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -825,9 +825,9 @@ static int dmatest_func(void *data)
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


