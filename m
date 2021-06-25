Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BCB3B3F6D
	for <lists+dmaengine@lfdr.de>; Fri, 25 Jun 2021 10:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFYIki (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Jun 2021 04:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYIkh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Jun 2021 04:40:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F729C061574
        for <dmaengine@vger.kernel.org>; Fri, 25 Jun 2021 01:38:17 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lwhLr-00BKLm-6n; Fri, 25 Jun 2021 10:38:15 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     dmaengine@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-um@lists.infradead.org,
        Johannes Berg <johannes.berg@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] dmaengine: idxd: depends on !UML
Date:   Fri, 25 Jun 2021 10:38:10 +0200
Message-Id: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6ab9d9a488a6..1f3c0e2ea4d9 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -278,7 +278,7 @@ config INTEL_IDMA64
 
 config INTEL_IDXD
 	tristate "Intel Data Accelerators support"
-	depends on PCI && X86_64
+	depends on PCI && X86_64 && !UML
 	depends on PCI_MSI
 	depends on SBITMAP
 	select DMA_ENGINE
-- 
2.31.1

