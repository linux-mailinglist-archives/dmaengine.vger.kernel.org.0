Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04822875C8
	for <lists+dmaengine@lfdr.de>; Thu,  8 Oct 2020 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgJHONG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Oct 2020 10:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbgJHONG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Oct 2020 10:13:06 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30BBA2184D;
        Thu,  8 Oct 2020 14:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602166386;
        bh=e0ZQM+Ar9LOvI9qr/oHYiy++btwM0sanj3jZG/rwbsk=;
        h=Date:From:To:Cc:Subject:From;
        b=ODufod8AH/BivMloVNIOsQqHnGGVsOH3MwrcEgg1CL+vXAWc9c6CwyC1lprhLmuBT
         EJq/eW1IDEDrMC3EM04IuUjZZbs5HjbvtmG+iYxOakEoCjP4mmyZS8x+jCoPDlhCCB
         uIur4ziwt7I9cfzp8Nq2IUFpJ3u2X4djtQDCtLXU=
Date:   Thu, 8 Oct 2020 09:18:28 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] dmaengine: stm32-mdma: Use struct_size() in kzalloc()
Message-ID: <20201008141828.GA20325@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Make use of the new struct_size() helper instead of the offsetof() idiom.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/dma/stm32-mdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 08cfbfab837b..29e5e30524bb 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -339,7 +339,7 @@ static struct stm32_mdma_desc *stm32_mdma_alloc_desc(
 	struct stm32_mdma_desc *desc;
 	int i;
 
-	desc = kzalloc(offsetof(typeof(*desc), node[count]), GFP_NOWAIT);
+	desc = kzalloc(struct_size(desc, node, count), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-- 
2.27.0

