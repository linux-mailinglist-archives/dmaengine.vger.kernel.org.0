Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61415F144
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 19:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbgBNSAS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 13:00:18 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.40]:26227 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390670AbgBNSAJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Feb 2020 13:00:09 -0500
X-Greylist: delayed 1502 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Feb 2020 13:00:09 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id C0986F43A
        for <dmaengine@vger.kernel.org>; Fri, 14 Feb 2020 11:10:25 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 2eTxjTyZVXVkQ2eTxjrj5J; Fri, 14 Feb 2020 11:10:25 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BuEqONPSEjbS6nR+nsgUPfM1v5+Y+62xNXlUsAnUd/c=; b=H6W/Fiysye58hDJxiiYBMewzcd
        VBQLgnSAN28NP/JizT+q1WA/GLkUQjzDs71ZQcSDWPJUJqAbUNFgGTYDntMRyHou+3dCqT14qCXC1
        PV27mRIl/oku9JMFvMq9eND7VNgLR6LBjVIw/Bse2pmxb84plypHp+xPIw9Ud2kHzlcCKobwbEBAq
        NYTs04MyY8ZSjljzrOCrBd3dMLne3zhsOKcySI0/KQTemQmjT4hT8qBufqJOqJ50JWsU5HhLEIVRr
        KT3SBt059LMfSFeiQEbZWgaHOdC6z8m5x3/Y/to+zL8qH1SXjaYVnEXSlNl4XfRwI1E6NiP+Y+WTa
        fhWfo0oA==;
Received: from [200.68.140.137] (port=41921 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j2eTw-003don-BC; Fri, 14 Feb 2020 11:10:24 -0600
Date:   Fri, 14 Feb 2020 11:13:02 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] dmanegine: ioat/dca: Replace zero-length array with
 flexible-array member
Message-ID: <20200214171302.GA20586@embeddedor>
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
X-Source-IP: 200.68.140.137
X-Source-L: No
X-Exim-ID: 1j2eTw-003don-BC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.137]:41921
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/dma/ioat/dca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/dca.c b/drivers/dma/ioat/dca.c
index be61c32a876f..0be385587c4c 100644
--- a/drivers/dma/ioat/dca.c
+++ b/drivers/dma/ioat/dca.c
@@ -102,7 +102,7 @@ struct ioat_dca_priv {
 	int			 max_requesters;
 	int			 requester_count;
 	u8			 tag_map[IOAT_TAG_MAP_LEN];
-	struct ioat_dca_slot 	 req_slots[0];
+	struct ioat_dca_slot	 req_slots[];
 };
 
 static int ioat_dca_dev_managed(struct dca_provider *dca,
-- 
2.25.0

