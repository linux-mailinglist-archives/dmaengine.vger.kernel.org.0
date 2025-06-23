Return-Path: <dmaengine+bounces-5606-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E2FAE3D02
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jun 2025 12:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E18E189747C
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jun 2025 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126723B63E;
	Mon, 23 Jun 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOtaOltl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB463209;
	Mon, 23 Jun 2025 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675194; cv=none; b=FoqebciCzD9fOMMv/vjozHGaVlAoUgX4+vVbvCDt+Y0RulXgYUX2etDA9s6+qi5fR1BDgg0JHNhAjLTbBGiF+KLrD0EA0n+55cSod8bGzl4Oss3lmQjaBoVwjDsSKwU+/IQnaBezXYp5ZZ2dvk/Q88PfN1sP0DJ/Iekq2RI7nD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675194; c=relaxed/simple;
	bh=gjIHlc0EFcjZAEwUPY6btZvUfUSNZ+XgJN8YYVR48NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br5E0/P4+vPwjjb67Trl1M9orq8He+UIUUc5yJr+7Tgud8zrP4RclaJB839qvTsjR6Q0xdu4DFUP6/OkQV1gtJIodN8xLCW2Q5OYWu1gAXndeLcBq0nv64yLO4FPjFKnZr9AKjb9DAiH1yPrD3Wrz9vKP2SNzFsSROtEwIjZdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOtaOltl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750675193; x=1782211193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gjIHlc0EFcjZAEwUPY6btZvUfUSNZ+XgJN8YYVR48NM=;
  b=aOtaOltlmLnRkEBp/RJaUasDKYLSHwKiXDju69MfNHv8URXFFJBhPM8P
   CXbqGHosLOGK8rlhUq5mjL7uI1kUG9zsUjCWrM1kvqWiVRHjdftcXBF6S
   cu2nZiEw/pa76mcm6ZUi+G7hc3OdcFbyY7bCgTpdq9NeGw6grWD66vc5R
   ozILrkfwFDFXCr6l1jpOgdORxfB2UgUMMnxsJdsWPc/GB9pO2i7jVtYJ6
   Qz9Bfp/JAqVn745VhE4TN/C3JdHN/91QLog8y1G3lsmadnvOcm27kmrdv
   cJVbo6p2J6FZUMf0Al4LPco+hKiA3qZkdryEPZKOiy0ycWXvOVlXfls9x
   A==;
X-CSE-ConnectionGUID: pFDtCZJnTM++lAhduo551Q==
X-CSE-MsgGUID: btyy1W0eTcmg6T1nWhDzqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="40484321"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="40484321"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 03:39:52 -0700
X-CSE-ConnectionGUID: q5V88mBoSnqqvcjRzighnA==
X-CSE-MsgGUID: IIBEGLduSeqVTBq7okjWDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151746370"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 03:39:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uTeaL-000000098pr-3hfA;
	Mon, 23 Jun 2025 13:39:33 +0300
Date: Mon, 23 Jun 2025 13:39:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nishad Saraf <nishads@amd.com>,
	Lizhi Hou <lizhi.hou@amd.com>, Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Paul Cercueil <paul@crapouillou.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Andy Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Amit Vadhavana <av2082000@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Casey Connolly <casey.connolly@linaro.org>,
	Kees Cook <kees@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Subject: Re: [PATCH v2 1/2] dmaengine: virt-dma: convert tasklet to BH
 workqueue for callback invocation
Message-ID: <aFku5QPf38JKlcPt@smile.fi.intel.com>
References: <20250616124934.141782-1-al.kochet@gmail.com>
 <20250616124934.141782-2-al.kochet@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616124934.141782-2-al.kochet@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 16, 2025 at 12:48:03PM +0000, Alexander Kochetkov wrote:
> Currently DMA callbacks are called from tasklet. However the tasklet is
> marked deprecated and must be replaced by BH workqueue. Tasklet callbacks
> are executed either in the Soft IRQ context or from ksoftirqd thread. BH
> workqueue work items are executed in the BH context. Changing tasklet to
> BH workqueue improved DMA callback latencies.
> 
> The commit changes virt-dma driver and all of its users:
> - tasklet is replaced to work_struct, tasklet callback updated accordingly
> - kill_tasklet() is replaced to cancel_work_sync()
> - added include of linux/interrupt.h where necessary

...

>  drivers/dma/hsu/hsu.c                          |  2 +-
>  drivers/dma/idma64.c                           |  3 ++-

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for the above two.

-- 
With Best Regards,
Andy Shevchenko



