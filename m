Return-Path: <dmaengine+bounces-435-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B377680C43C
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 10:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1BC2819C9
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFD321108;
	Mon, 11 Dec 2023 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="K97Abeap"
X-Original-To: dmaengine@vger.kernel.org
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 01:16:49 PST
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DD1AF
	for <dmaengine@vger.kernel.org>; Mon, 11 Dec 2023 01:16:49 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2e14:0:640:2cd1:0])
	by forward501c.mail.yandex.net (Yandex) with ESMTP id BA67660B25;
	Mon, 11 Dec 2023 12:10:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pAddjN8Caa60-KabXMH28;
	Mon, 11 Dec 2023 12:10:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1702285852; bh=UKtwdG87cbMckGwyNHeE1b5Vb5hNiKX74obiGUxAGKg=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=K97AbeapFDKuCtOee6amDMu8ldcf1mWMhdW2PujdAsJoL+9o2MZyTuY/7IDMsqjtw
	 QkEKLt+s2RMGhpDdgZyeAfvVlikeRXavIin32CqkoKmoDlmEoPXKOWxVkR9X/2ZKm0
	 CiCY0mtu7tPsvVcfT/s4miaxYBgyB4ZCi1JtZvD0=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <1bbcd4e612a1577d83456a5c88ad633547e59e9b.camel@maquefel.me>
Subject: Re: [PATCH v5 39/39] dma: cirrus: remove platform code
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Alexander Sverdlin
	 <alexander.sverdlin@gmail.com>, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Date: Mon, 11 Dec 2023 15:10:51 +0300
In-Reply-To: <ZV30llA4yDUs2G-Z@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
	 <20231122-ep93xx-v5-39-d59a76d5df29@maquefel.me>
	 <ZV30llA4yDUs2G-Z@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Andy!

On Wed, 2023-11-22 at 14:31 +0200, Andy Shevchenko wrote:
> On Wed, Nov 22, 2023 at 12:00:17PM +0300, Nikita Shubin wrote:
> > Remove DMA platform header, from now on we use device tree for dma
>=20
> DMA
>=20
> > clients.
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (device_is_compatible(cha=
n->device->dev, "cirrus,ep9301-
> > dma-m2p"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return true;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return !strcmp(dev_name(chan=
->device->dev), "ep93xx-dma-
> > m2p");
>=20
> Haven't you introduced an inliner with the similar flow? Why not
> reuse it?

It's the same, i moved it from platform header file into driver itself,
as i am removing "include/linux/platform_data/dma-ep93xx.h" completely.

>=20
> ...
>=20
> > +/**
> > + * ep93xx_dma_chan_direction - returns direction the channel can
> > be used
> > + * @chan: channel
> > + *
> > + * This function can be used in filter functions to find out
> > whether the
> > + * channel supports given DMA direction. Only M2P channels have
> > such
> > + * limitation, for M2M channels the direction is configurable.
>=20
> I believe
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/kernel-doc -v -no=
ne -Wall ...
>=20
> against this file (and maybe others!) will complain ("no return
> section"
> or alike).
>=20
> > + */
>=20

Agree, dropped doc style comment and converted it to simple comment, it
is internal to driver now, so no point putting it into docs.

