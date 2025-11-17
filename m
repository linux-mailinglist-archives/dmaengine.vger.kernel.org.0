Return-Path: <dmaengine+bounces-7231-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F10C65209
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43E024EAB96
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369E25B305;
	Mon, 17 Nov 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLosKj1M"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975F628E5;
	Mon, 17 Nov 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396347; cv=none; b=XXe7e/JJcHT+/ov4qxu+59rNUDi6o27WGVkvUNYS8CB8NuJ8FSjh/Qi57/2pa2vDOR/c6q6dvZtdMaUdBLOPhz0PiANxcB/3R9cBMv/HRNHl/gmmqwjUID+ZLdroW/n4x8/cQUAGQMtnysA5NmBm7iBTdnPppdLKyq6GMFZUPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396347; c=relaxed/simple;
	bh=xqte167/CtIiIs1bxGMyVe2Cfffz/PRiyeDV54//dVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kTC1k10iUJDjHWEojtwqX2nYjMToClXD/AkwrDbTx0u5p//9JV2c/icCI84pjgnaCPFnM2DG70YLxrNE+FmA7Np3+D775d4Vm2gezcYP5XpouRlyVPIqSnChcZpGX+1jWYi3Ffj2Ypi44tENumzbyBfHqqcWfqn+nAqmKY+RWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLosKj1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D98C19425;
	Mon, 17 Nov 2025 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396346;
	bh=xqte167/CtIiIs1bxGMyVe2Cfffz/PRiyeDV54//dVY=;
	h=From:To:Cc:Subject:Date:From;
	b=hLosKj1M17ivpZE9x62WLnVcfiVgycjByqNR7bWdYjiRn9l8FclT2bw5XYwh3d0PC
	 72xsRKvbMuosrZNuvrZ/i4YMKxAuCK7BDzXsDpDMygIq+JnvTtJCWDAHLMF+8Bi4GA
	 d2wF2JeioodMesZQi+yDtMmV031gUL30HfZDXPbaX4mS1z0sjDQ95afrmaPqpxexj1
	 6fdeAyFWVaoRrg7WEiZSZ8JUpyyUHjCr2uaIe548Fw60wBjPlmTnTA7ioI6sdra7rO
	 nnoheHYmUGEso7Cr4UpqYX8gqFEiA93S41BA+G8lXUO3J9e+l9/JxESKpthluONCoX
	 Mo/6HrFNInb8A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1wW-000000002vp-2cvb;
	Mon, 17 Nov 2025 17:19:04 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] dmaengine: ti: k3-udma: enable compile testing
Date: Mon, 17 Nov 2025 17:18:51 +0100
Message-ID: <20251117161851.11242-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There does not seem to be anything preventing the K3 UDMA drivers from
being compile tested (on arm64 as one dependency depends on ARM64) so
enable compile testing for wider build coverage.

Note that the ring accelerator dependency can only be selected when
"TI SOC drivers support" (SOC_TI) is enabled so select that option too.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/ti/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index dbf168146d35..cbc30ab62783 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -36,11 +36,12 @@ config DMA_OMAP
 
 config TI_K3_UDMA
 	tristate "Texas Instruments UDMA support"
-	depends on ARCH_K3
+	depends on ARCH_K3 || COMPILE_TEST
 	depends on TI_SCI_PROTOCOL
 	depends on TI_SCI_INTA_IRQCHIP
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
+	select SOC_TI
 	select TI_K3_RINGACC
 	select TI_K3_PSIL
         help
@@ -49,7 +50,7 @@ config TI_K3_UDMA
 
 config TI_K3_UDMA_GLUE_LAYER
 	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
-	depends on ARCH_K3
+	depends on ARCH_K3 || COMPILE_TEST
 	depends on TI_K3_UDMA
 	help
 	  Say y here to support the K3 NAVSS DMA glue interface
-- 
2.51.0


