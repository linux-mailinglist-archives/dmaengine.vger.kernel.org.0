Return-Path: <dmaengine+bounces-2443-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD853910791
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 16:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5741C209D2
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8631AD4A3;
	Thu, 20 Jun 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEJuulX0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575F11ACE61;
	Thu, 20 Jun 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892540; cv=none; b=szf6/dgYklX1qT6iwD2D4n4WDevFy8OlLm4gew89SCO9DL/NrnTU9oVSWOt7SStO1DsecEtW28YNjZauh3gQFusIO10Sq2hsx4k4X4juS9EBoH14PO33Xa58j7H+70A+6O8bXBwT9kH/YlXcx+bCV97vAKIO2dgBpwwDZJU7mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892540; c=relaxed/simple;
	bh=bkoariQAFK5nzptqulE5lD4Ceq9ZNl7I/5y71MtF05E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRWDFYXVJgofUc/UORUt0WtSPE3OaRk42bo5qtFx2gSjltRT2BY7ni5PumDUE2auzaWk8T4zMaljOnBoc0hMtiY6r5lP9uo2hwq1UtTGU+Vsnbv4ELNhqLCLKFPm2HN7GgkoCEWaylCKNg8lec7ilwbfg/1AC+IBpAmD5k5HwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEJuulX0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70623ec42c2so759508b3a.0;
        Thu, 20 Jun 2024 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718892539; x=1719497339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkoariQAFK5nzptqulE5lD4Ceq9ZNl7I/5y71MtF05E=;
        b=aEJuulX0jjYaqSnZkVAkKwhLoW87T9LVCZe4XV/JMH0kAxX2TQe7CvbbXb0pPFh4Qh
         +Wj3iqMc3vhY0GVy+3DBebyU+P4pbHwBmFzcbPuvJDrHpIZuWfO7zJuMuSr4Dd5eWfla
         zRIvmNivP3W84FN5sTdIkmY6OdKRPiu4pQ5yh/CobGFteOOZXunB1IEh4Bw4vcJeEaVz
         rSidujIA+e54/QNVC0swlr7eVppkYnNpvO9IEY3eVnc6STcg363E9SweA68rfaSviwGI
         gTTZdwo2/ezB8YYQMF3MRXlPdand6UgS8XjJA+6ohfUEnr8bH1QcnwJ5TyHxNGkIgZ/5
         Ufwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718892539; x=1719497339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkoariQAFK5nzptqulE5lD4Ceq9ZNl7I/5y71MtF05E=;
        b=uNbUYik8ey499IUjzk1secF4EmwmYX1Q3Y0P7QpiM2iDy6j/44rfPMBbbKXShvtYt4
         wvj0oyJ7DGfW+MUXBaeSdr6EG/NysS4E7UtdjKmlBAEE50dJG0eOMU4vLTiiRBQS4gMK
         LVa2YE4e38TOOU5pGQQ/wcJQ6G2FsPkgg9jWZ9DUi+R26B5xbiJbH6f5XSOdtIG//IMe
         QPEOfTAiZjsmbNbDcf1q5QAl2SR9zC6U2JgCtyU8d1aGPR3derLzLmvRL8CltoUpP+8n
         goyD6Jm1r6agkiAu24KVQITYdRZHHOP9fUy6enELFSgdb1TaspSim8qPh7TndFpx322L
         ojbg==
X-Forwarded-Encrypted: i=1; AJvYcCVQnPlSh5BOGXeQypkP5KwA5h7T4l5YQtnQcgYh4mqXyJb9ej9AwpbhNwL9/SX7e6n8LgAwKdnoT3KgfChsYOAy+QYkJvBawh2gaGf4dLLsBQPyGH0MWdl1lrFMqxPvRqAlk4HdKc7tiW+o220wdLTZP2iR0a8xBRpx+DZ0uAT/2F2ATpBy1sVRIrGJccoS9zCTtkhsgsZDbQ5pwtDH0JU1Fill0YA51f+TWS+uJ32STFxJ+uFTJlW3mnE=
X-Gm-Message-State: AOJu0Yy8Sscwz/pBGRDjfLZXc2ZYnnUx0VtgNrit0abBjF07uiqyn0nV
	L9ck7xooPLgWezdHTs4A5H2fdw0M0cr1W38v+2cmeBDegD/XCMlW
X-Google-Smtp-Source: AGHT+IEWi/i9vtD/HvCPbZdrn1cy8dwPBWfdCTrVuHryTftlO8XzUts6A/QV130K6XeOnU1kYBckXA==
X-Received: by 2002:a05:6a00:4f06:b0:705:995c:3e30 with SMTP id d2e1a72fcca58-706290abf4fmr7801065b3a.17.1718892538504;
        Thu, 20 Jun 2024 07:08:58 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc987743sm12800997b3a.90.2024.06.20.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:08:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AFD9C1824D9E0; Thu, 20 Jun 2024 21:08:55 +0700 (WIB)
Date: Thu, 20 Jun 2024 21:08:55 +0700
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
Subject: Re: [PATCH v12 6/7] Documentation: iio: Document high-speed DMABUF
 based API
Message-ID: <ZnQ398_ZtYpo-JLS@archie.me>
References: <20240620122726.41232-1-paul@crapouillou.net>
 <20240620122726.41232-7-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OmuTAUrc7S676QKv"
Content-Disposition: inline
In-Reply-To: <20240620122726.41232-7-paul@crapouillou.net>


--OmuTAUrc7S676QKv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 02:27:25PM +0200, Paul Cercueil wrote:
> Document the new DMABUF based API.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--OmuTAUrc7S676QKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZnQ37gAKCRD2uYlJVVFO
o/r8AQCIFAAnhfXKSkVIpjhII/qaXwnWsgfL4cVfExJmpumexgD/Ri4NWMVAfeiY
yXZE6Mz87M0muGonVU4ld7vLcryHOwE=
=A0ev
-----END PGP SIGNATURE-----

--OmuTAUrc7S676QKv--

