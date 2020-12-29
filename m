Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368392E7420
	for <lists+dmaengine@lfdr.de>; Tue, 29 Dec 2020 22:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgL2VSU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Dec 2020 16:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL2VST (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Dec 2020 16:18:19 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F24C061798;
        Tue, 29 Dec 2020 13:17:38 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lt17so19708081ejb.3;
        Tue, 29 Dec 2020 13:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YoIC1VUuo3ZMkw58sSiZEuDYFurC1CP1AvQuaaDJsJo=;
        b=eFXDee18v8SyxtmAnLFnvx9hlwkEPei4D7X1c1ZtlQfVxan+cF2Zr6IoPH6rBO4bbZ
         yTVjvZz7EfH9WNTpiCcr9Lz99bNysH92BX9tVNNJXAKogSN+N3UonmotEJST5X0faL3G
         XoOTem8CHli7erYfFBKQiUUkmHb4vuYCJsJEDpj0tMdagnKWG7RJawJz6MNswdbj6ztp
         G8n+5zykK6+ohfbcSrF0Syyz3aLJ7QXgZxb6C21MLzugL1Ch8W7V+IdFluosINY6ejUq
         QR9OKk9v0wGXLFlXUHeYHe+Fjq54cf81ZXcbzPyWUrPeNHCUYo+rz9LYF/MpvuSFx9mx
         k1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YoIC1VUuo3ZMkw58sSiZEuDYFurC1CP1AvQuaaDJsJo=;
        b=civI8S9gi9kbghO0ASXgB0KVdETED2p12kebtUss4i9lLppW+faEv/CY1bQ2rw5iUD
         fXiypoMR3J2n0p8T44na9pzmxzTgSPv3a97ZmtKihh8GTl3T+JWOlabAstwBTLNH1+6r
         c4sjtYxM0takiryqQ3Pn5cAwsnr5Vq7yGln441vRVIHOSt603nw7wpGrOy7vk1N9zNd5
         XH+NGLyaGaOnSoruT/fVsBMoTlVaqDpKmqeTEX0UuMJJIplseRlV/yaaCO6/PAWE3HlG
         4aCUjDrdrn7P4P1XQhliCHcN5UxWwap51HR6E0Z+gOMkl3rz0a1auhNeKOqIynaWy6eP
         5gJQ==
X-Gm-Message-State: AOAM533wiRprEMviG50tfUQOGyVw2zqSiWHB2m+mU2hJpnZbrAtEJhXx
        /eI/QULU9hwb7bzLnOhaI88=
X-Google-Smtp-Source: ABdhPJzGL8NQH6/WN+KiqH0eqxz7O5DyDbtwfANQXetaSzius8yHs0i5Z5V+WW6fuhXURJysSStZUg==
X-Received: by 2002:a17:907:20a6:: with SMTP id pw6mr48101107ejb.73.1609276657718;
        Tue, 29 Dec 2020 13:17:37 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:37 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 04/13] dt-bindings: dma: owl: Add compatible string for Actions Semi S500 SoC
Date:   Tue, 29 Dec 2020 23:17:19 +0200
Message-Id: <2bd23ef5dad5dd613006c20d714b1be3c4d38e7a.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a new compatible string corresponding to the DMA controller found
in the S500 variant of the Actions Semi Owl SoCs family. Additionally,
order the entries alphabetically.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
 - Added Reviewed-by tags from Mani and Rob
 - Ordered the entries per Mani's suggestion

 Documentation/devicetree/bindings/dma/owl-dma.yaml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/owl-dma.yaml b/Documentation/devicetree/bindings/dma/owl-dma.yaml
index 256d62af2c64..93b4847554fb 100644
--- a/Documentation/devicetree/bindings/dma/owl-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/owl-dma.yaml
@@ -8,8 +8,8 @@ title: Actions Semi Owl SoCs DMA controller
 
 description: |
   The OWL DMA is a general-purpose direct memory access controller capable of
-  supporting 10 and 12 independent DMA channels for S700 and S900 SoCs
-  respectively.
+  supporting 10 independent DMA channels for the Actions Semi S700 SoC and 12
+  independent DMA channels for the S500 and S900 SoC variants.
 
 maintainers:
   - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
@@ -20,8 +20,9 @@ allOf:
 properties:
   compatible:
     enum:
-      - actions,s900-dma
+      - actions,s500-dma
       - actions,s700-dma
+      - actions,s900-dma
 
   reg:
     maxItems: 1
-- 
2.30.0

