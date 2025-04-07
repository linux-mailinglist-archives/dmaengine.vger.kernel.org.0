Return-Path: <dmaengine+bounces-4850-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD7AA7EABC
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 20:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7CF4233DF
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15D526658B;
	Mon,  7 Apr 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHml4YnO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76BF26658A;
	Mon,  7 Apr 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049669; cv=none; b=tNPuwmb4JZ3w3LnVKWpxnvaiSJbRQFgO2IGnCoz6Kjy1N7WH4nTWV0mNi3AVdHJzl+4dy3PBf36I+JGjRbZhZQzg4Fnz7qPxTFmOjSRba9oU8umR3oGEA/T2JApDB1JD1MJtD5XQPxBjoqy2dxOA8sdfCgqWaMSzA6WjgQrhhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049669; c=relaxed/simple;
	bh=I7+BtqBSwD/aOxp3UhQs48Eo2OuppKK93/3YUDNmij4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jRitxVnyxFa2Ptd0cOqm6QDzmAKnOFmuwq8uhlduNPNsOM+k82besrCI5Y0loelVHU4WExaWJCjuhpIunjdMq/fEugtsvALe3Dfz6DxFqpufoZzwhS1736+2BYw11vgDai+FekLhtQSTI5VN8ppwJLLV6KlBynvZaKtapjFM92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHml4YnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD3EC4CEE9;
	Mon,  7 Apr 2025 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049669;
	bh=I7+BtqBSwD/aOxp3UhQs48Eo2OuppKK93/3YUDNmij4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHml4YnOVbk887Q8fbX3neI25y6KTzZ8y5OX1l0508tCHaIHFtaA9bZXgKxFPMBgY
	 N8xYLaEGGOfDBu3Yz+dseK6gHdEvmwpnEPD2JDp0Soa5kAjYGwCP90943JfRlBTTC1
	 9XqnBGhS+H4PP4jlZ67ARngBi/5uUrjHY56ExR4Jjx7wTZY9WNi7op9r9RdUf7Hr24
	 5pT/pgMj4IZ26TKaU62NgwBC83KSwPGFz0teMtXYLiHZ95uY4gHVX4NElMLu5ilza4
	 Pi2ewU3cU4W1zGF3tiZCHBgFyvgil2TSA2EcIjvCq3mlF5OEu7CGU/pXFsuUN6Oklp
	 FezWE92hcRh5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	kernel test robot <oliver.sang@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/15] dmaengine: dmatest: Fix dmatest waiting less when interrupted
Date: Mon,  7 Apr 2025 14:14:06 -0400
Message-Id: <20250407181417.3183475-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181417.3183475-1-sashal@kernel.org>
References: <20250407181417.3183475-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
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


