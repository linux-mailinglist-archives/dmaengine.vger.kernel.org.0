Return-Path: <dmaengine+bounces-7147-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF5C57631
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 13:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DB514E6E2A
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E41934F46A;
	Thu, 13 Nov 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="azDRmI+R"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545CB27B4E8;
	Thu, 13 Nov 2025 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036569; cv=none; b=kXI8nY9en1z1UnrFzI8ddwYilTIV06o4HR/I4at7A2S3n+1B7l9IJL6OVHlWxUKP/zCX6UwWcJntc2lL3FtBBSu1X9OP/u46Wcp2wYNvgbxuUym/hYItvZ3aaJ8CszMUQ3Zp86hXZ/LABNw0lqn7we0l7CwhW/qulu3qp4Qwv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036569; c=relaxed/simple;
	bh=RKcFAn+VDGMwlQVrFJj0LTHiZhkHmlIFPaKbYwlojYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AP9FOF1oGz7DvLRy68dcL0NPZJ4BtAjptKDYmVWwiNurvs428khcOeP/Hrecq24/065V8bg7OtM7XYcwoSV2O43IFK7Bc44CzJ6+haiOykq0Ir4aGJ4RWrOPktBA48DCaxfrhpWtyimk1prms8h/q+ekB74kdwDJxxV894lKk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=azDRmI+R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763036559;
	bh=RKcFAn+VDGMwlQVrFJj0LTHiZhkHmlIFPaKbYwlojYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azDRmI+R8f1SgJoLsdNywzkpwwGJ9Kbr+CrWk/huSIyHtmTjB002cpp6E6u9bIJ8d
	 onGTt6VqOtb5n4XiYSY0AFXh2Qktduo48lG2++VHjoDE3FKyyOfbNPqhvH4JYUrCDG
	 r4hw5C34VIKlOk8Lk/jgUeeyiknXA2jzsyHTXUXRKyIGo61mAdhR3WhVqAzx7Qj1Ax
	 hPfa8UGk7E1rnrF2l1Z/LFXhGDWPNTqA2g4yQ1EvhmLVNQ++75IY+5TnJDPb1NAjju
	 DUj/hSLpkiYnacOxkbkm2TZC7EI6eJI4dz5uqcKpXovvka9hJNDU/RHEuFCOAng3PO
	 mU0LjEH93CstQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B1F917E1340;
	Thu, 13 Nov 2025 13:22:39 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: dmaengine@vger.kernel.org
Cc: sean.wang@mediatek.com,
	vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	long.cheng@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 2/8] dt-bindings: dma: mediatek,uart-dma: Deprecate mediatek,dma-33bits
Date: Thu, 13 Nov 2025 13:22:23 +0100
Message-ID: <20251113122229.23998-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
References: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this property wants to express a capability of the hardware,
this is only used by the driver itself to vary the DMA bits during
probe.

Different hardware shall instead have different compatible strings.

Following the driver cleanup and the introduction of a specific
compatible string for the APDMA IP version found in MT6795, set
the "mediatek,dma-33bits" vendor property as deprecated.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
index 10fc92b60de5..4d927726df93 100644
--- a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
@@ -59,6 +59,7 @@ properties:
 
   mediatek,dma-33bits:
     type: boolean
+    deprecated: true
     description: Enable 33-bits UART APDMA support
 
 required:
-- 
2.51.1


