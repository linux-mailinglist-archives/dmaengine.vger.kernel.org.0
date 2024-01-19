Return-Path: <dmaengine+bounces-752-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C58329AF
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106591F22D0D
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4EB51C34;
	Fri, 19 Jan 2024 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZD+5wQt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2961A4EB5B
	for <dmaengine@vger.kernel.org>; Fri, 19 Jan 2024 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668594; cv=none; b=N/lcoJCkEUWkBuhbs+1LPA8agE4vFncSyfCcsg7qquGYRwmvavvEE3kW9tyzPge36ibR/bS9Ua3Eo+mLXAacdYO5CTOAu9/SYbwQz/UxjZqjaGi0VqKpaLE2041Tdvtt6XOIRk5iogW06U4qRPYEm+jsowDTonfRITvNbBOMGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668594; c=relaxed/simple;
	bh=dBRxwrmU/a2LE6/EDZDMXwNx3M7QpOXM9ox78PRWVL4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOoQM3JLQU7d3t8DEMKuSyK6MOweqoI1ReRYdTgtuxVSvzfLVpR3R39xagqfGyIm4an2B0Oypij+N/oMP4UG/0vChPMVoDjYz9um/WT+4GCUSX3iVaMyb9lU60bScewfssOPMcFglIA5LtlumJFWf7vCXHHZKS6fiLD2E8kUGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZD+5wQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B30C433C7;
	Fri, 19 Jan 2024 12:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705668593;
	bh=dBRxwrmU/a2LE6/EDZDMXwNx3M7QpOXM9ox78PRWVL4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EZD+5wQtb9d9mgNYHe2zV3rmMaJsuKI+A2pCjAS5o2gI7xp2Vjw0Fi8AUux9x/WGf
	 EC4G5Sbpxq4BstJLdDHwBte0/m4Hzr3EcbtLP3xkQWF0xqnL8PMvJ7171Q9KiBGSpi
	 RnAa3TmuFtOiMDrhUFZVxw+uTBr3QgBJAoTRbt9ZVT91toGdYldiqF0UVPW+d2+x0N
	 owHA3M+cZFduLu9zXn8DPyIjPO8H4Yrct+3LuE6OMXqbmLsNvLXegvo28HQc+LwRUD
	 eIAYIPhv86r2azKqy0LfapjF/7UeCZLPOlziS2RXB08Z4QMUxbMDFxay6oeJOm0qTM
	 ya4qypW1dzbyg==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 2/3] dmaengine: fsl-qdma: increase size of 'irq_name'
Date: Fri, 19 Jan 2024 18:19:43 +0530
Message-ID: <20240119124944.152562-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119124944.152562-1-vkoul@kernel.org>
References: <20240119124944.152562-1-vkoul@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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


