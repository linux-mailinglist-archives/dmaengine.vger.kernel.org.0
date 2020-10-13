Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B708928CE41
	for <lists+dmaengine@lfdr.de>; Tue, 13 Oct 2020 14:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgJMMXl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Oct 2020 08:23:41 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18807 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgJMMXk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Oct 2020 08:23:40 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201013122337epoutp02fc2cd9993bf175fbbd3ebf8a66f1663b~9jMRTJMaI1299012990epoutp02d
        for <dmaengine@vger.kernel.org>; Tue, 13 Oct 2020 12:23:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201013122337epoutp02fc2cd9993bf175fbbd3ebf8a66f1663b~9jMRTJMaI1299012990epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602591817;
        bh=vhCHSTYT3RjO1E7ie1Ctba4Syv1zYIq8jW2a+IGfhFw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZeUXEF8wTCbkqrIOFEs7EKOvLPN0uBc97xTJj7h66RHoc+b19b7ENFAdgPDT5tVCy
         UdlHMXqqa3WCsTdXF5wF+y68JSeptrQd4+NfY0w/kLIdEes+iXnqw6XtQmZh6exCsZ
         tTewiGrW+oN4mvjSV93ANt6lJrbJmXKSQgTzN89A=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20201013122336epcas5p1207c78dbfb3458cff07ebe7febdfa637~9jMQgruBJ2857928579epcas5p1O;
        Tue, 13 Oct 2020 12:23:36 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.73.09567.84C958F5; Tue, 13 Oct 2020 21:23:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20201013122030epcas5p2e576d5a2ebfaf9df8078e6ee70f3765c~9jJjDcHse2423824238epcas5p2y;
        Tue, 13 Oct 2020 12:20:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201013122030epsmtrp23b07696b12b136a6399a2d5972823c3a~9jJjCwY370338303383epsmtrp2-;
        Tue, 13 Oct 2020 12:20:30 +0000 (GMT)
X-AuditID: b6c32a4b-2f3ff7000000255f-60-5f859c48e880
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.15.08604.D8B958F5; Tue, 13 Oct 2020 21:20:29 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201013122028epsmtip1ce5d5d13b962ec5603d315ed66872cce~9jJh4bzSe2620526205epsmtip1j;
        Tue, 13 Oct 2020 12:20:28 +0000 (GMT)
From:   Surendran K <surendran.k@samsung.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, shaik.ameer@samsung.com, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, Surendran K <surendran.k@samsung.com>
Subject: [PATCH] DMA: PL330: Remove unreachable code
Date:   Tue, 13 Oct 2020 17:17:13 +0530
Message-Id: <20201013114713.28754-1-surendran.k@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCmhq7HnNZ4g7sLhC0ezNvGZrF66l9W
        i8u75rBZLNr6hd3iyMPd7Babd0xht9h55wSzA7vHplWdbB59W1YxenzeJBfAHMVlk5Kak1mW
        WqRvl8CVsXzjM+aCQ6wVrz6lNDDuZeli5OCQEDCROH42vIuRi0NIYDejRMe/l6wQzidGiekH
        J7BAON8YJe79/MUO03HzuT1EfC+jxM+v99ggnBYmicmdS4EcTg42AW2JD73b2UFsEQFriUcH
        p4CNZRboZJQ4dqmdGSQhDDTp3uxFjCA2i4CqxKeGdawgNq+AjUTPx89gcQkBeYnVGw4wQ9iL
        2CU6r9tA2C4S7ydPYYGwhSVeHd/CDmFLSXx+t5cNws6WuPGhnxXCrpCYd+MeVNxe4sCVOWD/
        MwtoSqzfpQ8RlpWYemodE4jNLMAn0fv7CRNEnFdixzwYW1Xi5P8fUOdIS1xZtx9qvIfE9OaZ
        YHEhgViJ7Sdfs0xglJ2FsGEBI+MqRsnUguLc9NRi0wLjvNRyveLE3OLSvHS95PzcTYzgCNfy
        3sH46MEHvUOMTByMhxglOJiVRHjPqTfFC/GmJFZWpRblxxeV5qQWH2KU5mBREudV+nEmTkgg
        PbEkNTs1tSC1CCbLxMEp1cDUstH7bEDCYvknj4s21u+SWyV5+vZilntKMlfvvzM32BEyZ9Hz
        GaVtKa8Fza+Fi59nsb9UsGe6W8M8rrPfol8+dtkYobBO897WPeUP1heXPrwRFcO6ZHG1+l/x
        6eEyq5Zq3ZYpzuDdv/xPRYi1Ajvb8ZmfN4kXXuxSyOG8sJTf1fSPS9Gegh9tU0+e31ATPfnT
        okq2ZsWzS1blaia/3mAzY9GcJdGa350/s14zX1u73PxSm3sS6+r0x+ozfx/l7si8UXr33ybX
        vMrJQkkfk3y+BGieMK1L8PPnjVqYHF+k4LoxmsNkfYbWSz9F/dgNUnrLUmSq90X7Sgi1hV8v
        27r+yasO1r5ZBaZl/lFJz8SVWIozEg21mIuKEwECwMOyXwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJMWRmVeSWpSXmKPExsWy7bCSnG7v7NZ4g/tLbSwezNvGZrF66l9W
        i8u75rBZLNr6hd3iyMPd7Babd0xht9h55wSzA7vHplWdbB59W1YxenzeJBfAHMVlk5Kak1mW
        WqRvl8CVsXzjM+aCQ6wVrz6lNDDuZeli5OCQEDCRuPncvouRi0NIYDejRPPVmUBxTqC4tMTH
        87uZIWxhiZX/nrOD2EICTUwSbz6agdhsAtoSH3q3g8VFBGwlpiw7zgQyiFmgn1Fi/fl5rCAJ
        YaAF92YvYgSxWQRUJT41rAOL8wrYSPR8/MwIsUBeYvWGA8wTGHkWMDKsYpRMLSjOTc8tNiww
        zEst1ytOzC0uzUvXS87P3cQIDhctzR2M21d90DvEyMTBeIhRgoNZSYT3nHpTvBBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHeG4UL44QE0hNLUrNTUwtSi2CyTBycUg1MNQ+TJxq83hhb5x/W9zB6
        Ns+qqG/mnJmvGldNmNH3deXt2c/MTNpvCu1MmPNxP5Nw3z3+a9F/m4q+3X+ov+rS68zZLzvE
        wh09NSYEv7wj7L7eubNt/pTZzVPFVjHNCZk7b/JmL65db468SW92bqlfWF1ueNq36dRqj9C0
        hrraBqaCjeHSkxqcuGyeJPqdu8V2Yv7q/NCP/i1W5zozVzx9s+KX+V3PLNsYywu6++y11Ll+
        LPqx/d+JJu3v2Vfqz76b8bdyv5XjOl/5T7detL5b++S/xrM/WULHtE4tqxTtd0j9mlgQwHt4
        8RL1nTlLf3oIpjr9Yctu+Gl3US/O6/Uq9p/Rh3c7X3ztLGKp79D7SImlOCPRUIu5qDgRACvm
        y5+GAgAA
X-CMS-MailID: 20201013122030epcas5p2e576d5a2ebfaf9df8078e6ee70f3765c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201013122030epcas5p2e576d5a2ebfaf9df8078e6ee70f3765c
References: <CGME20201013122030epcas5p2e576d5a2ebfaf9df8078e6ee70f3765c@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

_setup_req(..) never returns negative value.
Hence the condition ret < 0 is never met

Signed-off-by: Surendran K <surendran.k@samsung.com>
---
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

