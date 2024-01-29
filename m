Return-Path: <dmaengine+bounces-851-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C0840B4C
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 17:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894C41C226DC
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D952156974;
	Mon, 29 Jan 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bpLROeWM"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CC155A22;
	Mon, 29 Jan 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545571; cv=none; b=fx9+CmVsZwdl5DlbfcBBb+2E1+e1D+cqvfO3r509vsz2nlvbP6J3xmgw2uiGfbIVN38agGQh3QBteNkcBEDO1W8UBJNd/vhMl8n3LS/aZt/ojkDY1QhF0REa1EnZZjhkDKSBQLrJz/PTBg2fBi5NN+8s/C1uzoDrZAGhSvIve9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545571; c=relaxed/simple;
	bh=W46H/aCMXfesOX2zY96FjX0batkbZQUarj6CDXDqBP8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rdNS8mvpSZP/dxa3ARITf34PxHIasdJRM3yMeovO4iobbkSlP6Mqz/KJXnW07lriupugsimnyy7Na8tNPXjAVEXaVOhGqJv7TnA0OLwyPVsQhx8n6ejC5x/eg5A7yJ+Ml+mChm+ogwvPE8zj0R6pmraw2jKj8BpE0Ct230BdfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bpLROeWM; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2430DE0008;
	Mon, 29 Jan 2024 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706545565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E9Y1YO9a4lUPIXa97ED1XfcPSm0h5Y2q/VaMDZEFmqw=;
	b=bpLROeWMvuPAptm68QoPAg0rklxbUdEqyDVt0QebadEgi2fFXBAaOeAHosWg5PL9oDrqp6
	gLcV0KTxxN/uSqowdPt9hq6IzIcEF9w1nKroKiXeIe9uNTbOyFyuS/eHp5wpuWBnFjbiAx
	NW4skpr/0UxuH1LswPFISPQjgpCAHEyl3YEl0i0mRGq0ylwuDKIvgYqXKfZ9C0HYgRU1aA
	8j8Uz1ryodJSoctJYfhUejX0/NfFWSk89UzNgL/qnQChYmC5UGq29Vzs/HKhim/Myr6Qm4
	+DXnV6JGL22peVHrjpmu+H3ko49tCbqwSQtjLtO9plZW94DuCr/fK6TdTKxycw==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH v7 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Date: Mon, 29 Jan 2024 17:25:56 +0100
Message-Id: <20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJTRt2UC/43OTQrCMBAF4KtI1kaSJk1aV95DRPIzsQHbSFqLI
 r27oxvFQnH5ZnjfzIP0kCP0ZLt6kAxj7GPqMOj1irjGdCeg0WMmBSsEZ5xTK2kAM1wzHBvfmmN
 rYneOHVCrXKlDBcKWnmD9kiHE25veHzA3sR9Svr8vjeI1/QMdBWW0kADM1bp2KuxsSgOuNi615
 MWO8l9KIiWFl1zbWnBRzanyQ3EuF6gSKW1dpXwl8Ck9p9Q3pRcohRTYoI1hIJn/oaZpegIAGNo
 HowEAAA==
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

Changes in v7:
- No change, ready for merge
- Rebase to mainline 6.8-rc2
- Link to v6: https://lore.kernel.org/r/20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com

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
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20231011-b4-feature_hdma_mainline-b6c57f8e3b5d

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


