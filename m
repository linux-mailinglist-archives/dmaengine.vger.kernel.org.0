Return-Path: <dmaengine+bounces-2132-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FC48CB388
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 20:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B26282D34
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DEA147C73;
	Tue, 21 May 2024 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSNDHaLt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DD2B9A7;
	Tue, 21 May 2024 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316384; cv=none; b=KRi8c1m7qXGyX+yGuT4wy948QoFLNT5gsxZEDyg3c2fHFvGeUb6Pn+qH+u7x3oXwflQeRd2oCrNgmfI8uXv1xvYPO9PU3NTks1oWjSpJrd00bbjfdaigVLhCxhC0paMTlN0lF645luNp50f5/t/36Mp6bPTuWAwrcV5sXd9i5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316384; c=relaxed/simple;
	bh=9oN1+Qiu3ZjosqghZMHoJO8Wg1Ja4YbCGeqa01ozJAg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXJlkARTELFzaE6TS4qch71mTa7L3zhHMs5PQLGX1rk1rDBI/trZrF2lUuQ55M3C+98YhSdNxTPSVprOtAf8LWx515Jvlk8cVI6o/BqdkUeJJ9I8S6V5mTe4RYUEHQMXIDHRpu0DBMRTmSMLdqMUEXURVCe4V61P3Ukb0giCdwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSNDHaLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61784C2BD11;
	Tue, 21 May 2024 18:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716316384;
	bh=9oN1+Qiu3ZjosqghZMHoJO8Wg1Ja4YbCGeqa01ozJAg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=uSNDHaLtNjHp2bjf1f3dSmtpezQrkutqJSil0Qx1MnHaq9gR0MBDVINkZ4iOz+En/
	 BA35lwYMXxMvSg/Q/f8amERGWFDhPiKVcWoyAwEd5PRk/a3QiTt13iOBJRu06J3D4g
	 YUxma3QKyESdLVXxaaJUcnNVuKQQuZvsvO4UsuzQAVlJycrFC9ZJsLgoN3n8aSGIIk
	 8n+1kDQQxXTEoJ2E//iK82okve78UL/AIZUAyKm3NP/fvk8W9BzV0T3rnALo2sUtxz
	 huX6UnzXbzV+YhlvxX+fAfWpuysU5m2Q3D3e30eI/95ULOdCsATVaDhY5uW/6lEozx
	 J78PA6sv6sDmA==
Date: Tue, 21 May 2024 19:32:59 +0100
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
	alsa-devel@alsa-project.org, miquel.raynal@bootlin.com,
	perex@perex.cz, tiwai@suse.com, lars@metafoo.de,
	lgirdwood@gmail.com
Subject: Re: DMA Transfer Synchronization Issue in Out-of-Tree Sound Card
 Driver
Message-ID: <6e01c13f-2bc1-4e08-b50e-9f1307bda92d@sirena.org.uk>
References: <Zkxb0FTzW6wlnYYO@localhost.localdomain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xueZ6/gZSHePXE0a"
Content-Disposition: inline
In-Reply-To: <Zkxb0FTzW6wlnYYO@localhost.localdomain>
X-Cookie: Eloquence is logic on fire.


--xueZ6/gZSHePXE0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:31:12AM +0200, Louis Chauvet wrote:

> To address this DMA issue, I have created a patch [1] that guarantees the=
=20
> completion of the DMA transfer upon the return of xdma_synchronize. This=
=20
> means xdma_synchronize now sleeps, but looking at other drivers around it=
=20
> appears expected to be able to do so.

You need to set the nonatomic flag for the PCM to allow this, the
default is that triggers run in atomic context.

>=20
> 		switch (command) {
> 		case SNDRV_PCM_TRIGGER_START:
> 			/* Synchronize on start, because the trigger stop is called from an IR=
Q	context	*/
> 			if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> 				dmaengine_synchronize(my_dev->playback_dma_chan);

If any dmaengine work is needed put it in the generic dmaengine code and
allow it to be configured there (ideally through discovery through the
API).

> The problem might be related to the sound driver. Should I avoid manually=
=20
> using dmaengine_synchronize? How to achieve the same effect in this case?=
=20
> Perhaps there is a more traditional way to properly clean the stream in=
=20
> the sound subsystem which I overlooked?

If there's no way of resetting things without blocking then I'm not sure
you can do much better though I might be forgetting something, it does
seem like disappointing hardware design and application behaviour.

--xueZ6/gZSHePXE0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZM6NoACgkQJNaLcl1U
h9CQJgf/SoGgK5fxlN1tBFGIN5h4MwbX7Y5VNEDDebRPlp4d9xf84kvYAyqY83vL
PJ0Ta78vJLPUxM8CeHXkn5duaLzUAsAtJsn5gtSCBdUy3rhlvMt4v2JkNYE2nZ16
HilFrOejdfXGebjpHoPP4KocrUTQTSEuiHvOViuql2h4kqbt9PYaz9SATZii7QXT
cbaLKt7YlY2M8X4FCvy3O782rx7CJRTpK9QMm9SYJ0BMhviRCom084r+dQkuqFn3
V3MRZukP9UEMr7E8HrTU8NMOeQVoogf7ppb4h5xiQ/tZCAUfvoP4U6j/LZInc0NN
bNEb/K9hJvM14U9yp/rsw5ub2jhcxQ==
=Su6g
-----END PGP SIGNATURE-----

--xueZ6/gZSHePXE0a--

