Return-Path: <dmaengine+bounces-10728-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NqjHjAzEGqqUwYAu9opvQ
	(envelope-from <dmaengine+bounces-10728-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:42:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5CC5B25D7
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75885301B3F3
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3C3CBE7C;
	Fri, 22 May 2026 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQrTl8lh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEEF3CB916
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446272; cv=none; b=rtzpKxe3M9kXT2UVb6RUqXsDCNZMTSOLGhjaBY/24s4XFyHnGYf7iUolt6MuAhaZh2I99YCYseFmCAyU6X0ZNRo7lb+NH+rx27F2Iyag1550+ktom9evDYro0B4f6KEiQCo0ONa5bu4OfawsJBwnEUGlU4yDzGbxmjhALyFFh0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446272; c=relaxed/simple;
	bh=xmvYCQFNtdHb9SAiwitPLZkSLacbtKoh0Ho+lnvKGbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0DeQjhaHe31ZaPGFADPOdJRJoL+BOiIs3/3YBulP4TdnHY16CeZ2fpXgeJK+rAzbdBAlaMiKKbaYq3j6QyEIXpd0dX3MWb64AbaMO8Q4k8O4Upzpjnxks+A9YS5uAiPMC+jLz6l5xmXBiIt+uSJMoqzxmOMTQZ82+woR2lR1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQrTl8lh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so9586705e9.2
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779446266; x=1780051066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEhebhuCV6jMeZvMs5spESVnf7KoklTppjIaJgmVf+k=;
        b=dQrTl8lh5fbHe5/Ifg/PThU/8J2+FV4KBWLt++ph86R7tvmB4gpLzWiE+ZgU/2jNGo
         5drfN1Hm4ydcXKZCZl+rYR+tAoRFRbyLkn6s9UqhJgzkQcvdU8Gmn9yNy9QslmxL/gpu
         bELhiuXKrVq1sfG32kMipwt+g8IqXMTuUHERTu9ygV1Xz7zBNP7Xh0cOgdPQ55V8YSr6
         1ShH3PpOmujiAcJEALVGtJK/6zGEPped/GZAPmEIywLCmiRbXdkQS0rryUETxxCTjHfy
         AogaUj3cczA0mX65NYU7jrhEBTWTTGfRoC5jExF/JIN+k/SMse20VQtAmfTHj29eTRtl
         aXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779446266; x=1780051066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEhebhuCV6jMeZvMs5spESVnf7KoklTppjIaJgmVf+k=;
        b=pVsK1UxaZnIJQCo0RBnHJjcAYW1Ik1F8IkXixpmkebwAAwdTqYa9KT4za88KLVrQj6
         dVz7PGKvT74KvkJhpO9djimZ8s2bm4IC7INs4Van1cRb76KoOUE0u2dvHlvqiKUNJnda
         Hy7ft6e1wFiImPbUN7ZGHOZTh+cZyQ+mFAv2WNETBoCMRVgq5oUTs7j6ANzm3+onz/4W
         m53oNFpECmH//XOuKdYdfPZIpzIhc3ojETifOxWXXo6VnJu6g2AG9u3pGmklRFHIhZk7
         sWJcL1Gpgq4iemjvOTqRHJNVxlbzraCloDUYxsa+L9VLEJG3zGYbhlADgLuhgorRCr6m
         MjBg==
X-Forwarded-Encrypted: i=1; AFNElJ8ziY+8/WBpozHUiqN+wPKh8NSklWj4T1YxT68aiAdd0AGWpmrXxI1+U5KSE/yQI5d732LFAgHvknY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqBabkvDiOHkShXUioBvqhcYDOpNIFSYKYuzz70I8EUsJBGdY
	H/xEbSDDMpzP+tpTnn8x6P4nFl5D55+BN+DCeWoD1zzo2jwnK3FzE2D+
X-Gm-Gg: Acq92OE1MGoPLuEa9M4QljGtExuLC4y0hmF8PNLvwSxizUhGZDSkhyKvzqEYVzSkyKx
	7yq7H19OXXF3nToe95H+vqFGJFAFucxplOvrQtDFdkceyX6ATqD5Th8CGyYNXKY0t71sisA91YS
	alyhsuHiUeL/H169j6uJKK7N2scTvrs5P61Fzphft3Lp/K0lhkKuXA6i923gRIsGQ4lLKicMVxP
	ZORHpF3aklLHYuzI0aHxdBzbeHndPgPo/LdtJ5V/QhWsqBP3At5gtlagOb2FRnG9xHMP3QK53I1
	KiaVfp48MH1bR8R2DmVN9zQO7a9x+bztDp7N3iFb1D63Ooq3Y+kNRmy1GwI/sYo3W0dT78wvCCG
	oQsgnIHNV3zCag8uIqInGR9Nb+EOfTcD7kMMXu+Ulv3a6yQ684N16h7cq4vLqjhmV9q8+Uflm/C
	l4ilXB/mjiv9smaxCbbkFcl7x55zInsUN6IBZ4BiUp+vLPNFZ+tNlypBYWX8TpLj8LngYpLyeDQ
	HlerFTM1JU5SA==
X-Received: by 2002:a05:600c:5298:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-490428dd63emr39137895e9.31.1779446265889;
        Fri, 22 May 2026 03:37:45 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b9asm33058255e9.11.2026.05.22.03.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:37:44 -0700 (PDT)
Date: Fri, 22 May 2026 12:37:42 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/10] dmaengine: tegra: Use iommu-map for stream ID
Message-ID: <ahAxVwpUJES7NB8q@orome>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
 <20260331102303.33181-9-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ioswetuwxrwk65qn"
Content-Disposition: inline
In-Reply-To: <20260331102303.33181-9-akhilrajeev@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10728-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierryreding@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5E5CC5B25D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ioswetuwxrwk65qn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 08/10] dmaengine: tegra: Use iommu-map for stream ID
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 03:53:01PM +0530, Akhil R wrote:
> Use 'iommu-map', when provided, to get the stream ID to be programmed
> for each channel. Iterate over the channels registered and configure
> each channel device separately using of_dma_configure_id() to allow
> it to use a separate IOMMU domain for the transfer. However, do this
> in a second loop since the first loop populates the DMA device channels
> list and async_device_register() registers the channels. Both are
> prerequisites for using the channel device in the next loop.
>=20
> Channels will continue to use the same global stream ID if the
> 'iommu-map' property is not present in the device tree.
>=20
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 53 ++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dm=
a.c
> index 9bea2ffb3b9e..cd480d047204 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> @@ -1380,9 +1381,13 @@ static int tegra_dma_program_sid(struct tegra_dma_=
channel *tdc, int stream_id)
>  static int tegra_dma_probe(struct platform_device *pdev)
>  {
>  	const struct tegra_dma_chip_data *cdata =3D NULL;
> +	struct tegra_dma_channel *tdc;
> +	struct tegra_dma *tdma;
> +	struct dma_chan *chan;
> +	struct device *chdev;
> +	bool use_iommu_map =3D false;

No use in initiazising this since you immediately assign to it the
return value of of_property_present() below.

>  	unsigned int i;
>  	u32 stream_id;
> -	struct tegra_dma *tdma;
>  	int ret;
> =20
>  	cdata =3D of_device_get_match_data(&pdev->dev);
> @@ -1410,9 +1415,10 @@ static int tegra_dma_probe(struct platform_device =
*pdev)
> =20
>  	tdma->dma_dev.dev =3D &pdev->dev;
> =20
> -	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
> -		dev_err(&pdev->dev, "Missing iommu stream-id\n");
> -		return -EINVAL;
> +	use_iommu_map =3D of_property_present(pdev->dev.of_node, "iommu-map");
> +	if (!use_iommu_map) {
> +		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id))
> +			return dev_err_probe(&pdev->dev, -EINVAL, "Missing iommu stream-id\n"=
);

Looks like checkpatch.pl would complain about this being too long.

>  	}
> =20
>  	ret =3D device_property_read_u32(&pdev->dev, "dma-channel-mask",
> @@ -1424,9 +1430,10 @@ static int tegra_dma_probe(struct platform_device =
*pdev)
>  		tdma->chan_mask =3D TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK;
>  	}
> =20
> +	/* Initialize vchan for each channel and populate the channels list */
>  	INIT_LIST_HEAD(&tdma->dma_dev.channels);
>  	for (i =3D 0; i < cdata->nr_channels; i++) {
> -		struct tegra_dma_channel *tdc =3D &tdma->channels[i];
> +		tdc =3D &tdma->channels[i];
> =20
>  		/* Check for channel mask */
>  		if (!(tdma->chan_mask & BIT(i)))
> @@ -1446,10 +1453,6 @@ static int tegra_dma_probe(struct platform_device =
*pdev)
> =20
>  		vchan_init(&tdc->vc, &tdma->dma_dev);
>  		tdc->vc.desc_free =3D tegra_dma_desc_free;
> -
> -		/* program stream-id for this channel */
> -		tegra_dma_program_sid(tdc, stream_id);
> -		tdc->stream_id =3D stream_id;
>  	}
> =20
>  	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
> @@ -1483,6 +1486,7 @@ static int tegra_dma_probe(struct platform_device *=
pdev)
>  	tdma->dma_dev.device_synchronize =3D tegra_dma_chan_synchronize;
>  	tdma->dma_dev.residue_granularity =3D DMA_RESIDUE_GRANULARITY_BURST;
> =20
> +	/* Register the DMA device and the channels */
>  	ret =3D dmaenginem_async_device_register(&tdma->dma_dev);
>  	if (ret < 0) {
>  		dev_err_probe(&pdev->dev, ret,
> @@ -1490,6 +1494,37 @@ static int tegra_dma_probe(struct platform_device =
*pdev)
>  		return ret;
>  	}
> =20
> +	/*
> +	 * Configure stream ID for each channel from the channels registered
> +	 * above. This is done in a separate iteration to ensure that only
> +	 * the channels available and registered for the DMA device are used.
> +	 */
> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
> +		chdev =3D &chan->dev->device;
> +		tdc =3D to_tegra_dma_chan(chan);
> +
> +		if (use_iommu_map) {
> +			chdev->bus =3D pdev->dev.bus;
> +			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
> +
> +			ret =3D of_dma_configure_id(chdev, pdev->dev.of_node,
> +						  true, &tdc->id);
> +			if (ret)
> +				return dev_err_probe(chdev, ret,
> +					   "Failed to configure IOMMU for channel %d\n", tdc->id);
> +
> +			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id))
> +				return dev_err_probe(chdev, -EINVAL,
> +					   "Failed to get stream ID for channel %d\n", tdc->id);

There are also a few very long lines here. Make sure to run checkpatch
on these patches and remove all warnings. For dev_err_probe() some of
these might be okay. Otherwise, one alternative might be to reduce the
nesting here and push the inner "if" into a separate function.

Thierry

> +
> +			chan->dev->chan_dma_dev =3D true;
> +		}
> +
> +		/* program stream-id for this channel */
> +		tegra_dma_program_sid(tdc, stream_id);
> +		tdc->stream_id =3D stream_id;
> +	}
> +
>  	ret =3D devm_of_dma_controller_register(&pdev->dev, pdev->dev.of_node,
>  					      tegra_dma_of_xlate, tdma);
>  	if (ret < 0) {
> --=20
> 2.50.1
>=20

--ioswetuwxrwk65qn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoQMfYACgkQ3SOs138+
s6H+LxAAvJAdB4gkHH/VReijvfuBRUZI8hgE0C7QRu1SO/IkqBuVM7HL/IGYYIY5
7IynUar4cZB+OsIX9TbFp6zB9VLjF5aRC1ndZRgey8LZdhv34U67s8biyaXw+qwe
moHoFKmB1nju2iDoHu/xjV3KuZdSiRxLqSZZVnq1smixM16Y8z+finMhOqJ3tCU2
kTRMsL6EfqhN1eR2fruDlq2LrRVlOg2VWAMxuNcDavWyvBr71RuE8U6bBE123D7x
rCBSe99e3ugPTkVMNeSNAUeT6X01nXMta5a+MWsSQzf1webFdq6viJ1yj1rubj8Q
++jg58C4vjLjiQ94B4ahN1OQ/skCTcbH9e6Zb2FemZedW05PlTPjp3G1JLAJr9Je
kyf3IYoR+GisKmBL1OofWlNSqtLseF1Aml6BehQGrFGyCSQVLz0AbSepmHMdryk7
eGlC1c8EXFYSF6P7pRd6y9O30F/nCzPdXTLTWF1W1K/kB+flL+ediLlatogP3WHQ
0QvjBTd4/z20ixHWbdsE3qNx547ZHm4jRlxLzPAa6KcQyYaPYYeHa8XMoP1fPFbs
NA1qsXBjNWnw5h+KqYvZdGy81rWECwYYQrjLb+j5xfzhyqDrWF5maicbYpglfDQg
XThxzbRHx0n2WR+dM0zp+1uADdemXw5/8x4KFpC1GRHr1+EDLVA=
=j0ph
-----END PGP SIGNATURE-----

--ioswetuwxrwk65qn--

