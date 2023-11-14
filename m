Return-Path: <dmaengine+bounces-103-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBA37EB2C5
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 15:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3012811C3
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915A41227;
	Tue, 14 Nov 2023 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WVFrCZzS"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4033FB21
	for <dmaengine@vger.kernel.org>; Tue, 14 Nov 2023 14:52:07 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FEF10D;
	Tue, 14 Nov 2023 06:52:05 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B129240017;
	Tue, 14 Nov 2023 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699973524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+xLOKyAAZIVKLOKCb0mKpR7Go2KaA91YZcat0nslHDA=;
	b=WVFrCZzSVomLddWRoyTAJVN2lheLIAPj3akGLiY74f7YjiS1+ffTxbM8+vg/OMO4m6ykC7
	UtFGvotFxwzjlBpEzo/cvARR+m0zfHNq+X1SlCkP/Pid6aIPDQQohJYXsaRoKfmF0uX0Ml
	pnmnrxwchg4YNAGoCxmCJJS8ude3MeNK77brvj28DI375A14s3dVPdDkwFdmAYYzZZt+96
	B/2JmWREq2Vkg67+SWpzNC+F1fOUPSghs1QvaE51SA+S/23l0Li+ZhBx2R8UEhKmhSxqnQ
	J23A9lKqx2S4I7G6UnG8NYGX8d+tEgRgjeDGMi404SIKNpliz34SRBolqS1s0g==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH v5 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Date: Tue, 14 Nov 2023 15:51:53 +0100
Message-Id: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIqJU2UC/43NSw7CIBCA4as0rMVAoS9X3sOYBuhgJ7FgoBJN0
 7tLu3PX5T+T+WYhEQJCJJdiIQESRvQuR3UqiBmVewDFITcpWSk445xqSS2o+R2gH4dJ9ZNC90Q
 HVNemamwLQlcDyeevABY/O3275x4xzj58909JbNMDaBKU0VICMNM1nantVXs/59XZ+IlsbJJHK
 ZkpKQbJG90JLtp/al3XH+ilrpUNAQAA
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

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (6):
      dmaengine: dw-edma: Fix the ch_count hdma callback
      dmaengine: dw-edma: Fix wrong interrupt bit set
      dmaengine: dw-edma: Typo fix
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


