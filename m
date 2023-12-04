Return-Path: <dmaengine+bounces-363-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 800398035E2
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 15:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22656B20A61
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1C25762;
	Mon,  4 Dec 2023 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TDJaYPmj"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0ED106;
	Mon,  4 Dec 2023 06:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1701698643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t53LIR4hled+zaU+hMQumxi96x360KE+fXgFa+68WO0=;
	b=TDJaYPmjldl/ePtWEpqi3WHE5UesyvkxNu+zsaaQtjq/n8Vvnri9vvSYRWT2oGDHG+8lXC
	D8wfcN7colyxcta5CRvVF6saoZZ/bIZSAJmFABC8UdutQymfKP69sr8eehCafhquSZ9t8P
	T/5uA+bXwGO9j/+34leXH11fWp5Trlk=
From: Paul Cercueil <paul@crapouillou.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/4] dmaengine: axi-dmac: Small code cleanup
Date: Mon,  4 Dec 2023 15:03:49 +0100
Message-ID: <20231204140352.30420-2-paul@crapouillou.net>
In-Reply-To: <20231204140352.30420-1-paul@crapouillou.net>
References: <20231204140352.30420-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Use a for() loop instead of a while() loop in axi_dmac_fill_linear_sg().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-axi-dmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 2457a420c13d..760940b21eab 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -508,16 +508,13 @@ static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
 	segment_size = ((segment_size - 1) | chan->length_align_mask) + 1;
 
 	for (i = 0; i < num_periods; i++) {
-		len = period_len;
-
-		while (len > segment_size) {
+		for (len = period_len; len > segment_size; sg++) {
 			if (direction == DMA_DEV_TO_MEM)
 				sg->dest_addr = addr;
 			else
 				sg->src_addr = addr;
 			sg->x_len = segment_size;
 			sg->y_len = 1;
-			sg++;
 			addr += segment_size;
 			len -= segment_size;
 		}
-- 
2.42.0


