Return-Path: <dmaengine+bounces-7256-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1AFC73CD7
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAB5D4E349C
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E42D73B1;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiGb7YZ4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45553FC2;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639159; cv=none; b=b/qz0kcR07XWQwsgBjUOV0igp5SRGhoS5ESecwNx5NVqBkImqy5mxgcbLGaGddBcgpQy9uD1tMH5SjUQo83F6659XRxrW2+tJknqyvjGyckNJKFcZQ2wuCVdC20dRq/VcD+OH/k2Vli99WvCrQjDkF2K28pT6+0IZjENXKGHfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639159; c=relaxed/simple;
	bh=Ts8R/oTlM7BVnWJq+Ornb3LYuucJVmVu/7WaUTZZ2ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR61XLcTjunBMevKgiVSV0BxdV6rzpAYyBj5vQtFenHVBM5Dw03Ng0dQPE9rd78iRzKcyhx3tRqznxnXT3/BD6i8cZ2DoLVhcUM0aX8Pr2yJe9NupBYvmiFniiQyMiddzuyUaPZ4KnYKqtUnQdPK0DL3Ug32akCQ4rq80QPerPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiGb7YZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABADC116B1;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639159;
	bh=Ts8R/oTlM7BVnWJq+Ornb3LYuucJVmVu/7WaUTZZ2ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eiGb7YZ4Zg7MPipmK/+0bZAIc0yICKj07Qq0rl2TWmxXmQiDt69frxHmLpM51hRbl
	 VoCkL8qydKcdyCDz0042NLzWumY1wjMRMQUFzlzPrjhphxTchlDHGyD5CnTLORyD3c
	 K4n3xfMc/JD5xFiQFdItaHKXj+hlzIhMhsfg9ovkGzALkjMc+hMzae9re/ewzJH33Q
	 JZ6BE4y43H42rjof/9paYHRYF7L7+N/E1TrpTaL8AVJdmRzfSDERSzCvhncCiW+1W7
	 dN65cJAvYdCd2z1iBcGhN89xwTR5maaDi9UXurUhrGS3BH0wlMoEecbmACwxmgAf58
	 5G0GrUS5q7PAQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM36t-000000002Cy-221r;
	Thu, 20 Nov 2025 12:45:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/9] dmaengine: dw: drop unused module alias
Date: Thu, 20 Nov 2025 12:45:17 +0100
Message-ID: <20251120114524.8431-3-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120114524.8431-1-johan@kernel.org>
References: <20251120114524.8431-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver does not support anything but OF and ACPI probe since commit
b3757413b91e ("dmaengine: dw: platform: Use struct dw_dma_chip_pdata")
so drop the unused platform module alias along with the now unnecessary
driver name define.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/dw/platform.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index cee56cd31a61..c63fa52036d7 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -21,8 +21,6 @@
 
 #include "internal.h"
 
-#define DRV_NAME	"dw_dmac"
-
 static int dw_probe(struct platform_device *pdev)
 {
 	const struct dw_dma_chip_pdata *match;
@@ -190,7 +188,7 @@ static struct platform_driver dw_driver = {
 	.remove		= dw_remove,
 	.shutdown       = dw_shutdown,
 	.driver = {
-		.name	= DRV_NAME,
+		.name	= "dw_dmac",
 		.pm	= pm_sleep_ptr(&dw_dev_pm_ops),
 		.of_match_table = of_match_ptr(dw_dma_of_id_table),
 		.acpi_match_table = ACPI_PTR(dw_dma_acpi_id_table),
@@ -211,4 +209,3 @@ module_exit(dw_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare DMA Controller platform driver");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.51.2


