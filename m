Return-Path: <dmaengine+bounces-7245-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF55C68899
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 10:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B2F582945E
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DF63128A6;
	Tue, 18 Nov 2025 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIii7xuB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76830F922;
	Tue, 18 Nov 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458234; cv=none; b=GDCeAm+rXe8vYMEFXlkyfL4yAPJF1nZcXRNDeC9QlCVBMjoaewz4AY86AFp3Nsljo0fYyrf/7qmlQmdzC/YFvYegQU2L4PWKivh7XoIi8/HPyxgREDARR3DxY7xs7gI2LyTreS1peKKLIDeG3L45dsoWVWb+FPU54ZtJxtihUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458234; c=relaxed/simple;
	bh=CI0PsB0EzCBT/vkFRETcQNlw9KsBGj6g3PpqTbX+BGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otOPG6AruI61JcxYUD+4TgF/tntkUxuGkK6urTOuaQvwEE7rUe8sCQl6tui55BwOBXg+lwmZhYjruTxrqRSIZmwhyHgtJrEvd7V10CVFeZMorMpoJvN3XocUClq5C9vdEDteDRU7OkFRzMVAZXx+7VWHwUq0M5NW1ZbqctIBj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIii7xuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24D4C2BC86;
	Tue, 18 Nov 2025 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763458231;
	bh=CI0PsB0EzCBT/vkFRETcQNlw9KsBGj6g3PpqTbX+BGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIii7xuBjx0KRLn6b9BXUaNFNNqbPNbWYeiBCmj21wnxCemDy8ojhTCITSIUUFpgT
	 JiC1AAsyAm9LNQB7ctPS/J5YEIDYPmQYg17JfU6m+sh7d+EJRk/40nRaon6zRGUhwC
	 j4YTSUCtcW+QzYvAt50rKLqihakl7P5NYJBy70YBOJMha8PiJIchSmGmbklQvTggRX
	 MxqdIQzR/JRb8KOHuNKAX2QSKgVAlzTmlz668TIedye4ZxrtvJBfWpkOLNvPhMSBCd
	 nXG1cfviugI6dsN7AXhkeZjcijKGY0rpp+fJ6GYpYR4qpe+HnAvovqpKP6xOd3hOZR
	 cCXbN9xkJFGdQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vLI2f-000000000e5-2mqI;
	Tue, 18 Nov 2025 10:30:29 +0100
Date: Tue, 18 Nov 2025 10:30:29 +0100
From: Johan Hovold <johan@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 06/15] dmaengine: lpc18xx-dmamux: fix device leak on
 route allocation
Message-ID: <aRw8tWOmXhivruFW@hovoldconsulting.com>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-8-johan@kernel.org>
 <2e38039b-f136-44c6-829c-1d98783bbb1a@mleia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e38039b-f136-44c6-829c-1d98783bbb1a@mleia.com>

Hi Vladimir,

On Mon, Nov 17, 2025 at 09:24:48PM +0200, Vladimir Zapolskiy wrote:
> On 11/17/25 18:12, Johan Hovold wrote:
> > Make sure to drop the reference taken when looking up the DMA mux
> > platform device during route allocation.
> > 
> > Note that holding a reference to a device does not prevent its driver
> > data from going away so there is no point in keeping the reference.
> > 
> > Fixes: e5f4ae84be74 ("dmaengine: add driver for lpc18xx dmamux")
> > Cc: stable@vger.kernel.org	# 4.3
> > Signed-off-by: Johan Hovold <johan@kernel.org>

> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

Thanks for reviewing.

Johan

