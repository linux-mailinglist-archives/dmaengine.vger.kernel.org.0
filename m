Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE2E68DFAF
	for <lists+dmaengine@lfdr.de>; Tue,  7 Feb 2023 19:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjBGSQL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Feb 2023 13:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjBGSQH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Feb 2023 13:16:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A473B0FA;
        Tue,  7 Feb 2023 10:16:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16D9DB81A21;
        Tue,  7 Feb 2023 18:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B253DC433EF;
        Tue,  7 Feb 2023 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675793759;
        bh=hyXPCMlpO7BwytLT5DV1xWv0+2q0jvjZX4T5MnllIuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNot2fP8+qrl20uC7aLd2k2WQ99VRMTB7di8BZJFBFz2A1up4MdDzlXsN9VfNUBDh
         OvfsbMsAJJ6yhcOc44mbPRMCdoXiSAz/8AL0VxfVuRvEyYimbrt0ycjvsHm7N/z8hw
         kEmjSAtxeGw0nwh7FL/myNOxI38jux/T8bWui7Tk5aw1ZVSNsAJJ/hiNeCVuLA7/19
         hNQsHWC6HMh+y7COle+7qMFaS5QyYnHHv78+6DYrg7yY5Y9ASDV3oeqsVj9wq+a2n/
         fouDliMttw82xgyyKRrc0XgEAiUHxb66LoxNwKZTSdaRGO8kUnNLKMSZll/15uucPz
         Tuk4nfNxioQVA==
Date:   Tue, 7 Feb 2023 18:15:55 +0000
From:   Conor Dooley <conor@kernel.org>
To:     shravan kumar <shravan.chippa@microchip.com>, vkoul@kernel.org
Cc:     green.wan@sifive.com, vkoul@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: sf-pdma: pdma_desc memory leak fix
Message-ID: <Y+KVW4o1ZXJHFSZt@spud>
References: <20230120100623.3530634-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CFXVfqSA5rCRtNup"
Content-Disposition: inline
In-Reply-To: <20230120100623.3530634-1-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--CFXVfqSA5rCRtNup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Vinod,

On Fri, Jan 20, 2023 at 03:36:23PM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>=20
> Commit b2cc5c465c2c ("dmaengine: sf-pdma: Add multithread support for a
> DMA channel") changed sf_pdma_prep_dma_memcpy() to unconditionally
> allocate a new sf_pdma_desc each time it is called.
>=20
> The driver previously recycled descs, by checking the in_use flag, only
> allocating additional descs if the existing one was in use. This logic
> was removed in commit b2cc5c465c2c ("dmaengine: sf-pdma: Add multithread
> support for a DMA channel"), but sf_pdma_free_desc() was not changed to
> handle the new behaviour.
>=20
> As a result, each time sf_pdma_prep_dma_memcpy() is called, the previous
> descriptor is leaked, over time leading to memory starvation:
>=20
>   unreferenced object 0xffffffe008447300 (size 192):
>   comm "irq/39-mchp_dsc", pid 343, jiffies 4294906910 (age 981.200s)
>   hex dump (first 32 bytes):
>     00 00 00 ff 00 00 00 00 b8 c1 00 00 00 00 00 00  ................
>     00 00 70 08 10 00 00 00 00 00 00 c0 00 00 00 00  ..p.............
>   backtrace:
>     [<00000000064a04f4>] kmemleak_alloc+0x1e/0x28
>     [<00000000018927a7>] kmem_cache_alloc+0x11e/0x178
>     [<000000002aea8d16>] sf_pdma_prep_dma_memcpy+0x40/0x112
>=20
> Add the missing kfree() to sf_pdma_free_desc(), and remove the redundant
> in_use flag.
>=20
> Fixes: b2cc5c465c2c ("dmaengine: sf-pdma: Add multithread support for a D=
MA channel")
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>

Just checking in to make sure that this patch is on your radar.
Is there something you're waiting for on it?

Cheers,
Conor.

> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 3 +--
>  drivers/dma/sf-pdma/sf-pdma.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 6b524eb6bcf3..e578ad556949 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -96,7 +96,6 @@ sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,	dma_add=
r_t dest, dma_addr_t src,
>  	if (!desc)
>  		return NULL;
> =20
> -	desc->in_use =3D true;
>  	desc->dirn =3D DMA_MEM_TO_MEM;
>  	desc->async_tx =3D vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
> =20
> @@ -290,7 +289,7 @@ static void sf_pdma_free_desc(struct virt_dma_desc *v=
desc)
>  	struct sf_pdma_desc *desc;
> =20
>  	desc =3D to_sf_pdma_desc(vdesc);
> -	desc->in_use =3D false;
> +	kfree(desc);
>  }
> =20
>  static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
> diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> index dcb3687bd5da..5c398a83b491 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.h
> +++ b/drivers/dma/sf-pdma/sf-pdma.h
> @@ -78,7 +78,6 @@ struct sf_pdma_desc {
>  	u64				src_addr;
>  	struct virt_dma_desc		vdesc;
>  	struct sf_pdma_chan		*chan;
> -	bool				in_use;
>  	enum dma_transfer_direction	dirn;
>  	struct dma_async_tx_descriptor *async_tx;
>  };
> --=20
> 2.34.1
>=20

--CFXVfqSA5rCRtNup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+KVWwAKCRB4tDGHoIJi
0pfUAQCRSYpj+UXdzwRJIDxnAY4Ex2piBHnUpqHXYSzu+uHbXQD9GzSXnoeUACmz
isahFC6JG6tJAbxK/VM7KbIzY4vlFwU=
=jO8h
-----END PGP SIGNATURE-----

--CFXVfqSA5rCRtNup--
