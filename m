Return-Path: <dmaengine+bounces-4524-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC3A3ACA9
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 00:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C57AE7A4465
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 23:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2641DE4EF;
	Tue, 18 Feb 2025 23:43:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE7B1DE4C5;
	Tue, 18 Feb 2025 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922207; cv=none; b=Fo46VcbB+r5SN7oe5bGQfm24+WimGlkDkt1xHgGCVLM98demtEI1AhK0Aq2IZ26tqwLjWrtYTYxTIageHfwRAROeVNiE12D3lTvkj+YT4NVY6VN4zqOJXc4s9LcAifbKkcnW+CQPMbFVnoqPYS2cT2FcrIInWxTZBZMoFWRH1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922207; c=relaxed/simple;
	bh=eX/0IGXfXZ8n/KQ69vWisMH4KMm5NuuWSIxdXWCNTkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dKCZeunQNp5MIpDRjWc7V5NEDJjvu9SqZJjcZaASiHuMOYf/SHAjyIdY+6b4vgnmkVDgsNtEqd+l3KOZioSUfslTrzz0E4fwOwwp1NOYMe53OfmzIz3r6fgdL+USFGz4VeVngkTLgVFXmchNMx/XvZrXAcKnKidV4nLKNimXoTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: Te9t327nTA2Pq18PDQv2oQ==
X-CSE-MsgGUID: ZYLtr6ixThiR06uH/qLCpA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Feb 2025 08:43:21 +0900
Received: from mulinux.example.org (unknown [10.226.92.65])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id ED73F40FDD99;
	Wed, 19 Feb 2025 08:43:16 +0900 (JST)
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
Subject: [PATCH v3 2/7] dt-bindings: dma: rz-dmac: Restrict properties for RZ/A1H
Date: Tue, 18 Feb 2025 23:42:59 +0000
Message-Id: <20250218234305.700317-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218234305.700317-1-fabrizio.castro.jz@renesas.com>
References: <20250218234305.700317-1-fabrizio.castro.jz@renesas.com>
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


