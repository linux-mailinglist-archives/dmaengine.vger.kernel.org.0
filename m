Return-Path: <dmaengine+bounces-3754-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8409D4C7F
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2024 13:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49E0B24746
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2024 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFFA1D0F56;
	Thu, 21 Nov 2024 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFNqVrnL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724161CB331;
	Thu, 21 Nov 2024 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190540; cv=none; b=c22k45th28euSY/YI8UZ9vxEFZC3wxGPU3Qgr3Z6uS+k7PwfAk+7sFWWrD+0GJ5SLhmuEUuoE36rSJqDaP1OZL8PolRGPwMMV5ZJB7+EEaqeVJENBi/WUssFISVtZbMT1MyrUZRIkzqQo5hS7VFGHL0U/Cs6A9l5ax/62aLsaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190540; c=relaxed/simple;
	bh=y0Ec7Up5fRAMcaQYvRthElk+doTpQoQsvztHHkEYjNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+dDWUCKHh6FB61HMj9RzUpP7h2VJgLwmPOEXVSYN1+MDtac2Pd+1aUTGbQLgzyZI+DkwBEaYmX6J73R9hm5/qkDdSfJu2VFJM7+gN4Y824YXoEJHBPpdzJ4oYZPenvp2wpEutHSnDE7DKwK4hDE05e9SH7t0b8Uz7y8oKU/Bcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFNqVrnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609EAC4CECC;
	Thu, 21 Nov 2024 12:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732190540;
	bh=y0Ec7Up5fRAMcaQYvRthElk+doTpQoQsvztHHkEYjNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFNqVrnLsrVLum0qFjpzKTHDdMI9/QuVClCFWkvT/Fy6jIdhl7HS6c4tYPAvu1MwF
	 cmZ9n6WjlXsIvautB+2ckgwbwzYATw+reS+nFj7VbLAeQU2D/MKV9CTUIr3JRYLbBH
	 XrtFpwg3ddyy8A9FGQxfvLvVUdJIj9TKZJeffhjTfFBAch0Mt3li70jcJuQHUjp56g
	 dugWhC7Mkfn4TtcgpVPSCXDZJfnC2U8c/MjA52SatSB32BMIRVvcGbirBvdEGCgS7b
	 Dq0uei5qaZVAxv3MmKCKQwZSbHysQ0XVnMMSObXOC4cwdZaZ8PKaTWzMHLlZWB0CGp
	 a+HkHe8ntizIA==
Date: Thu, 21 Nov 2024 12:02:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, quic_msavaliy@quicinc.com,
	quic_vtanuku@quicinc.com
Subject: Re: [PATCH v1 0/1] Add immediate DMA support
Message-ID: <073ae0ed-32bf-4097-850c-832cccda6b58@sirena.org.uk>
References: <20241121115201.2191-1-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8S1pNuwrKQcjGCnD"
Content-Disposition: inline
In-Reply-To: <20241121115201.2191-1-quic_jseerapu@quicinc.com>
X-Cookie: Fortune favors the lucky.


--8S1pNuwrKQcjGCnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 05:22:00PM +0530, Jyothi Kumar Seerapu wrote:
> The DMA TRE(Transfer ring element) buffer contains the DMA
> buffer address. Accessing data from this address can cause
> significant delays in SPI transfers, which can be mitigated to
> some extent by utilizing immediate DMA support.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--8S1pNuwrKQcjGCnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc/IUQACgkQJNaLcl1U
h9DqdAf/YMnZEQeC93n9uvgxN5KbXCZMOWabzwsVIZcBggeh7+ifqfXS5cRGJPFD
F+ioaVQo6LiIXPwQw3RxS7YK+EWMNv8yj5zCFk/cCumH7dhj7v8GanKeLI6ICcLL
qeHK2XYf+IBmA+J0g1GQ2LaucI8a2oIUlmEilsuJJS5nPjrnI2g0HPriZ+NsXkFq
wP4hGjtRIS1N3ThG1rTaAZVJISW6lPAVoObL681KDYMlfG+rST4iVrtiaewguOAT
yjkFhXpt8c5S41bWD4Mh0Smlf7Md41aSy5PRVTWEAeZ5sk7cBgwbFGfsCyXISHPc
JvLLgikUwlb6Dr9akXHHOlQZvrRw4Q==
=eMYP
-----END PGP SIGNATURE-----

--8S1pNuwrKQcjGCnD--

