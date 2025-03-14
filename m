Return-Path: <dmaengine+bounces-4746-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E6CA61305
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 14:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2F63AA145
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ADF12FF6F;
	Fri, 14 Mar 2025 13:49:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mxout37.expurgate.net (mxout37.expurgate.net [91.198.224.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE12E336A;
	Fri, 14 Mar 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960188; cv=none; b=OTfNjgYW4k4gtUvAqpZrnuP3WUMC82yJS3ZBu9xYZA1fyqqmnZZ230ACQRBBNJyI40P1JnArsX9PiAPihNU21JUyrfPzdb+V8dW2myojhlZYvMDDsJ+XebMuFJVOo6aL/rIuqPJL4NynaW7elgHNHYtdV70PSvzlkVnkHvMgWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960188; c=relaxed/simple;
	bh=8/wDlzcd0n2jUA0q1fG4qnvCLt5vwQ2AQX60N3ExUgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhDwmhKbqdaaokM8WjzDiYfA15PLrM2IyeEQusOj57hpiTYh8Mu8EHd4CAGnNXXJphUwpAfxnZ5eycL9sn/HGf9lhQEjFwk+mjruh60bLpC8rF9eChhsBxSoZv9uVr61CRxmXVNwQH1hEh9A44eaSHoJxp4tgiqE0ITlL/pkPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de; spf=pass smtp.mailfrom=brueckmann-gmbh.de; arc=none smtp.client-ip=91.198.224.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brueckmann-gmbh.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1tt5Pu-005k7L-HR; Fri, 14 Mar 2025 14:49:38 +0100
Received: from [217.239.223.202] (helo=zimbra.brueckmann-gmbh.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1tt5Pt-003chE-Oy; Fri, 14 Mar 2025 14:49:37 +0100
Received: from zimbra.brueckmann-gmbh.de (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPS id 9E367CAF097;
	Fri, 14 Mar 2025 14:49:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTP id 9C677CAF053;
	Fri, 14 Mar 2025 14:49:36 +0100 (CET)
Received: from zimbra.brueckmann-gmbh.de ([127.0.0.1])
 by localhost (zimbra.brueckmann-gmbh.de [127.0.0.1]) (amavis, port 10026)
 with ESMTP id WRq9PIR4BSAX; Fri, 14 Mar 2025 14:49:36 +0100 (CET)
Received: from ew-linux.ew (unknown [10.0.11.14])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPSA id 872CBCAEFB5;
	Fri, 14 Mar 2025 14:49:36 +0100 (CET)
From: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
To: dmaengine@vger.kernel.org
Cc: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Marek Vasut <marex@denx.de>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
Date: Fri, 14 Mar 2025 14:48:47 +0100
Message-ID: <20250314134849.703819-1-thomas.gessler@brueckmann-gmbh.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1741960178-6A6E29C1-AE591C42/0/0

Coalesce the direction bits from the enabled TX and/or RX channels into
the directions bit mask of dma_device. Without this mask set,
dma_get_slave_caps() in the DMAEngine fails, which prevents the driver
from being used with an IIO DMAEngine buffer.

Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
---
 drivers/dma/xilinx/xilinx_dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
index 108a7287f4cd..641aaf0c0f1c 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3205,6 +3205,10 @@ static int xilinx_dma_probe(struct platform_device=
 *pdev)
 		}
 	}
=20
+	for (i =3D 0; i < xdev->dma_config->max_channels; i++)
+		if (xdev->chan[i])
+			xdev->common.directions |=3D xdev->chan[i]->direction;
+
 	if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_VDMA) {
 		for (i =3D 0; i < xdev->dma_config->max_channels; i++)
 			if (xdev->chan[i])
--=20
2.43.0


