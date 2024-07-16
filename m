Return-Path: <dmaengine+bounces-2705-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08389333EC
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2024 23:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E25E2849BD
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2024 21:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843B913B2B1;
	Tue, 16 Jul 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcPuY3Di"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F887441A;
	Tue, 16 Jul 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167028; cv=none; b=rznghtYC/8RohUg0mTo1v6ZhNAepkWuxFGPbKFb6vvOs9dpxss7I+pICp1TmDO7NwenIx2O2N0LThj9cWNV+RMHYuQwNd44Lr9mLvrYKtpV/ecn2aaIGImpw4cWpAuu6/TqqEFfjgkb0L2Xlj2sWraPT9keR/G4KYzFHyqzgbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167028; c=relaxed/simple;
	bh=bwiVrWgypWBECie/s1mDOD7hIJm+DB9R8xzMdeISMkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bDjLPaFfMizgR+v6f9xeqpXB1UlHGVnFkuNzaiuHCMjD99b0om4tuc0TKn+wQ93ZVlKrezRNns8WChryGHdDMj6vY/kV/1eslqoJ2mfqI53PrJlcj3DgQiKZwwCMeQJE7NbX+iRutDdSMOQA+d9CAxR6xJS87gVEtJMekGaRpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcPuY3Di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CCFC116B1;
	Tue, 16 Jul 2024 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721167027;
	bh=bwiVrWgypWBECie/s1mDOD7hIJm+DB9R8xzMdeISMkY=;
	h=From:To:Cc:Subject:Date:From;
	b=fcPuY3DiidPB6DduwthSWiUJytd1GM4AxM8MxXagjXGKXVhGK2TLvHIjtHvW9UYKN
	 6Tea2LQsLZRvCjaSTJ5/R8QExz02QCnsCOjY0yOchzDhh1foLSc9ktUcknR6q9/m3U
	 AdpMMyACw2+NzS8ZsE3cJ6z4GtKzYC5XnSkNouQlJc8Zl8wOhznFxNYeJUbkGUG8ZC
	 /wXU8XPTdRUyPv3UydVfhTSRSxVN3ig1M4thUCAikgNycfir/Ww3ZrMeoApSmq58d3
	 Za6mGytrW9s2x786pI7RN6zlzp5u2LlVB4bhYr9W79CNI22dzT1+LLSpIb4st2IEvb
	 Z5Yb3NmPtOyPA==
From: Kees Cook <kees@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] dmaengine: ti: omap-dma: Initialize sglen after allocation
Date: Tue, 16 Jul 2024 14:57:06 -0700
Message-Id: <20240716215702.work.802-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=kees@kernel.org; h=from:subject:message-id; bh=bwiVrWgypWBECie/s1mDOD7hIJm+DB9R8xzMdeISMkY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmluyxGjp2z9PYeRXfXMWfLcFWNql3Qog4Ansrd XhNvP1P0ZyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpbssQAKCRCJcvTf3G3A JpZ/D/99eTgdWlRO81FMBexrHCAhl4eK0zepp75IT0PSIKdvQiBBSLRKuzQkxXc0ZYdPdw2qnaF nZMfKbt2UwHEYxT6iX+EM38iuGImr2SOPzYff+/de6c9mh6uUu+cVmZQCQQf7uZIqFOjNsQ+smj fP0jdnA11FKyyhaMUCrjLeTFQo+hyNh6Kx6x8iY0x6vpBj2rKGVaRUelkxZqa3hF6U3VcAusFB6 89seG3e2LbPEYonJkciL3eqmDRuzsGs1k23OffwQv0pydgYv4wYC40wp4JJW56cP67De7VWSh+D anToQFKSgAg8zOv1qSAhFCJrIKswyl8aNn0aRM8HHfC3inwqb3mmTw1mV9xUZBGrQH+zBbqkL9f cZhWad8S5ujjjRZeIYcINGdc6KaN8RCJg6mhiOvKrovgxqdi/g6cqslOsc6iOp7Xpi4gz2Zry0p Hb0OLKgFOkava/SGQsFBccpWp4gSDZHD33Z86OrJxBBsvscVDSUVesC795dT3QQ+Q6GbEJLQe33 oVHixvHMMHLXuNWub+DSi6dxPENFky7dNPD++phmD4D2pSk0Hdsztk08z/D52YmAuE5dZ/8fhws OwYCanTQv/ppulJ6U83W5o1qjSHRbwwbuA/Hv9aEy5XzgUXLd84wxCbamI+14+vgiI6ksHEorxG 0jF9n0tlUSouA
 HA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With the new __counted_by annocation, the "sglen" struct member must
be set before accessing the "sg" array. This initialization was done in
other places where a new struct omap_desc is allocated, but these cases
were missed. Set "sglen" after allocation.

Fixes: b85178611c11 ("dmaengine: ti: omap-dma: Annotate struct omap_desc with __counted_by")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/ti/omap-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 7e6c04afbe89..6ab9bfbdc480 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1186,10 +1186,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	d->dev_addr = dev_addr;
 	d->fi = burst;
 	d->es = es;
+	d->sglen = 1;
 	d->sg[0].addr = buf_addr;
 	d->sg[0].en = period_len / es_bytes[es];
 	d->sg[0].fn = buf_len / period_len;
-	d->sglen = 1;
 
 	d->ccr = c->ccr;
 	if (dir == DMA_DEV_TO_MEM)
@@ -1258,10 +1258,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
 	d->dev_addr = src;
 	d->fi = 0;
 	d->es = data_type;
+	d->sglen = 1;
 	d->sg[0].en = len / BIT(data_type);
 	d->sg[0].fn = 1;
 	d->sg[0].addr = dest;
-	d->sglen = 1;
 	d->ccr = c->ccr;
 	d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_POSTINC;
 
@@ -1309,6 +1309,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_interleaved(
 	if (data_type > CSDP_DATA_TYPE_32)
 		data_type = CSDP_DATA_TYPE_32;
 
+	d->sglen = 1;
 	sg = &d->sg[0];
 	d->dir = DMA_MEM_TO_MEM;
 	d->dev_addr = xt->src_start;
@@ -1316,7 +1317,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_interleaved(
 	sg->en = xt->sgl[0].size / BIT(data_type);
 	sg->fn = xt->numf;
 	sg->addr = xt->dst_start;
-	d->sglen = 1;
 	d->ccr = c->ccr;
 
 	src_icg = dmaengine_get_src_icg(xt, &xt->sgl[0]);
-- 
2.34.1


