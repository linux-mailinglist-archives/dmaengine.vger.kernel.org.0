Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E2389133
	for <lists+dmaengine@lfdr.de>; Wed, 19 May 2021 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354209AbhESOi7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 May 2021 10:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354218AbhESOi5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 May 2021 10:38:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7A6C0613CE
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:37:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f22so1670133pfn.0
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0S2NRq33hx0y7mKlXaLULoVEPl4APjoeA2BRaVnZ5o=;
        b=sfvFuyxWjmZjZAxBOquDGbPTqjMKCbrBrHtTgp9axjDTcpQJ9e0tPcAhQbOoM5qJSs
         UE4XDbdRI3L6QFxx7P/4g9Qv3hVjK3bgOqPRiKrM/oxUDQ4PwWhNJFOPQ184nb2/Uw2D
         QdLjzYZX2DC5w+a4FkO1ffAShqhxTV2P0RfoR4AjCJWnfiE2XnN+0R08/gvUxw7wZ/ww
         L5B20kXkAgAGCmr8/0wyduEg6IqguU+iYdn3kBXYptsEgOCOnFL71FA+ECemetvRCbTe
         K8Qv4puPRqo4cynRJFSX2ZYrvdEgJlFOoU4NqeaKIT1Tbssq1OBG36JlpdDgiDbdKloP
         k9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0S2NRq33hx0y7mKlXaLULoVEPl4APjoeA2BRaVnZ5o=;
        b=KUOwlDg6SS+YsPVwgYj8x63djxa8xHLha4KmBWNvUfIMIeqRsV6HHNTF3b1+9dAZIB
         PgcHjSKxCa2LilycREKhjrObF6pGRl8O56077aX47SunTBN22Wl8OawGG4LPc00Yu6fI
         ESjjsG3mHjFi+KCYpq3Xb6YA6rIdHpiTe1cRm8wKbanoZ9zvpNCK/1YmWQ0FPnZkBvXX
         iJZzK0dd7uqKpbhI360OwKIrt4z4NDnbnaJJ1WEacoCg67n8jESDASySPIIX6OxIRtDy
         b3Twb2XbyrkEXETbZOjSDQQ5ltJ1NMvBT5EiqM1yyrqt2Gb4G+LeR3cV8+KyOKQPaTT6
         Q6vQ==
X-Gm-Message-State: AOAM531uyDVik88CV38Qm7sxqloFwxARE/1VTq1fzDwOTSzuLGFCj6v1
        wEcnH6lAXgkXSeVPNK3fnFkSwQ==
X-Google-Smtp-Source: ABdhPJxt3SqWw3HZJ/uiNBq1c9fOocDUG5up57ssysf2PT5jEFrllefPSnd7cOct8YHoQV+/k0vTAw==
X-Received: by 2002:a65:6a44:: with SMTP id o4mr11110387pgu.145.1621435057809;
        Wed, 19 May 2021 07:37:37 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.135.250])
        by smtp.gmail.com with ESMTPSA id o24sm9239515pgl.55.2021.05.19.07.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:37:37 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH v3 02/17] dt-bindings: qcom-bam: Add 'interconnects' & 'interconnect-names' to optional properties
Date:   Wed, 19 May 2021 20:06:45 +0530
Message-Id: <20210519143700.27392-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add new optional properties - 'interconnects' and
'interconnect-names' to the device-tree binding documentation for
qcom-bam DMA IP.

These properties describe the interconnect path between bam and main
memory and the interconnect type respectively.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
index 173e4d7508a6..d2900616006c 100644
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
@@ -47,6 +47,14 @@ properties:
     const: 1
     description: The single cell represents the channel index.
 
+  interconnects:
+    maxItems: 1
+    description: |
+      Interconnect path between bam and main memory.
+
+  interconnect-names:
+    const: memory
+
   qcom,ee:
     $ref: /schemas/types.yaml#/definitions/uint8
     description:
-- 
2.31.1

