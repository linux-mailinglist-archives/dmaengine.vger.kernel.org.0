Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67202FD7F7
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jan 2021 19:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404304AbhATSKq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jan 2021 13:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404108AbhATSK0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Jan 2021 13:10:26 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD9C0613C1
        for <dmaengine@vger.kernel.org>; Wed, 20 Jan 2021 10:09:31 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id n127so5979365ooa.13
        for <dmaengine@vger.kernel.org>; Wed, 20 Jan 2021 10:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7K9KBn9bqB04jrZILJlEhKRz8nOBafHD9qg+6ZogXcY=;
        b=Y05L323FDoV6AKTTz392NPub0X8DK+iYUHda1bZLzF/BArGroWw1wNZ3WUQuOIwbQ3
         nenqM5F2urm6eukQ8yCS88NiWyU3gcSCnkLPJnzjAL3HBni+fvUnP/GD4kXaGt/Nw22f
         v218FCXEm9INpFhKzseGOH/LoX86THTAGGRg4e/GXiFV15m7c9ttbjI8oL5YvkEBE97R
         tSEVGcOckszxiBd2aAJSoMA+n2BKCUS3GfuxEHveO4EL5rxX446Nd0NMqStkqiNpnx+o
         rRRZCHUfglWaHjglGMQF3ghqvKEUYWIJj0eilB9QakQpFwz7H0ycDbddYONqyuMQlEHC
         c7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7K9KBn9bqB04jrZILJlEhKRz8nOBafHD9qg+6ZogXcY=;
        b=CE3WAykes8YIt2puV+KUVT/aHUBJxHsJBtqpy53Pgqov4TE9CaCioP4lYKRka0Hzgi
         pRaNCM2fDzDlpnJlMBJKbMngGBnw0aQc/7eh4j3+wjgBd7JUF4fHK5ZcrKg9IPfzGJge
         DXM4WFctiVvI413LIjiGvxX/UD8zLO2LjgPcc3NkcbIIA5UtIzXr1/WLIgzkVqp8pD/J
         sLjmnU6q2yVK5lrDVCSUUFUq+RCg7GVkC1sXwm6Ge98FQIPGcsUY/C6Ct6usyQfroNfN
         qC96dGxwkssXIfRAyWLpsDnVs5+kIb5Fcqf4XjOXlNhQ1DtBH6aULwHP4v8LOypbc4OY
         YK4A==
X-Gm-Message-State: AOAM530blalF/594RzIqV+92KIpk6guO3yLZvUOXXLWP4bvedXdFmHER
        ghntuwvvUclm5LqGjaLFkaDWRA==
X-Google-Smtp-Source: ABdhPJwg/06sM/oK9/QGoc/MFPdAr2NH9zCbF5vyGBQIfPrV63QgbluXPkmyF/waaMwusJjN2+VdTw==
X-Received: by 2002:a4a:9f47:: with SMTP id d7mr6980105ool.23.1611166171359;
        Wed, 20 Jan 2021 10:09:31 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n124sm513578oig.33.2021.01.20.10.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:09:30 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        chuanhua.lei@intel.com,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: intel-ldma: Fix $ref specifier
Date:   Wed, 20 Jan 2021 10:09:39 -0800
Message-Id: <20210120180939.1580984-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The $ref for "intel,dma-poll-cnt" is missing an '/', causing
dt_binding_check to fail. Fix this.

Fixes: afd4df85602d ("dt-bindings: dma: Add bindings for Intel LGM SoC")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/dma/intel,ldma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
index 866d4c758a7a..a5c4be783593 100644
--- a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
+++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
@@ -56,7 +56,7 @@ properties:
     maxItems: 1
 
   intel,dma-poll-cnt:
-    $ref: /schemas/types.yaml#definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       DMA descriptor polling counter is used to control the poling mechanism
       for the descriptor fetching for all channels.
-- 
2.29.2

