Return-Path: <dmaengine+bounces-877-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7E084126B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BC6281585
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA6B15F310;
	Mon, 29 Jan 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6vn2XZu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E8415F30C;
	Mon, 29 Jan 2024 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553369; cv=none; b=ZAFKxSvF2d6AYwadJSTCmwJoSjgLjcJ1dd+2htkQ3XlHm6nYIaH/j0uTSx3p1FClEJK74khXp8Xm5rPCFirrGQDSmw+YlbqBWs/IUPQJh9QBkvkXxsi0Q5vubAw2dltGAyly3dev86i5gHDyFRUnC0vJaS1Yd3NDBTGjnuOsV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553369; c=relaxed/simple;
	bh=ZMlwUedNtK2KjgWPJu6Ee82FU7zw161lmbHHG5Coy7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/7/Fu6NsOfMISuSYa3JdNmBhloGkFmgklCoqhBkSxRWwI9FRpJUJ+cWFxW/us3aGYAnYkpIiyhh18FcXJfYG1dUfkReOPKvIlmmdOw4PV0oxafQNqXAudMw+/pYYYJMp+dvYSiVB0LtgKSp0+vcth3sh2awAHQoB1EQ7o3OGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6vn2XZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EFDC433C7;
	Mon, 29 Jan 2024 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553368;
	bh=ZMlwUedNtK2KjgWPJu6Ee82FU7zw161lmbHHG5Coy7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6vn2XZug5kZb4Z/dT3q1qN7SvzKWYtkrS9kKhT9emAK55o7z5vmYF0BrJW8uNMVc
	 yu8leLV/w4CW0+JOpMtyv6sewuC3r2m/MMOpHBcreuym4LJ3+DqEWmav6SxWV0d76L
	 r00wgLimaPtIrhL3csr7RsWRj8l+i0e7/JR7T1Bii9gInDj/N3zgPvgEl6TtLIy3IC
	 SVx4ihAHMkU2+30p+uvZgbH6gtIpeqwSmIAAVvCtpj9oDmpwaNjzqTSjOld1T/aU55
	 QvUn2QoDbE1cO9NFJ6ndput/602/j4EAuw+rbKUiUwVcriSAr1UnlUYCYbdLFNBvcy
	 hhJgI06zZdFOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 5/5] dmaengine: fsl-qdma: increase size of 'irq_name'
Date: Mon, 29 Jan 2024 13:35:57 -0500
Message-ID: <20240129183559.464502-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183559.464502-1-sashal@kernel.org>
References: <20240129183559.464502-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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


