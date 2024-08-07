Return-Path: <dmaengine+bounces-2817-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADE494AEA1
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 19:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0856E1C21923
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1284C135A79;
	Wed,  7 Aug 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McpFit5Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635812F398;
	Wed,  7 Aug 2024 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050327; cv=none; b=taqD/vWttvcf+F235BLA4Xyg5CHeUxNttlqLq6LOyeu55OxkoEsNKXKB2eLzIRyTBEVvHUbODeXK6KA5ylKnA6oSuNitVTEjbaFS698pcfU/FjFzf9xY0dhKZttgLWuOIhyK9LRgJMSTtCAZNOC2tLgSzyjvCSg7s1Vmw5T8KYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050327; c=relaxed/simple;
	bh=Ue9wCZbpVo7s2zBnb5ug6XQgRWWh4vsho1ZmwTILYeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B7i/ewahYw1USas+gwbdVvCj6LXoA9+S1tMa4JtsWcWfCMThzq8U3tqEIhv/h2w2mRUeRzzmZixmhCydWLMxPe3lNK0X+CGjevLGHAFaniHbIKSJopCwpDMvXmEURSeaQxf+BKWBNY6p/6G9ks568Nd0QX5OKMQD14URZ3OM6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McpFit5Z; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb4e1dca7aso20156a91.0;
        Wed, 07 Aug 2024 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723050325; x=1723655125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPmn8VFdpUiz/zz7vsoeMUfjx+ry2BSVsn7uxfVJEj8=;
        b=McpFit5Z8kiIQnUyaYyOQTKuEmmoL5DeR2I9uSG7o5ByAW7OpeXclDSx0EJKun2tc2
         bp/kFoiboV/8gWTt5CGtBd2kz2eKq5R5CSWlWGLKjS99PHwSzVFoPEhP2Xvk7HyVqG+C
         5+shUA5b8g5+5hQVUoJyfNjfmwx4cJWzl+IaRdQwml/TZPVJ7laUUNWf6AJMgWFdUijr
         R8jGPPGKUo72Al3aRglBjgPDQvebSDzW3Eef50I0whDyssXETYQkGbfdsANgv+RAXW1v
         KYgeXZOcELnodVdco3mB7WLQAWrDIDN2Ue4CQ081Le1NQ2icopyGojukntpP3nr0Jk7/
         zD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723050325; x=1723655125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPmn8VFdpUiz/zz7vsoeMUfjx+ry2BSVsn7uxfVJEj8=;
        b=t3w+7rKCGrwCG1TvNe+n0Jz9MSE3we5jsKksQ+RCQwfMEjZXcLogaPnU3gctVMN6uM
         79Dny6PDL4fCXkMD4ccGmT+DAaM2CqIMhAx+80Tc8kJt1z8sLIgGl52mA5bSsJI6hsN+
         gQ6xhxVaoy3HiM6dXuA5RQhGBT/8c+LI5hy9XN3UVzt2eZoPv1LAgO/9TZQc7KPlwnIT
         7jFpGpjnHjJEOMuYuy6QmM9lUD2vdCI3nYo1qjmOHL25uvkeB6oN0ORNN1pKNtKVNl71
         iJsvmWwPZriV4zQ61TMt6Omrw7BJWuSAXVFsLPt0NC9A3cKuo+97pjAo0kyeBH7ABESJ
         jchA==
X-Forwarded-Encrypted: i=1; AJvYcCXIyG+MvmKccHQJBVm00KhFfPIWRWUesjjExr4iQcJIiqT7W+EIaGtpiqisHFZ9gz/najp65PVLcMb6nMb++uE2T1smTUlpozZh4G3MK3dET7BzT3dUDdqm1uABU6Me1LbWueGYCw==
X-Gm-Message-State: AOJu0YyfTeDOzmPi+I38WzpIUAs79ZUNGgMaBjAJY1n/ksPtNSYzjalt
	0J9aphf975E+Ap2LRUJMMsDEQZU47RScHhuKjjhAayam0qdcbwtdlRbODw==
X-Google-Smtp-Source: AGHT+IF/PA1WGYg6scnVacIxbKK0JfJKKKSasZLzJxCRxj+gW51zclOe4xOjaGL2KmrM7/kAUJ89Ug==
X-Received: by 2002:a17:90a:630b:b0:2cd:8fcd:8474 with SMTP id 98e67ed59e1d1-2cff9599f55mr13174318a91.5.1723050324839;
        Wed, 07 Aug 2024 10:05:24 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5e1c:17b4:a72d:e3b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b36c1cf1sm1844359a91.23.2024.08.07.10.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:05:24 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: vkoul@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] dt-bindings: dma: fsl,imx-dma: Document the DMA clocks
Date: Wed,  7 Aug 2024 14:05:17 -0300
Message-Id: <20240807170517.64290-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Document the IPG and AHB clocks that are needed by the DMA hardware
as required properties.

It is not possible to have DMA functional without the DMA clocks
being turned on.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Mark clock and clock-names as required properties (Conor).

 .../devicetree/bindings/dma/fsl,imx-dma.yaml       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
index 902a11f65be2..75957f9fb58b 100644
--- a/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
@@ -28,6 +28,14 @@ properties:
       - description: DMA Error interrupt
     minItems: 1
 
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ahb
+
   "#dma-cells":
     const: 1
 
@@ -42,15 +50,21 @@ required:
   - reg
   - interrupts
   - "#dma-cells"
+  - clocks
+  - clock-names
 
 additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/imx27-clock.h>
+
     dma-controller@10001000 {
       compatible = "fsl,imx27-dma";
       reg = <0x10001000 0x1000>;
       interrupts = <32 33>;
       #dma-cells = <1>;
       dma-channels = <16>;
+      clocks = <&clks IMX27_CLK_DMA_IPG_GATE>, <&clks IMX27_CLK_DMA_AHB_GATE>;
+      clock-names = "ipg", "ahb";
     };
-- 
2.34.1


