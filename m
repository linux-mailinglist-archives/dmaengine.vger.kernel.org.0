Return-Path: <dmaengine+bounces-3063-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7966796932A
	for <lists+dmaengine@lfdr.de>; Tue,  3 Sep 2024 07:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC981F21E2C
	for <lists+dmaengine@lfdr.de>; Tue,  3 Sep 2024 05:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFFF1CCECD;
	Tue,  3 Sep 2024 05:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzHn2DmN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007DA1A4E66;
	Tue,  3 Sep 2024 05:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725340720; cv=none; b=sJGH/CcbdWKz83eFoGx7/TVcQJKv2nO4/iIXKqP1DVMCrxmTF9+Agvi6VMOD6hUK4pKrHl+1wi0KFYaLg2RUnhu5c3GdiK++BtQCSgmk/0sBMMca+yfr3eiYc9edQzAqyn8qgO+CFFDgRZPRRjjQ4nPYb7OR0D3MXZZxTcRbcVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725340720; c=relaxed/simple;
	bh=4bXI3Y8VgVB+Lkxuh2fA0DFR+CCa5qj8nePbkreELfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgJlpyMRirK6bAV1BzPblX6yT9LD04/oQKVNBAt4y616tv5i/2kkQoid+pf0hzawmUkKxAW6hS2Z50w40qAR/t+hVrI2yIOZFzS2G85VXu+xkEupD5jkQitR4pnB3w1x36dCWrt7aP9K2JheBzFj266jA41Z3U0DAy84F943AAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzHn2DmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CF9C4CEC5;
	Tue,  3 Sep 2024 05:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725340719;
	bh=4bXI3Y8VgVB+Lkxuh2fA0DFR+CCa5qj8nePbkreELfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzHn2DmNQ6IBXWBJpx/ch9sp5m81g75P1sV5za2Wvos4a6t41IZjSkMGrrnb6RdZZ
	 BvPUMF1psE5woM+DTarNamh0vgYzJo5usn5p1oN3uHGPVpjKKvXCJXeRXB16l0b0FT
	 iOcBNb7rTEXka1XtaIKvIhukBn+3PAlw3oI9qoiQxffg0/TK/OqiaFU+nJ6IoJOZ3M
	 lYiofQu89Kryk8Xugz9jNPp4JwTXYwCW6IcYRUS0pfpP5f+K+WpXj0ce7MiFQbBRIy
	 89CsReNJH4xZQZUducx2Zm1W4o4YhRZXiRF/O2Ay5GfH5aKvmBieMgwVAIaOh/uypw
	 udiZhsGmZZ1uA==
Date: Tue, 3 Sep 2024 10:48:35 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 0/7] dmaengine:Use devm_clk_get_enabled() helpers
Message-ID: <ZtacKzsoK1UWEE+O@vaman>
References: <20240830094118.15458-1-liaoyuanhong@vivo.com>
 <6829a2e4-f7e0-4f34-8702-e00b005e9e0c@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6829a2e4-f7e0-4f34-8702-e00b005e9e0c@kernel.org>

On 30-08-24, 20:11, Krzysztof Kozlowski wrote:
> On 30/08/2024 11:41, Liao Yuanhong wrote:
> > The devm_clk_get_enabled() helpers:
> >     - call devm_clk_get()
> >     - call clk_prepare_enable() and register what is needed in order to
> >      call clk_disable_unprepare() when needed, as a managed resource.
> > 
> > This simplifies the code and avoids the calls to clk_disable_unprepare().
> > ---
> > v2:remove inappropriate modifications, configure COMPILE_TEST for easy
> > testing, add devm_clk_getprepaed() for imx sdma device.
> > ---
> > 
> 
> Vinod,
> 
> Since ~2 weeks there is tremendous amount of trivial patches coming from
> vivo.com. I identified at least 6 buggy, where the contributor did not
> understand the code. Not sure about intention, but I advise extra
> carefulness
> when dealing with these "trivial" improvements.

Agree, these are introducing bugs as well..

Vivo folks, please channel your energies into fixing some real problems,
contributing support for your vivo phones including DT, drivers and
running mainline on them...

That would be better use of your and our time :-)

BR
-- 
~Vinod

