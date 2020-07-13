Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF2C21D4A7
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2020 13:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgGMLRA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jul 2020 07:17:00 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:35130 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgGMLRA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Jul 2020 07:17:00 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 0456FBC0E4;
        Mon, 13 Jul 2020 11:16:52 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     vkoul@kernel.org, dan.j.williams@intel.com, vz@mleia.com,
        peter.ujfalusi@ti.com, wenwen@cs.uga.edu, chenqiwu@xiaomi.com,
        grygorii.strashko@ti.com, christophe.jaillet@wanadoo.fr,
        zou_wei@huawei.com, colin.king@canonical.com,
        gustavoars@kernel.org, vigneshr@ti.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] dmaengine: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 13:16:46 +0200
Message-Id: <20200713111646.33625-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 drivers/dma/Kconfig              | 2 +-
 drivers/dma/lpc18xx-dmamux.c     | 2 +-
 drivers/dma/of-dma.c             | 2 +-
 drivers/dma/ti/dma-crossbar.c    | 2 +-
 drivers/dma/ti/k3-psil-am654.c   | 2 +-
 drivers/dma/ti/k3-psil-j721e.c   | 2 +-
 drivers/dma/ti/k3-psil-priv.h    | 2 +-
 drivers/dma/ti/k3-psil.c         | 2 +-
 drivers/dma/ti/k3-udma-glue.c    | 2 +-
 drivers/dma/ti/k3-udma-private.c | 2 +-
 drivers/dma/ti/k3-udma.c         | 2 +-
 drivers/dma/ti/k3-udma.h         | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index de41d7928bff..c7f3d4f2ba9e 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -333,7 +333,7 @@ config INTEL_MIC_X100_DMA
 
 	  More information about the Intel MIC family as well as the Linux
 	  OS and tools for MIC to use with this driver are available from
-	  <http://software.intel.com/en-us/mic-developer>.
+	  <https://software.intel.com/en-us/mic-developer>.
 
 config K3_DMA
 	tristate "Hisilicon K3 DMA support"
diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
index df98cae8792b..f3048340ad78 100644
--- a/drivers/dma/lpc18xx-dmamux.c
+++ b/drivers/dma/lpc18xx-dmamux.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
  *
  * Based on TI DMA Crossbar driver by:
- *   Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ *   Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  *   Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index b2c2b5e8093c..7c35f20d7cd6 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -4,7 +4,7 @@
  *
  * Based on of_gpio.c
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/device.h>
diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index 4ba8fa5d9c36..d6d16c066042 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 #include <linux/slab.h>
diff --git a/drivers/dma/ti/k3-psil-am654.c b/drivers/dma/ti/k3-psil-am654.c
index a896a15908cf..e3821e4dd44e 100644
--- a/drivers/dma/ti/k3-psil-am654.c
+++ b/drivers/dma/ti/k3-psil-am654.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
index e3cfd5f66842..758d5d331c34 100644
--- a/drivers/dma/ti/k3-psil-j721e.c
+++ b/drivers/dma/ti/k3-psil-j721e.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index a1f389ca371e..23eddd2fdbd3 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #ifndef K3_PSIL_PRIV_H_
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index fb7c8150b0d1..ac2068dac70f 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 64c8955e0cf1..ecf3ed3178e1 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -2,7 +2,7 @@
 /*
  * K3 NAVSS DMA glue interface
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *
  */
 
diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 0b8f3dd6b146..32128beeceb2 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c91e2dc1bb72..e0b87b9d1d95 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 128d8744a435..09798c2820af 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #ifndef K3_UDMA_H_
-- 
2.27.0

