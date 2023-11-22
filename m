Return-Path: <dmaengine+bounces-191-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2AB7F54FE
	for <lists+dmaengine@lfdr.de>; Thu, 23 Nov 2023 00:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAF71C20A8C
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6920219E8;
	Wed, 22 Nov 2023 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A1C10C;
	Wed, 22 Nov 2023 15:50:58 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35b1d57d7dbso1023385ab.3;
        Wed, 22 Nov 2023 15:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700697057; x=1701301857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9y7B28iU5ZNUpsVCJlJk1JXKne0NiaXScyyG4NBAic=;
        b=SITtd94WYof+ra6JeiKNSJxAqL+PPfv/GLjKc4TAJZ5TQfSWzlk7J1fCNp2jygNr18
         VtMOjQYLWksLNM4kXYUKEjRFpWFi6fDy06yZCl3eQUksyKoSj1eqeM5Rl8PJ7DO78+Ld
         CQRKmSmUURefHhn7wnmn3J8suboQvDEPosKcoLkZ2dZXhLRcFbnXzgnYZKfUfwFuaFxM
         4MHNhNVE9UgcWOSko//YNX0D0k6AnA5GqueYrFWsvAzMVb0B1vpB7Oaif8+NkveInhHR
         xHAwl3w1C1LlZlV9cc23/g1YukY/i8zOhfzarlw6L5ioZU9X/r4WYPX3JA1FwNNRXvJy
         1eCg==
X-Gm-Message-State: AOJu0YwlK/Izstvx/oLHLuE1P41vDBZj5GuQQwdLBTBbCR4F0isLvFmY
	eVyjNI/ySOdPmKm/4X7D+A==
X-Google-Smtp-Source: AGHT+IFlHoMym3RA4UsY+NlHfV9d/EIFHa1mRXIA9Og4cy1ASUf7O0VHAeuyHEMYAAbICw+XP7xlMg==
X-Received: by 2002:a92:cc41:0:b0:359:4048:38e0 with SMTP id t1-20020a92cc41000000b00359404838e0mr4017608ilq.0.1700697057292;
        Wed, 22 Nov 2023 15:50:57 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id ck14-20020a056e02370e00b00359d156386csm214367ilb.4.2023.11.22.15.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:50:56 -0800 (PST)
Received: (nullmailer pid 2966454 invoked by uid 1000);
	Wed, 22 Nov 2023 23:50:55 -0000
From: Rob Herring <robh@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: Drop undocumented examples
Date: Wed, 22 Nov 2023 16:50:50 -0700
Message-ID: <20231122235050.2966280-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compatibles "ti,omap-sdma" and "ti,dra7-dma-crossbar" aren't documented
by a schema which causes warnings:

Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']

As no one has cared to fix them, just drop them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/dma/dma-controller.yaml   | 15 ---------------
 .../devicetree/bindings/dma/dma-router.yaml       | 11 -----------
 2 files changed, 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/dma-controller.yaml b/Documentation/devicetree/bindings/dma/dma-controller.yaml
index 04d150d4d15d..e6afca558c2d 100644
--- a/Documentation/devicetree/bindings/dma/dma-controller.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-controller.yaml
@@ -19,19 +19,4 @@ properties:
 
 additionalProperties: true
 
-examples:
-  - |
-    dma: dma-controller@48000000 {
-        compatible = "ti,omap-sdma";
-        reg = <0x48000000 0x1000>;
-        interrupts = <0 12 0x4>,
-                     <0 13 0x4>,
-                     <0 14 0x4>,
-                     <0 15 0x4>;
-        #dma-cells = <1>;
-        dma-channels = <32>;
-        dma-requests = <127>;
-        dma-channel-mask = <0xfffe>;
-    };
-
 ...
diff --git a/Documentation/devicetree/bindings/dma/dma-router.yaml b/Documentation/devicetree/bindings/dma/dma-router.yaml
index 346fe0fa4460..5ad2febc581e 100644
--- a/Documentation/devicetree/bindings/dma/dma-router.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-router.yaml
@@ -40,15 +40,4 @@ required:
 
 additionalProperties: true
 
-examples:
-  - |
-    sdma_xbar: dma-router@4a002b78 {
-        compatible = "ti,dra7-dma-crossbar";
-        reg = <0x4a002b78 0xfc>;
-        #dma-cells = <1>;
-        dma-requests = <205>;
-        ti,dma-safe-map = <0>;
-        dma-masters = <&sdma>;
-    };
-
 ...
-- 
2.42.0


