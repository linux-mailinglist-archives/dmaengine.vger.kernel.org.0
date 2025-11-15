Return-Path: <dmaengine+bounces-7181-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED27C604E8
	for <lists+dmaengine@lfdr.de>; Sat, 15 Nov 2025 13:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2A724E7629
	for <lists+dmaengine@lfdr.de>; Sat, 15 Nov 2025 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AF629E0F7;
	Sat, 15 Nov 2025 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbhUTg2y"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F6B29E0E8;
	Sat, 15 Nov 2025 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209299; cv=none; b=W+st1ehcPVengYU3NmeHZ0usBk8Cir4L99hKQft/lQQ3cG58YjbpGYfrDxmutQqY4PFGOrRWYYmrq15KU8zA2bdYxPvZWMvlAM/bPcyA5fYgGflgnWx4Med26vUcRRAGTI//62eGFEj57iM1lKaIfQ+0Sq2QkAMQXX+4XR+eV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209299; c=relaxed/simple;
	bh=qnbEQfJ/X0ZmpMOyN7rpabYvjrZ5czl2oCiK6yZ/aM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAAoqBTzwn5ijjUuCLfhCWY1aq3mG7pyvkjIpkqEa2HkdzDWieOTULF2lsAVNGjzftcg9g78WSjWkCNvb5VhuwZTu2vygbiTWkUKA3xrLh1momjESXrgpcBa3YbdEqYB7x+8FIJRtcxWAgtSg7gTLeHsu+Q61/DQSZfsLdqHXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbhUTg2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EF2C19423;
	Sat, 15 Nov 2025 12:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763209299;
	bh=qnbEQfJ/X0ZmpMOyN7rpabYvjrZ5czl2oCiK6yZ/aM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GbhUTg2yrGlqBqVcfC9aqi1YG/6NW5DUwhyWV5txF5m9ZyTAKTz4BxGdHAxWXA+z/
	 ajY63z2+iHYvGDaOnpHL8KOwJQ+bXOfC8Fr0xhYnthlwHTK8sXSVUwZvfzhmIRBIYe
	 jE6a3yvmWy0jZ6Hr1QMg2MV2qXco19ljCMv+g0jPfD6GUioaFESwYdCG151UU09IvA
	 en868vAL8EhhCnk6SXMC9QHZAmXMfBjjNRYgbtGkpnAMjwMYLJi2sE5Ge4dN7nlY8d
	 gGSYvw8rKDUP0ZDisjQin1CkHJxVFx3Xb5aIDUk4DkCqXOby51UQsbzJfJELPcry/4
	 KArbIYHHxlkmg==
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
Subject: [PATCH 3/3] dt-bindings: mmc: am654: Simplify dma-coherent property
Date: Sat, 15 Nov 2025 13:21:23 +0100
Message-ID: <20251115122120.35315-6-krzk@kernel.org>
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
 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 676a74695389..242a3c6b925c 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -50,8 +50,7 @@ properties:
       - const: clk_ahb
       - const: clk_xin
 
-  dma-coherent:
-    type: boolean
+  dma-coherent: true
 
   # PHY output tap delays:
   # Used to delay the data valid window and align it to the sampling clock.
-- 
2.48.1


