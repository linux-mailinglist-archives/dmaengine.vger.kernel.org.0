Return-Path: <dmaengine+bounces-2427-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C65AB90EB33
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 14:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1211F24B8D
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFE3142E78;
	Wed, 19 Jun 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnASga92"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60E82D9F;
	Wed, 19 Jun 2024 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800493; cv=none; b=GuwsaNIPsz3kK0lazyYdc7ItbF/6Ac6jx1HB8/6CGiV0XwXPYENELR4iLCuuN6ODBpfOegIHL/u7L3ymnaXlLdkD76XpguFwGd9Mvwq2XE5Pkxdtm4oShDo2u+MsTbfq+i3pgjVn2FGkXH0TawdO6xkKNk0TJHDxP8x9KXgT55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800493; c=relaxed/simple;
	bh=izLEjKclWmIAjHC4MNPzF0kEUXBzIGhUDyI33snqJIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M096exBoNcwSeCrr4GmGULO5EzS8bYl4f2Pn+PQng0+i8h1lF13qS+G/ItLJ8hdK3EX+hm6EidldV89gechlc0z8K1DGIQ7BnhUH/vrS4nTK6WmVN2XNHOYTR+ziyYlgpeej+MtDZKUNZRl9tRqlQlGlYaUJc/AGwqBSOm+1oXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnASga92; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9b523a15cso3278025ad.0;
        Wed, 19 Jun 2024 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718800491; x=1719405291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=izLEjKclWmIAjHC4MNPzF0kEUXBzIGhUDyI33snqJIc=;
        b=DnASga92zvP15UWiLkNfkdvFzbyay1o9y+0G8uR1T3nSe3Oa8Y5T3gzO6YfO1C5LC/
         oz5Zv3qrR4PCWmpDd9rOs4qunHHsgqVEgqfZxvNm6F94DxZwZKmEMPNTNqJ+ubb+C7MP
         aA3DL5qmjEqL2rwv0ltOfi9RYN6C5e+HD77Lw/4NpXyOLjGekodUakxM8Y4iB/a7r37O
         RNURp0FGJZ1u4TD4g/OW9GRle2H2bxAQwV6RscqAMz+gu6gEAUAkEGJ46nno2Q9PgrW5
         Xt1r4qBj3fyLfTIjbdE7UmUlqBthdWJxSdUroyQ4O7xXqBU91Cm83PvEY762DMjDvLnz
         7T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718800491; x=1719405291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izLEjKclWmIAjHC4MNPzF0kEUXBzIGhUDyI33snqJIc=;
        b=rt7FuRHdnRso3pfGlTtlyawXP+ExhbNger2QB4hFwonRbNsiFUEy8nUrg+dfU/8tMP
         YP3GClBF9yA+iZe9QkGEWaPgOJN9VVhaDK3tENI8HBV0OJF8jp9QxdaEu93z8JCwe+gZ
         CgW13xt3VcnDrtfwEbGC+0U0pAAlQI2+gcWseIeOrLnm4yUTAbPmr0FB8mWQMsiO06aZ
         wwl7J4RZlvHw+xPdizHZd93mFrGAK82x2u8H5cw160dbVsNkBMzRCSA1aR6HgUu6Fvtk
         Q7jT/vZG4aDUDqIdlflZv2bsHabEXg6PVtEgMSIomCbYK96ciXH87MM7VS7E6DuBgi3V
         VUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBDMR3o5rKN5X1JnxzBg065kXlSeQMgwWjTuB3zghiiJre2MgZ1QXrMqwSl9yJGh7NhX/YE5DKAhKHZpIo33cgAB0DBCtH/qRkXRIZ+LaUMZ+GeuLH6hgm47oKsr4SwpW3q/YruAi2nA1WLEBAtVCvGR0nTDvENVbC0lrIP/1/1PlY6gbZbu2ChRXZGplNildnkYJT8qE2L4lSDnMhWF0MS0aL+WqfQ1f1HU1Y2tepvdp3h1jjBHesrjA=
X-Gm-Message-State: AOJu0YxD6ab7rVNLdaWzr4KYEISMQioH0YBpQQ9G0TX6umo/ITLIq0S0
	WKPpUzqZP7Ex1bFSVNYFwwWwryFILwXWmaHBJ/eE5Ih/dxui5Mni
X-Google-Smtp-Source: AGHT+IEcB9hqDiOaiiqXDcdkruBbV/uMxC4QPzGwEbCe7v1uupCHq+Ap/o3FdsOBJyDISnfA+bQ6nQ==
X-Received: by 2002:a17:902:e80d:b0:1f9:b19b:4281 with SMTP id d9443c01a7336-1f9b19b46admr18456575ad.33.1718800491391;
        Wed, 19 Jun 2024 05:34:51 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1ac4bsm115511095ad.227.2024.06.19.05.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:34:50 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AE04C190E115C; Wed, 19 Jun 2024 19:34:48 +0700 (WIB)
Date: Wed, 19 Jun 2024 19:34:48 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Paul Cercueil <paul@crapouillou.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v11 7/7] Documentation: dmaengine: Document new dma_vec
 API
Message-ID: <ZnLQaBQrV7KhxOeC@archie.me>
References: <20240618100302.72886-1-paul@crapouillou.net>
 <20240618100302.72886-8-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P+G0VMb+YrutxSpB"
Content-Disposition: inline
In-Reply-To: <20240618100302.72886-8-paul@crapouillou.net>


--P+G0VMb+YrutxSpB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:03:02PM +0200, Paul Cercueil wrote:
> Document the dmaengine_prep_peripheral_dma_vec() API function, the
> device_prep_peripheral_dma_vec() backend function, and the dma_vec
> struct.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--P+G0VMb+YrutxSpB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZnLQaAAKCRD2uYlJVVFO
o62HAP9Sf4C2GxRgQTiPvegZlarJtrtpsHOKgq1BhJIuokVeCgEA3Sb4DkOK66Dj
J768fmI0av+lWGHkQD9s9mkd4Y3TcAc=
=Ys7t
-----END PGP SIGNATURE-----

--P+G0VMb+YrutxSpB--

