Return-Path: <dmaengine+bounces-4852-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A45A7EB1A
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 20:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDCE420FC2
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0B269D1A;
	Mon,  7 Apr 2025 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcn9aMfe"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9F269D13;
	Mon,  7 Apr 2025 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049727; cv=none; b=g4LFWQu8KzoUADkOfhrNj+quEgKEHDC9nU1N2OXruLFkBHyEfxB5uwInC36bpGo+IDM/cbWz/watriNWzGMyZXeaqS/TD/jhCWiRMluT7stLpghfItmIqp4h4QQU91MTn+u7dZAbCgkSiWWlSUuP20e0zbkaseFOdtskud/NlnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049727; c=relaxed/simple;
	bh=wUD7pvsqiycf7WEiCUp5ChJ52uUqnZUapxNSi4IjGRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAZOIm0TrzT+63xBUdfVKu8AvySOoIDE1tM2T7/CTwQES3ez/R9ZmN1muB1Uhw4eKrACyEa13/KIWOH+MGHMNc1VFv/0VX84Q3mfRK85xyZWajqKrykvWyzpzlkF+MOWVqRMJR43DUg3UqAORGfz2wKn40ZobIqBKS/9fGM6j1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcn9aMfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5054AC4CEDD;
	Mon,  7 Apr 2025 18:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049727;
	bh=wUD7pvsqiycf7WEiCUp5ChJ52uUqnZUapxNSi4IjGRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcn9aMfeMlYSA0rMZDtoMMUr7i91jlVLwn1nv5UHa3eZmX/qBXoOrF8h/nI2j/wv5
	 UuxSEDf3VSNm1XcJWmtmsP5NCjI+U8v5t9FqowWv9RKRQtghJb7/Q3Vkbw+KdanIPO
	 cAaZYXq5cxXjieewrxrlGHK1kaZkw3wDee0g2bEVNYhIfD+h9QFuuwjbnrV+UxRe+P
	 b32l7KEnr79HxtOoBS+KA9O6GlQD4J+9D3rAsuVBm9VYp1hN70S7ikruuTKqufWX5M
	 0TUFiLLQ7cVVOornZ8DU1XUS8YlYDRVXK4rvOl0qZ+Tn3Z5OaGvHmmM7iY4IvL4LND
	 XP1f90ihd7eRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	kernel test robot <oliver.sang@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 5/8] dmaengine: dmatest: Fix dmatest waiting less when interrupted
Date: Mon,  7 Apr 2025 14:15:11 -0400
Message-Id: <20250407181516.3183864-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181516.3183864-1-sashal@kernel.org>
References: <20250407181516.3183864-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index f696246f57fdb..0d8d01673010c 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -828,9 +828,9 @@ static int dmatest_func(void *data)
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


