Return-Path: <dmaengine+bounces-4854-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B5A7EB04
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 20:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E36188B068
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655AD26B2DD;
	Mon,  7 Apr 2025 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R98a6ihT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B4255E2F;
	Mon,  7 Apr 2025 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049756; cv=none; b=Hn6uD4NwDn7iuhkIQrPbEky/Z3IFOzjl0dKtaxOC/Dbcezp4r6f+IX5Y/bW5xRL9Ypz+T6I/YyPX1ShmVDPOEH2T1nXPS/RbJ5jtkznM8uF41IGweYPWL4VAAjjcaLPFUlrLya2uQOWsUf93lqZrN3GZkm9eJegLQJ5OAir9Znc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049756; c=relaxed/simple;
	bh=GaY7QEA1UPQJrclhzlUM1rPMJWS9XZnF7605z8OzL/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mt3QDVW09JLfAP9SAEK1sW6fNivlDg9aM7sktFpmzvme/bzTAsJKNsvKZ9qCDpVkw7djDx4T2wApOHfViav5BLT+95GBIOET8ms0wPGwWCXqG1iVLczhf0Gf8ElT68fKdX3e0AIFMSjjHD97e4lSAnqIQ51wzGvJEfmFWeP95HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R98a6ihT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A69C4CEE7;
	Mon,  7 Apr 2025 18:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049756;
	bh=GaY7QEA1UPQJrclhzlUM1rPMJWS9XZnF7605z8OzL/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R98a6ihTSiuCb0XId7y9+tOpDKR3EVm8HmGF9ZlgG0I0iKYpCsRc2NB9pmH0EfPe7
	 MTCjALiHVvYbEbWIeaHByHnTXyPHnQ66Celv6U0BU6PdbyuIfHBipsWK3BaeUnuyUF
	 vomKoiWkNqH2IUNfOfcl9rhmEsJM1DXVT2hPlxLxiUUI/7uRJd87IK6ocdTdTM9CBD
	 C616x5E8ejeDU5qNupFCT5Ij6SyIwIfQLtO2f4SWRxgTEMNFaB1sfTeRb/XEmIZNKa
	 L/OzjFmP+vdIZldvMuCBEPrwgqJqVLP65tykL3YF72EAwVW+CDtS/x4cm50RjjG8xC
	 3icPaN1XVJdNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	kernel test robot <oliver.sang@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/3] dmaengine: dmatest: Fix dmatest waiting less when interrupted
Date: Mon,  7 Apr 2025 14:15:47 -0400
Message-Id: <20250407181550.3184047-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181550.3184047-1-sashal@kernel.org>
References: <20250407181550.3184047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index 238936e2dfe2d..6dfa1e038726a 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -809,9 +809,9 @@ static int dmatest_func(void *data)
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


