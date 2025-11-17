Return-Path: <dmaengine+bounces-7225-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD943C6510F
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4D98328E57
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFBD2D3750;
	Mon, 17 Nov 2025 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT6H2mov"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00682D23A8;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=bkcBosAnOgNnQnGQz2cKJ/dXnq5fBXP5lGJk0FHCkvItO2nuA59A1IQgaSlUQElouqakmDQo8VgoRnNoHZzWEmZmjsNMbVgG4w41wIGlkHkvewX8xzxeChw1jCdapiH2Oj1iGgj9JwY41RjVCWFb4EWcbawuzqgcswR+h364x90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=AriYcLx5dNNAKOVwHc1ayU8f+JVccX083sw071ekSEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mgt3JC0vFubetvQeYkFx9A9wNl5t8y+mJHEQPTqAgD7hf0H7QHMdocy2eyGTEudlyuoyMP1R0aGIrrxdc5obuaqqv9MD/uopaU7+rkeFnOSiWJQosoqyvAEKiaZAbrmA5BxBYmTsys8u5l3RN+xX7lW/pvMu818QmrmORGXlc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT6H2mov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8124C113D0;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396005;
	bh=AriYcLx5dNNAKOVwHc1ayU8f+JVccX083sw071ekSEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hT6H2movz5qHJg2r8TLZbGJPKAspN17fCMGqom/NOeHDqZQorPt5+xC/YkT8nFd3h
	 5gYnBZSFzwqcY6T85m4VftThKWO8u7QHGlCOYaqeNdSpwwoiJD/OMW0rFIW72kIpGd
	 X9crdyURpHP4njoxgz3B3TeEVZL1rpfiM7SGJ4qfWQUwDA40RKT6uKmRsKy9Pg1/xP
	 X6APTdwxfX/7/tRTi7NHfzLlx9/uvnJ0kRt16HulH1Y4hGeccRDLQdwURDrUp+/oFn
	 C0uGnuN1dbM2zCq3hNgnDAmBk3zteaJ4WtXkVLY74j4kD5W+qRD4jpdabaRKldpGWY
	 Lu+Hx0b/iDG7w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r1-000000002oL-2qg0;
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
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 15/15] dmaengine: ti: k3-udma: fix device leak on udma lookup
Date: Mon, 17 Nov 2025 17:12:58 +0100
Message-ID: <20251117161258.10679-17-johan@kernel.org>
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

Make sure to drop the reference taken when looking up the UDMA platform
device.

Note that holding a reference to a platform device does not prevent its
driver data from going away so there is no point in keeping the
reference after the lookup helper returns.

Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
Fixes: 1438cde8fe9c ("dmaengine: ti: k3-udma: add missing put_device() call in of_xudma_dev_get()")
Cc: stable@vger.kernel.org	# 5.6: 1438cde8fe9c
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/ti/k3-udma-private.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 05228bf00033..624360423ef1 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -42,9 +42,9 @@ struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property)
 	}
 
 	ud = platform_get_drvdata(pdev);
+	put_device(&pdev->dev);
 	if (!ud) {
 		pr_debug("UDMA has not been probed\n");
-		put_device(&pdev->dev);
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-- 
2.51.0


