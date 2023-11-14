Return-Path: <dmaengine+bounces-105-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393FE7EB2CA
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 15:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691971C20A69
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E57341233;
	Tue, 14 Nov 2023 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LTi65E4T"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56129405DB
	for <dmaengine@vger.kernel.org>; Tue, 14 Nov 2023 14:52:08 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D527912A;
	Tue, 14 Nov 2023 06:52:06 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A164240013;
	Tue, 14 Nov 2023 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699973525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iPCuxXS6fiLAq+ZD6dKRSHgB+AgJYpeJ58Nq57Fi1fk=;
	b=LTi65E4Tlircxae7M6pf96+eWA6ie+/jpuEiLF891xQxSMoGf7b2b2dRtvl9+ET3M6ro82
	m11cQHytfNvz6x+v6P+Rrn10m2FWjqm8oVRtWwQdOHopBNp2hTMw7cA39S7Drpije9NeYD
	UpMx4MYp+wbAxCN7K0ELXHXT+fBOWTEsjPqzdifAnBxUXzwq66/9n1fazUep9MOueXN4LV
	kq0lDF7Diwc9r9nfLYjhOSIr2qpRBV+yYNFG75ntcZBSul27yjQBhxv1B2anuDbsEezJC3
	4Caz1BnFpW/QXYlx/cbcUf1/rbgpcUQihIXWHLFYlGHR3RB1G81//ORU+83Enw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 14 Nov 2023 15:51:56 +0100
Subject: [PATCH v5 3/6] dmaengine: dw-edma: Typo fix
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-feature_hdma_mainline-v5-3-7bc86d83c6f7@bootlin.com>
References: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
In-Reply-To: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Cai Huoqing <cai.huoqing@linux.dev>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Herve Codina <herve.codina@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Fix "HDMA_V0_REMOTEL_STOP_INT_EN" typo error

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---

Changes in v3:
- Split the patch in two to differ bug fix and simple harmless typo.
---
 drivers/dma/dw-edma/dw-hdma-v0-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index a974abdf8aaf..eab5fd7177e5 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -15,7 +15,7 @@
 #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
 #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
-#define HDMA_V0_REMOTEL_STOP_INT_EN		BIT(3)
+#define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
 #define HDMA_V0_ABORT_INT_MASK			BIT(2)
 #define HDMA_V0_STOP_INT_MASK			BIT(0)
 #define HDMA_V0_LINKLIST_EN			BIT(0)

-- 
2.25.1


