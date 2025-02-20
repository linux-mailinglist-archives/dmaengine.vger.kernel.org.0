Return-Path: <dmaengine+bounces-4550-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37637A3DDA7
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 16:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A427AC3FF
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93A81FDA7B;
	Thu, 20 Feb 2025 15:01:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DEC1FCCFF;
	Thu, 20 Feb 2025 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063688; cv=none; b=aEcgP8qPiAYeMl5HXZfJPeOXwU3yZABqstb094pF2LipDembakjFv+7JXLioXcctORVbcCuZoj6wTWsSgXODVRlqA4lt911FYBZBrTRCJ8oxk6wZjorWwVL1P/G+bwfZZ8rErtm9tPJNGe97fbPTk1L4f7X0W99Cw71m33SDoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063688; c=relaxed/simple;
	bh=1q67/sKbU01LNwNTA+BXBDgeiYOVo0tD17OvaQniJOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RugljIkjoFG7ke5AwDJVhY0dVwZGgehajT59ok4dov3dn1BXsLFYGzStkT0FlDsKnrKHKA6kUXQejXid9dNSAGeRf7S/cYTIIcrroy8tniG8M5gqf4rZ7U12jjaoqTi1Rbt/GnpH0KjUHt/JCvjjH7qMACUfP+svjQMbIRNfr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: wsm71mwiSx2xciw/TMYjng==
X-CSE-MsgGUID: BM1zE8w1Sdm7bR1Gzus/SQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Feb 2025 00:01:26 +0900
Received: from mulinux.example.org (unknown [10.226.92.65])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0324842C8309;
	Fri, 21 Feb 2025 00:01:21 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 2/7] dt-bindings: dma: rz-dmac: Restrict properties for RZ/A1H
Date: Thu, 20 Feb 2025 15:01:05 +0000
Message-Id: <20250220150110.738619-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure we don't allow for the clocks, clock-names, resets,
reset-names. and power-domains properties for the Renesas
RZ/A1H SoC because its DMAC doesn't have clocks, resets,
and power domains.

Fixes: 209efec19c4c ("dt-bindings: dma: rz-dmac: Document RZ/A1H SoC")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
v3->v4:
* No change.
v2->v3:
* No change.
v1->v2:
* No change.
---
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index b356251de5a8..82de3b927479 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -112,6 +112,14 @@ allOf:
         - resets
         - reset-names
 
+    else:
+      properties:
+        clocks: false
+        clock-names: false
+        power-domains: false
+        resets: false
+        reset-names: false
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


