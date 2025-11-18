Return-Path: <dmaengine+bounces-7244-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F88C688CF
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 10:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B677367A26
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5587830FC3D;
	Tue, 18 Nov 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/BrZqnn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A957306B3B;
	Tue, 18 Nov 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458177; cv=none; b=qziC6+gmaXGqx6s0SJrTZ0QHdETU/HdwQzlAYXb0F+FJs8TDh6m1F5FNq9UGmdZma3bMsCLYOUQwGN0DMm85QfeIye1nn0uo5HZAZrdGk2ScUgou+5mZ62YKyH3l1ZwCleNWu5kWWe93UiznEvjvCHTdu2uUMC17K7RLXwB6y94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458177; c=relaxed/simple;
	bh=JI46k4HzINZC4+om7WdEPBQibDuHlTjpAlZ47eiSibw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqlnJHZhxlf+XUKcP6vctfBtHdHjp8738KQa68u/05VlIbQ9mqGXornPq0TVlc1fJY64CXL8CtFrKAw2V2n/j7o1fXRE/4msqSocnT7FXb1oifadnEjpQaKy9Y4y196EHuhQ3lzl1IXdYyvREe6Y4wAgrMgNausclu0zwTRgb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/BrZqnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307C4C2BCB6;
	Tue, 18 Nov 2025 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763458176;
	bh=JI46k4HzINZC4+om7WdEPBQibDuHlTjpAlZ47eiSibw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/BrZqnn/X6hTLBU5byeJBie2vFYZoapNlp59XIqmpawiKsy6fanNaEvew7tfOhTv
	 edehwcX2KDNVLGy8qlypL8xKGpaMgeaOoR92I1ZhB/YXgqGOkoQEiVhbOITMYPTO7f
	 +EHmvpncn5ClRl+t2ib+A+vnzWpbbTetWzfb4CiXvRAuC05oCpWmtVOmk/7VDxrBmc
	 t9oxeNQI3ja+QStesls5KxIBlVWWe+qnc7X7vVulBNUiKLX87r+XKZ4Dvpp59sEkMW
	 QD2fyjEgCoh1wyiTycW9KWKkfdw7nCM/huRjkMgniG3DYCizc1ZPkzN1paFmOxuDxA
	 NRt3pDfRV5bbQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vLI1l-000000000dC-1sg1;
	Tue, 18 Nov 2025 10:29:34 +0100
Date: Tue, 18 Nov 2025 10:29:33 +0100
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 01/15] dmaengine: at_hdmac: fix device leak on
 of_dma_xlate()
Message-ID: <aRw8fd_CTcybRevq@hovoldconsulting.com>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-2-johan@kernel.org>
 <aRtWo9CNqMS1EP67@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRtWo9CNqMS1EP67@black.igk.intel.com>

On Mon, Nov 17, 2025 at 06:08:51PM +0100, Andy Shevchenko wrote:
> On Mon, Nov 17, 2025 at 05:12:43PM +0100, Johan Hovold wrote:
> > Make sure to drop the reference taken when looking up the DMA platform
> > device during of_dma_xlate() when releasing channel resources.
> > 
> > Note that commit 3832b78b3ec2 ("dmaengine: at_hdmac: add missing
> > put_device() call in at_dma_xlate()") fixed the leak in a couple of
> > error paths but the reference is still leaking on successful allocation.
> 
> ...
> 
> > -	kfree(chan->private);
> > -	chan->private = NULL;
> > +	atslave = chan->private;
> > +	if (atslave) {
> > +		put_device(atslave->dma_dev);
> > +		kfree(atslave);
> > +		chan->private = NULL;
> > +	}
> 
> It can also be
> 
> 	atslave = chan->private;
> 	if (atslave)
> 		put_device(atslave->dma_dev);
> 	kfree(chan->private);
> 	chan->private = NULL;
> 
> which makes patch shorter.

Perhaps, but it would be less readable.

> In any case I'm wondering if the asynchronous nature of put_device() can
> collide with chan->private = NULL assignment. I think as long as it's not
> used inside ->release() of the device, we are fine.

It's just another reference to the dma device which is not going away
while it's channels are being tore down (or we would have bigger
problems).

Johan

