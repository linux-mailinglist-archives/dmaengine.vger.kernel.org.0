Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FAA5F018E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 01:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiI2Xs3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 19:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiI2Xs2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 19:48:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B981FBCB5
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:48:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 78so2746445pgb.13
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dTDmxuFs3z7wPKBAGhH0lbmw9ej4hIfQh/7fOzv8B9k=;
        b=OknPLF3QhruqHGOFUgdMYe9vU9jMRxOvbCrmgnSUfE3QRVGsP+SByYmW+j5DGfAgbI
         3GZNyJx+uMMG48/QlFGttyOQy40rvLStFHGVfWwKx+t8aU/x0vbC2EJ7jWhzYneesVF6
         Dx1XPXoscxUwRBl8K2JRtCXt963On/O3WJvkzOCtPjasR5oLPo710+m7bvuCxktxXp7/
         kGaLctd08wbrf4jtURlVOkcTGul2Bb+N9I9sWz2ISyBD8IQ9XKfKJ8HKnO+pEauGJTPg
         Ja/wZxrd3xO9k/RxvqpKgnU8n8gc8DCcFikh8dRrRY11j3BT/qpfVr9dg1b84bW7ZBQV
         fCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dTDmxuFs3z7wPKBAGhH0lbmw9ej4hIfQh/7fOzv8B9k=;
        b=RNjsMh3BdyLXinDmVSuuJ/MmcAtCIbNb7IX6JDUc8ykMK6pUkSxCb6qknQf3VUP7mP
         43yOK9fVgUdQjxKidiEOIOlIAC+Kx07ZR03UBQ5LcHMO0lyPOgiK2rbIgMEbPbFGA2kZ
         nP+533OkA4e5eSteQcuUST7zDiSAB5i3dkcicpXtUB+Rkp4oSXTDlFglZqp67jwck0V4
         ChQgquybfWPAHrmspdA5Y8sWuMkh6kF9ZOPypeTizTDhdHaxkMDi37zG/DfgbujlFaP3
         19b4kKaXO2e9UboFI6K6jwUOPqGNJsF9L5sHrcZUwDJNQVclLc1jGpKz6smwOw8y6BwY
         o5lA==
X-Gm-Message-State: ACrzQf361JaafWNwYUUmr//uazAvCYW9I8iq8jN/UXwoRVmGK75woWLi
        aYu3GdvyNwbaqcwMKqmkP6wn4WuXM5gpqg==
X-Google-Smtp-Source: AMsMyM7FwShIBExasb/b3zh/05Qz4LcRzwNLRfz7dvkYRrbOQGa3E6KtJuuhDK9TPVTm5VBDPBgmIA==
X-Received: by 2002:a62:6085:0:b0:53e:7874:5067 with SMTP id u127-20020a626085000000b0053e78745067mr6062525pfb.4.1664495307142;
        Thu, 29 Sep 2022 16:48:27 -0700 (PDT)
Received: from localhost ([75.172.140.17])
        by smtp.gmail.com with ESMTPSA id b2-20020a621b02000000b00536aa488062sm244055pfb.163.2022.09.29.16.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:48:26 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: [PATCH v3 3/3] dmaengine: ti: convert PSIL to be buildable as module
Date:   Thu, 29 Sep 2022 16:48:20 -0700
Message-Id: <20220929234820.940048-4-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220929234820.940048-1-khilman@baylibre.com>
References: <20220929234820.940048-1-khilman@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Combine all the SoC specific files into a single lib that can be
built-in or built as a module.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/dma/ti/Kconfig   |  3 ++-
 drivers/dma/ti/Makefile  | 15 ++++++++-------
 drivers/dma/ti/k3-psil.c |  2 ++
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index f196be3b222f..2adc2cca10e9 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -56,7 +56,8 @@ config TI_K3_UDMA_GLUE_LAYER
 	  If unsure, say N.
 
 config TI_K3_PSIL
-	bool
+       tristate
+       default TI_K3_UDMA
 
 config TI_DMA_CROSSBAR
 	bool
diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index d3a303f0d7c6..b53d05b11ca5 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -4,11 +4,12 @@ obj-$(CONFIG_TI_EDMA) += edma.o
 obj-$(CONFIG_DMA_OMAP) += omap-dma.o
 obj-$(CONFIG_TI_K3_UDMA) += k3-udma.o
 obj-$(CONFIG_TI_K3_UDMA_GLUE_LAYER) += k3-udma-glue.o
-obj-$(CONFIG_TI_K3_PSIL) += k3-psil.o \
-			    k3-psil-am654.o \
-			    k3-psil-j721e.o \
-			    k3-psil-j7200.o \
-			    k3-psil-am64.o \
-			    k3-psil-j721s2.o \
-			    k3-psil-am62.o
+k3-psil-lib-objs := k3-psil.o \
+		    k3-psil-am654.o \
+		    k3-psil-j721e.o \
+		    k3-psil-j7200.o \
+		    k3-psil-am64.o \
+		    k3-psil-j721s2.o \
+		    k3-psil-am62.o
+obj-$(CONFIG_TI_K3_PSIL) += k3-psil-lib.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index 761a384093d2..8b6533a1eeeb 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
@@ -101,3 +102,4 @@ int psil_set_new_ep_config(struct device *dev, const char *name,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(psil_set_new_ep_config);
+MODULE_LICENSE("GPL v2");
-- 
2.34.0

