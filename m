Return-Path: <dmaengine+bounces-5215-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF593ABD970
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 15:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420BD18887D7
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA03B24293C;
	Tue, 20 May 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb7sKGHw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61422DA1A
	for <dmaengine@vger.kernel.org>; Tue, 20 May 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747910; cv=none; b=Hahnw5pwVJJxBowItryDmd8yAajQcNZlFNgif4A9fjn4BYKC83Jc00NqlPBNii27kKE5m77Gfh3uvvhUrzT91PRE3oKE6xuEZy4EAT44CxFqntwqQbIrlhFLhyd8CCadB0a9PiD6aCEh6l4vWl5XEXj5klRQoRTIGyXFP6I03jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747910; c=relaxed/simple;
	bh=WhmKMlF3fN3/INvv+WAIo00+WXvmZbg/yaIjEBgDmUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=muR7FW8i6cSPNwjOuowJA05UYeiEYbGZfM4/Jr0eZh5QclL4ACXn48alr8iaZ3CKSfwaxg3TL70afoXW5ojifCZ8ANO6hwrAhSRslWQRKS0RlN5La1EWzxi7/aVhDFMu0euCXHC8tfq/PpV3bmIvockrr3FYuT6rJpyU5y2iwlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb7sKGHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D12EC4CEEB;
	Tue, 20 May 2025 13:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747747910;
	bh=WhmKMlF3fN3/INvv+WAIo00+WXvmZbg/yaIjEBgDmUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bb7sKGHwxO8JwNfNV4W1bV10wqFOG1n6z20sJq+fWXb0eRW9GnVO6BYSeIceWaQQU
	 4oNGgr7zLnl/3Ba22s1IY3LAPVXuluK9wz3w5PBT4odKXU1y0D1qs3rl22+Lil5NLQ
	 o5kwoRw5F56xSy9n1UwKrrLb/2x0CCULfZ3VOBmUpGbGKdwLHLPJiamXTF3JiURiu8
	 r6wMbLdfL+JPeDIS1Z3nMOyBO+sHSah0LL6Rz1wVAUu+mBt823gwLF8w++Zoj5HsAS
	 jvp0wNqZEJq0+98pY6sKQMEWfczitAsI9cZaf+xNv9IqMa+rOvBZsO4sbGASn6mkU8
	 ZZPnjznIcIYgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BACFC3ABDD;
	Tue, 20 May 2025 13:31:50 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 20 May 2025 14:31:51 +0100
Subject: [PATCH 1/4] dma: dma-axi-dmac: fix SW cyclic transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250520-dev-axi-dmac-fixes-v1-1-b849ea23f80b@analog.com>
References: <20250520-dev-axi-dmac-fixes-v1-0-b849ea23f80b@analog.com>
In-Reply-To: <20250520-dev-axi-dmac-fixes-v1-0-b849ea23f80b@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747747912; l=1461;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=V0XKZ+QEAXJ9KwAnrqaiZV0RfwiwQrqkI/wdD2sRznA=;
 b=pP6MzuO8onoKbSo2oA0blCQSNh/FRAYYZNCWngtxD2BBhsrJMkhsovhrfMf+UkXKArdilpKJw
 GIzBAA/hGNlB82BxUW29dcZzof4tKsHAtOlWpJiOmZGBxZdUlpX1MFK
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
2.49.0



