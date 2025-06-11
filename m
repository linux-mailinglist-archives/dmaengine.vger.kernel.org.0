Return-Path: <dmaengine+bounces-5380-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3663AAD5BD5
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087F63A7A94
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3A157A6C;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsV86RoR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0474059
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658613; cv=none; b=r6TAYQ6owcEVDACT49sWAofb7DynRUAJ25gsiZP6v+yK5TAXvrMzczDFm1QxYuseuNAzRY6NRyUTiBJCmONMxAAVxoG7qxauwqkgK8/eiUkX6uVEdaISYroAizbmv2/YE9kn98rqrzKZcB6dmcNIqcgadXGWxUa1PQBjnnJcx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658613; c=relaxed/simple;
	bh=D4LjaHZR/09nZPys9yZQRYoUbwhb3n+f1/qk1ZiFkG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sNgwjawXC5ByHiK6oPAgPNiqk0hcCPyk2Z3Pf7CBGoRvmp5EMkZYz8D5wvnU+zs5lDZ5v/sRBjMAamGv1as9SausQXlUEgdyFQLx8uql0vyaTW4NxHGnjcQK4a3l9zAF444ZiOB5eSEawvt3uZuDEfkK8bsM+ykfkP57pmuwy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsV86RoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 538E7C4CEEA;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658613;
	bh=D4LjaHZR/09nZPys9yZQRYoUbwhb3n+f1/qk1ZiFkG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rsV86RoRGPJjpv/OIe76LjDcN71Q+9HsRapFYVWotp5Db10Frr7lZso6MtkzcBoCV
	 1Wqi5hvRaKjzkxCQd93n13NDzrK6ICtKNLYymkqp6MeoirWa44rZg2dW8kblIrf5I3
	 vQl9U5HGcKiuJaQPmGIU535dpULm/wvh/X2BsJyvC6TsUdEMc1J0RU7lJugzu0bRbZ
	 k5nqrhyoucSf+M9gcMz2SCbNPFq6+3Intq1lhtZRABWqdUkAH5SNEaFP9+zXZtlmtl
	 klJCCG3Wz6AHP4GwRGbAV0GepTkH+NywJDDi+nqEGn80mCnLeW1hMAV31rL/5KHfnS
	 TbpbGZqAdekVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C17CC71137;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 11 Jun 2025 17:16:56 +0100
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
Message-Id: <20250611-dev-axi-dmac-fixes-v1-2-d30af52a2af5@analog.com>
References: <20250611-dev-axi-dmac-fixes-v1-0-d30af52a2af5@analog.com>
In-Reply-To: <20250611-dev-axi-dmac-fixes-v1-0-d30af52a2af5@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749658620; l=1232;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=VnP62GBHna2SYg1YsUNFGvTHFdm1Tb7CGDCA6I3LeD4=;
 b=wklruHOGSo+Uw1R66vDLihTt2dewv/gaSlzI29L7K0OqFzaFhGOfTbfGUy12YywL6cBWHfR6W
 aWwaM81uH/BDN/cleFxY0iQYoz/NUhZZPl12bfe9NcFBwhzjfJks2xX
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
index 2aa06f66624ba5749e7e7f24b55416f96064b82f..47d95d2d743b1b939ed0ec79ee29763843bcdc09 100644
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
2.49.0



