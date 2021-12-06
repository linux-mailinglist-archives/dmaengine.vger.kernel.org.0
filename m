Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFF146A34E
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244033AbhLFRq1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 12:46:27 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41913 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244232AbhLFRqC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 12:46:02 -0500
Received: by mail-ot1-f50.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so14566642otl.8;
        Mon, 06 Dec 2021 09:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Vg3zMnmIa1v4LLBisjFjB7Wnr8VsBWQpMW4ZAJLU6E=;
        b=EEJTgbG6hOPxKY3UUMIkjR7giYBm03vbkGiN2M2T51NPOynfAACIHtL4uqXtQrPKqx
         45ZaR1/kpBoBENAilLpV42iCoPX0ogOgSFnBAbDNgVcEOZyb3AO14kpczQqNiQOh3hIv
         iQPZRGcupkUoiLOzveEjF8QAshGU6XYmoqYvKkcg1NqbLXmO1FYY3M7gvd+Bw1JCoXCO
         0bS+4JylVcNER7B+jXUqPRdsXxWY3H6Tli3WuhM0R11HsLi5I3UV8pzoP0d3ysiOCJQH
         4DsU4C86qao06n+8nhDTH9z2vVLJgPTxHfJngcH1hT47/otWAZU9H8N2RO3ZtbhxppmN
         i1rg==
X-Gm-Message-State: AOAM530bJGI5+m1L98c1+SuVBdwXyJ4BvbNh4cm2LwGz6zYDk0tdYm0v
        nTuZOrtDOJ4QEoIGbZ5k1Q==
X-Google-Smtp-Source: ABdhPJxeyILdXvwFIHKMs6FNu/T9Ba85IcB324xgtuu4DwR8LJbS3dJPEi24VmSikl7z+jJJG7q3LQ==
X-Received: by 2002:a9d:490c:: with SMTP id e12mr30783824otf.90.1638812553315;
        Mon, 06 Dec 2021 09:42:33 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id y17sm2378960ote.48.2021.12.06.09.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:42:32 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: pl08x: Fix unevaluatedProperties warnings
Date:   Mon,  6 Dec 2021 11:42:31 -0600
Message-Id: <20211206174231.2298349-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With 'unevaluatedProperties' support implemented, the example has
warnings on primecell properties and 'resets':

Documentation/devicetree/bindings/dma/arm-pl08x.example.dt.yaml: dma-controller@67000000: Unevaluated properties are not allowed ('arm,primecell-periphid', 'resets' were unexpected)

Add the missing reference to primecell.yaml and definition for 'resets'.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/arm-pl08x.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
index 3bd9eea543ca..9193b18fb75f 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
+++ b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
@@ -10,6 +10,7 @@ maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
 allOf:
+  - $ref: /schemas/arm/primecell.yaml#
   - $ref: "dma-controller.yaml#"
 
 # We need a select here so we don't match all nodes with 'arm,primecell'
@@ -89,6 +90,9 @@ properties:
       - 64
     description: bus width used for memcpy in bits. FTDMAC020 also accept 64 bits
 
+  resets:
+    maxItems: 1
+
 required:
   - reg
   - interrupts
-- 
2.32.0

