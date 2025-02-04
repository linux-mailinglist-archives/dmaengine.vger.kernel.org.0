Return-Path: <dmaengine+bounces-4266-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D6A2760B
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 16:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CF67A0FAD
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B9214236;
	Tue,  4 Feb 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoN5abod"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4E213E90;
	Tue,  4 Feb 2025 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683395; cv=none; b=dO+opSIwvtpMgELelbxM36VAYNGjYvmGlvsKJDk0R7EPOHixQBoUHTV449acoZQ7k8rGOR2rXnSRHhRnbaJPSA+JEKgAI2rG4wJCsgy4fS6f3nEejqAXbDY0WHTEqk/8vjSc5zHMcoBcloeABaf9xAcfqNgk5oZ3jsLSDwriSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683395; c=relaxed/simple;
	bh=Hperjmt2vFY8V7jP1srdf54/2dxyzRb2naI2WZdG0o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/TXascUsorUQaUxBjN8TiEmVlOihYC0cTHUqtRGAA5iL0RbJMUXTCg+Cr6x2Sm9EvM+tNd9B+E44NPAxFRy9C5X43rMzfOAA6SgtwpLvGOGrnTEoL7mgtYwIeqRMPHIpmRUWXeACthBS61im4TlRfuFSelbhOyXZWayxa7VXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoN5abod; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436341f575fso67788525e9.1;
        Tue, 04 Feb 2025 07:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738683392; x=1739288192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6yfhdfuu6Jne04lXzCONZTO6jud9pXKpEXOoexC1v38=;
        b=NoN5abodXK5oGSB06E2pHmJ4GgJf12Voc7uNbEydOMrZvOwwq2fhnyWtJsdKm9Hywm
         tVlW3aWmJsLr3AvfTyq6rcxGYgXsi7/kpa5zD3+JOxPc4stgMb5QFU5bvxbgcLkI1GFz
         UOyHsn6NJkR26FlC8Dx7PXhK4Vt0d2s39GZPlcGOJUD5Juf/hCmWZ7se+1nWidItAWNV
         6xfUYpEGdVG3YMB1WcTqpYX3QhacTCsiTLf+GMaRYENQDAcpxqX+vawgmtsom/53YHPK
         NC70yJvKlEWL905eB1ZscggewSVd68g+Q7B+hy2SpHl2wMD+RItkXWTdd8ZHdzvcD8JO
         4HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738683392; x=1739288192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yfhdfuu6Jne04lXzCONZTO6jud9pXKpEXOoexC1v38=;
        b=lAZ8T97mbvMqOAH0065+KN8cWc474KsFMhIu/zsifw3Z6884f0auK2KGe+JTUJ8kLY
         arH7d62yPFMeTq61nRRCpbEplxC9+pYseqIGAGapnpowrB2a6mXJaN8ogoF7Stg8NnbF
         xiDdkBsc26b3LA3P2qeKMPipB7sEYF4QSsBGL4ac+zD2EhCbT1E1rs/IrXwnFC8aulix
         D0kcwT2Sr+PP7IWa3Qj3CUYvRrw9K9dUdjx8mnIFXy8rZvbQogd8BWtGjs5t6HBDKwPC
         U/eSSRSYyIcCyiNJlXIkdG7TzwjOBR9pbSv/0KzH0KTVXoeRqBA6vLCUFAILQZbME5Dt
         QLvA==
X-Forwarded-Encrypted: i=1; AJvYcCU1BPhwuhXn1dOHkw/YWPfrY1/p/ceAS4G0413BCRijhNupSJ2Kc/+G9rcD73gWG5HCcQCsEpyonzYaRhMT@vger.kernel.org, AJvYcCVGMMmQ8pyhJ3cCzPu3DLtPC/X6shg7/jgHXC6fN4KwkszZCwqAAOGn6+DNE2m8MBBHsWR2ge5Y@vger.kernel.org, AJvYcCWohQ+CMrcgjEnLqbqKX47aRkTDPHun7pMKdSxM7vuRz8GPGt9/cDNSI8kxG69jamxqiq5EAyMpepU=@vger.kernel.org, AJvYcCX9YL2x8vWk4eJSO4px2A6oWjNlQcEM/4PCWPr15TmWm7JA6mlDwUkFac4B3bluuzcLUG+Ex0W3yuQjQfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygyMlMehbRzz6j0VobC/IeQNKrOn1ZDwLMHUn80a4TLDs+9Lky
	+tac5dyZyKzxClCAS6peVg4ZY3yA6Gd5SFbZhZk7NCiNaqFxYZcB
X-Gm-Gg: ASbGnctiJhertZ72ChBOrGF7iZJ/4AVmMpmJB8tyPcoazkrjmSTzEXpNzK2RzXUNvaA
	kjp4I72YS/Bly4wO97m7439R2icwg/eMXIZkPqkHKKFNfqUBrodcMnYL86mX07uX8VtgVSTuHCW
	51a+7Yz4YN8Xj4sY2UezBBWVSIeMnkxeXR5iohW/wtYoEEE27jUw73tPJsAbPdoi5jthxPPDBXt
	RaJxukAAsI+3LA7G5Xyx99lQdFt66glWRltaU15AyPxrJelvaU7V9zNqeB1aaggFM3HfolZuLcI
	Ephp+kTDCczRp/qctulSCWXamUiJU+YNjf/IT9uC0XzMWbzaZV4Cw94xD5cE4fbP56K+QRRqmqX
	O3A==
X-Google-Smtp-Source: AGHT+IHHb0F37JA4DghmanO5lvxkHhYtOLWV4Qig4WpmdgfCxNk95q0DUf0KBslAz5XhKw7iztyrNg==
X-Received: by 2002:a7b:c5d7:0:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-438e07cd500mr214704025e9.22.1738683390301;
        Tue, 04 Feb 2025 07:36:30 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244ef41sm198097785e9.32.2025.02.04.07.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 07:36:29 -0800 (PST)
Date: Tue, 4 Feb 2025 16:36:27 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: vkoul@kernel.org, jonathanh@nvidia.com, dmaengine@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
Message-ID: <dsxaisxdpsxecyna527cifixyurmkgo3cfaiheau5jjdl5qysp@64qquncxdmof>
References: <20250116162033.3922252-1-mkumard@nvidia.com>
 <20250116162033.3922252-2-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="thw54jjy27rwk2q7"
Content-Disposition: inline
In-Reply-To: <20250116162033.3922252-2-mkumard@nvidia.com>


--thw54jjy27rwk2q7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
MIME-Version: 1.0

On Thu, Jan 16, 2025 at 09:50:32PM +0530, Mohan Kumar D wrote:
> Kernel test robot reported the build errors on 32-bit platforms due to
> plain 64-by-32 division. Following build erros were reported.
>=20
>    "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
>     ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
>     tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"
>=20
> This can be fixed by using lower_32_bits() for the adma address space as
> the offset is constrained to the lower 32 bits
>=20
> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@i=
ntel.com/
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> ---
>  drivers/dma/tegra210-adma.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 6896da8ac7ef..258220c9cb50 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_device *p=
dev)
>  	const struct tegra_adma_chip_data *cdata;
>  	struct tegra_adma *tdma;
>  	struct resource *res_page, *res_base;
> -	int ret, i, page_no;
> +	unsigned int page_no, page_offset;
> +	int ret, i;
> =20
>  	cdata =3D of_device_get_match_data(&pdev->dev);
>  	if (!cdata) {
> @@ -914,9 +915,16 @@ static int tegra_adma_probe(struct platform_device *=
pdev)
> =20
>  		res_base =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "globa=
l");
>  		if (res_base) {
> -			page_no =3D (res_page->start - res_base->start) / cdata->ch_base_offs=
et;
> -			if (page_no <=3D 0)
> +			if (WARN_ON(lower_32_bits(res_page->start) <=3D
> +						lower_32_bits(res_base->start)))

Don't we technically also want to check that

	res_page->start <=3D res_base->start

because otherwise people might put in something that's completely out of
range? I guess maybe you could argue that the DT is then just broken,
but since we're checking anyway, might as well check for all corner
cases.

Thierry

> +				return -EINVAL;
> +
> +			page_offset =3D lower_32_bits(res_page->start) -
> +						lower_32_bits(res_base->start);
> +			page_no =3D page_offset / cdata->ch_base_offset;
> +			if (page_no =3D=3D 0)
>  				return -EINVAL;
> +
>  			tdma->ch_page_no =3D page_no - 1;
>  			tdma->base_addr =3D devm_ioremap_resource(&pdev->dev, res_base);
>  			if (IS_ERR(tdma->base_addr))
> --=20
> 2.25.1
>=20

--thw54jjy27rwk2q7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeiM/gACgkQ3SOs138+
s6EAhQ//UuOqtMwn4ZLx9RPtnBdcZn+Wg7pQsAmcr0XD4jHnYolpSfqmsPV2zTtP
O75WWbyRmVKnbptotIqINN1iya+U68KFYMP6sdkc+jZMj7q/SwU4oAgWpw1p3aZx
FlPRGJ4z4OkdbJZLJm97yslvtSLs4s1e+xKtryimq012yUkJ87hzxNMZgHx8z5Cn
SM4DSHZ9KN9+IBzRBU2hQffcMk25xeCIb6mH/+TbOQTJff+TqUc0X3G/EXgGUHF3
B0ZzfcbtMFKH6jqWBX9kvr0KKgNkgk8SqYlURIUdt5kFiQwWT/SXqh+pxodLqHfk
1lc295BrT6bt9siTMEUll1n8DHvuvgaUoSTKqTGjZD29tolMRgXde/O3ssSGMIvO
phTTHef2IKT2rHC0zobsPYosyqgKvvdzq+dtUCDqQ4eF3qBaomt1eZL1YKiWH/Ai
lP4C19IZ+nsnk4Xk0Da9M948ZkSdIdm/fKaK6WZOPphC73y4k6YG/FQ3uBcMe1DI
qed0GwrIWD9GQcTOq/uIzQV2RJ/tCGh2HoJ3MUVFV2hK9YAQnq7hyM3n3mjNEOw5
Wh//M1hJIP13WnItRKmjMNUoHGiC3DxNEl5F6ie20k8ppjPsT04Rc9/kwGQfMJJr
7CRdc1wVurPd7nN2uTmaNtWzohKSOLHRhbFUE3XOZsjF0a9WdqQ=
=kX0N
-----END PGP SIGNATURE-----

--thw54jjy27rwk2q7--

