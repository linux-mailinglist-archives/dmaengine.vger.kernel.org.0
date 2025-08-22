Return-Path: <dmaengine+bounces-6121-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E760B30C32
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 05:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67F21D01651
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 03:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4637826FDBD;
	Fri, 22 Aug 2025 03:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="lZpte2w5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435D26B085
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832003; cv=none; b=OuWhzTdszdvaCJI4j4074h7qFnHLwIThXHygruWKLgJ3baPjJyZjBg8E0yPG+FYzXs7E0jc3bSDANI9H/6sW4X1zhvj1Jw4gmNjkrKtFcL/PQ4gkCI1UIs4VYaT5YMEs2JQgk54bY82w6hjvqPvewB45B1y2uLrdQ5C9hWP4b20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832003; c=relaxed/simple;
	bh=k16Ro7327MWHaqNkOpPs6wLh2gCwtpI8bM29orBEHX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7y2JJx5Ot+59xva9P71I520I5MaTCf+QANefV6g/2vuakKzCghI4Iw4Jy4TwO6qpvOAOwjSipzIgvv0r76xQkMtUsXwwbPZr/b3Es8SIqPJuSBUHBarw64mqQ3cY4P2wIO4bNhFZMJu3jH75QNPtkEJ8p3kZstNjL1RRqfJFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=lZpte2w5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323267adb81so1768483a91.1
        for <dmaengine@vger.kernel.org>; Thu, 21 Aug 2025 20:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755832001; x=1756436801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaYtJX2FWb8MRA+YGF1PwcizqXL95f52x/ivDYOROU8=;
        b=lZpte2w5A/e2BYmZqc8LzUUQOOPf5FzgfjJMhxnOiGa6ZtrADFkWLkKPN39xxaajfM
         TrBwf2s6IMff8wa1/JlbILAg40U4dgTLhKKxHavugDQw3Pa8/aruzIpD1iFuDlTqtEkP
         7rm+I3nzESX/tNql2rW+SewedQGL1kBjTN3oCmTOuF5N1u+EJzA690kFRySJ/b1nGliQ
         9iWmgt01JY38rTCYNMZp3yMr5NqYOiXEcQ+g8/9C+ALdtgYgZRbNrUERQQq4f8q7lhm4
         KomsulYJBNhg4eE0ea/BOYQ0iv0Y/2eCbISzksgtzclY6E7sE/B1B4yyiMQVa7dnRr5v
         FY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755832001; x=1756436801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaYtJX2FWb8MRA+YGF1PwcizqXL95f52x/ivDYOROU8=;
        b=NxuA/i/UrlledTDIc+qwX3Bx3jvg8qY9Pelx3rmSt4cvmF5CoYm0ponOG62dGf5Fto
         dxhIwAojwSnCDMlcYAJ3lL3LKSKkTx0675xEV5bhKV3l8XBZilBOfluJquVkpM60koAL
         aDRnbQBJy5cxjQE2w4r6DKIHNsav0yI78+yop205Yw59zYwePasGSnptMlMAuX7ZGO4q
         u56wKStYo0yuW7UgqXCXbM+p4Om56t8TUqR7ykWgz6wOdI0RFMcBwQfopfSvRDrRBdFE
         4CoNhPb728sBfzSwxgvv+fSMbt7/Kmn8XX5Fpws14QCrmijz5zeqS/vXdUPcMfuPj8PX
         BBbw==
X-Forwarded-Encrypted: i=1; AJvYcCXaNGTh/88BeWf9WMfNd3HhdjZjmBsVuNyeSse7vyyJj54oMIfpLaf1nN2W9pm42zrCyFIaQ1vw118=@vger.kernel.org
X-Gm-Message-State: AOJu0YymXONtC1s4fnIKsk5RyoBkf5w2CoIiJB3LSwfjuBAgxh9fiHQg
	uoSRhv9dhMKHmVjtN74Pc0FII4vVUKEbuUpx1mtazNzoAVzU5hxp97cAxzAm+kMNdcE=
X-Gm-Gg: ASbGncvcEmBMN0ywOHkeXxItvEYxxJATH0Gc42YX11ch3Nu+o3jfDk86nZsyt0SvM8A
	bcH3yDX0AzeMjL+u5iuiROR26uVIZ0/l3LPO+bUXW69hwoAfGo433gUoZMRAOfCjvGA4JgxvR8W
	JIjH1RtGnpoH6EktRGfE0MbY3ANY6fjlHoNyTpsxTH+Pmud1CcbJjbmEcAw0NfQ8PxKHB5Lg62/
	vtf2QAlf3EwSOX983AmNamqs5NxEa7lBk65PYaMJnBTg+8DwKOkYPZcb4IqFap7xh5PQPuHyGFo
	PDrcFL4SHzVBeVro9phgiHqBVxnxIxiUq0GA8Di39afGjN6haV7cm2HvN/iIVrUChaoldwwGKiE
	3wLK0FzrBJd5QjrncuDsmTCI+tcxusgbMDw==
X-Google-Smtp-Source: AGHT+IHtoiI+ywaKLlu/wESYvwFaF1Wdo5+3G/aByEkmXZSAYsSzFIutpoI18vcBU1inhQ9OszGlwA==
X-Received: by 2002:a17:90b:2c84:b0:31f:ad:aa1b with SMTP id 98e67ed59e1d1-32515e3bfd0mr2287803a91.3.1755832000590;
        Thu, 21 Aug 2025 20:06:40 -0700 (PDT)
Received: from [127.0.1.1] ([222.71.237.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47769afc1bsm2756777a12.19.2025.08.21.20.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:06:40 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 22 Aug 2025 11:06:27 +0800
Subject: [PATCH v5 1/8] dt-bindings: dma: Add SpacemiT K1 PDMA controller
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-working_dma_0701_v2-v5-1-f5c0eda734cc@riscstar.com>
References: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
In-Reply-To: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Add device tree binding documentation for the SpacemiT K1 PDMA
controller.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v5: No change.
v4: Add Rob's reviewed-by.
v3: New patch.
---
 .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ec06235baf5ca3ecffe7dba9bb425b242985660e
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/spacemit,k1-pdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 PDMA Controller
+
+maintainers:
+  - Guodong Xu <guodong@riscstar.com>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-pdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Shared interrupt for all DMA channels
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  dma-channels:
+    maximum: 16
+
+  '#dma-cells':
+    const: 1
+    description:
+      The DMA request number for the peripheral device.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - dma-channels
+  - '#dma-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dma-controller@d4000000 {
+            compatible = "spacemit,k1-pdma";
+            reg = <0x0 0xd4000000 0x0 0x4000>;
+            interrupts = <72>;
+            clocks = <&syscon_apmu CLK_DMA>;
+            resets = <&syscon_apmu RESET_DMA>;
+            dma-channels = <16>;
+            #dma-cells = <1>;
+        };
+    };

-- 
2.43.0


