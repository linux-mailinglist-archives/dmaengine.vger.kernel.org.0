Return-Path: <dmaengine+bounces-1417-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA10187E895
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 12:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F4E282952
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E15364B1;
	Mon, 18 Mar 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M94LeBaz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F82EB05;
	Mon, 18 Mar 2024 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761301; cv=none; b=vAWoKxe7t6+VH2jx2qrR+A+BTH24R98fGoJdc0SL5lxGpcCbRtwW0bSUoHByMOFr65Ga9ouKPDZmq5eBGoJo+4ojOf7HsBvOhtZ45mUMi/u/0VofgD4e5U4CQNu9z012j5GMnCD4exbzkGN3GuH0/zQDherzkk56VUQ1Z1pWWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761301; c=relaxed/simple;
	bh=YWSGx/XRw+rQGSUAj5COs58nByZSMdkxqDrDOksH/64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4atp0jbq76oVvxgszysIGbLJThlLoW0D3Fk8CwlhrhhYcKf8hE0t61r0fY78mYBVH4nthzYu1V0+c7iYf147JCInvg/CDe4ym12RpecRrXJzjaCeU0Unqk8uieIIPWpXMp5hpEEx37HWOm/wQ4RpUJp7YQXJMlpE1wc1yY+BMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M94LeBaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D29AC433C7;
	Mon, 18 Mar 2024 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710761300;
	bh=YWSGx/XRw+rQGSUAj5COs58nByZSMdkxqDrDOksH/64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M94LeBaz5RutfpnW9DhqWssP+WDFS9DQ55rIwEA9vZKL6kRrPxUx4YNV0nzm5yclY
	 IJzFMl3RJ8a09aQLN56aoPDM5YC9Cc831Jjc/36B6vjckSyOfneNSnPEMcKOIUQ2+e
	 yqp71W6Xkxr5Hsdo5PuBlWiPFbCzRLJPGW+D24ClPQEHf2VZCXiIRfWDBW5uTdbihB
	 +REtsgrggQM4SU5ctOYzmeFCocVPMfiu9MCZAAgIQ2hO5LHixNe0deDa4C7SO/H9JS
	 Y67FGNz3xwHLnfbagq+A1TyOLd1CQfZN8vrr9B7QpuC/Lg6YTGI76paHiASJNZE8hA
	 3qDF2XIoY/dXg==
Date: Mon, 18 Mar 2024 11:28:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Add support for Loongson1 DMA
Message-ID: <20240318-average-likely-6a55c18db7bb@spud>
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <CAAhV-H6aGS6VXGzkqWTyxL7bGw=KdjmnRZj7SpwrV5hT6XQcpg@mail.gmail.com>
 <CAJhJPsVSM-8VA604p2Vr58QJEp+Tg72YTTntnip64Ejz=0aQng@mail.gmail.com>
 <CAAhV-H5TR=y_AmbF6QMJmoS0BhfB=K7forMg0-b2YWm7trktjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QhK2PIeDRLdrsGtC"
Content-Disposition: inline
In-Reply-To: <CAAhV-H5TR=y_AmbF6QMJmoS0BhfB=K7forMg0-b2YWm7trktjA@mail.gmail.com>


--QhK2PIeDRLdrsGtC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 03:31:59PM +0800, Huacai Chen wrote:
> On Mon, Mar 18, 2024 at 10:08=E2=80=AFAM Keguang Zhang <keguang.zhang@gma=
il.com> wrote:
> >
> > Hi Huacai,
> >
> > > Hi, Keguang,
> > >
> > > Sorry for the late reply, there is already a ls2x-apb-dma driver, I'm
> > > not sure but can they share the same code base? If not, can rename
> > > this driver to ls1x-apb-dma for consistency?
> >
> > There are some differences between ls1x DMA and ls2x DMA, such as
> > registers and DMA descriptors.
> > I will rename it to ls1x-apb-dma.
> OK, please also rename the yaml file to keep consistency.

No, the yaml file needs to match the (one of the) compatible strings.

--QhK2PIeDRLdrsGtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfglUAAKCRB4tDGHoIJi
0imRAQDW5obsdOQ1Qf36y3Y9p4UM3IbT22yjGxcXNXDRMsONYwD+KVzSWGSm73jY
MbZrvy6JxG0g0IPxRKAVdrIehFUZAgI=
=+PD8
-----END PGP SIGNATURE-----

--QhK2PIeDRLdrsGtC--

