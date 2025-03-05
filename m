Return-Path: <dmaengine+bounces-4645-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27559A4F262
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 01:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CB2188F7AB
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 00:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB282D05E;
	Wed,  5 Mar 2025 00:21:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7622017548;
	Wed,  5 Mar 2025 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134097; cv=none; b=mXd0ZkthbiwRJGiP7q6wSAwtM+fG6NzCcTDodLj6lr7F8kgg+VZHuQ0dm1wuLqTiSijllGahyoVEqhEjbodUlTDRkP1JG0+eGEWnFv9LJfb0+gSq0oS9bzznhnOVmpvjZYSNQa3/4pMhxiC2SmlGXNDFHgOoO2/K9ev5s5C5E5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134097; c=relaxed/simple;
	bh=fvdCac4sqR/Njza0af2NCC5OdP/Mbpr38b1QkpUuv0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLjuJc1blwjiW2l/l8xaJjS7XHP8AZSZtqYMMZQubJi/F2IsL4NoVdIf9euVsKmPuOFJKBRk3WDVcEe6FDBBw7ArVnXpLENTzvRW1D3xAv1yskvknhCejzzh4aAuLN0lioWtd7Qnq10/+WoUWZQrQYAVlh1A7rivnnOjpGEl/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: QRjrZrDXSLuPei8IAKHW9g==
X-CSE-MsgGUID: 1HANV2RgRFuB5sLgM/3SRw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Mar 2025 09:21:30 +0900
Received: from mulinux.home (unknown [10.226.92.17])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id ECF9A404D874;
	Wed,  5 Mar 2025 09:21:25 +0900 (JST)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/6] dt-bindings: dma: rz-dmac: Restrict properties for RZ/A1H
Date: Wed,  5 Mar 2025 00:21:07 +0000
Message-Id: <20250305002112.5289-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com>
References: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4->v5:
* Collected tags.
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


