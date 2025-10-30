Return-Path: <dmaengine+bounces-7041-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA88AC21EE8
	for <lists+dmaengine@lfdr.de>; Thu, 30 Oct 2025 20:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830391886B2B
	for <lists+dmaengine@lfdr.de>; Thu, 30 Oct 2025 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2177F2E8B9C;
	Thu, 30 Oct 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7qfsxbO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A42E7167
	for <dmaengine@vger.kernel.org>; Thu, 30 Oct 2025 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852283; cv=none; b=FrR53yuNNwn9VsPXOrHDNtR/fA3w2mFaPUzxjUUBvu5DDHevluBhRS8sZ4QvSu+UVZT3UkRXBoxbFOPMz/3OU5azacJKwWLgGl5ykTAjmjYHQ184EDcvbQEZwm+2MgcKPNzip/R3rUH1MLe66JnyJPXV4uk8uxmSgmByEWfDCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852283; c=relaxed/simple;
	bh=ElrXgu5/6xmif6tI7ecktlmvL8AO7hOZe+lhNKfz7Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsJmQl/dP6cFPJnR2CgzxY41AGD4pxf9F+DYajZi22ax8mkZ6pH9Xx6vIcKq5EC/2qNw7zP12HW5zqEzF8BQifOl4qQVrJZZYoVSCzUd7vV4wSh9yLsCOXgly9JMRKqlfW7d7KwGF1zV3mc5Y00LtnMLgYHAdLtBIEZFP3kT6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7qfsxbO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d5c59f2b6so366244966b.2
        for <dmaengine@vger.kernel.org>; Thu, 30 Oct 2025 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761852279; x=1762457079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzCB8jIK8FF50evWPCp3i6KvsKUySMbzRnMGfOqE7VU=;
        b=B7qfsxbOlRmXNS+NAYWCKiuuUwDiaBm5u0bIsx05QP/t+SrapLrhI+MMw64W2AjFEJ
         6OGs6m3KougM3+imFScRH+fb6xgyefAlW4GiaQanIKfNGbNCkw7hXHOOsIWzQfet3l1j
         bm3YkYpdGYWcqmWRGSGcNYeWCaz2c5xxkydjQNxNUV42QNbjefqqn6MQWmYWLjlERFg1
         TdmSw0eCqRxR5hKN772dSZQxPH8ih98oELTY4gQLFmR2UCv3yHPAM6XFsne7tNChvSBr
         wdZry0KgIb5nlPVH3+c/MrDGmNNZDLI84f6JMuZ2TXG3nk0rn0+7iKVsFMmAZc5LyteB
         /bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761852279; x=1762457079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzCB8jIK8FF50evWPCp3i6KvsKUySMbzRnMGfOqE7VU=;
        b=EbPduvv1k/DeRKdI5+OmogyfKLTaVr6wUzEoLSi2seKQvtHRXmuqRqSX+U4uT/B+hf
         8zhGl5jzaZ2cG8y9Oljy6gGSgJR5kwHkiiYBF1CXdnecUzoRHSmMplc46Mdqv2niF/e9
         agoZKz+TJKEpqJAeYwPXCsVmaGhmOjCcUdAeeXYm6k/kxYzit4TlkEj/a9mjFogMb8R8
         MNu6kfCnY1K51eMUCmSbKdWIgsWcghEGahcR50hGS3n7Vn7nrlCr2TygKAIPhUcKR7bY
         cwn7u9iJRTnUQ/ZuEHX3XL0svDCrEIYAXRHXt4bsbbbbc2XtFzDD3aM+X60RAxWxjqnP
         H2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXTNZO4iW9Ii1l61vxACoHsOehSnzEjrNZFM6dtppWm9IOm+LEqLkLYZQo7Vnx30NrPyEp8849YaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAelM2hllupEyrIH9ywcq8mU10MxZL8FPLVZONYB0HJclUoDyV
	a69eR71ukLi8Ab+Z1FEvV54Ku0pkPh/f3lRHF8KP0r1ooPlSuG9zUhRs
X-Gm-Gg: ASbGncseU6IX7S7zj0tZqynBmc1fmr+AousrgPykyUJqGZ6iGQOm8cOe10WalgOL95I
	5XnIhZGK3malE3CAwqzqgrNgyo0h4acUgBWnOb6z/vQoV8Tp3jzzxCh7cVtJ1BebIdgc4hC5AFo
	Ue0Fiu41SrylXWPIx8iCqZhun1mohvGO++KnJzdyv0ZS4rgr5yeLqUWLUYO7U/Bfa3kaDsaLH56
	31Agr1FuQKoRU0hz72Se0omSUMcJ1xTI83cLPgcG6KlsfEi1L4uvuFC9PjBJMK1zg6BIbMekFkN
	e1BX10VFBjPkgLkq8yTWcTC8xklsO85qaUNMB5pXCb7aOENFBYAvGoTUMw9xgxswko9js53QQbz
	Azx4yhn7G1ZtG5EQVZLgWOUG1x98XcvRSpLI1wGR09p5TAtLCYYL+GqdtrG6YPgsAyXfjkflrnq
	XPf1cKHG6MTlSRmCtd6D8B+h9KlArgm7IvuGlkU8kFTi6H6CknXCZJ+Hqcse/YtBtqU8OROms7Z
	g==
X-Google-Smtp-Source: AGHT+IHAE2zfsvxg+WnKGQngg9O6/M2cc0o7OkY6Hhcq5Dlt181nXlixhzrIiYnYnVNrtbX+aXzOuA==
X-Received: by 2002:a17:906:fe41:b0:b3d:73e1:d809 with SMTP id a640c23a62f3a-b707061fd71mr80792866b.48.1761852278602;
        Thu, 30 Oct 2025 12:24:38 -0700 (PDT)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85445e81sm1827260866b.64.2025.10.30.12.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 12:24:37 -0700 (PDT)
Date: Thu, 30 Oct 2025 20:24:35 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Sheetal ." <sheetal@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH V2 4/4] arm64: tegra: Add tegra264 audio support
Message-ID: <zxcety2tqsv6p5p2rqaa3e4un44m2loo4zm5goeansuf5zdly6@jqeg2hm5rmcz>
References: <20250929105930.1767294-1-sheetal@nvidia.com>
 <20250929105930.1767294-5-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="istw733rho4drg3w"
Content-Disposition: inline
In-Reply-To: <20250929105930.1767294-5-sheetal@nvidia.com>


--istw733rho4drg3w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2 4/4] arm64: tegra: Add tegra264 audio support
MIME-Version: 1.0

On Mon, Sep 29, 2025 at 04:29:30PM +0530, Sheetal . wrote:
> From: sheetal <sheetal@nvidia.com>
>=20
> - Add the audio devices for the tegra264 SoC in the tegra264.dtsi file,
>   which includes sound, HDA and APE(Audio Processing Engine) subsystem
>   nodes.
>   APE subsystem includes,
>    - I/O interfaces such as I2S, DMIC and DSPK (all the available
>      instances).
>    - HW accelerators such as ASRC, OPE, MVC, SFC, AMX, ADX and Mixer (all
>      the available instances).
>    - ADMA controller and Interrupt controllers.
>=20
> - Enable the audio nodes in tegra264-p3971.dtsi platform DT file.
>=20
> Signed-off-by: sheetal <sheetal@nvidia.com>
> ---
>  .../arm64/boot/dts/nvidia/tegra264-p3971.dtsi |  106 +
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 3190 +++++++++++++++++
>  2 files changed, 3296 insertions(+)

Applied, thanks.

Thierry

--istw733rho4drg3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkDu3MACgkQ3SOs138+
s6H7xg//eVts+nMHcP4RRSRZowrB9Hev9Ui98kXJyEnnlm0YVJ1AYLz7kUIHXMVk
gwdifz6s85sfO+nufj469hlCm877zZwW+gO2gTwF3t7hh0mZ6tRVT0qqgI9phsM9
IkBFhAlmqFZeznEUhYQ0RktdN1h0RW0nWhG7fzyUMLS9RltTMHCDgbl8ckXoTLBn
9i1coz/Zm3puDLiPDE/LsmASeYXhtaB5bbkNLlbdN7yrrWOSEJMXTFbllErAv37b
Ycaa7gyZJviyjOO0/245sg4QO+PHcPFdBbxtV4CaON96uSdlIWqAcQUZKUvAKPMO
4OJ2pKTo7VIMzvXmkcqpbPWySOrFj2sfLTb3jQX+W7KTv2R9n9HxkANbJ0rQn7+z
rr4xzQFVfsTd2LP6Mr84wStmyDdlXF9+kwVnH/F7tKT3ZAj3bL93Q77W1tPduHwz
qlRLtQgCVX0KuTb7Tezs1IXbxgaetulHzWRa8ayIYhb9gNf7gZi3C0PUSPP7BtWF
p7cMVV7yq0bqRZ2q+PanKUvNUzNS4zJJoAuMHGtXdR6pedUq+T3SHoqdmxmRo2bO
5gTYoHd18rOs2+43CqRmgfHmqm+Ei4k4pJSVmIIQMKGbzHvn2Y3uPgugI4GUPP2P
KxhijmcU+KzqlklSQ/xNrTdLYyoLiOWdCi/AFzSbRoc0TsfT+oU=
=sxTn
-----END PGP SIGNATURE-----

--istw733rho4drg3w--

