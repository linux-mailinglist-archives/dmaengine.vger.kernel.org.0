Return-Path: <dmaengine+bounces-5118-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F43CAB047D
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 22:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5040B9C4A0A
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 20:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507B28B7DA;
	Thu,  8 May 2025 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBSNk7kb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914B2797B2;
	Thu,  8 May 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735606; cv=none; b=SXrLqWoDlZs5vjDFVK60CNOxRvEUU6weQFDjBYw5geY4XwdZKhuBbTvxrndffSdcUNOcZjr4vP1wSnRFC/8VlHb+szmZdlYi8uEr5l1B+lx2OQXAqxT7WXg9viPlxl6hogjLP/8bc5Gj8PsaNzXd7BRA2ndwratV/LxhjYG1ooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735606; c=relaxed/simple;
	bh=Kc6hBLgzEa0uGFWYv6P3w8w8P0x5kfHcjBizEXHn1L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh2moiOm8ldXuiW5nkSkrnvkT6rM2UddjI4z5CHIYKZLVb6f1bCYiMTzEp58GLdXEEtrm7jKl6lWW3euMQkejLENg0PMr0ZZuTavpjw+UoG63P8yjaQR9woTfoLnh+WBzrdf7rYv4T8Mz70vlB0UtaqeD5uCuKajIU78TYhu898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBSNk7kb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2963dc379so227854766b.2;
        Thu, 08 May 2025 13:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746735603; x=1747340403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1FpAb0zWWKOBlHUezPCO5SYg/E1e3MjIvSD2IBmYGE=;
        b=dBSNk7kbcvnV35NaJrYhzLGdUUiHLOJFwjdklSU/GJ0GO5GQebbuikiRInC2UNc9d8
         fDk3C9kxyuBwp5Cx0mm9nSOc2oiGI8rzpgXbj2C9rdUJYkQibJbLQ19blF82Bm2Eu+RX
         VDiJJUs5meqA0IAhHFu621EHyyZrB3WiELKVSa4OXG64ToYOnM2plwjiQu1J3mGMWEKC
         TfHHmyG2yv2H958G5StX5R/XcuiX95dKaVFDAn/urS609cqO5x19Hnu9Xq+F2ta2ofsw
         fY863lmjwD50JMAydgLdZ1Xe4cMycx0NOQ/YhzUMoG1TQlZJSMF/UIo0WTYoNBYxZtLt
         X74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746735603; x=1747340403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1FpAb0zWWKOBlHUezPCO5SYg/E1e3MjIvSD2IBmYGE=;
        b=OV3EXOkCQmy9rYgTC07HrwA4YwFDx+1I9WEkk3msSPEJXPx5nFE+pLfwqVppVNr8w9
         l+FJMnnYo37SLIO+jmW8u/uuM6fhjXGi6zThds2sYZ9qXU66+WrtT6uM7Tg1DIlrYN7W
         fo9/ds8UsUJNcgWWROInUY+y39JuHeHyf7qbseCLnVIjaBNWIlhHiRiJb79bIOmN4nXx
         7+8LmFHWffs16rDUISvFiGxEW4OJLCRb1jwuiyJue9sfGBqOxZ80VOauwgKOy0U2Yiyf
         P4qMVs6dUODkuI4tG/RvrPK4kw2P9FUfHtH1AfZudPLP5/SegSUYTwIZvJHfn+Y4KGif
         fGHA==
X-Forwarded-Encrypted: i=1; AJvYcCWJkc3RnnqzbZZhPSu93VZmgWM0nEpJ53klno9bvcgCsL5yvxX+N5k9j+OFQ5P/nPMJx4zwmjZEMkPH@vger.kernel.org, AJvYcCWfm+VqsIjqBN1V1Y1jlmmmilsghCZNHkZOhU/gwjm0yORA3Ctb34bErt3+dqemDt+mwQtMuMsR2KXa@vger.kernel.org, AJvYcCX3Jg/HEDyWDViWKUSRtn0KY9hyEzhJBNEuPyqfF94vGLg7uNc0xPS/9+M2e8F+Sn26QXYccCyP6b2px+8=@vger.kernel.org, AJvYcCXLoSFSnj7/zUdwBXWlq7J9sPSqYcyCnq5Y/SOMA5grujcg2uZyxpQI+RlCipZXeHDkv5JA8ydwvPLZ2Z9Q@vger.kernel.org
X-Gm-Message-State: AOJu0YycMxWKg8Zpng/hYfEDFcMa4UZiK2u6ztqrc0QphxkBKv/Wlg+l
	HNENzbS8djjpYGsxDQZ4oxWWMI+cMAQpaa8xtgp+ghr/lcJpW+ba
X-Gm-Gg: ASbGncsafGVRIYLN6eNdwt0dv9XW4ldFg/iaAuA2C4LldlacIXXAh6y8tI8HV8FCTFr
	vKlUE1UHjPDORHJJtFhmI6io/RkQaaU92Qwo7ElGLg3IRBL+g8qtG0svJrHnip7YNcnENnrVLYJ
	Od2HYqbCADOiHxDOkXHMAIjH7xYxiI+14DolSOmHPtGjMItnORiF65XXCv10Qw8S2LB6ABL4vZ3
	OfdZZXyvGcZBmjXCPEBTcPCftDpeK6vzTED8gTw34TCtF6TjtLa+NubVYA3nfppljEc46vhnSib
	1aEMbVWwzOpwsv0Ba98Ehjm1L2+l4sZIYsiTZzCwSEXVwaWJGHyP4/Sc6dySr8nQHXacL/g6nXX
	P9mnPyBdcFvE8pLIfjD6ICi4pZLT14h2Vim7VNQ==
X-Google-Smtp-Source: AGHT+IEr3ekTauJ79CmjQnAzPfdbGB2+aT5aRrlnaWlsztHaVgeEbdE9tNCJ9sLHb2H6IWdaP2tp1A==
X-Received: by 2002:a17:907:a708:b0:ace:c5de:24cc with SMTP id a640c23a62f3a-ad2192dea1cmr79586766b.60.1746735603058;
        Thu, 08 May 2025 13:20:03 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197463e2sm36318066b.108.2025.05.08.13.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:20:02 -0700 (PDT)
Date: Thu, 8 May 2025 22:20:00 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: dma: nvidia,tegra20-apbdma: convert
 text based binding to json schema
Message-ID: <acuv2ezui4i7zuzzbuevf4gamk4647d2xc7molhvusyvh5puwh@woathv5saaky>
References: <20250507-nvidea-dma-v4-0-6161a8de376f@gmail.com>
 <20250507-nvidea-dma-v4-2-6161a8de376f@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ytpz5koaxckl7oqp"
Content-Disposition: inline
In-Reply-To: <20250507-nvidea-dma-v4-2-6161a8de376f@gmail.com>


--ytpz5koaxckl7oqp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] dt-bindings: dma: nvidia,tegra20-apbdma: convert
 text based binding to json schema
MIME-Version: 1.0

On Wed, May 07, 2025 at 04:57:34AM +0000, Charan Pedumuru wrote:
> Update text binding to YAML.
> Changes during conversion:
> - Add a fallback for "nvidia,tegra30-apbdma" as it is
>   compatible with the IP core on "nvidia,tegra20-apbdma".
> - Update examples and include appropriate file directives to resolve
>   errors identified by `dt_binding_check` and `dtbs_check`.
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
>  .../bindings/dma/nvidia,tegra20-apbdma.txt         | 44 -----------
>  .../bindings/dma/nvidia,tegra20-apbdma.yaml        | 90 ++++++++++++++++=
++++++
>  2 files changed, 90 insertions(+), 44 deletions(-)

I've applied this for now. If we want to drop the reset-names property
as suggested by Jon we can always do so in a follow-up.

Thanks,
Thierry

--ytpz5koaxckl7oqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgdEfAACgkQ3SOs138+
s6EtuxAAkWlTo7zM6Tj0FU18EEj+91FIP07Xb5PqbDK7Wk23Yrw8Qg5Sax0+/ab0
aWox68egLXu0AmF4mlQqfGeDmlvPS4kPVzxgkohYQIv0J5j09TNz7ZjT/8j6izeG
zWh6dK7QHAkY5MR08uGoL5ZaVm2sg35dJ5XEk16KfScWihsXCTLRPESH66REDjIM
2Z3GX8Uy+T4MecR4pU2COiZ6cdBoLiSDc+M0/JB09JCeRksWxw0PQS6hixx504DG
qtNf1+im0dMxfdXTV7UYPJrtoPAWj4x7KEZiHF3Lnse6wX3hZwywgrjE97EM3L+M
x9O9n0zH4V+1Kc6lV95atkA4zLPearRK5A9gS3hU2qS5Yww24mT1GRjShyff6k8X
L8bl8UFyugaUe8mE1JACl9SaYFeAbPFEZGObYbzTMKVI4CdHO4PVVApEO9I8IDgV
HzXtuXzSbaDckzLSspYPsRoycuBgO6HF1D5erjgu+79nSK7REBdAmBJVyYzO9zfY
bLH+wyprSB10CwNhVJ6zF0gv6sFsMYkvHEdu16uv4pl0BRgi+dg6VtdNPgl67CZm
tFsmKrjQCgVDBWZw/HSJlGkgRAp/Q4tDyS55hYSTAEY0/apMFGC8LY9uEHXwlc+c
nwYd/DToWTMrwbXZSo3ZCNIzzcWlWzODO29U9xxgIGcm23BqehU=
=sqOe
-----END PGP SIGNATURE-----

--ytpz5koaxckl7oqp--

