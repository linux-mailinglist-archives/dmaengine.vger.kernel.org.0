Return-Path: <dmaengine+bounces-7180-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D17C604DC
	for <lists+dmaengine@lfdr.de>; Sat, 15 Nov 2025 13:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 229D54E61FB
	for <lists+dmaengine@lfdr.de>; Sat, 15 Nov 2025 12:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51EC29B20D;
	Sat, 15 Nov 2025 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1+3VldC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A423D288;
	Sat, 15 Nov 2025 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209294; cv=none; b=Wl4oBf19uKw9ThX3wlgZaGHdxzNGGXW/jgzSlUCWNXoZMh+rk5h29O4UJZrjDSMzzta9iifcq8UKTbEZcNneEiI7bqQMOlifjmCJS/oiROFofvHKzlz7vgwkLsDW4OAcuS3mC2f9K52rEP1F3f3NLhpBM7T8CCPNApmNRxm6gME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209294; c=relaxed/simple;
	bh=avO0zpLxyi3tvTmbM/WVmfIlk/427UKM8doZxyoj6Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFNeXkvSfTZO8wgUQyaEXu4G7NKAfYifhwgosd5fuVEYRgAcNVaid+zQA1IKduYMkznuIq5hMoA3tb/awu/wjDMmYzaUZmDJPIIq57XYAjUurs2jD0rgLa42MJhPIDBuejJu3Tl2BEJDDzPuRjKbW57+l49cCOUeSttStWmL6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1+3VldC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72599C4CEF5;
	Sat, 15 Nov 2025 12:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763209294;
	bh=avO0zpLxyi3tvTmbM/WVmfIlk/427UKM8doZxyoj6Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1+3VldCGa52eZ/Zo9eHfml5HhFLEVqgR3n9XtEeu6QAjh3Am5hDmX4t+djYzeiHu
	 mzDNoXpTh//8eVqq5dqIzbJLEwXXSmgiOtoQnANHt9m37XXdg5dcC0hqB298vmobjJ
	 cXsizUghYcXIBNDtZ0WuQbjkybj3P9RGym/UcjQNJVbjzX5IngWDGIeOKYfaDUwwzT
	 vOQ1gzwm66U/NvQDkl7Vx9oa8mUdcd3mROhtQXtoyjTZYBPfqQietdG2Q0oPMwlH2h
	 wMH2knPzRBeTeKMpA50kGQDVPJR4c790AYNKlopkmkSaBWBMcjSwMES5Z6uV/YS2B8
	 6CyS+nXy2LFqg==
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
Subject: [PATCH 2/3] dt-bindings: dma: xilinx: Simplify dma-coherent property
Date: Sat, 15 Nov 2025 13:21:22 +0100
Message-ID: <20251115122120.35315-5-krzk@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251115122120.35315-4-krzk@kernel.org>
References: <20251115122120.35315-4-krzk@kernel.org>
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
 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml    | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
index b5399c65a731..2da86037ad79 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
@@ -59,8 +59,7 @@ properties:
   power-domains:
     maxItems: 1
 
-  dma-coherent:
-    description: present if dma operations are coherent
+  dma-coherent: true
 
 required:
   - "#dma-cells"
-- 
2.48.1


