Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F900458AA1
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 09:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhKVIsR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 03:48:17 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34659 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238847AbhKVIsQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Nov 2021 03:48:16 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B51DC3200E91;
        Mon, 22 Nov 2021 03:45:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 22 Nov 2021 03:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=IEQFLYmwMPm+QnJiU4zImMcu/1U
        6t6+5t6Sfxd7594o=; b=Z3DT7q7a1nfcJhugd+NnEVHYsagN45ODpa6vPQAlJ9R
        AwX8yvPSpgqTKp+wGtQk85oSO9XyiumqqBBYqIJj5zK8XltBcytKch/jE5hNmbqL
        GZLk5elidg7zvV47tRGBmRrUKqjK/huqkUlSmZ7vJT0HATmq4tXBPM1utwN8utkb
        gzMlt42xodx1+ErnTuCmrIIfcif24P/u51Od85bbbQVIQGTGr3xn3a26rp7d2+OV
        h35WyXeFm9UfgPvf2iL/SW/vgA2KaKtmKidj3cZGvQ4rO/mRIje39OrqZ3RiCryj
        qkL7uQfJjndShgu69Da8DeWoQ35lHUoPT02jsaqyELw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=IEQFLY
        mwMPm+QnJiU4zImMcu/1U6t6+5t6Sfxd7594o=; b=F13FPfU93S1oq3hZ3JRXDj
        u9OgxmQ0bANgLDzF4pGSqYTAbjDuqAEkoKfqPfAF+kInTQLSjZqc0y7Y0y3KSFoP
        PZlnlf1EeZ7JDLhS6cWXtDTyMxmCunLF1F4elRiaqvGCyJzBj/DhV57AtJZZCbJp
        EPam/ZWrzNZswMSVbimbiRj1FlJ3rJ2/vzQuCmItN7IfscP7Z8rerFJ/bXl5/L/K
        BG+xKetb8/JpUnpjRkcvAxRzqTLyBReee5YclSNSZ2fK8qXJL0jeOLwrcRknk3Wy
        evRPAVj1Rdz2UaFiF1uv/Osi2qE9quzTtoOLinz9DUBYY+QrVoEJKup8dh5X1Lrg
        ==
X-ME-Sender: <xms:k1ibYaIgMPEz0bSgchnu15xWm_EtRQ_F-gc6hbEysFW3PFzuvjMQ9A>
    <xme:k1ibYSKNHciI1tPTn13vueDIF2Hr8q3PUW-YYK6Cquev_XQIsiRVjmIA-TfvMauAK
    aOoqvwqlhhxualGeNM>
X-ME-Received: <xmr:k1ibYav7GVDlqgR-Gy8yae0tfEqhZwZrNs1l5RkkU0QWgVVUNwogwIf_d9vQ0V7-LP5snZMtk258ZvQXJFzdDmDYFCPLEEUtUro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeefgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:k1ibYfY1swP51FYp9KgqukI-vCDZnbS3x_AULgSXEGwnBlDQVF_JVA>
    <xmx:k1ibYRbC1OT00tC7WSQcSJUyW_7dj6aFJc39uf9zzGGNMWTC38zlfg>
    <xmx:k1ibYbADJRZjtYtYi1q0okSGVMzaI9FSL1kzuW5stxsr_ykU9LBsqg>
    <xmx:lFibYWPyTtLyLc5BtSUf3TC3UNDEQ6m_nPK3LBCoG_gzWbhT0XbfAA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 03:45:07 -0500 (EST)
Date:   Mon, 22 Nov 2021 09:45:04 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: sun6i: Add support for 34-bit physical
 addresses
Message-ID: <20211122084504.5picqz6xxaiup6tf@gilmour>
References: <20211119052702.14392-1-samuel@sholland.org>
 <20211119052702.14392-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7inek6mjn4muxwl4"
Content-Disposition: inline
In-Reply-To: <20211119052702.14392-4-samuel@sholland.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--7inek6mjn4muxwl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 18, 2021 at 11:27:00PM -0600, Samuel Holland wrote:
> @@ -645,7 +660,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep=
_dma_memcpy(
>  	if (!txd)
>  		return NULL;
> =20
> -	v_lli =3D dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
> +	v_lli =3D dma_pool_alloc(sdev->pool, GFP_DMA32|GFP_NOWAIT, &p_lli);

This raises a checkpatch --strict warning since we're supposed to have
spaces around the pipe.

Maxime

--7inek6mjn4muxwl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYZtYkAAKCRDj7w1vZxhR
xXcRAP0S6BzQLRMjoeNCFMCmHaQ8A9vR83TuAg85HtLWJIrgrwEA1GUWojfLx+Ns
NRB9aejX7t2F8h/xA5GDox29cy3gIAU=
=L02M
-----END PGP SIGNATURE-----

--7inek6mjn4muxwl4--
