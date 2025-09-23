Return-Path: <dmaengine+bounces-6696-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EB7B94F8D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 10:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F416427D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBC731A067;
	Tue, 23 Sep 2025 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J80QME/6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3B3101A3
	for <dmaengine@vger.kernel.org>; Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615788; cv=none; b=q3yZnrzU7eLN3ZXZirGxB4cW6Kc/b3btKnuzxcE760V589HbpgAIZV+DwMwgkP5ZuIRsZeSgcjs958WDKgBcoSRPvabYPCAKL40E2xJ/3sGuRN/1opgSni3touUD35ajfIU2eAUg8mXYy5cXb8FvR0qgZA8YUEjxSGOfy8Z3u1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615788; c=relaxed/simple;
	bh=ELBSmRLEKGJ5aOCVQteR2lnDyBorETpu7ExpNiDqHgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pl928JgCpPBaxJ4IUp4gQEcj+daAHNTFLmY6+P22vJkTKl0j8kGpEpXvxQxp3nblFgl+0hHRbnCq2k/8wnkCRzvh4+p0FldFjKc3CQqKN2Ljm7SuFXCncu4sqGwYtJw+hYPMj7yL3KOrrx2HtcMEiRT4/DAh3DmjmtCqHFfI8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J80QME/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BA39C116B1;
	Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758615788;
	bh=ELBSmRLEKGJ5aOCVQteR2lnDyBorETpu7ExpNiDqHgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J80QME/6LRqDj+lmM9lrx/UttMINPwcSRJE73GHouzIPwJ9U9kmsdogqeqM4Km8ms
	 nWEgM7P4kMp4CFlrFTo2gmowt5bPBQjK7/b/kpaPDIhHTrZJAaDoQSIJNrXIpOzJhh
	 kJWzcNmiTGeJRE0rGIgwM7b7yN1p4AYffnGb1hGVGB71Ls+PpCjIMIoypcKs6rdBRb
	 jEaMTpmEd3ZUcMeWlkPtz2/xyuAPyg0ZEu3HVXSyG3Od+OR0OUWBCwklDg2BuG3mKn
	 mf3L48sVpkSTHfUgR+4I1yiV9r1/9x7gODLgtIhT0JGSqQjPBdxTRFIZpwXspBJYzl
	 Ab9uWKL8cAHHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABEECAC5A5;
	Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Sep 2025 09:23:35 +0100
Subject: [PATCH RESEND 1/4] dma: dma-axi-dmac: fix SW cyclic transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250923-b4-dev-axi-dmac-fixes-v1-1-5896dcbbd909@analog.com>
References: <20250923-b4-dev-axi-dmac-fixes-v1-0-5896dcbbd909@analog.com>
In-Reply-To: <20250923-b4-dev-axi-dmac-fixes-v1-0-5896dcbbd909@analog.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Paul Cercueil <paul@crapouillou.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758615815; l=1461;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BAuoxEsSrmFa/FKz+UWCZwjeXC6UYdc6O9UDaRqXuRY=;
 b=Dv5EdzWjRC4w+RwTCWLgSMfXZwZTy90VSGG8JGHegvWnstMM6cxCtISHRnVYCsgvX2qcxfOct
 9kRCFoBmiwhA8LtAbj7jvMJ+4MxQoTQoBH0m9yFYRTC1XQMQW26Icbu
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
index 5b06b0dc67ee12017c165bf815fb7c0e1bf5abd8..e22639822045f237ebcd1fa012a75bbe7dc536c5 100644
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



