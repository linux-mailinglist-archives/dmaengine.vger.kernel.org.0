Return-Path: <dmaengine+bounces-7345-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D1BC87F45
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 04:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F833AD751
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D440330DEAB;
	Wed, 26 Nov 2025 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaD6ScxF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B03C30DD3F
	for <dmaengine@vger.kernel.org>; Wed, 26 Nov 2025 03:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127681; cv=none; b=EtJGMmAjwqgPIZag5XUlpmq/S0smDA2R6lPRRKkGv3OFqMevT9CgneDGMqmMmqk1maFOoayFcW/QrZex6cOvcIROOjt4pKRPVf7zcQkDSdaCACMoMPj5zkfCndgjiS3p69EFUN4okmY+VpqItG7FXMqMjAnCwQBa0fAU4u3z2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127681; c=relaxed/simple;
	bh=8qfzksOJbbTsCAArgtKRpDmbL7H3emUXbpVOCg00fyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y52LqWaUxlX5HSDngkukU44bM1daX76jaeozlA9jMJDloE5yRc9XtrkL37bQzPdMxgkkgESJS3mO22LDmbruVJikRJzLw9YzWG32Td1zE5LRaEsp4IxFUUrdZYzMyv+YiklN5fi67SBT2sZBTHJZhWGGC9QGAzxmzdseM5CpRlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaD6ScxF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso9692269b3a.2
        for <dmaengine@vger.kernel.org>; Tue, 25 Nov 2025 19:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764127679; x=1764732479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=51lFxwZazAf8fla+gakTIRMJxAjLqhU3wJI76M1NFic=;
        b=VaD6ScxFrp8LqX177cp8V4uvnkz28jm9DTx60wfOLF+6DBTfKAjV1ry5Tiv1X/Ap6v
         797K+rURgSnvAO5ah1Qgnl8zihueUy5HHs5HTRYtEGzFS2zMEYf927le/Wx4Eq2Qp26J
         nQMmVJFLEIX2YwIkgWFas1rmEwfwW+44WXba3hfWt/svnEzDSV9OVEyAcN/ktP3n3zN/
         Usy/hNF4uUEm+ehzE1T31XcoEHNADBJlDs0QtfG+vEajflcLF0CCi0VpeNtlr9Y9FsQR
         il0M4mdviputUnW/qBdBgSNV1NAz60Dz0dXDFtHe2wk8NH7tlcwpk9HpHcUT90djkIp8
         5N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764127679; x=1764732479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51lFxwZazAf8fla+gakTIRMJxAjLqhU3wJI76M1NFic=;
        b=w9sUGovCa8IJwbWadgw6Rl4d2eDA15rBLt3xVBJIQSVifexWCTPhbzQDTmMefY7rlP
         sQ3oeBEaNwc0Nq5t9580V10pO352h7ils1yUC9Nb5xS7MoKB1C1fJC/9i7CELlq2LZ6B
         bMxCmFE2NCwSu2fIDRTDbcP0io0RXkfi2FFMyNpb4OOK6WMn+oxJQl3N9rfkqgNGWnk0
         5CAlbsHn7SKL3StSBIsNIOff8bETlTcie+P+tv87OPqlw6BkHsOnpucpSPH1Yr/0/1py
         S3mVpnfEALd71enCtuYQZSqurWm/545hQrLfEUv3VpblSSBGOc58eaJLsQfh7OHT+M3R
         t2bA==
X-Gm-Message-State: AOJu0Yxv8UuazOZ67R3iOcwm4OQFFduxRp24r1LFdyNDruX020I2u6jr
	0hV0/kX7JonFM0EzYNlC3p0NmtuOT6uuKqtzAHkWRg7PvNyiR1cYGgYQ
X-Gm-Gg: ASbGncuqxiCVSiiggAgDWp/8QuuP7JL/mmnMF1y/5oPKCi+TRTGbwh6OhH0I1DcY81z
	ahAFIfL2mJXtCeI2xOLWj+iALV4N7p9XD0Is1J8GasNPcLkuhdoCSFBAEoC6X8Wm2eLOAoC7UMe
	Pe3uedQrnVuI/daflk9FyWVXMM5eN7Wek17r8qziNuSqOHLWguRNXIHBIRp7M6x9rMF7Y4OcAnF
	ATPkGMM/ZO8YZeRjYbAfqh2d0HabUoOyO2Oyy/b5uQEwXhSdJ864xbVbkv6phVeX5yKs7PBQRGZ
	hqbCYp3AS1EWY0usUobz7+6CQ04wHRjLLBmGDkfMTlDtaunPOu364mXpTDvf1Wb+OBtiYXAZ5Lt
	1DQdXUMXRb+o26c2ADJqnl3Wv394d2cPlIdZQl8z277LYPvZOTMpvnTO0qom2IVBP9v1VXwnZ4t
	eqfDRmg9BkDZw=
X-Google-Smtp-Source: AGHT+IG9xHzrSQWvZCXHCGOpqvWXyFnbV+8dBSEJrT3vhP/mRsbjw5OciOtuksf2l1kJH+WCP8MtWw==
X-Received: by 2002:a05:6a20:3c8d:b0:35f:84c7:4031 with SMTP id adf61e73a8af0-3637e0d3593mr5748425637.55.1764127679511;
        Tue, 25 Nov 2025 19:27:59 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed471060sm19640415b3a.15.2025.11.25.19.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:27:58 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id CBEA845A3F83; Wed, 26 Nov 2025 10:27:56 +0700 (WIB)
Date: Wed, 26 Nov 2025 10:27:56 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Subject: Re: [PATCH] docs: dmaengine: add explanation for phys field in
 dma_async_tx_descriptor structure
Message-ID: <aSZzvJ4zhEm5jCYd@archie.me>
References: <20251113064937.8735-1-bhanuseshukumar@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U9VBp7oVmCj/Mqtc"
Content-Disposition: inline
In-Reply-To: <20251113064937.8735-1-bhanuseshukumar@gmail.com>


--U9VBp7oVmCj/Mqtc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:19:37PM +0530, Bhanu Seshu Kumar Valluri wrote:
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentat=
ion/driver-api/dmaengine/provider.rst
> index 1594598b3..f4ed98f70 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -411,7 +411,7 @@ supported.
>    - This structure can be initialized using the function
>      ``dma_async_tx_descriptor_init``.
> =20
> -  - You'll also need to set two fields in this structure:
> +  - You'll also need to set following fields in this structure:
> =20
>      - flags:
>        TODO: Can it be modified by the driver itself, or
> @@ -421,6 +421,9 @@ supported.
>        that is supposed to push the current transaction descriptor to a
>        pending queue, waiting for issue_pending to be called.
> =20
> +    - phys: Physical address of the descriptor which is used later by
> +      the dma engine to read the descriptor and initiate transfer.
> +
>    - In this structure the function pointer callback_result can be
>      initialized in order for the submitter to be notified that a
>      transaction has completed. In the earlier code the function pointer

The wording LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--U9VBp7oVmCj/Mqtc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaSZztQAKCRD2uYlJVVFO
o3iXAP9hXC3MnhskzYfaAyFleh+Po17o9hELn1Mf7RwHDBrknQD+LKtDpNOsLJVe
M+AIvBjSO5AFnmkh3L8D5e+INwmlcQA=
=XV4N
-----END PGP SIGNATURE-----

--U9VBp7oVmCj/Mqtc--

