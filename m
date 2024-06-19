Return-Path: <dmaengine+bounces-2426-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E9790EAFE
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 14:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589671C20C59
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572FF14EC78;
	Wed, 19 Jun 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4IhSgHY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7B1422C1;
	Wed, 19 Jun 2024 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799748; cv=none; b=qXH15DRBQZMGNIjJqzYRwwepSiqTAzSjPJofB255GMuHQpx2hLs/kCbJBgHE3D3nsUk7KJ/zgpA+V/p7vRMYN1EKBYE8N751jhLgoHGVn3hBfcVtdX3A2bvPyEAAk7Vxai0fwqmdGUAVCinhwfDaiHVZiBrhm0yTjc3wYReUcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799748; c=relaxed/simple;
	bh=V41/rcWKltI+WknTyeXP06R8W+cGdmxAwRdLK3VXRV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oC7GTRBF6tw76h69U20WDQL0lvSKfGVO9vBFQU1SZb9Gu42YMmDYnI3MhP+lqtbJDxX/HNtOCpX3+TBuw39oM5D3c+5Enk5tp7vbaMqRX7X/kcw7ruIREh9DzJ0uaMt8kxnCgMF/C6CRzud7TLItxRZalORxknc/NuexMvfwvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4IhSgHY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-704189f1225so5756692b3a.0;
        Wed, 19 Jun 2024 05:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718799746; x=1719404546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V41/rcWKltI+WknTyeXP06R8W+cGdmxAwRdLK3VXRV4=;
        b=X4IhSgHY1PWhRgqXGYmQKpGyc04XCU1J7i7RT/sC9yMcTVIPgjrx8tOY4imNNHoUhM
         u4gBIoQmaZI1STxj7a7UuX8XePLdiO19BtjBanIU1OtQPWYngTbkakQtiSMWDV/U9bO5
         M9ZL84S/GVHmMQuArAVkMgTXG4AnDET6K0rZ9j11NxVgafWM+KyT2mMNpwJTvBFExVh5
         78A5pig8CEiQlHWDkY6uamfv0ifCTm2f8mdk+rN57V2zQRXaugWDNjksUt7znRvQooTI
         c7HoVcUhm3rUQ3Au0Do3fviHX5UK8gLa7CIulB7WIpb2Wb94OjnL3TDqpc3br+B5z85I
         bN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718799746; x=1719404546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V41/rcWKltI+WknTyeXP06R8W+cGdmxAwRdLK3VXRV4=;
        b=GBJHFKjEamE1xSZNGnFkKT1qfJxJ6ON7QUvjtyDkxj/iSgU6mUYfCsI6NCthCNAHy/
         +M5vbJmV7jhPUf38xqs4KfXm4TBfmEgZjDV3itJYs9d7e0VyHqh+X0nXC82VQuAyziU9
         crj5DGhAAuJXENHh2XrDQN4B2mfIPOtwC8vVPPbxacluIUHPMgAmGBDnonzPaG/0RGLq
         tmNV4g4F83wGxwYlQBnu0MxABLlZb4tftLF4uqqVIbSh+KXlloOeIpbeQ8au5LWXTdva
         WrGGsifWTJwjkPozLQqqiHFwv0FlHtBNypxxUwBedteX48zpsl9Pf7gPMKkqUDxRCXTK
         hh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXx8LsvrZ6Vt2j8MzeNWdDPr+1Wg0NqXLqe80qbD+XJ6sV5c0cUWpNHah7SGa+j52ZQYjLUVgTth82msprrdIkPhuXE+FFwP1ibqJ5HKZglMMBsqjVKfxVKxR1OUzNs/DY0FyqazNlKrHD24YNhVoJ2b+kKmHlM6bP8QV+cxw8cPGmjuQboIqf4KAU8PsxJFDS3NbhttPkjw2NMUkkPU7bf6w16mwjEEAI2SQS37EwS0gzgOB2WJBPwuo=
X-Gm-Message-State: AOJu0Yzyne+Rnjeebot5tyFV6Jv05fmta0LIoDWcJxNgTFsEPykp4qOI
	z0A+Om+bfhEpV1f1Ag8B3jJgoeR/9Nmggkw4ur/UXQb8zgQL9TYK
X-Google-Smtp-Source: AGHT+IFNxwWmh0mB5nhspfwKH+64F9TJyMuzEuB30lqUIBugcJh/Gng9OTFsOUwuNaX9+aJTaOMbww==
X-Received: by 2002:a62:bd10:0:b0:705:cade:1f40 with SMTP id d2e1a72fcca58-70629c3683emr2114067b3a.11.1718799746080;
        Wed, 19 Jun 2024 05:22:26 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc929321sm10560319b3a.26.2024.06.19.05.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:22:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 015D5182522A8; Wed, 19 Jun 2024 19:22:22 +0700 (WIB)
Date: Wed, 19 Jun 2024 19:22:22 +0700
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
Subject: Re: [PATCH v11 6/7] Documentation: iio: Document high-speed DMABUF
 based API
Message-ID: <ZnLNfq3QvdwlVD1t@archie.me>
References: <20240618100302.72886-1-paul@crapouillou.net>
 <20240618100302.72886-7-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wDBpEk9k3fDiQDP8"
Content-Disposition: inline
In-Reply-To: <20240618100302.72886-7-paul@crapouillou.net>


--wDBpEk9k3fDiQDP8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:03:01PM +0200, Paul Cercueil wrote:
> +As part of this interface, three new IOCTLs have been added. These three
> +IOCTLs have to be performed on the IIO buffer's file descriptor,
> +obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.
"... which can be obtained using ..."

--=20
An old man doll... just what I always wanted! - Clara

--wDBpEk9k3fDiQDP8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZnLNfgAKCRD2uYlJVVFO
o4y6AQDgOsdarQ8+Hpt/RroNmGj88fc5ztC2ucDL+SFkBMD3egEA/jAq/vCNnHLV
PeVNFq70Fcg7IPBxIcAc0QN08ILDOws=
=7nF7
-----END PGP SIGNATURE-----

--wDBpEk9k3fDiQDP8--

