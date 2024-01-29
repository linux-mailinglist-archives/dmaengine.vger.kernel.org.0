Return-Path: <dmaengine+bounces-881-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496DE84127F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9071C2122F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799A2E83F;
	Mon, 29 Jan 2024 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIfJ+OHi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3C161B4A;
	Mon, 29 Jan 2024 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553383; cv=none; b=ArynchZYDOhvKVWVheTfIVQibFbEbYrjjdjM7gLwikI7yHxEHp705hU40gmNRHpsDhDPUgYA5wS0Jnj0njSAw11Q9cH03WclvVL3LGf5uyE38f/Dan24I2cgAE+3Q9QpSTULj0oahxfPkTZYJjh20sqY3dqEaZ1dWBUERoKFWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553383; c=relaxed/simple;
	bh=ZMlwUedNtK2KjgWPJu6Ee82FU7zw161lmbHHG5Coy7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8We25YDr/XN0Db1d5KvINGzVVeWXtC/6e9RQLEeGNBV8abH1RXil0R0Blh8rNHt28RilQ4SEkJnr5LvdZAD01a2+S+7CpaDnGBACkaisuYNQVMG+d0W5yoyKC/mEjVQuPcfGtN6t9uomHIXCq+QPQIZr0K9cdEhnwox8KTJTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIfJ+OHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558DCC433C7;
	Mon, 29 Jan 2024 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553382;
	bh=ZMlwUedNtK2KjgWPJu6Ee82FU7zw161lmbHHG5Coy7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DIfJ+OHipPSCl4A0pQL8e3IFq8l89Lzw+lccH1RCeLB5qvRTT+N9TPqojz0AYnOrE
	 +Frp05Cq397usz4TKsXszjn4bC7hwunhM802gBQCR1oCrux6o6bx/Bf7hazwKbk52q
	 00N5r48hhGKi+LV/Ysro6aZENTP8INDnOPsVi/vWqBqpP0OZ9yn1rVlf4amSXpXPi6
	 16b8gvhlyPimDqncqvWEHi/6djeUen73z2D84BA0earLCcSvwpc5W+OJaFC+pB/TVp
	 XL3fSN6ekp3xQ93WyOZUL+hitA2BUvCf99TDdo1yFOVqeYWR9pbgLMtEGEn6tRo6wA
	 f6rLVZ/esG+0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/3] dmaengine: fsl-qdma: increase size of 'irq_name'
Date: Mon, 29 Jan 2024 13:36:16 -0500
Message-ID: <20240129183617.464694-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183617.464694-1-sashal@kernel.org>
References: <20240129183617.464694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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


