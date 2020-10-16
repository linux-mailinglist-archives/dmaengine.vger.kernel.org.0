Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACD293502
	for <lists+dmaengine@lfdr.de>; Tue, 20 Oct 2020 08:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgJTGbp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Oct 2020 02:31:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:27792 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbgJTGbp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Oct 2020 02:31:45 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201020063143epoutp037b3ec577297d723236409a8f0bff2288~-n6BOZRTh2125621256epoutp03S
        for <dmaengine@vger.kernel.org>; Tue, 20 Oct 2020 06:31:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201020063143epoutp037b3ec577297d723236409a8f0bff2288~-n6BOZRTh2125621256epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603175503;
        bh=q/yRDubQFTEVF/EhzvwKNC1PxYzwoZN8v/NQWixFw1A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hJIKFBR4lMnc+J7zyB+Gt1hvCllE4k2WTxyCNhdLt540skO5aeC7E9c3l76v13nNH
         9q7ismBc5+Y8g4BFC3J0P0EiYcDjpfErFVsFKsH5uj8t7j2ZSnB+T1bHIDgyguTvJu
         ajOFv0km2Hum/cT+ESstr78Ryp8OiZWh4iGA2qLg=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20201020063142epcas5p4eefebe127da3cfe5725708782dd71333~-n6Anv7qs2181621816epcas5p4I;
        Tue, 20 Oct 2020 06:31:42 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.F7.09567.E448E8F5; Tue, 20 Oct 2020 15:31:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20201016110722epcas5p3e1bc44be4c2b35654b440276448b7c4f~_dFj-vlKX0346203462epcas5p3F;
        Fri, 16 Oct 2020 11:07:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201016110722epsmtrp175fc1135bc1f129e41761ab84e468eb2~_dFj-JzoK2845428454epsmtrp11;
        Fri, 16 Oct 2020 11:07:22 +0000 (GMT)
X-AuditID: b6c32a4b-2f3ff7000000255f-77-5f8e844e4d43
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.05.08745.AEE798F5; Fri, 16 Oct 2020 20:07:22 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201016110721epsmtip28142bc5bc871de3407e327df4baa925b~_dFi5N5i32036620366epsmtip2_;
        Fri, 16 Oct 2020 11:07:21 +0000 (GMT)
From:   Surendran K <surendran.k@samsung.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, shaik.ameer@samsung.com, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, Surendran K <surendran.k@samsung.com>
Subject: [PATCH v2] dmaengine: pl330: Remove unreachable code
Date:   Fri, 16 Oct 2020 16:03:47 +0530
Message-Id: <20201016103347.63084-1-surendran.k@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCmlq5fS1+8we1+GYsH87axWaye+pfV
        4vKuOWwWi7Z+Ybc48nA3u8XmHVPYLXbeOcHswO6xaVUnm0ffllWMHp83yQUwR3HZpKTmZJal
        FunbJXBlfFrMUXCDtWLz0Y3MDYznWboYOTkkBEwkGrtvMHcxcnEICexmlJi+fgojhPOJUeLV
        tllQzmdGiY9TlzHBtHRuP8QEkdjFKHHj4X8WCKeFSeLL6WnMIFVsAtoSH3q3s4PYIgLWEo8O
        TmEFKWIW6GSUOHapHaxIWMBW4lLjKTYQm0VAVeLy/ttANgcHr4CNxIc/chDb5CVWbzgAdqCE
        wDx2iYm/V7JBJFwkNm48zgphC0u8Or6FHcKWknjZ3wZlZ0vc+NAPVVMhMe/GPahee4kDV+aw
        gOxiFtCUWL9LHyIsKzH11DqwL5kF+CR6fz+B+phXYsc8GFtV4uT/H8wQtrTElXX7ocZ7SEzd
        9ghsrZBArMTJf8sYJzDKzkLYsICRcRWjZGpBcW56arFpgXFearlecWJucWleul5yfu4mRnCU
        a3nvYHz04IPeIUYmDsZDjBIczEoivBNY++KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yr9OBMn
        JJCeWJKanZpakFoEk2Xi4JRqYJq8fJZZ60mLCw0dwmtC3kQ8OyBhtMjK51am1QOZn4evS1Tv
        NfbgeePh8uyCri/TF6XwnRs1Jj3nnuDp1vDv5PaNfFsZvpzY5fssJf3o29t3o07f+bijhmlS
        XsGXOv/5z+pyC/8diNu7pWHlB57PSX3pF32mFm2UlWQLZvzOdrJlckb2JQOHqfHeR564feH3
        Trdi6ouNuD87/ikrS+2afeevrJEMYJkpUH63Xsh6za37zXMFiyMtLJb/O/Arw8NthYTDjskt
        +dbnGSrnXYybsj376P8pRqv2G9+aFWuVstfNIPbm5Nkc7btPCnzU+qzlaqSZe0H+vHGyzj23
        YJ4Hf07/dsrau9mVz5713XobMwMlluKMREMt5qLiRAAWTJXfYQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJMWRmVeSWpSXmKPExsWy7bCSvO6rus54g7WzLCwezNvGZrF66l9W
        i8u75rBZLNr6hd3iyMPd7Babd0xht9h55wSzA7vHplWdbB59W1YxenzeJBfAHMVlk5Kak1mW
        WqRvl8CV8WkxR8EN1orNRzcyNzCeZ+li5OSQEDCR6Nx+iKmLkYtDSGAHo8SHC8eYIRLSEh/P
        74ayhSVW/nvODlHUxCTRe3ESO0iCTUBb4kPvdjBbRMBWYsqy42CTmAX6GSXWn5/HCpIQBkpc
        ajzFBmKzCKhKXN5/G8jm4OAVsJH48EcOYoG8xOoNB5gnMPIsYGRYxSiZWlCcm55bbFhglJda
        rlecmFtcmpeul5yfu4kRHDBaWjsY96z6oHeIkYmD8RCjBAezkgjvK+m2eCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8X2ctjBMSSE8sSc1OTS1ILYLJMnFwSjUwGXX2nUo99fZJ98qYhdpt75Im
        ZF45UW/57Vh4Xfx2kXaNNweXHGVL+lxyUGbp67aqvP3rrZvqXd/xdxfuvrp0Tfj/3s6H53ld
        755Pe3ns7OF0gTzt7Jlmri3CNtNvzavzfJ773DXhF+OS0JDykhM2Pu+D1333uyvceFbm3vdJ
        ShK7hXbM+a8je+BM3epXRvWRC9vCW/KbGWQ+TjzQuknPfnHix3z9kyzds+qMZ537NDsssPDq
        I8t/U62Oz1xxYBaLULfFTnv7DdO4orr3H8gTsndka2OoK0lYf/2WBofTgT82OyfzhTJvUrpz
        R6hb87iAuHelvA2X3rPd5lM6m/XebX5jVJgpGjv36533qbV+SizFGYmGWsxFxYkATcHuFocC
        AAA=
X-CMS-MailID: 20201016110722epcas5p3e1bc44be4c2b35654b440276448b7c4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201016110722epcas5p3e1bc44be4c2b35654b440276448b7c4f
References: <CGME20201016110722epcas5p3e1bc44be4c2b35654b440276448b7c4f@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

_setup_req(..) never returns negative value.
Hence the condition ret < 0 is never met

Signed-off-by: Surendran K <surendran.k@samsung.com>
---
Commit tag is changed

 drivers/dma/pl330.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index e9f0101d92fa..8355586c9788 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1527,8 +1527,6 @@ static int pl330_submit_req(struct pl330_thread *thrd,

 	/* First dry run to check if req is acceptable */
 	ret = _setup_req(pl330, 1, thrd, idx, &xs);
-	if (ret < 0)
-		goto xfer_exit;

 	if (ret > pl330->mcbufsz / 2) {
 		dev_info(pl330->ddma.dev, "%s:%d Try increasing mcbufsz (%i/%i)\n",
--
2.17.1

