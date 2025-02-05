Return-Path: <dmaengine+bounces-4295-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB1A28B96
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 14:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC5D188657E
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 13:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08654A32;
	Wed,  5 Feb 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLyjgdXM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC170831;
	Wed,  5 Feb 2025 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761920; cv=none; b=a6O1LFdws1z0pcMcBREc9/TKW7hJiKwMNOcc1iAzq5hk97O+F6qdAHnYPvFASTjQJ+rW3VL3gYzK1Yf6Im6hBLiLmvViVS7CLts6M/5C1f2XbNNo1b0aBbecAG5My71T0oL7ZOe8xqcZwLAUwm0dztVfzm3r1c7NhN5svfIvn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761920; c=relaxed/simple;
	bh=Bvgs596QDXVcf4nIcZPkQ3ZNhV8dwv7Ku9oO7UCotdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bML4bkyT71QUaYGQiy2XjC3bZEUoKh1VcXTkrzonYhR7qc0IHsCcX8YQecbSmyGHNTQg+bv1g5kbWQ5pbdmj34BNlsUF7ArADpd5q8adLuFJUgB8QBIlergsBcRbeVcFwY9xvjFau7p+gthCFgyC/gzEnJ21CMJ3vYSUlLw08fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLyjgdXM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436202dd730so47908255e9.2;
        Wed, 05 Feb 2025 05:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738761917; x=1739366717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNlyjMwMPlr7uDovX44fIagmW4xuRDDb5y9kKEoul9Q=;
        b=YLyjgdXMyYvMbqiNa8Cod33A1BQDWN37q5Z+ZYjyI9SwPUKCZWX6Ei+M30lONB4J3F
         Fl/K0Rq3LRA5LvERqqf/MSjJC4H/CDE9Kf+8UK/jxtBsgTsypwKVBF627gOKFsmV152L
         PlJc+m0BsQVAL3ZO0P5bHgG7fKb3g6112NzcLM8KCKxVA/ELmO7HhfOph88ozyeR5miB
         uQNxO9ahahvUbZmjLnDwPT7yigBCkvmPnfkH1ZNc7Yj1Oat5d3VuechDmgjKlruuH0B8
         ckRlcck6072kIRUp22AS7VOQ0iwB27p//pVrvofzbn81rYwSBtzIzCzfCxj9B3oyciEs
         mPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738761917; x=1739366717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNlyjMwMPlr7uDovX44fIagmW4xuRDDb5y9kKEoul9Q=;
        b=wncvvIBk9cGdSpAy0qP6hf4ELg2kkzOgFG8NIJbY6hGKC7Kyxw0jP2FFrt3jUv0ZSz
         QQH4vWw4lMaO6hvmkMoInEnHDWiB54o36LnmDo38IlpXRllngW/Dn9Z2lwDCC1xBDl3J
         jtldpKO8TKqT8Hj6Ca73T0b3qwDzyFhvBql93EedEeGIJOa0oWS+laVgz9tUX+hBQ5BG
         3VD+rHP5WCYBFo/D7vj0jKtVYPiT8MMKpSvaazPpuPvHMSa8GWG1JoC6NCq69hX9Nz7Y
         b4zT6l4w6jnLyqxBpdZzEdp7UeEBV7E12UdN6mDpe1ih5OFi0GOP1dpi1LFgabHjPJHs
         rJAg==
X-Forwarded-Encrypted: i=1; AJvYcCUH0sp0u2qYk+EF7kuBJ1QfUe4EeNcXb9+49n3SDNYaJpgswimOnCVAbmv5XJBR6on6jURCSqu0Mao8NW0=@vger.kernel.org, AJvYcCVWtKHTVnl/xWP+lgA8SwxbdNzHW8hG7BWK3gwuGuSZGswWuhIQap+8/GLtskov8wWJAiVfXcnB@vger.kernel.org, AJvYcCXVBie/P88B6LU/GnvQZu1ZIMjjEyxJcrCF9KZSTQqd5RNs9J7MPtKzfBWHoQhQPvlRNYe/DunuUhE=@vger.kernel.org, AJvYcCXblHYFAy2LIhgG9T1177Z04bz0H84/J8dm7GBZukaEo11+hizGOKVPHGLgTPrxep0NY7RYkHXbLFQ0iHpD@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhbxTKn5cbKJTMYWbJypjdK1dhnHS57qqGDmg9vVhKTe/k7tL
	Nv918Y+aES5IJv4msiWh9QyLlauJU7Vng4j23HSP5bG8fCnmt3vR
X-Gm-Gg: ASbGncssIH2023SLJMpLIYQt1Rfkz5PIAnjzqrNsnEMQEOG3fIGnEEcUrSfVzbuxKPL
	ZwpcpAx7GOPFhLn341lSwcb3z0ltdGFnRVYQUvSnUoiKJrDlR5O5IVqDZRI3KH/GeXE4CbpNBA2
	00ZbBt7g1zgewcGuEu1XYEbl8kzxvI0SGfXBp0kVqF2wrSHz3d+4Vdcdx29NQ5KbeltaHCBzeD2
	MPTvVadIiEivp8eRgCE4Dm7jtsl7bBftfNckJNSPl6Zt2O/AluMAzAojEy9RpnJBiqMilO0OHm0
	03+DdIQ6TFVSpef6tGwQN2EIjg+oM3b73tfcZbV3f6FyT6eHBJdpRcK8CU6NPeLK3uQEBoAl4ev
	YYg==
X-Google-Smtp-Source: AGHT+IHCGbXVWfzGQ3kl4KoOlJscavKQjIfiyC37i44Dk0UJCS4XRf705bvO5Ryl5krNxdQSp96Kbw==
X-Received: by 2002:a5d:47a8:0:b0:38a:88a0:2234 with SMTP id ffacd0b85a97d-38db4860dd7mr1510571f8f.4.1738761917183;
        Wed, 05 Feb 2025 05:25:17 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38da1a11f16sm7796367f8f.14.2025.02.05.05.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:25:15 -0800 (PST)
Date: Wed, 5 Feb 2025 14:25:14 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: vkoul@kernel.org, jonathanh@nvidia.com, dmaengine@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
Message-ID: <t3ml2g4vvdbgtf446z75kii7c7fqc5ogjwvstult2wzktq3zyk@ztsd3o3elxcf>
References: <20250205033131.3920801-1-mkumard@nvidia.com>
 <20250205033131.3920801-2-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vm7yhsuaczxkqt6u"
Content-Disposition: inline
In-Reply-To: <20250205033131.3920801-2-mkumard@nvidia.com>


--vm7yhsuaczxkqt6u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
MIME-Version: 1.0

On Wed, Feb 05, 2025 at 09:01:30AM +0530, Mohan Kumar D wrote:
> Kernel test robot reported the build errors on 32-bit platforms due to
> plain 64-by-32 division. Following build erros were reported.
>=20
>    "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
>     ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
>     tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"
>=20
> This can be fixed by using div_u64() for the adma address space
>=20
> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@i=
ntel.com/
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> ---
>  drivers/dma/tegra210-adma.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--vm7yhsuaczxkqt6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmejZroACgkQ3SOs138+
s6Gx9A//WgxIkKQz3x9iB1FrKb8aNa6jpjUI57LlaFklBcZpAi2CID/M/VfOq5bV
GcO8ghpogXyruMfTWmrcbAubWAFrDOq5UnHVzcdZ/sZuOGNwDRoOr/8iKB/Yu/P3
BGaPzoQ6lcwQQlrddGHpzGvNYe+TGXQ+1U9S/gDPwjEb/ioRVUuhv0Ud60OfqtjI
VnAdPxcM2paIswyFW/4eo9kvWuSWoTSFPF2LyoJC5CXwGmtS0kCwMjaHMwKuGKV7
MwYctcIRtkU2AmDiIixVf3a4s7mkfwl6/OA6eZDd2YPqC3B23OQYqeWNS8flOXAd
YXk5WjdisEIr4sccaR731Wf8kpbvtivZ3ZP+KgWk6Ar4OK0xiJ6mePbCXFEtvbQt
UbLnWI6nUbexCuc8hp1OiNGmrsHNWu9lRGNOIzLUWxMMaJK0WbsBh2yS0PAANyp3
1D/M1Cx+aumPWOiNSQvaehsLUYLmIgt4CRXP8MDhzyOHJ+29ZxkJVaVyusL+nGUe
C/Hc048m2P/yqQRgITtvPkgQ+cfQsqZACEb8s23Zm77h6OL9X2lfEcjA0ZWxqE3C
3ubHXBTqav8fOlhVkIUtbzTItVw6aAAZ8rosXgDlS5g5ReuZX1R1fbKZIqTZW6kG
L6fqgUbeG/fhLQZSiMH4GvC64a+svgPGVPH4I8/CjH87RnAnV9Y=
=mDGR
-----END PGP SIGNATURE-----

--vm7yhsuaczxkqt6u--

