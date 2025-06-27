Return-Path: <dmaengine+bounces-5670-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96850AEBAD8
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 17:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA006560A21
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5493E2E88A2;
	Fri, 27 Jun 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fcv6IU78"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5FB29DB86
	for <dmaengine@vger.kernel.org>; Fri, 27 Jun 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036421; cv=none; b=o2Lb45zklBBJiAImenhcl0ZH+G7G/qfbsaXzQbHdbZI2vgA99jqOAHfM5mm0ZJytNmr5o3PNbLLdfll6xzfBEgZqyi6qsVXG0AF/BKvfYu61oxdv7GbWE9Ml6ec4KcDfiLjBQsY87IgdyIKxg+MkMsm14iAPu4vF4jy8XGREhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036421; c=relaxed/simple;
	bh=WhmKMlF3fN3/INvv+WAIo00+WXvmZbg/yaIjEBgDmUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sblfn54xoCMkxJar0GroifXsClr/skHZuWfclbBhgdFDRMMGx8Yj7VdH/CghdaZLK8jBF7459Q9W76O1dIKT0+bhPVQ+DCvYiA0oViRWDB4wQqL2BeIdQTQSiHLLx5Yx2IwmcPqOj+yA/nfAivFkTzH9W6c8W/L0pShW3dqS2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fcv6IU78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB7BEC4CEEF;
	Fri, 27 Jun 2025 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751036420;
	bh=WhmKMlF3fN3/INvv+WAIo00+WXvmZbg/yaIjEBgDmUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Fcv6IU78V9YtddjyyfJl0y6vMt7CTOLpLM7SG0u1YK9diBCoRIsqhD8kqE9+i4P7Q
	 ndcOK4Ot5bxGs9IPwLsQ9HBB/0vVfqeqGmIe/Gh2yHnikVimxajbQZwmMXZBh4ssos
	 UHTy/wGQtelMhofPkE8+J7PYOpQgDG0LDNj+toFCmCy5/hwRkoLWPMFXQo6KhfUtv+
	 HTCDdSXPuR9ZV82RgF5HLGXDjOwNGBiSQr8I26VJYORSqq1tK7g+EePV/Y7VCYh8Us
	 AafihclSjgaXwNcH0PfvXJkhL2aqGhzJ/eE3fv05rJnTcujvg5MadTxaVQO8PzKRaf
	 hzCbA40TLLXog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2255C7EE39;
	Fri, 27 Jun 2025 15:00:20 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 27 Jun 2025 16:00:19 +0100
Subject: [PATCH RESEND 1/4] dma: dma-axi-dmac: fix SW cyclic transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250627-dev-axi-dmac-fixes-v1-1-2453674c5b78@analog.com>
References: <20250627-dev-axi-dmac-fixes-v1-0-2453674c5b78@analog.com>
In-Reply-To: <20250627-dev-axi-dmac-fixes-v1-0-2453674c5b78@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751036430; l=1461;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=V0XKZ+QEAXJ9KwAnrqaiZV0RfwiwQrqkI/wdD2sRznA=;
 b=aVdA1X9f5u0zhtxQ5BXmM+krPpOS03MwfxAqePT0ANLogFuFmfFp49N4BC5+2yHRHV+Y8rASa
 wBnlmq/otSpB255bGbYG0PldQ9GrX5Y8dM7xOTLLfS4Y4hgcuEQCfd3
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



