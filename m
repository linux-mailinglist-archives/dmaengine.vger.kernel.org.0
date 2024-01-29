Return-Path: <dmaengine+bounces-879-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A873A841274
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45881C238BF
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CDE15FB22;
	Mon, 29 Jan 2024 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po0uXYZs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B215FB1F;
	Mon, 29 Jan 2024 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553376; cv=none; b=vA7eTxT/lYecZhxPGWKTvislX3DsNt72ciGydsqrAcq9pfKiYLOROry8IsRz0rCwIEWZ4FO/oomchg3DNIpr07u9sVozu5qUlIMfXU2Wfl51tc8U2FxjJf8OksEOAqBmx0xTYWsEsQ1B9m1awG2z/yXv0r5zA23ZSgg6kL9EKXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553376; c=relaxed/simple;
	bh=ZMlwUedNtK2KjgWPJu6Ee82FU7zw161lmbHHG5Coy7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZ2R5qZwja9SRb7+uP0iQm7r+NCqj7svh35p9tciuBAPWuRhH3T0iYap+KJVsiWpkxu+cLRFl8ktjYAxGxzJqlL0cwlzzHqb2qw9IJIDEH784BeV6cjC0noWg4LoqZGn89DBVG6YD51bjH9uXiCt/RUWMXFlZPvrN+87Y6yOvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=po0uXYZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302D4C433F1;
	Mon, 29 Jan 2024 18:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553375;
	bh=ZMlwUedNtK2KjgWPJu6Ee82FU7zw161lmbHHG5Coy7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=po0uXYZs1lLWV6JSezRfRciDTIjbOzhQwzkElg66v0vjuIyTIHBJZD1UzflRkXTQa
	 8uGO0KcjUoZo4hKXFy11NL33XjYMFfE6h245i/OjOzf+HpK3OpdcnxwYTb4hEKI3H/
	 XbfVBWFdSqrIO9N49KctKZAGMg2+a6u9YdOmI3WOxK22AppE/Bcivu5DviZQ0x8rQd
	 maFrjdzv0B7ZTMIuC2pjGssddIimh/l4nqVePt3evuVDlrSexUhax14dkZ5KOUoz6D
	 JAMGB0E/5fdBMFsgDMz8y2XCwIU1HERbF6iiUJHIqHVbdtgPHTocrL6CdbQSg9rCse
	 SwJXs4vu940DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/3] dmaengine: fsl-qdma: increase size of 'irq_name'
Date: Mon, 29 Jan 2024 13:36:08 -0500
Message-ID: <20240129183610.464618-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183610.464618-1-sashal@kernel.org>
References: <20240129183610.464618-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Vinod Koul <vkoul@kernel.org>

[ Upstream commit 6386f6c995b3ab91c72cfb76e4465553c555a8da ]

We seem to have hit warnings of 'output may be truncated' which is fixed
by increasing the size of 'irq_name'

drivers/dma/fsl-qdma.c: In function ‘fsl_qdma_irq_init’:
drivers/dma/fsl-qdma.c:824:46: error: ‘%d’ directive writing between 1 and 11 bytes into a region of size 10 [-Werror=format-overflow=]
  824 |                 sprintf(irq_name, "qdma-queue%d", i);
      |                                              ^~
drivers/dma/fsl-qdma.c:824:35: note: directive argument in the range [-2147483641, 2147483646]
  824 |                 sprintf(irq_name, "qdma-queue%d", i);
      |                                   ^~~~~~~~~~~~~~
drivers/dma/fsl-qdma.c:824:17: note: ‘sprintf’ output between 12 and 22 bytes into a destination of size 20
  824 |                 sprintf(irq_name, "qdma-queue%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/fsl-qdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 045ead46ec8f..39e2c4d52d8b 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -805,7 +805,7 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 	int i;
 	int cpu;
 	int ret;
-	char irq_name[20];
+	char irq_name[32];
 
 	fsl_qdma->error_irq =
 		platform_get_irq_byname(pdev, "qdma-error");
-- 
2.43.0


