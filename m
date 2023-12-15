Return-Path: <dmaengine+bounces-537-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB21A8148CF
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 14:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B7D2857F7
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 13:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E8B2D7AF;
	Fri, 15 Dec 2023 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Srd2SsiP"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DFF2D791;
	Fri, 15 Dec 2023 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1702646029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21xrIJTonl2JSPX53jr10oHQ64LwYtc2R0VBvZ9/BIs=;
	b=Srd2SsiPVhfJfsyWju8h+Dm7x5+BPCtFQl+HxHQbQDmI+PE4bBDNFI8XEZ/F00eK+WVL0E
	1WRaVjqdmk26n/7H3E5q1RbKKjB/g34lRMRLvxcKJPC2sqozzM8vmaANDeLiVdaMqTPdyM
	/RQRKKg/IfZopXUG219fOc6KrlKNbXY=
From: Paul Cercueil <paul@crapouillou.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/5] dmaengine: axi-dmac: Small code cleanup
Date: Fri, 15 Dec 2023 14:13:09 +0100
Message-ID: <20231215131313.23840-2-paul@crapouillou.net>
In-Reply-To: <20231215131313.23840-1-paul@crapouillou.net>
References: <20231215131313.23840-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Use a for() loop instead of a while() loop in axi_dmac_fill_linear_sg().
This makes the code leaner and cleaner overall, and does not introduce
any functional change.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
v2: Improve commit message
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


