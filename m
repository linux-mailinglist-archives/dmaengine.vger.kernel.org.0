Return-Path: <dmaengine+bounces-131-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A07A7EEFAB
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 11:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0B61C2086F
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B37182C4;
	Fri, 17 Nov 2023 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SpxbkSq9"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA9384;
	Fri, 17 Nov 2023 02:04:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DCE7FF813;
	Fri, 17 Nov 2023 10:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700215446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G0PLzIlsZP1HElpZeKAWH8qOGtUSKwQ/xdBhUhmw8QA=;
	b=SpxbkSq9soW9ge6pfKqJIvgCoMhsIfVuBLPQEHLeG4Elnw2Q3TTm6LcFRFyaR4G6zZZXmF
	ZY0fV4nQSqqip2V+JWz9tHNgo8W2AQwUUU2xl/S0phM7no6sUCURksr7IDnhvsfti21NA6
	q8ZdvJMRTtFPVj8BuHksG2WRNyPYhDO4/BrBVrqHg3FpTLbplYYYyoMErQTma57Atr4rop
	bPir+rS1nki/AeqH7Y8YhXLFR7f3VjpdWcsOfJNwkUw1iL111CHElo1W8+PdGfPGvpE9+3
	WQQtLHIv3vS8xuFrfdmKWgUm4zlz/hu7KQfhVcOPO6e8cZOqg60Gx/saCo102w==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH v6 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Date: Fri, 17 Nov 2023 11:03:48 +0100
Message-Id: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIQ6V2UC/43OywrCMBAF0F+RrI00zbOu/A+RksfUBmwiaS1K6
 b+bdiMiSJd3hntmJtRD8tCj425CCUbf+xhyEPsdsq0OV8De5YzKoqSkIAQbhhvQwyNB3bpO153
 24eYDYCMsl40CarhDuX5P0PjnSp8vObe+H2J6rZdGukw3oCPFBS4ZQGErWVnRnEyMQ14dbOzQw
 o5sK8UyxahjRJqKEqp+Kf6hCGF/KJ4paawSTtH8lPym5nl+A8HsiJZYAQAA
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

This patch series fix the support of dw-edma HDMA NATIVE IP.
I can only test it in remote HDMA IP setup with single dma transfer, but
with these fixes it works properly.

Few fixes has also been added for eDMA version. Similarly to HDMA I have
tested only eDMA in remote setup.

Changes in v2:
- Update comments and fix typos.
- Removed patches that tackle hypothetical bug and then were not pertinent.
- Add the similar HDMA race condition in remote setup fix to eDMA IP driver.

Changes in v3:
- Fix comment style.
- Split a patch in two to differ bug fix and simple harmless typo.

Changes in v4:
- Update patch git commit message.
- Link to v3: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com

Changes in v5:
- No change
- Rebase to mainline 6.7-rc1
- Link to v4: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v4-0-43d417b93138@bootlin.com

Changes in v6:
- Fix several commit messages and comments.
- Link to v5: https://lore.kernel.org/r/20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (6):
      dmaengine: dw-edma: Fix the ch_count hdma callback
      dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
      dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
      dmaengine: dw-edma: Add HDMA remote interrupt configuration
      dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup
      dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup

 drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 39 +++++++++++++++++++++++------------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
 3 files changed, 44 insertions(+), 14 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231011-b4-feature_hdma_mainline-b6c57f8e3b5d

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


