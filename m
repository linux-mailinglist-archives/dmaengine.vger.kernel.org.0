Return-Path: <dmaengine+bounces-7265-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FF8C73D07
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E195D4E774D
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C983128CF;
	Thu, 20 Nov 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqsqXetj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B1302CB0;
	Thu, 20 Nov 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639269; cv=none; b=NbzAW1yaDXP00A3lccyAYgJf8pLycswCscfak9+uJL0L+P8IGZBaoj+B7ZoPqgvqvWShLtEn1SQUV0nzzyJP6Mb91QGbz5sL6BvgAvq1KvKn1K0m/tP3h7V3O5gH9gRUEtd0Jxj3qHmEdLvaO6ShJLCpZSSpAPYw1aD2TwCuvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639269; c=relaxed/simple;
	bh=jlBISMafcPOaSCkHt5SiIEqaS7RM1+PNySMlLFMbVqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHQx3aQkXXbiPZfp7J+uXnbEnqjRWhGC4IUK6mvopwH/J8vqcLl3m22xyYXWo6KY1axHbQcHgN/K64iDZayOYeetTP+nL2n6Xgm4RgK9i3bDbXeL0FsjSGxd7NXi7M4F0Cr3oxUSWF0ClXNo/gH9TsqcnhR+pzJMcWpMqbtHmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqsqXetj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394F6C4CEF1;
	Thu, 20 Nov 2025 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639268;
	bh=jlBISMafcPOaSCkHt5SiIEqaS7RM1+PNySMlLFMbVqk=;
	h=From:To:Cc:Subject:Date:From;
	b=uqsqXetjTXitb+2wT+v4VCGFpI6qo5k++FyRdnUe+q4cZ0yZYAplGMM/cXQ8zfEA5
	 jn2Lq4FaRnvwoFm+RNkE8oB65ZofIFrs6Zt8giL2UsI62/ve7i9iAO/x/d6yzNC2rz
	 4D03GvzNpfVL8wZ/Nt8EeMN/D1dhxRAjiB4CcuwGLRyE55LYNM/33o7U2GB2K+OAvP
	 B9TZXf+1TxRcueMIh6pdAd0JKFYZ6NDkhjcKi1Ti/HFh4d6t8FhEVo8aKo5tOfzPEQ
	 13BjvgcshFUdfo5l6EUab9BfIH/cqu3eXf70B8vjgrtWiGZPG4W9kAzuDWxm2oiNcZ
	 a8bMTuGsLmJgw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM38e-000000002G0-24w1;
	Thu, 20 Nov 2025 12:47:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] dmaengine: bcm2835: enable compile testing
Date: Thu, 20 Nov 2025 12:47:44 +0100
Message-ID: <20251120114744.8666-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The seems to be nothing preventing the driver from being compile tested
so enable that for wider build coverage.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
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


