Return-Path: <dmaengine+bounces-4296-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7272CA28B9A
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 14:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0960E1680FF
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 13:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4464478F34;
	Wed,  5 Feb 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2i2/T+x"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C06A32;
	Wed,  5 Feb 2025 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761932; cv=none; b=a4TubQoL7tGIdNGgC9eamKVFg7/Abc3bgqtB1ZJLvu3CR024x3rj5B/nkgaybc9yi0Sp4AFZ0vbxJRBKPMvdbOw1EEKrfqy8tizt0k2LyvhGG88+p9fASnqXWPq+o3ASoTF+TmvSlsgak7+CVF6+foAfhWPiaXvah3k3WJt0mbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761932; c=relaxed/simple;
	bh=XTWpsRnRWTE25zA+sBZLSSQCyCjLU9XZs7GYTp+7VI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5ldCDTsbF9dGQL/qqdVgE/aV+gkoLPkVZMqBZm1KAARio9rUOIDMbG3WOiPk2TJ5RVNn2zlxGly0jskAybQ8xbFLUGskF9WelBOXeRy0cnIwDAfhUfoCVSKH0H1BynfkCQDacekrZ18QVp/hV9vnrU7SMcxUJLw1P6amMtFxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2i2/T+x; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38db3a3cf1cso379702f8f.2;
        Wed, 05 Feb 2025 05:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738761929; x=1739366729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9z7DdXznA1NPfNDcjmpeCDs9eaXj/Q6qJq8JgsSWe+0=;
        b=a2i2/T+x3VPR/FtfDmGpaLJ9Qs2aHFnLQKAA63TeP+9FhEDv1EdaTTYy12+qujLZZ4
         0MDP0Szy8c2qzKT+Kzya9rEm2wU4qZdZxPGGTByNMZ0kUEFc7qXG1k/3O5ws9VSsl/cR
         cIqGFPTc5kemYaIJGtrB07cUSU6HbyiD226JlCCMXNsLjiMWVn3TgZzmm90WEfqLJguX
         TJ4o+LsAGQeO7Y2VhMYiZFe/bYcdyIYmPDfeEjDmgs0fqlKWlxkuTxzGGmnBIf5gHl/a
         6Ov7JDj0k3A2mmOCY/WLXCdLMCopMFO7jiEc2dzYoIHL7CwruQoEX1Ek+oJwjVrnXCh5
         1rGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738761929; x=1739366729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z7DdXznA1NPfNDcjmpeCDs9eaXj/Q6qJq8JgsSWe+0=;
        b=vPYRCiaD+0LBdEAo6DrgHE6FfEe6m8M+AGhhj5GNb+gJad3BsF8MNVw3halhza5kc4
         n2iaHdgddHSsFnytmdmrHW79c6L7FVjOw2ksfi3521BrTDYVaTmR8dIEyOj3K9dXVyvi
         mT6r6JO6o7gVF+OKViScHc9j4tRefFRt8UD+GOH8Yj1MFn+pITuwtayECwGzZatb1kos
         AU0m7+ZBmGqMxtCF7SPNlHJdiBRZudXF9AnpfW2aDXoAWEfWpQaqPIU9ygSqkXmx1lO0
         wximbybhhBtTX5/4QanlyoVjn6bMovoombsCNTnOt5N3/LN3JNXyNCW074w3oAdJqYV8
         w3qw==
X-Forwarded-Encrypted: i=1; AJvYcCUa+EErWwVtITcytipahZ1KmUM6n3rOvtqz5aY1NB7VBOJsoc1LflZb01dSHjH4vclcIRUDeSAU@vger.kernel.org, AJvYcCVOmm1gl0kNtPIfpIpU9EKp58dGfLAkq8EVBfJ590uGsx1VOh8/TZqeOWPU3QqLDisrMQwymvx1PXE=@vger.kernel.org, AJvYcCVblGkXzxTHZtU8NSVHaebx/kEUjLtyTRfUJ00DxzsRwKoVPwKdhVFbjvsjIn+JEyC5IIKfS57/ezjj4W8=@vger.kernel.org, AJvYcCXvas4c9wiGD34R50aF9+5GT85AK5D/iS9JF63rHJR1Hc7fO+sfQ5IlggdlsnIUcEBiV4wgasRhCRcX46In@vger.kernel.org
X-Gm-Message-State: AOJu0YyOZ4er/o7o6gn75ypK3PEbfqd5YtQhjW1dNJlonLJnaARdenqf
	hENGqtb1/pfvEvtrJMfQSxBAmIESZV7aX3qlfE8f/ht2ls6mrpBSmYG2Wg==
X-Gm-Gg: ASbGnctKc0RKMdUnVTcbXghFYHuysj7hlHZmeYEHfwK2NEvUWiCkmfC0Lq12/SVImQe
	kK36N12Wf/HIqAcNiFKU7aweKfqvSzJTunMiTtl1GjS0zXJf83Lphkx77eWW8iOTHzFi0E5p3pv
	/EGjJw6GltC1DLNKhePvZn5wQQW+v/XjkoE0vt3M6XmAUAf6lpiDnbiWF4RsYB8ZoOMYaw1EXb6
	o6nGiKnomB23yY6gZoQC68pEgyNzoT3x2uy8VQfXuv4YJFb5RkyS12YnYEhKm266rmCINNIQ2Uy
	/XQYk1qLcJOrfO7b3S4NTRc62rxaG4Bs4ax48AKtuQhgt/zdQkdZS8Eh5ohbojcH65waBcq2jZl
	UIQ==
X-Google-Smtp-Source: AGHT+IHUBt2rp2i3M8mYb5bJFk4lrrrC/GEjyWqApC2WTrWyibF7rX+2e3wh7EbnbRI8LVlXCpOYMA==
X-Received: by 2002:a05:6000:144e:b0:385:fa2e:a33e with SMTP id ffacd0b85a97d-38db491f375mr2205155f8f.43.1738761928493;
        Wed, 05 Feb 2025 05:25:28 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0ec369sm18564600f8f.8.2025.02.05.05.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:25:27 -0800 (PST)
Date: Wed, 5 Feb 2025 14:25:25 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: vkoul@kernel.org, jonathanh@nvidia.com, dmaengine@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dmaengine: tegra210-adma: check for adma max page
Message-ID: <hp2rhfbnaapaje37bb3dkwzq4736a5wtpw63s3khbxcbdfrdvr@kzoyp36apstv>
References: <20250205033131.3920801-1-mkumard@nvidia.com>
 <20250205033131.3920801-3-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="en7ozepq526oravd"
Content-Disposition: inline
In-Reply-To: <20250205033131.3920801-3-mkumard@nvidia.com>


--en7ozepq526oravd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] dmaengine: tegra210-adma: check for adma max page
MIME-Version: 1.0

On Wed, Feb 05, 2025 at 09:01:31AM +0530, Mohan Kumar D wrote:
> Have additional check for max channel page during the probe
> to cover if any offset overshoot happens due to wrong DT
> configuration.
>=20
> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> ---
>  drivers/dma/tegra210-adma.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--en7ozepq526oravd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmejZsUACgkQ3SOs138+
s6FeJw/+I3AWXx8z9F1KMy4kC+WqrmyGv5HHdQKZzlL6zyoZXOr9BJJfx8Bw4zkO
xnsiG1Uiy8MXfXFvezMj3YtWBbf25jIG9xbQYLTLd86IK1Y7JnQr4zCNNbxLH8+K
jzfmIp5W8SNVE6pehnyazmGwNiFowMGxVBbyDftaCWVEZh/zXDJqe7ycB7ZBRDA3
haObNDLa91r5Wd9vp//xLBLONt3kyldF/AMujJ8OMcTnSr9Oh9OcdFv15XWY2qh6
TxI6d7ZcGTL4AIZoxHo5dDWnH4/iZhpPWDN66bosQ/jv56XeOPEaVjXiEzmwHx2j
pr0pQrhSm1hzWrkyurOD1eobjjnSwgNpqYN58giz5I3QqdFo39dA9J7B26udx5M+
irBDt/GWmY8UcD2uRBgiaVVPdiIFsh5hCSaowIFNlNuwV09e+FyV8jFxYrgPLsv0
uQeVySjI9cHfVv+N48VSQbxxh7UUo65/WCP31OpkKlAoY0cy36gAibvdO7PRieX/
C7fmwQtBaoa40zFaivRQ21ZGFH1or5dtshVIUfyTQNSAhjKyMy85bjQSSJMONuly
3cOcozs8BE4CZ0q43sVUUqoGxJ/fva9CvpgAL1tH78B6ljgJKbxM1DMzwTrynxKa
3ovzHaKp8XoNWcY47pCLx8NWLjqEYG1otwGpy6wFXeBU9WVXdZk=
=wJHk
-----END PGP SIGNATURE-----

--en7ozepq526oravd--

