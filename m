Return-Path: <dmaengine+bounces-2203-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951108D333B
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2024 11:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F061C23CA5
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2024 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0116A361;
	Wed, 29 May 2024 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="Cz6a153t"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21C169AD1;
	Wed, 29 May 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975586; cv=none; b=i94RddPA1Fl/rieEj2Yhb/Y7e4RUSsJ04xNO+k/PKmiTwGtmW+Kpu6VE7Wdk6u0Z9k0bXvEpGnGcG0yOV8OYAC7Kczk7cKflB8gQN0nMy8kg0eqYe51uwOhFj2KDCfnGTrh10ZoYy3DDFPh4T8cgoTMx9UZf4lbB2L4CbKKZswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975586; c=relaxed/simple;
	bh=l7mhXePXHTFDyJUwQC4y7lNYr3qtq/le3v+/Gidrbl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClkeP+irobvaamsgZrF5nW/8EbZJkbhZcXikhu6Fhh3oGg7nk1R3i3aB2HZ8YdAB17thww8z7kdVQwhLtL2XvkAlyUzSkFcqXMjW7RfTb4cPP7et3G6Bm0ntSz489yDFFxYaFkINsdt6+1r/PX/4cjEz9kfr5jLpXcoR4l5K5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=Cz6a153t; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:20a3:0:640:7ed3:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id CCD715F368;
	Wed, 29 May 2024 12:34:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1YNEP8GXnKo0-fskH20Jg;
	Wed, 29 May 2024 12:34:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1716975242; bh=l7mhXePXHTFDyJUwQC4y7lNYr3qtq/le3v+/Gidrbl0=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=Cz6a153tsNlUNXCWJA+xj20FfesTujtqIfabhWuo/O35m+IyHW61ET45zp6Xby87C
	 1VYv/PrXJwOE+b1Tp/R2PV/qgU+XFF4ONVWXk2ha5dVz2W1s29lsVxxeXPMNP3PHAe
	 LnLrrq9mgp7iFNjP+qd7/iU+vExcRSDOMHzUbAN8=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <5757d0ff5754f537b16ae36f9e7b5c2399c2cb5e.camel@maquefel.me>
Subject: Re: [PATCH v2 0/3] dmaengine: ioatdma: Fix mem leakage series
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Dave Jiang <dave.jiang@intel.com>, n.shubin@yadro.com, Vinod Koul
	 <vkoul@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@yadro.com
Date: Wed, 29 May 2024 12:34:02 +0300
In-Reply-To: <e3ec5070-abb7-4adc-9cd1-c459ca27b531@intel.com>
References: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
	 <e3ec5070-abb7-4adc-9cd1-c459ca27b531@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Dave!

On Tue, 2024-05-28 at 09:08 -0700, Dave Jiang wrote:
>=20
>=20
> On 5/27/24 11:09 PM, Nikita Shubin via B4 Relay wrote:
> > Started with observing leakage in patch 3, investigating revealed
> > much
> > more problems in probing error path.
> >=20
> > Andy you are always welcome to review if you have a spare time.
> >=20
> > Thank you Andy and Markus for your comments.
> >=20
> > Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> > ---
> > Changes in v2:
> > - dmaengine: ioatdma: Fix error path in ioat3_dma_probe():
> > =C2=A0 Markus:
> > =C2=A0=C2=A0=C2=A0 - fix typo
> >=20
> > - dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
> > =C2=A0 Andy:
> > =C2=A0=C2=A0=C2=A0 - s/int/unsigned int/
> > =C2=A0=C2=A0=C2=A0 - fix spelling errors
> > =C2=A0=C2=A0=C2=A0 - trimmed kmemleak reports
> >=20
> > - Link to v1:
> > https://lore.kernel.org/r/20240524-ioatdma-fixes-v1-0-b785f1f7accc@yadr=
o.com
> >=20
> > ---
> > Nikita Shubin (3):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmaengine: ioatdma: Fix leaking on versi=
on mismatch
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmaengine: ioatdma: Fix error path in io=
at3_dma_probe()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmaengine: ioatdma: Fix kmemleak in ioat=
_pci_probe()
> >=20
> > =C2=A0drivers/dma/ioat/init.c | 54 ++++++++++++++++++++++++++----------=
-
> > ------------
> > =C2=A01 file changed, 29 insertions(+), 25 deletions(-)
> > ---
> > base-commit: 6d69b6c12fce479fde7bc06f686212451688a102
> > change-id: 20240524-ioatdma-fixes-a8fccda9bd79
>=20
> Thanks for the fixes.=20

Glad i could help.

You might find this one useful:

https://patchwork.ozlabs.org/project/qemu-devel/patch/20240524114547.28801-=
1-nikita.shubin@maquefel.me/

I think sometimes it's much more faster to test something with QEMU
than tinkering with real hardware.

>=20
> Reviewed-by: Dave Jiang <dave.jiang@intel.com> for the series
>=20
> Would be nice if someone wants to move everything to the devm_*
> management APIs. Would make this a lot less messy. Probably not worth
> the effort though given how old the driver is and no more devices are
> being created to use this driver.=20
>=20
> >=20
> > Best regards,


