Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C0B15F140
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390800AbgBNSAM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 13:00:12 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.40]:17742 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390784AbgBNSAL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Feb 2020 13:00:11 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 7B4913B32D
        for <dmaengine@vger.kernel.org>; Fri, 14 Feb 2020 11:14:21 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 2eXljU3tKXVkQ2eXljroNJ; Fri, 14 Feb 2020 11:14:21 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k+QU65CHLZoLG7AfwTnQ5YtDbA20JGLnCMfo7U4sik4=; b=OpQNwq3cCqz8SZD6hAvLref+Y6
        lMllw7ioVUPsYynpCRVpJGfyWvhnsmOA+BrGswNXwTMNRi7yD6i0AXXYikW7kjcOIlx5A39W9SSMP
        5Q5VGYluBnUMY5C7vzBaU2Ep6ryr74VmdSO+sQutg4Tlc/ouI/YHh6XAvTXxYmqZBinqu7r5HmVbZ
        iFQM8+f+Qhgj/1HAzMYj8rRSONhIBxAkUJniCHe6TVCNwU1OpEg8p3p5SWuU9bW6SQG3/r9o4KUDO
        cJOKrMw5ZVqS45ItrIgxaucsN8gWZwmimFtkfRR9SKyu+uS3p/gJoAB9HBlKSoStWvHif21BAvKIL
        7zOktwHQ==;
Received: from [200.68.140.137] (port=25415 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j2eXj-003fsi-RY; Fri, 14 Feb 2020 11:14:20 -0600
Date:   Fri, 14 Feb 2020 11:16:57 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] dmaengine: tegra210-adma: Replace zero-length array with
 flexible-array member
Message-ID: <20200214171657.GA25663@embeddedor>
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
X-Exim-ID: 1j2eXj-003fsi-RY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.137]:25415
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
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
 drivers/dma/tegra210-adma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 6e1268552f74..c4ce5dfb149b 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -164,7 +164,7 @@ struct tegra_adma {
 	const struct tegra_adma_chip_data *cdata;
 
 	/* Last member of the structure */
-	struct tegra_adma_chan		channels[0];
+	struct tegra_adma_chan		channels[];
 };
 
 static inline void tdma_write(struct tegra_adma *tdma, u32 reg, u32 val)
-- 
2.25.0

