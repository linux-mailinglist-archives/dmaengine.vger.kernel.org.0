Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2146A09CD
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2019 20:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfH1SlW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Aug 2019 14:41:22 -0400
Received: from gateway36.websitewelcome.com ([50.116.125.2]:45077 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbfH1SlV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Aug 2019 14:41:21 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id A13784015E147
        for <dmaengine@vger.kernel.org>; Wed, 28 Aug 2019 13:07:13 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 32siir2LH4FKp32siivI06; Wed, 28 Aug 2019 13:41:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9ehTI29T7w72VnCiJ4pfIoIouCCdrHpXCFm9DHTh2s4=; b=mkNi/cNFtVf0MNWH51wJwoX8Hr
        mG2NK2idTEeFuEztzH2/JpZCo+lbmV5TBhJObknptd996kFtTFqdi6jvKTF8c9ZQdEe0K1JOX6gdK
        mUr7ntIJPc+6Rhw8APEkbLysjJi/8ik4So+gakMQe6jt5CJUtAO97yG/HaxBL1nvKprmXSSPBWuzU
        5pGO13cmmziszdg0R5mYt3ayJGalON46VY8iPTpRi104JOaEdXznNW+GvggkXAym4t4j/4XOyCRpm
        CpMHI0ytgqa1FE4eJCVygP+Nr7/ll7+51OmVY/HLzQO9j8VxYfsKKMTpPQFHCS4rvzwRtjIMEmQCq
        dAne+x5w==;
Received: from [189.152.216.116] (port=43062 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i32rf-004L4p-TI; Wed, 28 Aug 2019 13:40:15 -0500
Date:   Wed, 28 Aug 2019 13:40:15 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ioat/dca: Use struct_size() helper
Message-ID: <20190828184015.GA4273@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.216.116
X-Source-L: No
X-Exim-ID: 1i32rf-004L4p-TI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:43062
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 32
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct ioat_dca_priv {
	...
        struct ioat_dca_slot     req_slots[0];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(*ioatdca) + (sizeof(struct ioat_dca_slot) * slots)

with:

struct_size(ioatdca, req_slots, slots)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/dma/ioat/dca.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/ioat/dca.c b/drivers/dma/ioat/dca.c
index 70fd8454d002..be61c32a876f 100644
--- a/drivers/dma/ioat/dca.c
+++ b/drivers/dma/ioat/dca.c
@@ -286,8 +286,7 @@ struct dca_provider *ioat_dca_init(struct pci_dev *pdev, void __iomem *iobase)
 		return NULL;
 
 	dca = alloc_dca_provider(&ioat_dca_ops,
-				 sizeof(*ioatdca)
-				      + (sizeof(struct ioat_dca_slot) * slots));
+				 struct_size(ioatdca, req_slots, slots));
 	if (!dca)
 		return NULL;
 
-- 
2.23.0

