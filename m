Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F825124B
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 08:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgHYGq1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 02:46:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46235 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgHYGq0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 02:46:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200825064624euoutp0231a950c2f4b40aa4ea824650617366c7~ub_2u3Xbk1675216752euoutp021
        for <dmaengine@vger.kernel.org>; Tue, 25 Aug 2020 06:46:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200825064624euoutp0231a950c2f4b40aa4ea824650617366c7~ub_2u3Xbk1675216752euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598337984;
        bh=Lh/NX7H67LjExdxCrMRZFUhDLwhDWtl4bmR0W/2GllE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VOlHxOPgcX+KErzihGNWlF8ipv9SJ7pujBaBg9JJSF/dxm7KmI8umHEC1kwB4Vz5D
         +BZQ3B+X8W3xGVlOkxkPAgUjaJbK+8eIdN5MuMXE+N4ZvGDWXbj8E2Ef5NoSCChw8V
         uW/LZBcm92Yohb9hpVAeTgXmKcjcuocxHDM4nGD8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200825064624eucas1p25bac963c6430e2b93d120898d19c9b43~ub_2hQKDe1600416004eucas1p2V;
        Tue, 25 Aug 2020 06:46:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 23.D7.05997.0C3B44F5; Tue, 25
        Aug 2020 07:46:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200825064623eucas1p2d8ba8813794fe18ddd246b9a4789ed93~ub_2GeBz11611216112eucas1p2Q;
        Tue, 25 Aug 2020 06:46:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200825064623eusmtrp26e0d4580d320c9920045f7c5f825c012~ub_2Fd1lX0265402654eusmtrp2p;
        Tue, 25 Aug 2020 06:46:23 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-53-5f44b3c0fb3a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B6.46.06314.FB3B44F5; Tue, 25
        Aug 2020 07:46:23 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200825064623eusmtip1b86b15e1292343a8f0f5986031386bd5~ub_1pgKgi1291312913eusmtip1z;
        Tue, 25 Aug 2020 06:46:23 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sugar Zhang <sugar.zhang@rock-chips.com>, lkp@intel.com
Subject: [PATCH] dmaengine: pl330: Fix burst length if burst size is smaller
 than bus width
Date:   Tue, 25 Aug 2020 08:46:17 +0200
Message-Id: <20200825064617.16193-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTYRTHeXa3u+tqdZsDD5Yag6KCNDXoYi+kCY4gMD/0wTCb8+bEbdq9
        OjUFl8bQTcVEaZmRVJBMljqXL1NMZ7hAUlHQiC1JkZwgQlppabbbtfr2O8///M6Bw0Ngsm/C
        UCJbn08zepVWgUuE3aObEyeHuhLTT/naCarT2i6i2hq3RZRjYUZETbuacWq5Yh6n7G98Ysr7
        YVBA9XnfYhcJ5bMBv0DpsFXhyq7nZcrtptdCZa3ThpRrjvBkPFVyLpPWZhtoJurCTYnG37wk
        zpuQFPlGFsVGtESYEUEAeRo2vkeYkYSQka0IGvwWEV+sI3DOzQrMKChQrCGwTrEcc4KzdnK3
        6UXA2PIK+aaA4djQc4yT0WBeMeMcy0k1zIyacE7AyGEEbpcZcUEwmQZzLquYYyF5BOyvjH8G
        ScnzsDnKbwYyAto6hjBOBvIzDvZyy26QCK7VRcRzMCx7nGKeD8FO3xMBL1Qg+DRuF/NFNYLp
        cuuucRa84z9w7gIYeRzaXVH8MeKhZzWJx33wfuUA14wFsL77AcY/S6HSJONnHIUmz8t/W4cn
        pzCelfClsgXjb5IGE85+cR0Kb/q/qgUhGwqhC1hdFs3G6OnCSFalYwv0WZHqXJ0DBX7D2C/P
        ei9ybWW4EUkgxV6pcfBSukykMrDFOjcCAlPIpQnvxm7IpJmq4js0k5vOFGhp1o0OEkJFiDT2
        qT9NRmap8ukcms6jmb+pgAgKNSKm30R/LLtSk6KOTW2eUefYkus8GyU5YSs79XtaNY90kSno
        ZylzZjOp7lZjyVJGrKUzbFZOdzfs1/Q9vHs4Lt+wFTp8WYNV97p9A60wf70h4Wrh42OoMGbk
        69za7UOYKa7smjxbW91zr6iqpvQ+LBR7kuINO3hEhyWzcsiMK4SsRhV9AmNY1W9JwYAeCQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsVy+t/xu7r7N7vEGxx5r2qxccZ6VovVU/+y
        Wmx6fI3V4vKuOWwWr5ofsVmsPXKX3eLOrX1MFjvvnGB24PBYvOclk8emVZ1sHpuX1Hv8nbWf
        xaNvyypGj8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
        MstSi/TtEvQyXs55wV5wnqvi7uGn7A2MLzi6GDk5JARMJLb0XWDtYuTiEBJYyigxc+EzVoiE
        jMTJaQ1QtrDEn2tdbBBFnxglfrZfYgJJsAkYSnS9BUlwcogIpEpMXHSJEcRmFjjKKPFlk1cX
        IweHsEC0xLumJJAwi4CqxNqtDSwgNq+ArcTPY9eZIObLS6zecIB5AiPPAkaGVYwiqaXFuem5
        xYZ6xYm5xaV56XrJ+bmbGIFBue3Yz807GC9tDD7EKMDBqMTD27DPOV6INbGsuDL3EKMEB7OS
        CK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgZZPZJYSTc4HRkxeSbyhqaG5haWhubG5sZmFkjhv
        h8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZG7kqFtKpdM42eSh203pb0fP2E4rsevnE2/4yv/NvS
        MWlLFsMl8epIPp5zdi9cd7DvZT0VtPmm/neGuFIZpztx6vNu3ggPu9pX+42xw5Mnekfh0rf7
        P17J9ev8oTv3u2B04quTggfNOPuUL/xXlNW1frVd3KNnS4oiq8GctKRlV9cJG23ZFyulxFKc
        kWioxVxUnAgAuVWFuWACAAA=
X-CMS-MailID: 20200825064623eucas1p2d8ba8813794fe18ddd246b9a4789ed93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200825064623eucas1p2d8ba8813794fe18ddd246b9a4789ed93
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200825064623eucas1p2d8ba8813794fe18ddd246b9a4789ed93
References: <CGME20200825064623eucas1p2d8ba8813794fe18ddd246b9a4789ed93@eucas1p2.samsung.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the burst len fixup after setting the generic value for it. This
finally enables the fixup introduced by commit 137bd11090d8 ("dmaengine:
pl330: Align DMA memcpy operations to MFIFO width"), which otherwise was
overwritten by the generic value.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 137bd11090d8 ("dmaengine: pl330: Align DMA memcpy operations to MFIFO width")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 2c508ee672b9..e010064d8846 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2801,6 +2801,7 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	while (burst != (1 << desc->rqcfg.brst_size))
 		desc->rqcfg.brst_size++;
 
+	desc->rqcfg.brst_len = get_burst_len(desc, len);
 	/*
 	 * If burst size is smaller than bus width then make sure we only
 	 * transfer one at a time to avoid a burst stradling an MFIFO entry.
@@ -2808,7 +2809,6 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	if (desc->rqcfg.brst_size * 8 < pl330->pcfg.data_bus_width)
 		desc->rqcfg.brst_len = 1;
 
-	desc->rqcfg.brst_len = get_burst_len(desc, len);
 	desc->bytes_requested = len;
 
 	desc->txd.flags = flags;
-- 
2.17.1

