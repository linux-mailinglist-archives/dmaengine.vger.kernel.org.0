Return-Path: <dmaengine+bounces-4320-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D82A2B4AA
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 23:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C590B165542
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F322FF43;
	Thu,  6 Feb 2025 22:03:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098EE23908E;
	Thu,  6 Feb 2025 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879408; cv=none; b=nAlx0hFYjPGF8TvbU0MCuKs1R8DFfjMNTXefheQt6+N+9v5pN2Ax/uu70va8chjUvpFISV7aO/mLWBEc/3fDPMx4xr4lq1qAfEYYNf+Xq9xPcaeZQmRhlYDxd8FaYqn8i0AdNPIJuP12d6NdHB4JblMou6TauiP4Em4EA9Fq5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879408; c=relaxed/simple;
	bh=DqKjsZ0vyc1aR5v8xm1pNo9x6effzNLvtT4TDbb1ph4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L3cIsOHS7sqYKMaZWvyIOLMrcgUqIyaj+Gz0RgwvQaMr9rLm+LTkdmAaHy457HPq0dBDwAk/SR9WBqtndp0FU2cj5lV31R0RuBgkiqpt0klbnqD5evJTDo3pwfCDYNLs10NqlfuL9cpdnbVyK+LxiqAoo5j4ldTKBamcbvDXEd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: vD3J4fqLSaCqkH0ePdka5w==
X-CSE-MsgGUID: Q/GESUGQSfOcl/dzoQYiNg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Feb 2025 07:03:26 +0900
Received: from mulinux.example.org (unknown [10.226.93.55])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9A89940AF4A4;
	Fri,  7 Feb 2025 07:03:22 +0900 (JST)
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
Subject: [PATCH 2/7] dt-bindings: dma: rz-dmac: Restrict properties for RZ/A1H
Date: Thu,  6 Feb 2025 22:03:03 +0000
Message-Id: <20250206220308.76669-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206220308.76669-1-fabrizio.castro.jz@renesas.com>
References: <20250206220308.76669-1-fabrizio.castro.jz@renesas.com>
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


