Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0036B2B9EC5
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 00:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgKSX4Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Nov 2020 18:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgKSX4X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Nov 2020 18:56:23 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6AC0613CF;
        Thu, 19 Nov 2020 15:56:21 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id gj5so10406530ejb.8;
        Thu, 19 Nov 2020 15:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXhSAC/h1fTKvVgZvg2QA0XeitbzBpaKRQrMdrDvejs=;
        b=Sa1pmQZAJ3rhIDX9pJMhMUMdixs0l3PbQAanQPgfpYIMVNo382nmReWEhrffWH/1TF
         piGrgubhDpEdJ8NL/YK2eiuFf36bRdVy3MsmOKRd3f5BreSm28/SzEF1rYr430u4gslT
         Ouqpbfqoy0SuuzveZTdMJZioEQ2wp1XJjO66IA3JcgT4Ft387Ae/V26XDR7G0tzWELWO
         bJRUsh0w6uJjv7aeGfB1TGDcrPjAogmN8t3On0j43lfbRgOC6dtYmsW42oRXYPfus/Vz
         QCLntyrV/7AN7TdfJKwluSfs1FxL2ClZX3vo8C32Qu4r/RfxndtgBYuw+QKxgj1sWdmF
         6WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXhSAC/h1fTKvVgZvg2QA0XeitbzBpaKRQrMdrDvejs=;
        b=NkKZIu3umWgi6HIm20sWsiV0pNVYP+li0XR6KvkeouPF2020rvcrHdoUOhX8dyVLaC
         ubMxSoDtKsgDdNO49GTBmTctEz5nyIA+e+X3+hDgIqOTwvqM4eviWNoilnhMqut20N1d
         vVOwIrgkVk40hXjvADw6dfvCcKf/Ex2iMjDNH1GdDSu3cHCNxIKy5pWstnV8oK59MXFi
         6rOXqOa8R448JHizmVOtfO1WBesGZEgGgovb24NGir964duJpaCb5xto67uTMlketrAg
         PhxiWO855i05ZgkxGIOGmiBBCJBPDaqRDIN1M6so3mTv+Rorj174jqjt2pdWdyq/AbVg
         vsLQ==
X-Gm-Message-State: AOAM532MjOAvWMZlthg7L5xkqVt6H+qqjeAu9RdHYdJlkkvxnG4FC7bL
        9Ez9ak9bC2SBLTsIjTnvd2IyUSXm8Q8XDw==
X-Google-Smtp-Source: ABdhPJxeuekq/dff7SbqRJIJpNRUaKE2GIKbP+q52KyY2YWdo4x7/gJeSB9G09Hk4ybnsyzUxWraMQ==
X-Received: by 2002:a17:906:c298:: with SMTP id r24mr12870176ejz.381.1605830180446;
        Thu, 19 Nov 2020 15:56:20 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:19 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/18] dt-bindings: dma: owl: Add compatible string for Actions Semi S500 SoC
Date:   Fri, 20 Nov 2020 01:55:58 +0200
Message-Id: <0e79dffdf105ded2bb336ab38dc39b4986667683.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a new compatible string corresponding to the DMA controller found
in the S500 variant of the Actions Semi Owl SoCs family.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 Documentation/devicetree/bindings/dma/owl-dma.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/owl-dma.yaml b/Documentation/devicetree/bindings/dma/owl-dma.yaml
index 256d62af2c64..f085f0e42d2c 100644
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
@@ -22,6 +22,7 @@ properties:
     enum:
       - actions,s900-dma
       - actions,s700-dma
+      - actions,s500-dma
 
   reg:
     maxItems: 1
-- 
2.29.2

