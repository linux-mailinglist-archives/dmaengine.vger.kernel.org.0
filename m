Return-Path: <dmaengine+bounces-4595-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB17A495CC
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EEE16502F
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AB425BABC;
	Fri, 28 Feb 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LHuSGsB/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3225B693
	for <dmaengine@vger.kernel.org>; Fri, 28 Feb 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736105; cv=none; b=TbM4gvy+kKPBEj3VrmLe0opKMx7kV2ySbnWEqMHQS6yzyj7/GSrZJ+VZMR8lHENj0c54zJOobqvgBiyIdHgHhUyoFLa2sJxSFcAGRdHe+KLVlscqS5BMTdflh9byfV9lJACWLuyKQhJaRCRXVJi2/NxTY5DBcEAlU90ayf7wk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736105; c=relaxed/simple;
	bh=XYLUnTNaQuIXtH7OIV1lfwAh6b5aC2kp3AK1Hzj5ows=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=NqcUbfr5S+93HhijVgLqfSVrCYO5Yfd+Fa687pVTCPVc/fRHB/LzI6Rv6mSwrCY80QKdKEg53MzCWqANpasThTfkw4lUUTaSTUdmhJmIziMuVa0JNu2bwmifUgqGfljbbEMPo8FyD2M3CKyLDEgcATHumHQ+iGaAIx6qnPuOQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LHuSGsB/; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250228094821epoutp0183452d9c7e7c1994aff26158c003a38f~oVkLjl-fK1342013420epoutp013
	for <dmaengine@vger.kernel.org>; Fri, 28 Feb 2025 09:48:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250228094821epoutp0183452d9c7e7c1994aff26158c003a38f~oVkLjl-fK1342013420epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740736101;
	bh=18iY0XXTL9npz3MKKWokwxOCWnjgB6CSduF8tMUm4D0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=LHuSGsB/rUi328g13YXk+u3ZJOcNkembfbeAzApQD93vSs+xVNICeTDCmPbZy3nQD
	 6v4dN8Fq6nb+Vw/axM2Izj2rzJV7VF7XihrLaYOz46QswtqE3AFWqhkJVg2dSIUtjE
	 IJmkj1CFH3QRDDo5FyZFtAhah7TxxTg35fX+L02Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250228094820epcas5p36bb70d2da5c76c8a64f7680975938b10~oVkK4BMF72824028240epcas5p3z;
	Fri, 28 Feb 2025 09:48:20 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z43LC21S0z4x9Pv; Fri, 28 Feb
	2025 09:48:19 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CC.9D.19956.36681C76; Fri, 28 Feb 2025 18:48:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250228093256epcas5p1584a4e85ed027dd253a5d8617366eeae~oVWuK-JrX1275612756epcas5p1x;
	Fri, 28 Feb 2025 09:32:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250228093256epsmtrp17c571e0bcfc27d794238cdb648d7b327~oVWuGLwdF2192121921epsmtrp1t;
	Fri, 28 Feb 2025 09:32:56 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-4d-67c186634c18
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.5E.33707.8C281C76; Fri, 28 Feb 2025 18:32:56 +0900 (KST)
Received: from FDSFTE245 (unknown [107.122.81.20]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250228093255epsmtip2deda8297f5f97a1b168b219bbac633d2~oVWtRHRt00156501565epsmtip2K;
	Fri, 28 Feb 2025 09:32:55 +0000 (GMT)
From: "Aatif Mushtaq/Aatif Mushtaq" <aatif4.m@samsung.com>
To: "'Vinod Koul'" <vkoul@kernel.org>
Cc: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pankaj.dubey@samsung.com>, <aswani.reddy@samsung.com>
In-Reply-To: <Z8Ab3VcAXf5z7UqE@vaman>
Subject: RE: [PATCH 1/3] dmaengine: Add support for 2D DMA operation
Date: Fri, 28 Feb 2025 15:02:38 +0530
Message-ID: <000501db89c3$bf6de540$3e49afc0$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFsIHTrWqAe9Pu9L3iNOvGTrR8WTgG4P+QRAcvczKUCj5EGvbQKqHTg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTXTe57WC6wZsrPBaHNm9lt1g99S+r
	xeVdc9gsFm39wm6x884JZgdWj02rOtk8+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUzL91W
	yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
	I7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj9sUHzAXtshWzW54wNjD2iXcx
	cnJICJhIdNz8xdTFyMUhJLCbUaJx1hR2COcTo8SDXw2sIFVgzsoFhjAdcyZuY4Mo2sko8fXH
	WqiO54wSHyZfYwGpYhOwkjj/ax8biC0ioCqx5ckDIJuDg1mgUmLLK02QMCdQeM7clewgtrCA
	i8TJc3/AylmA4odfrAKL8wpYStzcupMZwhaUODnzCdh4ZgF5ie1v5zBDHKQg8fPpMlaIVW4S
	O68uZIOoEZc4+rOHGeQ2CYGP7BInb+1ngWhwkehZNZ0NwhaWeHV8CzuELSXxsr8Nyk6WuPl+
	H5SdIzFh4Woo217iwJU5LBC/aEqs36UPEZaVmHpqHRPEXj6J3t9PmCDivBI75sHYShJr3vdB
	rZWQ+HfwJOMERqVZSF6bheS1WUhemIWwbQEjyypGydSC4tz01GLTAuO81HJ4fCfn525iBCdI
	Le8djI8efNA7xMjEwXiIUYKDWUmEd1bsgXQh3pTEyqrUovz4otKc1OJDjKbA8J7ILCWanA9M
	0Xkl8YYmlgYmZmZmJpbGZoZK4rzNO1vShQTSE0tSs1NTC1KLYPqYODilGphsdix92vH4kmNq
	UB2LUo9f3Lpj16W3X7ty4eYqrjLms8Vyf36eamiu3RAwUX6j5xz2zTPU5ni+bas5/yz4huQV
	48vV379sPiC7faFCq7y9T2mWjcnBTM+gZS51/okv1gXMXhy5j8V/x46+PUz+3JayhrXHnW/Z
	Rxfteb1jguTjFTlLA8q23LSydL72RDG73F2482Lw/9NtXz4ark+72P3v+RefOT976zdc3yAm
	r1/zYLH4u2lWi2ILlXRZl01d1s8oqbWiJ+i+7hT5i/1vF1dGOmwP1DPROMpgu0BMyOdqp1FY
	Rhm7amsU84zf8wv/xgnZ8G/95vf5adq5hLtXduq6XGH5EvdxkqRwZczVO1eUWIozEg21mIuK
	EwGuFQ08GQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvO6JpoPpBt0r+CwObd7KbrF66l9W
	i8u75rBZLNr6hd1i550TzA6sHptWdbJ59G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV8bsiw+Y
	C9plK2a3PGFsYOwT72Lk5JAQMJGYM3EbWxcjF4eQwHZGid72Q4wQCQmJ5s5GJghbWGLlv+fs
	ILaQwFNGiRV7M0BsNgErifO/9rGB2CICqhJbnjwAs5kFaiUeLLrGBDH0EqPE7Qe3WUESnEBF
	c+auBBskLOAicfLcH7AGFqD44RerwOK8ApYSN7fuZIawBSVOznzC0sXIATRUT6JtIyPEfHmJ
	7W/nMEPcpiDx8+kyVogb3CR2Xl0IdYO4xNGfPcwTGIVnIZk0C2HSLCSTZiHpWMDIsopRNLWg
	ODc9N7nAUK84Mbe4NC9dLzk/dxMjODa0gnYwLlv/V+8QIxMH4yFGCQ5mJRHeWbEH0oV4UxIr
	q1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqY3I5fiuIXWyIiK34l
	bUOve5sM27p/V6PfbJFJzBDNXXZceR5z7mwO/7aduy6UCCc08l2rNdYyTzWOzpnofVFDNNXq
	yDxpmzXvHwrybPi+KdTy2HPxiRcTHGUZIi0UYqtTFof9OJu5paBoosG9wH8NHQm2jNZ/d/9L
	XXNTpj/qla/Npa6AX1NfXIm3jBG7+m9du+mCL+r7NZcaFqzfb9jIWnnv655Pe3Sd7i+wPCJ9
	pD/yckL0nd0LvYpdneJce00fcL44y8haLFLt0VvMfGVZ0lkdq6Pxc5nmfmGu9y2845+xRPX0
	7JZ+W7ZFe56IN7z8HB1VziDXMVNciaVa1LV+n2uOa8Mu7shHnHwPliixFGckGmoxFxUnAgCG
	a0C4/AIAAA==
X-CMS-MailID: 20250228093256epcas5p1584a4e85ed027dd253a5d8617366eeae
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
> From: Vinod Koul <vkoul@kernel.org>
> Sent: 27 February 2025 13:32
> To: Aatif Mushtaq <aatif4.m@samsung.com>
> Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org;
> pankaj.dubey@samsung.com; aswani.reddy@samsung.com
> Subject: Re: [PATCH 1/3] dmaengine: Add support for 2D DMA operation
> 
> On 10-02-25, 11:49, Aatif Mushtaq wrote:
> > Add a new dma engine API to support 2D DMA operations.
> > The API will be used to get the descriptor for 2D transfer based on
> > the 16-bit immediate to define the stride length between consecuitive
> > source address or destination address after every DMA load and store
> > instruction is processed.
> 
> Why should we define a new API for this...? Why not use the sg or
> interleaved api for this?
> 

Thanks for pointing out, interleaved API can be used for this.
I will make the change

> >
> > Signed-off-by: Aatif Mushtaq <aatif4.m@samsung.com>
> > ---
> >  include/linux/dmaengine.h | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index b137fdb56093..8a73b2147983 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -833,6 +833,7 @@ struct dma_filter {
> >   *	be called after period_len bytes have been transferred.
> >   * @device_prep_interleaved_dma: Transfer expression in a generic way.
> >   * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the
> dst
> > address
> > + * @device_prep_2d_dma_memcpy: prepares a 2D memcpy operation
> >   * @device_caps: May be used to override the generic DMA slave
> capabilities
> >   *	with per-channel specific ones
> >   * @device_config: Pushes a new configuration to a channel, return 0
> > or an error @@ -938,6 +939,9 @@ struct dma_device {
> >  	struct dma_async_tx_descriptor *(*device_prep_dma_imm_data)(
> >  		struct dma_chan *chan, dma_addr_t dst, u64 data,
> >  		unsigned long flags);
> > +	struct dma_async_tx_descriptor
> *(*device_prep_2d_dma_memcpy)(
> > +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> > +		size_t len, u16 src_imm, u16 dest_imm, unsigned long flags);
> >
> >  	void (*device_caps)(struct dma_chan *chan, struct dma_slave_caps
> *caps);
> >  	int (*device_config)(struct dma_chan *chan, struct
> dma_slave_config
> > *config); @@ -1087,6 +1091,27 @@ static inline struct
> dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
> >  						    len, flags);
> >  }
> >
> > +/**
> > + * device_prep_2d_dma_memcpy() - Prepare a DMA 2D memcpy
> descriptor.
> > + * @chan: The channel to be used for this descriptor
> > + * @dest: Address of the destination data for a DMA channel
> > + * @src: Address of the source data for a DMA channel
> > + * @len: The total size of data
> > + * @src_imm: The immediate value to be added to the src address
> > +register
> > + * @dest_imm: The immediate value to be added to the dst address
> > +register
> > + * @flags: DMA engine flags
> > + */
> > +static inline struct dma_async_tx_descriptor
> *device_prep_2d_dma_memcpy(
> > +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> > +		size_t len, u16 src_imm, u16 dest_imm, unsigned long flags)
{
> > +	if (!chan || !chan->device || !chan->device-
> >device_prep_2d_dma_memcpy)
> > +		return NULL;
> > +
> > +	return chan->device->device_prep_2d_dma_memcpy(chan, dest,
> src, len,
> > +						       src_imm, dest_imm,
> flags); }
> > +
> >  static inline bool dmaengine_is_metadata_mode_supported(struct
> dma_chan *chan,
> >  		enum dma_desc_metadata_mode mode)
> >  {
> > --
> > 2.17.1
> 
> --
> ~Vinod


