Return-Path: <dmaengine+bounces-1420-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E931687EC5A
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 16:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6476281E03
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BCA524C1;
	Mon, 18 Mar 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob7rNXNx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D5D4EB49;
	Mon, 18 Mar 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776555; cv=none; b=pQUpQ82flDGhk/hESiDFXXb6K8wVLkN2Y7u5eWBSLCLlewx7OxCRup3k1AjzjjdhAUAgY2jN02YK0aaLSI1IQQDj25A7JNXFLJkSKmXg7UhTb3p5kgRDQOLMdd2TrlcTi580rh//JlDzl9QeI5e/JaAj5z2O6kqYQntm8Z93HPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776555; c=relaxed/simple;
	bh=wiO6Bh3K57JlVluzbql0nVmgIijn97Jq2YMvmvx8BNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQs0j+G4G2XxjDsBw1X5VJFLPlMJQqZUsYM/+H9/WnkNhSrOwFrPzi0kkU9lW0o29IP73j5VkDQk0/mkt8RRva3pkdDCRsLd3+owSQoaumFmGu9oZyIfueuqj/IvdFoF7lYxliJYS4zGTdLjiUBJLysKIJo2Xk0vcyWAOCv//00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob7rNXNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67237C433F1;
	Mon, 18 Mar 2024 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710776554;
	bh=wiO6Bh3K57JlVluzbql0nVmgIijn97Jq2YMvmvx8BNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ob7rNXNxKDRr+C+oZa2j8cP9ZvdMcI5EKEBvGUHg6RzPvyS3S3EHNrNj3fG0dlVw5
	 FCfHynwhxT7rM19px4zE9vNS3rGis9Z/eIak1o/6GKfZ1ko4BMFmEZj4MKrIu4FgLp
	 RnTdi0pn5vgZ3L6LwVAXv3CMCxffafBiaFgep8W5vabN0pCfYuIrikKWOLKT7BI7ct
	 9tSsvImCrV1WIg0HXJUULPCgKdMKTZ47F17ApczNvAzWz9nqL3LWSGhKKA/fi73S0o
	 Y7rLAE5Zt4knyBWxlTMrQq/whFbFAEMbkw/TeNraEKeZnP/7O9AE6CjeKW9P4H8mXT
	 uP/ryqrqh9mFQ==
Date: Mon, 18 Mar 2024 15:42:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Add support for Loongson1 DMA
Message-ID: <20240318-saxophone-sudden-ce0df3a953a8@spud>
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <CAAhV-H6aGS6VXGzkqWTyxL7bGw=KdjmnRZj7SpwrV5hT6XQcpg@mail.gmail.com>
 <CAJhJPsVSM-8VA604p2Vr58QJEp+Tg72YTTntnip64Ejz=0aQng@mail.gmail.com>
 <CAAhV-H5TR=y_AmbF6QMJmoS0BhfB=K7forMg0-b2YWm7trktjA@mail.gmail.com>
 <20240318-average-likely-6a55c18db7bb@spud>
 <CAAhV-H4oMoPt7WwWc7wbxy-ShNQ8dPkuTAuvSEGAPBKvkkn24w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FRokeeiQacP7TgxH"
Content-Disposition: inline
In-Reply-To: <CAAhV-H4oMoPt7WwWc7wbxy-ShNQ8dPkuTAuvSEGAPBKvkkn24w@mail.gmail.com>


--FRokeeiQacP7TgxH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 10:26:51PM +0800, Huacai Chen wrote:
> Hi, Conor,
>=20
> On Mon, Mar 18, 2024 at 7:28=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Mar 18, 2024 at 03:31:59PM +0800, Huacai Chen wrote:
> > > On Mon, Mar 18, 2024 at 10:08=E2=80=AFAM Keguang Zhang <keguang.zhang=
@gmail.com> wrote:
> > > >
> > > > Hi Huacai,
> > > >
> > > > > Hi, Keguang,
> > > > >
> > > > > Sorry for the late reply, there is already a ls2x-apb-dma driver,=
 I'm
> > > > > not sure but can they share the same code base? If not, can rename
> > > > > this driver to ls1x-apb-dma for consistency?
> > > >
> > > > There are some differences between ls1x DMA and ls2x DMA, such as
> > > > registers and DMA descriptors.
> > > > I will rename it to ls1x-apb-dma.
> > > OK, please also rename the yaml file to keep consistency.
> >
> > No, the yaml file needs to match the (one of the) compatible strings.
> OK, then I think we can also rename the compatible strings, if possible.

If there are no other types of dma controller on this device, I do not
see why would we add "apb" into the compatible as there is nothing to
differentiate this controller from.

--FRokeeiQacP7TgxH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfhg5gAKCRB4tDGHoIJi
0sTjAQDALytttuYfVJsyQy7sDZDV8tYi6psKezR8Bc3oDe2MVwD+L29VHP1xWfy+
9VXdiRDcAPkATuvmQv2ntv9hE0bTTwg=
=hLYv
-----END PGP SIGNATURE-----

--FRokeeiQacP7TgxH--

