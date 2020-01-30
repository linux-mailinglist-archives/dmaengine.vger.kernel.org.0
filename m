Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D1014D6F1
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 08:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgA3HIw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 02:08:52 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52020 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgA3HIw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 02:08:52 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130070850euoutp01fb98ed88f841ddefc0e9cb81699c7533~umHEOi40g0692706927euoutp01E
        for <dmaengine@vger.kernel.org>; Thu, 30 Jan 2020 07:08:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130070850euoutp01fb98ed88f841ddefc0e9cb81699c7533~umHEOi40g0692706927euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580368130;
        bh=Pztbs1SooUHpR9Ka324ZsDUVPuCK37S2FVX9ZA3EIgM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=c9fhm0Qkpwsfp1AFFssAiEOoUQgabAy1hlJmwXiQUSUCKx3KB4ikVef7u6Rn0Fy7M
         Gcq9InmmIMaPafwow9ocvV39uE5ANKIAc1xbJLcByZ5a+rY9WB4Mqktf+fpdlug86k
         VdHl0274+dtp7SKlMwwyVibdUfnefylbL+fnaHSU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130070850eucas1p1de25dae51dab0db0f8a0c68b266f8238~umHD9kdVE0857108571eucas1p1U;
        Thu, 30 Jan 2020 07:08:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 43.66.61286.201823E5; Thu, 30
        Jan 2020 07:08:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130070850eucas1p1a7a09e2bec2f6fe652f206b61a8a04ae~umHDtadOd0078500785eucas1p1K;
        Thu, 30 Jan 2020 07:08:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130070850eusmtrp18991581ad7f07aeaa6bc511e491ba8c4~umHDssTEz2633426334eusmtrp1Q;
        Thu, 30 Jan 2020 07:08:50 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-51-5e32810237c6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.EE.08375.101823E5; Thu, 30
        Jan 2020 07:08:49 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130070849eusmtip14c0ca2e951d10105d9999a650bea69da~umHDKiW7p3268232682eusmtip1O;
        Thu, 30 Jan 2020 07:08:49 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] dmaengine: Fix return value for dma_requrest_chan() in
 case of failure
Date:   Thu, 30 Jan 2020 08:08:34 +0100
Message-Id: <20200130070834.17537-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduznOV2mRqM4g6+bBSyuXDzEZLFxxnpW
        i6kPn7BZrJ76l9Vi7uxJjBbnz29gt7i8aw6bxYzz+5gs1h65y24x6+MPVoudd04wO3B7bPjc
        xOYx8ayux6ZVnWwefVtWMXocv7GdyePzJrkAtigum5TUnMyy1CJ9uwSujB/vLjIVbOOomNi9
        ibmBsYW9i5GTQ0LARGLtiXtMILaQwApGif0TdLsYuYDsL4wSl6YfYYdwPjNKPNu5jrWLkQOs
        o/kTVNFyRon2ddeZ4Dr+Le1nBhnFJmAo0fW2iw3EFhGolVjVsYsZpIhZYBWTxImpU1lAJgkL
        xEgsPuUFYrIIqEqcOmYPUs4rYCvx+/5WNojr5CVWbzjADGF/Z5Po2x0EYbtIzDnSC/WBsMSr
        41ugbBmJ05N7WEBWSQg0M0o8PLeWHcLpYZS43DSDEaLKWuLOuV9sIIuZBTQl1u/Shwg7Srxe
        NIUF4kk+iRtvBUHCzEDmpG3TmSHCvBIdbUIQ1WoSs46vg1t78MIlqDM9JOYfWMYCCdBYiTkX
        N7BOYJSbhbBrASPjKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMC0cfrf8U87GL9eSjrE
        KMDBqMTDK1FmGCfEmlhWXJl7iFGCg1lJhFfUFSjEm5JYWZValB9fVJqTWnyIUZqDRUmc13jR
        y1ghgfTEktTs1NSC1CKYLBMHp1QDY3NpVris6VqGI+9NNJaYfsmpyfu5vXFLk4Gem8nV83KL
        b6RYBbaG/23YoPuoTto4UvlaysLy8yvjHT4+vlI6V+Teg1AfZT2BnfeeZ8s3BySc+OlyVWtF
        uae70NZfav+XnZ325OznyKfPb8XNXFz9dBrfzVzHqClv1/04qVUo7Sr4x2je5olpc5VYijMS
        DbWYi4oTAYLoamoXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t/xu7qMjUZxBtv7rS2uXDzEZLFxxnpW
        i6kPn7BZrJ76l9Vi7uxJjBbnz29gt7i8aw6bxYzz+5gs1h65y24x6+MPVoudd04wO3B7bPjc
        xOYx8ayux6ZVnWwefVtWMXocv7GdyePzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jB/vLjIVbOOomNi9ibmBsYW9i5GDQ0LARKL5k24X
        IxeHkMBSRonfG2+zdTFyAsVlJE5Oa2CFsIUl/lzrYoMo+sQocWPvaRaQBJuAoUTXW4iEiEAj
        o0T3vWfsIAlmgXVMEu92VYHYwgJREnd6L4JtYxFQlTh1zB4kzCtgK/H7/laoZfISqzccYJ7A
        yLOAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYMhuO/Zz8w7GSxuDDzEKcDAq8fBKlBnG
        CbEmlhVX5h5ilOBgVhLhFXUFCvGmJFZWpRblxxeV5qQWH2I0Bdo9kVlKNDkfGE95JfGGpobm
        FpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY23UVnf4Jff/A2BiSKf/jQm5P
        c1TM1d+dS2RDHwqJqlw68eUa04nWvLknmzqTNaLk967dmDr30BfhjU4HvjUfS+l1Ws/n6bTl
        th5zpZik2bbkT/GGE1gCpz+PTl8waTbfy+AdByLD5I+Fydnt/TXlZitPWbKAG/P20KMHd3Fo
        xnWJxqotOH5eiaU4I9FQi7moOBEA8GzLMm8CAAA=
X-CMS-MailID: 20200130070850eucas1p1a7a09e2bec2f6fe652f206b61a8a04ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200130070850eucas1p1a7a09e2bec2f6fe652f206b61a8a04ae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200130070850eucas1p1a7a09e2bec2f6fe652f206b61a8a04ae
References: <CGME20200130070850eucas1p1a7a09e2bec2f6fe652f206b61a8a04ae@eucas1p1.samsung.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit 71723a96b8b1 ("dmaengine: Create symlinks between DMA channels and
slaves") changed the dma_request_chan() function flow in such a way that
it always returns EPROBE_DEFER in case of channels that cannot be found.
This break the operation of the devices which have optional DMA channels
as it puts their drivers in endless deferred probe loop. Fix this by
propagating the proper error value.

Fixes: 71723a96b8b1 ("dmaengine: Create symlinks between DMA channels and slaves")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/dma/dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index f3ef4edd4de1..7b1cefc3213a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -759,7 +759,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	if (!IS_ERR_OR_NULL(chan))
 		goto found;
 
-	return ERR_PTR(-EPROBE_DEFER);
+	return chan ? chan : ERR_PTR(-EPROBE_DEFER);
 
 found:
 	chan->slave = dev;
-- 
2.17.1

