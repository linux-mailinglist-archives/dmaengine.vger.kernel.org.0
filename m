Return-Path: <dmaengine+bounces-852-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50615840B4D
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 17:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54461F23764
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6715697A;
	Mon, 29 Jan 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k16/AWa1"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95764CFF;
	Mon, 29 Jan 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545571; cv=none; b=JXFcoRChMiafVGDn24rwis2zr/PNOQbNC+Pc7MKzE1zHl27Nryv3Yw+aI5EdvCCY+VCHWb4pszzN//33vJza16+YBpBb8Nier+Yhf+boSoVShax00qZdxVIfqBKtXX8wuOIKyQlyuf9U0suvFpc0LrWbSCcZlU7T9fmoggNr+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545571; c=relaxed/simple;
	bh=UaY75zw6o52pDBfyVQuKZPkthmJ59a0OijX3V5ynnkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WG7HtJjw8Mzs77q1EzUOwiWup1c23kt2k1At14egVJL+lyD01cGgSIw+2sfZFRFXUOLRIEiqte6rj0QFhkhPwnsOApVR7EnLyiO7GjMZANMoYUvsbvjHArvtLojpTDigcKy85d8QuTfpLMWkaRY7XcI3Puwwa3hBL/1TKfAx3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k16/AWa1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78C89E000E;
	Mon, 29 Jan 2024 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706545567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAldIdFOcM6TSQgoc+utZ58ITzn88qsDQysRSDWf7aE=;
	b=k16/AWa19fqJf1nRgkxYXzj2UPvusjUHMekficOF8ryuUewp6ia77yC+U0DOlLz5EMFxah
	9+qHXCb5OHHGbsH6hSFhYygoTibLsXkj855fyPhuK5Eid4A3oUBKiWMu8xWLnDhjub5YgW
	W51fnK7AKblSdeXwGAoxeymcggvQ8MZNblSFra22UodjsNV+fwtB+FeGToHt/4RTja2HFd
	Lo3I/XAJtxafaEfn20e37rfLiRUAPA1IaA8/n26/N1Sjfa6zeQvISKVX3ZoZo846l6KcyL
	qJAY7qXGRGOxPPOsC7rW82PSEmRL05n+QbcNh81NSCxSG0rncch9YLlK4nO+BA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 29 Jan 2024 17:25:58 +0100
Subject: [PATCH v7 2/6] dmaengine: dw-edma: Fix wrong interrupt bit set for
 HDMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-b4-feature_hdma_mainline-v7-2-8e8c1acb7a46@bootlin.com>
References: <20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com>
In-Reply-To: <20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Cai Huoqing <cai.huoqing@linux.dev>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Herve Codina <herve.codina@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Instead of setting HDMA_V0_LOCAL_ABORT_INT_EN bit, HDMA_V0_LOCAL_STOP_INT_EN
bit got set twice, due to which the abort interrupt is not getting generated for
HDMA. Fix it by setting the correct interrupt enable bit.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Split the patch in two to differ bug fix and simple harmless typo.

Changes in v6:
- Update commit message
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 1f4cb7db5475..108f9127aaaa 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -236,7 +236,7 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Interrupt enable&unmask - done, abort */
 		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
 		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
-		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
+		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);

-- 
2.25.1


