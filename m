Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C811AFC27
	for <lists+dmaengine@lfdr.de>; Sun, 19 Apr 2020 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDSQtg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Apr 2020 12:49:36 -0400
Received: from v6.sk ([167.172.42.174]:43706 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgDSQte (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 19 Apr 2020 12:49:34 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id AA569610AE;
        Sun, 19 Apr 2020 16:49:33 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 7/7] dmaengine: mmp_tdma: Remove the MMP_SRAM dependency
Date:   Sun, 19 Apr 2020 18:49:12 +0200
Message-Id: <20200419164912.670973-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419164912.670973-1-lkundrak@v3.sk>
References: <20200419164912.670973-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

A generic SRAM will driver for Device Tree enabled platforms will do as
well.

The non-DT drivers that use mmp_tdma to transfer audio samples to and from
the audio SRAM should depend on MMP_SRAM themselves.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0924836443152..bd0b6abd32fd3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -394,12 +394,10 @@ config MMP_TDMA
 	bool "MMP Two-Channel DMA support"
 	depends on ARCH_MMP || COMPILE_TEST
 	select DMA_ENGINE
-	select MMP_SRAM if ARCH_MMP
 	select GENERIC_ALLOCATOR
 	help
 	  Support the MMP Two-Channel DMA engine.
 	  This engine used for MMP Audio DMA and pxa910 SQU.
-	  It needs sram driver under mach-mmp.
 
 config MOXART_DMA
 	tristate "MOXART DMA support"
-- 
2.26.0

