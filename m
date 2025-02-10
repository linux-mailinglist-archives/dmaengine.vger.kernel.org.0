Return-Path: <dmaengine+bounces-4367-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E3BA2E444
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 07:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49B51887967
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 06:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591C1A3159;
	Mon, 10 Feb 2025 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iPfNgLbT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4CE1925BF
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169795; cv=none; b=ek2LO1prYRgEDX35muUDBjM1hTUttYg72AR5VbU2sk2u2fdw3XSqUzOgBEgfO8NtssbCtDaHgnG7u6pF7jcAp5y6fcGA/+LrQpmiDuQ41G9Nhw3P7opYSAjznH7e5zOwwnrLGovQ7v6WkEMMrCJSkwuXGM7RlmTuh31l98xt8N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169795; c=relaxed/simple;
	bh=u29kw3PAt2/TVlFJvlq+qdiGnInsbi4kZ70cRUTk6cc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=GGrp0fd8k3Oe+rBlLCityXxw2HiRDJnkRNIC2ELEf1hIQd7XpcYKXlSOjjaZ1X3I2Nib2wMUyYY0W6pPNA7QL5Hbfmrcx6D+PtodC+6shoawBNFYe6xBZ61lzaDg9gczzE3IpFfE48M1cMw39OZ+U13NKymNN0f0noGdKVLzeTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iPfNgLbT; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250210064305epoutp04a5c8f4bce1b7d5bd3a35b0288d7f62c7~ixbSBpQ6s1657916579epoutp04G
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 06:43:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250210064305epoutp04a5c8f4bce1b7d5bd3a35b0288d7f62c7~ixbSBpQ6s1657916579epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739169785;
	bh=k8uc0/TsrBMb+gRemsPGa/jXjlbqOddYaCgtcQXT+Z0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=iPfNgLbTSGThGAlIxBWjxJ7E742/xWVZCvjQoOraII24DW61UO6Y2YXxYoTs3rENs
	 O2/569iNG9Bac/j4WddrwAgWPx37vYs77nDP3P/kGIzblQq5cJJie4faZ5la1RHW0D
	 vaupUq8wHvzdRbdwPzRp1crcAIifbyNDe9J5SVZ8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250210064304epcas5p1d14d48b6369da50dba6e7bde5ddeeca9~ixbRgnLQZ3041530415epcas5p10;
	Mon, 10 Feb 2025 06:43:04 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Yrw4l0NbWz4x9Q3; Mon, 10 Feb
	2025 06:43:03 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.28.29212.6FF99A76; Mon, 10 Feb 2025 15:43:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250210062219epcas5p4695fe63e9ba36c19a640504f95dc3f12~ixJJ_ry7J2370323703epcas5p4x;
	Mon, 10 Feb 2025 06:22:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250210062219epsmtrp101d4d50107ad574e20e9a0a622c7bfbd~ixJJ91UjG0978209782epsmtrp1s;
	Mon, 10 Feb 2025 06:22:19 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-2d-67a99ff63ee1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	38.AC.33707.B1B99A76; Mon, 10 Feb 2025 15:22:19 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250210062218epsmtip27c7a3c48a6528a6f4a58ef0accda9c3d~ixJJDdRBM1525115251epsmtip2D;
	Mon, 10 Feb 2025 06:22:18 +0000 (GMT)
From: Aatif Mushtaq <aatif4.m@samsung.com>
To: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pankaj.dubey@samsung.com, aswani.reddy@samsung.com, Aatif Mushtaq
	<aatif4.m@samsung.com>
Subject: [PATCH 0/3] Add capability for 2D DMA transfer
Date: Mon, 10 Feb 2025 11:49:12 +0530
Message-Id: <20250210061915.26218-1-aatif4.m@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7bCmlu73+SvTDXYKWxyb8ZHR4tDmrewW
	q6f+ZbW4vGsOm8WirV/YLXbeOcHswOaxaVUnm0ffllWMHp83yQUwR2XbZKQmpqQWKaTmJeen
	ZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCtVVIoS8wpBQoFJBYXK+nb2RTl
	l5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ/z7OZGlYCdLRf+6d8wN
	jKeZuxg5OSQETCRePNjE1sXIxSEksIdRYuP6F1DOJ0aJl1OOssI5dy59YIFpudSzFqpqJ6PE
	uQOLmCGcL4wSd9cuZwKpYhPQkth57hwjiC0i4C/xdvJCNhCbWSBO4tLl5ewgtrCAucTHz9/B
	prIIqEpMP/YfrJdXwFLixIVdUNvkJVZvOAB1bD+7xOzb3hC2i8Tef1PYIGxhiVfHt7BD2FIS
	L/vboOxkiZvv90HZORITFq6Gsu0lDlyZAzSfA+geTYn1u/QhwrISU0+tY4I4k0+i9/cTJog4
	r8SOeTC2ksSa931QayUk/h08yQhhe0g8e9AFNlJIIFZi1fuqCYyysxAWLGBkXMUolVpQnJue
	mmxaYKibl1oOj6jk/NxNjODUpBWwg3H1hr96hxiZOBgPMUpwMCuJ8JosXJEuxJuSWFmVWpQf
	X1Sak1p8iNEUGGQTmaVEk/OByTGvJN7QxNLAxMzMzMTS2MxQSZy3eWdLupBAemJJanZqakFq
	EUwfEwenVAMTf6/5I4OOz+vfTOr+cbQg9/iFmce4N0lPPZuctdrMtY1/Rzy/+tLH9X/y3rTZ
	TE+aH2J0lDXBjc1gdV5nwLH7zglbCqv223+ZkcaxMoft1QG+Z5KiB5TMvhk9mvW07OHJ/mtr
	9pckrTdcN+Fn1tbHua2Le1bnFrXoBHuGbt81Szbo4qzQ7zoZVmZ6WzmDFp/R+LLoxxG3r6ef
	nbmyQ2BZdF6876HtCj1HHJO1V1yZfTI5b9aWvPbZX0Mur/KI2T9BNNta/6FY5MQTKV4Pj9ye
	/f3+xEO7NUUUb8/gYav6ecqryDpMdnWX5Ld3t6zTZlQFH4080pKvdoBFR9N96hSz3guP32u7
	HnESeMyps+NquBJLcUaioRZzUXEiAF9gMeLWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJMWRmVeSWpSXmKPExsWy7bCSvK707JXpBicPK1gcm/GR0eLQ5q3s
	Fqun/mW1uLxrDpvFoq1f2C123jnB7MDmsWlVJ5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVw
	Zfz7OZGlYCdLRf+6d8wNjKeZuxg5OSQETCQu9axl62Lk4hAS2M4oce3jL1aIhIREc2cjE4Qt
	LLHy33N2iKJPjBJ//xwBS7AJaEnsPHeOEcQWEQiUWN/wmQXEZhZIkNiw7SA7iC0sYC7x8fN3
	sDiLgKrE9GP/wXp5BSwlTlzYxQKxQF5i9YYDzBMYeRYwMqxiFE0tKM5Nz00uMNQrTswtLs1L
	10vOz93ECA4QraAdjMvW/9U7xMjEwXiIUYKDWUmE12ThinQh3pTEyqrUovz4otKc1OJDjNIc
	LErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGptUr5hk0ivxpkZeTZZy+cD+7St72ez+P6EVt
	uOSpKqxwefPWvgdbE/fsLJphs1fa9JdgROI8vam/vEoqnWTi/z21rFMvsNt/5pXRkeK3fx0m
	PizsFTtyc5ey9ANbORu2xIq817U7rmXdvJSwMOTXwfO1K7tT40RZkv/EW1lllvhPvemhmPoz
	+oFvSIbBa83//islzk6I5V9cbPxCSrvklpavqXzKRK7VxbIuizMa8jJmn47k613v9yWMZUfy
	QXnrlbsOLf37okLyAK+l86w//5gk1XcvnKqwMsPE3DCSpd8rkL32zK9jK7l/JYk6x2+S6Rfc
	3BhxO9vqPO8Do3KhnqVTIj+L37adfPtD2/0WJZbijERDLeai4kQAsAZGPX8CAAA=
X-CMS-MailID: 20250210062219epcas5p4695fe63e9ba36c19a640504f95dc3f12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250210062219epcas5p4695fe63e9ba36c19a640504f95dc3f12
References: <CGME20250210062219epcas5p4695fe63e9ba36c19a640504f95dc3f12@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

Add support for add halfword instruction to pl330 driver to achieve
2D DMA operations. Add a corresponding dmaengine API to prepare the
DMA for 2D transfer and create a hook between the dma engine and pl330
driver function.

Aatif Mushtaq (3):
  dmaengine: Add support for 2D DMA operation
  dmaengine: pl330: Add DMAADDH instruction
  dmaengine: pl330: Add DMA_2D capability

 drivers/dma/pl330.c       | 44 +++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h | 25 ++++++++++++++++++++++
 2 files changed, 69 insertions(+)

-- 
2.17.1


