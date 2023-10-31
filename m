Return-Path: <dmaengine+bounces-28-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A01047DC4FF
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 04:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41788B20D9B
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 03:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5455663;
	Tue, 31 Oct 2023 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YJ88UxgM"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391553BA
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 03:50:32 +0000 (UTC)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0D9B3
	for <dmaengine@vger.kernel.org>; Mon, 30 Oct 2023 20:50:29 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231031035025epoutp0374df788de680ba30a69a49dc27f2f949~TFK7YgTdM2066420664epoutp03X
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 03:50:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231031035025epoutp0374df788de680ba30a69a49dc27f2f949~TFK7YgTdM2066420664epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698724225;
	bh=EouRBmKhq7EoiCaGaT+zyOrMyxPMDT7M3xsIO4slk4s=;
	h=From:To:Cc:Subject:Date:References:From;
	b=YJ88UxgM32YrovmwYcV+BeHKeER5W4pLzW5L77vI89lTZ72jbU/JsHPZ4wkTmyhxN
	 fs95W10bGd3x1TI5uOqxFHVDtmWn+I3ITc1SFGKjEGljKa1DY9G7IixQVHFbUmXppX
	 tPSin7TNnpYc3BDMRlZNFRUpyJmPiRJ7zUM7/7xw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20231031035025epcas2p3856d14781454c08771e820211a22a426~TFK7EiZbO2646326463epcas2p3M;
	Tue, 31 Oct 2023 03:50:25 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SKGPY038xz4x9Q7; Tue, 31 Oct
	2023 03:50:25 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.2D.09622.08970456; Tue, 31 Oct 2023 12:50:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20231031035024epcas2p240760f064c90e017a3ada73d9271e9c9~TFK6CGabC1784117841epcas2p2u;
	Tue, 31 Oct 2023 03:50:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231031035024epsmtrp12bcabfbd69d8da4bdcdd0a666b28ad19~TFK6Bg-2p1514115141epsmtrp1X;
	Tue, 31 Oct 2023 03:50:24 +0000 (GMT)
X-AuditID: b6c32a46-fcdfd70000002596-98-65407980a5dc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7F.17.08755.F7970456; Tue, 31 Oct 2023 12:50:24 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231031035023epsmtip29e794305b731194f9a743e888bd22a16~TFK5xaJ2y0824508245epsmtip2S;
	Tue, 31 Oct 2023 03:50:23 +0000 (GMT)
From: Bumyong Lee <bumyong.lee@samsung.com>
To: Vinod Koul <vkoul@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Bumyong Lee
	<bumyong.lee@samsung.com>
Subject: [PATCH] dmaengine: pl330: set subsys_initcall level
Date: Tue, 31 Oct 2023 12:48:54 +0900
Message-ID: <20231031034854.115624-1-bumyong.lee@samsung.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmhW5DpUOqwaceWYu9py0sVk/9y2px
	edccNou7906wWOy8c4LZgdVj06pONo/+vwYefVtWMXp83iQXwBKVbZORmpiSWqSQmpecn5KZ
	l26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFVJoSwxpxQoFJBYXKykb2dTlF9a
	kqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ1x52FKwW6OioMPLjM3MM5h
	72Lk5JAQMJF4c/s+YxcjF4eQwA5GiW2t51ggnE+MEtP7J0M53xglWncdYINpmThtE1RiL6PE
	xSlrmSGcj4wSnQe7WEGq2AS0JV4dmABmiwh4SrTeWccMYjMLpEj0zXrPAmILC9hIHHo+iwnE
	ZhFQlfgzrQHoKA4OXgFbiS+NhRDL5CX2LPoOVsIrIChxcuYTFogx8hLNW2czQ9RsYpdY18kP
	YbtILLq1jxXCFpZ4dXwL1J9SEi/726DsbIkjh/5D2RUSx070MUHYxhKznrUzgpzALKApsX6X
	PogpIaAsceQW1FY+iY7Df9khwrwSHW1CEKaqRNPNeogZ0hLLzsxghQh7SKy8bwESFhKIlZh0
	eSHLBEb5WUg+mYXkk1kIWxcwMq9iFEstKM5NTy02KjCCx2dyfu4mRnCa03LbwTjl7Qe9Q4xM
	HIyHGCU4mJVEeA+bOqQK8aYkVlalFuXHF5XmpBYfYjQFBu1EZinR5Hxgos0riTc0sTQwMTMz
	NDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoFplaiAmmea5tfXXaqNz9tFAoIuJgd/
	7Q973n+v9774Qu4IkUNFIqUbf162jEyPyTp7I5/t0AKbxRX/bXe/+i4VNcly7YuJrMzfE1Ou
	SMqlt57wYW44NWHK1YR9Kn5TlDbEyrZ674g9+XFtnbVWzZlHb3TW+EXf6DY943KXaZuP+kWP
	VS4nVe5x8pcuf/Dj35om/63MZ7L0q15Jq954sdPxOtOhD4YevLmLHifuTv+8eR3P1Ikvpz9W
	llUOuZEVdp3l0gG/ftf1vgEeTWYzeTr5wi2frZ3SNtNs2dXZGyI+fkqMuZjyMlHms+kLo4Ss
	lhMtxmsvuTYrqkanPD+3SO/sQfWksHirKPnzD1oeNP5UYinOSDTUYi4qTgQAl95OKvwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsWy7bCSvG5DpUOqwexfjBZ7T1tYrJ76l9Xi
	8q45bBZ3751gsdh55wSzA6vHplWdbB79fw08+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK+PO
	w5SC3RwVBx9cZm5gnMPexcjJISFgIjFx2iaWLkYuDiGB3YwSN9/8YYFISEu8aP3GCmELS9xv
	OcIKUfSeUaKx7zcbSIJNQFvi1YEJYEUiAt4Se7+3g8WZBdIkHr09CGYLC9hIHHo+iwnEZhFQ
	lfgzrQFoMwcHr4CtxJfGQoj58hJ7Fn0HK+EVEJQ4OfMJC8QYeYnmrbOZJzDyzUKSmoUktYCR
	aRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnAAamnuYNy+6oPeIUYmDsZDjBIczEoi
	vIdNHVKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ84q/6E0REkhPLEnNTk0tSC2CyTJxcEo1MDEI
	2Ra3VgpdfaBRphl1Z6bEljPC/7i3PYhVzJ7+80A+94kZ/7PkpPztzb5fPCalnjNnp/Phh+s5
	U+wPX9K4Vr7Z71DVY8aJKjJrXNW4xfI6H+dNmLhi1cZ10zY0XNFNrohO2i3UIaMT+8q8Z01n
	1J9JrzZfj72419LyQZfr8vgdaku/CoUpWFzIkX4R9+pHf97FSoOfMnp6iX4aC7fye+sazw4P
	sUo1DRdd9EM8f+uvQ4s/G3G1z0pc+PJV7MUuze36212K3kwzjZoutK+4nc/J7olbQeAatd8K
	bPdmzSi7ZrZHlqU6zL708eWzbiYiAoGvEvde/9ZUp38vYnqUh+ziii7n2zxeh14wNXZcV2Ip
	zkg01GIuKk4EAI9h/pavAgAA
X-CMS-MailID: 20231031035024epcas2p240760f064c90e017a3ada73d9271e9c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031035024epcas2p240760f064c90e017a3ada73d9271e9c9
References: <CGME20231031035024epcas2p240760f064c90e017a3ada73d9271e9c9@epcas2p2.samsung.com>

module_amba_driver is macro for module_init/exit
module_init is device_initcall level when it configured
with built-in driver.

pl330 is dmaengine driver. because slave drivers depend on
dmaengine drivers, dmaengine drivers is more appropriate
subsys_initcall.

Signed-off-by: Bumyong Lee <bumyong.lee@samsung.com>
---
 drivers/dma/pl330.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 3cf0b38387ae..4970830d7ab0 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -3270,7 +3270,17 @@ static struct amba_driver pl330_driver = {
 	.remove = pl330_remove,
 };
 
-module_amba_driver(pl330_driver);
+static int __init pl330_init(void)
+{
+	return amba_driver_register(&pl330_driver);
+}
+subsys_initcall(pl330_init);
+
+static void __exit pl330_exit(void)
+{
+	amba_driver_unregister(&pl330_driver);
+}
+module_exit(pl330_exit);
 
 MODULE_AUTHOR("Jaswinder Singh <jassisinghbrar@gmail.com>");
 MODULE_DESCRIPTION("API Driver for PL330 DMAC");
-- 
2.42.0


