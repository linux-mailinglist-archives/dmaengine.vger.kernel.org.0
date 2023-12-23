Return-Path: <dmaengine+bounces-652-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A493F81D364
	for <lists+dmaengine@lfdr.de>; Sat, 23 Dec 2023 10:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E5281782
	for <lists+dmaengine@lfdr.de>; Sat, 23 Dec 2023 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9029456;
	Sat, 23 Dec 2023 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="QI4e097o"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0939944F;
	Sat, 23 Dec 2023 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5700:0:640:9f25:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTP id 2DBED5E7F8;
	Sat, 23 Dec 2023 12:50:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wnMTcg7sH0U0-lC5po5G3;
	Sat, 23 Dec 2023 12:49:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1703324999; bh=rnbUS06+JV2kXQzoFZqstlw6VQtLSVdgCy936EMVjgo=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=QI4e097osx6nUf8GCAXmt6FXdpo1Rk5NkdDGDcJGaedXM5+Jof2uM7pNFvOdTvIMa
	 Oc302eD82abfsw0xhOUQi09sTQZOydzjJmrFS0mUn26TAgzA/Zc4ydPdKuecrPD/9k
	 jCFC5uw+fLs8kXrDiFFp490pjD0ECksL2jT6pkZA=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <4b6e64cea850c7db974aac97d71560be4e261b1c.camel@maquefel.me>
Subject: Re: [PATCH v6 40/40] dma: cirrus: remove platform code
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Alexander Sverdlin
	 <alexander.sverdlin@gmail.com>, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date: Sat, 23 Dec 2023 12:49:59 +0300
In-Reply-To: <ZXn4UIkoJeHnAAGW@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
	 <20231212-ep93xx-v6-40-c307b8ac9aa8@maquefel.me>
	 <ZXn4UIkoJeHnAAGW@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 20:30 +0200, Andy Shevchenko wrote:
> On Tue, Dec 12, 2023 at 11:20:57AM +0300, Nikita Shubin wrote:
> > Remove DMA platform header, from now on we use device tree for dma
>=20
> DMA
>=20
> > clients.
>=20
> ...
>=20
> > +static inline bool ep93xx_dma_chan_is_m2p(struct dma_chan *chan)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (device_is_compatible(cha=
n->device->dev, "cirrus,ep9301-
> > dma-m2p"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return true;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return !strcmp(dev_name(chan=
->device->dev), "ep93xx-dma-
> > m2p");
> > +}
>=20
> Hmm... Isn't the same as new helper in a header in another patch?
>=20

Indeed it's internal now. Move here from platform header.

