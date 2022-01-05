Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F051484DBD
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jan 2022 06:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbiAEFoV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jan 2022 00:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbiAEFoS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jan 2022 00:44:18 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B861C061761
        for <dmaengine@vger.kernel.org>; Tue,  4 Jan 2022 21:44:18 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 8so34610046pgc.10
        for <dmaengine@vger.kernel.org>; Tue, 04 Jan 2022 21:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHcajqg9Gpb6lA1mDgUhgvp80/uagYog9aG622RiQkc=;
        b=SXWvmyRxMnnFXzxISs/uv6T0FSxXr7ReBtqaa2rXzPMFtO8arE8D4c8WrHXjhAbg6Z
         v2c4RiXXuVBhRixsMwtb0oh/msiXOUOqR2xcIe05pOTPFave691aYvDAreElkAHO/qmV
         npekYShKlN1zlPyATGx0vCT8zizon1ZVZ/3vWVh0SyNKLGCjDW7n27KVsjHZLbE5nSJ4
         hPBAWPYa631/lrk5bvqOTHRE0fb4VShSE/cC5jdYtdUowhJg1iY4jqUsPc28v1X8pJav
         oQyzuMHJPkdm4C/CS+Eod40alD/52qa9habh4+2v6wnK55S1BikOMhuBm0fmQ5itm6io
         alQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHcajqg9Gpb6lA1mDgUhgvp80/uagYog9aG622RiQkc=;
        b=NxorGMyyuoEJxabCatGVIgq8kOyuXmt3GAApQkoD9ye66ExcQrt78RT5yf+T2LeZmu
         +tYcQNpQMYvrHjwErlAAtgtRHr22GQ/eyXmNxlqneScZGZaJSlHRRB0l1WPz8yOHPDr6
         3vk0rvCdEVKL65kNcqFyvoT1nRZ9h0f6kKjZCYoG4OCS11zeb0+JszWjWjXB89tZlDmA
         /CZZwk//SdR+QxFbV2PnvHUDV7VrQG2oBYbZ/w4hr/T69dEjwHt1U+dBI2lN5ZFjGyiY
         BJA1P5UFkW9hVS1bn/ZUDkUfL8jty5Qy30rgUShvlueqMVnmGXLRvjs7GfYQHqhslZ/A
         kcug==
X-Gm-Message-State: AOAM531JDZjLWDTcl5k8oyORSyjlrDbtarFP6jv6uctk0E65tKoI9uIt
        zwmUDb0NvmrfdHUn/QstVNpbdQ==
X-Google-Smtp-Source: ABdhPJxb4U73W3VbaLmfSuss/ZkajAODH5FlLZNrkJE4VhGjoI6/tg9nwj4cGqHa4kBqzMHl7MUOng==
X-Received: by 2002:a63:745d:: with SMTP id e29mr32203035pgn.213.1641361457962;
        Tue, 04 Jan 2022 21:44:17 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cu18sm1000574pjb.53.2022.01.04.21.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 21:44:17 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/3] dt-bindings: Add dma-channels for pdma device node
Date:   Wed,  5 Jan 2022 13:43:59 +0800
Message-Id: <0419b2865c87f72adeb4edee9113a959e468b4a5.1641289490.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641289490.git.zong.li@sifive.com>
References: <cover.1641289490.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channels property, then we can determine how many channels there
by device tree, rather than statically defines it in PDMA driver

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index d32a71b975fe..256bcb111d57 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -34,12 +34,17 @@ properties:
     minItems: 1
     maxItems: 8
 
+  dma-channels:
+    minimum: 1
+    maximum: 4
+
   '#dma-cells':
     const: 1
 
 required:
   - compatible
   - reg
+  - dma-channels
   - interrupts
   - '#dma-cells'
 
@@ -50,6 +55,7 @@ examples:
     dma@3000000 {
       compatible = "sifive,fu540-c000-pdma";
       reg = <0x3000000 0x8000>;
+      dma-channels = <4>;
       interrupts = <23 24 25 26 27 28 29 30>;
       #dma-cells = <1>;
     };
-- 
2.31.1

