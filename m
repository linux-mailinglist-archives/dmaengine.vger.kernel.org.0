Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675D8376077
	for <lists+dmaengine@lfdr.de>; Fri,  7 May 2021 08:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhEGGil (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 May 2021 02:38:41 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:59504 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhEGGik (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 May 2021 02:38:40 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210507063735epoutp043e47fba94f18c14bc84dd528cdac67db~8tW9E6hCu2204322043epoutp047
        for <dmaengine@vger.kernel.org>; Fri,  7 May 2021 06:37:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210507063735epoutp043e47fba94f18c14bc84dd528cdac67db~8tW9E6hCu2204322043epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620369455;
        bh=R7dryezq0Nf0+UiSalFsUCWk082+AvVZSvIDVjOyZ6c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bJxWsM/ti8ZucuYbsVIRcDRDndaLd7gR08uEJIoOO0/v4FgBmuMY+VCKki2Q6vD2A
         GvLKHR/EIfOrfglATYAegvE8h0Fq68qlEOVo9YdEEedM0v+UfOB1ytj8eWaqOefJQj
         JGXOuiam/TsouBeL95JEQmMxXUF32moVW1F6O9LE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210507063734epcas2p11f54da4d27c7b37e623a3ed3d0d341ea~8tW8nfzcx1930019300epcas2p1X;
        Fri,  7 May 2021 06:37:34 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.186]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Fc1303jJJz4x9Q0; Fri,  7 May
        2021 06:37:32 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.7D.09433.B20E4906; Fri,  7 May 2021 15:37:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210507063730epcas2p3c08de48b052cc7d8dc2805a16cd79361~8tW4x3err0384803848epcas2p3F;
        Fri,  7 May 2021 06:37:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210507063730epsmtrp28a6f8a96fa839610d0bd6495fa8daafa~8tW4w9xrk2320123201epsmtrp2J;
        Fri,  7 May 2021 06:37:30 +0000 (GMT)
X-AuditID: b6c32a47-f61ff700000024d9-d1-6094e02b9c39
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.C7.08637.A20E4906; Fri,  7 May 2021 15:37:30 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210507063730epsmtip131557ee7c383be555867873f7fc275a8~8tW4lWL800698406984epsmtip1w;
        Fri,  7 May 2021 06:37:30 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bumyong Lee <bumyong.lee@samsung.com>,
        Jongho Park <jongho7.park@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] dmaengine: pl330: fix wrong usage of spinlock flags in
 dma_cyclc
Date:   Fri,  7 May 2021 15:36:47 +0900
Message-Id: <20210507063647.111209-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmqa72gykJBtv/8VvsPW1hcXm/tsXq
        qX9ZLSbMv8lscXnXHDaLu/dOsFjsvHOC2YHdY9OqTjaP/r8GHn1bVjF6fN4kF8ASlWOTkZqY
        klqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7ReSaEsMacUKBSQ
        WFyspG9nU5RfWpKqkJFfXGKrlFqQklNgaFigV5yYW1yal66XnJ9rZWhgYGQKVJmQk3Hl6DT2
        gg7uiheLtzI3MPZxdjFyckgImEj8u3SZtYuRi0NIYAejxLT5G5ghnE+MEpv232SCcL4xSlzf
        +oOxi5EDrGXbBVmI+F5GiXVH7jFCOB8ZJb6e72UGmcsmoCux5fkrRhBbRMBTovXOOrCxzALb
        GSUObp3IBJIQFgiW+Lb0OJjNIqAqcebnfDYQm1fAXuLzk3UsEAfKS5w+cY0RIi4ocXLmE7A4
        M1C8eetssKESAsfYJSae/MgO0eAiMXv5HlYIW1ji1fEtUHEpic/v9rJBNHQzSrQ++g+VWM0o
        0dnoA2HbS/yavoUV5E9mAU2J9bv0IV5WljhyC2ovn0TH4b/sEGFeiY42IYhGdYkD26dDnSwr
        0T3nM9QFHhJnOnrA3hISiJV48XMn6wRG+VlIvpmF5JtZCHsXMDKvYhRLLSjOTU8tNiowRo7V
        TYzgNKjlvoNxxtsPeocYmTgYDzFKcDArifCeXjQ5QYg3JbGyKrUoP76oNCe1+BCjKTB8JzJL
        iSbnAxNxXkm8oamRmZmBpamFqZmRhZI478/UugQhgfTEktTs1NSC1CKYPiYOTqkGJi9HBo63
        5l08929UMx9NiNrS71oQcEt5/eaDHlfmRL8qk1VjKl5x5djD50v2qe3aeVa475PMei7326w+
        c4tW2F9TZ1f7FptTlRlof2Sr0yrFH5+UOrYZ3Zw/8+ltrevTOD5krSk59qNJwuHzKqVcmzff
        2F1c9VdZ3U7eZ8nzRuLEkhoPqRW/e1Saj3MLBqVOcl4zi+deZ39fZk9246x91tdKphToLXoq
        Iy2m+WNuwsuP8kp6rjKfnRrX3xUx/Kl9nXNJstDpJG1t/i/mFTuc+iq2amo7lJ2++IvHlOPa
        g9PBC9kvpUbYqG/f+izjZKzL3rMTpy6YP2HxhZY7V3dkrPjLaFh99PDNkvj1rxS3r1FiKc5I
        NNRiLipOBAChK5FFDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnK7WgykJBnM36VjsPW1hcXm/tsXq
        qX9ZLSbMv8lscXnXHDaLu/dOsFjsvHOC2YHdY9OqTjaP/r8GHn1bVjF6fN4kF8ASxWWTkpqT
        WZZapG+XwJVx5eg09oIO7ooXi7cyNzD2cXYxcnBICJhIbLsg28XIxSEksJtRouXkHuYuRk6g
        uKzEs3c72CFsYYn7LUdYIYreM0psOXaTDSTBJqArseX5K0YQW0TAW2Lv93Y2kCJmkEkPbs1k
        BtkgLBAo8fq9G0gNi4CqxJmf88F6eQXsJT4/WccCsUBe4vSJa4wQcUGJkzOfgMWZgeLNW2cz
        T2Dkm4UkNQtJagEj0ypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOCg1NLcwbh91Qe9
        Q4xMHIyHGCU4mJVEeE8vmpwgxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTU
        gtQimCwTB6dUA9PkP28uHjHamXb8k9rdK47Wr17WqoteCFp057vsvel7JlvqHOGdInaQiZGx
        /ibXGXcPi+7ji2OmcazJCTK/sbduwfGmiN15JqE/Yu/I7Jlfs4xl05av2z4vz/5rEhXw46Wg
        uPGEujXb/jyf9maLq//Xa+kKPddTZm1nT3OWvxij4Fz86dbjVaf0uM8nxDzzZb3p1xR41nzy
        BS7p/R6qQkY+ywoMTjw+KJ0fwfDyd5rOfYbudaclmNcmLbxd8Ej24FHRY+dvOPPuYczOEMyS
        zdjQd+s2w6Kn3pL3/J+oSop0KaVO84k+80Q0L/dx0Q0zmYbbC76raWeyNoT454S9cblqbfvr
        zVnd7hWmckWz7f8qsRRnJBpqMRcVJwIA/g4yurkCAAA=
X-CMS-MailID: 20210507063730epcas2p3c08de48b052cc7d8dc2805a16cd79361
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210507063730epcas2p3c08de48b052cc7d8dc2805a16cd79361
References: <CGME20210507063730epcas2p3c08de48b052cc7d8dc2805a16cd79361@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Bumyong Lee <bumyong.lee@samsung.com>

flags varible which is the input parameter of pl330_prep_dma_cyclic()
should not be used by spinlock_irq[save/restore] function.

Signed-off-by: Jongho Park <jongho7.park@samsung.com>
Signed-off-by: Bumyong Lee <bumyong.lee@samsung.com>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/dma/pl330.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index fd8d2bc3be9f..110de8a60058 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2694,13 +2694,15 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 	for (i = 0; i < len / period_len; i++) {
 		desc = pl330_get_desc(pch);
 		if (!desc) {
+			unsigned long iflags;
+
 			dev_err(pch->dmac->ddma.dev, "%s:%d Unable to fetch desc\n",
 				__func__, __LINE__);
 
 			if (!first)
 				return NULL;
 
-			spin_lock_irqsave(&pl330->pool_lock, flags);
+			spin_lock_irqsave(&pl330->pool_lock, iflags);
 
 			while (!list_empty(&first->node)) {
 				desc = list_entry(first->node.next,
@@ -2710,7 +2712,7 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 
 			list_move_tail(&first->node, &pl330->desc_pool);
 
-			spin_unlock_irqrestore(&pl330->pool_lock, flags);
+			spin_unlock_irqrestore(&pl330->pool_lock, iflags);
 
 			return NULL;
 		}
-- 
2.31.1

