Return-Path: <dmaengine+bounces-4747-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED7AA61314
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 14:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DACF1883000
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDA21F1818;
	Fri, 14 Mar 2025 13:53:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mxout37.expurgate.net (mxout37.expurgate.net [91.198.224.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6D1DFD9A;
	Fri, 14 Mar 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960423; cv=none; b=r1mmrvmLRoGuursGAJwsSGSd+yBJEp7E38s7A2XUhwmo71jwo+rpbuH/H+JKQiY+ZDvsqtFST1H+GvccNpD1S/md2SnRRi+QPtCc44trsYn6r5X8zZs3fJVY+n8i9rvv+vmED4TmlrtvGFWjsnFzXl5Kuc/BWLw3gg2cTUtHhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960423; c=relaxed/simple;
	bh=QIqZq36mZ1fXNil9RPKcst3POABFpIjHwANElr2HuQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uN11CWPhqfSn6diYlbQ8L5qSyV0UfxaoVac1FegrNxeKcj6JtcHjkdql/JPCmp+SPoLwgiz3CpdVN6tqooACqA+Rl7XIcboRD7FxH/n/8A1olCD1yr3gpY555qlL61ln3Ajti8VSihyyusxMmfJC9fRamDSfunYTGyX7E25nTG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de; spf=pass smtp.mailfrom=brueckmann-gmbh.de; arc=none smtp.client-ip=91.198.224.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brueckmann-gmbh.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1tt5Nu-003bqT-Vn; Fri, 14 Mar 2025 14:47:35 +0100
Received: from [217.239.223.202] (helo=zimbra.brueckmann-gmbh.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1tt5Nt-003e41-4V; Fri, 14 Mar 2025 14:47:33 +0100
Received: from zimbra.brueckmann-gmbh.de (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPS id E9E4FCAF156;
	Fri, 14 Mar 2025 14:47:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTP id E5E97CAF150;
	Fri, 14 Mar 2025 14:47:31 +0100 (CET)
Received: from zimbra.brueckmann-gmbh.de ([127.0.0.1])
 by localhost (zimbra.brueckmann-gmbh.de [127.0.0.1]) (amavis, port 10026)
 with ESMTP id EnYx8uQXloXr; Fri, 14 Mar 2025 14:47:31 +0100 (CET)
Received: from ew-linux.ew (unknown [10.0.11.14])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPSA id CE686CAF131;
	Fri, 14 Mar 2025 14:47:31 +0100 (CET)
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
Subject: [PATCH] dmaengine: xilinx_dma: Set max segment size
Date: Fri, 14 Mar 2025 14:47:15 +0100
Message-ID: <20250314134717.703287-1-thomas.gessler@brueckmann-gmbh.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1741960053-ADFAB3DC-1FE738A5/0/0
X-purgate-type: clean
X-purgate: clean

Set the maximumg DMA segment size from the actual core configuration
value. Without this setting, the default value of 64 KiB is reported,
and larger sizes cannot be used for IIO DMAEngine buffers.

Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
index 108a7287f4cd..4b4a299e3807 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3114,6 +3114,8 @@ static int xilinx_dma_probe(struct platform_device =
*pdev)
 		}
 	}
=20
+	dma_set_max_seg_size(xdev->dev, xdev->max_buffer_len);
+
 	if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIDMA) {
 		xdev->has_axistream_connected =3D
 			of_property_read_bool(node, "xlnx,axistream-connected");
--=20
2.43.0


