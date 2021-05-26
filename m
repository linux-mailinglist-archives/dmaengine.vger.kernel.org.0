Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F8A391BCF
	for <lists+dmaengine@lfdr.de>; Wed, 26 May 2021 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhEZP02 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 May 2021 11:26:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59372 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhEZP0T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 May 2021 11:26:19 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QFOG0P001753;
        Wed, 26 May 2021 10:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622042656;
        bh=Fm+hVjRUGJmwYKDMUjbdou43Vw1Zw5cGhop7i6WK2Zs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mJADvKwfSNQGntLrVQzyXdzhQgYPK85gcVyr5brT2ja4ajBfvlAvS43uC2fTLd38t
         CoMIpUpo+39B2+6hELvgwNKcG5xOx4rSFp4oyVX16jdUbV5mGiGJa2ElGiwTQB1tkS
         GIi1F0jD6RO8Z+Qt17SSCWz9wdnVgT2+7u8vApQ8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QFOGxk079325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 10:24:16 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 10:24:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 10:24:16 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QFN9Jk056314;
        Wed, 26 May 2021 10:24:11 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <dmaengine@vger.kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 12/18] media: Re-structure TI platform drivers
Date:   Wed, 26 May 2021 20:53:02 +0530
Message-ID: <20210526152308.16525-13-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210526152308.16525-1-p.yadav@ti.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The ti-vpe/ sub-directory does not only contain the VPE-specific things.
It also contains the CAL driver, which is a completely different
subsystem. This is also not a good place to add new drivers for other TI
platforms since they will all get mixed up.

Separate the VPE and CAL parts into different sub-directories and rename
the ti-vpe/ sub-directory to ti/. This is now the place where new TI
platform drivers can be added.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---
Compile tested only. There should be no functional change.

Changes in v2:
- New in v2.

 MAINTAINERS                                              | 3 ++-
 drivers/media/platform/Makefile                          | 2 +-
 drivers/media/platform/ti/Makefile                       | 3 +++
 drivers/media/platform/ti/cal/Makefile                   | 3 +++
 drivers/media/platform/{ti-vpe => ti/cal}/cal-camerarx.c | 0
 drivers/media/platform/{ti-vpe => ti/cal}/cal-video.c    | 0
 drivers/media/platform/{ti-vpe => ti/cal}/cal.c          | 0
 drivers/media/platform/{ti-vpe => ti/cal}/cal.h          | 0
 drivers/media/platform/{ti-vpe => ti/cal}/cal_regs.h     | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/Makefile       | 4 ----
 drivers/media/platform/{ti-vpe => ti/vpe}/csc.c          | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/csc.h          | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/sc.c           | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/sc.h           | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/sc_coeff.h     | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/vpdma.c        | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/vpdma.h        | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/vpdma_priv.h   | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/vpe.c          | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/vpe_regs.h     | 0
 20 files changed, 9 insertions(+), 6 deletions(-)
 create mode 100644 drivers/media/platform/ti/Makefile
 create mode 100644 drivers/media/platform/ti/cal/Makefile
 rename drivers/media/platform/{ti-vpe => ti/cal}/cal-camerarx.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/cal}/cal-video.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/cal}/cal.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/cal}/cal.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/cal}/cal_regs.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/Makefile (78%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/csc.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/csc.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/sc.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/sc.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/sc_coeff.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpdma.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpdma.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpdma_priv.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpe.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpe_regs.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 710203d794d7..607dd5e18e7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18449,7 +18449,8 @@ W:	http://linuxtv.org/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	Documentation/devicetree/bindings/media/ti,cal.yaml
 F:	Documentation/devicetree/bindings/media/ti,vpe.yaml
-F:	drivers/media/platform/ti-vpe/
+F:	drivers/media/platform/ti/cal/
+F:	drivers/media/platform/ti/vpe/
 
 TI WILINK WIRELESS DRIVERS
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index eedc14aafb32..5ddfa5bc02e1 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_VIDEO_PXA27x)	+= pxa_camera.o
 
 obj-$(CONFIG_VIDEO_VIU) += fsl-viu.o
 
-obj-y	+= ti-vpe/
+obj-y	+= ti/
 
 obj-$(CONFIG_VIDEO_MX2_EMMAPRP)		+= mx2_emmaprp.o
 obj-$(CONFIG_VIDEO_CODA)		+= coda/
diff --git a/drivers/media/platform/ti/Makefile b/drivers/media/platform/ti/Makefile
new file mode 100644
index 000000000000..bbc737ccbbea
--- /dev/null
+++ b/drivers/media/platform/ti/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y += cal/
+obj-y += vpe/
diff --git a/drivers/media/platform/ti/cal/Makefile b/drivers/media/platform/ti/cal/Makefile
new file mode 100644
index 000000000000..45ac35585f0b
--- /dev/null
+++ b/drivers/media/platform/ti/cal/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_VIDEO_TI_CAL) += ti-cal.o
+ti-cal-y := cal.o cal-camerarx.o cal-video.o
diff --git a/drivers/media/platform/ti-vpe/cal-camerarx.c b/drivers/media/platform/ti/cal/cal-camerarx.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/cal-camerarx.c
rename to drivers/media/platform/ti/cal/cal-camerarx.c
diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti/cal/cal-video.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/cal-video.c
rename to drivers/media/platform/ti/cal/cal-video.c
diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti/cal/cal.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/cal.c
rename to drivers/media/platform/ti/cal/cal.c
diff --git a/drivers/media/platform/ti-vpe/cal.h b/drivers/media/platform/ti/cal/cal.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/cal.h
rename to drivers/media/platform/ti/cal/cal.h
diff --git a/drivers/media/platform/ti-vpe/cal_regs.h b/drivers/media/platform/ti/cal/cal_regs.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/cal_regs.h
rename to drivers/media/platform/ti/cal/cal_regs.h
diff --git a/drivers/media/platform/ti-vpe/Makefile b/drivers/media/platform/ti/vpe/Makefile
similarity index 78%
rename from drivers/media/platform/ti-vpe/Makefile
rename to drivers/media/platform/ti/vpe/Makefile
index ad624056e039..3fadfe084f87 100644
--- a/drivers/media/platform/ti-vpe/Makefile
+++ b/drivers/media/platform/ti/vpe/Makefile
@@ -10,7 +10,3 @@ ti-sc-y := sc.o
 ti-csc-y := csc.o
 
 ccflags-$(CONFIG_VIDEO_TI_VPE_DEBUG) += -DDEBUG
-
-obj-$(CONFIG_VIDEO_TI_CAL) += ti-cal.o
-
-ti-cal-y := cal.o cal-camerarx.o cal-video.o
diff --git a/drivers/media/platform/ti-vpe/csc.c b/drivers/media/platform/ti/vpe/csc.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/csc.c
rename to drivers/media/platform/ti/vpe/csc.c
diff --git a/drivers/media/platform/ti-vpe/csc.h b/drivers/media/platform/ti/vpe/csc.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/csc.h
rename to drivers/media/platform/ti/vpe/csc.h
diff --git a/drivers/media/platform/ti-vpe/sc.c b/drivers/media/platform/ti/vpe/sc.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/sc.c
rename to drivers/media/platform/ti/vpe/sc.c
diff --git a/drivers/media/platform/ti-vpe/sc.h b/drivers/media/platform/ti/vpe/sc.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/sc.h
rename to drivers/media/platform/ti/vpe/sc.h
diff --git a/drivers/media/platform/ti-vpe/sc_coeff.h b/drivers/media/platform/ti/vpe/sc_coeff.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/sc_coeff.h
rename to drivers/media/platform/ti/vpe/sc_coeff.h
diff --git a/drivers/media/platform/ti-vpe/vpdma.c b/drivers/media/platform/ti/vpe/vpdma.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/vpdma.c
rename to drivers/media/platform/ti/vpe/vpdma.c
diff --git a/drivers/media/platform/ti-vpe/vpdma.h b/drivers/media/platform/ti/vpe/vpdma.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/vpdma.h
rename to drivers/media/platform/ti/vpe/vpdma.h
diff --git a/drivers/media/platform/ti-vpe/vpdma_priv.h b/drivers/media/platform/ti/vpe/vpdma_priv.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/vpdma_priv.h
rename to drivers/media/platform/ti/vpe/vpdma_priv.h
diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti/vpe/vpe.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/vpe.c
rename to drivers/media/platform/ti/vpe/vpe.c
diff --git a/drivers/media/platform/ti-vpe/vpe_regs.h b/drivers/media/platform/ti/vpe/vpe_regs.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/vpe_regs.h
rename to drivers/media/platform/ti/vpe/vpe_regs.h
-- 
2.30.0

