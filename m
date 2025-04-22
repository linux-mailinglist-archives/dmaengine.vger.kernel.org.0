Return-Path: <dmaengine+bounces-4942-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E07A97447
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 20:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15EB1889968
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 18:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03CA28F951;
	Tue, 22 Apr 2025 18:11:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF01ACED3
	for <dmaengine@vger.kernel.org>; Tue, 22 Apr 2025 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345487; cv=none; b=tH5uA/kbWM+WGM7JmAOabfOs/pqmUg5aIbN/3qrWCLTmCTegLFLI4sRFcHI3KY4Kqa3LbL2t8Ip2O5yytoV68wkhgHtBfETRmuQQVsh19/atOdcZQzhS23X4lTbm2LbI4bYo0sOQdUWn7+74RIYBzvQIFVSOnvy8UKKEqLJ+iII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345487; c=relaxed/simple;
	bh=sD2P1qf04CXKydLbP1DMc7gQ1cnGCf1VWpZb5o8PUA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bV3mJMZlhxT57ScghSiMuIwT8SPuaEhwAUY09A7oaWmJd+PPLc7u9Bh6ybufT+ZP5RPzHsyT61Bqtx1rSsNQSi1y/tXwWADdbG2ZkduCGdK6aM75vjF0S7hqTwJ5y+epspB6J0iu8uSHwD7T69iTBwz161riR8Udlwm/Gpe2GLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:d623:9713:5a54:d77])
	by andre.telenet-ops.be with cmsmtp
	id gJBM2E0013mAuGe01JBMuu; Tue, 22 Apr 2025 20:11:22 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1u7I5Q-00000001R0H-3QYx;
	Tue, 22 Apr 2025 20:11:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1u7I5Y-0000000BCVX-3Y6k;
	Tue, 22 Apr 2025 20:11:20 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Vinod Koul <vkoul@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: ARM_DMA350 should depend on ARM/ARM64
Date: Tue, 22 Apr 2025 20:11:19 +0200
Message-ID: <50dbaf4ce962fa7ed0208150ca987e3083da39ec.1745345400.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arm DMA-350 controller is only present on Arm-based SoCs.  Hence add
dependencies on ARM and ARM64, to prevent asking the user about this
driver when configuring a kernel for a non-Arm architecture.

Fixes: 5d099706449d54b4 ("dmaengine: Add Arm DMA-350 driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8109f73baf10fc3b..db87dd2a07f7606e 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -95,6 +95,7 @@ config APPLE_ADMAC
 
 config ARM_DMA350
 	tristate "Arm DMA-350 support"
+	depends on ARM || ARM64 || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.43.0


