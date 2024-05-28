Return-Path: <dmaengine+bounces-2193-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDADC8D1A5B
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 13:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531CC1F223EE
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C67916D31F;
	Tue, 28 May 2024 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELLVpAfZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596C16D31E;
	Tue, 28 May 2024 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897286; cv=none; b=oRgfjQvY44/yCMo2DTjSlx98TYxwKO41eEYqdMi2rfYZ6QhQ9G/A+qhzQw8/nGLEa0R85RbAxHCpqDyRLSAiGgSzHldRBflo+Isc94Mey9nZik8Q8Zxqti73wcdHm9D98R31EotXHDl+pth9aRlaliGZ0Ikg37MLqsPeK9YwekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897286; c=relaxed/simple;
	bh=pLxvFN5xoZsmrrcBMk/UoNtiBh/fqcsPOnfsZ8fmsVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j5bPNtVT0ooLpPYnPd1sp9F6ZLTOnBOme8GCbfhPWZOiLEHg+kGMhXGyd9PPTYTd1cD8ZMzGYiRqVkSjETJET2H4Kvh7f4SLIP87KYw/SucjydUzB9lHRpqZpB7HVAo1/mkau8WRxujvidd8bnv2K/fBwXm2A7GSStCVHV5E1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELLVpAfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10472C32782;
	Tue, 28 May 2024 11:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716897285;
	bh=pLxvFN5xoZsmrrcBMk/UoNtiBh/fqcsPOnfsZ8fmsVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ELLVpAfZw8gnXmQG8/5+WnJJZaVPKFcnFt8bg4L6b0QJiCV2d1C09Xes6bKc4+L+i
	 OKpLeJi+EWcX02O3ZhjvKp8zOoMJ5BaF5UqlBUK3QNRLxwz7Km0jWNYQ9VkbYr/cEX
	 6wL2pSm69cruSgtH1mG1kj+A30DM2Cj9FvigAuOeqDwuYhY9PDMJKGIkAj4D7ulbO7
	 8nu/6OmrjNjNGgLIMmeTn4+cXRpadIl0wNIjI3vzvFURmtikDJndqqd2LH2Yg8IKjl
	 f99ia8uAjdrjHs2lBneWpWMQFRTJIP5XOuQWUe0UWG86SmtFSf3NFP5tUXYC+MsRuE
	 oNHv0c9ggE7rA==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Fabio Estevam <festevam@denx.de>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: fsl-edma: avoid linking both modules
Date: Tue, 28 May 2024 13:54:22 +0200
Message-Id: <20240528115440.2965975-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Kbuild does not support having a source file compiled multiple times
and linked into distinct modules, or built-in and modular at the
same time. For fs-edma, there are two common components that are
linked into the fsl-edma.ko for Arm and PowerPC, plus the mcf-edma.ko
module on Coldfire. This violates the rule for compile-testing:

scripts/Makefile.build:236: drivers/dma/Makefile: fsl-edma-common.o is added to multiple modules: fsl-edma mcf-edma
scripts/Makefile.build:236: drivers/dma/Makefile: fsl-edma-trace.o is added to multiple modules: fsl-edma mcf-edma

I tried splitting out the common parts into a separate modules, but
that adds back the complexity that a cleanup patch removed, and it
gets harder with the addition of the tracepoints.

As a minimal workaround, address it at the Kconfig level, by disallowing
the broken configurations.

Link: https://lore.kernel.org/lkml/20240110232255.1099757-1-arnd@kernel.org/
Fixes: 66aac8ea0a6c ("dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 965fa49668ff..b3873d01a2ab 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -394,7 +394,7 @@ config LS2X_APB_DMA
 
 config MCF_EDMA
 	tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
-	depends on M5441x || COMPILE_TEST
+	depends on M5441x || (COMPILE_TEST && FSL_EDMA=n)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.39.2


