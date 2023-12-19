Return-Path: <dmaengine+bounces-574-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967D818125
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 06:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05091F2215C
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 05:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33516C131;
	Tue, 19 Dec 2023 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cHEKPKrQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81CCBE5A
	for <dmaengine@vger.kernel.org>; Tue, 19 Dec 2023 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231219055054epoutp021886e3d581b65a763adabaf97d8a527b~iJbHH712O1829018290epoutp02M
	for <dmaengine@vger.kernel.org>; Tue, 19 Dec 2023 05:50:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231219055054epoutp021886e3d581b65a763adabaf97d8a527b~iJbHH712O1829018290epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702965054;
	bh=vS1oP5iGRxlsDO6czYXHKxfOWISMU1maD1ga+U6KYqU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=cHEKPKrQ9C24XsPzoFidZJNBEgHd2vwOdKCrsSVj6FiEr31szGAPiYxYAP4yqRhD1
	 uQZe94lqrrgJrMM1cjHVVpBdJKZL9bpY2x9880k1TkV3oSvTce3CG5LCmoSSEt8p6k
	 ZTKGW1Ykgme+T6nQfj1M4N/6QAxKn13mqr8Bs2Lk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20231219055054epcas2p41441ffa6ab7a24551330537018b50d57~iJbGsWXkM0806908069epcas2p4F;
	Tue, 19 Dec 2023 05:50:54 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.92]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SvQlx5VKxz4x9Q8; Tue, 19 Dec
	2023 05:50:53 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.7B.08648.D3F21856; Tue, 19 Dec 2023 14:50:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20231219055052epcas2p4bb1d8210f650ab18370711db2194e8e3~iJbFLfEkC1416214162epcas2p4F;
	Tue, 19 Dec 2023 05:50:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231219055052epsmtrp2a009a5976b11e6c6760815ccee5f3fb4~iJbFK1D491965519655epsmtrp22;
	Tue, 19 Dec 2023 05:50:52 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-eb-65812f3d3ed7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CF.B9.08755.C3F21856; Tue, 19 Dec 2023 14:50:52 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231219055052epsmtip2c7090de8b6f9c19b6b06dd8b455c5082~iJbE6muV52053220532epsmtip2K;
	Tue, 19 Dec 2023 05:50:52 +0000 (GMT)
From: Bumyong Lee <bumyong.lee@samsung.com>
To: vkoul@kernel.org, p.zabel@pengutronix.de
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Bumyong Lee
	<bumyong.lee@samsung.com>
Subject: [PATCH] dmaengine: pl330: issue_pending waits until WFP state
Date: Tue, 19 Dec 2023 14:50:26 +0900
Message-ID: <20231219055026.118695-1-bumyong.lee@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmua6tfmOqwZO/WhZ7T1tYrJ76l9Xi
	8q45bBZ3751gsdh55wSzA6vHplWdbB79fw08+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUz
	L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKuSQlliTilQKCCxuFhJ386mKL+0
	JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjzsM+1oLL7BU9b/8yNzCu
	Y+ti5OSQEDCRWLd/DWMXIxeHkMAORom2KVfYIJxPjBIPrp5lhnC+MUr8/7seyOEAa9kxpR4i
	vpdRYtO6iywQzkdGibNzzrKDzGUT0JZ4dWACK4gtIqAj8efqEbB9zAIpEn2z3rOA2MICbhKn
	N01kBLFZBFQlHi9dCNbLK2Ar8ffHGaj75CUW71jODBEXlDg58wkLxBx5ieats5kharaxSxy6
	bA9hu0j8XrGIEcIWlnh1fAs7hC0l8fndXqiZ+RIz59xggbBrJL7e+wcVt5dYdOYnO8iTzAKa
	Eut36UP8qyxx5BbUVj6JjsN/2SHCvBIdbUIQpqpE0816iBnSEsvOzGCFsD0krv6/wQRiCwnE
	Sly7sIx9AqP8LCSvzELyyiyEtQsYmVcxiqUWFOempyYbFRjCYzQ5P3cTIzjVaTnvYLwy/5/e
	IUYmDsZDjBIczEoivC6L6lOFeFMSK6tSi/Lji0pzUosPMZoCA3cis5Rocj4w2eaVxBuaWBqY
	mJkZmhuZGpgrifPea52bIiSQnliSmp2aWpBaBNPHxMEp1cB0SZpdcRFXxAaD9VznV/29+S/5
	a4WzhcbvqrcbRefMrrq3O7BlYumml2WRm/9fD2E590Zp2cPViZMDa1akTedccebW5Qfa93er
	Cf8Wm5VddG/uqq3FRfPrf0skfVcP6X7YG22ZxLCkV5X7nHI6R2/Sh2KlYP/vlRcfebc3GDy4
	ypZpxXvMXd74h43p0gUOL79UWpVczZ8iY9t87M55q/Z565L+nv9Y9I2vv6LO4TT/a55tM8vX
	cSj3TxZ84nnqg16avL7YQx1bj0+d09SutjkJ2WXusnmp6jBx941Yu8dxk8Umef3Oyw09GL3y
	fi5TGVeI7RQnIXu9GKNLfXF73vx2Wvr0iq5gkhO3RIXqJzklluKMREMt5qLiRAAzfNuM/gMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsWy7bCSvK6NfmOqQctlUYu9py0sVk/9y2px
	edccNou7906wWOy8c4LZgdVj06pONo/+vwYefVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlXHn
	YR9rwWX2ip63f5kbGNexdTFycEgImEjsmFLfxcjJISSwm1Fi5gUpEFtCQFriRes3VghbWOJ+
	yxEgmwuo5j2jxOvrsxlBEmwC2hKvDkwAKxIR0JOYufoAM4jNLJAm8ejtQTYQW1jATeL0polg
	9SwCqhKPly5kB7F5BWwl/v44wwaxQF5i8Y7lzBBxQYmTM5+wQMyRl2jeOpt5AiPfLCSpWUhS
	CxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBAegluYOxu2rPugdYmTiYDzEKMHB
	rCTC67KoPlWINyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QD
	U9HcRvU3zK7Tky6dO/p61SXzSfZnHqxiKlvBdjLCUjPX2Ou+7ceCo0crniZMzy+Jf7mE5zr7
	fMVHGV3/y3hUlrPkXPd/7XJRZprC20IR9dULKn03S7YL+bL9OxqxNWtKk0fURZkXrauVz7+O
	T092mf7zrFj10jWxMg3nxc+9/9WwSjmiXTrp9Gw/tidMzvpi6QmBdxdybsoWaY5esuVl0pw/
	X/7ZHL7wtjKr9eLjI8/i2c9Oclnx6ZNCp/0thQJPEd4XE9gKjgWWnc/3n+7fuv+0QESg0qJ+
	CZFWJ6kQ078P3c/o+NwWapi3v5lppo73CtGC4Dlzmp/wXTy1OKvVW+pa7BueRTxM0UzhHY3J
	SizFGYmGWsxFxYkAQszlr68CAAA=
X-CMS-MailID: 20231219055052epcas2p4bb1d8210f650ab18370711db2194e8e3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231219055052epcas2p4bb1d8210f650ab18370711db2194e8e3
References: <CGME20231219055052epcas2p4bb1d8210f650ab18370711db2194e8e3@epcas2p4.samsung.com>

According to DMA-330 errata notice[1] 71930, DMAKILL
cannot clear internal signal, named pipeline_req_active.
it makes that pl330 would wait forever in WFP state
although dma already send dma request if pl330 gets
dma request before entering WFP state.

The errata suggests that polling until entering WFP state
as workaround and then peripherals allows to issue dma request.

[1]: https://developer.arm.com/documentation/genc008428/latest
Signed-off-by: Bumyong Lee <bumyong.lee@samsung.com>
---
 drivers/dma/pl330.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 3cf0b38387ae..c29744bfdf2c 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1053,6 +1053,9 @@ static bool _trigger(struct pl330_thread *thrd)
 
 	thrd->req_running = idx;
 
+	if (desc->rqtype == DMA_MEM_TO_DEV || desc->rqtype == DMA_DEV_TO_MEM)
+		UNTIL(thrd, PL330_STATE_WFP);
+
 	return true;
 }
 
-- 
2.43.0


