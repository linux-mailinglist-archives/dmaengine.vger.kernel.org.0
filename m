Return-Path: <dmaengine+bounces-4233-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F3CA22DDF
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 14:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9503016800B
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A701E3DD8;
	Thu, 30 Jan 2025 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paj8Ojc2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4BB199939;
	Thu, 30 Jan 2025 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244074; cv=none; b=S861weMBeaS+iAmelXVeCvLazIng8qdk7B9PXcJL1X58JBvuUe5PGAwIM4Nd1vTPXU4D7hThHY31Zmy9mXFry7hs52b3bTsnYRWieukGjN7V05Bd49IOrreN4qNjO6TZvN4yc+NEcJZjAynogegugoCrI0a8NTE0BGIK+aWDYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244074; c=relaxed/simple;
	bh=J0b+obWMjwAaXulYmF/USRpijIdeFA5Q4buPxAHpfEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agpHe95PBOQAjOaGdjhd0jEd9TRyrKArtVDBFhJNlihOZjGdX5vhX46QFy1vwsnYjLqNilDg1ohGCOPQxZiWoY5W99XLxPQP5Kl0HrBfMWteaWClzJOVrae0xw0UemP73nrsDsfE9niF+ER8owtycwryfMuW4hhSAK7jgRfHnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paj8Ojc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46798C4CED2;
	Thu, 30 Jan 2025 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738244073;
	bh=J0b+obWMjwAaXulYmF/USRpijIdeFA5Q4buPxAHpfEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=paj8Ojc2487u0LjD1LvjOz88O1023RfHLGy5RmT3rBujmTTDmWlKY9vHjdrVr9rWl
	 SunBQKrHpL6RsyKaEXqU6rtx47XgEpdc4yMLc1eVKKd2SOkeBqFb8OvS3332+janft
	 cVZ+UHaBuJnnaPEclpK6uegtAvC+fji9P9Ab+czIV4O/LDady49Die3UbM7vPIv1oU
	 Df8aN8hfG/V/bgtF45VguGhzoSGpblA6d5B/1BAFITSq5XiYn2w+Qk3sITk7g/4/w7
	 UrtqvkTqnQNxxaGAE9tRACSLqtdyEv86Pklg0hAq91KZ3weKygnCZRqQqRZ3XNZJH1
	 gMKBYmwwZTsLg==
Date: Thu, 30 Jan 2025 14:34:30 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Florent Tomasin <florent.tomasin@arm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yong Wu <yong.wu@mediatek.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, nd@arm.com, 
	Akash Goel <akash.goel@arm.com>
Subject: Re: [RFC PATCH 2/5] cma-heap: Allow registration of custom cma heaps
Message-ID: <kyesso3gaajbdze3ie4imrmrk2lzqf6s7eoonlljeitfs3utwh@dycnl7cnzep5>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <2255866ee9e81136a7099376b34b8305758ec9f0.1738228114.git.florent.tomasin@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="x43ujhulkmklcecy"
Content-Disposition: inline
In-Reply-To: <2255866ee9e81136a7099376b34b8305758ec9f0.1738228114.git.florent.tomasin@arm.com>


--x43ujhulkmklcecy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 2/5] cma-heap: Allow registration of custom cma heaps
MIME-Version: 1.0

Hi,

On Thu, Jan 30, 2025 at 01:08:58PM +0000, Florent Tomasin wrote:
> This patch introduces a cma-heap probe function, allowing
> users to register custom cma heaps in the device tree.
>=20
> A "memory-region" is bound to the cma heap at probe time
> allowing allocation of DMA buffers from that heap.
>=20
> Use cases:
> - registration of carved out secure heaps. Some devices
>   are implementing secure memory by reserving a specific
>   memory regions for that purpose. For example, this is the
>   case of platforms making use of early version of
>   ARM TrustZone.

In such a case, the CMA heap would de-facto become un-mappable for
userspace, right?

> - registration of multiple memory regions at different
>   locations for efficiency or HW integration reasons.
>   For example, a peripheral may expect to share data at a
>   specific location in RAM. This information could have been
>   programmed by a FW prior to the kernel boot.

How would you differentiate between them?

Maxime

--x43ujhulkmklcecy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5t/5gAKCRAnX84Zoj2+
dqCmAYDoWSZStP9SqqDBsMXAXM2LcdlKGIxA9z3zUEk7mfa1Tr8e2yuFJiIaj32i
idm/BgQBfjHysDgl5TQpuMaxC4xCpEeBM/24GEO2Z7T2jFQ/knGH6TS9zQ95+16V
MmgikebI5g==
=QJcw
-----END PGP SIGNATURE-----

--x43ujhulkmklcecy--

