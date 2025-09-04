Return-Path: <dmaengine+bounces-6385-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EFEB4407C
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 17:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422CA178D15
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1BA2571BA;
	Thu,  4 Sep 2025 15:25:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B798C21CC44;
	Thu,  4 Sep 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999518; cv=none; b=kc0dZAIV1OCJi8nxLom2eTdEgiot2fIJCiPFdr6IGeFOpuVGe6MCD8TPeyiAllXJjHGfrw1XOryq6DeI/AkfG5bReZdIWsaf09J0U2IxViqu9nY4HxP7iBUu2hleEH6H+OmY1tS4VL8xmD6PXCKgtJcnWHjTJZf/+Wj8VMdH2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999518; c=relaxed/simple;
	bh=nEvhJjd5ikgtuZLSUS9PKum7072QqkOZ6pK2z0iWAEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJOOrQrXvVUw20KkqLW7MnmW8YwPygWDQ9McBEosUevp9xqj5kU9RGecrFQ9pIJQ0PmcuEWTzljUhX3LzQ78KGzAvNn1hdW7obFdgiPgJJtMQiDJCXjGDwahjUGgnQUNHYk/uoK5bjiTaa9keU+HjRT902mNu4sVjGU18JswZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CCFC4CEF6;
	Thu,  4 Sep 2025 15:25:17 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Vinod Koul <vkoul@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] dmaengine: rcar-dmac: Remove dummy Runtime PM callback
Date: Thu,  4 Sep 2025 17:25:09 +0200
Message-ID: <5f98cc1c3994bb0329c3eeaf5d37284817a2b9a5.1756999325.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756999325.git.geert+renesas@glider.be>
References: <cover.1756999325.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 63d00be69348fda4 ("PM: runtime: Allow unassigned
->runtime_suspend|resume callbacks"), unassigned
.runtime_{suspend,resume}() callbacks are treated the same as dummy
callbacks that just return zero.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index be7c239f5b721b2b..6a6c3234702c648e 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1729,11 +1729,6 @@ static struct dma_chan *rcar_dmac_of_xlate(struct of_phandle_args *dma_spec,
  */
 
 #ifdef CONFIG_PM
-static int rcar_dmac_runtime_suspend(struct device *dev)
-{
-	return 0;
-}
-
 static int rcar_dmac_runtime_resume(struct device *dev)
 {
 	struct rcar_dmac *dmac = dev_get_drvdata(dev);
@@ -1750,8 +1745,7 @@ static const struct dev_pm_ops rcar_dmac_pm = {
 	 */
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				      pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(rcar_dmac_runtime_suspend, rcar_dmac_runtime_resume,
-			   NULL)
+	SET_RUNTIME_PM_OPS(NULL, rcar_dmac_runtime_resume, NULL)
 };
 
 /* -----------------------------------------------------------------------------
-- 
2.43.0


