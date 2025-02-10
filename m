Return-Path: <dmaengine+bounces-4370-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C98A2E44A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 07:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB881888954
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05601ADC9B;
	Mon, 10 Feb 2025 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W6IU2rPj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1CB1ADC86
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169803; cv=none; b=kT2mE3dlvSuNTMgR6FwHcQ+IeBepiO1527iiquKR9DvQj56Q1yAnKOpgt4LCJ0R8dXZPY7O8zk7HwG9fDrWDEPNnvNnGbYnMTqe1QHLGFxCjpG30poO12eM2Y0DZU7lhucUyraIYyqJVUd6/ULYVr87LwfzuIEFZ8s31fbS3To4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169803; c=relaxed/simple;
	bh=9mDFLvucuaDifFxb+HT9HMKh7P6pf7kmEhDjJvF9a6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=qTC33e3XgNT9BWAcAVIO3sskZeFAOJLpF72LdLnVeLJ7bsjocQfm4tz6pHKIqRCsGq/MM+o7Af3SCKHfC1M60DID+HiXIROFAgZx3qGIxfeNlLJPP8AXBwyKOLo4FL16u5Ce7GY8+085ADIdlTs4XTTSH4YU4WzafxMFR5CHBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W6IU2rPj; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250210064319epoutp0263aa919c89e36574a1c0e9e158918bcc~ixbfUzceA2975429754epoutp02J
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 06:43:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250210064319epoutp0263aa919c89e36574a1c0e9e158918bcc~ixbfUzceA2975429754epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739169799;
	bh=Ua+YeT0LSOY7afcADYsqXqftnGnbvD+rsIeK21OzCIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6IU2rPjJjL76v3/aIvbea2J+t1c3ixzkd/hmhZvwfPQC406y66IgBR3NNiUDDwa4
	 AsJRIJLoAt6AzzyWILH7NueEjibzg/ceFiE5sEIqgR6aCHBNx0dd6ywgpNnFiH1Itz
	 6CKQxnChJNM2shu3ht9ZNthB5Pcir72Vf6KT9iEw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250210064316epcas5p363a8a015ac24f57517436022657d9549~ixbcTXa7z2234622346epcas5p3l;
	Mon, 10 Feb 2025 06:43:16 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Yrw4y4GB1z4x9Q3; Mon, 10 Feb
	2025 06:43:14 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5A.99.19956.200A9A76; Mon, 10 Feb 2025 15:43:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250210062258epcas5p195b96f374fa9ce1802ec4d1c1e73f69c~ixJuZ_bSJ3185031850epcas5p1B;
	Mon, 10 Feb 2025 06:22:58 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250210062258epsmtrp2b1ea8e324c732f2c8c4d8c0324be61c7~ixJuTSrqw3016530165epsmtrp2v;
	Mon, 10 Feb 2025 06:22:58 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-74-67a9a00263d4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9D.B4.23488.24B99A76; Mon, 10 Feb 2025 15:22:58 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250210062257epsmtip26da7f5dc4c1b6694295a3c564c9b2e08~ixJtTD4Gf1439214392epsmtip2h;
	Mon, 10 Feb 2025 06:22:57 +0000 (GMT)
From: Aatif Mushtaq <aatif4.m@samsung.com>
To: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pankaj.dubey@samsung.com, aswani.reddy@samsung.com, Aatif Mushtaq
	<aatif4.m@samsung.com>
Subject: [PATCH 3/3] dmaengine: pl330: Add DMA_2D capability
Date: Mon, 10 Feb 2025 11:49:15 +0530
Message-Id: <20250210061915.26218-4-aatif4.m@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250210061915.26218-1-aatif4.m@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7bCmpi7TgpXpBtMXclkcm/GR0eLQ5q3s
	Fqun/mW1uLxrDpvFoq1f2C123jnB7MDmsWlVJ5tH35ZVjB6fN8kFMEdl22SkJqakFimk5iXn
	p2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VVSKEvMKQUKBSQWFyvp29kU
	5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGf8O3WHvWA6T8X13f+Y
	GxiXcnUxcnJICJhILDi0ir2LkYtDSGA3o8SeswuhnE+MEluXvmSDcL4xSiyatogdpmXVgmNM
	EIm9jBJPG09COV8YJe43vgerYhPQkth57hwjiC0i4C/xdvJCNhCbWSBO4tLl5WA1wgI2Es+P
	rAOzWQRUJTbeXwZm8wpYSsx9cIsZYpu8xOoNB8BsTgEriTXH3oLdJyGwjl3ifOttqCIXiWkv
	2qDOE5Z4dXwLlC0l8fndXjYIO1ni5vt9UPEciQkLV0PZ9hIHrsxh6WLkADpOU2L9Ln2IsKzE
	1FPrmCBu5pPo/f2ECSLOK7FjHoytJLHmfR/UeAmJfwdPMkLYHhLtKxZDw7GXUWJ15y+2CYxy
	sxBWLGBkXMUomVpQnJueWmxaYJyXWg6PtuT83E2M4MSl5b2D8dGDD3qHGJk4GA8xSnAwK4nw
	mixckS7Em5JYWZValB9fVJqTWnyI0RQYgBOZpUST84GpM68k3tDE0sDEzMzMxNLYzFBJnLd5
	Z0u6kEB6YklqdmpqQWoRTB8TB6dUAxPX64aN/ZHrGqMmnl0awFN+K2tp7bIQg9U3jSR9Js0I
	NP+j2yO5mO/i22NH57FVnTJljt6Uf+vsf0ZPpujLJhGS3rM3vC/Y8EpTynp5ZVV9mmms1tZn
	XjpKc0RPvXzH3r6mP2znXee+dtlIztNPhc2z/1//57RuzSVhYfs3UjukZCckrGzICN84JWHi
	c9era7+dC5m0t+GtvGNvnVXoROPLBe+ZpfvS7nFs+9ssIDL9cJNOUX6W5J5Dtf3Mn5/YZuyI
	nShlesRY/pJjTHRMYpXILN0pHDrMZ+ueGvWfrl+5aJ8Y3532v9V/rnOln537QlTC6Pzz9e9j
	j3jsX5r8+qvVpDWcz/h3eIuvS7ET3aTEUpyRaKjFXFScCABvbzZV5QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42LZdlhJXtdp9sp0g9VTZCyOzfjIaHFo81Z2
	i9VT/7JaXN41h81i0dYv7BY775xgdmDz2LSqk82jb8sqRo/Pm+QCmKO4bFJSczLLUov07RK4
	Mv6dusNeMJ2n4vruf8wNjEu5uhg5OSQETCRWLTjG1MXIxSEksJtRYtPtKcwQCQmJ5s5GJghb
	WGLlv+fsEEWfGCXefljKDpJgE9CS2HnuHCOILSIQKLG+4TMLiM0skCCxYdtBsBphARuJ50fW
	gdksAqoSG+8vA7N5BSwl5j64BbVMXmL1hgNgNqeAlcSaY2/BaoSAal4f2s0+gZFvASPDKkbJ
	1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4MDS0tjB+O5bk/4hRiYOxkOMEhzMSiK8JgtX
	pAvxpiRWVqUW5ccXleakFh9ilOZgURLnXWkYkS4kkJ5YkpqdmlqQWgSTZeLglGpgsmWYUD3r
	l7Z9xZz5Of+5W11q4zd7/djb+mJmQMazxdLsra67jq37d2VNikP6vf8Ty3ntWFlDY8UTDH5f
	fdNw57b7EaYjUn+qHDq3rO/0vh7skJ3ztba1XqD9+o5ERZ3n9dwmwRVt6yJnHtmRMK01mUlA
	YLK1g4Y+1zf1+CD/TYUzT62LtqiZqHppOsv0iydXPs54Vvb7j7r2/qz9b+dp/phpzLHYd9PV
	x8+eFPvG9iSEv2B6X7dcy7n9Z/VMH29pobxF8ziEZn/IZnoa5C1Sntz9+kOx0x0N5lA240me
	NyQCF82PZJ1TpP/KSVzNq93nWrBI9Y9wbwV1BU5ruz8rr/n/rr8loCLVd8jrFrMSS3FGoqEW
	c1FxIgCCIPuFmwIAAA==
X-CMS-MailID: 20250210062258epcas5p195b96f374fa9ce1802ec4d1c1e73f69c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250210062258epcas5p195b96f374fa9ce1802ec4d1c1e73f69c
References: <20250210061915.26218-1-aatif4.m@samsung.com>
	<CGME20250210062258epcas5p195b96f374fa9ce1802ec4d1c1e73f69c@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

Add a capability to prepare DMA for 2D transfer and create a hook
between the DMA engine and the pl330 driver

Signed-off-by: Aatif Mushtaq <aatif4.m@samsung.com>
---
 drivers/dma/pl330.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 546ea442044e..ac17657413b5 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2847,6 +2847,23 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	return &desc->txd;
 }
 
+static struct dma_async_tx_descriptor *
+pl330_prep_2d_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
+		dma_addr_t src, size_t len, u16 src_imm,
+		u16 dst_imm, unsigned long flags)
+{
+	struct dma_pl330_desc *desc;
+	struct dma_async_tx_descriptor *tx;
+
+	tx = pl330_prep_dma_memcpy(chan, dst, src, len, flags);
+	desc = to_desc(tx);
+
+	desc->px.src_imm = src_imm;
+	desc->px.dst_imm = dst_imm;
+
+	return tx;
+}
+
 static void __pl330_giveback_desc(struct pl330_dmac *pl330,
 				  struct dma_pl330_desc *first)
 {
@@ -3157,6 +3174,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
 	pd->device_free_chan_resources = pl330_free_chan_resources;
 	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
+	pd->device_prep_2d_dma_memcpy = pl330_prep_2d_dma_memcpy;
 	pd->device_prep_dma_cyclic = pl330_prep_dma_cyclic;
 	pd->device_tx_status = pl330_tx_status;
 	pd->device_prep_slave_sg = pl330_prep_slave_sg;
-- 
2.17.1


