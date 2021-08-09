Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060DA3E4291
	for <lists+dmaengine@lfdr.de>; Mon,  9 Aug 2021 11:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhHIJZI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Aug 2021 05:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbhHIJZH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Aug 2021 05:25:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B326C0613CF
        for <dmaengine@vger.kernel.org>; Mon,  9 Aug 2021 02:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=wqXDif7NwCkMnURmGQly5X2Keh83uVrxcrqsPz/w+tA=; t=1628501087; x=1629710687; 
        b=L2HjDs4Ho9ljdvDrLmrJBYQ1ezpIzX+tMnKHwOtFZPZYzHG5UTbqAcH2TjQR1SS7or4BMf9iGpB
        yADUlcGiasrkx4PCOfAEJj94/Ce4HGZj6fLm2qiYvNhXewkLaPud1RUwAy8MtHDt5xYzj/Rnql8cv
        ANDHBYYIVmnXUZy76FQlztE3qIqS5LBaaCaKmPVOXOnqITSK5wTanVoTXzzgHnuiSA2w6dtvOtaMa
        iczWOCzFcTwP1TUQ1C03JgnScGGlgm3tDSZdd4wN79RJk2PTaMNURD93awq/L/GS+zqyenLZgrlWw
        AXjm6IbLtGW8A6tC1YwaOh9fAjpLlJGI2kUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mD1TW-0083m6-Nc; Mon, 09 Aug 2021 11:24:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dmaengine: ioat: depends on !UML
Date:   Mon,  9 Aug 2021 11:24:09 +0200
Message-Id: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Now that UML has PCI support, this driver must depend also on
!UML since it pokes at X86_64 architecture internals that don't
exist on ARCH=um.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 39b5b46e880f..dc155f75926d 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -315,7 +315,7 @@ config INTEL_IDXD_PERFMON
 
 config INTEL_IOATDMA
 	tristate "Intel I/OAT DMA support"
-	depends on PCI && X86_64
+	depends on PCI && X86_64 && !UML
 	select DMA_ENGINE
 	select DMA_ENGINE_RAID
 	select DCA
-- 
2.31.1

