Return-Path: <dmaengine+bounces-6003-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF794B23A08
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 22:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF04D1A27656
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9102D0603;
	Tue, 12 Aug 2025 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey348pIx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A92F0693;
	Tue, 12 Aug 2025 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030796; cv=none; b=VN8NkeDywdTYeT9OQoFRFWG4Fs3Vm/lBT9ryEOuvMSU+jgXPpn4oWHz2s2//wmfWHzzYhMRzX7z86rKmrL/xYgCf8kXj+mFcqra/uEHldHFY0776Vnnk4Zs7CR/h6yMi/ZEb+ZxbuYvyPV0Xo+oVZNHiKSD/Ani1yQORyqq1TH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030796; c=relaxed/simple;
	bh=uwbhXIneRmsaZaWvxLCpVQGXbk9Wr+ul8nmFQxg5e64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVJABLHpkP7gJ2CWKX7OhHJSZ16Plv3Hv9SpCs0j2CbrrAXmUKo3RoweJyh/GVlEWQMSbGXsDuYlnsNHxdOeMmgniJUppjCTPWHkp/NX1Q/vu0mT8sOM+LEe37YpJEVD739Vcc8Lo6mR0cQ7n7OETOKwMBEimYyWp5sAfmwYKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey348pIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B056AC4CEF0;
	Tue, 12 Aug 2025 20:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755030794;
	bh=uwbhXIneRmsaZaWvxLCpVQGXbk9Wr+ul8nmFQxg5e64=;
	h=From:To:Cc:Subject:Date:From;
	b=ey348pIxSmFm/UuOuwlV3pkJy5dMXtVoasKq52qo7O4uY0j2SJbbn6qngNNJBcBHW
	 X9Q11QGg5IQebv64cEGTwnMIF9xB37Qt9OLbVilFMMjHJvXxfkIU6RzPd0tUgwLroD
	 AsYkvpxBbdzty+v9+//6RFeHzYdGtfyw4KN3+jfi09MUXZnHbJ9r5SeuNSy9yO00jX
	 /sek+IMGEQ+w4vh8He+bZr0DZwnm0tNdAOnKEs1SoNwjsMv/vxJlrM9uoBrVzOQwWm
	 q9J0P581vrR5fy1MVSAenZ4R+9X95afhO9ruvsra9bIpGn3ropkCR580C27pEcTfgZ
	 D0kKpJoI3CQQw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: nvidia,tegra20-apbdma: Add undocumented compatibles and "clock-names"
Date: Tue, 12 Aug 2025 15:33:07 -0500
Message-ID: <20250812203308.727731-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the undocumented NVIDIA APBDMA compatibles and "clock-names" which
are already in use. There doesn't appear to be any per compatible
differences.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/dma/nvidia,tegra20-apbdma.yaml          | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.yaml
index a2ffd5209b3b..ea40c4e27a97 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.yaml
@@ -18,10 +18,17 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - const: nvidia,tegra20-apbdma
+      - enum:
+          - nvidia,tegra114-apbdma
+          - nvidia,tegra20-apbdma
       - items:
           - const: nvidia,tegra30-apbdma
           - const: nvidia,tegra20-apbdma
+      - items:
+          - enum:
+              - nvidia,tegra124-apbdma
+              - nvidia,tegra210-apbdma
+          - const: nvidia,tegra148-apbdma
 
   reg:
     maxItems: 1
@@ -32,6 +39,9 @@ properties:
   clocks:
     maxItems: 1
 
+  clock-names:
+    const: dma
+
   interrupts:
     description:
       Should contain all of the per-channel DMA interrupts in
-- 
2.47.2


