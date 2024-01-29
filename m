Return-Path: <dmaengine+bounces-883-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D5084128A
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7E41F238A9
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89094161B6D;
	Mon, 29 Jan 2024 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffVSfKBC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E432161B67;
	Mon, 29 Jan 2024 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553391; cv=none; b=GfoOzmIA2sS2JHQWItnr6k83mF+Wtroqa98c2cvRxKIfxf7iZb6dKi+wQFpOmKmL9yo/qu4lQCrzDQFl4tuUqz4gZ4Rx5BQpgFXd7ssadOp7IDBAElbe2sWr+z+9WLc1jL6E6UQ/8oe0DvslU7ujhgQQMuIgYEE5aDkdzu6sK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553391; c=relaxed/simple;
	bh=Omc01jK1Z8eiAuRSZ6plvZXzTRhy/HguHQ+cAeuTqSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QamHzDmebvb2kz+pElKu2bj0lbjaQ4+NR83bOD13yWW1i4fRaJk6hBudR0wA0fNfB5FxCruX07HT4NrH5ljutOrqaITIapWVsz9je/R+qUMoEzeObNoMAIITyyLjtTxuC3eBbTqCgGsAQoqlkeMWITk8xreG2/4H275gw3t5OlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffVSfKBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8622EC433C7;
	Mon, 29 Jan 2024 18:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553391;
	bh=Omc01jK1Z8eiAuRSZ6plvZXzTRhy/HguHQ+cAeuTqSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffVSfKBCNCMKi1s695lgYUg6IrHJ0egNblgidXsDhveNJx6re80tz7ESkqN9kEKwr
	 PoB0imB5sD9GD3xFv3VcFwxiMOXZXrckSWFpIZTxVjoomtubK7G3qMG2/fSM95Z+zH
	 0Q0kdrVzEvNeb1Tjy2YYYH1reaKftOOsu7xOyPujBxzKjaUy5veqoYOQNmkc7Xm3V2
	 JXiQh1qteIn5HvqWtdTDPwsw+X6Tx4ecVgHQgrvIQdT/gJ/8jFfUYYQbqIuFRqXEYR
	 E59TJdB9rh3Ad9DhswGbVyXeNy7uatUO2yzcLLniXO/eXD3HLlJ1dBZ7rKhhp7KMgm
	 j8ZPVZ7WW2XCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/3] dmaengine: fsl-qdma: increase size of 'irq_name'
Date: Mon, 29 Jan 2024 13:36:23 -0500
Message-ID: <20240129183625.464771-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183625.464771-1-sashal@kernel.org>
References: <20240129183625.464771-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index f5a1ae164193..6a894fbaf947 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -754,7 +754,7 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 	int i;
 	int cpu;
 	int ret;
-	char irq_name[20];
+	char irq_name[32];
 
 	fsl_qdma->error_irq =
 		platform_get_irq_byname(pdev, "qdma-error");
-- 
2.43.0


