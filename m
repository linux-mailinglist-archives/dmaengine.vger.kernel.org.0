Return-Path: <dmaengine+bounces-7053-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A959FC3204D
	for <lists+dmaengine@lfdr.de>; Tue, 04 Nov 2025 17:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7827B189569C
	for <lists+dmaengine@lfdr.de>; Tue,  4 Nov 2025 16:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67762330B0B;
	Tue,  4 Nov 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUE7FMtM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83C32B9B7;
	Tue,  4 Nov 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273311; cv=none; b=O6s+ipMarHalwQV7amDcNGp4hMq7wuvoWHv50Zez3fpZkeDstMBHNgZItTSJ1fvy9tBZtzCH8I3epc5ccyK5J7RYS4AqYX8PUV2nu12cylCk/fLFjCHydPf/1ovd/w8IrrRLQzcrsskoPVD9kgz5e1NbGI+S1S1ORILMBqQghvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273311; c=relaxed/simple;
	bh=NNOWTT+YB33V66bWp09LBKeawoo4s/jO0mOdabh4dGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iXXS8TexFi9yvj/wpZwT27x9doGrQWWzbr1O2IzLh+bRtVsOxQairHLn4JV//4wK/L5QHX0eZMkdXPZWHLo6qET8GVNqMad4VHKH/4T2Vn3T0H0K18URY74CHFQV0d7JERrp1J+aXR38ZtBtc7tcxAhaK7iJaAk7YGkdPPsVXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUE7FMtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4924C4CEF7;
	Tue,  4 Nov 2025 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762273311;
	bh=NNOWTT+YB33V66bWp09LBKeawoo4s/jO0mOdabh4dGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mUE7FMtMjFTOm9XluIoJ6vlsgzWhMINtW9DmgEDq2Bigk+w817tSDs5wBsGtrAijo
	 Z3TJplY+BtArGPpSCoqvtshxEARhNwJ83bOHiXyM0YeFTghh9uvum8zV5SIpteEyt2
	 1eZEHHdAq8UwmGQOxBXflucSEkmg6DEiOPTWI6XrUN2II1FWzn0o4/cAX5VX6VTed2
	 uyXSB8mKqhT/mXbofr+0hhsVPIQjU7H66UJNg6r67+lZ1YLmMi/ceA6FPIW0FoVETd
	 7b6C4OTet/MxkNx+FzD5k5sGAaq6I1rSfKX/5m5/vDibIc2pxPSNyiogQadZifAEBy
	 Bav3pXdas/dBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AA8CCFA07;
	Tue,  4 Nov 2025 16:21:50 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 16:22:25 +0000
Subject: [PATCH RESEND 1/4] dma: dma-axi-dmac: fix SW cyclic transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-axi-dmac-fixes-and-improvs-v1-1-3e6fd9328f72@analog.com>
References: <20251104-axi-dmac-fixes-and-improvs-v1-0-3e6fd9328f72@analog.com>
In-Reply-To: <20251104-axi-dmac-fixes-and-improvs-v1-0-3e6fd9328f72@analog.com>
To: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Paul Cercueil <paul@crapouillou.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762273346; l=1405;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=h38Cp593uwl9c1SEt5NsKQomiYALx/d39utsfA9eGW4=;
 b=E2NgXxn7aKyCrbUdCy9amZZSWcULFuBhnycTQ9SxCbWHr/B1fmdCY4fOBik6A5zm+vY494NCk
 k8JjsdA6fF5CiSnhQKkn9bEs7cqFqRRAHNQ7fcJLP66/KCqByBuDOMO
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
index 5b06b0dc67ee..e22639822045 100644
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
2.51.0



