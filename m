Return-Path: <dmaengine+bounces-5399-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46136AD68A7
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 09:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C4917A501
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 07:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20AB222596;
	Thu, 12 Jun 2025 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="asFA2Tb0"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F22222571;
	Thu, 12 Jun 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712591; cv=none; b=pRZ9O9Xu1Ap+05ajmtHOKzQI92op+XEHhtiapE8T27w9frU6KiaFzO+j0kTfSVLgTetvHNqPVyvLymr/ggvkoXw017bCsL1Hc5lSjnLL2VYFkVeQiqFMvimmFRnM9H1cRKrU+kamqnIMOFyi2W8mst/ye8mvPjgbuBXfAS76ywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712591; c=relaxed/simple;
	bh=nunSoUgL+OqF/9Wb5ALb9TtxDzYYeJ25IDSPvV6oElQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIzuItdVtircHnPKLA07DxOHs99fW7xjqGwFpcZ3TIMqZ74QP9lkn2/96w8bIjRIzJRGeQj1eGqrE58dy4gYn5DnQFRO8A65YLeDWweRMqP2aP+GkAYZOjXYvrw3n3WWX8X4ZgOQ6B1VeQfCjH1QFwY6YqjphTTtHPD0pEX85Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=asFA2Tb0; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C7GPa71594309;
	Thu, 12 Jun 2025 02:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749712585;
	bh=XhMgCzLFHDrjP7IHTKbvXrrvOjH/iAr+ej+q3Ejpd68=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=asFA2Tb0X3GrLpoIhs8JEbCZjBSm4dUiMPyLlCz1cpR/AAW/Du55Bch6TYK0Zwg2I
	 4OVUMc1osty6Kdd8r8yNKRNRLHsKqlevWos7LQT+HKxvE16eGXXfsZ2m3Y9e1e6A2P
	 fRt034ez0GLKv8Eu7xvRRuTe0NdnLfiO/SMjDqsI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C7GOhZ1618875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 12 Jun 2025 02:16:25 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 02:16:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 02:16:24 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C7FTKW1608959;
	Thu, 12 Jun 2025 02:16:19 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Sai Sree Kartheek Adivi <s-adivi@ti.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>,
        <p-mantena@ti.com>
Subject: [PATCH v2 10/17] dmaengine: ti: k3-udma: move inclusion of k3-udma-private.c to k3-udma-common.c
Date: Thu, 12 Jun 2025 12:45:14 +0530
Message-ID: <20250612071521.3116831-11-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612071521.3116831-1-s-adivi@ti.com>
References: <20250612071521.3116831-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Relocate the #include directive for k3-udma-private.c to
k3-udma-common.c so that the code can be shared between other UDMA
variants (like k3-udma-v2). This change improves modularity and prepares
for variant-specific implementations.

No functional changes intended.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 2 ++
 drivers/dma/ti/k3-udma.c        | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index 9c541646e8e44..27abf389cc878 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -2489,3 +2489,5 @@ int setup_resources(struct udma_dev *ud)
 	return ch_count;
 }
 
+/* Private interfaces to UDMA */
+#include "k3-udma-private.c"
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 2df0ebe8e7fac..be3dab9fbebba 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2854,5 +2854,3 @@ module_platform_driver(udma_driver);
 MODULE_DESCRIPTION("Texas Instruments UDMA support");
 MODULE_LICENSE("GPL v2");
 
-/* Private interfaces to UDMA */
-#include "k3-udma-private.c"
-- 
2.34.1


