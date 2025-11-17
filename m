Return-Path: <dmaengine+bounces-7214-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A208EC650F1
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B939A28A12
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0F62D060D;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtWPys9u"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A472C237C;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=mRWXyCBND+gqkTs5FuPaCy0y37ro3c8ZaH+sZxq+K4liXsIYTwhkPPyzGBNBCAnyoeWoz1Zbk6HMC/oQjxnrT6tWY4oJwXeLDR23hyYbExTWBfVpZfmkDBDJE1w4MLtnRAGE3OP25o9MLUG0C/rqC2Um9/9BUimqXuEJOH05rZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=+gtV5rGLMOFmbBmErF+iAc9MrKb8OqQyobykzk6xYrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzFsBjGkWBjDI7QTmELi/3giME20jjyJZRRILCtwt6y5F2tqDUEnRlOp3VTz8wy3FulDfbkY0OwylEuyq/DMCmyLBCQfbVQJQwgBdnAAkPiwAfeqkui/FePHounlv6MKp7ryfR91uZ5C4HMpyO+smjads9dzKLHN6E2wC53XHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtWPys9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F052CC2BCB6;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396005;
	bh=+gtV5rGLMOFmbBmErF+iAc9MrKb8OqQyobykzk6xYrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtWPys9u5/RHjAa0zDWNmAErSem3vWH2P2aGvlP1X3AaddCUPcbWVS1lGZr3qfj9X
	 Trrj0Vd5Cj0YOieXIBj5SJTkLObFlOflcF16wp9Yixszgydx86RfAYfhEQf0zUfB7R
	 hSxxI3Gzbvusoucfw/VeFE7x/qSuw+AuAsWAyW96kOlq/UzCDbYG9Yv7+qwvSURBFV
	 bX6PKhyiEjCNadMqH4Om8Lz61ME0XIQAX+hOuYqtVi1riP2HJmPB+NYbEZlMnfWcK3
	 OOIhFJL+80MhuM6+3+oXAYhpxm66oWen6g2YEtZya9377PJl9ZFLnzHggbruCqS9In
	 6A+JzeVw5Vofg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r1-000000002o0-08t5;
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
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 08/15] dmaengine: sh: rz-dmac: fix device leak on probe failure
Date: Mon, 17 Nov 2025 17:12:51 +0100
Message-ID: <20251117161258.10679-10-johan@kernel.org>
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

Make sure to drop the reference taken when looking up the ICU device
during probe also on probe failures (e.g. probe deferral).

Fixes: 7de873201c44 ("dmaengine: sh: rz-dmac: Add RZ/V2H(P) support")
Cc: stable@vger.kernel.org	# 6.16
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/sh/rz-dmac.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 1f687b08d6b8..38137e8d80b9 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -854,6 +854,13 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	return 0;
 }
 
+static void rz_dmac_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
 {
 	struct device_node *np = dev->of_node;
@@ -876,6 +883,10 @@ static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
 		return -ENODEV;
 	}
 
+	ret = devm_add_action_or_reset(dev, rz_dmac_put_device, &dmac->icu.pdev->dev);
+	if (ret)
+		return ret;
+
 	dmac_index = args.args[0];
 	if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
 		dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
@@ -1055,8 +1066,6 @@ static void rz_dmac_remove(struct platform_device *pdev)
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	platform_device_put(dmac->icu.pdev);
 }
 
 static const struct of_device_id of_rz_dmac_match[] = {
-- 
2.51.0


