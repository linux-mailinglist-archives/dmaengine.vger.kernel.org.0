Return-Path: <dmaengine+bounces-7234-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61250C6581C
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 18:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AB113865DA
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CDF305047;
	Mon, 17 Nov 2025 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsXwphmp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11353043B0;
	Mon, 17 Nov 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399342; cv=none; b=HabFEWJT/K+Sm+tFUOp4HaXQQHORp1g9NNrrOH0MNrdZ4/9cYZv7iP3JPxQV4WjAPV8GdcRyTBUVmO0za0cMm+UQHYL0KtkvLREbcD592EtLhdwiccveY2wQB/O8WVS9JVzkyGU9GKZ2CEvRhznkzRYoxEcRRlEWSj1sk4UQ40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399342; c=relaxed/simple;
	bh=4kMNR9Yeh46Zun2W8PCixF5ybA369cJLVczKGIcU10A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnJpAdLiKd+x/w0wBKSEHgKEyNKua6badIJBvjTSILoBCPzA3ocK50Lx+EYbjOkB81lRuB/JkkgYuownlobdOWZWcIb6I9qm3P56TOxu66/kmd9KWMkj748269GZCqBLZSf58iRcQPn0XzoKu6rdngzYooMJ7duRzYAOgVoARM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsXwphmp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763399339; x=1794935339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4kMNR9Yeh46Zun2W8PCixF5ybA369cJLVczKGIcU10A=;
  b=GsXwphmpPOfiJv9d3Qt8UU4b7srj2ZbOOShW9ZGpEjCf20vRKXirTAFe
   uO+53rlhru22SKv8USKjS1lrqy9+QywcQ2YyZFBKvzIUhJif8CW/joboo
   fTA4/jbWpUUZAj4Mav4iUMEppQR38QCARI7RhPRsujKEZ9q1lXCCH6AKD
   NZtuGthYJTxW7W1PZqKyMzXEZafoUOk+pqccuOzAkAoVAoaxpRXjCXJrL
   7O4BnKvvY7FRCbiZPD/g7nyG30iSZr14XU2k7zG1kktNuJCq31TrKeBUk
   sz6xLvgIK2ONNijAowcGroK6Ya/mHE1weEkg1tCc4tFZ/OZFpdmgTkMd+
   w==;
X-CSE-ConnectionGUID: siQLtZiWRD+GQNMKZfjSaA==
X-CSE-MsgGUID: N9JTJOAaS+SK+yenMLKhKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="52977239"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="52977239"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:08:56 -0800
X-CSE-ConnectionGUID: /9gViLN3QyGGKNXnu6UJTw==
X-CSE-MsgGUID: tQbX9niRQkqCGuR/yAOemQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="213900336"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Nov 2025 09:08:52 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3B51996; Mon, 17 Nov 2025 18:08:51 +0100 (CET)
Date: Mon, 17 Nov 2025 18:08:51 +0100
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 01/15] dmaengine: at_hdmac: fix device leak on
 of_dma_xlate()
Message-ID: <aRtWo9CNqMS1EP67@black.igk.intel.com>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117161258.10679-2-johan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 17, 2025 at 05:12:43PM +0100, Johan Hovold wrote:
> Make sure to drop the reference taken when looking up the DMA platform
> device during of_dma_xlate() when releasing channel resources.
> 
> Note that commit 3832b78b3ec2 ("dmaengine: at_hdmac: add missing
> put_device() call in at_dma_xlate()") fixed the leak in a couple of
> error paths but the reference is still leaking on successful allocation.

...

> -	kfree(chan->private);
> -	chan->private = NULL;
> +	atslave = chan->private;
> +	if (atslave) {
> +		put_device(atslave->dma_dev);
> +		kfree(atslave);
> +		chan->private = NULL;
> +	}

It can also be

	atslave = chan->private;
	if (atslave)
		put_device(atslave->dma_dev);
	kfree(chan->private);
	chan->private = NULL;

which makes patch shorter.

In any case I'm wondering if the asynchronous nature of put_device() can
collide with chan->private = NULL assignment. I think as long as it's not
used inside ->release() of the device, we are fine.

-- 
With Best Regards,
Andy Shevchenko



