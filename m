Return-Path: <dmaengine+bounces-1482-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6521888A7DF
	for <lists+dmaengine@lfdr.de>; Mon, 25 Mar 2024 16:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B611C604C8
	for <lists+dmaengine@lfdr.de>; Mon, 25 Mar 2024 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4DF4CE1B;
	Mon, 25 Mar 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDkKtaQm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96DB3DAC18;
	Mon, 25 Mar 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373415; cv=none; b=aa8f3ibiDyOtoT6f78/j7mZOaEqxxTXZFGSOahdvAj8QQiF8U6vEhxN1ZMM92z4DwofYDuCkTzkzUhjF2UvvAy5fhgEA9FxUkJufanHbwxw9WuuJobXN5YEdTD741e3k07RJWTucdRWWslq57UTqDO/r9iRSGUiPxnB7bHkHHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373415; c=relaxed/simple;
	bh=hrZPseZ/aDtrhN7KU2wrYjtCnetz/cj9YzDAAtIWeAs=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=jifvBOyXk49jy7ElEIZLEbFOlMS8I1Q9fJvlA0W1ABeCxxQpQflX12UwyIAgRAa1rRX4Ya9UflxAa5+QWPtLuSpTJZcK926sXA4ANjrdguN8uviHjxsMK/oLJvxuuFQwatSB8cavNJCCrwxLd6MtsY68gPh43GfheZdKdKcSRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDkKtaQm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c12c73ed8so1193505a12.2;
        Mon, 25 Mar 2024 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711373412; x=1711978212; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XD4ew/GHYtcG3hjg8Rw1ArwLrYnutWTTiSTIVtBubr0=;
        b=YDkKtaQmGy7niTGGqp51Rf6fC1UU0yEGoFzp2lNEQ/kw6Cx5aD8asXH0rqsuXJI4nC
         f350IdRXVgFbTxT4/elt+1gBw1HcBQP7qNULPVWD3khOw13WoXpYkzKAXMuSTCHCuw0T
         JNkyXqmN6k8DJ0K4WCzeJaWmOxEGaMuoTS0i4SOPim36lsix6oW3gEwu0CzNJEqB4PRK
         ecqAPAS3liVd3zW4nhkcOuera+3VNPvEmSpO+WHHrBgVkhsohSea6+Ru27Z7wQCkqypF
         DXBEjBI8OME5OPWXqVhYSDyU5WsP3KEt4H8G1Xhue92VnLlN2q3R8ssPScpPfkwvvCqq
         8XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373412; x=1711978212;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XD4ew/GHYtcG3hjg8Rw1ArwLrYnutWTTiSTIVtBubr0=;
        b=A5+KgNBC2uXzYJ87tux29hu0xmu2JsFcn0X2EdJFT108svZDPUy0ghHLdedTpg0w9A
         vxo+1WEMIIQhVGtHgNZMEtqMZRul4Jls9lqVld2KhCn2FguVhBFtE9IhVVMV1kvFcnC6
         S7JM8jeeB9E/h2iz0j0iUXnaQP8xN++5R8588dXuAZAYMj4aM2OGAogHhKB2QLWribUY
         5N4W9LBvkiTiudht2kYhTePGj97C6u+ENQCKhdzQbytSAL7MnUQvrk6ynzYWBeElZsrb
         AZb7CPPgqG3KxVYIj004Yk/y0sQq4IAYVsSsdpeYTHAncW33Cqfr1SJcDMUfQT3Rk0Fy
         ojAg==
X-Forwarded-Encrypted: i=1; AJvYcCUXmLgNL0FqZvLs2uN4TsoTT3KC0GsYfSsU0QIdYmLmH81xSzSj84aIUF4C0tBnJ6XJsU4NQjCvVPdliFtpos8lXhz8l++42pimicPfTp8WhIplU2zuO0Ob1ul5+1zOEYWVCZEgIxCZeqQfUAoqYrJC3F3TvYiQNrs8fbJ57+enTq0vLPI=
X-Gm-Message-State: AOJu0YzAs1zn//L7hRPiOu869pfPx6TAJfDzEyMSll/J0vAOAqyRTYCf
	r0fZ8y69LIKBSPGFooqbipI2mCnoMfPubio4rQaQ5DczDHDZKQihnNo1snak
X-Google-Smtp-Source: AGHT+IHMpffUHcFawHydrS+vWRoqBc9bV74qfpHVrxOZK745LGlf96m7BGzz87O4DVTYDVSUiI4XGw==
X-Received: by 2002:a17:907:f84:b0:a48:7cbd:8b24 with SMTP id kb4-20020a1709070f8400b00a487cbd8b24mr2311144ejc.17.1711373411541;
        Mon, 25 Mar 2024 06:30:11 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c27-20020a170906171b00b00a44936527b5sm3064853eje.99.2024.03.25.06.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 06:30:10 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=55f459f7e54beefef07011c1d824c0093225f2bd4123168eb5e41c29c511;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 25 Mar 2024 14:30:10 +0100
Message-Id: <D02V8R59Y6I3.13XIQDA5L6QCK@gmail.com>
Subject: Re: [PATCH v2 RESEND] dmaengine: tegra186: Fix residual calculation
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Akhil R" <akhilrajeev@nvidia.com>, <ldewangan@nvidia.com>,
 <jonathanh@nvidia.com>, <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240315124411.17582-1-akhilrajeev@nvidia.com>
In-Reply-To: <20240315124411.17582-1-akhilrajeev@nvidia.com>

--55f459f7e54beefef07011c1d824c0093225f2bd4123168eb5e41c29c511
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Mar 15, 2024 at 1:44 PM CET, Akhil R wrote:
> The existing residual calculation returns an incorrect value when
> bytes_xfer =3D=3D bytes_req. This scenario occurs particularly with drive=
rs
> like UART where DMA is scheduled for maximum number of bytes and is
> terminated when the bytes inflow stops. At higher baud rates, it could
> request the tx_status while there is no bytes left to transfer. This will
> lead to incorrect residual being set. Hence return residual as '0' when
> bytes transferred equals to the bytes requested.
>
> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> v1->v2:
> * corrected typo - s/exisiting/existing/
>
>  drivers/dma/tegra186-gpc-dma.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--55f459f7e54beefef07011c1d824c0093225f2bd4123168eb5e41c29c511
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYBfGIACgkQ3SOs138+
s6FBeg//RL9qtORpLwtTvaMi2BCM4joMkUMECQ4qDz4nES1pm+wqVl0w+l7VpTJf
j7DrpS1DkUBYSA4cEnkqzrdbrWwT1iSOZNiIrVVjrg7YYdIifacKHDWodCK712Ri
xb3mENbUy6Ljj4rOAIe8D1t7IF1ufUBFAdikQLMYaPOGy2Oqe58VslwwTgneFMp1
ca/v2altcEQ/POZJypoJC+zQoJPMMoNezg1RRt6NAiaD51862o66doKHBmHzBGFH
BS3kcs5jf1tbn3R7ZSK0qmyFP0aiWOVHivRFABR6yGaI5gz0AP6QsVQYLCYrfJEo
3e80vIn4VQEXdYNPT6rmJF7PFqnjPbse0bHJYY/ltlwVYCgJX40JX0J2hgRVGKxN
XctliKSlQ23HR3aZpaATYwIUHwyKoRSjowzeVF0ZuoDX+ZkWkuml7cqChvbwh5Pm
tWqGw4E9oKY+n9sXEm1d3J4dVEhby/vY67nCHDOD9Lj0xRy/C9di6t8AiHayZiY8
WboA1JCbJ5GcNn1eCoI6YJ35Hn3J5Il6d3O+QfTOqzRSckVNLgfuCATnaiRwdAwe
CY6NwH2+T1eNYIZ2KsIKS3G9Ilq8XH1/yMdhV0+dagm93/WHvKvHpy2V1Iedk2XH
tX9HjGDLEnqs5Oc1iNdRJoVIVorCu/3yAICONU2coMSNWgaG7pw=
=Heur
-----END PGP SIGNATURE-----

--55f459f7e54beefef07011c1d824c0093225f2bd4123168eb5e41c29c511--

