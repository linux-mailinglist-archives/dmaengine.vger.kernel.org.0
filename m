Return-Path: <dmaengine+bounces-1446-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED788803C4
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 18:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F52C1C22B76
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 17:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C192B9D2;
	Tue, 19 Mar 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQf9nojb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF962943F;
	Tue, 19 Mar 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870060; cv=none; b=r0j/IKuvDCX/Q9vpJSdwqLO8Tdx5fwqp5FSwrRckMre0hAl1sA31epsLNhBCq4zj+SgGbOh2kWxLMcoj4zo8/QO8jjqDfpLC1ggGAgnucdfts/zwOpUlla6tll6NaI0JHQtL/VOSnp1PqANVmc7z1rB8Shv4mkif1oHig72q5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870060; c=relaxed/simple;
	bh=CKyJcdGuzJfzYC3Io1ni1ArcNYE/b8UBL4slLPFHKpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5sTB4fMGcqZxUcP99nX6Nu7CCrOokF0MIMcFS18oQtbIf0CZnZ0+mTAtt0ENCJvW+Q8XEpfhTb6KQ/Cr6ouhz/RbrC1NLeC9v6wafWWYFP0gC4PEwhLAbVF2BtGWkDVi4da+JYnf1uwYeiZx2OQCzWnbmhaNxhAXgWmiZ/6yKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQf9nojb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80489C433F1;
	Tue, 19 Mar 2024 17:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710870059;
	bh=CKyJcdGuzJfzYC3Io1ni1ArcNYE/b8UBL4slLPFHKpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQf9nojbPOW4HrNNylLWnDlZHkF50T40x4EQZuDXubNIO8+PqbyWowceYtbysCw98
	 WJw0kczvcycOc5DO5OGOwcVsIkA/RZV83q++gFRsIt9a+fox615mRI9giMzh92xIEp
	 L5ZVem6qySpvk8ZYPecckBjBZBnKB4STaIx78c5oypwY/IbIDUc/bMBTv8Wbgzgr9m
	 laGIBrNX2D4KWT0cCAlpDUD6BDKcVzbLuNxTGUw6lgAogcZID7C5Ks/dM1doVn2e6/
	 aWmepWf7vklvJuHia+JJJ+SKMEbu2SYlCGIb3JZTUv/L77BLN2k4pgEHLXTlOsTrXb
	 YZwArHTx5mqRQ==
Date: Tue, 19 Mar 2024 17:40:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Add support for Loongson1 DMA
Message-ID: <20240319-trimester-manhole-3bd092f3343f@spud>
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <CAAhV-H6aGS6VXGzkqWTyxL7bGw=KdjmnRZj7SpwrV5hT6XQcpg@mail.gmail.com>
 <CAJhJPsVSM-8VA604p2Vr58QJEp+Tg72YTTntnip64Ejz=0aQng@mail.gmail.com>
 <CAAhV-H5TR=y_AmbF6QMJmoS0BhfB=K7forMg0-b2YWm7trktjA@mail.gmail.com>
 <20240318-average-likely-6a55c18db7bb@spud>
 <CAAhV-H4oMoPt7WwWc7wbxy-ShNQ8dPkuTAuvSEGAPBKvkkn24w@mail.gmail.com>
 <20240318-saxophone-sudden-ce0df3a953a8@spud>
 <CAJhJPsXKZr7XDC-i1O_tpcgGE9c0yk7S9Qjnpk7hrU0evAJ+FQ@mail.gmail.com>
 <CAAhV-H5Gm6mACV4smxDB=BJvLr8C1AmgY=mMqfNYOOxEUBhqFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zXRSty4a3vyseasR"
Content-Disposition: inline
In-Reply-To: <CAAhV-H5Gm6mACV4smxDB=BJvLr8C1AmgY=mMqfNYOOxEUBhqFA@mail.gmail.com>


--zXRSty4a3vyseasR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:40:54AM +0800, Huacai Chen wrote:
> On Tue, Mar 19, 2024 at 10:32=E2=80=AFAM Keguang Zhang <keguang.zhang@gma=
il.com> wrote:
> >
> > On Mon, Mar 18, 2024 at 11:42=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Mon, Mar 18, 2024 at 10:26:51PM +0800, Huacai Chen wrote:
> > > > Hi, Conor,
> > > >
> > > > On Mon, Mar 18, 2024 at 7:28=E2=80=AFPM Conor Dooley <conor@kernel.=
org> wrote:
> > > > >
> > > > > On Mon, Mar 18, 2024 at 03:31:59PM +0800, Huacai Chen wrote:
> > > > > > On Mon, Mar 18, 2024 at 10:08=E2=80=AFAM Keguang Zhang <keguang=
=2Ezhang@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Huacai,
> > > > > > >
> > > > > > > > Hi, Keguang,
> > > > > > > >
> > > > > > > > Sorry for the late reply, there is already a ls2x-apb-dma d=
river, I'm
> > > > > > > > not sure but can they share the same code base? If not, can=
 rename
> > > > > > > > this driver to ls1x-apb-dma for consistency?
> > > > > > >
> > > > > > > There are some differences between ls1x DMA and ls2x DMA, suc=
h as
> > > > > > > registers and DMA descriptors.
> > > > > > > I will rename it to ls1x-apb-dma.
> > > > > > OK, please also rename the yaml file to keep consistency.
> > > > >
> > > > > No, the yaml file needs to match the (one of the) compatible stri=
ngs.
> > > > OK, then I think we can also rename the compatible strings, if poss=
ible.
> > >
> > > If there are no other types of dma controller on this device, I do not
> > > see why would we add "apb" into the compatible as there is nothing to
> > > differentiate this controller from.
> >
> > That's true. 1A/1B/1C only have one APB DMA.
> > Should I keep the compatible "ls1b-dma" and "ls1c-dma"?
> The name "apbdma" comes from the user manual, "exchange data between
> memory and apb devices", at present there are two drivers using this
> naming: tegra20-apb-dma.c and ls2x-apb-dma.c.

I think it's unnessesary but I won't stand in your way.

--zXRSty4a3vyseasR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfnOJwAKCRB4tDGHoIJi
0nvrAQDhZVVmZ6duvOR3gVQKirxCEc7beNbKbw7KypGCx1HM8QD/flL3O4geYnwx
Q4s8Sg0+lo7D1opd2SceXluRzmFuBQc=
=+H9t
-----END PGP SIGNATURE-----

--zXRSty4a3vyseasR--

