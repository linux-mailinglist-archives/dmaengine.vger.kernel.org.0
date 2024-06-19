Return-Path: <dmaengine+bounces-2428-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102990EB51
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 14:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAF31F219E6
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 12:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FCA143752;
	Wed, 19 Jun 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpM1yyQt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515914372C;
	Wed, 19 Jun 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800949; cv=none; b=QpN71tgqp9Nsvzopg4R76B4apOJ6u6fP1x8hMH4T6z2IeSl3wvzNDniOlYz9SzSg3h0d05wNHmSXhlmbVqSUdg37xQQmU6gvtHoXrqqrEbz+eK+WLb5KFgS5BOZ1hIV7cEkCxe/pIvfQ5xSwpbmd9qgk7SK3aiY2h0eV3Nm0SpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800949; c=relaxed/simple;
	bh=SByv/3h9r3a4Qn4WiJyJL8zDWTb94P7sc74/rI4gJdE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EnBjmkqLaSX60cp0MoZIGWNyADiaeyKzHcNn9P5OgHC9rMWgBmQt8rFdNpyWp3H/twTMPsznE9WmQE5W3LNIN2DDGapDYcqgUwjpRSxhVvb8Pn0Ppjy1jQTerD/rWIDIysa/GHtPmAyyRv7YTEcsj1/KgC1oWOhPjPCiNi2dNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpM1yyQt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3609565a1bdso2751754f8f.1;
        Wed, 19 Jun 2024 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718800946; x=1719405746; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SByv/3h9r3a4Qn4WiJyJL8zDWTb94P7sc74/rI4gJdE=;
        b=BpM1yyQtdOijm6fQ8D8hjmzGWqHsl60Sv3s068mg3USmAgr95V/5rkl9Sjx8nFH3j+
         Z1Y+ZGbngdW5DegJwUj2A69/fIoCsyTWCrFKt9HsnTml79QW6ep7qdtcVUHdwNJDnK+w
         YCdosh5oA8xrg50TY+CbzJbsI3Uu1wH81eRXuAKX2O4Du1ITv69O7herIvpc4qJy9aSG
         H5NgZ/iWQgkecWGwfrnP/e9RY+4T/7joz+j/HryiSNMQ36yFI/UL9dEpdL4z4+ZlCe4q
         i+RCKkK5etI7FAb9GZTc7Dfhht5CedxRZSYd5SFGlx2T4d2L3Y0svE9+DfgSY+WGLLhH
         PojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718800946; x=1719405746;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SByv/3h9r3a4Qn4WiJyJL8zDWTb94P7sc74/rI4gJdE=;
        b=B8nLFdBzNpCWDWz+qEOJkruby9kjKeDD+eXR+2dyXpph5zevfE7Epgbj/0XExFNOQv
         KLVwmyC2RukR1l/IKxomEaIekQM8G2GNI41kFajlSflWyCp1Yv4yiBfI1Zb+A/1Vux3n
         aHaMWkbyPixuNSJW9WI5RthHJcnFzajwhYVEgly3DDn1JjaKgC49fcJwvU8VvHvvAY1C
         E69WkxdRuyTewsy8iSbP1hQt4UElYIzLIAXas944UNbs5bqb8QHwXpKbPxtkIprCA6Kx
         xT1TkE2scxCEy3YSSuaRhDpT/UTs7LZiBNfpBFHxm6ceW5I4FKA609rySbf3hK/dhxuq
         2wsg==
X-Forwarded-Encrypted: i=1; AJvYcCVHh9ay1+ZnN8EygaGXrHpQddRaLk2TryausLqV02ed+Bt3vQEs9VcLufJeCzcwDltoMV60T2EkeOi4AXIw8UMUidLuR16QJx3fsp+0BAeAShDA25Us/wXYw6YmYjr/NWpI/q5Tn3GvAt3n3WqVKcafM1m2WckMbhZWWgzNeXd+sBjJXKsjWIptleeBS99T/tDLklCVJYm/Zp6c5ys4Zs2ukwR8eAEaDDiA16Ej03NHEwMxDCezlzIKkhk=
X-Gm-Message-State: AOJu0Yw8cNWJpbhRhlzJfQ0zLCh+qqGDQfCWF9topQ4XZsl9YdORhttK
	edpmdVYUfKju4dOltEbxArK3s9UNEAf7/Hr5POWfU3UC6v+gEi0Y
X-Google-Smtp-Source: AGHT+IF/Ojl1lCzIwbb45P/jSm86hTqAzckOlwd+zvudCih8xPEeyV/X1b+GBHx7mkaxSTjUHPDwzQ==
X-Received: by 2002:a5d:5259:0:b0:35f:1f13:9638 with SMTP id ffacd0b85a97d-36317898472mr1843020f8f.28.1718800945924;
        Wed, 19 Jun 2024 05:42:25 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104b8bsm17125682f8f.105.2024.06.19.05.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:42:25 -0700 (PDT)
Message-ID: <412eb0f294b4bdef69b0d988e8f1c8a36c29d22e.camel@gmail.com>
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Paul Cercueil <paul@crapouillou.net>, Markus Elfring
 <Markus.Elfring@web.de>,  lkp@intel.com, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  linux-iio@vger.kernel.org,
 dmaengine@vger.kernel.org,  linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org,  linaro-mm-sig@lists.linaro.org, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>, 
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap
	 <rdunlap@infradead.org>
Date: Wed, 19 Jun 2024 14:42:24 +0200
In-Reply-To: <15edbedcac80961ec9b7834041e54143657cd48b.camel@crapouillou.net>
References: <202406191014.9JAzwRV6-lkp@intel.com>
	 <a4dd1d73-5af3-4d3d-8c0f-92dc439fa119@web.de>
	 <d452ecc4fc703a1f98aa4f243c6ded7fbfe54b0e.camel@crapouillou.net>
	 <cbcfb64a-e5c2-41a7-8847-227d4f6872de@web.de>
	 <e948cd137da8e4f97bfbf7ef68a5450476aeee0c.camel@crapouillou.net>
	 <41fa9904-28a8-46fa-bf2a-014875409b83@web.de>
	 <15edbedcac80961ec9b7834041e54143657cd48b.camel@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 14:21 +0200, Paul Cercueil wrote:
> Le mercredi 19 juin 2024 =C3=A0 13:56 +0200, Markus Elfring a =C3=A9crit=
=C2=A0:
> > =E2=80=A6
> > > https://lore.kernel.org/linux-iio/219abc43b4fdd4a13b307ed2efaa0e6869e=
68e3f.camel@gmail.com/T/#eefd360069c4261aec9621fafde30924706571c94
> > >=20
> > > (and responses below)
> > >=20
> > > It's more nuanced than I remembered.
> > =E2=80=A6
> >=20
> >=20
> > > > * Will the desire grow for further collateral evolution according
> > > > to
> > > > =C2=A0 affected software components?
> > >=20
> > > Not sure what you mean by that.
> >=20
> > Advanced programming interfaces were added a while ago.
> >=20
> > Example:
> > https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup=
.h#L8
> >=20
> > Corresponding attempts for increasing API usage need to adapt to
> > remaining change reluctance,
> > don't they?
>=20
> Sure, I guess.
>=20
> But that does not change the fact that I cannot use cleanup.h magic in
> this patchset, yet, as the required changes would have to be done in a
> separate one.
>=20
>=20
Not to speak on the added churn in doing that now. This is already v11 and
complicated enough for us to add another dependency.

Moreover, yes, cleanup stuff is very nice but if some interface/API does no=
t support
it, it's not up to the developer using that interface/API on some other pat=
ch series
to add support for it.

- Nuno S=C3=A1


