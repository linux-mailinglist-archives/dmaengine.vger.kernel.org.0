Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4871B243FFF
	for <lists+dmaengine@lfdr.de>; Thu, 13 Aug 2020 22:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMUl4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Aug 2020 16:41:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53098 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMUlz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Aug 2020 16:41:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200813204153euoutp017e4f352c23db6498b32d39535cae1b71~q7o51jVnC1018010180euoutp01U
        for <dmaengine@vger.kernel.org>; Thu, 13 Aug 2020 20:41:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200813204153euoutp017e4f352c23db6498b32d39535cae1b71~q7o51jVnC1018010180euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597351313;
        bh=3nZADrUFUgfGPQxdSrhWsZX6s3iqEwBwc14jXbAEU28=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PZmnYyT6XUGmRxe9UpnjPY7BkzuslvEkHUs0vsTfToXFuQS1Jvc15VaIYLyy0FZWH
         fRv3vumQ/NbeplwCxDWRHqtOlCA1p0cZquds83sup6RBw15g/6+PD3V4UftWpFNVIc
         HkxBv2oI6RKNZXfhWiq7mxLxyz0mc7IlZdTNm1/k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200813204152eucas1p131a31edbcf91bd44cd4db544d617a3f8~q7o40NSWe1357313573eucas1p1l;
        Thu, 13 Aug 2020 20:41:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 52.B1.05997.095A53F5; Thu, 13
        Aug 2020 21:41:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200813204151eucas1p1c64a0880ba83013f87d0ca41242e533a~q7o4CdKQy0951509515eucas1p1t;
        Thu, 13 Aug 2020 20:41:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200813204151eusmtrp1f40391b21178da748681535f7007829a~q7o4BtnFN2785827858eusmtrp1v;
        Thu, 13 Aug 2020 20:41:51 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-4e-5f35a5908250
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DF.C9.06314.F85A53F5; Thu, 13
        Aug 2020 21:41:51 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200813204151eusmtip27cc4eb74b070be0244cd11152ea33af5~q7o34_tnp1027010270eusmtip2x;
        Thu, 13 Aug 2020 20:41:51 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] dmaengine: pl330: fix instruction dump formatting
Date:   Thu, 13 Aug 2020 22:41:23 +0200
Message-Id: <20200813204123.19044-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7oTlprGG7xfJGaxccZ6VovpUy8w
        Wqye+pfV4uahFYwWl3fNYbO4e+8Ei8XOOyeYHdg9Fu95yeSxaVUnm0f/XwOPvi2rGD0+b5IL
        YI3isklJzcksSy3St0vgylh68zZ7wUvWis1rp7I1MF5g6WLk5JAQMJHonLadCcQWEljBKHHg
        lm4XIxeQ/YVRYsr138wQic+MEgteOcM03J7ezQZRtJxR4vHqqcwQznNGiR/NnxhBqtgEHCX6
        l55gBUmICKxnlNjZeQlsFLNAtETvlbdg+4QFnCS+/brKCmKzCKhKNG5cxw5i8wpYS2z7uI0Z
        Yp28RPvy7WwQcUGJkzOfgN3NL6AlsabpOgvETHmJ5q2zoeqns0t0L7aGsF0k5vw9CvWnsMSr
        41vYIWwZidOTe4DiHEB2vcTkSWYgd0oI9DBKbJvzA6reWuLOuV9sIDXMApoS63fpQ5Q7Sjxo
        M4Aw+SRuvBWEOIBPYtK26cwQYV6JjjYhiBkqEuv690DNk5LofbWCEcL2kPh3cAvTBEbFWUje
        moXklVkIaxcwMq9iFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITDGn/x3/soNx15+kQ4wC
        HIxKPLwRDqbxQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zo
        ZayQQHpiSWp2ampBahFMlomDU6qBUeRgcneVhNhByT9JzBOXG7Z9c2M9eHJDfC5DoaHptSel
        YoWT5M7ZHHMrCI45rOh4NuxaiPFX17VSxx7Ulgo8fK0f/f5Uwo15H21OMraWL1J7Gr3gaqal
        9WmuVQvmF648ocC+/fUv5sq4/XlF3W5+CcwGsQvj5FtNO60nzBGT2HKuW4SF+WWAEktxRqKh
        FnNRcSIA+AbSZi0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xe7r9S03jDc4vkbfYOGM9q8X0qRcY
        LVZP/ctqcfPQCkaLy7vmsFncvXeCxWLnnRPMDuwei/e8ZPLYtKqTzaP/r4FH35ZVjB6fN8kF
        sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZSy9
        eZu94CVrxea1U9kaGC+wdDFyckgImEjcnt7N1sXIxSEksJRR4tOcF0xdjBxACSmJlXPTIWqE
        Jf5c62IDsYUEnjJKPNvNB2KzCThK9C89wQpiiwhsZpT4dTYcxGYWiJaY/Ws5WFxYwEni26+r
        YDaLgKpE48Z17CA2r4C1xLaP25gh5stLtC/fzgYRF5Q4OfMJC8gJzALqEuvnCYGE+QW0JNY0
        XWeBGC8v0bx1NvMERoFZSDpmIXTMQlK1gJF5FaNIamlxbnpusaFecWJucWleul5yfu4mRmCM
        bDv2c/MOxksbgw8xCnAwKvHwRjiYxguxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0
        J7X4EKMp0DsTmaVEk/OB8ZtXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaP
        iYNTqoGxOm37kUiegH0LvhzY0VL66nx0wCuTdYJt0zZ7hz5KeKAhG/7klMPrrRfXz04Xf/g3
        /u3foB8LI2671LMwZyTIz+HbUKh2n9vj9NXHn44Jvb6x8TJL1R0p8bBI5QMKO44mZTQvE/KZ
        0jwhIvL8dneLK0kFr7Xe/X6h+MWMc57TQuNLy4VfZq3fqcRSnJFoqMVcVJwIADDQ6sunAgAA
X-CMS-MailID: 20200813204151eucas1p1c64a0880ba83013f87d0ca41242e533a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200813204151eucas1p1c64a0880ba83013f87d0ca41242e533a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200813204151eucas1p1c64a0880ba83013f87d0ca41242e533a
References: <CGME20200813204151eucas1p1c64a0880ba83013f87d0ca41242e533a@eucas1p1.samsung.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Instruction dump uses two printk() in a row to print one instruction. Use
KERN_CONT to prevent breaking the output in the middle.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 88b884cbb7c1..e1af6a470453 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -254,7 +254,7 @@ enum pl330_byteswap {
 static unsigned cmd_line;
 #define PL330_DBGCMD_DUMP(off, x...)	do { \
 						printk("%x:", cmd_line); \
-						printk(x); \
+						printk(KERN_CONT x); \
 						cmd_line += off; \
 					} while (0)
 #define PL330_DBGMC_START(addr)		(cmd_line = addr)
-- 
2.26.2

