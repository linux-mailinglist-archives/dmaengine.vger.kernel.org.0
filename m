Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22F746C871
	for <lists+dmaengine@lfdr.de>; Wed,  8 Dec 2021 01:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242703AbhLHAIS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 19:08:18 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46270 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242690AbhLHAIR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 19:08:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 57E19CE1ECA;
        Wed,  8 Dec 2021 00:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029FDC341C5;
        Wed,  8 Dec 2021 00:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638921883;
        bh=HVrBSNB36jTypNFFUkXDJkWXugeWW3Ecpo4AdjI1ygY=;
        h=Date:From:To:Cc:Subject:From;
        b=ZQQ6iAWGMymuF120zo9dKdNCNl6eiU0cit85AlJYyJtoyas5S2UxPHX3o0cwT+hbB
         6yZQWUwsq76lATHtSVWBBzKLe5DlV3CIm0UHUJ2LgtEPbbWIxB4Hy3WLd4uxZP3G9n
         J7oyyuFhuBhr/ng8e8+XaCRwGymOuT6GAg4NYmVEBmfTtuysf7jhzYEQVLoVovcocd
         oRKJJesq8Jds5eAAeAdR+mwpQZN1YS+tDeLsogONg62v3noNXxvs/caRH2BHv6f2k1
         7+T1bWmkbpJw/tnftpXDI2PiGYAYTHAbBoZd8NbUJGqi+8qTo7lvPEmX1CCg58kHgB
         8BLzHqHVtZGeA==
Date:   Tue, 7 Dec 2021 18:10:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] dmaengine: at_xdmac: Use struct_size() in
 devm_kzalloc()
Message-ID: <20211208001013.GA62330@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version, in
order to avoid any potential type mistakes or integer overflows that, in
the worst scenario, could lead to heap overflows.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/dma/at_xdmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 275a76f188ae..e42dede5b243 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2031,7 +2031,7 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 static int at_xdmac_probe(struct platform_device *pdev)
 {
 	struct at_xdmac	*atxdmac;
-	int		irq, size, nr_channels, i, ret;
+	int		irq, nr_channels, i, ret;
 	void __iomem	*base;
 	u32		reg;
 
@@ -2056,9 +2056,9 @@ static int at_xdmac_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	size = sizeof(*atxdmac);
-	size += nr_channels * sizeof(struct at_xdmac_chan);
-	atxdmac = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	atxdmac = devm_kzalloc(&pdev->dev,
+			       struct_size(atxdmac, chan, nr_channels),
+			       GFP_KERNEL);
 	if (!atxdmac) {
 		dev_err(&pdev->dev, "can't allocate at_xdmac structure\n");
 		return -ENOMEM;
-- 
2.27.0

