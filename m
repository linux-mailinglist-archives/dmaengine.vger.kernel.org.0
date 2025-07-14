Return-Path: <dmaengine+bounces-5805-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E3BB0448A
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 17:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8263B330D
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0925B1F4;
	Mon, 14 Jul 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiAuLL2H"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512A24EF8B
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507541; cv=none; b=c4KLHm2I+kkxJMMQPYk+vvW74KjiUf7P0c8+lbKPstlUQRwPYsY3gNfRyY7FOOluA4obz4o+irZHEKxma2Q8O6Ag1w/mybozGejsYd1ekM3V4M5S/3TG7VYV95Nb84v4mpplB44iZ9zA1iE+aAOGm6jnCL9u2lP0HZxSwgbdVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507541; c=relaxed/simple;
	bh=m0HSEjX1jaREX9X9d/z3wVxya3rZDLBco5Un+YDkXHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y72faF0kHQwkmTMl/CUy3RW4Wv8p52XlxMi7xx9PI/O8ASTfAzbwSLaPb+ilrxVjhrg2bsN47pj1b3WZ+o51l1h7L7ftKrrKWvSRNmAeqdjIm1tnP7t5S81NSEfgdw72Oh8baHdwnFaoR491Odrn4u52OvKl60TIbccoKaWqAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiAuLL2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD6DDC4CEF6;
	Mon, 14 Jul 2025 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752507540;
	bh=m0HSEjX1jaREX9X9d/z3wVxya3rZDLBco5Un+YDkXHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EiAuLL2HDIivDz3l60tM0wLD+rs0q5m+jAx0pENKLiGzoQg/2AB7w0mEM1C1XCbLX
	 VefopWZhze6OGdNmsVwD0PQ3NtNgU/RH9QWZ0i1eHRWU+CTemep1vABDDp1isCILO8
	 vW8b60kbhjPv7YBUNMs9EMXGbpOw7TFOnBBnGpJmPr72a44U73TBruxvaoKV6xY1xU
	 1TZoxN64JYsy29UyVrxTIQG6k/wdfSNfvRuFI/hgdTvGRhBvlaVfyHFrYoq6Bmo2kw
	 cHh3QIAUaPA6e17oMdvjqat/Tt2OdGIGogqfaR3TsQwbauhDYe+lZ3EhuuumJ9k3kH
	 W91oeyRslxW7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC68C83F1B;
	Mon, 14 Jul 2025 15:39:00 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 14 Jul 2025 16:39:07 +0100
Subject: [PATCH RESEND 1/4] dma: dma-axi-dmac: fix SW cyclic transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250714-dev-axi-dmac-fixes-v1-1-c3888b0d671b@analog.com>
References: <20250714-dev-axi-dmac-fixes-v1-0-c3888b0d671b@analog.com>
In-Reply-To: <20250714-dev-axi-dmac-fixes-v1-0-c3888b0d671b@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752507553; l=1461;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7FGbSXizw76IfQYT0EAU1rxT7UHIvRzOGYH1bHBB6Mo=;
 b=K+zOAzs3SwiU5IRBx5e5FSTDM8aEjX8a7Hk3qgZunRRwd+pfzoxkic/ak6SKu8bhx8Q8ejpRd
 aymjLT3PZp/D1e3WULj5d2rjDHmqB6fwnjA9i5jzmnc4NAknKWeH3uM
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

If 'hw_cyclic' is false we should still be able to do cyclic transfers in
"software". That was not working for the case where 'desc->num_sgs' is 1
because 'chan->next_desc' is never set with the current desc which means
that the cyclic transfer only runs once and in the next SOT interrupt we
do nothing since vchan_next_desc() will return NULL.

Fix it by setting 'chan->next_desc' as soon as we get a new desc via
vchan_next_desc().

Fixes: 0e3b67b348b8 ("dmaengine: Add support for the Analog Devices AXI-DMAC DMA controller")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 36943b0c6d603cbe38606b0d7bde02535f529a9a..2aa06f66624ba5749e7e7f24b55416f96064b82f 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -247,6 +247,7 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 			return;
 		list_move_tail(&vdesc->node, &chan->active_descs);
 		desc = to_axi_dmac_desc(vdesc);
+		chan->next_desc = desc;
 	}
 	sg = &desc->sg[desc->num_submitted];
 
@@ -265,8 +266,6 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 		else
 			chan->next_desc = NULL;
 		flags |= AXI_DMAC_FLAG_LAST;
-	} else {
-		chan->next_desc = desc;
 	}
 
 	sg->hw->id = axi_dmac_read(dmac, AXI_DMAC_REG_TRANSFER_ID);

-- 
2.50.1



