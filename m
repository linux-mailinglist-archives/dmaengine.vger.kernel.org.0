Return-Path: <dmaengine+bounces-4652-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BE3A54463
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 09:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000C6170FCA
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1121FBC9F;
	Thu,  6 Mar 2025 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VuDXOzlj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8981FCF7C
	for <dmaengine@vger.kernel.org>; Thu,  6 Mar 2025 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248822; cv=none; b=CdUQ5chBw9oRg6oH1HJ/KDHDPiOBJJkuAWi/ePiox1k/AKl7HnsgLomhtPyfg4J/E2pWlzBLIyqqUmZRWCQRVQX86jnzBU8svXjpKM97rZP2NUybe04h+pqzQ/J9Uj7CnvhOp6WCKqKSF20Woh00cFv/mnBKWoTHogywCyUJqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248822; c=relaxed/simple;
	bh=eUWsVZlYIjL3uAIwhBG07uNNCBfBviynwix7o2rDp44=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=ripO+w8of0fkW2NOVlAqAm5J5EiKVosFTLCY2Q7l4hwu8kXcUg2sB4VN+J63M65+3kiTRpa+Jdu49rvhE0Ob+IgVvopIRHqCI30ORAHvCbDDsOlS1qedf62ATvNCEJP0x3kGQHTF00DgQuQaG0RbTaszKnlxSdZM7lr+5zPnAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VuDXOzlj; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250306081331epoutp02bf3c34eea61d9bbf7081828565fbca3f~qKJGYm1dM2631826318epoutp024
	for <dmaengine@vger.kernel.org>; Thu,  6 Mar 2025 08:13:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250306081331epoutp02bf3c34eea61d9bbf7081828565fbca3f~qKJGYm1dM2631826318epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741248811;
	bh=Knqwjqi8GM+4dP/latZEf+wvPDK1ylOIsGOJ/pjBcKs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=VuDXOzljywT9rE+DTveaUSn7uB8cE+o57upwpdEKg8GP25T0odmG+QWbeiliYBJjM
	 pF3AJbVKf0aFDPb+GxLY37N2gtizQoi6HAxO+AKe/T74XJXXEsv8XYZdnEqjb5wXYV
	 9OHHbkDGF82fWw3akJNyEXexM0OLiA/IGvUPDaZM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250306081331epcas5p4262255b3e8a8503f816fb6d82a9b1c90~qKJF1jdSG2477724777epcas5p4T;
	Thu,  6 Mar 2025 08:13:31 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z7hy139Hqz4x9Q7; Thu,  6 Mar
	2025 08:13:29 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.A6.19933.82959C76; Thu,  6 Mar 2025 17:13:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250306063546epcas5p388084f298ae5d55eab7fbbb7cc1db2d9~qIzvhmjmb0821708217epcas5p3e;
	Thu,  6 Mar 2025 06:35:46 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250306063546epsmtrp183610b81ac1e5a41fa084533ed2e7dc3~qIzvgx2MP2210422104epsmtrp1k;
	Thu,  6 Mar 2025 06:35:46 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-41-67c959281b3b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	3B.4A.33707.14249C76; Thu,  6 Mar 2025 15:35:45 +0900 (KST)
Received: from FDSFTE245 (unknown [107.122.81.20]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250306063545epsmtip1d4a3d8251fe06ce0f9469ed7fbe08272~qIzun50W40927409274epsmtip1W;
	Thu,  6 Mar 2025 06:35:44 +0000 (GMT)
From: "Aatif Mushtaq/Aatif Mushtaq" <aatif4.m@samsung.com>
To: "'Vinod Koul'" <vkoul@kernel.org>
Cc: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pankaj.dubey@samsung.com>, <aswani.reddy@samsung.com>
In-Reply-To: 
Subject: RE: [PATCH 1/3] dmaengine: Add support for 2D DMA operation
Date: Thu, 6 Mar 2025 12:05:43 +0530
Message-ID: <014701db8e61$fdd331d0$f9799570$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFsIHTrWqAe9Pu9L3iNOvGTrR8WTgG4P+QRAcvczKUCj5EGvbQKqHTggAfgiMA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTU1cj8mS6wZ8nYhaHNm9lt1g99S+r
	xeVdc9gsFm39wm6x884JZgdWj02rOtk8+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUzL91W
	yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
	I7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjfeMtpoLHGhXzTt5lamBco9DF
	yMkhIWAisfjtGdYuRi4OIYHdjBJtvz6xQTifGCWmbFrADOdcmLqVCaZlYsclqMRORomTs7+y
	QDjPGSX+r+5iA6liE7CSOP9rH5gtIqAqseXJAyCbg4NZoFJiyytNEJNTgFdiwj9rkAphAReJ
	k+f+gFWzCKhIvGk4yApi8wpYSky83MkGYQtKnJz5hAXEZhaQl9j+dg4zxD0KEj+fLmOF2OQn
	8ezPUXaIGnGJoz97wO6UEPjKLvHl1RZ2iAYXiWXfe6CahSVeHYeJS0m87G+DspMlbr7fB2Xn
	SExYuBrKtpc4cGUOC8QrmhLrd+lDhGUlpp5axwSxl0+i9/cTaFjxSuyYB2MrSax538cGYUtI
	/Dt4knECo9IsJK/NQvLaLCQvzELYtoCRZRWjZGpBcW56arFpgVFeajk8vpPzczcxghOkltcO
	xocPPugdYmTiYDzEKMHBrCTCe9HvZLoQb0piZVVqUX58UWlOavEhRlNgeE9klhJNzgem6LyS
	eEMTSwMTMzMzE0tjM0Mlcd7mnS3pQgLpiSWp2ampBalFMH1MHJxSDUy6xm+mvLy74Zd/sMnW
	tYkP2kpN0g8sD8x/kKnO4Wm97qn77+c9j1bNuGKwKfzGVOYpTXO5eP2O/dnX/sR60ztF81ln
	35x5XhrfaX72r+C6XQdvfN9j/+R1T1fFi8pulYMBz6PD2z1uL5rls1lgqbSpmR7bRJvqQ0tN
	XKpnSq5q1XmTf0Jw2XXf9qv3E37G1nUf1mUTZmoSP7zRaOKa6R770uL/5PeunfNr3q7zZywf
	bUvrvJhkviDjx/s1As++W/U/jnmUY9n74W+NdvCUzDsOLD/PN4Tqffze11rk6iCSJ2neuuV8
	60K2VsfpPUvkX93XrJosuuwaSzq7IfN15VPLF9WJXtj1edP0y1fTLIxrlFiKMxINtZiLihMB
	TpaQvBkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnK6j08l0gyMHzCwObd7KbrF66l9W
	i8u75rBZLNr6hd1i550TzA6sHptWdbJ59G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV8b7xltM
	BY81KuadvMvUwLhGoYuRk0NCwERiYsclZhBbSGA7o8TLwwYQcQmJ5s5GJghbWGLlv+fsXYxc
	QDVPGSVuHP4BlmATsJI4/2sfG4gtIqAqseXJAzCbWaBW4sGia0wQDZcZJV697AFKcHBwCvBK
	TPhnDVIjLOAicfLcH7B6FgEViTcNB1lBbF4BS4mJlzvZIGxBiZMzn7CAtDIL6Em0bWSEGC8v
	sf3tHGaI2xQkfj5dxgpxgp/Esz9H2SFqxCWO/uxhnsAoPAvJpFkIk2YhmTQLSccCRpZVjKKp
	BcW56bnJBYZ6xYm5xaV56XrJ+bmbGMGRoRW0g3HZ+r96hxiZOBgPMUpwMCuJ8L4+dTxdiDcl
	sbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1OqgWnCkRDxV2/yV0le
	vOdyjvmZu9tD8ZpAz9AHwReqcvn6v3V9jA9cFTH1WUq/gu7O7Z7r01oc+tUcDhz+Fh+f9fCc
	0inJaROLX+nzHj3z+lycxLRpHlGNNbkBN/uFw7aKzPO5IRx0ojX9JMeP5DVf/+62+/P8Tc4M
	zh1nWD7nLhDPTOz/xfZ3RsqRhFPyzLN4zD9Uv/DV2jP93L/Fi2636W1RK/338EZqguw7N/Oi
	T8bZEjd9/T+n/JGamWEa6+Ij1VFWvmBtwKWi4lubTeJTmZ07VWU+Xvu5O+uGX9O1m+WMelx1
	USerCp/eaOMz2qYjyn/tyTNe7gkf9uSfmqL4TuHEZw72vme9bMmHqg9UVyixFGckGmoxFxUn
	AgBhg6cq+wIAAA==
X-CMS-MailID: 20250306063546epcas5p388084f298ae5d55eab7fbbb7cc1db2d9
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



> -----Original Message-----
> From: Aatif Mushtaq/Aatif Mushtaq <aatif4.m@samsung.com>
> Sent: 28 February 2025 15:03
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
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: 27 February 2025 13:32
> > To: Aatif Mushtaq <aatif4.m@samsung.com>
> > Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org;
> > pankaj.dubey@samsung.com; aswani.reddy@samsung.com
> > Subject: Re: [PATCH 1/3] dmaengine: Add support for 2D DMA operation
> >
> > On 10-02-25, 11:49, Aatif Mushtaq wrote:
> > > Add a new dma engine API to support 2D DMA operations.
> > > The API will be used to get the descriptor for 2D transfer based on
> > > the 16-bit immediate to define the stride length between
> > > consecuitive source address or destination address after every DMA
> > > load and store instruction is processed.
> >
> > Why should we define a new API for this...? Why not use the sg or
> > interleaved api for this?
> >
> 
> Thanks for pointing out, interleaved API can be used for this.
> I will make the change
> 

While trying to make the change I realised that sg and interleaved
APIs cannot be used for our use case.
Interleaved API is used to transfer data from non-contiguous
buffer to non-contiguous buffer and sg API is used to transfer 
non-contiguous buffer to contiguous buffer but both the APIs work 
on multiple data chunks where each chunk has its individual attributes 
and there is a tx descriptor for each data chunk.
But in our case we have single tx descriptor to increment the source or
destination after every DMA LOAD and STORE operation till the desired
length of transfer is achieved, which means we don't have multiple data
chunks which is required in case of interleaved and sg.
The use case is to do memory to memory copy but not in a linear way,
such that we can define a gap between each burst.

> > >
> > > Signed-off-by: Aatif Mushtaq <aatif4.m@samsung.com>
> > > ---
> > >  include/linux/dmaengine.h | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > index b137fdb56093..8a73b2147983 100644
> > > --- a/include/linux/dmaengine.h
> > > +++ b/include/linux/dmaengine.h
> > > @@ -833,6 +833,7 @@ struct dma_filter {
> > >   *	be called after period_len bytes have been transferred.
> > >   * @device_prep_interleaved_dma: Transfer expression in a generic
> way.
> > >   * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the
> > dst
> > > address
> > > + * @device_prep_2d_dma_memcpy: prepares a 2D memcpy operation
> > >   * @device_caps: May be used to override the generic DMA slave
> > capabilities
> > >   *	with per-channel specific ones
> > >   * @device_config: Pushes a new configuration to a channel, return
> > > 0 or an error @@ -938,6 +939,9 @@ struct dma_device {
> > >  	struct dma_async_tx_descriptor *(*device_prep_dma_imm_data)(
> > >  		struct dma_chan *chan, dma_addr_t dst, u64 data,
> > >  		unsigned long flags);
> > > +	struct dma_async_tx_descriptor
> > *(*device_prep_2d_dma_memcpy)(
> > > +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> > > +		size_t len, u16 src_imm, u16 dest_imm, unsigned long flags);
> > >
> > >  	void (*device_caps)(struct dma_chan *chan, struct dma_slave_caps
> > *caps);
> > >  	int (*device_config)(struct dma_chan *chan, struct
> > dma_slave_config
> > > *config); @@ -1087,6 +1091,27 @@ static inline struct
> > dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
> > >  						    len, flags);
> > >  }
> > >
> > > +/**
> > > + * device_prep_2d_dma_memcpy() - Prepare a DMA 2D memcpy
> > descriptor.
> > > + * @chan: The channel to be used for this descriptor
> > > + * @dest: Address of the destination data for a DMA channel
> > > + * @src: Address of the source data for a DMA channel
> > > + * @len: The total size of data
> > > + * @src_imm: The immediate value to be added to the src address
> > > +register
> > > + * @dest_imm: The immediate value to be added to the dst address
> > > +register
> > > + * @flags: DMA engine flags
> > > + */
> > > +static inline struct dma_async_tx_descriptor
> > *device_prep_2d_dma_memcpy(
> > > +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> > > +		size_t len, u16 src_imm, u16 dest_imm, unsigned long flags)
{
> > > +	if (!chan || !chan->device || !chan->device-
> > >device_prep_2d_dma_memcpy)
> > > +		return NULL;
> > > +
> > > +	return chan->device->device_prep_2d_dma_memcpy(chan, dest,
> > src, len,
> > > +						       src_imm, dest_imm,
> > flags); }
> > > +
> > >  static inline bool dmaengine_is_metadata_mode_supported(struct
> > dma_chan *chan,
> > >  		enum dma_desc_metadata_mode mode)  {
> > > --
> > > 2.17.1
> >
> > --
> > ~Vinod


