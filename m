Return-Path: <dmaengine+bounces-3234-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0A989EE1
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 11:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC881F22A6C
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 09:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284718E36C;
	Mon, 30 Sep 2024 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EBljyAUx"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398BF18E046;
	Mon, 30 Sep 2024 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690150; cv=none; b=GYScbXg+TcWYTV530pA5lRnNqeqKYZjP3YDq9tVTWDTIRe5iZDH2O9Rd3o1BQwm5CUz1JPR1FhpytiPitBXG+npf+WwPEHpIN8C4DaCUS2sI/8VcE5s51nj6grkQYk3W5F3ua4cAd9bxej74RSY6YD1ENqvOB892cAQ62V5C324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690150; c=relaxed/simple;
	bh=nLkCuTBPfpbqNBH1j3e2/aPI6MfTBWdislcAckUBGL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6eMHadvDyFOB9ZLMmRTL+N8o5AuVa+8m4CLCxgmgPWZ6LgC3QaH7orSS5/SN6GwjGf3bK/0/HcNo1WIH1AEWBqOgQGw+FJSMu5GlNguhEaV5QqWP8XNbpUJZonvl3Bjer88j62hJc9jNlntr2LD3vtWP/qmakgPcFbteqqIcBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EBljyAUx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690150; x=1759226150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nLkCuTBPfpbqNBH1j3e2/aPI6MfTBWdislcAckUBGL0=;
  b=EBljyAUxYlwhcNrpKVCyRb2CqVXICTVBBkeDYIk/ZfNMjjh3UasOmKPE
   4KMSsy8jjVL0dojivIV4GIJ1PYqf7lQ4ErQPosvXfkGD1N2G9wYXdeV/x
   /dwH8fvX42IIAfUMfr7qXos7Ty+5Q2yuwqbVnske/dqrlZwa1AsfBTyO5
   vIN6YgGQhUYq4WKMKu3ttVrCzOdwIdOlaHMhCMYhBMCDBwdMT+vDCvoSa
   WZ2rKvhrB0pOrNB1fA/hyP51QaNjRADpDOS1Dl83FjVShrmTN25CCz6my
   qCdEZfzLpmqREeuq59vTycTyI3Jz1jN6K+o1u9FBL5vwNRpwI0magqo78
   w==;
X-CSE-ConnectionGUID: VDfGPtv3TTmpuSmsWgS4Xg==
X-CSE-MsgGUID: VdO0X8l/Su+LpxXBcz6CqA==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="263420168"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:23 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:20 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Vinod Koul <vkoul@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>, Green Wan <green.wan@sifive.com>,
	Palmer Debbelt <palmer@sifive.com>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 09/20] dt-bindings: dma: sifive pdma: Add PIC64GX to compatibles
Date: Mon, 30 Sep 2024 10:54:38 +0100
Message-ID: <20240930095449.1813195-10-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

PIC64GX is compatible as out of order DMA capable, just like the MPFS
version, therefore we add it with microchip,mpfs-pdma as a fallback

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 .../bindings/dma/sifive,fu540-c000-pdma.yaml      | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index 3b22183a1a37..609e38901434 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -27,11 +27,16 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - microchip,mpfs-pdma
-          - sifive,fu540-c000-pdma
-      - const: sifive,pdma0
+    oneOf:
+      - items:
+          - const: microchip,pic64gx-pdma
+          - const: microchip,mpfs-pdma
+          - const: sifive,pdma0
+      - items:
+          - enum:
+              - microchip,mpfs-pdma
+              - sifive,fu540-c000-pdma
+          - const: sifive,pdma0
     description:
       Should be "sifive,<chip>-pdma" and "sifive,pdma<version>".
       Supported compatible strings are -
-- 
2.30.2


