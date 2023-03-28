Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97486CC6D8
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjC1Plk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjC1PlR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:41:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A811EAA;
        Tue, 28 Mar 2023 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018018; x=1711554018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qBFRkj3VAiWm2ddYSXBSzpv19mxvwr/Ryn7W1PctZ/c=;
  b=N5ec3HMmzhjUO90xAJvw9ZPKSgdQg46rw1VMdz3oZG4/GtbPm8snrc7b
   DqiLpHObk6J0TA0VPcuGmkWdUhCAIKlxCC69TjIZeom5RmKYkENc2sCyr
   Un2wpMdkz2vOaXUtXd5mamjt1cPNRkKzoI1lwnbsoujD3WrPQMcjuwwKI
   b96jp4EksOoOTIM57tS+EFLFgOOmOOF9TMhQxHJZJ7u/BZm8DHmQbvGwf
   jBIvFzGh1GnOKyl+u9As0Vbi4CkfAoS9beW3GqKdrpuWjBEe94j0HsUA2
   yPvN/v5dauCqcPIlLYCnf8v6rMXU9jW4kLePlak85zFmG720nZE0TThDS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405543664"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="405543664"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:40:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773185264"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="773185264"
Received: from sdwarak1-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.127.200])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:40:00 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        clabbe@baylibre.com, daniele.alessandrelli@intel.com,
        prabhjot.khurana@intel.com, mgross@linux.intel.com,
        declan.murphy@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 2/3] crypto: ixp4xx - Move driver to drivers/crypto/intel/ixp4xx
Date:   Tue, 28 Mar 2023 10:39:50 -0500
Message-Id: <20230328153951.126564-3-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328153951.126564-1-tom.zanussi@linux.intel.com>
References: <20230328153951.126564-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the growing number of Intel crypto drivers, it makes sense to
group them all into a single drivers/crypto/intel/ directory.

Create a separate drivers/crypto/intel/ixp4xx directory and move
drivers/crypto/ixp4xx_crypto.c to it, along with a new Kconfig and
Makefile to contain the config and make bits.

Also add a COMPILE_TEST dependency to CRYPTO_DEV_IXP4XX so it can be
more easily compile-tested.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 MAINTAINERS                                       |  4 ++--
 drivers/crypto/Kconfig                            | 15 ---------------
 drivers/crypto/Makefile                           |  1 -
 drivers/crypto/intel/Kconfig                      |  1 +
 drivers/crypto/intel/Makefile                     |  1 +
 drivers/crypto/intel/ixp4xx/Kconfig               | 14 ++++++++++++++
 drivers/crypto/intel/ixp4xx/Makefile              |  2 ++
 drivers/crypto/{ => intel/ixp4xx}/ixp4xx_crypto.c |  0
 8 files changed, 20 insertions(+), 18 deletions(-)
 create mode 100644 drivers/crypto/intel/ixp4xx/Kconfig
 create mode 100644 drivers/crypto/intel/ixp4xx/Makefile
 rename drivers/crypto/{ => intel/ixp4xx}/ixp4xx_crypto.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0054dc0e5f0b..e49d331aba47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2275,7 +2275,7 @@ F:	arch/arm/boot/dts/intel-ixp*
 F:	arch/arm/mach-ixp4xx/
 F:	drivers/bus/intel-ixp4xx-eb.c
 F:	drivers/clocksource/timer-ixp4xx.c
-F:	drivers/crypto/ixp4xx_crypto.c
+F:	drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
 F:	drivers/gpio/gpio-ixp4xx.c
 F:	drivers/irqchip/irq-ixp4xx.c
 
@@ -10387,7 +10387,7 @@ INTEL IXP4XX CRYPTO SUPPORT
 M:	Corentin Labbe <clabbe@baylibre.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
-F:	drivers/crypto/ixp4xx_crypto.c
+F:	drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
 
 INTEL ISHTP ECLITE DRIVER
 M:	Sumesh K Naduvalath <sumesh.k.naduvalath@intel.com>
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index e8d9fc954121..007299bcd36c 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -240,21 +240,6 @@ config CRYPTO_DEV_TALITOS2
 	  Say 'Y' here to use the Freescale Security Engine (SEC)
 	  version 2 and following as found on MPC83xx, MPC85xx, etc ...
 
-config CRYPTO_DEV_IXP4XX
-	tristate "Driver for IXP4xx crypto hardware acceleration"
-	depends on ARCH_IXP4XX && IXP4XX_QMGR && IXP4XX_NPE
-	select CRYPTO_AES
-	select CRYPTO_DES
-	select CRYPTO_ECB
-	select CRYPTO_CBC
-	select CRYPTO_CTR
-	select CRYPTO_LIB_DES
-	select CRYPTO_AEAD
-	select CRYPTO_AUTHENC
-	select CRYPTO_SKCIPHER
-	help
-	  Driver for the IXP4xx NPE crypto engine.
-
 config CRYPTO_DEV_PPC4XX
 	tristate "Driver AMCC PPC4xx crypto accelerator"
 	depends on PPC && 4xx
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index eb8eb80aab3b..17f323718b6a 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_CRYPTO_DEV_FSL_CAAM_COMMON) += caam/
 obj-$(CONFIG_CRYPTO_DEV_GEODE) += geode-aes.o
 obj-$(CONFIG_CRYPTO_DEV_HIFN_795X) += hifn_795x.o
 obj-$(CONFIG_CRYPTO_DEV_IMGTEC_HASH) += img-hash.o
-obj-$(CONFIG_CRYPTO_DEV_IXP4XX) += ixp4xx_crypto.o
 obj-$(CONFIG_CRYPTO_DEV_MARVELL) += marvell/
 obj-$(CONFIG_CRYPTO_DEV_MXS_DCP) += mxs-dcp.o
 obj-$(CONFIG_CRYPTO_DEV_NIAGARA2) += n2_crypto.o
diff --git a/drivers/crypto/intel/Kconfig b/drivers/crypto/intel/Kconfig
index 6a9abdf38422..a777e558b004 100644
--- a/drivers/crypto/intel/Kconfig
+++ b/drivers/crypto/intel/Kconfig
@@ -2,3 +2,4 @@
 
 source "drivers/crypto/intel/iaa/Kconfig"
 source "drivers/crypto/intel/keembay/Kconfig"
+source "drivers/crypto/intel/ixp4xx/Kconfig"
diff --git a/drivers/crypto/intel/Makefile b/drivers/crypto/intel/Makefile
index 159a5fd3e9ac..93a3cf3a8703 100644
--- a/drivers/crypto/intel/Makefile
+++ b/drivers/crypto/intel/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) += iaa/
 obj-y += keembay/
+obj-y += ixp4xx/
diff --git a/drivers/crypto/intel/ixp4xx/Kconfig b/drivers/crypto/intel/ixp4xx/Kconfig
new file mode 100644
index 000000000000..af3cc5688328
--- /dev/null
+++ b/drivers/crypto/intel/ixp4xx/Kconfig
@@ -0,0 +1,14 @@
+config CRYPTO_DEV_IXP4XX
+	tristate "Driver for IXP4xx crypto hardware acceleration"
+	depends on (ARCH_IXP4XX || COMPILE_TEST) && IXP4XX_QMGR && IXP4XX_NPE
+	select CRYPTO_AES
+	select CRYPTO_DES
+	select CRYPTO_ECB
+	select CRYPTO_CBC
+	select CRYPTO_CTR
+	select CRYPTO_LIB_DES
+	select CRYPTO_AEAD
+	select CRYPTO_AUTHENC
+	select CRYPTO_SKCIPHER
+	help
+	  Driver for the IXP4xx NPE crypto engine.
diff --git a/drivers/crypto/intel/ixp4xx/Makefile b/drivers/crypto/intel/ixp4xx/Makefile
new file mode 100644
index 000000000000..74ebefd93046
--- /dev/null
+++ b/drivers/crypto/intel/ixp4xx/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CRYPTO_DEV_IXP4XX) += ixp4xx_crypto.o
diff --git a/drivers/crypto/ixp4xx_crypto.c b/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
similarity index 100%
rename from drivers/crypto/ixp4xx_crypto.c
rename to drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
-- 
2.34.1

