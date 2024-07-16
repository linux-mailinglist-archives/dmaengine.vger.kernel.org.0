Return-Path: <dmaengine+bounces-2703-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E03C9333B1
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2024 23:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0B71C22DD0
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2024 21:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C5273478;
	Tue, 16 Jul 2024 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUW+jcmq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511DF46522;
	Tue, 16 Jul 2024 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721165915; cv=none; b=GhPRapftUDguQN0cfs70a5/7TnPk+uVxuPE6LnpTJb7yThLa4TxydA/gm3vhH6qjogGicWQ7X9K51EO54OWYOaNkFW7OG/9quQZggOrPi8e6TMw44VXw0CJM/A1qvhWo9NYaxuxmMgwWGSpRqZWCTX4gDoYirTdRVEt+vUHgSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721165915; c=relaxed/simple;
	bh=s3argfT0bjT56iOArbsY0GzxvURpvlj8dSdXayAnGo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E1KnW5aQEoskmlx7+RKaiHXWgoWfKZCer8J68OXw5MjRpuAIQqv3U7P9Z1Qw7bvJJDTcaCL05wE11punpnBkGtrFn+nnCC2G/WhM64x1a6gpDkUeHGtCpxqktNnSuRqxq9jMyTobuO08kqY4mcwK+PaTbR7/nxRoyaHCyueQrik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUW+jcmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB571C116B1;
	Tue, 16 Jul 2024 21:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721165914;
	bh=s3argfT0bjT56iOArbsY0GzxvURpvlj8dSdXayAnGo8=;
	h=From:To:Cc:Subject:Date:From;
	b=cUW+jcmqnCG0IrFlXrXiG5XfhplLdmPDpmoLC62qovl97ix3YhOwFUAj98ha2vL2A
	 Dg6Uy+T+mG0v1w5TAr5cInRbJyKL5+9jEiE4QB5TY4erkqmkIfBYMGUDLukhJaGgGF
	 tTOfTWKAafXrKk5MH9u/pdwX1/2nZRuMa9v55AEc2pTlzsuFiE/v982X/j4tOEDXUL
	 eylO+JM4kJWwPnsKwsf1sEjgeN4CmPH9DGk7f98aFml5IqPC3cbfv1LHbwAqA0pg/I
	 mMu1Zcnjulhn6AdDYLDMo1AMZFDj0yCaUpqb1OA/ka+7iHU5xYMHYawoxhBwQb0oBE
	 1SeEAe1+diIYA==
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>
Cc: Kees Cook <kees@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] dmaengine: stm32-dma3: Set lli_size after allocation
Date: Tue, 16 Jul 2024 14:38:33 -0700
Message-Id: <20240716213830.work.951-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=kees@kernel.org; h=from:subject:message-id; bh=s3argfT0bjT56iOArbsY0GzxvURpvlj8dSdXayAnGo8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmluhZjVuTZVY4VuNVA9HyBDrilOXfvC/bv0t4D 77IyyEHNQOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpboWQAKCRCJcvTf3G3A Jj/0D/9PvSaesj4pRMPSiHXBTn/G/dt9EL9dWBSh2VkDcnpNnwHRa0MCb1KLQh+je5Tr27kb0en iQFv480u4YA/RKgn4DsO5czDWawVMnMcUK3v9DlFWhMdadEBzZYX/vyooYqIedRmwjg+qQVYQCS UCjHpsqGu3bgDvMTwHMZ1d0NVqXxdDK1DxWXiMdKem3bNLArIps5ic5WdCUTuDGK/AfTphwTnzW Ejybti4O6+eLNyj28ccYb724kuf5KYL0U2mktsSBn8nkP2H/ZolT4YNxgw72VnC2m13sMj0zz9e 2zwlZ34PzE7Ce8KKG2BEqAdZZYxh+HPPW0HQtmLqT3HEfP1v9wvrnaiEYSbRadMVdavcLXJfMSS RjoxqTou5N9PONYHLqhmuiqNwiE/kYKYN+Qtol5lXdasf1r7zitzs020sBI0BXH2rQHmei7aG4Z Fpxr8pCUQXU/DJJmIUhNRfI5FYK6jGN8mG3cLgZFhTxrZdzsJlICLSj9oV0tQE/dPuTcpnhAkpU Kokd76DCk4PQKu1X6F9iX8l99p0JPt4XNN/rSos3++hvRFbMaweJpcz/V+B6oxRRJfXChznHNir QItIsXDzAqqxAzTMs1S7TaMqXRGLGIhnF1d97O9zAzlMb02otRb19zZinSKmL9hKGWvuLX6ngdW HbGOqYVdMdTP7
 Hw==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With the new __counted_by annotation, the "lli_size" variable needs to
valid for accesses to the "lli" array. This requirement is not met in
stm32_dma3_chan_desc_alloc(), since "lli_size" starts at "0", so "lli"
index "0" will not be considered valid during the initialization for loop.

Fix this by setting lli_size immediately after allocation (similar to
how this is handled in stm32_mdma_alloc_desc() for the node/count
relationship).

Fixes: f561ec8b2b33 ("dmaengine: Add STM32 DMA3 support")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Amélie Delaunay" <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/dma/stm32/stm32-dma3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4087e0263a48..0be6e944df6f 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -403,6 +403,7 @@ static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_ch
 	swdesc = kzalloc(struct_size(swdesc, lli, count), GFP_NOWAIT);
 	if (!swdesc)
 		return NULL;
+	swdesc->lli_size = count;
 
 	for (i = 0; i < count; i++) {
 		swdesc->lli[i].hwdesc = dma_pool_zalloc(chan->lli_pool, GFP_NOWAIT,
@@ -410,7 +411,6 @@ static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_ch
 		if (!swdesc->lli[i].hwdesc)
 			goto err_pool_free;
 	}
-	swdesc->lli_size = count;
 	swdesc->ccr = 0;
 
 	/* Set LL base address */
-- 
2.34.1


