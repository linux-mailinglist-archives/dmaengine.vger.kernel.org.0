Return-Path: <dmaengine+bounces-5343-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615EAD4E04
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 10:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1267AC323
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 08:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B342367DA;
	Wed, 11 Jun 2025 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtGw96Xi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDCC2367AE;
	Wed, 11 Jun 2025 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629477; cv=none; b=o48T//i/68Z6Vle1HoU+1jCQIV/qLkdAhPAFb6hIBsAKk4Y55NmOxtfgsyDMTnKQh5o95XFhMil/gQbgfJGIFqJhH8zF2WP5N85f9wrSzFvSQMVdebo/GkIhTsAGf8iPbaSuzOx47Bjw73oQAIEAOaEp9+WguPzkiMwGRQOjxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629477; c=relaxed/simple;
	bh=l6XeT3LXyFrlrCtT9xgFGVmCHaNUCX0eKWZGqDdqJ9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u778lCQIha9sw39XEtnWB05h/t+MDy1usVP2K2QFvP7Afe6CZ73N1ikSEEF9ZIJhfvbpinDILGu/T343jB3E1/jgpUzknB16PR3iLt3BDgWlw3xmZX4l8UXmPxREqE4mrmuo+ficeCOtX7bygf+sPqdIITnxYQ9DBESxs0bm778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtGw96Xi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a4bb155edeso78643371cf.2;
        Wed, 11 Jun 2025 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629473; x=1750234273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00Y+C1NgJK+RcRNEHyqDxW/VXT0REGuVvjiQNS/nXxY=;
        b=EtGw96XivaqkJ1NYkVbUDKFB8a4RZCIj4iq0X9hIZ/ano1/CNt2dIYogc6JSGnrmkV
         99ddNwLjzzDyY2Rl1atoypPNILA9SVz9NPbSFNizHSMCUh9+zzIlkE5ZGf0DqdtTaY3h
         +UQL7mRphJW7pevVu78Sq6vz1gixqu6SR0pKxdvkH4feVsawT/85+x816vAQxxn3K3RY
         6ei7n3J+eOqpek74t3dptGoIp0JG89TzYKU6MesuHl3eUmsu/lP8MmY0ZOiAEZcuNjB6
         yTLkA3CiH8G9jBsxVGzmE+/9knymctJJlqSRvYU7FmjOWuHIucjxJVT1/6bBtcL6Mme+
         An1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629473; x=1750234273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00Y+C1NgJK+RcRNEHyqDxW/VXT0REGuVvjiQNS/nXxY=;
        b=VS7RQ+Aposl9lQR+5TC6PPscb75oE4ps5BvktQTjIz6KL/CopvXX3wf3/mHFinCi2Y
         N0AvVJJDyRYrOEmatADcFcY5eR8ZeNR4EYmmdBgmnLwAQkYBMr6P+JFj5U9clYf4f08Y
         LqvT/CJ4RMScXnI6F+dA8fpLGQoJEPCxl0Gg7gSkZBlsWu695iEoS8PmRUdVEBKRdRtl
         yeB0lKb2VlASPvCITy6V7DRaqZzZnD77dkkvVzIGNa398e58KtYF13hsXoPohcFeI3d8
         kwKaU9l1ypScfwXj0Q2ndJn8SPb2J52RWx1sMpmgYkVeA2qfyrELpuEMAcyrkmTdMaVA
         XBCw==
X-Forwarded-Encrypted: i=1; AJvYcCVuMgtAYMXkgiApNNsZspYqXeI3XHQoIsiFLlgRaGpQpc+kEqJMyP0LZlXPykizQjLxnt+WlC24L38M7KVa@vger.kernel.org, AJvYcCWOmacq7zzmQB62Pw+5ctGJ2dCOlz1FrZrm9HrzIDfbAHMb7VDU2esaC9nNTXaJEYFprAmXyyDHUhgr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3rnwKq7Cun3Ydy1o1enzniXMprbBYiQ7XKyWBX6WkxXtOlCB/
	NCJl4wBND8raGxsKSjRdgvtyDRp3KEM55IuGliTsNN0C59nt4jlQsD60
X-Gm-Gg: ASbGnct8KRii9gyyzq6SB4ZiM068GdKGef16iPshy5M9z92Btk3GWZ/JgrnFF1vKEwO
	9yHaVHrAUBRui53DWK+bS2uqxwDT15HfjLRPz0R6QGPP3C/uV+ROtOeQX5Zm73A2eK6u9Mqq+lx
	0T34W+/qAzAlRpOQ4AA5Ob5Q7pCKqGJVGoz7TTJyAWP8uZIv4P035G1q+OVKvJYkJI4LA1MFEIF
	1EFb6IzuE3aN3qnujMwnrmgB2MNytzRW4M5Jya8ymA2PbOLG+SUwD5kO4K5h6V58PCIw5vtysO6
	0Up4NDU16vUlus8/b5ymrXzSdnru2d4QrLLgCGXQMiHIuS/q
X-Google-Smtp-Source: AGHT+IH/A2dN7aEwFSvK+XOGHnNd1Ms/qTqK5FFtVoR1qjX6O4PJ9oh2Gq1zA0E/mBczJM+1ZkNyHQ==
X-Received: by 2002:a05:622a:4249:b0:4a5:a96d:6068 with SMTP id d75a77b69052e-4a713c5871dmr48328971cf.37.1749629473419;
        Wed, 11 Jun 2025 01:11:13 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a611150018sm85377551cf.8.2025.06.11.01.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:11:13 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v14 1/2] dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series SoC
Date: Wed, 11 Jun 2025 16:09:58 +0800
Message-ID: <20250611081000.1187374-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611081000.1187374-1-inochiama@gmail.com>
References: <20250611081000.1187374-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
an additional channel remap register located in the top system control
area. The DMA channel is exclusive to each core.

In addition, the DMA multiplexer is a subdevice of system controller,
so this binding only contains necessary properties for the multiplexer
itself.

Add the dmamux binding for CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/dma/sophgo,cv1800b-dmamux.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml

diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml
new file mode 100644
index 000000000000..011002942235
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/sophgo,cv1800b-dmamux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800/SG200 Series DMA multiplexer
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+description:
+  The DMA multiplexer of CV1800 is a subdevice of the system
+  controller. It support mapping 8 channels, but each channel
+  can be mapped only once.
+
+allOf:
+  - $ref: dma-router.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800b-dmamux
+
+  reg:
+    items:
+      - description: DMA channal remapping register
+      - description: DMA channel interrupt mapping register
+
+  '#dma-cells':
+    const: 2
+    description:
+      The first cells is device id. The second one is the cpu id.
+
+  dma-masters:
+    maxItems: 1
+
+required:
+  - reg
+  - '#dma-cells'
+  - dma-masters
+
+additionalProperties: false
+
+examples:
+  - |
+    dma-router@154 {
+      compatible = "sophgo,cv1800b-dmamux";
+      reg = <0x154 0x8>, <0x298 0x4>;
+      #dma-cells = <2>;
+      dma-masters = <&dmac>;
+    };
-- 
2.49.0


