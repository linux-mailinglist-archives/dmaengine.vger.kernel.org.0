Return-Path: <dmaengine+bounces-4769-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E583A6D835
	for <lists+dmaengine@lfdr.de>; Mon, 24 Mar 2025 11:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F098816E5B0
	for <lists+dmaengine@lfdr.de>; Mon, 24 Mar 2025 10:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AEF2E3366;
	Mon, 24 Mar 2025 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LzLGXsvO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184F25DB1E
	for <dmaengine@vger.kernel.org>; Mon, 24 Mar 2025 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742811745; cv=none; b=AlkGhZXOUFqOJjHBcXqy1KzTjtPnDl+1mP377V3JXNwsy3YraUMOGAKgcqKvw1/gzFV4NjLrf4tfS2iGqDav+Id6lDISG/A0XuL8WKetLsd8CHwuDgLUotwhFjBJ+BH5/kbQqQ7wOyBhTwyFcYhWO+8q9h8r+F1OIr2rsPyI/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742811745; c=relaxed/simple;
	bh=7EuDp97T6eGN9Uv1l+Ew36X/SFMuxHOZbvKNx3732Fg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=KBlhS8OLRApY7/INYYkW1pvwZ1uiqc2AI/y/P08tfKX/wzjV671Uff4johpngXlWfKBm87bVzchJ89mmkOAQaOpeKgOZVrfUi3Si56lR029Eqaw/NEq/8o5UjpdM8TetKjT8GzwaCQNiil2wvEpwJVZKr+hgSXESMHrp28yA6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LzLGXsvO; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250324102216epoutp0434d7dc02d505b957228fbdc1890ec0a0~vtgpSeN_52855828558epoutp04e
	for <dmaengine@vger.kernel.org>; Mon, 24 Mar 2025 10:22:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250324102216epoutp0434d7dc02d505b957228fbdc1890ec0a0~vtgpSeN_52855828558epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742811736;
	bh=ZB3Z0j0VHC9UQuJJRKuwipbhHT0HrtT0tEnIfDyyr18=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=LzLGXsvORc/n7Gx2nufgfeoP3BFJbi5s6AOAdjCkuNhKx7IRVMCIrhiFiIg3zMT/u
	 T0WHfdtfZZs4Ly95sNgI3yplujTdM1QcMQbZItrNC4wNwLVoRUnWqGxle4PlYoC4ux
	 4ddIu0NIIIDU1puvUK/4uMNhg4p1aLEr17VRFJN4=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250324102215epcas5p3d861070bb6dcbdddd9c6330b7426bd29~vtgomuDGw1918719187epcas5p3B;
	Mon, 24 Mar 2025 10:22:15 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4ZLpyG25n9z3hhT7; Mon, 24 Mar
	2025 10:22:14 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DC.E3.10173.65231E76; Mon, 24 Mar 2025 19:22:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250324073455epcas5p2fef46449d34e33682625d5edc77bc087~vrOiazsYP1752617526epcas5p2k;
	Mon, 24 Mar 2025 07:34:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250324073455epsmtrp14571a1529c1de57a17e465d1964bdf00~vrOiZwp9-2690026900epsmtrp1X;
	Mon, 24 Mar 2025 07:34:55 +0000 (GMT)
X-AuditID: b6c32a44-8b5fb700000027bd-a6-67e13256e64c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CF.4E.08766.F1B01E76; Mon, 24 Mar 2025 16:34:55 +0900 (KST)
Received: from FDSFTE245 (unknown [107.122.81.20]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250324073454epsmtip217eaf384a235b4550fc70c7be5b76526~vrOhkIMFq1488814888epsmtip2S;
	Mon, 24 Mar 2025 07:34:54 +0000 (GMT)
From: "Aatif Mushtaq/Aatif Mushtaq" <aatif4.m@samsung.com>
To: "'Vinod Koul'" <vkoul@kernel.org>
Cc: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pankaj.dubey@samsung.com>, <aswani.reddy@samsung.com>
In-Reply-To: 
Subject: RE: [PATCH 1/3] dmaengine: Add support for 2D DMA operation
Date: Mon, 24 Mar 2025 13:04:53 +0530
Message-ID: <000001db9c8f$3ce35770$b6aa0650$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFsIHTrWqAe9Pu9L3iNOvGTrR8WTgG4P+QRAcvczKUCj5EGvbQKqHTggAfgiMCAHbHb4A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTUzfM6GG6wZY+fotDm7eyW6ye+pfV
	4vKuOWwWi7Z+YbfYeecEswOrx6ZVnWwefVtWMXp83iQXwByVbZORmpiSWqSQmpecn5KZl26r
	5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
	kV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ3x7/Z79oIJ+hVnN2xnamDsUO1i
	5OSQEDCRmLdkF0sXIxeHkMBuRolJz7+zgSSEBD4xSiy66Q2R+MYoserfE1aYjo3LZ7JBJPYy
	Ssx7eoAZwnnOKPFxYhsjSBWbgJXE+V/7wEaJCKhKbHnyAMjm4GAWqJTY8koTxOQU4JWY8M8a
	pEJYwEXi5Lk/YNUsQNW/z95jB7F5BSwl9r+axwxhC0qcnPmEBcRmFpCX2P52DjPEPQoSP58u
	Y4XYFCbR/uMYO0SNuMTRnz1QNT/ZJW5tNoKwXSRePD8DFReWeHV8CzuELSXxsr8NyvaR+DHv
	FdS/GRIT+lqhbHuJA1fmsEB8oimxfpc+RFhWYuqpdUwQa/kken8/YYKI80rsmAdjK0msed/H
	BmFLSPw7eJJxAqPSLCSfzULy2SwkH8xC2LaAkWUVo2RqQXFuemqyaYFhXmo5PLaT83M3MYKT
	o5bLDsYb8//pHWJk4mA8xCjBwawkwnuM9WG6EG9KYmVValF+fFFpTmrxIUZTYHBPZJYSTc4H
	pue8knhDE0sDEzMzMxNLYzNDJXHe5p0t6UIC6YklqdmpqQWpRTB9TBycUg1MkrpSl11uHzl/
	QoJV7GLu9zPzJ/BOcpz7rHbLsuO1017wSUiJNS47oLuA1XeOd0b2XSkpr4p7SanPnSMWFxdt
	zXplHXMzl/GVvrZ99fs3eSrO4Ux7XXXLLZb9zuhSz1j27GxhZ2rEqhmnsjP3rZ6fFK7ot0On
	SpGl7rPRpSkLtj7ufzx7Kdt8h2nuO3LfaF5p+/ZaOI5tpd3zXcpu5RIqk4wrr9g8OH9u6sHX
	/02MNqoyLb8+oS7XPK/U1t0srnBfvK7t822prebnS6QufV3lWf7yQGU5e+DDD/1eb38XBLvk
	sAg1Bc0+UrQymJnxz8Vij1k81/+kFZ/ee+dDvIiNzrwPjms3/nu57IjL6707lFiKMxINtZiL
	ihMBEXI6WxcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvK4898N0gwOL9S0Obd7KbrF66l9W
	i8u75rBZLNr6hd1i550TzA6sHptWdbJ59G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV8a/2+/Z
	CyboV5zdsJ2pgbFDtYuRk0NCwERi4/KZbF2MXBxCArsZJaZtn8kEkZCQaO5shLKFJVb+e84O
	UfSUUWJh33VmkASbgJXE+V/72EBsEQFViS1PHoDZzAK1Eg8WXWOCaLjCKHG85w1QAwcHpwCv
	xIR/1iA1wgIuEifP/QGrZwHq/X32HjuIzStgKbH/1TxmCFtQ4uTMJywgrcwCehJtGxkhxstL
	bH87hxniNgWJn0+XsUKcECbR/uMYO0SNuMTRnz3MExiFZyGZNAth0iwkk2Yh6VjAyLKKUTK1
	oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4RrQ0dzBuX/VB7xAjEwfjIUYJDmYlEd5jrA/T
	hXhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTAdfqpq7Hoj
	sfRG7tOEIA+p8uc1r9NazryKXbtfhV19qsPrydejf1ZsPWy6ubttru+KFVmr9s/uXHxUp7Qz
	9NfB0NSfgWVOv5cyaz0WuCMX11mfqyE23Yl5u8XUr58PZTH+0cjYaOlxfFmg9zOnApNDS3WY
	TPs+zmfUljlidLLULXhOi8SM06f2eF8V9xLcYSLz7tieRpewuUwyte2dVxoVf/BOyfZlSyxu
	z2SofcH+aOobjUzbokjv63r7Ra4+Wzbf8dizgAzx9AUdqfZP438rH10g7fJ+r+KUxGZjm8iT
	RtodPDOufLfvn1bts4819YPM50+/OXMsbM9zf7hV+9TBYPKRx1GXrU4l19wWPabEUpyRaKjF
	XFScCACYqGelAAMAAA==
X-CMS-MailID: 20250324073455epcas5p2fef46449d34e33682625d5edc77bc087
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250210062247epcas5p4ce208ba2806454c48a68ef25d0a326cc
References: <20250210061915.26218-1-aatif4.m@samsung.com>
	<CGME20250210062247epcas5p4ce208ba2806454c48a68ef25d0a326cc@epcas5p4.samsung.com>
	<20250210061915.26218-2-aatif4.m@samsung.com> <Z8Ab3VcAXf5z7UqE@vaman>  

Hi Vinod,

> -----Original Message-----
> From: Aatif Mushtaq/Aatif Mushtaq <aatif4.m@samsung.com>
> Sent: 06 March 2025 12:06
> To: 'Vinod Koul' <vkoul@kernel.org>
> Cc: 'dmaengine@vger.kernel.org' <dmaengine@vger.kernel.org>; 'linux-
> kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>;
> 'pankaj.dubey@samsung.com' <pankaj.dubey@samsung.com>;
> 'aswani.reddy@samsung.com' <aswani.reddy@samsung.com>
> Subject: RE: [PATCH 1/3] dmaengine: Add support for 2D DMA operation
> 
> 
> 
> > -----Original Message-----
> > From: Aatif Mushtaq/Aatif Mushtaq <aatif4.m@samsung.com>
> > Sent: 28 February 2025 15:03
> > To: 'Vinod Koul' <vkoul@kernel.org>
> > Cc: 'dmaengine@vger.kernel.org' <dmaengine@vger.kernel.org>; 'linux-
> > kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>;
> > 'pankaj.dubey@samsung.com' <pankaj.dubey@samsung.com>;
> > 'aswani.reddy@samsung.com' <aswani.reddy@samsung.com>
> > Subject: RE: [PATCH 1/3] dmaengine: Add support for 2D DMA operation
> >
> >
> >
> > > -----Original Message-----
> > > From: Vinod Koul <vkoul@kernel.org>
> > > Sent: 27 February 2025 13:32
> > > To: Aatif Mushtaq <aatif4.m@samsung.com>
> > > Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > pankaj.dubey@samsung.com; aswani.reddy@samsung.com
> > > Subject: Re: [PATCH 1/3] dmaengine: Add support for 2D DMA operation
> > >
> > > On 10-02-25, 11:49, Aatif Mushtaq wrote:
> > > > Add a new dma engine API to support 2D DMA operations.
> > > > The API will be used to get the descriptor for 2D transfer based on
> > > > the 16-bit immediate to define the stride length between
> > > > consecuitive source address or destination address after every DMA
> > > > load and store instruction is processed.
> > >
> > > Why should we define a new API for this...? Why not use the sg or
> > > interleaved api for this?
> > >
> >
> > Thanks for pointing out, interleaved API can be used for this.
> > I will make the change
> >
> 
> While trying to make the change I realised that sg and interleaved
> APIs cannot be used for our use case.
> Interleaved API is used to transfer data from non-contiguous
> buffer to non-contiguous buffer and sg API is used to transfer
> non-contiguous buffer to contiguous buffer but both the APIs work
> on multiple data chunks where each chunk has its individual attributes
> and there is a tx descriptor for each data chunk.
> But in our case we have single tx descriptor to increment the source or
> destination after every DMA LOAD and STORE operation till the desired
> length of transfer is achieved, which means we don't have multiple data
> chunks which is required in case of interleaved and sg.
> The use case is to do memory to memory copy but not in a linear way,
> such that we can define a gap between each burst.
> 

I want to gently remind you to please review my approach.

> > > >
> > > > Signed-off-by: Aatif Mushtaq <aatif4.m@samsung.com>
> > > > ---
> > > >  include/linux/dmaengine.h | 25 +++++++++++++++++++++++++
> > > >  1 file changed, 25 insertions(+)
> > > >
> > > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > > index b137fdb56093..8a73b2147983 100644
> > > > --- a/include/linux/dmaengine.h
> > > > +++ b/include/linux/dmaengine.h
> > > > @@ -833,6 +833,7 @@ struct dma_filter {
> > > >   *	be called after period_len bytes have been transferred.
> > > >   * @device_prep_interleaved_dma: Transfer expression in a generic
> > way.
> > > >   * @device_prep_dma_imm_data: DMA's 8 byte immediate data to
> the
> > > dst
> > > > address
> > > > + * @device_prep_2d_dma_memcpy: prepares a 2D memcpy
> operation
> > > >   * @device_caps: May be used to override the generic DMA slave
> > > capabilities
> > > >   *	with per-channel specific ones
> > > >   * @device_config: Pushes a new configuration to a channel, return
> > > > 0 or an error @@ -938,6 +939,9 @@ struct dma_device {
> > > >  	struct dma_async_tx_descriptor *(*device_prep_dma_imm_data)(
> > > >  		struct dma_chan *chan, dma_addr_t dst, u64 data,
> > > >  		unsigned long flags);
> > > > +	struct dma_async_tx_descriptor
> > > *(*device_prep_2d_dma_memcpy)(
> > > > +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t
src,
> > > > +		size_t len, u16 src_imm, u16 dest_imm, unsigned long
flags);
> > > >
> > > >  	void (*device_caps)(struct dma_chan *chan, struct
dma_slave_caps
> > > *caps);
> > > >  	int (*device_config)(struct dma_chan *chan, struct
> > > dma_slave_config
> > > > *config); @@ -1087,6 +1091,27 @@ static inline struct
> > > dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
> > > >  						    len, flags);
> > > >  }
> > > >
> > > > +/**
> > > > + * device_prep_2d_dma_memcpy() - Prepare a DMA 2D memcpy
> > > descriptor.
> > > > + * @chan: The channel to be used for this descriptor
> > > > + * @dest: Address of the destination data for a DMA channel
> > > > + * @src: Address of the source data for a DMA channel
> > > > + * @len: The total size of data
> > > > + * @src_imm: The immediate value to be added to the src address
> > > > +register
> > > > + * @dest_imm: The immediate value to be added to the dst address
> > > > +register
> > > > + * @flags: DMA engine flags
> > > > + */
> > > > +static inline struct dma_async_tx_descriptor
> > > *device_prep_2d_dma_memcpy(
> > > > +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t
src,
> > > > +		size_t len, u16 src_imm, u16 dest_imm, unsigned long
flags) {
> > > > +	if (!chan || !chan->device || !chan->device-
> > > >device_prep_2d_dma_memcpy)
> > > > +		return NULL;
> > > > +
> > > > +	return chan->device->device_prep_2d_dma_memcpy(chan, dest,
> > > src, len,
> > > > +						       src_imm,
dest_imm,
> > > flags); }
> > > > +
> > > >  static inline bool dmaengine_is_metadata_mode_supported(struct
> > > dma_chan *chan,
> > > >  		enum dma_desc_metadata_mode mode)  {
> > > > --
> > > > 2.17.1
> > >
> > > --
> > > ~Vinod


