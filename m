Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323AE4869BB
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jan 2022 19:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbiAFSZb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jan 2022 13:25:31 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35630 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242733AbiAFSZa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jan 2022 13:25:30 -0500
Received: by mail-oi1-f170.google.com with SMTP id s127so4942819oig.2;
        Thu, 06 Jan 2022 10:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cF7NOXX0VCxREtaDxxcjv4QjL9Wd5MC7Ra3H6nrdF+Q=;
        b=4GQhrBv0Vv8o31hoG2ragc4hC/myINIowC5fFJI1O/SeXjtRhkNYV9Va2ZdDRoT1ra
         MuCHhR2pifF/Vs76eAA7qp2aK6m4BJ4jhv37PNKkwxydDsY5r9Tp2SQg8wxkhNrkDb1y
         044SRJ2kipmNQgTRUPR/LCgbodVfJTEKJ+qNjq8yNBm2rtS/VOJQalbas989YXfHPgUy
         UN9V+mb97In6U9TmuNJpY/9fZDZb//kmloQdEzqARYbF0EXu+bWKS48GOry+XJD8+ajA
         mS2bgp6Kn46uAXHaIEsTOm6AItaF2xfcn7mUTFeduFAryYlb7zGDOcA/bM9R8/7b17RX
         08Rg==
X-Gm-Message-State: AOAM531XBCizEJNRaGwk1/3tMQFKY5WGa8Hz+9T24E4DBr29N4hKQldB
        N9k3RYqC4Vi013zrTbMIKCzzW6nFwA==
X-Google-Smtp-Source: ABdhPJwHKljtbw4ST1iRI0MgRmPXUWUCv2jaJpK16yDsCDmvGPMgVOe4pZe1zQTLwFkxzyBK9SArBw==
X-Received: by 2002:aca:4385:: with SMTP id q127mr6763971oia.39.1641493529683;
        Thu, 06 Jan 2022 10:25:29 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id r13sm484949oth.21.2022.01.06.10.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:25:29 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma-controller: Split interrupt fields in example
Date:   Thu,  6 Jan 2022 12:25:10 -0600
Message-Id: <20220106182518.1435497-2-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Best practice for multi-cell property values is to bracket each multi-cell
value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/dma-controller.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/dma-controller.yaml b/Documentation/devicetree/bindings/dma/dma-controller.yaml
index 0043b91da95e..6d3727267fa8 100644
--- a/Documentation/devicetree/bindings/dma/dma-controller.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-controller.yaml
@@ -24,10 +24,10 @@ examples:
     dma: dma-controller@48000000 {
         compatible = "ti,omap-sdma";
         reg = <0x48000000 0x1000>;
-        interrupts = <0 12 0x4
-                      0 13 0x4
-                      0 14 0x4
-                      0 15 0x4>;
+        interrupts = <0 12 0x4>,
+                     <0 13 0x4>,
+                     <0 14 0x4>,
+                     <0 15 0x4>;
         #dma-cells = <1>;
         dma-channels = <32>;
         dma-requests = <127>;
-- 
2.32.0

