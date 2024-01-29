Return-Path: <dmaengine+bounces-873-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB99A841257
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62412820B5
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48315D5BB;
	Mon, 29 Jan 2024 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijUeWpW6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8015D5B7;
	Mon, 29 Jan 2024 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553356; cv=none; b=cr32mZIxscJf9+KrQTrhQm6rwGw8sVNEEipQF7r1Vz0OowIwD+3rOZWv5wnIh1sQpeNrTp3BkehR/X/rkfz+F+ZW5ympMMuu2pSdvS7JMS7V0um+RKIv/0uv8Hj0bi6Qmq5uJDRGJSuvJQ1k/aGb75ViySYobDTeuDQKmIcGWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553356; c=relaxed/simple;
	bh=WGLUlG6y44wAx6s6BsUbF71upygdwDMNOrR+LHhtidc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dR+GV857pbFO7EONFuV9JOa0K35fJbHs9Kh9yDETCikdZN1aZBNkjFI+eOwUzre1C69s5rfVfYrRJHro8cgDsanv9DZWhniiRpmRtS0AGOfOTCEXYFU+EOaH8yfGZG1hP7wCP1AVIny0wEv+e7bW85RnSmE6nxra7S4R5kcC6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijUeWpW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B63AC43390;
	Mon, 29 Jan 2024 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553355;
	bh=WGLUlG6y44wAx6s6BsUbF71upygdwDMNOrR+LHhtidc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijUeWpW623awZYINlNuFmpV5nccJLvp9aByiiWn4Avi92daDVOr/sdG1RCP6vHeZI
	 e+LHJwNyma9WJuS8f7yJ43P3tjBUJjJSDCdbODq99yLz3HfaPT6TdXN3LDSSydfjzT
	 nS1kCQ8o3/gisGLpQ4A92Fj2sngIHTmDfk8+rfjx6BeaK57UYdhb4xrq9Pc3h08/IV
	 4S4YtwO/9f7+GsFge9bN8Fh6o8JNgRRmSifsfW/9ugxa/M5HAechB/x2pSGstgGOPE
	 CBkFh3dlc9dgaudUbjN/YcG5uxm0OsZ4TuOLfBSNb/K7HBnUSF/MnqUxlyEdixoeHs
	 zhVrBaoECigYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/10] dmaengine: fsl-qdma: increase size of 'irq_name'
Date: Mon, 29 Jan 2024 13:35:17 -0500
Message-ID: <20240129183530.464274-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183530.464274-1-sashal@kernel.org>
References: <20240129183530.464274-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
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
index a8cc8a4bc610..d141f3f4d9f6 100644
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


