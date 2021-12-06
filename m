Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FC846A347
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 18:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245178AbhLFRqG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 12:46:06 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36495 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244986AbhLFRp5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 12:45:57 -0500
Received: by mail-ot1-f47.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so14610834otl.3;
        Mon, 06 Dec 2021 09:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMEGpXkQSMg6zAnWALCmMXVNDdUfut/AU6uq1HnIcdY=;
        b=G8GC0HXO8pJe5ozFNsVv9BvCHK4UslZVRVDUmQsBNejuBig5/girMJIQKCTjfMj5Vl
         EIhDcXznNnd6gXbkwu2V17X1Hus0Gosis3GvuZ/Sbc5hgxFzGtBcBwupGOkCRd5LIpfG
         LVrYCYpm3IKaQ84sd571X8m/HLAqJP2EU5IUzKK3HpwZpmHxqq5Pao2DBuRa/F2fFrE4
         IZu7mcERy3piaBi7/gWrIiXM5c7nXqnLj7UR6//8DL5QTKE7s9uuMKhVQZih5aWw+uYo
         2iC4wcROJD41yiYbiGMAQmw6BLZK92OD+dKeaMVKRICpTXtw7pQEtnqHqMriK0kIn280
         d79g==
X-Gm-Message-State: AOAM5301CyDsaiYbpaOrAWr/ZfpFJVjaruexiRdLBywLcezBBbhyhgjA
        zlG9PFz5EyLDqoIx5NVQHw==
X-Google-Smtp-Source: ABdhPJw2vf51doQd/DZxL3pSrPArXIu9al2TunD0DuuEk9HbirzwvZYvs9z+pRumhFooLuAMX0GcBg==
X-Received: by 2002:a05:6830:601:: with SMTP id w1mr29894635oti.267.1638812548258;
        Mon, 06 Dec 2021 09:42:28 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id w80sm2732252oif.2.2021.12.06.09.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:42:27 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: ti: Add missing ti,k3-sci-common.yaml reference
Date:   Mon,  6 Dec 2021 11:42:26 -0600
Message-Id: <20211206174226.2298135-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The TI k3-bcdma and k3-pktdma both use 'ti,sci' and 'ti,sci-dev-id'
properties defined in ti,k3-sci-common.yaml. When 'unevaluatedProperties'
support is enabled, a the follow warning is generated:

Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml: dma-controller@485c0100: Unevaluated properties are not allowed ('ti,sci', 'ti,sci-dev-id' were unexpected)
Documentation/devicetree/bindings/dma/ti/k3-pktdma.example.dt.yaml: dma-controller@485c0000: Unevaluated properties are not allowed ('ti,sci', 'ti,sci-dev-id' were unexpected)

Add a reference to ti,k3-sci-common.yaml to fix this.

Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml  | 1 +
 Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index df29d59d13a8..08627d91e607 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -30,6 +30,7 @@ description: |
 
 allOf:
   - $ref: /schemas/dma/dma-controller.yaml#
+  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
index ea19d12a9337..507d16d84ade 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
@@ -25,6 +25,7 @@ description: |
 
 allOf:
   - $ref: /schemas/dma/dma-controller.yaml#
+  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
 
 properties:
   compatible:
-- 
2.32.0

