Return-Path: <dmaengine+bounces-3805-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC29DA58F
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 11:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2094B23407
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FFF198E92;
	Wed, 27 Nov 2024 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A2sfmo8P"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F8196C6C;
	Wed, 27 Nov 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702613; cv=none; b=IBrjKFjpXh/gUBAHCijMk17TWWHFt3+Z1j2452QQae5UbXPEFK0/JYXOwlc3eQmorU4wV5gQefM7RrVELpFzw4cL0ZzjlcDI9f7VE08LTjJCppCxY+kSRzLzBFPvfKG0mp73rfK62VVvJ2mCeHxAs2ZdOwZlJdpPFatP0+ZAc8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702613; c=relaxed/simple;
	bh=IEZYFq7ZA0bJavu0NuORPkZdBxRIAAOqrzKUTb6QUyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5MEpiqZn/7LWNcZ8U004svPnTsMvXH7NAzmd7ItW1+ZpIR7LWOKbPn/L/F1M5HxxxnTdY0TMAO8nRkoTP2lidHIfWVEaMOexnLGUtmJYzegTrRXnjRWmu3k5G2PaAROKE6Xdl/7iKpMi7FuWK+GAtIFKg4EOn8H7Zi0q2Y1Z9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A2sfmo8P; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ARAGZ5V984414
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 04:16:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732702595;
	bh=q/nYmdCTz44+JCFZUJpD+tY0QDH07BMbYOzhqdwiOqE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=A2sfmo8PZ3zEjuyIN8D6hvV2kNyJFkJvTj1dLEp1JwXxhieKX+E1cT3FvUbRV3DwW
	 /tIx9lVkF97UKrrClkDUOn3wMxrTZLgCEewIFKZv1sHHhSOnItlAVmIGsKZKx3qZLd
	 AIwCywKwbPGPjYZKV84qBK6JXDE6oZsTQRvI8Wb0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ARAGZYY026756
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Nov 2024 04:16:35 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 04:16:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 04:16:35 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ARAGRoL104602;
	Wed, 27 Nov 2024 04:16:32 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH v3 1/2] dt-bindings: dma: ti: k3-bcdma: Add J722S CSI BCDMA
Date: Wed, 27 Nov 2024 15:46:26 +0530
Message-ID: <20241127101627.617537-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127101627.617537-1-vaishnav.a@ti.com>
References: <20241127101627.617537-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

J722S CSI BCDMA is similar to J721S2 CSI BCDMA and supports both RX and TX
channels but has a different PSIL thread base ID which is currently
handled in k3-udma driver. Add an entry for J722S CSIRX BCDMA.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V2->V3:
  * Added missing compatible entry missed in v2.
  * Address Krzysztof's review comments to not wrap commit
  message too early.

V1->V2:
  * Address review from Conor to add new J722S compatible
  * J722S BCDMA is more similar to J721S2 in terms of RX/TX support,
  add an entry alongside J721S2 instead of modifying AM62A.

 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index 27b8e1636560..b5bc842c5a0e 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -34,6 +34,7 @@ properties:
       - ti,am62a-dmss-bcdma-csirx
       - ti,am64-dmss-bcdma
       - ti,j721s2-dmss-bcdma-csi
+      - ti,j722s-dmss-bcdma-csi
 
   reg:
     minItems: 3
@@ -196,7 +197,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: ti,j721s2-dmss-bcdma-csi
+            enum:
+              - ti,j721s2-dmss-bcdma-csi
+              - ti,j722s-dmss-bcdma-csi
     then:
       properties:
         ti,sci-rm-range-bchan: false
-- 
2.34.1


