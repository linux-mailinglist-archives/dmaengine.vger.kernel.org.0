Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA4A6DCE04
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 01:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDJX1J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Apr 2023 19:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDJX1G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Apr 2023 19:27:06 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B862706;
        Mon, 10 Apr 2023 16:27:00 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1842d8976d9so7873569fac.9;
        Mon, 10 Apr 2023 16:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169219; x=1683761219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BKmejGlMSUvRsKggdx7LuEDnr/YS/2ZplY03ssRG4U=;
        b=movUC3gAmlCoYuQyb+6/LgXnSkvWz0ZpjW/9frQ35wmkqVFunKmlj0CFOAgE61qxTf
         YNtnH1Ju83lgVcb3I72M6dzff3Ho6Dc/5uF4zr5YsrVQB7/VwTgIeCFuBh29XitpWbKD
         g/jxTGoLQIScUsAeWqOsfADR+YMASb3NFAo8q8AKdp6unygsvxXIEv1/llpLQyFEZCv9
         lCOnJTCN3CjQg8mbxJHjK0D/ZnLqUFXpN5JEcAQORYgpgC2ceZAaFS2UADyTC+zSt9Ae
         WgVO/Cg6PTigJtnBmIOZGGxoVURRFonqLzvwSQDuii4kTCIguo1e/L1d5kKYTcPpaxmS
         ahyQ==
X-Gm-Message-State: AAQBX9db/0wHGGESV04iBffx+c1PQ5EXRwR7htUExn4CVtxjwsqrR70v
        YYyZzodcQ1BPvD45lIOjAA==
X-Google-Smtp-Source: AKy350YP1HVw5NSXCcsMrWBxIWHH6ye4QiUs/PQqLrcEaVkbdo/4RTY7AvL9YnboAJMGeir0LFPdIQ==
X-Received: by 2002:a05:6871:54e:b0:184:5395:4e44 with SMTP id t14-20020a056871054e00b0018453954e44mr2445990oal.28.1681169219638;
        Mon, 10 Apr 2023 16:26:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f5-20020a056870d30500b0017ae1aede32sm379829oag.46.2023.04.10.16.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:26:59 -0700 (PDT)
Received: (nullmailer pid 1561553 invoked by uid 1000);
        Mon, 10 Apr 2023 23:26:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: qcom_hidma: Add explicit platform_device.h and of_device.h includes
Date:   Mon, 10 Apr 2023 18:26:54 -0500
Message-Id: <20230410232654.1561462-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

qcom_hidma uses of_dma_configure() which is declared in of_device.h.
platform_device.h and of_device.h get implicitly included by of_platform.h,
but that is going to be removed soon.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/dma/qcom/hidma_mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 62026607f3f8..05e96b31d871 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -12,6 +12,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
-- 
2.39.2

