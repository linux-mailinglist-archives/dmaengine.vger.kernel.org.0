Return-Path: <dmaengine+bounces-6425-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3520B47B03
	for <lists+dmaengine@lfdr.de>; Sun,  7 Sep 2025 13:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B68200E8D
	for <lists+dmaengine@lfdr.de>; Sun,  7 Sep 2025 11:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D07262FE7;
	Sun,  7 Sep 2025 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="gpX0Kz92"
X-Original-To: dmaengine@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE411DF26A;
	Sun,  7 Sep 2025 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244891; cv=none; b=Qd5euHDySbpBWXEjFqF6I3ZTVgre1vQ0uGh/8aqAIlFzz3uB40AMOGj1xTY9v8+LvWSvCeJw2p47Rt4UYF/HDb1pMVyqLcJvRxMhQMx7EFj/jgJvAmlxnDOhDO0zW+CrACoLnD2Bcb90qp4LZssU1YarN6e8O3J3m4W/LC5SfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244891; c=relaxed/simple;
	bh=gnR1bN4f585sAR+aIfz3xySKJKZ+0Tyw9oY35sth0I4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LLbGk1DXijNKOGILSpOWynm0sJZxRper7OKeXMSrOEkG4RtmesHWt2Lq/F4AnWGEOh9Mu+1eWGalS3UT74EBukD3ZosilRxavijYv5hChZVgC3sa1eEmPG/T5Pd2nuIZ00/pAdhrLX7mm8QJW9Os0cB6SdKdFxgbChZx/LL4a6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=gpX0Kz92; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1757244576;
	bh=vzMRSNquciMXGu8CwgqTnQ8mVrWWx/y+NRlacn/1wyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gpX0Kz92uA1Mx0JBMdS/8NHzjh58U/0VC8ty7W8TWk4kS12/2lYDWTo3sZBRPoFik
	 hhP8x9cwOeJsQMb8jRHv2NBB1E0R0QVZpcFTobId3sZNqKPXHx4Ghr66IjOok6+Dgm
	 yA02bdcJic00SOz/NzqOfN03nG+ugQj5zP0s2XHY=
Received: from localhost.localdomain ([112.94.75.165])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 7600DAF8; Sun, 07 Sep 2025 19:29:32 +0800
X-QQ-mid: xmsmtpt1757244572tiwo0mr9c
Message-ID: <tencent_D434891410B0717BB0BDCB1434969E6EB50A@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70eRbmROUPgRD86B27m0zZS/8QeMF6JS3ThHIw8thwK6p/sqceBs
	 av9KAoRa2Ct7uRJVzAWFPI90ILgEDmvNQFENGJSZJ6U8cH7JcdjG8Tw+em2tMVimWrrY1cUiDfh/
	 qGRaWja5RRxYOSiMJccrTZDceLExojZpKNksm+flljSZmLdtu3fvXunwQ8Y82XB6RlFQu9b/gifS
	 CbRpRg1woMJ7n0JL2WUVhKGwRVn5VOm9FOIV9ZsDXqc0srbqMl5o51d8hQheGkzRkXF5JxrO9uIN
	 1gN6JgYWPZjkSMqlrt4DqTbb5SFjBtoM0XghRwwaLnhR/0desDuqqVDsLFaYm61RVL9m2FOx4N24
	 7hZ4lRSn5yGCAMSgG290RHmRzO9L5a4oEYSP4zuFvZjLgwh0c6Ot+0LoW5mSavxlgs9iUln3akex
	 /aTTX1Sl6buy9HIbE3HVD9rqSF83ZI1fb/DhbT21BgQXUxnuDOUKyJoDYqgFakh/HTG3ZLiSOVab
	 tj1n6f8uAAe1f5QAaTdi+DgpETiXDmdW5vZxTXGB5d2tkjhWaD1qkXA7e1caer76+h3iIgOzbpBp
	 JCT8Z7VG3a3gtgj7MWDmi6Dt90DpqQj0y5421NLDVhh5hsDNDfnLp/qPXZx8+c5SO7/T8OP/OW0O
	 Q7FUZtYfZ1UUZpm9R/Xo7aIT5JqOE5toCa7v6OVTHK2VL3ZnseppQSbtIvpYgtWiP+33diVqEF5C
	 PIVKrr307Fo5UBP1CxBUSy/Qcbma3JzutaC1mpcpq1ovWZxR4FL2XvR3Pl8q5o0u2gwG5c3Co8Su
	 9x7tcDvss9sdBeHQucrrzCYCGOJ1uOeMm16sJVJe3dIbXsQ6jVcfiRrJ4z4c73xDlt7JgekAlVBr
	 PtJZ1jZW+8PY9nCbbfvteiqnXD7Gf+SN3qzh0jBMCTd4ebm+t8CG6SvKTU1UhIWMQJBpxLgOOZVs
	 nvTL8+tvm/wRBk73kdGH4TKBzp9NzgfqUA7dXSF1HJVWK4E0opxgUk8GErQxRpXR6s/Z/DLwCNxm
	 g/JnTJuxupUW4ISqu6
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Conley Lee <conleylee@foxmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	wens@csie.org,
	mripard@kernel.org,
	vkoul@kernel.org
Cc: netdev@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conley Lee <conleylee@foxmail.com>
Subject: [PATCH] net: ethernet: sun4i-emac: free dma descriptor
Date: Sun,  7 Sep 2025 19:29:30 +0800
X-OQ-MSGID: <20250907112930.712212-1-conleylee@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250904072446.5563130d@kernel.org>
References: <20250904072446.5563130d@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation of the sun4i-emac driver, when using DMA to
receive data packets, the descriptor for the current DMA request is not
released in the rx_done_callback.

Fix this by properly releasing the descriptor.

Fixes: 47869e82c8b8 ("sun4i-emac.c: add dma support")
Signed-off-by: Conley Lee <conleylee@foxmail.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 2f516b950..2f990d0a5 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -237,6 +237,7 @@ emac_alloc_dma_req(struct emac_board_info *db,
 
 static void emac_free_dma_req(struct emac_dma_req *req)
 {
+	dmaengine_desc_free(req->desc);
 	kfree(req);
 }
 
-- 
2.25.1


