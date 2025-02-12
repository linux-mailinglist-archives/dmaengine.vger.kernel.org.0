Return-Path: <dmaengine+bounces-4451-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC74BA33238
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 23:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152313AA180
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB421129D;
	Wed, 12 Feb 2025 22:13:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7090205AC3;
	Wed, 12 Feb 2025 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398404; cv=none; b=UmGjjPQNQ/M5qT06qPZo+GPvcBtbaVuFdII3eSM2GFdWCnfJhVx4DXExCZTIuPmbeEay1FyffGKt3IjObhvjxoPDyyErLhRY38tGbn7d7XfU/zUqAs0vQTir3pVTCKRLmNlp9Bszp9eyUO8z41cGYWTreuM0tjOWWpJpS9zMy5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398404; c=relaxed/simple;
	bh=d4/O4IqwTDvm3lELgZsxQaM1SWdPgW8MiGY50WKq1wY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J00t9bQ494o6Nf/0ZyreXk+qaW35/lhEv7VK4jqOxwQuH03K2mnNw9p63cs1wWliTWXxrYgi9tEfxXy3TVQ74ZX7SivMGITZcR6VzWMonp6g09ufq5wRjon0WvLhDvhuM0BM8zpRYiDVnlWOPf0v0Fjpe3kr1X7rRan8qWTtPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: TfjP905zR5OWWa3k3WZmiQ==
X-CSE-MsgGUID: a6emqeTeT6yzwy2XTa7Uag==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Feb 2025 07:13:21 +0900
Received: from mulinux.example.org (unknown [10.226.93.8])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 79DF340AACC4;
	Thu, 13 Feb 2025 07:13:17 +0900 (JST)
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
Subject: [PATCH v2 2/7] dt-bindings: dma: rz-dmac: Restrict properties for RZ/A1H
Date: Wed, 12 Feb 2025 22:13:00 +0000
Message-Id: <20250212221305.431716-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212221305.431716-1-fabrizio.castro.jz@renesas.com>
References: <20250212221305.431716-1-fabrizio.castro.jz@renesas.com>
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


