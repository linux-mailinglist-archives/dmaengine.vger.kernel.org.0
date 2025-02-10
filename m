Return-Path: <dmaengine+bounces-4371-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F155A2E5C5
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 08:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A74907A35A3
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 07:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E472F22;
	Mon, 10 Feb 2025 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MWkJxIeJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF81ADC93
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173851; cv=none; b=N3tUjG+wkLIJh4qWFBxTCaqq75ApkwkWMPeZLnDS3kb5XZz0jhA3HCjxUX/OaJi5QGe7an0zIQsDZtTBbrWGD2tyVfwwsf+c7J2PiEQueILT0excLUVjdVgRo/sfa0ewPdjuCcxiU3clwAEhG+kNGLxhgoVVW2Er0MqtHU3gUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173851; c=relaxed/simple;
	bh=E5XTfvzNYj9B9esyrKaB5uJKrEnXpsM9La4z8KB03sQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=M7UliPkQkc4zSbMNoHrX7yjoYL86ROoC0suHTCfthZkLaqmBGr+e1g18VckwkpTybEAoktmRQtVEcsspWRaOc4jItdAqgINaqVcjkdtFcD4k/V2Bd1LG70Jr/UEtqJjslns3cNhwvab7fUqkPp+Q170bG0rw7A+KN/1AWkPIBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MWkJxIeJ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250210075046epoutp048ccb322736d8af5e13ec12f58feaa44a~iyWYuP8Gw2057020570epoutp04f
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 07:50:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250210075046epoutp048ccb322736d8af5e13ec12f58feaa44a~iyWYuP8Gw2057020570epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739173846;
	bh=uOIG1kBwa375IjDxvtTpcivrXTy/E8ot3zCUgn0FhOM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=MWkJxIeJ9YSvC9A1DPP9f5IjE5VDaJbscOcq9KXB7aYUhuSP2V/sUN08C6TmmIhuV
	 zeJlOo6XiyOieS1A08lNuG2dxQh/8+zzb1QHO7Nq0MHhZ7wOnBcHuErg6MK5ntE0ty
	 JMVKX89APvsAfP7B2SKkidxB322VCMFuvvsYFSVU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250210075046epcas5p2388005a7545725c07c52c4b36d9e4bde~iyWYQ94lB1911619116epcas5p2-;
	Mon, 10 Feb 2025 07:50:46 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YrxZq6BqWz4x9Pt; Mon, 10 Feb
	2025 07:50:43 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	70.89.19956.3DFA9A76; Mon, 10 Feb 2025 16:50:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250210075043epcas5p4a56834e40a986fd7d8d720f0af456fc6~iyWVgPQTI1423614236epcas5p43;
	Mon, 10 Feb 2025 07:50:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250210075043epsmtrp11404969101ef7002b8420388cc7a29ff~iyWVfsydk2946729467epsmtrp1U;
	Mon, 10 Feb 2025 07:50:43 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-83-67a9afd35e6c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E1.77.18949.3DFA9A76; Mon, 10 Feb 2025 16:50:43 +0900 (KST)
Received: from INBRO001561 (unknown [107.122.12.6]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250210075042epsmtip210702a549534698b569cabe34e80868f~iyWUmr-sK0313903139epsmtip2f;
	Mon, 10 Feb 2025 07:50:42 +0000 (GMT)
From: "Pankaj Dubey" <pankaj.dubey@samsung.com>
To: "'Aatif Mushtaq'" <aatif4.m@samsung.com>, <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <aswani.reddy@samsung.com>
In-Reply-To: <20250210061915.26218-2-aatif4.m@samsung.com>
Subject: RE: [PATCH 1/3] dmaengine: Add support for 2D DMA operation
Date: Mon, 10 Feb 2025 13:20:41 +0530
Message-ID: <05c601db7b90$7c662e60$75328b20$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFsIHTrWqAe9Pu9L3iNOvGTrR8WTgG4P+QRAcvczKW0Ar1QAA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTQ/fy+pXpBvu6DS2OzfjIaHFo81Z2
	i9VT/7JaXN41h81i550TzA6sHptWdbJ59G1ZxejxeZNcAHNUtk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
	Rn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG/h1/2As6ZCsaj2k2MN4S72Lk
	5JAQMJH4umk5UxcjF4eQwG5Gif8TdrNDOJ8YJRb/fcEC4XxjlLjSfZAdpuXc2i9Qib2MEq+f
	t0M5Lxgl7r6aC1bFJqAvce7HPFYQW0SgXqKp/SELiM0sICfRtKuFEcTmFLCSeHTvBhOILSzg
	InHy3B82EJtFQFXiyaKNzCA2r4ClxNJX/UwQtqDEyZlPoOZoSyxb+JoZ4iIFiZ9Pl0HtcpKY
	dbePHaJGXOLl0SNg/0gI/GSXaHg6nwWiwUXiy+G7UM3CEq+Ob4F6TUriZX8bkM0BZPtILN3t
	AREukdjQsxSq1V7iwJU5LCAlzAKaEut36UOs4pPo/f2ECaKTV6KjTQiiWk3i+/MzUItkJB42
	L2WCsD0kDj/5yzaBUXEWksdmIXlsFpIHZiEsW8DIsopRMrWgODc9tdi0wDgvtRwe3cn5uZsY
	welRy3sH46MHH/QOMTJxMB5ilOBgVhLhNVm4Il2INyWxsiq1KD++qDQntfgQoykwtCcyS4km
	5wMTdF5JvKGJpYGJmZmZiaWxmaGSOG/zzpZ0IYH0xJLU7NTUgtQimD4mDk6pBqaQVuZME70f
	2+Un5HiHd7k6buzV0YpqtOBaPL3158/DK56s0I2+1PvNXqRymt/lt5v9jXI0uDU6p18+xsLK
	ut3r8Grey+fzZj65u3DGmiPnZk7mZ7x+SN/qSeW2mOSG85yZTXKr/YLWLFt2ZnL+xev9IVMu
	pDMwXp7ouCaxfZJVa2XPvuStWw0Z8rOjznUf3+8akhqR8yzAvGGjn4R5/m335xGf3k7wk3mR
	xVHltrX3xZsrSZ+rebs3udse2u+kYrbq/iq2Rsn+/JMTrXmeMJaL7Ug7MvfWBdNIG5YznsJs
	AazrG7e4HV70JbXzQ4nL0madgM9XL93L2h914WjQe3UGP4frUnN2Xhe4/iGyvl2JpTgj0VCL
	uag4EQDGP8uJGAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO7l9SvTDe595bM4NuMjo8WhzVvZ
	LVZP/ctqcXnXHDaLnXdOMDuwemxa1cnm0bdlFaPH501yAcxRXDYpqTmZZalF+nYJXBmd608w
	FqyTqfjVb9TA+Eesi5GTQ0LAROLc2i8sXYxcHEICuxklbiybwgSRkJGYvHoFK4QtLLHy33N2
	iKJnjBKHN/1nBEmwCehLnPsxjxUkISLQzChxcucVsA5mATmJpl0tjBAdOxklzr9ZxwKS4BSw
	knh07wbYCmEBF4mT5/6wgdgsAqoSTxZtZAaxeQUsJZa+6meCsAUlTs58wgIxVFui92ErI4y9
	bOFrZojzFCR+Pl0GtlhEwEli1t0+dogacYmXR4+wT2AUnoVk1Cwko2YhGTULScsCRpZVjJKp
	BcW56bnFhgVGeanlesWJucWleel6yfm5mxjBkaKltYNxz6oPeocYmTgYDzFKcDArifCaLFyR
	LsSbklhZlVqUH19UmpNafIhRmoNFSZz32+veFCGB9MSS1OzU1ILUIpgsEwenVANTdrTSE4ng
	GIWtbstOzbeMeBEQVc49+076vuDOO0tfysdf01iX33y7uC3kHiP74jfbmMwP9UhdyVwVUV7t
	dLJLhFO69Mf9yWeDWs3+Gyp5uR29IT5f/dfbVPt9nnYrXtUaCCeaeMvnmi5J3mxcn/xbxHf/
	H9b5VavOnLKtvXW/9Ii1+O0jZvuM961bn3IwsXGu8/fWrYJ7g99ft5WRzhA/GD1N8NKMLtkZ
	GomFHaYH2J6/PaxZf6Gj9JaWVafPkUVbDmS+Xyrk6XBYWyVidvW7E/k3K847yC+f7LAk88Gc
	pcXn98/T5Z+davLkRdmWj1vdZ33NWj3zkscBXbmff72XnvLlfKhS6NlodcZf1f62EktxRqKh
	FnNRcSIANU6lxAMDAAA=
X-CMS-MailID: 20250210075043epcas5p4a56834e40a986fd7d8d720f0af456fc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250210062247epcas5p4ce208ba2806454c48a68ef25d0a326cc
References: <20250210061915.26218-1-aatif4.m@samsung.com>
	<CGME20250210062247epcas5p4ce208ba2806454c48a68ef25d0a326cc@epcas5p4.samsung.com>
	<20250210061915.26218-2-aatif4.m@samsung.com>



> -----Original Message-----
> From: Aatif Mushtaq <aatif4.m=40samsung.com>
> Sent: Monday, February 10, 2025 11:49 AM
> To: vkoul=40kernel.org; dmaengine=40vger.kernel.org; linux-
> kernel=40vger.kernel.org
> Cc: pankaj.dubey=40samsung.com; aswani.reddy=40samsung.com; Aatif Mushtaq
> <aatif4.m=40samsung.com>
> Subject: =5BPATCH 1/3=5D dmaengine: Add support for 2D DMA operation
>=20
> Add a new dma engine API to support 2D DMA operations.
> The API will be used to get the descriptor for 2D transfer based on
> the 16-bit immediate to define the stride length between consecuitive
16-bit immediate (what? Data?)
Run spell check consecuitive -> consecutive
> source address or destination address after every DMA load and
> store instruction is processed.
>=20
> Signed-off-by: Aatif Mushtaq <aatif4.m=40samsung.com>
> ---
>  include/linux/dmaengine.h =7C 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b137fdb56093..8a73b2147983 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> =40=40 -833,6 +833,7 =40=40 struct dma_filter =7B
>   *	be called after period_len bytes have been transferred.
>   * =40device_prep_interleaved_dma: Transfer expression in a generic way.
>   * =40device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst
> address
> + * =40device_prep_2d_dma_memcpy: prepares a 2D memcpy operation

prepares -> Prepares (P should be in CAPS)

>   * =40device_caps: May be used to override the generic DMA slave capabil=
ities
>   *	with per-channel specific ones
>   * =40device_config: Pushes a new configuration to a channel, return 0 o=
r an
> error
> =40=40 -938,6 +939,9 =40=40 struct dma_device =7B
>  	struct dma_async_tx_descriptor *(*device_prep_dma_imm_data)(
>  		struct dma_chan *chan, dma_addr_t dst, u64 data,
>  		unsigned long flags);
> +	struct dma_async_tx_descriptor *(*device_prep_2d_dma_memcpy)(
> +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> +		size_t len, u16 src_imm, u16 dest_imm, unsigned long flags);
>=20
>  	void (*device_caps)(struct dma_chan *chan, struct dma_slave_caps
> *caps);
>  	int (*device_config)(struct dma_chan *chan, struct dma_slave_config
> *config);
> =40=40 -1087,6 +1091,27 =40=40 static inline struct dma_async_tx_descript=
or
> *dmaengine_prep_dma_memcpy(
>  						    len, flags);
>  =7D
>=20
> +/**
> + * device_prep_2d_dma_memcpy() - Prepare a DMA 2D memcpy descriptor.
> + * =40chan: The channel to be used for this descriptor
> + * =40dest: Address of the destination data for a DMA channel
> + * =40src: Address of the source data for a DMA channel
> + * =40len: The total size of data
> + * =40src_imm: The immediate value to be added to the src address regist=
er

src -> source

> + * =40dest_imm: The immediate value to be added to the dst address regis=
ter

dst -> destination=20
avoid using non-standard short forms in comment except variable names.

> + * =40flags: DMA engine flags
> + */
> +static inline struct dma_async_tx_descriptor *device_prep_2d_dma_memcpy(
> +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> +		size_t len, u16 src_imm, u16 dest_imm, unsigned long flags)
> +=7B
> +	if (=21chan =7C=7C =21chan->device =7C=7C =21chan->device-
> >device_prep_2d_dma_memcpy)
> +		return NULL;
> +
> +	return chan->device->device_prep_2d_dma_memcpy(chan, dest, src,
> len,
> +						       src_imm, dest_imm, flags);
> +=7D
> +
>  static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan
> *chan,
>  		enum dma_desc_metadata_mode mode)
>  =7B
> --
> 2.17.1



