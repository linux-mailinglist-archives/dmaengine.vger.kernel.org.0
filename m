Return-Path: <dmaengine+bounces-3638-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D22F9B52B7
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 20:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF4D281D7F
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 19:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C802076CC;
	Tue, 29 Oct 2024 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W82yHHrh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACA12076B0
	for <dmaengine@vger.kernel.org>; Tue, 29 Oct 2024 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230169; cv=none; b=HHiSikHHEtO0KHBSCk+NvejkYdVP1bNi6g0bT0eI6Lyblh/vRc1cGaEeUpN1YceeVkcJyCiFeC7r2RbJcLd097w9SAwmEWxOq6DKcZO625VxKd/S7/huggsgXNCl25vs0Zeq0TV+22mHql4GHk7IKSy2LgUcKbwW0oOUUVssQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230169; c=relaxed/simple;
	bh=B34viA+MM65CdrXgUsW5Dp3t9NZOdkgqu5Mg4s7zNz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pR4PXMCWHDGuUo5itsbbBh9bO/jbyK5JmHtmMqaYPSXXxNDHx+wzik3mmEZDSl/rl0rlDQxYBvC+xbKm4MhJPYf5VNgepexp2Pyjp7nWVj3LnV6aKLjUSZ3NHcrZJWEA0FkXzxe1ykeALhhQYX9wMryPlT4+2KzyfbeyHQ0N2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W82yHHrh; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7180dc76075so3041913a34.3
        for <dmaengine@vger.kernel.org>; Tue, 29 Oct 2024 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730230165; x=1730834965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGUVNbD0P2PUChlIpa6bQKf2kJo/Yt/Ozq4hpa/Va30=;
        b=W82yHHrhM3MaVrF3VIu+DToxJvuQ7qb5wjnc0n9rN+Kb2mWKhSo5R0RpEzBRz22+mC
         UrGToCj4w5Ai80RLg5zAe0jYICRsfH+E63IMPB0/uykcBI464fISy/D9K17c8PZt9tFt
         VXZ0wRdNvfddEPdZOd2hIxR2Q75gzIOs+ONxBxmQg6f5MlUqjjOQpNO21sT+HTs/oZ6J
         /gEl673QfEYt4c3DuVS6WIXO1KQrKjYjPrnB5jnGxAAhEvm3BulzD2aEzUKR3nEiMKVv
         GX9QTlqaflQt+ghzqirnic1YptAhPdoCdMvpxL6QBFG19luN3TvHeV01lM/xY0VWqU+Q
         pP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730230165; x=1730834965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGUVNbD0P2PUChlIpa6bQKf2kJo/Yt/Ozq4hpa/Va30=;
        b=kxYUm9OJAz54/+2wvaJmJBOEGfct4xTcawB94s99oc9GE/lMwdJ7y98F3FRPst+BEY
         i+zfeVnFc2m0womMA8F+PCvp7XT7jNJtRpqbckFXfTnHHpUoTSfF9Mr/uaCd/6eh/Wb6
         55NUnSpm5sqgAzR9SXTenCefW3JeKOv2VPx0fZvDwzW112AYwSEDRZG20PryMEJR65wA
         rYNitOScvtnFGSIgrLw5/jJLrojUOQ8CQEq6cchf3ni8Jd/pFdN/TLfdxHQsooF1RtYa
         iHoBLiyM2fuAGiQT6PjDPErAPONKUP+tWnu7/dfeAlQxgFLyoIVQUjCSvqbfq81W+Z7k
         /ziA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0S/++OxmbZ2WAJHH2ywiRlypS0DgYMHot7xXQXbvopn2rtGPVnpPng4MdG7oPZhGVECNvp8wLvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkAuj1kSieUIYw5GW3ACJYdPIHCjrtEdyHlsFMXvd5DGs+6P8M
	FLIstLwgw1jCLNJ4QFKBxTlMIjBMB/V9ZR4fA6c4UX0smNslfTx/iLhPXv+Zs7U=
X-Google-Smtp-Source: AGHT+IGE0tgvTOYhl6F6bmPumOXK81X+mAvwcn8J4Wmk4yCW9mIalh760l6gAYLCoA/c+7MA2f4sdg==
X-Received: by 2002:a05:6830:4188:b0:718:a7e:85f4 with SMTP id 46e09a7af769-7186828f9camr10938259a34.24.1730230165409;
        Tue, 29 Oct 2024 12:29:25 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec18598e79sm2452495eaf.14.2024.10.29.12.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:29:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 29 Oct 2024 14:29:15 -0500
Subject: [PATCH v2 2/2] dt-bindings: dma: adi,axi-dmac: deprecate
 adi,channels node
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-axi-dma-dt-yaml-v2-2-52a6ec7df251@baylibre.com>
References: <20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com>
In-Reply-To: <20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Deprecate the adi,channels node in the adi,axi-dmac binding. Prior to
IP version 4.3.a, this information was required. Since then, there are
memory-mapped registers that can be read to get the same information.

Acked-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

For context, the adi,channels node has not been required in the Linux
kernel since [1].

[1]: https://lore.kernel.org/all/20200825151950.57605-7-alexandru.ardelean@analog.com/
---
 .../devicetree/bindings/dma/adi,axi-dmac.yaml         | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml b/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
index b1f4bdcab4fd..4a4295e699f0 100644
--- a/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
@@ -33,8 +33,12 @@ properties:
     const: 1
 
   adi,channels:
+    deprecated: true
     type: object
-    description: This sub-node must contain a sub-node for each DMA channel.
+    description:
+      This sub-node must contain a sub-node for each DMA channel. This node is
+      only required for IP versions older than 4.3.a and should otherwise be
+      omitted.
     additionalProperties: false
 
     properties:
@@ -123,17 +127,4 @@ examples:
         interrupts = <0 57 0>;
         clocks = <&clkc 16>;
         #dma-cells = <1>;
-
-        adi,channels {
-            #size-cells = <0>;
-            #address-cells = <1>;
-
-            dma-channel@0 {
-                reg = <0>;
-                adi,source-bus-width = <32>;
-                adi,source-bus-type = <0>; /* Memory mapped */
-                adi,destination-bus-width = <64>;
-                adi,destination-bus-type = <2>; /* FIFO */
-            };
-        };
     };

-- 
2.43.0


