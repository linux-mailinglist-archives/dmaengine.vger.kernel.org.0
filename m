Return-Path: <dmaengine+bounces-1023-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC3857AA7
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 11:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201FA28555F
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 10:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A753807;
	Fri, 16 Feb 2024 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA6CQEZA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49A7535D3;
	Fri, 16 Feb 2024 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080613; cv=none; b=qX6U2OT+WVk0wLiRQ7LmYLL15UtjYTes7+yp7U8Df9nPDwZU9sAyrFshH4JRhsb1x7R7HNTuXyOJDf+ljvkz2uN1Xnb1jakZKRKK7vHPbTxPjqmdF1yCkOoHJlVXm3yi9Bdg+7hQ1LYnKmhICzUaJcX6cB4jX7x62d4UqRkP3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080613; c=relaxed/simple;
	bh=UUdY4wIqwnqUH5q8nMthOgVFQcZQizyQsuLNXOUVmQE=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=tD1wOfjeanFVkVYrhTkSrO2y7Z9ULOo344Y+q5KKL46yTZfjaUAJJpmSW2OeItXxB0ifKjC/KmJxI0HhfOJDMnzO3sxSmBXoy5wNRMG+7eVqa1Gvuy3opSi8892M3OQRXbAZ148uZfzkR6D9IO3yVkuEQ65zfpZKDxkwHPqg5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA6CQEZA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26fa294e56so283143966b.0;
        Fri, 16 Feb 2024 02:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708080610; x=1708685410; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zmWRSDEK5agGpnOeMjgZIl5L92yW3SOPS8cAj0SGXc=;
        b=GA6CQEZAQ1hGwY0nSHtUhHw1UMypML3m2M7upEq5ImAi/IeXrGT4+WG6Cy1Ck4xQrX
         y3jiwfeGmvXSo2tmEbFsagZW6FdsH26DZUw30UNoghKQMe83PT1sEgZc5t4vb6zCQOi1
         8UDy/Vvb4B7kTauo6cQNvj61hveIfyK+6j5i+NamnygfA/JPUwWkIWuz+w7R72j02LhS
         YuAN0FGIPEJJb5LryS40FYR8kZatbQE8Uu9/PdlXft1PFErslu/okrugtTqHCY/0FY4M
         YoSV9i9p4udSzY1PCpqWgAGTgdIuBJUMY880eewN+saodrxlOw/Kt9QDFZKTOszwvzMm
         GnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708080610; x=1708685410;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zmWRSDEK5agGpnOeMjgZIl5L92yW3SOPS8cAj0SGXc=;
        b=vfZsbtZBoG7VJo596bWRgWZCEY+VSld6Y2wW5AHW7e8QZJ6EAesdOTQ+RSXsaiTlJS
         qpReVkEKGXxGwYYLyDvS7cCO3BVvFQR9DC06uZdh3b2RQL1e0i0l8NZ6OtSX8Ki4JFlv
         cl4XAurLdHI4FescVvnOykPBdmtRcO7i3q11+0UbUGCk4jpYZbNVm2U0MzlUlG4K7B9E
         FMZWniFDe3PQg3KbxHNY0+GfmhayPRM0umIvaXXVH66qIrCOEMvOFDZIS4zLj5pE7IlE
         8N+Q82XNRfW3M6zWX5fbve8s0/Em+L/gXi6PkRIuwj4LBAiLplNtDf+RGKr3ZQS98g2b
         dDnA==
X-Forwarded-Encrypted: i=1; AJvYcCUPqJtScKgn343+FvI014jbDOEUPaU7SPgcPirwiRODChqNqKz8JlkZV0DDi8JFUwI50OSJ+LvFZ3jc3+bBkvJH3lW+fBfKvIewo6JWbhCi5YuDU8LG22RX3IWQtlwdRS6TYlVgB+0=
X-Gm-Message-State: AOJu0Yw1eLz2M2PAbtU5V+snuN0Pj6aOShREuU7TMPVdszD51cmkCF5g
	fj2/Q96d6X6cAn7vf1yNeYpAmvIHqbsoJ5eAQ8jUtI19Sm9RGJ/c6go7bs/B
X-Google-Smtp-Source: AGHT+IGW4zpWeC+ipaqrQzlcR+82bd/BsfpvdUPVZJVMT8RDwmx3KkuMlJJ3jnn+NLH08w9ZD/iX7g==
X-Received: by 2002:a17:906:338b:b0:a3d:125b:d221 with SMTP id v11-20020a170906338b00b00a3d125bd221mr2936716eja.26.1708080609699;
        Fri, 16 Feb 2024 02:50:09 -0800 (PST)
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id um10-20020a170906cf8a00b00a3d599f47c2sm1457616ejb.18.2024.02.16.02.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 02:50:09 -0800 (PST)
Content-Type: multipart/signed;
 boundary=1889ebf0e44ed4f61dbb4f63d89515057e6639825218073105c2ee9b3079;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 16 Feb 2024 11:50:08 +0100
Message-Id: <CZ6G1IYIUZ34.E9WAQS7JJV2Q@gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: tegra210-adma: Update dependency to
 ARCH_TEGRA
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Peter Robinson" <pbrobinson@gmail.com>, <linux-tegra@vger.kernel.org>
Cc: "Jon Hunter" <jonathanh@nvidia.com>, "Thierry Reding"
 <treding@nvidia.com>, "Sameer Pujar" <spujar@nvidia.com>, "Laxman Dewangan"
 <ldewangan@nvidia.com>, "Vinod Koul" <vkoul@kernel.org>,
 <dmaengine@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240216100246.568473-1-pbrobinson@gmail.com>
 <20240216100246.568473-2-pbrobinson@gmail.com>
In-Reply-To: <20240216100246.568473-2-pbrobinson@gmail.com>

--1889ebf0e44ed4f61dbb4f63d89515057e6639825218073105c2ee9b3079
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Feb 16, 2024 at 11:02 AM CET, Peter Robinson wrote:
> Update the architecture dependency to be the generic Tegra
> because the driver works on the four latest Tegra generations
> not just Tegra210, if you build a kernel with a specific
> ARCH_TEGRA_xxx_SOC option that excludes Tegra210 you don't get
> this driver.
>
> Fixes: 433de642a76c9 ("dmaengine: tegra210-adma: add support for Tegra186=
/Tegra194")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Sameer Pujar <spujar@nvidia.com>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> ---
>
> v2: fix spelling of option
> v3: Update T210 -> Tegra210
>     use "and later" rather than all current devices
>
>  drivers/dma/Kconfig | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--1889ebf0e44ed4f61dbb4f63d89515057e6639825218073105c2ee9b3079
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXPPeEACgkQ3SOs138+
s6HD8RAAjqbP3wAiOirz329MsIUU4v7Hdcl/LInbq79dY47m10yHbX/q8pdzGsNx
aGOECWV7OHZdVPwsu7DcZC//4XHZuOs8KZ4NuS/k4eidBJY6famh9PRyKKa3krYl
EhKgC8UecWKpwynB42QvsTw3rMKZ0MhGgvHMkorxBbFORDSmfMXEzD5rQc0HHyGq
or98pzxAE+VhnQO64BTvwAr3Rq0bFYkpu2tLdiTtQUzpcaieLmwaak0iuSMqRl2V
LTicMv7KRGuKeUiPjaE9MET2rQL78/ilbcl4UHWjscXyfJS66/inG6djNaur0H63
GwayQrjnBe90gapVrFLfl5XxGlc1ERhtSqSonKmEroFJzk27dtLDdmvrWu4yCjeM
iQwhzyTOreVsVjudsqUNJ44kjSX8nD9uX06TjlVWWFb+drQS5Ce54rVCUGb7t24w
Q1Arm8LlNqUTiGz1yAPFoU8RmQWBbpy1tWgCRwH2lnxKokhT1fOfmugClFW8vv9+
K7K5QxEBeh7DytoN3MXh9E5rQL60RppVGTEJH5f0dUT2cL+CVcp5TNqFo4i+0FkG
ynCttL6A09gB3NGPuymyWqUq/IKiAgmmvUERaTiqpKqZfoE69m2u+o4KS40zdAxX
bH3xsCNeUl6xIWQXUQ9zlvCQ9TBW+7yeyLnBhoNyX8G4KPaEq88=
=f+fG
-----END PGP SIGNATURE-----

--1889ebf0e44ed4f61dbb4f63d89515057e6639825218073105c2ee9b3079--

