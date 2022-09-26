Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9495EAFA2
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 20:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIZSWo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 14:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIZSWU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 14:22:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EFD6E88F
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 11:18:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b75so7506536pfb.7
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XxwI1lYNO39OjWf2d6ldhB9aHI8zuvkxn0q3dnQxszo=;
        b=iVz3vqrj/T1ywRrTCiHZSPbDCmMkYJTH0qD5syWgfCu72i4LPxBekt2F+SHBlK8t6E
         8DGkugVtwh6/AQCfO5FYarI34Xynd+Uz9gblBiEgdCKzN2U/fGZaedeG2rtTtvBK4UMM
         XpDqAkHHTgqqqlJrjMnckfjt+1uvh4RiifoLRvRSMieFWqlmP3kwiljm6roZjn60XVDI
         1G2DcAz/cv7Gg3coJFLHBfGT622A73D+Esrx222/kodZlXfddmimnPXuusCwSLGj4M8Z
         x7vnF7oFghuqEQ9EN5AKiBBBHtB/bPLlhj2kq73xvmF9tDjXDel1uVcqr8b9nApAHZHz
         bOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XxwI1lYNO39OjWf2d6ldhB9aHI8zuvkxn0q3dnQxszo=;
        b=YhOYbBQqcc07qZHIWl5w+z5eS2HxMRcrEL/ag28EVbLBLVcZ5RzIY4uWL8aBs6u7K0
         OIYr72OXuEw1x6JQ8EXgsqYPB5SaMixGr6rj7+MGDGw+n6F1I3rsG5ONgUUjH7uAQYax
         GDSrCWBQPt6U1oJz90yH74NsjoCJgmeGPIAfeBMVjE4dmXwJtvZDzgxaVQQNUjk2eiJ9
         J5VXNbsL6ym4azYGIBUYjxOJjposvyv9DBZH8gc5uquLAMQzAKldY5mKrTcAZCP+5Ekw
         47EfIyOu5Efh+Qn4yYWrlnSOsEWkcZzwU+jc3a/MeBj5opREqW6uhnFODbhF3WvTaUTe
         YJdA==
X-Gm-Message-State: ACrzQf1zi1tJEltyYlgLauNhnPXBy8nmt8lZhepw+BZKbxV12SWrvA8o
        NeFbNnLzAUMUgZCz5WTHVODOlQ==
X-Google-Smtp-Source: AMsMyM7o0uYgZR63cSzBGCvK/km8m/uY0V3mtzdIkpES1S3ItbVhIVp1LYEKmhlteR16wcvMb9JSbw==
X-Received: by 2002:a05:6a00:234a:b0:542:f9f2:72e5 with SMTP id j10-20020a056a00234a00b00542f9f272e5mr24782122pfj.34.1664216336816;
        Mon, 26 Sep 2022 11:18:56 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id 67-20020a621946000000b005379c1368e4sm12886365pfz.179.2022.09.26.11.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:18:55 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: [PATCH 3/3] dma/ti: convert PSIL to be buildable as module
Date:   Mon, 26 Sep 2022 11:18:48 -0700
Message-Id: <20220926181848.2917639-4-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220926181848.2917639-1-khilman@baylibre.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

map symbols need EXPORT_SYMBOL and files need MODULE_LICENSE.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/dma/ti/Kconfig          | 3 ++-
 drivers/dma/ti/k3-psil-am62.c   | 4 ++++
 drivers/dma/ti/k3-psil-am64.c   | 4 ++++
 drivers/dma/ti/k3-psil-am654.c  | 4 ++++
 drivers/dma/ti/k3-psil-j7200.c  | 4 ++++
 drivers/dma/ti/k3-psil-j721e.c  | 4 ++++
 drivers/dma/ti/k3-psil-j721s2.c | 4 ++++
 drivers/dma/ti/k3-psil.c        | 2 ++
 8 files changed, 28 insertions(+), 1 deletion(-)

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
diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am62.c
index 2b6fd6e37c61..7c4ca85f68b1 100644
--- a/drivers/dma/ti/k3-psil-am62.c
+++ b/drivers/dma/ti/k3-psil-am62.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 
 #include "k3-psil-priv.h"
 
@@ -184,3 +185,6 @@ struct psil_ep_map am62_ep_map = {
 	.dst = am62_dst_ep_map,
 	.dst_count = ARRAY_SIZE(am62_dst_ep_map),
 };
+EXPORT_SYMBOL_GPL(am62_ep_map);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-psil-am64.c b/drivers/dma/ti/k3-psil-am64.c
index 9fdeaa11a4fc..c579374feef9 100644
--- a/drivers/dma/ti/k3-psil-am64.c
+++ b/drivers/dma/ti/k3-psil-am64.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 
 #include "k3-psil-priv.h"
 
@@ -156,3 +157,6 @@ struct psil_ep_map am64_ep_map = {
 	.dst = am64_dst_ep_map,
 	.dst_count = ARRAY_SIZE(am64_dst_ep_map),
 };
+EXPORT_SYMBOL_GPL(am64_ep_map);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-psil-am654.c b/drivers/dma/ti/k3-psil-am654.c
index a896a15908cf..10db638b1178 100644
--- a/drivers/dma/ti/k3-psil-am654.c
+++ b/drivers/dma/ti/k3-psil-am654.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 
 #include "k3-psil-priv.h"
 
@@ -173,3 +174,6 @@ struct psil_ep_map am654_ep_map = {
 	.dst = am654_dst_ep_map,
 	.dst_count = ARRAY_SIZE(am654_dst_ep_map),
 };
+EXPORT_SYMBOL_GPL(am654_ep_map);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-psil-j7200.c b/drivers/dma/ti/k3-psil-j7200.c
index 5ea63ea74822..b7c638a5d140 100644
--- a/drivers/dma/ti/k3-psil-j7200.c
+++ b/drivers/dma/ti/k3-psil-j7200.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 
 #include "k3-psil-priv.h"
 
@@ -173,3 +174,6 @@ struct psil_ep_map j7200_ep_map = {
 	.dst = j7200_dst_ep_map,
 	.dst_count = ARRAY_SIZE(j7200_dst_ep_map),
 };
+EXPORT_SYMBOL_GPL(j7200_ep_map);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
index 34e3fc565a37..759e4a156acd 100644
--- a/drivers/dma/ti/k3-psil-j721e.c
+++ b/drivers/dma/ti/k3-psil-j721e.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 
 #include "k3-psil-priv.h"
 
@@ -296,3 +297,6 @@ struct psil_ep_map j721e_ep_map = {
 	.dst = j721e_dst_ep_map,
 	.dst_count = ARRAY_SIZE(j721e_dst_ep_map),
 };
+EXPORT_SYMBOL_GPL(j721e_ep_map);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-psil-j721s2.c b/drivers/dma/ti/k3-psil-j721s2.c
index a488c2250623..fd9e56851e59 100644
--- a/drivers/dma/ti/k3-psil-j721s2.c
+++ b/drivers/dma/ti/k3-psil-j721s2.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 
 #include "k3-psil-priv.h"
 
@@ -173,3 +174,6 @@ struct psil_ep_map j721s2_ep_map = {
 	.dst = j721s2_dst_ep_map,
 	.dst_count = ARRAY_SIZE(j721s2_dst_ep_map),
 };
+EXPORT_SYMBOL_GPL(j721s2_ep_map);
+
+MODULE_LICENSE("GPL v2");
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

