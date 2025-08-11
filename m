Return-Path: <dmaengine+bounces-5987-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC885B2112A
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 18:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC126E112B
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 16:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA2E2D47F6;
	Mon, 11 Aug 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsoSK1GI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269922D47EE
	for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927797; cv=none; b=O15smE+NKkUygkH3jpXDtHJC/o75WI1TCy86G9x27luIeqsvseSs/P4qhn60npFMAx3qtAWU5XrfpDVpHDNRjT6MoPbmA/R6VDF8p/8P+SM98T+a9D9WLLZvgvlz+MsV07mOh0WtGllY+15mouqPwQ+qKTVupL5gorRhLVzVkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927797; c=relaxed/simple;
	bh=2Tzz7ysj80lYB1BE5Wt/UNTORIUkdlDrcYmxDhh1i1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IO1NyY1YAAPmutZS1ObC1z2PaMctq2CyFSn3Q4EtKHZue7qlKna/rPoRsD5WFnLsViLALYOYTtcKon0QDLfpcuqYTEHOasElD5zipW7uHsIiljaoi0Gzt8Kan6NUfhpCdLLoMWA39PHCzwdLnqb3lNJyD5IebrXGwGksufjTB9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsoSK1GI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEFBCC4CEFC;
	Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927796;
	bh=2Tzz7ysj80lYB1BE5Wt/UNTORIUkdlDrcYmxDhh1i1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nsoSK1GIvrqkLdDFYb8W8rYynUAqmuBfy5pdB7RVSMMGhp5HBWH7N4UXMeKLSJLa+
	 ObRycQRLyh9pC2b3hchGPXPUGLufi+o2lMdtKQ+eZMuKC5PH6PLg13av8nqtu+J5JY
	 YxqE4VX+oBc4DMwMgznOQzwXYDc7UAudfRZ4DTJksflqjEWvGiF4eyPfcI0nejXbBs
	 BnrVmRQsETQ5+Fs0ie7bgDvkmFxakA5nIOIEGZIQIGuwobfiQ5sXwOujudmLA5OrCu
	 r6vM/729Uf/ydCw3PAhqsi9EzAlHFCYqfl+yltDC524B7JMFnOSiFUWHaI1+O/KQkM
	 nj1ZYO2nMXQGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA95CA0EDA;
	Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 11 Aug 2025 16:56:37 +0100
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
Message-Id: <20250811-dev-axi-dmac-fixes-v1-2-8d9895f6003f@analog.com>
References: <20250811-dev-axi-dmac-fixes-v1-0-8d9895f6003f@analog.com>
In-Reply-To: <20250811-dev-axi-dmac-fixes-v1-0-8d9895f6003f@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754927814; l=1232;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=qODL1NlzaztSF9p9vRP44mRlOQRklh3MwhgK7VeiTxQ=;
 b=lagkWOH8MPyDm4gL8Ohb9wriM1Hk9Szfx8QlYP+sWmsiY6NEpP7pFm2NdkafTof8FsU5W3QPQ
 jLAOoKks2WTCXCpD/ewdV54jyPlEtkfY7eT/ieyyEWWUT6CmyIUMWpW
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



