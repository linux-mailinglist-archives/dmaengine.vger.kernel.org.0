Return-Path: <dmaengine+bounces-10725-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOeTHF0uEGrIUgYAu9opvQ
	(envelope-from <dmaengine+bounces-10725-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:22:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA83B5B1FC8
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E5A630160C5
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8AB245005;
	Fri, 22 May 2026 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOSPfDl2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA623C8C47
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444909; cv=none; b=HbvwEKqA6lbZu8fzExS/ymcEdJr05xbJPsiiC0BaY4HwgKhR8yOA1wxXjIfBNYEIz4TTIiVP9Vf4DYLC+qlTeqyyOw/m5zoa5TdmVF+j+TvCuBO+jYenDOmkoj9n+usBbxzJYd4pwGESPS5XAFXE+UH+oLlXhUyiOVgzfKsXbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444909; c=relaxed/simple;
	bh=/yxmDFswOx0w9wiVEewfyX6IVYQi4wAMBnDeD1IdRwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRAoJMyLGiFAKpMPSPa777ouoFf9bd581VzdX2I/CQvZkAKivXgQgxi+ADm2kzlhJOQLfJZ0hTROSfGPqLaMRfRqXB96h/BbHcGQoi+yzbnjywmsJ2w0FFEPppsv8aJlRRVFERSgi/dCGRd8tLVYfRmpYgD1ivNvSgGChTiL940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOSPfDl2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso53806305e9.1
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779444906; x=1780049706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOAQCrLo3DVebScmr4gEaN7TLeXl7WWHrX8xDm80OJE=;
        b=eOSPfDl21QMVMgB3UaEPPQB/KvE3OGDey6qmYlv3p6eS1qzgwUBzFgzV/5PIMNWKgi
         BYhYeQItrLRI+ebhcv19R8dibcZabnkYKr5xZ56cdlk4vVFf7ELAVMFyCyEspmrqh+tH
         FCL8VDMUTaBc36zHp8VlkrLy1EAd7i9eOrgxNpputPS5tdHlIc/xijIDv6058dEfvBLR
         cQic8ydSWOZD965k001W6QaRRvBm6ZaAmdwEoVVTU1zXYMdgkW3gTfCqjq0m+Of5C4CI
         VQAYL5Jw52ntBS/D8s1iVeTyaHnwLzGXa648C3nyp5Q7SoIIJequLecuPWCQh4RpWIpY
         psRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444906; x=1780049706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOAQCrLo3DVebScmr4gEaN7TLeXl7WWHrX8xDm80OJE=;
        b=bXAtg4bz+8FWu7UoRFxOKgNzsV+OIOvl5M5Npp5G3XfIX5uffm8vBrGHeouLPRIxqa
         xekk4tw9aWhkkUPdzHrRF7aeLPOTucOzFj8IteQenVAnsnzUXvCXW1cjXrkxs0+iXhDO
         AWBYAgStxsca18PlGnTbdMateityS6jDcc3wjzm6+CD/v9Uc6B3Oo4fmnWpTbIG3DYxC
         T9/6Hy2RnYyXByv1QVsdQ35htJBzlYKLvCTadiFWFJfm7Q2tJ3ITtY6XH8oZvP2W1tKL
         LUf5D8C6TKa/3NAaqz+upVPDjTH9xn7i2KSlV/IzrqcswKDDBwwkcwbiPe9lDMOpBnoj
         XmQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BDd1CfuUAee2R9SCxAr4faW3uRKVcymFVFuWpkshe2zUmL8SWyd+rahBo14/Pke7NcvpyBm0Zap8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgro4RlVprIej1RqSs4899etGbogq/NPwmyKhckQXk73GQENT
	f/d/MRXFTKM+Da1gtljQmEhBaTthqtE51eG24mdq17c8n9GipZP1EAoC
X-Gm-Gg: Acq92OEre68dQEyEVFnpaiLywQZol+h0DfpanoB5mBlO/SoWbV+Wn9nLXLPC60wv24J
	9ozRzCr013AT7hRcDX12BkGFLf+TiloO+AWPoiVKpYm0GUEapM1+QEy+JtFfwKyi832XwyHZIq4
	vJhhdrVC6OLAq0RLA8oRr5qjJMl0zzNNz+7gbkc5dRFa9EQif8JWQeArDlNG/nl4A8mlVJR4x70
	7uLROQOrU7mFp4W4UiAwXt6vKwd7TS7NBklgrVJTItZz6PtfNG7ATN1APk+OicdOWjItPuqnIIj
	B44zZn8+yqNqU9oo2QU3ZgJgNeFYYP8Z0GXttsCa9mKhxZ/1j3rW+c3R6d2pxYjhMw5b7lkxhIf
	dw28QPTLWYtt0c/CJ1MvzWcDis5Ta2gLUMP1J8V9dAyhe7APueiIMMiGvYuiMxbloQZw0vu32+g
	lt00wpqfzcaZLKD5w2LpoeMEkcgmgaEv0TOoHN7FY98vvFN/y2asxLfZc/WQVJW7F/b6/cG3Nw+
	K7Lblc8/PGB8Q==
X-Received: by 2002:a05:600c:4510:b0:48f:e230:72fc with SMTP id 5b1f17b1804b1-490428ee268mr34911935e9.33.1779444905920;
        Fri, 22 May 2026 03:15:05 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561f2dfsm29695065e9.12.2026.05.22.03.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:15:02 -0700 (PDT)
Date: Fri, 22 May 2026 12:15:00 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v6 05/10] dmaengine: tegra: Use struct for register
 offsets
Message-ID: <ahAsEhzuLFyhhOBT@orome>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
 <20260331102303.33181-6-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="imzmnmclq2alqm7o"
Content-Disposition: inline
In-Reply-To: <20260331102303.33181-6-akhilrajeev@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-10725-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CA83B5B1FC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--imzmnmclq2alqm7o
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 05/10] dmaengine: tegra: Use struct for register
 offsets
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 03:52:58PM +0530, Akhil R wrote:
[...]
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
[...]
> @@ -181,18 +149,24 @@ struct tegra_dma_chip_data {
>  	unsigned int nr_channels;
>  	unsigned int channel_reg_size;
>  	unsigned int max_dma_count;
> +	const struct tegra_dma_channel_regs *channel_regs;

Odd. I would've thought you'd have to predeclare the structure, but if
this builds fine, I suppose it's okay this way, too:

Acked-by: Thierry Reding <treding@nvidia.com>

--imzmnmclq2alqm7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoQLKQACgkQ3SOs138+
s6Fm9A//TpPiDRyGRX5S+DREIyuLzv0q+Fts53fWV69V2cKAdllYUgvBAaGN6kiu
0x7UYLj+83kly4h8EYq3tFWWbk9CZneS/6dURNSzUlSzo5Cdl/zzXfeXeJriWTHP
mgdbVh3oFdl/l0ITQPFG/dvFoEB30eST3qWCPImXLl3upt2IuHYoGPUuwlZSwOWs
TIKRQp84R096p6Y/axdNeevLjJ3x24AF6OvcdF/Bp0hUhHdBVUN29vQ3BwUVOIeO
RYeT0uF8Ns3TpiQSZbvKROOZZRoJYm4jiEu0dLUPxr7TBOtzNxZrmRYcKFc+uPvq
/gqfMZ6jQM72h0yLBw5SEU09XHh1uTzkbnemIjA8VHYaIBofhSFPxysZDdMNY1nf
YyaMBPtDX+cj7wEjcFAp8r+7X9vYd+eojs5a2j1j6hj2ZGncDVj6ES6p9NoNUKIe
YGBTKKM1J1CDtUa5Ty1IMcpaMjV/o3Xe89mmNAJ85w0S+ga0c5lP0DDR418jRIpP
lJOsuBG1ulxLVB74o6UX3HAKPblhpe9lawyH/Wx9UvwIYvtyH/CmTx05VgJeA/p8
wgVchLEGPT222TJmmH3SAWRswoVc72wxxoAzn4URbRTXATh7lO9yEpKSG7TefOhV
iroH1+Ob5vi8gkoLBKz5uyA4UCCpGxVi2um4oBXXf5nennrswY8=
=Kkfg
-----END PGP SIGNATURE-----

--imzmnmclq2alqm7o--

