Return-Path: <dmaengine+bounces-3204-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D3B97E874
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 11:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583891C211DD
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048B194C6E;
	Mon, 23 Sep 2024 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Y2ptN+Jk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9661946B9;
	Mon, 23 Sep 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083206; cv=none; b=GF75a7FYJWovwAx9+MmId+p7XkfHJG0ze4a1ZFg+HOTWpLWHCjWEQVhR/fuS1d7McFUWUTTARwws0ZrL9mQDwn9d8iY5Rw581vwmEbWwjGihWmobPas9XVQlEBb6TPacvYcZ8aXu3qzVnrLXtlmi7AEQLG5b2llG6/dOl8thwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083206; c=relaxed/simple;
	bh=Jwe2rfxMroRh47QxbHBmU9rQiX81nZ12xNBj0ZV9nyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ciw2rd5g4lB5SicXcMIUxHX93kR8EhVTqPZVXtgTStRRA29wEd7loQh4RryDQoPGuqg+W7vwWLCxxjieY3NR3XCk3HkS4sS2Z0bC8oDB2Sx0wnFfhf2G7LDpRX/HJoJsOZCEfD33JVHK1AIxNL2NU8ZcVxvkmpmunJRoHY18pAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Y2ptN+Jk; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 2BD631FC52;
	Mon, 23 Sep 2024 11:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727082855;
	bh=At81ypCxxPBo+FE40G+JP3sqUBPMoZlfXvpciUyJ4DE=; h=From:To:Subject;
	b=Y2ptN+JkZ22J3kjH82uFPUbId73FVYPoCg93XYNoE76ztZ7sk4+FQUV14mPXwtwZo
	 DF9vVnVbzCLLMmE250JMKEZuHJwdDzYR43GzBkL4HfglfdbFWvETicGIYy/We7uD6x
	 Rl1w5jyL+w96AFZanbbo6jbR0Do1/XWXmeOgLiAG3tAsKzDC5yei3z3MGIVXQHlySh
	 6mkqIvP+QeOmh5G4IrBd1gXMHVjyP94og0b9IMIG0ldsiq8vsVWMlPiIdJItTVbTeI
	 mYSHG3ktaY6UlASzMT1/ydMJRrlv0XcucNujHQq9UvqIzgNbGl32SB4VfzkP60rBVw
	 LnBXNo55cI9pA==
Date: Mon, 23 Sep 2024 11:14:10 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jai Luthra <jai.luthra@linux.dev>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Rishikesh Donadkar <r-donadkar@ti.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix teardown for cyclic PDMA
 transfers
Message-ID: <20240923091410.GA120879@francesco-nb>
References: <20240918-z_cnt-v1-1-2c58fbfb07d6@linux.dev>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918-z_cnt-v1-1-2c58fbfb07d6@linux.dev>

Hello Jai,

On Wed, Sep 18, 2024 at 06:46:55PM +0530, Jai Luthra wrote:
> From: Jai Luthra <j-luthra@ti.com>
> 
> When receiving data in cyclic mode from PDMA peripherals, where reload
> count is set to infinite, any TR in the set can potentially be the last
> one of the overall transfer. In such cases, the EOP flag needs to be set
> in each TR and PDMA's Static TR "Z" parameter should be set, matching
> the size of the TR.
> 
> This is required for the teardown to function properly and cleanup the
> internal state memory. This only affects platforms using BCDMA and not
> those using UDMA-P, which could set EOP flag in the teardown TR
> automatically.
> 
> Similarly when transmitting data in cyclic mode to PDMA peripherals, the
> EOP flag needs to be set to get the teardown completion signal
> correctly.
> 
> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Signed-off-by: Jai Luthra <jai.luthra@linux.dev>

Thanks for this, really appreciated!

I did test this patch on top of v6.11, before I had errors every
time I was doing some recording, (e.g. `arecord -D hw:0,0 -c 2 -f S16_LE
-r 44100 -t wav -d 16 /tmp/a.wav`)

[   63.906602] ti-udma 485c0100.dma-controller: chan2 teardown timeout!
[   64.090472] davinci-mcasp 2b00000.audio-controller: Receive buffer overflow
[   65.409909] ti-udma 485c0100.dma-controller: chan2 teardown timeout!

In addition to that I used to have system crashes afterward, but today
it seems that this is not happening with v6.11.

I think that this should go explicitly to stable, so I would add
Cc:stable in your v2 (that I assume you need to send to address some
review comment from Péter).

With all of that said

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com # Toradex Verdin AM62

Francesco


