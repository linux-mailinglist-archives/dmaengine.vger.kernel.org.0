Return-Path: <dmaengine+bounces-5804-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB7B04485
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B073C188AAAE
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BB225A65A;
	Mon, 14 Jul 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJQBorRx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C21FF1A0
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507541; cv=none; b=EWQKh9ZM39wQCQnTMLJxUbZG/d4Bd0fSS2y461iNkHCiEyyDQmXPzQK2HEBWWGUZgITxwfDxz53WJnaw0t3ucfowDib58C+eOOUkz4AIrFILhEYhuBfi2ZKbOS9prtjEObjZ7SVs/YlbEfEvLZzWi6s8MP4XPkxgoq7ZqTxM3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507541; c=relaxed/simple;
	bh=2Tzz7ysj80lYB1BE5Wt/UNTORIUkdlDrcYmxDhh1i1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UykE+FmvAaqKZUXezaR0yz1kia/5z9KLJAewkIGMqcU2HD+nj08kI0EByWL9lVbGEF4pTv+qFzYpxRg4QKCWu3VvG4Ce/EZfizMAXLmjuL8j9l+V8hE3DgxUEbQx0ern1D2yIofuX51JJ9x6ioZI6/SSzhYOvZRsK5AJiBKWaJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJQBorRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA632C4CEF8;
	Mon, 14 Jul 2025 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752507540;
	bh=2Tzz7ysj80lYB1BE5Wt/UNTORIUkdlDrcYmxDhh1i1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PJQBorRx5uizpCdXzWZzYlg2PqMsadYHX6d7WTcL8AB57f4U79Szy7rDx9uBiBBjK
	 yxVkG4hHcdG5AR23YjleTQwtuOtt8LnbUKPl/GOVMzP9P7ZbdDdaYmQprgRwZXtuOH
	 rj3URIs7zYwW5upsScdTaFV2piDViCnIyPE+WXeqUxWhr3cPO1qxHD0IBi/nqVsqHN
	 mMCKr6PZlLCQom6S44z4VRBgNKns5W8FkJWog7Izn1bwJCnUoTezO1PvEpxkBJG6JM
	 E5j7G8XZQPbCpvejRQflGBhpeSgnad6TcerlmMDf84lGZyuNEpC/FobA3o/BgCoKMo
	 RAkLFUD9g16VQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06E7C83F17;
	Mon, 14 Jul 2025 15:39:00 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 14 Jul 2025 16:39:08 +0100
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
Message-Id: <20250714-dev-axi-dmac-fixes-v1-2-c3888b0d671b@analog.com>
References: <20250714-dev-axi-dmac-fixes-v1-0-c3888b0d671b@analog.com>
In-Reply-To: <20250714-dev-axi-dmac-fixes-v1-0-c3888b0d671b@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752507553; l=1232;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=qODL1NlzaztSF9p9vRP44mRlOQRklh3MwhgK7VeiTxQ=;
 b=acsfjOmWxJquRKjJp26gvsSQ3DUPZ5tbC45kUPsRSQOzlZ7MySmFyBOzszethQ6NtEjsIIADq
 wbShJ2fkvKICjLeYjuO5ROwUBzM/TW6/TQgMcWWvyzE5FEaoxpB3HaN
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
2.50.1



