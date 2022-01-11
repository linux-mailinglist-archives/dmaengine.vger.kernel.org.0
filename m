Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5409D48A9DE
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jan 2022 09:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349026AbiAKIvr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jan 2022 03:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349032AbiAKIvp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jan 2022 03:51:45 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B247C061748
        for <dmaengine@vger.kernel.org>; Tue, 11 Jan 2022 00:51:45 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id pj2so16014751pjb.2
        for <dmaengine@vger.kernel.org>; Tue, 11 Jan 2022 00:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95yOM2oPjDW4I8teUQkYRlUXa8kIk+GmIx7gO72jBTY=;
        b=GpMh6fkVqVZnpQ6fScwSciNnWMkmNTtU1WgST8+pCoVLTfgXeKSZPYogUkpsxz6FF8
         +/WpAxttfOV5TjT30xKEvL0rMlmogZOvL5ugDuwDo5eKo/S6U/EinZ6A+7O7Wj/MZ7Qu
         9VLER8etNMkI5H/6yhxTf83SOM8KvmMuHHqNR7mFTlu6mj8BQoLXQ2Oh7zlInW8SZdVb
         fp4+SLidAPI2J9gB0om53xk/hHNTonmlL56uac8Nqo+p7Ww3v4YCmeBNPdfehubbB50E
         sbzbwr4fsRxt56wcVkdGZMa97wM7wATjjeQ7Gfmj7HA75e0HSHt0woJkskypzV61D4KB
         oj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95yOM2oPjDW4I8teUQkYRlUXa8kIk+GmIx7gO72jBTY=;
        b=AkQP0QouJodiGa1icDjiNXFhr1xDaemqATFv/aPTCea6VrrOXd+uNxXBn78FCwUExt
         830JlAVzPn1eQMd4EI5yj0QXooKcrMOvl+VPItPq7hABZIzwWBl7jhduS+YKRUMAC2Az
         GW7u89j81gOBGUoUbPadfi4HH5D2o1smNa089vc3g0B7S3RbCpvwViqBl5zbnIK1I37Q
         74FLBpxtfzdvh16+xnt5w7lMRC8HSd0ut63jEPABS1gYdbzgxZly3+zD1yDJWPyj67H3
         ctpeg2VsXCP08xNBhITrI1R9GzJ7sqtWn9cD5LjNdiW2aiFDyiZyv0N5ovdCkstoekwB
         B/zg==
X-Gm-Message-State: AOAM531UB90YchyPYunbi+RhN6MLwVKIPSLY94JENo5Al43bMs8G1Raz
        cu+RGmgDLOxqxEsj07dvK4m/8g==
X-Google-Smtp-Source: ABdhPJxlbSxnGg4ihJcp7ofYvFqtVX8rwXaySdYUqfwyOnXJUtvZ0NiapTjTqylZZvzzNHeBMF6Y+A==
X-Received: by 2002:a17:90a:578b:: with SMTP id g11mr2051970pji.76.1641891104660;
        Tue, 11 Jan 2022 00:51:44 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j4sm9447598pfa.149.2022.01.11.00.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 00:51:44 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 2/3] dt-bindings: Add dma-channels for pdma device node
Date:   Tue, 11 Jan 2022 16:51:26 +0800
Message-Id: <5db314b798cd9cfcb5cb61bc56515220b7d50315.1641890718.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641890718.git.zong.li@sifive.com>
References: <cover.1641890718.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channels property, then we can determine how many channels there
by device tree, rather than statically defines it in PDMA driver

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index d32a71b975fe..3dbb8caefc17 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -34,6 +34,12 @@ properties:
     minItems: 1
     maxItems: 8
 
+  dma-channels:
+    description: For backwards-compatible, the default value is 4
+    minimum: 1
+    maximum: 4
+    default: 4
+
   '#dma-cells':
     const: 1
 
@@ -50,6 +56,7 @@ examples:
     dma@3000000 {
       compatible = "sifive,fu540-c000-pdma";
       reg = <0x3000000 0x8000>;
+      dma-channels = <4>;
       interrupts = <23 24 25 26 27 28 29 30>;
       #dma-cells = <1>;
     };
-- 
2.31.1

