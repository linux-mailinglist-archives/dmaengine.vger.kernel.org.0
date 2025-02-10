Return-Path: <dmaengine+bounces-4372-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC1BA2E5CF
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 08:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEC218843C1
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7131B87F0;
	Mon, 10 Feb 2025 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mbhag8NZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7C1BBBE5
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174004; cv=none; b=nBfCvqL947NguizwE1o8/9fyagsM73amERtnAnZf5arwN/Y1zFqwDUuRSIowNtFuzz/Wkwa6RG0tgUGFLAdE8LW420QVSxKiNVsDEBrX0urXuho2CRQmL+TprWUuIueocTMBls1o4CpUswzEdEnlVFXxUn8IbsTutbh3HsloyHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174004; c=relaxed/simple;
	bh=A/ki657tF9v7ENbEZ4a+TKB7ZFmDXEdYtlTWQIA84nM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=fTX/HnTlqcxslzBz25Cbt/iqR8xSSZrTlKkdb78TH5dudjokZLNHsBGDy3RxGDyTZGlByPDkXyslovCq58huxoyEOVvcmsG42HOow4vBhF1lz0AG2LFA+C4F9QiKswp8MbxOun2TO1fQCHHqBO+95oGWWmpyXAhf+fNkA31msgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mbhag8NZ; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250210075319epoutp030ca0b4365d8a2edc70f12fdbff340aa8~iyYnS2Tbh2379823798epoutp03R
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 07:53:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250210075319epoutp030ca0b4365d8a2edc70f12fdbff340aa8~iyYnS2Tbh2379823798epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739173999;
	bh=Ca//94l6MDde/Eqz/GvdtHuFzOw5YQ9AikyGGg0wOuw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=mbhag8NZt3B/xKenkhFrLFcnk/Hbj319UHjd1HX75g8iJ8QTMIupCo706lKk5+GWR
	 oudyhNq++NAisrNSwbfuaL7bIOgywo2Q4C/j/jyYtnuDnPS85IPCQcKyvCCJF9/VA+
	 kT7Mv5tdVS031VQ1vYtL2UOnpA6K88olRNRlpXn8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250210075319epcas5p3ce58e05166dc9e10d9d0045742a1c6bb~iyYmeRSB10708707087epcas5p3v;
	Mon, 10 Feb 2025 07:53:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Yrxdn48X8z4x9QB; Mon, 10 Feb
	2025 07:53:17 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CB.4E.20052.D60B9A76; Mon, 10 Feb 2025 16:53:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250210075317epcas5p4d7aceb8cc711e4cfcdbfe92ea2368e69~iyYkvvbDI1216212162epcas5p49;
	Mon, 10 Feb 2025 07:53:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250210075317epsmtrp2516b25a6e7fbf3ec7759585a5e2c208b~iyYkuBvwo1894918949epsmtrp2s;
	Mon, 10 Feb 2025 07:53:17 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-0f-67a9b06da116
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	94.8F.18729.C60B9A76; Mon, 10 Feb 2025 16:53:17 +0900 (KST)
Received: from INBRO001561 (unknown [107.122.12.6]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250210075316epsmtip237be9ebc2c6c5cc9fcb94dbe199e05ee~iyYjyTpjB0652006520epsmtip2f;
	Mon, 10 Feb 2025 07:53:16 +0000 (GMT)
From: "Pankaj Dubey" <pankaj.dubey@samsung.com>
To: "'Aatif Mushtaq'" <aatif4.m@samsung.com>, <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <aswani.reddy@samsung.com>
In-Reply-To: <20250210061915.26218-3-aatif4.m@samsung.com>
Subject: RE: [PATCH 2/3] dmaengine: pl330: Add DMAADDH instruction
Date: Mon, 10 Feb 2025 13:23:14 +0530
Message-ID: <05c701db7b90$d8139270$883ab750$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFsIHTrWqAe9Pu9L3iNOvGTrR8WTgI1Uy4DAa8Ik02z/727AA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTXTd3w8p0gxl9chbHZnxktDi0eSu7
	xeqpf1ktLu+aw2ax884JZgdWj02rOtk8+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUzL91W
	yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
	I7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj3o/cgja2iudLp7E0MPawdjFy
	ckgImEg0z/jJ3sXIxSEksJtR4sGMF0AOB5DziVFicyJE/BujxIF/vcwgcZCG9rlhEPG9jBJv
	/7xghnBeMEpcfDqLHWQqm4C+xLkf88A2iAjUSzS1P2QBsZkF5CSadrUwgticAlYSf9f+ZQax
	hQWcJPbs+QxWwyKgKrHl1nI2kGW8ApYSWy7zgoR5BQQlTs58AjVGXmL72znMEA8oSPx8uowV
	pFwEaMyVD94QJeISL48eAftLQqCRQ2LD3fcsEPUuEkfa5jJB2MISr45vYYewpSQ+v9vLBvGj
	j8TS3R4Q4RKJDT1LoVrtJQ5cmcMCUsIsoCmxfpc+xCo+id7fT5ggOnklOtqEIKrVJL4/PwN1
	pIzEw+alUEs9JC6cmcE4gVFxFpK/ZiH5axaSB2YhLFvAyLKKUTK1oDg3PbXYtMAwL7UcHtPJ
	+bmbGMFJUctzB+PdBx/0DjEycTAeYpTgYFYS4TVZuCJdiDclsbIqtSg/vqg0J7X4EKMpMKwn
	MkuJJucD03JeSbyhiaWBiZmZmYmlsZmhkjhv886WdCGB9MSS1OzU1ILUIpg+Jg5OqQamlZa5
	Kp+Vp6867cN77hJbcseuDNb/txQU3fcXX505T9/07seiZZN2AgPxh+bvku4pLZyLj1/w+PX0
	qrXJpe51M+Qeaf39zmyvas+86qJgvHXxzvTNr4o1+ebO6Wj1TVFoWvObZQd328rGbtNCjo/v
	nrZO7pXNXLZFMVP161E+15NM82b/WmzbtTDk9bKVG9cd9ZjvtXTF395p2bFBT25eUHO9Ll+1
	5uv3n2070yLex/6p1/+3QiW+8r+SnlP5rDeKkmHrZ8prGvkuOCgQ+evVwvO97E/lL9Y4f0o6
	v8bEmUVwlfjKrIqjqx/N+vRB4WV52vPvEYaJGdrTlPQaWAIt9m+uFTnCyvjH9tjWi3FnlViK
	MxINtZiLihMBjsQniRMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvG7uhpXpBu0LmC2OzfjIaHFo81Z2
	i9VT/7JaXN41h81i550TzA6sHptWdbJ59G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV8a9H7kF
	bWwVz5dOY2lg7GHtYuTgkBAwkWifG9bFyMUhJLCbUeL03BnsXYycQHEZicmrV7BC2MISK/89
	Z4coesYosabtFBNIgk1AX+Lcj3msIAkRgWZGiZM7r4B1MAvISTTtamGE6NjJKHHr6B1GkASn
	gJXE37V/mUFsYQEniT17PrOA2CwCqhJbbi1nAzmJV8BSYstlXpAwr4CgxMmZT1ggZmpL9D5s
	ZYSw5SW2v53DDHGdgsTPp8vAvhEBGnnlgzdEibjEy6NH2CcwCs9CMmkWkkmzkEyahaRlASPL
	KkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4BjR0tzBuH3VB71DjEwcjIcYJTiYlUR4
	TRauSBfiTUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUgtQgmy8TBKdXAJFJq
	/fme8bGTzutOMiwyCugoXvPvysHTadYfjhmJ8Rv2nMp+y22u5vy/d9+L4Ljt5y/vXGjVe1nY
	5uBmCTaHd3dlFHtlcx55l2xYnNlZXGPR/VpV8ZJxvMbOn1s+zzeerBJz8XRMhdEE7uWLfWQj
	sqM3s363De/bz3In9fHMo42NaRzRi3t+Bpma8uZ9t7zwQDfmKt96KekT/RO6lz96WO0SKrTn
	8SGd9OcP5Kz3r9CdHfnj4rbLa37XL2RrtXmQ+uLhoiS/iwxXu5VUv+gJtCnMmvTK9ArnyTvm
	iy59vth2sH3+0e0vf191mX97zeO1M3vbqoyWliyJWVSuP5GVx6zkwZ3jsUK2P568Kfz0P0iJ
	pTgj0VCLuag4EQCav+mZAAMAAA==
X-CMS-MailID: 20250210075317epcas5p4d7aceb8cc711e4cfcdbfe92ea2368e69
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250210062254epcas5p1d463b3ce009ea29f5291fc27954103e7
References: <20250210061915.26218-1-aatif4.m@samsung.com>
	<CGME20250210062254epcas5p1d463b3ce009ea29f5291fc27954103e7@epcas5p1.samsung.com>
	<20250210061915.26218-3-aatif4.m@samsung.com>



> -----Original Message-----
> From: Aatif Mushtaq <aatif4.m@samsung.com>
> Sent: Monday, February 10, 2025 11:49 AM
> To: vkoul@kernel.org; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: pankaj.dubey@samsung.com; aswani.reddy@samsung.com; Aatif Mushtaq
> <aatif4.m@samsung.com>
> Subject: [PATCH 2/3] dmaengine: pl330: Add DMAADDH instruction
> 
> Add support for emitting DMAADDH instruction.
> Add halfword instruction adds an immediate 16-bit value to the source
> address register or destination address register for the DMA channel
> thread. This enables the DMAC to support 2D DMA operations.
> 
> Signed-off-by: Aatif Mushtaq <aatif4.m@samsung.com>
> ---

Looks good to me.
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>


