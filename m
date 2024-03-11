Return-Path: <dmaengine+bounces-1336-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13FA878AB0
	for <lists+dmaengine@lfdr.de>; Mon, 11 Mar 2024 23:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBD81C2104E
	for <lists+dmaengine@lfdr.de>; Mon, 11 Mar 2024 22:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB99C57861;
	Mon, 11 Mar 2024 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC32lBz1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2D52F61;
	Mon, 11 Mar 2024 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195933; cv=none; b=pyTRLUp/35zVrtmYtaOlJYnklcGARmokPCQYvt+Fm4NCQeXyRya67OEpSJNvni26DeG/qjFE5SM6liY6MxIkNWh7nkfYj3DPQJIWsFyE5AFFRO7b4UHBi7kINrnE9cf4/BQNuaxWqdNLFvtXqGjBiLwkwzxQWu6HqwDTI/w7k0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195933; c=relaxed/simple;
	bh=l0/IQ23QUrCfGWUZ/tXclmNM1YnM2HDLEAk057qvzkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OhTvHvK/PBczw9GSD/7CA3AIloOx+3PrARoB/FH6h11YkcE9Swc6UXzpjqXRRBEjRl9ADWcSgx3RSxy6BmATkIqDaK7VdcWAqeXofXDyCirA5ZQWAKrf9ZYlm7/ClrvcjurJn2rBx0+h/J8ecpRw3Y9/yXPCrZg70tnIVLBUsAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC32lBz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88B3C433C7;
	Mon, 11 Mar 2024 22:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710195933;
	bh=l0/IQ23QUrCfGWUZ/tXclmNM1YnM2HDLEAk057qvzkY=;
	h=From:To:Cc:Subject:Date:From;
	b=AC32lBz1enrvDOlWUdu4x8Sj92fX3lrFP/eEg4C0B6vE40bYfFWvIkBHHtFxmf1u7
	 ry06MtikeGL6PsNo6ZDyrun3wlZlRiPn3h8BmYuUsilBLqhJnFuVEAD3mWcLuZM1Y+
	 57PyE+EJ0f1pfXVXgNjEKM6FQHYDXdw3ZqNV5GYV+nbeEzHIXLQJFv0K/YupiBm0HX
	 DQY2RscCrehP4u68UgCX7mnNv9UQrhMvotY7ltZIL4eouZum+yYoHud/QIUJon0Rck
	 JRhcJy3y4fQMNPgW94ojROzsUyehxG96c32gFs2zbBm1AOQAMbB+McS5QeLsHjbaGh
	 BFT1BYwO9teOg==
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: snps,dma-spear1340: Fix data{-,_}width schema
Date: Mon, 11 Mar 2024 16:25:22 -0600
Message-ID: <20240311222522.1939951-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'data-width' and 'data_width' properties are defined as arrays, but the
schema is defined as a matrix. That works currently since everything gets
decoded in to matrices, but that is internal to dtschema and could change.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/dma/snps,dma-spear1340.yaml      | 38 +++++++++----------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
index 5da8291a7de0..7b0ff4afcaa1 100644
--- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
@@ -93,10 +93,9 @@ properties:
   data-width:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description: Data bus width per each DMA master in bytes.
+    maxItems: 4
     items:
-      maxItems: 4
-      items:
-        enum: [4, 8, 16, 32]
+      enum: [4, 8, 16, 32]
 
   data_width:
     $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -106,28 +105,26 @@ properties:
       deprecated. It' usage is discouraged in favor of data-width one. Moreover
       the property incorrectly permits to define data-bus width of 8 and 16
       bits, which is impossible in accordance with DW DMAC IP-core data book.
+    maxItems: 4
     items:
-      maxItems: 4
-      items:
-        enum:
-          - 0 # 8 bits
-          - 1 # 16 bits
-          - 2 # 32 bits
-          - 3 # 64 bits
-          - 4 # 128 bits
-          - 5 # 256 bits
-        default: 0
+      enum:
+        - 0 # 8 bits
+        - 1 # 16 bits
+        - 2 # 32 bits
+        - 3 # 64 bits
+        - 4 # 128 bits
+        - 5 # 256 bits
+      default: 0
 
   multi-block:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description: |
       LLP-based multi-block transfer supported by hardware per
       each DMA channel.
+    maxItems: 8
     items:
-      maxItems: 8
-      items:
-        enum: [0, 1]
-        default: 1
+      enum: [0, 1]
+      default: 1
 
   snps,max-burst-len:
     $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -138,11 +135,10 @@ properties:
       will be from 1 to max-burst-len words. It's an array property with one
       cell per channel in the units determined by the value set in the
       CTLx.SRC_TR_WIDTH/CTLx.DST_TR_WIDTH fields (data width).
+    maxItems: 8
     items:
-      maxItems: 8
-      items:
-        enum: [4, 8, 16, 32, 64, 128, 256]
-        default: 256
+      enum: [4, 8, 16, 32, 64, 128, 256]
+      default: 256
 
   snps,dma-protection-control:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.43.0


