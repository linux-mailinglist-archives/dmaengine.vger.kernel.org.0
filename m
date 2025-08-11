Return-Path: <dmaengine+bounces-5988-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD8B21120
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 18:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532F1188498D
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9A02D47F5;
	Mon, 11 Aug 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLU0O6WB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2E2D47EF
	for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927797; cv=none; b=F0kKVs1u3hETVFuEPK4Tr55wiSHnqGE6YUko2oGGcjkdZZpsB4y8Q7blMOm2oMzTAyU+R1vj+qRJtF1OVM4PEr9RogJG50tLDfCAay2eI0ErYjq7Dq3BJcz5V6GryRRJFev5mGZFaAwsAQhksO4jpUxHvogXzFFv39fI9VqZSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927797; c=relaxed/simple;
	bh=m0HSEjX1jaREX9X9d/z3wVxya3rZDLBco5Un+YDkXHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqK0eUhFG6O5NLqsVhhy1hnynDOkHFMyAutGnxwBnIhk8IA/B2Mev3g85cepFdW7WKX6Sg6F19yby8JqeX5qOjBFXlW+aS5d1lfn3+5KNIvYBssf6UKL+DmqAgV+Dd5EAhkBOTTcptM3Fj3QOd1ehscgZLOjZQMzYaLKFc7NgoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLU0O6WB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAB0CC4CEFA;
	Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927796;
	bh=m0HSEjX1jaREX9X9d/z3wVxya3rZDLBco5Un+YDkXHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MLU0O6WBuZv1TKzcsVEcW0M3MAqTbO13ZCTPtaHDqi/r+g3fgrwtuf+gUrX4qyv/B
	 oGV8WVTq/E0FWB4wJkDOJUyLwpUlSEz4WBE1cbVfMU3/W0y5Oj+oq+4Yd/HlhIYAZc
	 3POdhlApmr7U/O3RI+2fjK2AY+AeYR+j4D5gechZPadQhyWUhEWgnAgFbcorfRz+hM
	 cUTxSYSuOGhSOxQaXU7/gygpa2OAqrffqLyd/NSSDGS6iHiXiudy8FDeMCxcguK4Tw
	 7Xqbp/9YFFvYt4rf8Umi/F/HtcgpM/HkkDdcR51J2tiTpZOTmIfxoiUWrCJ0IJz5zR
	 ZHS7cvSdd6qaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D50DCA0ECD;
	Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 11 Aug 2025 16:56:36 +0100
Subject: [PATCH RESEND 1/4] dma: dma-axi-dmac: fix SW cyclic transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-dev-axi-dmac-fixes-v1-1-8d9895f6003f@analog.com>
References: <20250811-dev-axi-dmac-fixes-v1-0-8d9895f6003f@analog.com>
In-Reply-To: <20250811-dev-axi-dmac-fixes-v1-0-8d9895f6003f@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754927814; l=1461;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7FGbSXizw76IfQYT0EAU1rxT7UHIvRzOGYH1bHBB6Mo=;
 b=PeU369nnqC+xMfx+Vr5Jfehuz+82TKy75zP0xaI2bEdie78hM/iQPdFaH3qek0LqQicWmIDhb
 QrA2HIsRrzHAGFASdBIUEZszO3waY9SpfMVwejpo220N+ZP4BUvPFQC
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



