Return-Path: <dmaengine+bounces-7243-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B144C687F9
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 10:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 156254EE455
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C3311C1B;
	Tue, 18 Nov 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMppkkQB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9B314A6C;
	Tue, 18 Nov 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457695; cv=none; b=KVVbcdSdtBqYoiyTAR7txXVp9uTyqksiBOOmAxCNFJK5NTN4t9WuRt/hMTuBdRPt5jeKt+NbzOu5STQt7QwIPsj6KraJMcSn6rmTqLoowHd2v7FiRXamri8UXW5tKUQKOU5nEelV22ucNp4fRmFkfY7kxhhxVhKlHelO7tcF7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457695; c=relaxed/simple;
	bh=D77XObG49/C29q6kEN1sq4/lM859w+9aGcCdFRAL+fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0Q1zL41uGpS1KbsJQPkUhLo+lL07o5b24VEkja/pwf6AcyGQqOzJE5tA/lrcCVUgjdS8enSP/LhKcVa5pTY1yU0pyzznsCPFI5h8z5r2eDWy0RzkyYSo4AvT/Ur9Z/nmNtjsGyd/iDT2MSoViaxwUIQ75Bi25X45R1BdGqLc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMppkkQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC0AC2BCB8;
	Tue, 18 Nov 2025 09:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763457694;
	bh=D77XObG49/C29q6kEN1sq4/lM859w+9aGcCdFRAL+fU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMppkkQBWVpfob8eggibe370ADQgTmmQ6uBpJ2tObZy+lDjtueD15SNf5xN6CE+XK
	 YQRvZI3zRc+0f2OvFOREbcuingKBTX3so7W8gUsQaPfgDpclr9c+daT89kwhxGMToG
	 YTzgz+fsWnRYPktn0L2oYoXAWe3w0517hRaX+S9jrx1+LjLNVJ7tquFg1ljJlBsa9v
	 nyvVCN8m+NBrCtsV6OJ768++iGCCzaqrWD2AbdJ62pz1R1I+OWkNih15Zhh4ZwbgiJ
	 EuahNuLzcZMWzNA42kVVykLYq+YoRJlYAkFjrrYCh5uisC2t+RoM+Dy9x4FVPPx3RD
	 1+L1/J+CL/+UQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vLHtz-000000000WH-0SZp;
	Tue, 18 Nov 2025 10:21:31 +0100
Date: Tue, 18 Nov 2025 10:21:31 +0100
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
	stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 04/15] dmaengine: dw: dmamux: fix OF node leak on route
 allocation failure
Message-ID: <aRw6m9HXxxmq3nss@hovoldconsulting.com>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-6-johan@kernel.org>
 <aRtV69UcldVcYiKR@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRtV69UcldVcYiKR@black.igk.intel.com>

On Mon, Nov 17, 2025 at 06:05:47PM +0100, Andy Shevchenko wrote:
> On Mon, Nov 17, 2025 at 05:12:47PM +0100, Johan Hovold wrote:
> > Make sure to drop the reference taken to the DMA master OF node also on
> > late route allocation failures.
> 
> ...
> 
> > +put_dma_spec_np:
> > +	of_node_put(dma_spec->np);
> 
> Can we use __free() instead?

I'm no fan of __free() but here it's a particularly bad fit, so no.

Johan

