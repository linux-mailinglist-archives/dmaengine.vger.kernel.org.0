Return-Path: <dmaengine+bounces-10729-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIagJKEzEGqqUwYAu9opvQ
	(envelope-from <dmaengine+bounces-10729-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:44:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0093B5B2637
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BB6C3003ED7
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D053356756;
	Fri, 22 May 2026 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQHxNiJn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90F3C9440
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446308; cv=none; b=HhyWNjBUu6TelnrBgV/tM5ciW1d/Oqb619gD01yJhTfgLvCWS9GPInapbG1drr9x9j5JaB8DqbS1HB6Y6FnMHc4gLw3XI9DVcNN6sm3kVqyyCEBSPWs6m+y7SqZ1xi8prhrAkOdXSZP+ltjdB9EkYTrnpa14hdV/5XqGpIYmtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446308; c=relaxed/simple;
	bh=/wJ57xNPnCf8dH8DjzmbGHCzUBmnFHtfYvzgs74xh6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C94u9U38I2di32JIim3K4biIdsQcutbIR2TMQ7yIKkIOYGcloFCent1Rjq1iagySofLbiOeda/9txYM2deA1dz27jMD8YoPfGTfChGSusG05jt5lGM31BTz2n9AU31nEv/KgPtvQ/eFs++9tW5kS58tSQZnrRUDHdOU+FTCl/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQHxNiJn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so17149165e9.2
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779446306; x=1780051106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mLsUocanVpLcdr3xQCUl3kNzYIEe9clsefrb8kWlcvk=;
        b=JQHxNiJnKrHq3OULqFsFgAz2seUp3wkoDGf56P609Lz8zcvIRqceYfvhxA02DLMXYU
         mMwnJptOGIzJxZymhJHIjbWvLCmeuj8n7UIOICLHS1gmmNzKr8p2KhNzX6DVGRlIPlpF
         VSz47h5C310AHM5l0xhftcy5tNUaVEPxRuSyak2yNSeWwErCCIpAyjoV+RbORQCkxRmX
         m3NVnxQYrV1baXShcz2azKhJZtASpm5UrCWmDSnwFuG70S1h9x8Z4yPPgKS4c91gBA64
         MA64GSY7llXVpYA9LFZ9x/2syM5AohGARrIEuPf7aGGumOsihGLkUvpC+Z11FmkpZpfI
         muiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779446306; x=1780051106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLsUocanVpLcdr3xQCUl3kNzYIEe9clsefrb8kWlcvk=;
        b=N2OCI6GuAxlSL822MECsYlHjboWlX1WdVfNZmlFS3qJ/clUyEwXd9Yc7as7SnSrXgN
         okp83z17e4jH7SFICfFDTOedKgE4slTbkgCFbfSinPeUdMOWNvOjMUa+5lxKYPRzNHgB
         HJTsokQADqBOTcfegNuRqyoVEukbq0etbBmA6Cxfuk1xWdOHI3j4jcv8IMWlxbWXKvTJ
         xs+bDWUAKs2tV6ZptX98QZn/Z/gBA5nIlxuYmbpJ7unw292lhIFstsqePSTuxkJABu9z
         4/YH3hRR9T67Ir+EB/qtRIqXmO8B+BIIHk4p+l+LK7eJgaL98Wl0k3z8C7fRPD6XivY1
         v5fg==
X-Forwarded-Encrypted: i=1; AFNElJ+AJqzGPMGNePl8G1csqzskQc1IfUGFydBhEtU1rpzJFuaYbRwFdIXmlMpQrT+dc0VXX0wkjBzVuw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxTBolCyRtyvMLnlxL8Sws//jfybFbWug1OZdxwCI3s+/hFiqX
	oDqSlBoiFJn04i1GaC15ohbRx6zTuj5SxylcacAKyy2jHpLhJZ8u4iFy
X-Gm-Gg: Acq92OEHlqiNrA7AQdRtr8mpPy0oKxhvaJtU6yKkEazG28x8/X1Pim5yHOEIcSnvPPg
	hHOtJ5ta4QuntsZOZt4cuSTfjvTzsZ65l93zk9OlLjoLNLF0ZVPxyIdagS8Hp1DQqbgov1rSD/z
	BrKNQgDn4w91oJerqyrBo4O07DQwNXXPrpjxkXhgo07BtIC6bgtXKOm+G0DjswHmdhfHwSjwdcD
	hCT80x2kOvwZgfLiSHgq5RY0bciW8D91W4WXhIm8OrruyLzs/HgdekaALhIFeHqJY2wZLrGPxMH
	HeJZpbfHtil6NWp5cUjMVPStsDCb9/41G3GDDNI1R9MctlF5EYcpfqun3nzXqPPbsWIWACGeB4X
	t/sDruXldp3f++OqlUP6kp+ynmvuJzKQ5u2t7UiR/BXtC4ewSvJGLTCOaZNuoW88UeJrv/LZ+sY
	TRftrDrc3hgr/3ITzildHOaaTVNkem9Lg4QdvY+DCbodVhdydJIJFmGIRVCEe6IXPYAuhzfnsy7
	yCLtxufzYGcTQ==
X-Received: by 2002:a05:600c:3e0c:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49042489c30mr44798295e9.5.1779446305909;
        Fri, 22 May 2026 03:38:25 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d63f8sm13240135e9.18.2026.05.22.03.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:38:24 -0700 (PDT)
Date: Fri, 22 May 2026 12:38:22 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v6 09/10] dmaengine: tegra: Add Tegra264 support
Message-ID: <ahAyF4i51x5ldppq@orome>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
 <20260331102303.33181-10-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4oagdshx4rnxulqg"
Content-Disposition: inline
In-Reply-To: <20260331102303.33181-10-akhilrajeev@nvidia.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10729-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierryreding@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nxp.com:email]
X-Rspamd-Queue-Id: 0093B5B2637
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--4oagdshx4rnxulqg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 09/10] dmaengine: tegra: Add Tegra264 support
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 03:53:02PM +0530, Akhil R wrote:
> Add compatible and chip data to support GPCDMA in Tegra264, which has
> differences in register layout and address bits compared to previous
> versions.
>=20
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--4oagdshx4rnxulqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoQMh4ACgkQ3SOs138+
s6FfphAAs+xOd5AbT8+y/eH+MoUKuhrW0ACB8ym66bqs+OCu+VVuM9p6LR7+6Mux
2+AFLpjeYRRdRYHjzoAsdnUo0VnC/+IFrrqOdoTD8npmeo2SveLrJx+f+BQJ4McM
aHS06cHVboDMya7H3UWHieyto9IZcEmAQjudHId+FPg6rYs3rjbDI2r71M2PM5Ns
nkjaOnkF9S/zPaUptXfdATyviC3yseTgJ36x6N0zKh9EKs1r+kcwlMchCu3k4M/e
uAOx0TEw1Jr12BwQRevhHWPn7JQAbq6a5aSsP4y6Ubvoe0JZIg28+FMFjLC0OvLp
3RMXYpH/0ovuRq3ruMN2NIdpAVZrAnd6OBCAb6c8bQ875+PrkCuQWNhzkV5GsqCN
XNTZRbHAXRfc6Oh/HkxR0rB/US58pr170vp06VeeKsPvpaZYaLT/a+gpVrhyytnZ
0fHu/2sGTgXGdgDdSK37XFlqgCtOMluSPDPrf+mNyDYWorMNK5zrHDIlbIDsZdyT
z4aCMtFdeZhIQSf0IZse1Yi6Kp4pCJEc6836c2FwSDm4iy1o0sH9g8qnvRC1jgej
3FxbqdYz6rvsT/Ri3MdhfZJC+J7vgpZvO5Fptkc9Y4b0OfeisLlRNxMJdIZqDoq2
BIo1f/fukHUAiDdo79dDfnLb/UViqXKst2JZCqdgOykedZy9E4M=
=Y6T/
-----END PGP SIGNATURE-----

--4oagdshx4rnxulqg--

