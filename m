Return-Path: <dmaengine+bounces-7222-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E85AC65100
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7C28328D26
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40922D1936;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Illrwbrl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80A2D0635;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=bn3JFAPlbKVnvYR5aSj19k4h50vz8xQ7i2T5ZqJWm0z+I1Kr8ogW0hVHH0QpsdstmPzkf2pQBzwX/KsxSXkBtLfGN4kuOrm+8/sDvDeEeaz1kjsZgF6ZECKz1tZhaxSoPcx6SMbQYzXT/3wYU/1MGfd9lahF5fMGVmyomnHGKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=y1FuJEfKwFBT32YZR2KFCDOM008BUzx/mEb1XlP/nHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3Q7TnbN8omxHEswwQdbDlsvnjld2Ubia1pEuk5g15+R9AOej0QHzKvWkwhe05nfn6Dwk12NpM2bh3EP8FtYUNEAs2J4peUTrmAGIK4sW+N+rGnpPMDg2DxmLAd1T2UuHqKjrAZoIFUAyi89ioP79F9NvDv+gDJp+du+dzK7d90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Illrwbrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587B6C113D0;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396005;
	bh=y1FuJEfKwFBT32YZR2KFCDOM008BUzx/mEb1XlP/nHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IllrwbrlnAm0LHbftszwREVu7ZXeuhaUjd7+ExOS6LEv+uvmOTVV4VBJKp6p316GN
	 xkFyfCnVhKS12yldSvGW7xRJWlZtQfslEvCTznIVbDUbmXLUJO2lieGTXh4aGl104c
	 nwqGg4gGelojAcMqAIt3PEgThvvTN/fXLXJBc+utIRay+giDePUxJiufjVuwBWbGm0
	 BW2o/7h9ROulkqWltRONK9HqNMIzxShd9zoIbUnsHrjHDhwEkXkmIdshs4IfsJYeiC
	 sy0pOlQq3i/ARVSGp5Oas66mxaLmF07o2e8V11Q7rBOoEIlhEHjbBqStishFiAkDGL
	 eXltv9jurugcg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r1-000000002oB-1h9L;
	Mon, 17 Nov 2025 17:13:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH 12/15] dmaengine: ti: dma-crossbar: fix device leak on dra7x route allocation
Date: Mon, 17 Nov 2025 17:12:55 +0100
Message-ID: <20251117161258.10679-14-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117161258.10679-1-johan@kernel.org>
References: <20251117161258.10679-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the crossbar
platform device during dra7x route allocation.

Note that commit 615a4bfc426e ("dmaengine: ti: Add missing put_device in
ti_dra7_xbar_route_allocate") fixed the leak in the error paths but the
reference is still leaking on successful allocation.

Fixes: a074ae38f859 ("dmaengine: Add driver for TI DMA crossbar on DRA7x")
Fixes: 615a4bfc426e ("dmaengine: ti: Add missing put_device in ti_dra7_xbar_route_allocate")
Cc: stable@vger.kernel.org	# 4.2: 615a4bfc426e
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/ti/dma-crossbar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index 7f17ee87a6dc..e52b0e139900 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -288,6 +288,8 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 
 	ti_dra7_xbar_write(xbar->iomem, map->xbar_out, map->xbar_in);
 
+	put_device(&pdev->dev);
+
 	return map;
 }
 
-- 
2.51.0


