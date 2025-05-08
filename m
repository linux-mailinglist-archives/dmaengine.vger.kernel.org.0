Return-Path: <dmaengine+bounces-5117-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A310AB0478
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 22:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9AE77A5588
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 20:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27F28B7E4;
	Thu,  8 May 2025 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Qao+hF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC81288C23;
	Thu,  8 May 2025 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735566; cv=none; b=mMUftu4c/sBq2x/G0gYT87/sOP4j+H2p9Ejnj3Od7G+/9E0Yk+rrNkE2BSlU/sGlsxYpkb4Fig/cl6QbKzvMRlfu69eTTZavrCetlRBNwdtbjb5ewcu30exITTTkujZDiszRFQiezWBQokK3Sz81Zu5Y/wRM0qEUQqp2NeytYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735566; c=relaxed/simple;
	bh=5SncBGolfNK+2/YW5KYl+Ur9nYIs7iF0hpCOYtVJLgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIMlp1yn3GCrHon1TLFS9moVxyVTG4w0rP7aHl+NZqhDINhcJZZJB0eS4tbQFNXMh04jx2IoGHLTRN9acfobtQiYXmIUs8Tp2Op4+2UlCoDOdLaj/dyKLXnEXYb/mjX/EuwpvgPISWNVGbJdLBNwYiOIOPg7L4f86H7t/6TCu7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4Qao+hF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso1055853f8f.1;
        Thu, 08 May 2025 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746735563; x=1747340363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVLVnqmjBYNcz4O9cR0Vvpoe7UkalsaHxxkX+qgSFfw=;
        b=D4Qao+hFY8xIL/S/xGf6baMCAkMBCoUqhWPtjv19KxTppxtj/owMJepRpNSyAFWK+b
         XsIhHM2rO9kRBbLIR5NTBelaAHtQBWOBzNjATZzrx3Kpk9oie/3f5CLo815P4vgfA+Pt
         KdsSsh8PLEM3yn8Vc6UrebO8iWYe9ceyIAWxvhu1WdqIFHxtrGUpVM7vG0vfTW7eBTZX
         7Af+C+mHfnQLI9EcooTfSJz7kvgvN/qJkr8QqrrwZ9qJXREmJdktssUCyNRbJsGv8WVv
         VhPc4uhh12SUkihYa/lMvORFrmJWye+eBTJbqA8fysh7a9ZxW0MLzJ1s6pzrVMtCRywq
         MCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746735563; x=1747340363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVLVnqmjBYNcz4O9cR0Vvpoe7UkalsaHxxkX+qgSFfw=;
        b=PRlaD/nlB/MSMH6JT3KfvviMs9DhuSd+uVe2rWW+ICenzYMZvboUzIWARz71ycn/TC
         r4wl9VQldeRSIer8VYjszspoPiQwmfu8hY+T6fikXAEakscaUZfTpU4QnK5p3exRJ2Xf
         0bd1P5AtlbJp4F1s7QdNQqwvivkvSBnRB20DahiV5nX45o+wYc0duVmEyEYWDDjqACD2
         KWrCNBRsHlH6aZuk4vOJgkC9+5qzSiX9S5K19R/CubbhEntobEOx5DVJemKd63SS34s2
         6OR4TZwZDGwxOruq1AqUZ4zJIznx7dzBADGYOuf13xJILyicHqm6NYJo2frfGU4Tkzc8
         ft8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJkfHOVXTml7ueIIQJCD3wjhiw5Gt76GAKT4ZlihtvDVQLyY46S9ySNfu5X5Xidr69AE6tlgHXuX/+@vger.kernel.org, AJvYcCUX54ES9Jgv5MD1BEWblOthA/C4TmpJ5uBauxHnVv4BiB3BjA8UuPaGws0HIdr3TYuWuRsado17NBMOmwI=@vger.kernel.org, AJvYcCViQ4dw1iuGkFZUyCguMkcbmK5L0I/ci8hOBguKrjsFz9bZnwGHFimAv3be9wbt4nsCP7YSXO4tr40EAm4E@vger.kernel.org, AJvYcCXcVU+YUC/HaFExDk1MBLQcjY8iH1WmYFLXeRFyQxfoflWTc7sY102sJYrG7utLp7DJO5axmLUB49Cc@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNJdt9AzW8TEJxSa8da2FE+hZwmX/GspHQ62OxSsxOR9q8bw4
	dghbwwfwNG7Y48TILk5jpk1dw48xRSvldGwjx+rru0wia9URLcXX
X-Gm-Gg: ASbGnctXFSrbPhUAAQX3zKA/qOe6HjzZsVkUNGyx91+OfmlROPxa0hDwC4brUC99sKk
	MD99beMtErob2DpWzeKk1eEFMUW0tNSXG/ZeRc8ugJgi15y4LvUtm2ZojjN6T/VgsjGocHDHEM4
	ATIIBRCgB5pT4BQCLnziNCAfx0YkcrPSaLHZNewxODIMdjCdCthzg3RKSMcztlxabxCUJYnugwq
	/oazZFdhTJsKrfndq6sOcdmOwI0llxfw2WRt4Jxn2A+GowS84Ckf4sTD1qWcpTZWkhdG2gZoYV+
	xrsm0q1LqNbX3X18Nd6TC8m5IQkn1me98lOPSgtyp1T27UFgt9jZFYIUz9e81MQsDNMI5gstpqO
	zvuDTsMFvRC1sxlUGkBxpAEh/pzk=
X-Google-Smtp-Source: AGHT+IGGGmnU57jhBnGXZRcmxM5mqs699GMHM0BxQzEcI5zs1hwcZQuIVn9mMwtqOEzQ80DrO8F33w==
X-Received: by 2002:a05:6000:4212:b0:39c:1f19:f0c3 with SMTP id ffacd0b85a97d-3a1f6487770mr742969f8f.46.1746735563337;
        Thu, 08 May 2025 13:19:23 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c78fsm926225f8f.97.2025.05.08.13.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:19:21 -0700 (PDT)
Date: Thu, 8 May 2025 22:19:19 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/2] arm: dts: nvidia: tegra20,30: Rename the apbdma
 nodename to match with common dma-controller binding
Message-ID: <upqp23gzdwfrzb2wqipw2pbxp7dh3bl4glxjg7okkbx5eegp45@piyur2lwnwik>
References: <20250507-nvidea-dma-v4-0-6161a8de376f@gmail.com>
 <20250507-nvidea-dma-v4-1-6161a8de376f@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="talwpauofrsaghcl"
Content-Disposition: inline
In-Reply-To: <20250507-nvidea-dma-v4-1-6161a8de376f@gmail.com>


--talwpauofrsaghcl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/2] arm: dts: nvidia: tegra20,30: Rename the apbdma
 nodename to match with common dma-controller binding
MIME-Version: 1.0

On Wed, May 07, 2025 at 04:57:33AM +0000, Charan Pedumuru wrote:
> Rename the apbdma nodename from "dma@" to "dma-controller@" to align with
> linux common dma-controller binding.
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/nvidia/tegra20.dtsi | 2 +-
>  arch/arm/boot/dts/nvidia/tegra30.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, though I did change the subject prefix to be more in line with
what we usually use.

Thanks,
Thierry

--talwpauofrsaghcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgdEccACgkQ3SOs138+
s6EEKxAApm6wmNJ4mdUiKx25vzZHKY6HXYiJDeFPr6dWU0OE8L3d1vy71HsnEzfj
wwV0oLb0YkZZHCUEPB1PXQoDFsXmKhDAK39h4i5UdzjJ978LRilUeUzEkxpe2PLT
JXCsm8qo9NoJh5Zy+C3GD++0dkfWRamLDv+Qzf4UTqXAIQYkiQ50dA9wgfB6+aaX
j541npp46Ij9CwZm4Pa+EQCkfBe6mrfdfFVKa2nWsenaNmxC50DLO0iB6X00/lc1
iUWKCugn6X3+zErrASQFpJxmKOMMld+cFQEcZ1qiBAH9cv0HqXgbypL/f63nOYzO
aM88Pkyh4oyDO27hZI2wzMEf+uSGmj5erLso0s5B/p1rqQyWar0VcccmV9GIJn5A
j9pt/IXlMfowf2i/tcaRMjJnIEldeLin7uVbsvM/pk4ikH6a++4hHZ6bb0fx20pY
47iuQiyssNt2BYVUbaosU3IW+KykmXzNu5OQx4b3EwKNG0CkEihU4XW5+5GBHvz7
hy6L6IJCvDPZ8rKNFuMy+CWxOUdbv9rLTd9vSOtyaPbxTHuyc7x7Tsne9kkv/1eE
GWhjBgUHfZADqquMp97cX+UF2BLXA1R2uYwNZXMkPXOGY293CzzGukzeqJC32S8H
4utOVlBFpF4AVkNuzCTuHe/oi9h05FJF17o+vFbgevUwZneFMBc=
=vkGk
-----END PGP SIGNATURE-----

--talwpauofrsaghcl--

