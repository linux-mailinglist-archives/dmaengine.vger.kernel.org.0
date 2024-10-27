Return-Path: <dmaengine+bounces-3609-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3724E9B207A
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 21:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DE51C2099D
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D128317DFEB;
	Sun, 27 Oct 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp4LVjva"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7317B433;
	Sun, 27 Oct 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061732; cv=none; b=jnDS3eCUyRn9EKdyjptJah7LZwnLbYZE1Rn3BMuSKi5biPRmn24QaPcrjmn2EtWG1/fj3+Z3KDFjXpzb7Aq7hmkORpCaY3e+ylfZXKMBzxAJGw7fFSs5hrESdVuW4nS0DoVSNOXCN1MDnSQUJEIpr0CxX00VNGB+3XbOqKF6kX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061732; c=relaxed/simple;
	bh=TlirieVOeoCI7ASR7CcbZmiCUaE3lt5vbX64fy8rlco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze1sEwqeUO0Nj87PmCawPFmRXaoHOYJTDGk7Ef+ck9RjrbLf2OkU7vtvv1o3dxguYUqYQ12z6yD1Pb6CmNgZGQVSHLXo7R+UP7JBEdR4ESktjD0SSlAeAil4NSdGKAXbTgYxogS5ZWnZ4p9qn5Pm7yzBLzo6gssxx9rdb3+V51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp4LVjva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878AFC4CEC7;
	Sun, 27 Oct 2024 20:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730061732;
	bh=TlirieVOeoCI7ASR7CcbZmiCUaE3lt5vbX64fy8rlco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yp4LVjvaUZS3b8aTxrtglH2gFy/HjfkX+6t6JlasaRbx/nm/b5n+rY6wfMjl1YR9E
	 Z4zQaQf9/MmBWWRy5iKi3gy0s4alRlVX88ko70636P9+YL4bb4hvgedX2lBaOPLFqx
	 tuxmVG6TPvGLXafUJj3hVKDsCIjHidHEbjX9up7l5ev9PEyYPINYU7T9pl1JR5+wZe
	 +dNDcMWN9UkvgtI4jD3FztgIZ2aIVwZH4yFZIHIXOkM4lUI5ZxcYj20UqyHlbBeBzP
	 B4FDlxKonncinwwKCrPhtqUxq5eBdQfn8Upi8p38+LHEfjswAnH97iD2XLV3gEE78D
	 a3hzmGYzUrwqw==
Date: Sun, 27 Oct 2024 21:42:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Mesih Kilinc <mesihkilinc@gmail.com>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 02/10] dma-engine: sun4i: Add has_reset option to quirk
Message-ID: <nlhsxigg3rbfvua76ekmub4p6df2asps2ihueouuk6zkbn56zl@xdj6jzzt4gfb>
References: <20241027091440.1913863-1-csokas.bence@prolan.hu>
 <20241027091440.1913863-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241027091440.1913863-2-csokas.bence@prolan.hu>

On Sun, Oct 27, 2024 at 10:14:32AM +0100, Cs=C3=B3k=C3=A1s, Bence wrote:
> From: Mesih Kilinc <mesihkilinc@gmail.com>
>=20
> Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
> has this bit but in order to support suniv we need to add it. So add
> support for reset bit.
> =20
>  static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
> @@ -1215,6 +1218,15 @@ static int sun4i_dma_probe(struct platform_device =
*pdev)
>  		return PTR_ERR(priv->clk);
>  	}
> =20
> +	if (priv->cfg->has_reset) {
> +		priv->rst =3D devm_reset_control_get_exclusive(&pdev->dev,
> +							     NULL);
> +		if (IS_ERR(priv->rst)) {
> +			dev_err_probe(&pdev->dev, "Failed to get reset control\n");

syntax is: return dev_err_probe()

Best regards,
Krzysztof


