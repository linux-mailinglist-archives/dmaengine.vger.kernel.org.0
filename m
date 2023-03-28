Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E358C6CC6DD
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjC1Plj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjC1PlR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:41:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4483111E9D;
        Tue, 28 Mar 2023 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018017; x=1711554017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKDrUlG2J6CW2hsz7Kqgy/KuKtUut2UIBgLdc048xRo=;
  b=H6QvKYyMWqIwQbByefi7b10rSsNazElwXJLr1MUWncivjpskJnLBlaHw
   RCO1PEPRNX+8u0GWm3AUyRMAc6+irW3OAgMzZyUvoPL40e4rPtyol9R+Y
   TQR3n7TVaNnlxcFIzLecNXPXKXumhYsf96h4NCEZM3Lk1E4rJql709Bk0
   FPEVH4oysVzKRQBoCBHoNAE6M3wAFPLdg1PA+TKAsRh4GwyjAUeOwVO/k
   JYeHlj7nhL/uZ4kfPcS8v+GKkbrHg3F65Q+jVdGlILrZ3vevHwBCDfJaj
   LVV74lK9YkG9bnKGALwAj9ntz+u5PuCUfsilY6cBcqSPZI8xC3pMjbX6k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405543650"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="405543650"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773185241"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="773185241"
Received: from sdwarak1-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.127.200])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:39:57 -0700
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
Subject: [PATCH 1/3] crypto: keembay - Move driver to drivers/crypto/intel/keembay
Date:   Tue, 28 Mar 2023 10:39:49 -0500
Message-Id: <20230328153951.126564-2-tom.zanussi@linux.intel.com>
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

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 MAINTAINERS                                   | 26 +++++++++----------
 drivers/crypto/Kconfig                        |  1 -
 drivers/crypto/Makefile                       |  1 -
 drivers/crypto/intel/Kconfig                  |  1 +
 drivers/crypto/intel/Makefile                 |  1 +
 drivers/crypto/{ => intel}/keembay/Kconfig    |  0
 drivers/crypto/{ => intel}/keembay/Makefile   |  0
 .../keembay/keembay-ocs-aes-core.c            |  0
 .../{ => intel}/keembay/keembay-ocs-ecc.c     |  0
 .../keembay/keembay-ocs-hcu-core.c            |  0
 drivers/crypto/{ => intel}/keembay/ocs-aes.c  |  0
 drivers/crypto/{ => intel}/keembay/ocs-aes.h  |  0
 drivers/crypto/{ => intel}/keembay/ocs-hcu.c  |  0
 drivers/crypto/{ => intel}/keembay/ocs-hcu.h  |  0
 14 files changed, 15 insertions(+), 15 deletions(-)
 rename drivers/crypto/{ => intel}/keembay/Kconfig (100%)
 rename drivers/crypto/{ => intel}/keembay/Makefile (100%)
 rename drivers/crypto/{ => intel}/keembay/keembay-ocs-aes-core.c (100%)
 rename drivers/crypto/{ => intel}/keembay/keembay-ocs-ecc.c (100%)
 rename drivers/crypto/{ => intel}/keembay/keembay-ocs-hcu-core.c (100%)
 rename drivers/crypto/{ => intel}/keembay/ocs-aes.c (100%)
 rename drivers/crypto/{ => intel}/keembay/ocs-aes.h (100%)
 rename drivers/crypto/{ => intel}/keembay/ocs-hcu.c (100%)
 rename drivers/crypto/{ => intel}/keembay/ocs-hcu.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2db8b4940de8..0054dc0e5f0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10422,11 +10422,11 @@ INTEL KEEM BAY OCS AES/SM4 CRYPTO DRIVER
 M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/intel,keembay-ocs-aes.yaml
-F:	drivers/crypto/keembay/Kconfig
-F:	drivers/crypto/keembay/Makefile
-F:	drivers/crypto/keembay/keembay-ocs-aes-core.c
-F:	drivers/crypto/keembay/ocs-aes.c
-F:	drivers/crypto/keembay/ocs-aes.h
+F:	drivers/crypto/intel/keembay/Kconfig
+F:	drivers/crypto/intel/keembay/Makefile
+F:	drivers/crypto/intel/keembay/keembay-ocs-aes-core.c
+F:	drivers/crypto/intel/keembay/ocs-aes.c
+F:	drivers/crypto/intel/keembay/ocs-aes.h
 
 INTEL KEEM BAY OCS ECC CRYPTO DRIVER
 M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
@@ -10434,20 +10434,20 @@ M:	Prabhjot Khurana <prabhjot.khurana@intel.com>
 M:	Mark Gross <mgross@linux.intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/intel,keembay-ocs-ecc.yaml
-F:	drivers/crypto/keembay/Kconfig
-F:	drivers/crypto/keembay/Makefile
-F:	drivers/crypto/keembay/keembay-ocs-ecc.c
+F:	drivers/crypto/intel/keembay/Kconfig
+F:	drivers/crypto/intel/keembay/Makefile
+F:	drivers/crypto/intel/keembay/keembay-ocs-ecc.c
 
 INTEL KEEM BAY OCS HCU CRYPTO DRIVER
 M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
 M:	Declan Murphy <declan.murphy@intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/intel,keembay-ocs-hcu.yaml
-F:	drivers/crypto/keembay/Kconfig
-F:	drivers/crypto/keembay/Makefile
-F:	drivers/crypto/keembay/keembay-ocs-hcu-core.c
-F:	drivers/crypto/keembay/ocs-hcu.c
-F:	drivers/crypto/keembay/ocs-hcu.h
+F:	drivers/crypto/intel/keembay/Kconfig
+F:	drivers/crypto/intel/keembay/Makefile
+F:	drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
+F:	drivers/crypto/intel/keembay/ocs-hcu.c
+F:	drivers/crypto/intel/keembay/ocs-hcu.h
 
 INTEL THUNDER BAY EMMC PHY DRIVER
 M:	Nandhini Srikandan <nandhini.srikandan@intel.com>
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 56466eeb4eef..e8d9fc954121 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -821,7 +821,6 @@ config CRYPTO_DEV_SA2UL
 	  used for crypto offload.  Select this if you want to use hardware
 	  acceleration for cryptographic algorithms on these devices.
 
-source "drivers/crypto/keembay/Kconfig"
 source "drivers/crypto/aspeed/Kconfig"
 
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 34c1e60d9dd1..eb8eb80aab3b 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -51,5 +51,4 @@ obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
 obj-y += xilinx/
 obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
-obj-y += keembay/
 obj-y += intel/
diff --git a/drivers/crypto/intel/Kconfig b/drivers/crypto/intel/Kconfig
index 7c9f51b873ea..6a9abdf38422 100644
--- a/drivers/crypto/intel/Kconfig
+++ b/drivers/crypto/intel/Kconfig
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 source "drivers/crypto/intel/iaa/Kconfig"
+source "drivers/crypto/intel/keembay/Kconfig"
diff --git a/drivers/crypto/intel/Makefile b/drivers/crypto/intel/Makefile
index b1263f1f90cc..159a5fd3e9ac 100644
--- a/drivers/crypto/intel/Makefile
+++ b/drivers/crypto/intel/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) += iaa/
+obj-y += keembay/
diff --git a/drivers/crypto/keembay/Kconfig b/drivers/crypto/intel/keembay/Kconfig
similarity index 100%
rename from drivers/crypto/keembay/Kconfig
rename to drivers/crypto/intel/keembay/Kconfig
diff --git a/drivers/crypto/keembay/Makefile b/drivers/crypto/intel/keembay/Makefile
similarity index 100%
rename from drivers/crypto/keembay/Makefile
rename to drivers/crypto/intel/keembay/Makefile
diff --git a/drivers/crypto/keembay/keembay-ocs-aes-core.c b/drivers/crypto/intel/keembay/keembay-ocs-aes-core.c
similarity index 100%
rename from drivers/crypto/keembay/keembay-ocs-aes-core.c
rename to drivers/crypto/intel/keembay/keembay-ocs-aes-core.c
diff --git a/drivers/crypto/keembay/keembay-ocs-ecc.c b/drivers/crypto/intel/keembay/keembay-ocs-ecc.c
similarity index 100%
rename from drivers/crypto/keembay/keembay-ocs-ecc.c
rename to drivers/crypto/intel/keembay/keembay-ocs-ecc.c
diff --git a/drivers/crypto/keembay/keembay-ocs-hcu-core.c b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
similarity index 100%
rename from drivers/crypto/keembay/keembay-ocs-hcu-core.c
rename to drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
diff --git a/drivers/crypto/keembay/ocs-aes.c b/drivers/crypto/intel/keembay/ocs-aes.c
similarity index 100%
rename from drivers/crypto/keembay/ocs-aes.c
rename to drivers/crypto/intel/keembay/ocs-aes.c
diff --git a/drivers/crypto/keembay/ocs-aes.h b/drivers/crypto/intel/keembay/ocs-aes.h
similarity index 100%
rename from drivers/crypto/keembay/ocs-aes.h
rename to drivers/crypto/intel/keembay/ocs-aes.h
diff --git a/drivers/crypto/keembay/ocs-hcu.c b/drivers/crypto/intel/keembay/ocs-hcu.c
similarity index 100%
rename from drivers/crypto/keembay/ocs-hcu.c
rename to drivers/crypto/intel/keembay/ocs-hcu.c
diff --git a/drivers/crypto/keembay/ocs-hcu.h b/drivers/crypto/intel/keembay/ocs-hcu.h
similarity index 100%
rename from drivers/crypto/keembay/ocs-hcu.h
rename to drivers/crypto/intel/keembay/ocs-hcu.h
-- 
2.34.1

