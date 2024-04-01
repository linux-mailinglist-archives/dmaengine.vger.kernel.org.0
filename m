Return-Path: <dmaengine+bounces-1684-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E6894628
	for <lists+dmaengine@lfdr.de>; Mon,  1 Apr 2024 22:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA441F22092
	for <lists+dmaengine@lfdr.de>; Mon,  1 Apr 2024 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E687E43AD1;
	Mon,  1 Apr 2024 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCSbRpX1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76321EB31;
	Mon,  1 Apr 2024 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004240; cv=none; b=WyMDEcQJBO5sUhenjIVRbtUEMCJ14ND9eEI5jyHDMUgm+9lb8WebPFLUkKusKYAHPnhiN0gKWNdSgJISVqMyjFP6zFv8f8354/ONOvyzv4Hl3eAcAaWAzFtljpRzN6N9ZjPssluN/GgyoifHt6gVRnzgvZ+Tu8dmAorm/GePgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004240; c=relaxed/simple;
	bh=PbWJ4zFdnAhUsADey3LkEStZEZuTOSuvaXwBHAs8Hr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HimMGQIzENzqW54OMLkYyRQ6BrMdhvl4oc9G9SaBLGo2rPagHHcDenRg0vvgDgWeHQo8HoQkPJ07/pUMyuxlonRsNw7v4coItzy6zoOtYvNjiND4TRQhGXXsFLU+DrGXaKuP40LJgGgVsApxMxqJ1fJrDBtSP9kz83pIXMDiKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCSbRpX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9DAC433F1;
	Mon,  1 Apr 2024 20:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712004240;
	bh=PbWJ4zFdnAhUsADey3LkEStZEZuTOSuvaXwBHAs8Hr4=;
	h=From:To:Cc:Subject:Date:From;
	b=bCSbRpX1FdqEtSkCsK5Qq6d5phY2G8Tm8eayj3N23DC/LYiz3AV38rV4+M6GFwapH
	 CTp6RFi/2511ccrU3R44+pACYW47QHouai/AGB+UIuUUe4lzL1d6ZTN7qteihruKzz
	 c5a51RajNe8wz97cSgHxO2aXp1KZ7rh8uc0dmmuaO+cph3xDGkd3IaQr/yy3getaAG
	 SyiJNaxAl7l/sR1kJSXtd0dF8etP8m+poFPAtt/nZV7znsHZ6hnP55ECxZa8h1V7YL
	 Uw7l+zD3Y8Vluiv2ITLC9bJQ8QCKAGiM1cBFSyIipg8G2ZL4joArXpq/IgYSL7xl24
	 0jFKYlxvHzxeA==
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: dma: snps,dma-spear1340: Fix data{-,_}width schema
Date: Mon,  1 Apr 2024 15:43:53 -0500
Message-ID: <20240401204354.1691845-1-robh@kernel.org>
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Make 'minItems' explicit. This works around a bug in dtschema, and is
   also preferred.
 - Add tags
---
 .../bindings/dma/snps,dma-spear1340.yaml      | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
index 5da8291a7de0..c21a4f073f6c 100644
--- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
@@ -93,10 +93,10 @@ properties:
   data-width:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description: Data bus width per each DMA master in bytes.
+    minItems: 1
+    maxItems: 4
     items:
-      maxItems: 4
-      items:
-        enum: [4, 8, 16, 32]
+      enum: [4, 8, 16, 32]
 
   data_width:
     $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -106,28 +106,28 @@ properties:
       deprecated. It' usage is discouraged in favor of data-width one. Moreover
       the property incorrectly permits to define data-bus width of 8 and 16
       bits, which is impossible in accordance with DW DMAC IP-core data book.
+    minItems: 1
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
+    minItems: 1
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
@@ -138,11 +138,11 @@ properties:
       will be from 1 to max-burst-len words. It's an array property with one
       cell per channel in the units determined by the value set in the
       CTLx.SRC_TR_WIDTH/CTLx.DST_TR_WIDTH fields (data width).
+    minItems: 1
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


