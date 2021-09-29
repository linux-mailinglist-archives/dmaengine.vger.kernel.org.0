Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C75941CF35
	for <lists+dmaengine@lfdr.de>; Thu, 30 Sep 2021 00:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347229AbhI2W07 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Sep 2021 18:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346527AbhI2W07 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 Sep 2021 18:26:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5633361425;
        Wed, 29 Sep 2021 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632954318;
        bh=gCBBC7JLGcZQaPz+Vpq0Pd8Hio930/7xgACvcEd+XUY=;
        h=Date:From:To:Cc:Subject:From;
        b=VQjSOMwzO2qj85XL58H9btVmTAisQxj9svagsvJ6Fs1umbMjHiELrKopvMjhlXg2t
         EAP0K+SlqqlNQ+pNDOw8GXjcAkF/wP/n31E5BRUhe82OBzspT6S7YBIzxJY79iu0/I
         jB8TWO2wVwhzXWNfWEdC2mznHwmsOI86fGjBusdQ2f6lvOpBHCI9xfrPQVLLh+5xqo
         GclWImlBNL0OMGqYw8Lk62q+IF6kHK+E70AgPj9Sx1alMFoOmilsKP8nr9OLwSkg5P
         hFxaUdEEYJiYFgNWjs4cDvbXUaPAwMfnUmfwJ2VLI7WxAzerck07FJkbcC6bpzksmL
         OTg52+ALhspWw==
Date:   Wed, 29 Sep 2021 17:29:22 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] dmaengine: stm32-mdma: Use struct_size() helper in
 devm_kzalloc()
Message-ID: <20210929222922.GA357509@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worse scenario, could lead to heap overflows.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/dma/stm32-mdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 18cbd1e43c2e..d30a4a28d3bf 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1566,7 +1566,8 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	if (count < 0)
 		count = 0;
 
-	dmadev = devm_kzalloc(&pdev->dev, sizeof(*dmadev) + sizeof(u32) * count,
+	dmadev = devm_kzalloc(&pdev->dev,
+			      struct_size(dmadev, ahb_addr_masks, count),
 			      GFP_KERNEL);
 	if (!dmadev)
 		return -ENOMEM;
-- 
2.27.0

