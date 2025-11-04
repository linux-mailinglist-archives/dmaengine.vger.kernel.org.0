Return-Path: <dmaengine+bounces-7054-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D86C3206E
	for <lists+dmaengine@lfdr.de>; Tue, 04 Nov 2025 17:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EF624EB661
	for <lists+dmaengine@lfdr.de>; Tue,  4 Nov 2025 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D62330D2F;
	Tue,  4 Nov 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4P2hCDz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70432D0C8;
	Tue,  4 Nov 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273311; cv=none; b=H1L9dmglXWSHtVI4wTBklP9On4RB9PlOzopKUPfdqARjEakrZ4XYFaurTNtBrblCvCLt8eIvcnmtre3vRJAvDfBG9+Ab51CIouF24elHuYle7kHWERLRUOvtnVb3QPCQ2li3PJWRXHr+nAOFPFhlpYUVQutfo8G7352USfJTOeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273311; c=relaxed/simple;
	bh=cV2vC+hxvYQWbjTcpngorrmuYzWYeh/aFndPXKB73hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqqI0MbEhDkA6s6w18Ld/ubZxIi5Ato6kaPZ0dUGgMJKFThKSaFR8QCof6RMrwPJzYbAGc4iwZHlEi6KyZTYFzcIy5VDYGjMYVRV1gEaULOgouHimNZWTJSCH+5A7CuYkxUlkXxjhdRV95ZVNm6qu29U7xSXjN3VzSeCkS+GjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4P2hCDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3B8FC16AAE;
	Tue,  4 Nov 2025 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762273311;
	bh=cV2vC+hxvYQWbjTcpngorrmuYzWYeh/aFndPXKB73hg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K4P2hCDzrPQBH+VFqU9CUQyQvGeSqXAiG3/0PLLgEE4UKT/Fq9QG+d80Og2+bpuS+
	 3V5DvnjbkHF4WhFjXLz9ziCmB1Ef6pkshaVVYPiwdWboskMPQveJndlkCq/qYTx8py
	 E+D1UosTg7/iYtwOoRT0uHORiyLEWMXe3cqm1nEeJR+PIR6H9OhUNN0S9MwCD73vfD
	 yqoSg5D3IMhrz67meMZW7i9JWOSJsZdk1Q/dz+a0UGhXTvx0D2vx6ObHKZppa3xbq7
	 A8IMd3GwNnk27G6qM/T/g4NNlRqntTKOEhCCGfsvpje3MEfxWDuNBBxmJ7aRcNdPdW
	 esIRkFcUAxD9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B9CCF9E3;
	Tue,  4 Nov 2025 16:21:50 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 16:22:26 +0000
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
Message-Id: <20251104-axi-dmac-fixes-and-improvs-v1-2-3e6fd9328f72@analog.com>
References: <20251104-axi-dmac-fixes-and-improvs-v1-0-3e6fd9328f72@analog.com>
In-Reply-To: <20251104-axi-dmac-fixes-and-improvs-v1-0-3e6fd9328f72@analog.com>
To: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Paul Cercueil <paul@crapouillou.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762273346; l=1176;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=t6kHiNCcPdNevKJZVwwd/Ae6Ss9wsGbaY4aAg+0KubQ=;
 b=iSHU+bVnMQxJm1vUTgWhFYcxzXNZpc9drBk0pcRZYkUjkn3V+vnFujnRPJhSHOL1jnRphyA2v
 1Oo6i1ldXUgBsvMuDAeSgO2k+SkMBcfFD7YksHv0Nbfmq9UjfloCJoQ
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
index e22639822045..0f25f6d8ae71 100644
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



