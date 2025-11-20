Return-Path: <dmaengine+bounces-7266-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDEBC73D25
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2CE342FA6A
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84A32E6CBF;
	Thu, 20 Nov 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZMB11PS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063D2853FD;
	Thu, 20 Nov 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639423; cv=none; b=DeXt8uQOoRrbKSWeBWf6Z2dae60Tba1SyQuoTkqC8WrFC4md2Tx6I5HtCgV1VE1rTum44WmiGdVPfy1xa8r3gs5NZEuQNDjjB6JAh7lgkmcpOeVC8e9JuhHC5OcfxU2mMo97lm8blIXQIn6VQvdGkGcLB379XGnFOC1Z8rqw9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639423; c=relaxed/simple;
	bh=LL4SUt7taIPQNz1nL6kPaOVKgkkGHK2bOalYlID8+BI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtLKA1RcRuZmELw3zjRgGtAcQku287sJPOjullIJsX8T45qd2DpzQuSqL2k+qeBYXLr7q84BAzHgkqXhxJvmJVhSPvwItO9RGxbWw6b9GOv2v77QhFdRb2Ccxsmg9FvpRs44rKn4ZAkvELB/lLSC7PIzHFYnRR+YOt+EfLH88KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZMB11PS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC2DC116B1;
	Thu, 20 Nov 2025 11:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639421;
	bh=LL4SUt7taIPQNz1nL6kPaOVKgkkGHK2bOalYlID8+BI=;
	h=From:To:Cc:Subject:Date:From;
	b=SZMB11PSr8YRGjylyhpDDf0Aps3ER0x+ReBCNcJwvpEtU/6mBHuxhaFwzy2iK35yo
	 2t4ZEzFcHQzjedm3DpmDPecQMHjYzOJehfJn4BOgI/Zuph7T6145bUSV5oUrXkdlFd
	 njpOVNmOBn3cwj9z/owROtPr3NmgDPYKqbUM40atpG28TkxbwQU7eS+5cUVNZ13OTu
	 MoDxw1V0LJH7xKf0XJ2hxIJtCVdOcT5mUfSNacreZtWGE/gQlK9Dn+99noX3W0pGJW
	 +PuLDn1IXQLnRpVJZPOiSFAK0U/FxADLZCoyWaTxfxuvDPB3nV0XCSgQDPfS75vUwt
	 UBnxLmD6xF7yQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM3B7-000000002Ko-1gJ7;
	Thu, 20 Nov 2025 12:50:21 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] dmaengine: bcm2835: enable compile testing
Date: Thu, 20 Nov 2025 12:50:16 +0100
Message-ID: <20251120115016.8967-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be nothing preventing the driver from being compile
tested so enable that for wider build coverage.

Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes in v2:
 - fix typo in commit message


 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 115e7f2a9988..1a80760a9978 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -143,7 +143,7 @@ config BCM_SBA_RAID
 
 config DMA_BCM2835
 	tristate "BCM2835 DMA engine support"
-	depends on ARCH_BCM2835
+	depends on ARCH_BCM2835 || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 
-- 
2.51.2


