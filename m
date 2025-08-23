Return-Path: <dmaengine+bounces-6164-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7FEB32A01
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 17:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5AA582DDC
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194B32EA140;
	Sat, 23 Aug 2025 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM67uI7C"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20DD2E9746;
	Sat, 23 Aug 2025 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964661; cv=none; b=JKbOsi5UhbVEl9Lp+JOTtb4XaMFiSxFCnEyw9tSeEl8vrXFH5hTCh92lUcyXBvUGK/JiBmpEdYXzkLUQhNODlZZfduV/zaD0HRY1BEI0MLdpzSQ+ORE9Bb9VjsDZI11ik2mTg20YZPj7NQOu5xq5Lrki4Z1tmAUlxBKnll5I38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964661; c=relaxed/simple;
	bh=mPhmqWPTnMNFn5FnYjezuTC9hDdu0Dic6CcLiRxG/2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTVL87oUKrrdi86h3fz/MqObqqPxSqnta8Lsec0v5jXXdmaWr4m40f+6vNSoqjLOO+oshNcT/y3aFe2bbf1VwCHO8TUl5peBpt5H5ITwLE/bYiSVQhIEJilaDEdSrFC0oBFbb1QXlYLwVwJwk/TXjLItRPwep8u3rwpZY/padHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM67uI7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3F4C4CEE7;
	Sat, 23 Aug 2025 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964660;
	bh=mPhmqWPTnMNFn5FnYjezuTC9hDdu0Dic6CcLiRxG/2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uM67uI7CWhJwXbQZuvDsd7Pqr81tTyu7iVzUKwEZICsl8wP4HK5TmAVnm7uV0CroP
	 iAMEVvK7AyoGJn6vCCtyhjoVyXTm9nfRTP8hdR1zYhLKXSgXGSrSpPMQ6s1nUiCgFo
	 P6KHQx3/oaqFCaSjTnBq/MFZUG+MF+fWQcKZ9uNbuyLfQbOt9Oo457b0JN2peKe/IB
	 3vZAivVjQDRsQR3Kjc+YGcarG316pP99Q9lP7nI5gdtuik1o+yqCi6Z+NPbyuO/qJD
	 RX325lh7j7TfSkj0WLrBA//SZW9T0n0bDr2ZfoW69D9Q1GgIx0IodlvDAUt4XS4JE6
	 5P7uV1E10pQIg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] dmaengine: dma350: Check vchan_next_desc() return value
Date: Sat, 23 Aug 2025 23:39:58 +0800
Message-ID: <20250823154009.25992-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823154009.25992-1-jszhang@kernel.org>
References: <20250823154009.25992-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vchan_next_desc() may return NULL, check its return value.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/arm-dma350.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 24cbadc5f076..96350d15ed85 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -399,11 +399,14 @@ static enum dma_status d350_tx_status(struct dma_chan *chan, dma_cookie_t cookie
 static void d350_start_next(struct d350_chan *dch)
 {
 	u32 hdr, *reg;
+	struct virt_dma_desc *vd;
 
-	dch->desc = to_d350_desc(vchan_next_desc(&dch->vc));
-	if (!dch->desc)
+	vd = vchan_next_desc(&dch->vc);
+	if (!vd)
 		return;
 
+	dch->desc = to_d350_desc(vd);
+
 	list_del(&dch->desc->vd.node);
 	dch->status = DMA_IN_PROGRESS;
 	dch->cookie = dch->desc->vd.tx.cookie;
-- 
2.50.0


