Return-Path: <dmaengine+bounces-4368-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C310CA2E447
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 07:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AF63A4AE8
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 06:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5801AF0AF;
	Mon, 10 Feb 2025 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J7jBVAqN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CE1ADC6C
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169800; cv=none; b=Tw1FeUZDgV8m4JU590hb0Eq2GAhDMiIxUCsnw2jpTm9BU3m7BvElgGWryuKeaJaUS+Bo0HSXFWTq9TVNxHgfNVnzsdnIdOdFPaE8dtFAFSqYY664OVg4DS3M5HFpZbIHYGaTR3xvTY4sajzuGAUi0Bb7ivSf/qNIStUZqG6e7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169800; c=relaxed/simple;
	bh=5u7F+siDxk1smDwLaUSKmW7d8GLaEqp1WdRO58GibIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=HbyWpRWHhyokyFoT04PamIMMfmBS1tgj5t+mJTAPcrLcasbrFkw0XUA9mKZC6xq818eadSB1Qe6dThriA8oD50H3KT1FYivI+3v8Dns8SSFQ5r5FThbtm+BELiosplP9YP1Kx0JcsVh+Qs8ICuiob6t0/AIRY/BlNSKwD3dFuzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J7jBVAqN; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250210064309epoutp03fe6024b31057aeeb34b338598528817a~ixbWIbHiR1778217782epoutp03E
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 06:43:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250210064309epoutp03fe6024b31057aeeb34b338598528817a~ixbWIbHiR1778217782epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739169789;
	bh=3T7XYBocWY+Y/TDydYiw5WG4u/h9PVvQeHolIgWGmXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7jBVAqNMbbt+2U6xFiaDz5iW4jdUL3j922R/DRobncV/vFICyAUZxNzgjE2r5Tqx
	 5BKkLRr3TiGtu92sBoS71UkGQm5Rv2R31ZN5U/VqjRgDC9N55jMPnHebuwDoBLJFkd
	 eHUzteERAJDZyk31e/br1ba3IZs7X3e5PL3FFm9E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250210064308epcas5p2039b65679c2c8ba704d46cf0ee1f27f5~ixbVi9X7o1042710427epcas5p2g;
	Mon, 10 Feb 2025 06:43:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Yrw4q3bwxz4x9Q7; Mon, 10 Feb
	2025 06:43:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.CE.20052.BFF99A76; Mon, 10 Feb 2025 15:43:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250210062247epcas5p4ce208ba2806454c48a68ef25d0a326cc~ixJkOPrPR1469314693epcas5p4i;
	Mon, 10 Feb 2025 06:22:47 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250210062247epsmtrp1d63fc403e886d68da5cfad2ac07a119a~ixJkNiStL0980809808epsmtrp1T;
	Mon, 10 Feb 2025 06:22:47 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-9c-67a99ffbf583
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.FB.18949.73B99A76; Mon, 10 Feb 2025 15:22:47 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250210062246epsmtip2fd17ed49e083b0a14f8a81cefa88e69b~ixJjLDmQc1523415234epsmtip2g;
	Mon, 10 Feb 2025 06:22:46 +0000 (GMT)
From: Aatif Mushtaq <aatif4.m@samsung.com>
To: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pankaj.dubey@samsung.com, aswani.reddy@samsung.com, Aatif Mushtaq
	<aatif4.m@samsung.com>
Subject: [PATCH 1/3] dmaengine: Add support for 2D DMA operation
Date: Mon, 10 Feb 2025 11:49:13 +0530
Message-Id: <20250210061915.26218-2-aatif4.m@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250210061915.26218-1-aatif4.m@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7bCmlu7v+SvTDdZMkbQ4NuMjo8WhzVvZ
	LVZP/ctqcXnXHDaLRVu/sFvsvHOC2YHNY9OqTjaPvi2rGD0+b5ILYI7KtslITUxJLVJIzUvO
	T8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB2qukUJaYUwoUCkgsLlbSt7Mp
	yi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM540rmdvaBPrGLe8ePM
	DYxzhboYOTkkBEwkbjy6xtjFyMUhJLCbUWLhuiY2COcTo8Sau/PZIZxvjBJnHu9hg2np/veT
	GSKxl1Fi6t4dTCAJIYEvjBIbl9qD2GwCWhI7z51jBLFFBPwl3k5eCNbMLBAncenycnYQW1jA
	QeL318tgNouAqsT9N3fBangFLCWmL7oJtUxeYvWGA8wgNqeAlcSaY2/BLpIQ2MQu8WLSfSaI
	IheJbRv2skLYwhKvjm9hh7ClJF72t0HZyRI33++DsnMkJixcDWXbSxy4Moeli5ED6DhNifW7
	9CHCshJTT61jgriZT6L39xOoVbwSO+bB2EoSa973Qd0pIfHv4ElGCNtD4vCTv9Bg7GWUmPfj
	LvsERrlZCCsWMDKuYpRMLSjOTU8tNi0wzEsth8dacn7uJkZw2tLy3MF498EHvUOMTByMhxgl
	OJiVRHhNFq5IF+JNSaysSi3Kjy8qzUktPsRoCgzAicxSosn5wMSZVxJvaGJpYGJmZmZiaWxm
	qCTO27yzJV1IID2xJDU7NbUgtQimj4mDU6qBaf6mv2YFHeyvfsZLSlfwMr94MePl1d0tF+eq
	lmdc1YuzbY+5oH1nT/fyP20tB2u3hl6onlvJp5mVHCpw8OZU1X9iSZUq912CNorc/H98/l/j
	cJWF8W3PK+/avsiauD5rl0flg5I8N+GPr3lt6qojpla/rrl+7LlsnG3llZ7ezd0+sl7PoosN
	BZaznTU7uXWC8lSbPbfF/k6bslxQ8UNPUf4GG/FjFb9y5rhozPd8ovE5eXPl0isqnct3a918
	q2ZQvbhM8auKX46FS/7/Ozvrps7hvb6qI2PH2o/7L33mmON78Yab8VadWapSNW0+uXJJ7p29
	grOMfu6NKz7DMGvetHn9u1/oLCmJrRPaq3DrmRJLcUaioRZzUXEiAGUnFk7kAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42LZdlhJXtd89sp0g2kLNC2OzfjIaHFo81Z2
	i9VT/7JaXN41h81i0dYv7BY775xgdmDz2LSqk82jb8sqRo/Pm+QCmKO4bFJSczLLUov07RK4
	Mp50bmcv6BOrmHf8OHMD41yhLkZODgkBE4nufz+Zuxi5OIQEdjNKHNv0nBUiISHR3NnIBGEL
	S6z895wdougTo8Tqd6dZQBJsAloSO8+dYwSxRQQCJdY3fAaLMwskSGzYdpAdxBYWcJD4/fUy
	mM0ioCpx/81dNhCbV8BSYvqim2wQC+QlVm84wAxicwpYSaw59hasXgio5vWh3ewTGPkWMDKs
	YpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDiwtrR2Me1Z90DvEyMTBeIhRgoNZSYTX
	ZOGKdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK83173pggJpCeWpGanphakFsFkmTg4pRqYsu73
	Lj1gWhu0iXNSsBiH8XGGn+ah8mx/H1RYsd1I7Wn/YN7w3PncDalFlg27r1jXTYwXTH/528np
	w96NqvkbfvJ+uehn8adBcKveN0vBwlUV2RumJl2tvpq1i9vg4OTd8+5eYrQ+ffLqS6kPnw2C
	+yUNluu0BkjnLV1xdj1jjtyeCfl7r61q8bnXb6DB2D3hrcPOqsgl/1UvV5pZiYln3xBur1U1
	P2kjU8olqJKal6dzfdXZcwbrH9cvVZHj+Nz1f/nLbZYPXvDkFSV5m1fv7Jn/j6fpvmOqyZm2
	TW5O69Yvrb7+/JJ/3AJjebF9TbYlO202HPMre3Kl+cB+g49L162/Xx7VELh6rfbbKVtdlViK
	MxINtZiLihMBOvzkXpsCAAA=
X-CMS-MailID: 20250210062247epcas5p4ce208ba2806454c48a68ef25d0a326cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250210062247epcas5p4ce208ba2806454c48a68ef25d0a326cc
References: <20250210061915.26218-1-aatif4.m@samsung.com>
	<CGME20250210062247epcas5p4ce208ba2806454c48a68ef25d0a326cc@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

Add a new dma engine API to support 2D DMA operations.
The API will be used to get the descriptor for 2D transfer based on
the 16-bit immediate to define the stride length between consecuitive
source address or destination address after every DMA load and
store instruction is processed.

Signed-off-by: Aatif Mushtaq <aatif4.m@samsung.com>
---
 include/linux/dmaengine.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b137fdb56093..8a73b2147983 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -833,6 +833,7 @@ struct dma_filter {
  *	be called after period_len bytes have been transferred.
  * @device_prep_interleaved_dma: Transfer expression in a generic way.
  * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst address
+ * @device_prep_2d_dma_memcpy: prepares a 2D memcpy operation
  * @device_caps: May be used to override the generic DMA slave capabilities
  *	with per-channel specific ones
  * @device_config: Pushes a new configuration to a channel, return 0 or an error
@@ -938,6 +939,9 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_dma_imm_data)(
 		struct dma_chan *chan, dma_addr_t dst, u64 data,
 		unsigned long flags);
+	struct dma_async_tx_descriptor *(*device_prep_2d_dma_memcpy)(
+		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
+		size_t len, u16 src_imm, u16 dest_imm, unsigned long flags);
 
 	void (*device_caps)(struct dma_chan *chan, struct dma_slave_caps *caps);
 	int (*device_config)(struct dma_chan *chan, struct dma_slave_config *config);
@@ -1087,6 +1091,27 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
 						    len, flags);
 }
 
+/**
+ * device_prep_2d_dma_memcpy() - Prepare a DMA 2D memcpy descriptor.
+ * @chan: The channel to be used for this descriptor
+ * @dest: Address of the destination data for a DMA channel
+ * @src: Address of the source data for a DMA channel
+ * @len: The total size of data
+ * @src_imm: The immediate value to be added to the src address register
+ * @dest_imm: The immediate value to be added to the dst address register
+ * @flags: DMA engine flags
+ */
+static inline struct dma_async_tx_descriptor *device_prep_2d_dma_memcpy(
+		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
+		size_t len, u16 src_imm, u16 dest_imm, unsigned long flags)
+{
+	if (!chan || !chan->device || !chan->device->device_prep_2d_dma_memcpy)
+		return NULL;
+
+	return chan->device->device_prep_2d_dma_memcpy(chan, dest, src, len,
+						       src_imm, dest_imm, flags);
+}
+
 static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
 		enum dma_desc_metadata_mode mode)
 {
-- 
2.17.1


