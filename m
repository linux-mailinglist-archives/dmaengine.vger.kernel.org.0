Return-Path: <dmaengine+bounces-7179-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE54C604BC
	for <lists+dmaengine@lfdr.de>; Sat, 15 Nov 2025 13:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2B084E2C39
	for <lists+dmaengine@lfdr.de>; Sat, 15 Nov 2025 12:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81124299A90;
	Sat, 15 Nov 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp5p5xX7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273427B50C;
	Sat, 15 Nov 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209289; cv=none; b=k08pyhTFE55xqWNxkNBt3ImKk/U3/qoAqkw2mzbp4GkWp7BTg2GbFe3vCq1odWXv2YLmfMz2TzJeLvPrOQlhSuZTSi03OcQ2ycNcWZhEXcHFlsuI2Gln9lSmDeV4tCqx9330eK45LqJwkb00yD6Oc36iY5Hf7RrgqAzWIs1zEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209289; c=relaxed/simple;
	bh=CvW3RPjAQHRDOfHqugrlxCPi56fwvh2F4UBJhuXf3jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJBTQhEUA1QA8sJuLa1LaRmMtxVGDKb2pTfuNRiq+/Dyx8HhPV0et+DGjFQ6KSLw1pYWPcMAljHs6Eboc/LyUL7vQN/7obiz6Pv+AybhGBvmLuI+IXPg1SflasDXFpKZb6qzjsmwNdXCar/KidghOLzOPQtkc4MKHEKiB+FsH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp5p5xX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683ABC16AAE;
	Sat, 15 Nov 2025 12:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763209289;
	bh=CvW3RPjAQHRDOfHqugrlxCPi56fwvh2F4UBJhuXf3jY=;
	h=From:To:Cc:Subject:Date:From;
	b=qp5p5xX7ENbuB1mPVuIYCFnQYSYEPZ5tpWjz30Y0M31mP4b20X/sC9/9ZCzECXwMN
	 LDbhsstItv8lHknHCJvXhUcCiRgI2oX4W0rPhrIBFQo/6FWKmqmjRUzhHStlgSZTBn
	 NFIxnDFkB4UJsXn3jdPl/pYr3gvX/tk02FY4t8j8NiGRCvhAlWePlAG2r+NYvB7guk
	 FzxN7BQbuBeCnKcdDQPItEO9PCTqX+o0od9GC6xr2FFu080JYl86KdwFmMl1xVpms6
	 3+C9e4H+4hzDhu3ibGRicQ/fsSc4yLa7tEP36hiAXFcBT6bkudn2Z2RzxhBUdHLDnE
	 OjUplpuBVEnZA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Harini Katakam <harini.katakam@amd.com>,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] dt-bindings: display/ti: Simplify dma-coherent property
Date: Sat, 15 Nov 2025 13:21:21 +0100
Message-ID: <20251115122120.35315-4-krzk@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Common boolean properties need to be only allowed in the binding
(":true"), because their type is already defined by core DT schema.
Simplify dma-coherent property to match common syntax.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml | 3 +--
 Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 361e9cae6896..38fcee91211e 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -84,8 +84,7 @@ properties:
     maxItems: 1
     description: phandle to the associated power domain
 
-  dma-coherent:
-    type: boolean
+  dma-coherent: true
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
diff --git a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
index fad7cba58d39..65ae8a1c3998 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
@@ -103,8 +103,7 @@ properties:
     maxItems: 1
     description: phandle to the associated power domain
 
-  dma-coherent:
-    type: boolean
+  dma-coherent: true
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
-- 
2.48.1


