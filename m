Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2A63D6990
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jul 2021 00:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhGZVwE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Jul 2021 17:52:04 -0400
Received: from neon-v2.ccupm.upm.es ([138.100.198.70]:48257 "EHLO
        neon-v2.ccupm.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhGZVwE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Jul 2021 17:52:04 -0400
X-Greylist: delayed 696 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 17:52:03 EDT
Received: from localhost (62-3-70-206.dsl.in-addr.zen.co.uk [62.3.70.206] (may be forged))
        (user=adrianml@alumnos.upm.es mech=PLAIN bits=0)
        by neon-v2.ccupm.upm.es (8.15.2/8.15.2/neon-v2-001) with ESMTPSA id 16QMET1C021260
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 22:14:30 GMT
Date:   Mon, 26 Jul 2021 23:14:23 +0100
From:   Adrian Larumbe <adrianml@alumnos.upm.es>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>,
        dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dmaengine: xilinx_dma: Restore support for memcpy SG
 transfers
Message-ID: <20210726221423.5q6b5cwruznzqfxr@worklaptop.localdomain>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
 <20210706234338.7696-2-adrian.martinezlarumbe@imgtec.com>
 <YO5u/ZK4njSpYrwN@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a6pixnfpycuirtiv"
Content-Disposition: inline
In-Reply-To: <YO5u/ZK4njSpYrwN@matsya>
X-BitDefender-Scanner: Clean, Agent: BitDefender Milter 3.1.7 on neon-v2.ccupm.upm.es, sigver: 7.89286
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--a6pixnfpycuirtiv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vinod, I'm the same person who authored this patch. I left my previous
employer so no longer have access to their company email address. However I=
've
signed this email with the same GPG key to confirm my identity.

On 14.07.2021 10:28, Vinod Koul wrote:
> On 07-07-21, 00:43, Adrian Larumbe wrote:
> > This is the old DMA_SG interface that was removed in commit
> > c678fa66341c ("dmaengine: remove DMA_SG as it is dead code in kernel").=
 It
> > has been renamed to DMA_MEMCPY_SG to better match the MEMSET and MEMSET=
_SG
> > naming convention.
> >=20
> > It should only be used for mem2mem copies, either main system memory or
> > CPU-addressable device memory (like video memory on a PCI graphics card=
).
> >=20
> > Bringing back this interface was prompted by the need to use the Xilinx
> > CDMA device for mem2mem SG transfers. The current CDMA binding for
> > device_prep_dma_memcpy_sg was partially borrowed from xlnx kernel tree,=
 and
> > expanded with extended address space support when linking descriptor
> > segments and checking for incorrect zero transfer size.
> >=20
> > Signed-off-by: Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
> > ---
> >  .../driver-api/dmaengine/provider.rst         |  11 ++
> >  drivers/dma/dmaengine.c                       |   7 +
> >  drivers/dma/xilinx/xilinx_dma.c               | 122 ++++++++++++++++++
>=20
> Can you make this split... documentation patch, core change and then
> driver

I understand you'd like these in three different patches, is that right? Or
maybe one patch for the core change and its associated documentation, and
another one for the consumer.

> >  include/linux/dmaengine.h                     |  20 +++
> >  4 files changed, 160 insertions(+)
> >=20
> > diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Document=
ation/driver-api/dmaengine/provider.rst
> > index ddb0a81a796c..9f0efe9e9952 100644
> > --- a/Documentation/driver-api/dmaengine/provider.rst
> > +++ b/Documentation/driver-api/dmaengine/provider.rst
> > @@ -162,6 +162,17 @@ Currently, the types available are:
> > =20
> >    - The device is able to do memory to memory copies
> > =20
> > +- - DMA_MEMCPY_SG
> > +
> > +  - The device supports memory to memory scatter-gather transfers.
> > +
> > +  - Even though a plain memcpy can look like a particular case of a
> > +    scatter-gather transfer, with a single chunk to transfer, it's a
> > +    distinct transaction type in the mem2mem transfer case. This is
> > +    because some very simple devices might be able to do contiguous
> > +    single-chunk memory copies, but have no support for more
> > +    complex SG transfers.
>=20
> How does one deal with cases where
>  - src_sg_len and dstn_sg_len are different?

Then only as many bytes as the smallest of the scattered buffers will be co=
pied.

> >  - src_sg and dstn_sg are different lists (maybe different number of
> >    entries with different lengths..)
> >=20
> > I think we need to document these cases or limitations..

I don't think we should place any restrictions on the number of scatterlist
entries or their length, and the consumer driver should ensure that these g=
et
translated into a device-specific descriptor chain. However the previous
semantic should always be observed, which effectively turns the operation i=
nto
sort of a strncpy.

> > +
> >  - DMA_XOR
> > =20
> >    - The device is able to perform XOR operations on memory areas
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index af3ee288bc11..c4e3334b04cf 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -1160,6 +1160,13 @@ int dma_async_device_register(struct dma_device =
*device)
> >  		return -EIO;
> >  	}
> > =20
> > +	if (dma_has_cap(DMA_MEMCPY_SG, device->cap_mask) && !device->device_p=
rep_dma_memcpy_sg) {
> > +		dev_err(device->dev,
> > +			"Device claims capability %s, but op is not defined\n",
> > +			"DMA_MEMCPY_SG");
> > +		return -EIO;
> > +	}
> > +
> >  	if (dma_has_cap(DMA_XOR, device->cap_mask) && !device->device_prep_dm=
a_xor) {
> >  		dev_err(device->dev,
> >  			"Device claims capability %s, but op is not defined\n",
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilin=
x_dma.c
> > index 75c0b8e904e5..0e2bf75d42d3 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -2108,6 +2108,126 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan,=
 dma_addr_t dma_dst,
> >  	return NULL;
> >  }
> > =20
> > +/**
> > + * xilinx_cdma_prep_memcpy_sg - prepare descriptors for a memcpy_sg tr=
ansaction
> > + * @dchan: DMA channel
> > + * @dst_sg: Destination scatter list
> > + * @dst_sg_len: Number of entries in destination scatter list
> > + * @src_sg: Source scatter list
> > + * @src_sg_len: Number of entries in source scatter list
> > + * @flags: transfer ack flags
> > + *
> > + * Return: Async transaction descriptor on success and NULL on failure
> > + */
> > +static struct dma_async_tx_descriptor *xilinx_cdma_prep_memcpy_sg(
> > +			struct dma_chan *dchan, struct scatterlist *dst_sg,
> > +			unsigned int dst_sg_len, struct scatterlist *src_sg,
> > +			unsigned int src_sg_len, unsigned long flags)
> > +{
> > +	struct xilinx_dma_chan *chan =3D to_xilinx_chan(dchan);
> > +	struct xilinx_dma_tx_descriptor *desc;
> > +	struct xilinx_cdma_tx_segment *segment, *prev =3D NULL;
> > +	struct xilinx_cdma_desc_hw *hw;
> > +	size_t len, dst_avail, src_avail;
> > +	dma_addr_t dma_dst, dma_src;
> > +
> > +	if (unlikely(dst_sg_len =3D=3D 0 || src_sg_len =3D=3D 0))
> > +		return NULL;
> > +
> > +	if (unlikely(!dst_sg  || !src_sg))
> > +		return NULL;
>=20
> no check for dst_sg_len =3D=3D src_sg_len or it doesnt matter here?

It doesn't, according to the semantics that I had envisioned.

> +
> +	desc =3D xilinx_dma_alloc_tx_descriptor(chan);
> +	if (!desc)
> +		return NULL;
> +
> +	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> +	desc->async_tx.tx_submit =3D xilinx_dma_tx_submit;
> +
> +	dst_avail =3D sg_dma_len(dst_sg);
> +	src_avail =3D sg_dma_len(src_sg);
> +	/*
> +	 * loop until there is either no more source or no more destination
> +	 * scatterlist entry
> +	 */
> +	while (true) {
> +		len =3D min_t(size_t, src_avail, dst_avail);
> +		len =3D min_t(size_t, len, chan->xdev->max_buffer_len);
> +		if (len =3D=3D 0)
> +			goto fetch;
> +
> +		/* Allocate the link descriptor from DMA pool */
> +		segment =3D xilinx_cdma_alloc_tx_segment(chan);
> +		if (!segment)
> +			goto error;
> +
> +		dma_dst =3D sg_dma_address(dst_sg) + sg_dma_len(dst_sg) -
> +			dst_avail;
> +		dma_src =3D sg_dma_address(src_sg) + sg_dma_len(src_sg) -
> +			src_avail;
> +		hw =3D &segment->hw;
> +		hw->control =3D len;
> +		hw->src_addr =3D dma_src;
> +		hw->dest_addr =3D dma_dst;
> +		if (chan->ext_addr) {
> +			hw->src_addr_msb =3D upper_32_bits(dma_src);
> +			hw->dest_addr_msb =3D upper_32_bits(dma_dst);
> +		}
> +
> +		if (prev) {
> +			prev->hw.next_desc =3D segment->phys;
> +			if (chan->ext_addr)
> +				prev->hw.next_desc_msb =3D
> +					upper_32_bits(segment->phys);
> +		}
> +
> +		prev =3D segment;
> +		dst_avail -=3D len;
> +		src_avail -=3D len;
> +		list_add_tail(&segment->node, &desc->segments);
> +
> +fetch:
> +		/* Fetch the next dst scatterlist entry */
> +		if (dst_avail =3D=3D 0) {
> +			if (dst_sg_len =3D=3D 0)
> +				break;
> +			dst_sg =3D sg_next(dst_sg);
> +			if (dst_sg =3D=3D NULL)
> +				break;
> +			dst_sg_len--;
> +			dst_avail =3D sg_dma_len(dst_sg);
> +		}
> +		/* Fetch the next src scatterlist entry */
> +		if (src_avail =3D=3D 0) {
> +			if (src_sg_len =3D=3D 0)
> +				break;
> +			src_sg =3D sg_next(src_sg);
> +			if (src_sg =3D=3D NULL)
> +				break;
> +			src_sg_len--;
> +			src_avail =3D sg_dma_len(src_sg);
> +		}
> +	}
> +
> +	if (list_empty(&desc->segments)) {
> +		dev_err(chan->xdev->dev,
> +			"%s: Zero-size SG transfer requested\n", __func__);
> +		goto error;
> +	}
> +
> +	/* Link the last hardware descriptor with the first. */
> +	segment =3D list_first_entry(&desc->segments,
> +				struct xilinx_cdma_tx_segment, node);
> +	desc->async_tx.phys =3D segment->phys;
> +	prev->hw.next_desc =3D segment->phys;
> +
> +	return &desc->async_tx;
> +
> +error:
> +	xilinx_dma_free_tx_descriptor(chan, desc);
> +	return NULL;
> +}
> +
>  /**
>   * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transa=
ction
>   * @dchan: DMA channel
> @@ -3094,7 +3214,9 @@ static int xilinx_dma_probe(struct platform_device =
*pdev)
>  					  DMA_RESIDUE_GRANULARITY_SEGMENT;
>  	} else if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_CDMA) {
>  		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
> +		dma_cap_set(DMA_MEMCPY_SG, xdev->common.cap_mask);
>  		xdev->common.device_prep_dma_memcpy =3D xilinx_cdma_prep_memcpy;
> +		xdev->common.device_prep_dma_memcpy_sg =3D xilinx_cdma_prep_memcpy_sg;
>  		/* Residue calculation is supported by only AXI DMA and CDMA */
>  		xdev->common.residue_granularity =3D
>  					  DMA_RESIDUE_GRANULARITY_SEGMENT;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 004736b6a9c8..7c342f77d8eb 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -50,6 +50,7 @@ enum dma_status {
>   */
>  enum dma_transaction_type {
>  	DMA_MEMCPY,
> +	DMA_MEMCPY_SG,
>  	DMA_XOR,
>  	DMA_PQ,
>  	DMA_XOR_VAL,
> @@ -891,6 +892,11 @@ struct dma_device {
>  	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
>  		struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
>  		size_t len, unsigned long flags);
> +	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy_sg)(
> +		struct dma_chan *chan,
> +		struct scatterlist *dst_sg, unsigned int dst_nents,
> +		struct scatterlist *src_sg, unsigned int src_nents,
> +		unsigned long flags);
>  	struct dma_async_tx_descriptor *(*device_prep_dma_xor)(
>  		struct dma_chan *chan, dma_addr_t dst, dma_addr_t *src,
>  		unsigned int src_cnt, size_t len, unsigned long flags);
> @@ -1053,6 +1059,20 @@ static inline struct dma_async_tx_descriptor *dmae=
ngine_prep_dma_memcpy(
>  						    len, flags);
>  }
> =20
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy_=
sg(
> +		struct dma_chan *chan,
> +		struct scatterlist *dst_sg, unsigned int dst_nents,
> +		struct scatterlist *src_sg, unsigned int src_nents,
> +		unsigned long flags)
> +{
> +	if (!chan || !chan->device || !chan->device->device_prep_dma_memcpy_sg)
> +		return NULL;
> +
> +	return chan->device->device_prep_dma_memcpy_sg(chan, dst_sg, dst_nents,
> +						       src_sg, src_nents,
> +						       flags);
> +}
> +
>  static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan =
*chan,
>  		enum dma_desc_metadata_mode mode)
>  {
> --=20
> 2.17.1

Adrian Larumbe

--a6pixnfpycuirtiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEGSgcTOewnlj/4h9n1cwlZC6W1h8FAmD/M78ACgkQ1cwlZC6W
1h85ggv/cmfhD4l3+r+TTuLIpSGO9T0i1qTKrBgsEEDb1qKCnQtfGHxPLEKnpkAs
Enslz6nwlX6IO6OsLvQeuxiawiCroviQskQqhSaI9lqUWo8U5JRQ241XtjvIE+Sb
285qqQY8IhIhRaGhIzdiNrIOjJ43dCkHKBrFSMNOfwLbIeFZnYSNfeJK9vulTcq1
PIYKj6T320fkS4y2dwq4Dxmhu+BpiJZzgC9DeDDZjQAjQ5Cat6WGNGHAO9QTDlaf
YsPTbWp8xfzEoXayKFYxL13LcfN4LTF+RUteDre5OtOPc98yncmA0zkY3GcJy8bx
IvysP/C8/nwU19moUTSEuXRaFJmIP2tHVD5vwl+6sL0dFqofLY41iCaUIZY1HH4d
0zbgeVLIDIRiBWQXAoB2dzZl2tpq4e7qtkvIwo3t/g2F+X3PSBh8FhepvGeTCmwo
jmnQUxMHymwbHghxLEv7oIOksykAKy9Y46kkv0aZQKxf6ZSmafXhHfy1wzcDIDfv
Ccp8oMBy
=EEqW
-----END PGP SIGNATURE-----

--a6pixnfpycuirtiv--
