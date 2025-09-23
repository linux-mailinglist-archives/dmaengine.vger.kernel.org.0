Return-Path: <dmaengine+bounces-6693-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1CAB94F99
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 10:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79BB7A9559
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3AC3195EE;
	Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf8KS5ok"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78022874F6
	for <dmaengine@vger.kernel.org>; Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615788; cv=none; b=WIBlEJKohqiAJ0wj03cI5SDftwjuTRtQohjwzHBKG+btXCeCJZROEzNa/yYgxOlv+2eh9thdSkcWdcUlBYU9Z1SbVdaxl1hwkoGfcKl8z7WtEDfmO/SE5Zzp1j0wvflqdEgTYcRTzu+XgbNsVVJR+CgpISL7saF4trBy+qDgbaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615788; c=relaxed/simple;
	bh=Tj7ZIixF6JQzfqukU5d1HHPnGzBYc5eZZlBhX+MP9y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n+qt3VHHO0+uxv3fUHJhtMUc4V4mwd3WRYlWzLcL22+6f40nx+pMiV9zVl34Eo+QKxbmcB53lDw3KestYBdY8gGGb6czxl/R5vFLdot7QFS0NiNPu/Ks3qzZYrl7Fy2XL1qBdLukrt0HSLS4qh+91eG7eS82ZgPhDKFMErJWKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf8KS5ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88EAFC116C6;
	Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758615788;
	bh=Tj7ZIixF6JQzfqukU5d1HHPnGzBYc5eZZlBhX+MP9y0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Kf8KS5okHqH6pLB5hly4551PxSYUEW79kOrquMrtjWvqfVtn3XiQHf0jhmOsU8E2O
	 nQzPEbPIW91uoZa402yU6IIEz5N3jUJMcujLh39QCjLd48cyjaMobibuzMMCTdMtt9
	 rkZZ5mN4RxnKsDPxyD83fAYIeEuU9CVUQR5E2S7dpzBug8g9ldME7OPCxaLFBjoMoO
	 PK289zAaKl4Ez2kx2ufJIQkmNSO65rfFXV3hayqt5CCE43QPYUPTUzr72x3r3qwpdS
	 wfCmM+KRPEg3H7GhagJw7dzqq0lc1fAUl15hJJTCIkM1lQg4Lb//aL2z/hrAzxXjjZ
	 d6txqGy5ma1tg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79638CAC5A7;
	Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Sep 2025 09:23:36 +0100
Subject: [PATCH RESEND 2/4] dma: dma-axi-dmac: fix HW scatter-gather not
 looking at the queue
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250923-b4-dev-axi-dmac-fixes-v1-2-5896dcbbd909@analog.com>
References: <20250923-b4-dev-axi-dmac-fixes-v1-0-5896dcbbd909@analog.com>
In-Reply-To: <20250923-b4-dev-axi-dmac-fixes-v1-0-5896dcbbd909@analog.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Paul Cercueil <paul@crapouillou.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758615815; l=1232;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=4b9dcvl8c/l0P11QEVGkDqWnjYO8C6p4SEA8/PG0B24=;
 b=+C/tzslfewHJVs9tVxaLVN1RfA2OFiO9M5oqmx/Oa20eUoaw9AQpXpHT/6h4QkHgkVtec1hxs
 psWR4TopmJTCvJyzXhAnVUhzhwBDGCDU0rRAcKXv9fR76PEO4uS2Ylv
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

For HW scatter gather transfers we still need to look for the queue. The
HW is capable of queueing 3 concurrent transfers and if we try more than
that we'll get the submit queue full and should return. Otherwise, if we
go ahead and program the new transfer, we end up discarding it.

Fixes: e97dc7435972 ("dmaengine: axi-dmac: Add support for scatter-gather transfers")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index e22639822045f237ebcd1fa012a75bbe7dc536c5..0f25f6d8ae71fa73fb24c58b3e2ecfea452cd158 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -233,11 +233,9 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	unsigned int flags = 0;
 	unsigned int val;
 
-	if (!chan->hw_sg) {
-		val = axi_dmac_read(dmac, AXI_DMAC_REG_START_TRANSFER);
-		if (val) /* Queue is full, wait for the next SOT IRQ */
-			return;
-	}
+	val = axi_dmac_read(dmac, AXI_DMAC_REG_START_TRANSFER);
+	if (val) /* Queue is full, wait for the next SOT IRQ */
+		return;
 
 	desc = chan->next_desc;
 

-- 
2.51.0



