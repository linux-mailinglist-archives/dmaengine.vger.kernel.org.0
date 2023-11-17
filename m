Return-Path: <dmaengine+bounces-135-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAC67EEFAF
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 11:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8731C2097F
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573BB18AE1;
	Fri, 17 Nov 2023 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QYHHyKIm"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB864C1;
	Fri, 17 Nov 2023 02:04:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA377FF817;
	Fri, 17 Nov 2023 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700215448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svngh7gavoOsAoTd14KvI+aVm1JHod9n5Mvh72UXNZY=;
	b=QYHHyKIme7eUxzobIVI12NLStklWJelYUHOZJ8AvmXXYvVElzTGwhkFIEekpHOSAcW+K18
	l2G2pjqbTC+vUGDQq4caHJnddWHbObwbnmuLFdXz6OHmI5UQdklpT+f5Tam2dLWOW8kYqZ
	aygZ3O+Dh2MQLgPPzYeM3II+RhgcZsTqTiW7Gd5RkguZymAmsnmbw88V2uQDy1Nsu+B+Yr
	M5sifRmoU3s/BGjR6O0bBukYE5UNkg63Dh/xrTT5HSqVhwIG5d/kk4MH6BX71psxXwLM8n
	AeT5maXpNpy6RDf8b46r8dFUQyUMjm/QOYl+KuSWQRvIph3e3tZsuZljL0ziWw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 17 Nov 2023 11:03:52 +0100
Subject: [PATCH v6 4/6] dmaengine: dw-edma: Add HDMA remote interrupt
 configuration
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-b4-feature_hdma_mainline-v6-4-ebf7aa0e40d7@bootlin.com>
References: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
In-Reply-To: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Cai Huoqing <cai.huoqing@linux.dev>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Herve Codina <herve.codina@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Only the local interruption was configured, remote interrupt was left
behind. This patch fix it by setting stop and abort remote interrupts when
the DW_EDMA_CHIP_LOCAL flag is not set.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 108f9127aaaa..04b0bcb6ded9 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -237,6 +237,8 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
 		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
 		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);

-- 
2.25.1


