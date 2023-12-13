Return-Path: <dmaengine+bounces-517-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB5811C91
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 19:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A606B21255
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EC45DF05;
	Wed, 13 Dec 2023 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUG6SRQd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C1181;
	Wed, 13 Dec 2023 10:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702492246; x=1734028246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6mjYUiiWTKU+zQiM8bgxUs35x1rWNcFswLWdtn0ALYc=;
  b=eUG6SRQdn5X8kzpmImO21Ma9G1Klzb6ftQkQx03SYHf9nwbjFGko2ULA
   pSYyiNPtZoMpVECnRGuTBDakExojL3NbwXHEpF3weByxM63Gh4qUgR1+5
   IXKRspijowgQik2AWYp13joScbOBZ3wtmdnNKNTFLN0102yXeTv4cKXIy
   7UOqLgtGe2rI867rs5ZwmS32vdWUDUYFoLLUuIdQvq7yjPFIcBf7iZmvv
   +5egqyGp6fjx+Lal/O6P9adZ3EFaZlSkK8BnopS4i7eO5UGdzeTvSSuhu
   nH6qF80Yv2NfYKCQQNvBcGZ5oSgk1fZ7e2nxA7x6G4Mco0PdZvOjZU+cg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1844802"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1844802"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:30:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750222872"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="750222872"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:30:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rDU0H-00000005bnG-04KO;
	Wed, 13 Dec 2023 20:30:41 +0200
Date: Wed, 13 Dec 2023 20:30:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 40/40] dma: cirrus: remove platform code
Message-ID: <ZXn4UIkoJeHnAAGW@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-40-c307b8ac9aa8@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-40-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 12, 2023 at 11:20:57AM +0300, Nikita Shubin wrote:
> Remove DMA platform header, from now on we use device tree for dma

DMA

> clients.

...

> +static inline bool ep93xx_dma_chan_is_m2p(struct dma_chan *chan)
> +{
> +	if (device_is_compatible(chan->device->dev, "cirrus,ep9301-dma-m2p"))
> +		return true;
> +
> +	return !strcmp(dev_name(chan->device->dev), "ep93xx-dma-m2p");
> +}

Hmm... Isn't the same as new helper in a header in another patch?

-- 
With Best Regards,
Andy Shevchenko



