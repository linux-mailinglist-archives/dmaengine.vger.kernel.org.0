Return-Path: <dmaengine+bounces-869-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF27841237
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1D01C2176E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B503315AADA;
	Mon, 29 Jan 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLsXu6Sf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00215AAD4;
	Mon, 29 Jan 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553317; cv=none; b=cyQnNFbM4mw5z1Z7mjaMaAQY3RVQLQuBz8Atgx6qQQLA21H8L+FNSqhxloY6W/SWTzDgRRiInKuoSw1Q+x0+XXZn0z+r4X9y61pdhy5mqemuF4u4SoYT3T2zEzGWaGrOOn+y4qdHUuWjH6utMmAFZu/cCh3VagSb03pyni7CsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553317; c=relaxed/simple;
	bh=IeW3uhTMmwB9xAkfqMxGn0/i+utiqeYCsfSRBi3NrZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjXG5Rt1YFgn/yZDxlmK2Z6leCV9+tz1sHE5R8OVB9YMFJh+vNezWV60xs2Fhlv9b0ce1LfuZhmbDS1DpNsBVkNRF+lTJYDNtRNZl39kH+abyN5LWjRN+DGjkt48FCsevNjbGsjf0t8vpje+nIAbYqL86tePGycJsa3IKeVC+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLsXu6Sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A11EC43394;
	Mon, 29 Jan 2024 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553317;
	bh=IeW3uhTMmwB9xAkfqMxGn0/i+utiqeYCsfSRBi3NrZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLsXu6Sfj18iXKuazHDqtB77CeJkiXTzGkw3qcR5TX8ZIxFCQiV0GZmldVW9KgUrD
	 fq/+tj1BYDfNH010w8a6XYu9DBnBZwjRBVvuivozq+j6ZbHrSnZccv6NXo/WKAR78z
	 4bnF2wwPITowHkL+Wfdw2OLHuER+q6d/PPT+Wnc/iqSXYFXcc6K3tPP1GvIWH7CRjo
	 DMlbsX4oHJcFR+ekMvyPOCDKk/6X2JW3r/XXkJ06P25A0lfFGnWZgjbv3KJqejfv/4
	 gr//xabyk3XTTP4hplXqrg3YLGe922IEjfy8X+UYrOVWqpaVRt1tdpVS0OzKOL3ni4
	 WS01+o+umlzNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 11/12] dmaengine: fsl-qdma: increase size of 'irq_name'
Date: Mon, 29 Jan 2024 13:34:20 -0500
Message-ID: <20240129183440.463998-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183440.463998-1-sashal@kernel.org>
References: <20240129183440.463998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
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
index 47cb28468049..a1d0aa63142a 100644
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


