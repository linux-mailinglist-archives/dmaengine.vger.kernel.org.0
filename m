Return-Path: <dmaengine+bounces-3610-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BDE9B2082
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 21:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F376FB20EB4
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 20:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C76117D354;
	Sun, 27 Oct 2024 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ7XnWoF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099C558BB;
	Sun, 27 Oct 2024 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061800; cv=none; b=kp71PKGVSSZgysUHdWu2VmlCF+HXD3W9ENWSkOiCXde/dla80Avq9ZHAZlek5Bh9ehplliHfsPHYnwxhIymdWcSXGUzoLiY+uOLMy48HgU3M0hWEeiUo8ilr+9zHLlMANJOtS001dMhDMb0PEaPff1CTryRovw/19+FdEpCBjTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061800; c=relaxed/simple;
	bh=qvujWRAqdpKJn304U7F5jeDAVb+FedOCfe/qiEKOYTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUhRFVXn34+fWxU7aZfhflwq8fzOJ4vnuGEXZwQ74okjU7vUo/t6WvXdu6v1PAdt8kEDspleLAK29JCLKPy1R8ogoC40OX2f8j3wY4xMF4R1We97La5N1BBvsKZmKBKyvTmodQqtX+a4q3ca4ekPb+LdKkkfA2YhNfuqkvqzUp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ7XnWoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DB9C4CEC3;
	Sun, 27 Oct 2024 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730061800;
	bh=qvujWRAqdpKJn304U7F5jeDAVb+FedOCfe/qiEKOYTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQ7XnWoFLsKwXIdsVWpeNEua6b7zNYi8q+Ferq/6ckQ7pnWD/E0KLmXwzGWVihUwU
	 JKlSjOC32M/g8Kwqgi5Mm+v7OoyfIadYdlLzs6d8if8xXvwjTl+bub2X0aKr9m0jSF
	 Uj9dG0Z20+lpisHeSTLqiE/e9iCqTHc45uYkhgDBUig+oQU4lIPAHnb2FfdjEITbcw
	 dFpm8Azg35ZUO+M0FH2MOaEfT/toHBXEWTE5cBh9UpT8MnHacQAH/RUf4L45kZL2fi
	 HNYuS7FGibaqWP7KJcorc+NKsAd9WqMWF8ooZIO5e6Xmo1jGb2hMlmw6HMWHClV1RS
	 ho/a9qwQmMjWQ==
Date: Sun, 27 Oct 2024 21:43:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Mesih Kilinc <mesihkilinc@gmail.com>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3 02/10] dma-engine: sun4i: Add has_reset option to quirk
Message-ID: <dsuadjqzybikpnuyr7q2fbq5jdzev33rqqhnehh3ns2lgfvdlb@bdmib46vlxt3>
References: <4b614d6c-6b46-438a-b5c3-de1e69f0feb8@prolan.hu>
 <20241027180903.2035820-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241027180903.2035820-2-csokas.bence@prolan.hu>

On Sun, Oct 27, 2024 at 07:08:55PM +0100, Cs=C3=B3k=C3=A1s, Bence wrote:
> From: Mesih Kilinc <mesihkilinc@gmail.com>
>=20
> Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
> has this bit but in order to support suniv we need to add it. So add
> support for reset bit.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> [ csokas.bence: Rebased and addressed comments ]
> Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>
> ---
>=20
> Notes:
>     Changes in v2:
>     * Call reset_control_deassert() unconditionally, as it supports optio=
nal resets
>     * Use dev_err_probe()
>     * Whitespace
>     Changes in v3:
>     * More dev_err_probe()

You did not build v2. Then you send v3... which you also did not build.

Please start at least compiling your own code. Then start testing it,
but without building it cannot obviously be even tested.

Best regards,
Krzysztof


