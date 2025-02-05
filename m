Return-Path: <dmaengine+bounces-4297-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5222EA28BED
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 14:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6E53A8FFE
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D09136358;
	Wed,  5 Feb 2025 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b="x4wfEhLH"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.hc1631-21.eu.iphmx.com (esa.hc1631-21.eu.iphmx.com [23.90.122.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F412EBEA;
	Wed,  5 Feb 2025 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.122.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762786; cv=none; b=KNMJ9BOSAGW1m+qUiMHOB215RtZ3VgsCXDTqbtK4WcH1AKSwVYTR9n3BHgwLZmAdjHIQOfMQOdO7zRytGcT2l2rqCkXvd0FZ+icdPvJ6SH+SkRj54A0WIbp9qEbFtjaRA9CTJeZOo462I0W3j9uqrvNaRtnA5/C0E4LIbUa6ks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762786; c=relaxed/simple;
	bh=xx1KM5z16al4ID4kukkEVWnUudNZ1JhFx2Qas0+7Tog=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WLG6LmxWeIDgLQJGrIZLUTZ62rVo6ejjlisBKVWXoi8OJBD0lt8Ki3qH8S7e1LMQfeIC0u57E4cbbSh70nz/SiFp8wFDFRxFOz6O/RoYeSIxM/20uXtt9HMneBESz2vMsoJ26PkG66sQMPej8s63I0HMPkp2Z0ha9PU5pb0RKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com; spf=pass smtp.mailfrom=thalesgroup.com; dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b=x4wfEhLH; arc=none smtp.client-ip=23.90.122.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalesgroup.com
X-CSE-ConnectionGUID: 1q7d95LtS1q7Mc6NC2Q4mg==
X-CSE-MsgGUID: GZZoiLI/RRSL35n8i8jpaw==
Authentication-Results: ob1.hc1631-21.eu.iphmx.com; dkim=pass (signature verified) header.i=@thalesgroup.com
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="25679662"
X-IronPort-AV: E=Sophos;i="6.13,221,1732575600"; 
   d="scan'208";a="25679662"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=thalesgroup.com; i=@thalesgroup.com; s=bbmfo20230504;
  t=1738762714;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=hXK05cqlZ9cZyN/m6/nx739KmMO7Ld02nRkYNkBU9lI=;
  b=x4wfEhLHG41h81z88Ca4M8m62sTUHY3EbdCkT9R3XJCIvZtBzVMS0sYV
   X5pDntB0xKKHghSpmn1tWDOLMJwmHimABGF6dJZeF/zAl85PV8c9eqVqO
   tuW0FdxjuREerPYeG+mGiAMfqaVd2xSSI62z1zrvcbLhRv/Aa645en0LW
   /tlHWQ31djRGULlORIy7TdVjaIm6kW0Z1mlGn3nlXHwnTRujC9dEqkvlD
   etuE4aRaDNEHOQ7qfY0TdpvHA4v392fnSZvlcgjPZSD5widm90AxL2Pgo
   6NNWRURMPg5hPHc3gxo3zBaBXxHnI+yXYlQL74Vzxk3yCbeeRPXqy5X0m
   Q==;
X-CSE-ConnectionGUID: kw5DrnbaR8yn4ohGetljXg==
X-CSE-MsgGUID: TnlGGTSYSDmj+ZdKcrVJcQ==
X-CSE-ConnectionGUID: DIdceQhtReSMJDZ67/xDGg==
X-CSE-MsgGUID: HzWhxkqNQpKfvAi7Bx5W5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="40762103"
X-IronPort-AV: E=Sophos;i="6.13,261,1732575600"; 
   d="scan'208";a="40762103"
From: LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "LENAIN
 Simon" <simon.lenain@thalesgroup.com>, LEJEUNE Sebastien
	<sebastien.lejeune@thalesgroup.com>, BARBEAU Etienne
	<etienne.barbeau@thalesgroup.com>, RENAULT Xavier
	<xavier.renault@thalesgroup.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: optional reset support
Thread-Topic: [PATCH] dmaengine: dw-axi-dmac: optional reset support
Thread-Index: Adt3z3Y2yWnkRdAqTHGNYv7obAEStw==
Date: Wed, 5 Feb 2025 13:38:32 +0000
Message-ID: <bf8f02ced6604f80acb84e82ea3a9268@thalesgroup.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-endpointsecurity-0xde81-ev: v:7.9.19.477, d:out, a:y, w:t, t:21,
 sv:1738730589, ts:1738762712
x-ms-exchange-nodisclaimer: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Use optional reset support to avoid having to add a new entry to dw_dma_of_=
id_table for each target requiring reset support

Signed-off-by: Philippe Lecointre <philippe.lecointre@thalesgroup.com>
Acked-by: Simon Lenain <simon.lenain@thalesgroup.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/d=
w-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..186bfb35b9eb 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -48,8 +48,7 @@
 	DMA_SLAVE_BUSWIDTH_64_BYTES)
=20
 #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
-#define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
-#define AXI_DMA_FLAG_USE_CFG2		BIT(2)
+#define AXI_DMA_FLAG_USE_CFG2		BIT(1)
=20
 static inline void
 axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
@@ -1498,15 +1497,13 @@ static int dw_probe(struct platform_device *pdev)
 			return PTR_ERR(chip->apb_regs);
 	}
=20
-	if (flags & AXI_DMA_FLAG_HAS_RESETS) {
-		resets =3D devm_reset_control_array_get_exclusive(&pdev->dev);
-		if (IS_ERR(resets))
-			return PTR_ERR(resets);
+	resets =3D devm_reset_control_array_get_optional_exclusive(&pdev->dev);
+	if (IS_ERR(resets))
+		return PTR_ERR(resets);
=20
-		ret =3D reset_control_deassert(resets);
-		if (ret)
-			return ret;
-	}
+	ret =3D reset_control_deassert(resets);
+	if (ret)
+		return ret;
=20
 	chip->dw->hdata->use_cfg2 =3D !!(flags & AXI_DMA_FLAG_USE_CFG2);
=20
@@ -1665,10 +1662,9 @@ static const struct of_device_id dw_dma_of_id_table[=
] =3D {
 		.data =3D (void *)AXI_DMA_FLAG_HAS_APB_REGS,
 	}, {
 		.compatible =3D "starfive,jh7110-axi-dma",
-		.data =3D (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
+		.data =3D (void *)AXI_DMA_FLAG_USE_CFG2,
 	}, {
 		.compatible =3D "starfive,jh8100-axi-dma",
-		.data =3D (void *)AXI_DMA_FLAG_HAS_RESETS,
 	},
 	{}
 };
--=20
2.44.1

