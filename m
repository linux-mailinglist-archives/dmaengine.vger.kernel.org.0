Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4477E201E15
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2020 00:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgFSWiK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Jun 2020 18:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbgFSWiK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 19 Jun 2020 18:38:10 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E760222C3;
        Fri, 19 Jun 2020 22:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592606289;
        bh=IkGutlDUa54YbopeCAD6V4k6oQhpD4RBxx/u05QcjNs=;
        h=Date:From:To:Cc:Subject:From;
        b=g1mg1DLVt/kWT2gcRdaKB47pDvSsGdbZQXP5K5sN01qOgiAV2O41ZIrOtcAzGdZfx
         cmLZvfJQx3pFUBPR/fq19gy/yrpO1Mv2mAVEfg2x7lOvr9v9SlX9142RRpf1i08M8O
         KP/JHTd3SGDLd5y7If4z9dBmaJqbWJU7DiSpsfNI=
Date:   Fri, 19 Jun 2020 17:43:34 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] dmaengine: ti: k3-udma: Use struct_size() in kzalloc()
Message-ID: <20200619224334.GA7857@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/dma/ti/k3-udma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 0d5fb154b8e2..411c54b86ba8 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2209,7 +2209,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
 	u32 ring_id;
 	unsigned int i;
 
-	d = kzalloc(sizeof(*d) + sglen * sizeof(d->hwdesc[0]), GFP_NOWAIT);
+	d = kzalloc(struct_size(d, hwdesc, sglen), GFP_NOWAIT);
 	if (!d)
 		return NULL;
 
@@ -2525,7 +2525,7 @@ udma_prep_dma_cyclic_pkt(struct udma_chan *uc, dma_addr_t buf_addr,
 	if (period_len >= SZ_4M)
 		return NULL;
 
-	d = kzalloc(sizeof(*d) + periods * sizeof(d->hwdesc[0]), GFP_NOWAIT);
+	d = kzalloc(struct_size(d, hwdesc, periods), GFP_NOWAIT);
 	if (!d)
 		return NULL;
 
-- 
2.27.0

