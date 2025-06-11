Return-Path: <dmaengine+bounces-5379-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962DAAD5BEC
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 18:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DF7189F149
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E99D81749;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT6WahEv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E26BFCE
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658613; cv=none; b=aL+p4+kyzKSzlNQoSZOev9XwFjCNj9MA7jTVp1jdhIxU8CM/ygjHvLWiue4nTHaH1VGangKUoCcF3IzLoPkcWQlDP9I9lqJFvV246h8bdSpDn6fIIvtnOoAgIk0P7uHD7ibIQVkgv2dSefPH+uYOxxAXYcAhN08LnjdBdtJ8hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658613; c=relaxed/simple;
	bh=WhmKMlF3fN3/INvv+WAIo00+WXvmZbg/yaIjEBgDmUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=st5Fw6g0heLAbBvrU1eYH8tMqpFg2mDUpbtv3wZVINTPaMqG885b/u30FakwXrjx+567zQsS1yE+23vSpNMGEZxr8ELRWAlZwdnymXZ9knVnTTVBdIO5FLcR7HEiuCH3eem/P/vlRkQdGRQ7XLWIghdxLosoy5K4K+0ZDPHipzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT6WahEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 469E2C4CEEF;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658613;
	bh=WhmKMlF3fN3/INvv+WAIo00+WXvmZbg/yaIjEBgDmUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JT6WahEvKb02Qlt1g7XfIfYcC7t9ZcIoO2T1Tse7g4ixqniu5nNSmcFCiz22eFVb6
	 rxnea7IS1MPfv/JHWRfya8hRPXKl7wsa3ABAuNRzTT0EzEasJxxK6kK9XGCa1pBJZa
	 HNwm4ACsIaIwjLZu0mWABwhkmWxyvD5nYf/fL/cSuwkCS7vlsRdF6N/JZYBi/OfjPh
	 GvbaId6B8LeTsdpIPa891weZ72OLXzd65JPop/cYALatCFHgXHE0qBF2FAgfvTmGew
	 hXXoiq9mt9jnZ0unXYwVNjmEeSWMZTymdDXVng72RPDiM3eSW9tAu5glLHXc4bkL/2
	 9gn/F9GQ4Q/Sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F61CC71131;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 11 Jun 2025 17:16:55 +0100
Subject: [PATCH RESEND 1/4] dma: dma-axi-dmac: fix SW cyclic transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-dev-axi-dmac-fixes-v1-1-d30af52a2af5@analog.com>
References: <20250611-dev-axi-dmac-fixes-v1-0-d30af52a2af5@analog.com>
In-Reply-To: <20250611-dev-axi-dmac-fixes-v1-0-d30af52a2af5@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749658620; l=1461;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=V0XKZ+QEAXJ9KwAnrqaiZV0RfwiwQrqkI/wdD2sRznA=;
 b=y53tA5DMG/KJ1SYcZUUuaIFdTlrp3rpHPbfXjAI7R3tSVUL8NGSRCwsN+kSdO7uIchcpssbkQ
 YUNfBNRk6vGBAjnkAHglF7oA5h7uGOcY1MNStzIZcop8W58DDnRqARg
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



