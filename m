Return-Path: <dmaengine+bounces-4369-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E092BA2E448
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 07:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7346C162F05
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 06:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4505C1AF0D7;
	Mon, 10 Feb 2025 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o795g0Kn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306381ADC86
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169801; cv=none; b=bZ4VCquqGj0wcVm1xa5VpDscV2vLox24JK8l0jxL/tDmcat+owToI3qNM89T304+6bJWFdqDGVQ3ihGOd5VFSPnWz/lN2ZJdjFUmamoCTy9wownOvlOxGT3+GkvEj6egv2iDxy5/91wqXGUWfZ6kYEXyDBu0indJfW7kcfbUpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169801; c=relaxed/simple;
	bh=N7qcxjEKJMGvZ19C9JTGbapJx4lfcfUzpdhsTrWfklM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=Y8UePsV6035+3/a2n9IkTO9gKumzrjhVcxvXc2c10rcCHmSHWybng2AP5WaonmKey1nntDnJl8YzrNG5KdAtRhqLk2IFDljExCVvVUnew5dj/PEnCcGLS6U6U/j2VX/5il2SVlc0yZXmO9WhxG9LJSZQR1BonvGlntgFhaeT4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=o795g0Kn; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250210064312epoutp03c861e7118f199aca45fa71f5636db2e8~ixbYicPML1775617756epoutp03H
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 06:43:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250210064312epoutp03c861e7118f199aca45fa71f5636db2e8~ixbYicPML1775617756epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739169792;
	bh=I6kXYvqWMdpi0+2JDXDckaXE3fUbCTy1ikxu5HxqnOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o795g0KnQLdm7zMDEYeL/nMvF7Ce6zqle6WCkmro84gzIwPPxZOMD2oJH2xlNNMdi
	 lxubbFkDGrfEev7SSiKRnNQ1i1RoWsf+zV/vVfa+65s+UhHMTBHfxV9d5KaBAqoyaJ
	 vD6HCq2GiuSnFsCDWaKrvcAjzPD435e2BXcjaIZU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250210064311epcas5p44c20a1506b35592ee2c0de6c1e1836aa~ixbYQy6r11998419984epcas5p4r;
	Mon, 10 Feb 2025 06:43:11 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Yrw4t480yz4x9Q8; Mon, 10 Feb
	2025 06:43:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F6.F6.19933.EFF99A76; Mon, 10 Feb 2025 15:43:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250210062254epcas5p1d463b3ce009ea29f5291fc27954103e7~ixJqHa7p_1000110001epcas5p17;
	Mon, 10 Feb 2025 06:22:54 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250210062254epsmtrp262edfa85b0030afe0adbd9eaf55a9157~ixJqGwC3p3016530165epsmtrp2i;
	Mon, 10 Feb 2025 06:22:54 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-62-67a99ffe822b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.B4.23488.D3B99A76; Mon, 10 Feb 2025 15:22:53 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250210062253epsmtip2e307c7811742829e83a5389e598e2d72~ixJpG9w5P1428414284epsmtip2h;
	Mon, 10 Feb 2025 06:22:52 +0000 (GMT)
From: Aatif Mushtaq <aatif4.m@samsung.com>
To: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pankaj.dubey@samsung.com, aswani.reddy@samsung.com, Aatif Mushtaq
	<aatif4.m@samsung.com>
Subject: [PATCH 2/3] dmaengine: pl330: Add DMAADDH instruction
Date: Mon, 10 Feb 2025 11:49:14 +0530
Message-Id: <20250210061915.26218-3-aatif4.m@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250210061915.26218-1-aatif4.m@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7bCmpu6/+SvTDT5uk7U4NuMjo8WhzVvZ
	LVZP/ctqcXnXHDaLRVu/sFvsvHOC2YHNY9OqTjaPvi2rGD0+b5ILYI7KtslITUxJLVJIzUvO
	T8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB2qukUJaYUwoUCkgsLlbSt7Mp
	yi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5o/3ieseCOQMWV709Z
	GhiX8nYxcnJICJhIzL6yn7mLkYtDSGA3o8SyxfdZIZxPjBIn7vezglQJCXxjlNjfqw7T8fnM
	CxaIor2MEtfOvWCHcL4wSnQtW8wCUsUmoCWx89w5RhBbRMBf4u3khWwgNrNAnMSly8vZQWxh
	ATuJj9MXg9ksAqoSCxa/BLN5BSwlVn48xAyxTV5i9YYDYDangJXEmmNvwZZJCGxil5hz6Scr
	RJGLxJIfEMskBIQlXh3fwg5hS0l8freXDcJOlrj5fh9UPEdiwsLVULa9xIErc4CO5gA6TlNi
	/S59iLCsxNRT65ggbuaT6P39hAkiziuxYx6MrSSx5n0f1HgJiX8HT0Kd4CFx4cwMRkig9DJK
	/P38nW0Co9wshBULGBlXMUqmFhTnpqcWmxYY5aWWw2MtOT93EyM4bWl57WB8+OCD3iFGJg7G
	Q4wSHMxKIrwmC1ekC/GmJFZWpRblxxeV5qQWH2I0BQbgRGYp0eR8YOLMK4k3NLE0MDEzMzOx
	NDYzVBLnbd7Zki4kkJ5YkpqdmlqQWgTTx8TBKdXAJO/jeO5T6bu0f/KeCscNi5ckdwk9Z2OZ
	IzKlqFuJr2GFwWTni9d+XXhYtmWp4Ouw3cLyDAc2tu14dMi0n/VFlmVLdsqxrGdb7M/2FvQz
	893/cHFbJ+da7aTaHSULp/wqy9m7vMJKJC8+JurJVF+P9ee/Rd9XcnzefWmv0MvDvx+ys998
	tqvnddlRtyR/63elPAlzGtOK73vsfdQivULwZ0bCq4eTMpIX/ctg9k95PrvFxHvq54/qLUzy
	J3e+ueTb3TrPxu3+QUevOd/05y7bWJ0j88fRal7Mv/vrdeZbbPvZaM3w4dPRdiOn9eszH4pV
	cZxYrGARzNmgvvFg0m7VmKT8NvVOoxLFWe82zd0TqMRSnJFoqMVcVJwIAGPK98PkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42LZdlhJXtd29sp0g2/HbSyOzfjIaHFo81Z2
	i9VT/7JaXN41h81i0dYv7BY775xgdmDz2LSqk82jb8sqRo/Pm+QCmKO4bFJSczLLUov07RK4
	Mto/nmcsuCNQceX7U5YGxqW8XYycHBICJhKfz7xg6WLk4hAS2M0ocf/HNVaIhIREc2cjE4Qt
	LLHy33N2iKJPjBIrZ21jBkmwCWhJ7Dx3jhHEFhEIlFjf8JkFxGYWSJDYsO0gO4gtLGAn8XH6
	YjCbRUBVYsHil2A2r4ClxMqPh5ghFshLrN5wAMzmFLCSWHPsLViNEFDN60O72Scw8i1gZFjF
	KJlaUJybnptsWGCYl1quV5yYW1yal66XnJ+7iREcWFoaOxjffWvSP8TIxMF4iFGCg1lJhNdk
	4Yp0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwrDSPShQTSE0tSs1NTC1KLYLJMHJxSDUzR75LW
	2vfNq+E45rVtkt0HG7+9h+c5Pby9uJit6u/HPyYT76/9xOvNsnrFnDkXf06cVNxsIma2JiXg
	/O9NOUe/pClmPVFl7JZcbtYaU5mZK7b6avP96av/Z2y3F/Qs8Og/v3x20jVFr/dht66UmUe5
	W5XFxJx0Wn38Y+Myl9XrVogIvPaNSU8VvH1i93/mE4//W3avW9Hw7s+t4o8eQfbv49o8hToS
	7omsS//qVGDLm+QbPZctZ/YuP6a2bZ+VJ0S1Led0jdy11cbhkqfgZtaJgdlbn0ZYiPUwuB8U
	2CNwnv1uRZ5V8tbP6gulBcqzRV//D2nJ3XWifcbb536zPi26bS1TdPLu1RVtcXM4j11SYinO
	SDTUYi4qTgQAQykP9JsCAAA=
X-CMS-MailID: 20250210062254epcas5p1d463b3ce009ea29f5291fc27954103e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250210062254epcas5p1d463b3ce009ea29f5291fc27954103e7
References: <20250210061915.26218-1-aatif4.m@samsung.com>
	<CGME20250210062254epcas5p1d463b3ce009ea29f5291fc27954103e7@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

Add support for emitting DMAADDH instruction.
Add halfword instruction adds an immediate 16-bit value to the source
address register or destination address register for the DMA channel
thread. This enables the DMAC to support 2D DMA operations.

Signed-off-by: Aatif Mushtaq <aatif4.m@samsung.com>
---
 drivers/dma/pl330.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 60c4de8dac1d..546ea442044e 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -323,6 +323,8 @@ struct pl330_xfer {
 	u32 dst_addr;
 	/* Size to xfer */
 	u32 bytes;
+	u16 src_imm;
+	u16 dst_imm;
 };
 
 /* The xfer callbacks are made with one of these arguments. */
@@ -623,6 +625,22 @@ static inline u32 _emit_LD(unsigned dry_run, u8 buf[],	enum pl330_cond cond)
 	return SZ_DMALD;
 }
 
+static inline u32 _emit_DMAADDH(unsigned dry_run, u8 buf[], enum pl330_dst ra, u16 imm)
+{
+	if (dry_run)
+		return SZ_DMAADDH;
+
+	buf[0] = CMD_DMAADDH;
+	buf[0] |= (ra << 1);
+	buf[1] = imm;
+	buf[2] = imm >> 8;
+
+	PL330_DBGCMD_DUMP(SZ_DMAADDH, "\tDMAADDH %s %u\n",
+			ra == 0 ? "SA" : "DA", imm);
+
+	return SZ_DMAADDH;
+}
+
 static inline u32 _emit_LDP(unsigned dry_run, u8 buf[],
 		enum pl330_cond cond, u8 peri)
 {
@@ -1097,6 +1115,7 @@ static inline int _ldst_memtomem(unsigned dry_run, u8 buf[],
 {
 	int off = 0;
 	struct pl330_config *pcfg = pxs->desc->rqcfg.pcfg;
+	struct pl330_xfer *x = &pxs->desc->px;
 
 	/* check lock-up free version */
 	if (get_revision(pcfg->periph_id) >= PERIPH_REV_R1P0) {
@@ -1113,6 +1132,11 @@ static inline int _ldst_memtomem(unsigned dry_run, u8 buf[],
 		}
 	}
 
+	if (x->src_imm)
+		off += _emit_DMAADDH(dry_run, &buf[off], SRC, x->src_imm);
+	if (x->dst_imm)
+		off += _emit_DMAADDH(dry_run, &buf[off], DST, x->dst_imm);
+
 	return off;
 }
 
@@ -2633,6 +2657,8 @@ static inline void fill_px(struct pl330_xfer *px,
 	px->bytes = len;
 	px->dst_addr = dst;
 	px->src_addr = src;
+	px->src_imm = 0;
+	px->dst_imm = 0;
 }
 
 static struct dma_pl330_desc *
-- 
2.17.1


