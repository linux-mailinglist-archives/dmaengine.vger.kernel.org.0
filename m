Return-Path: <dmaengine+bounces-6169-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D653FB32A16
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 18:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDD5A209DA
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828362E973F;
	Sat, 23 Aug 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa5LXq6S"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5C2EBB8C;
	Sat, 23 Aug 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964675; cv=none; b=FEToVoB7CwsVbcAWEpNfU6ytPk7eNm/0dK+dV39+Be58Z2ezArfvnQhhuJDybx6nRmKNLhQhW9OHimkwQTExCaiyuQ35nfrz4CPlWsyL5fgXsrD7USX9xlAS4i2yoBpacNscEHX1XHcaV+MQWK93u5AkdOmCe66qLB6DPBOegJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964675; c=relaxed/simple;
	bh=i5iq1Jzx4wxKCJVdwU1cFzHZFmOjbUhc2dS2K/G9ffs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrNRk2aai6j93PlA+4SJJWStodjxr+tApYGifQkvi1Q+XfHLazgCuQ+yrkOo2yXzZ/8O9k3KwNjE4cVC3p8PrZkCanX1TEw7FeqAw9vlRX1yAZ4FTKNCua0MoaIy/nwVyOwN2DoeTV8sRy/93ApJr83bd/pgoREDQiBOe0grGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa5LXq6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96E7C116C6;
	Sat, 23 Aug 2025 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964675;
	bh=i5iq1Jzx4wxKCJVdwU1cFzHZFmOjbUhc2dS2K/G9ffs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fa5LXq6Sdvf5zLpWKdoPenQXRZfWjoFmAk5KBn9AFYPjeZ8xN+4EvQvQ7Bq8aZuPA
	 9EgVKXW4jqRvAnsJvjUU8RLR0aWNly1q+2BDXmv2aIjxy3S6YK/JA+t6Z2xKNvfUN+
	 ++dTrVp9duEkjstuQM3twS7uagEnaPmwZ3w1jJKUDP4EmcDtgZbNo79Xi5Uih+pyZ5
	 XrHHLdDKChDA3ItPzGQOsagxQfgfjmRuNd+9qBz8vRIPA72XwNhT/K0UUV3MIbACuB
	 NmHps0cH2QWqfHGK7fdEKteFX4hzTmQoyMm8LzNEuouYAx8y3I0BXkMpPs9agfErbo
	 xyAYaFaeGTTLg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] dt-bindings: dma: dma350: Document interrupt-names
Date: Sat, 23 Aug 2025 23:40:03 +0800
Message-ID: <20250823154009.25992-9-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823154009.25992-1-jszhang@kernel.org>
References: <20250823154009.25992-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the dma350 driver assumes all channels are available to
linux, this may not be true on some platforms, so it's possible no
irq(s) for the unavailable channel(s). What's more, the available
channels may not be continuous. To handle this case, we'd better
get the irq of each channel by name.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/dma/arm,dma-350.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
index 429f682f15d8..94752516e51a 100644
--- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
+++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
@@ -32,6 +32,10 @@ properties:
       - description: Channel 6 interrupt
       - description: Channel 7 interrupt
 
+  interrupt-names:
+    minItems: 1
+    maxItems: 8
+
   "#dma-cells":
     const: 1
     description: The cell is the trigger input number
@@ -40,5 +44,6 @@ required:
   - compatible
   - reg
   - interrupts
+  - interrupt-names
 
 unevaluatedProperties: false
-- 
2.50.0


