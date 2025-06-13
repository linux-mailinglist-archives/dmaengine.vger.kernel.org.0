Return-Path: <dmaengine+bounces-5454-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7378AD92DC
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 18:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6622F1E326C
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620C42E11DD;
	Fri, 13 Jun 2025 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1rWZEPS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109A2E11B5;
	Fri, 13 Jun 2025 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832458; cv=none; b=ggZPSIaNfcix16oOFfej5Tk/16ohnjp8qOGbk4YnzkuYWh1Y9u1Gn9eSS+sdb2Nd2sS4gKxYK5k5VjwR1XvlWG1yMOf/yI+shq2V+MVS4Le8QUQxRN6jLpvTXazZQXm1zZ8tAT5l/+nOmpX262eDCRF0nrIdb8lBCxzMdIh105Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832458; c=relaxed/simple;
	bh=XmQATzAYaYnvtUMi+XnSnSqsLk5YyHQDgNS0PcyR0VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvSaIwoPWa1stderyx1a5nLSjm28Iw6AZFjx4z+H5ueRzrs2fpWQGuOTnpns3A6PAoa2O0qipFwWLq3/jahZY5K07paOPXBrRN4/5MKKyXzSQkZLFrQv4x74TbcyBfHL6Pq5PXMxrLa/YBEi3hyQakgbajRZSss4WzlhH8P1WvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1rWZEPS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749832456; x=1781368456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XmQATzAYaYnvtUMi+XnSnSqsLk5YyHQDgNS0PcyR0VE=;
  b=Z1rWZEPSUjOXaFCHVCOE90SJp7n5KAViY9SXv4Rn6GT/CSpgFYh87fkV
   TyWMVtpgWGrxtQ3cQkpVpGFE4d1+hl01loLoFFD73IdT4mAHu+dxp2LUw
   6FaKJF1I5V7AWCGZnlqSPQ9cdn/GOqUOYJvkcbIeupp6DAILTiDoZ8CAO
   UOAPXcsLpi7yzhLvRzBnffQywRUQ2ExGY9c6YY+g6C79MREs92for1D8M
   LSYe8fwhnjklnEVhQO0onvbigw2SZlNN/AkCLZ25f5/Q8AeMopYU6cKPd
   MqMCcTm3VuEqRvz+TgWdUq7jr2enc77pkfLFekejVm/WFqEhVCZvN2xkW
   w==;
X-CSE-ConnectionGUID: D0ju2UKdSnm7TG/08lmd4A==
X-CSE-MsgGUID: S5FtnycxSd+xcp47mSMkBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="54672617"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="54672617"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 09:34:15 -0700
X-CSE-ConnectionGUID: xTT/NwgZQVyWy81RA0eR+g==
X-CSE-MsgGUID: EOizAm/wT4OMCyvmQSPCSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="153160363"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 09:34:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uQ7Lp-00000006IeZ-3Wol;
	Fri, 13 Jun 2025 19:33:57 +0300
Date: Fri, 13 Jun 2025 19:33:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Subject: Re: [PATCH 1/1] dmaengine: virt-dma: convert tasklet to BH workqueue
 for callback invocation
Message-ID: <aExS9WB0Ussl4Lec@smile.fi.intel.com>
References: <20250613143605.5748-1-al.kochet@gmail.com>
 <20250613143605.5748-2-al.kochet@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613143605.5748-2-al.kochet@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 13, 2025 at 02:34:44PM +0000, Alexander Kochetkov wrote:
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
> 
> Tested on Pine64 (Allwinner A64 ARMv8) with sun6i-dma driver. All other
> drivers are changed similarly and tested for compilation.

...

> --- a/drivers/dma/amd/qdma/qdma.c
> +++ b/drivers/dma/amd/qdma/qdma.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/amd_qdma.h>
>  #include <linux/regmap.h>
> +#include <linux/interrupt.h>

It seems it was ordered. Please, preserve the order.
It not, try to squeeze to have longest possible ordered chain
(it can be interleaved with something unordered, just look at
 the big picture).

(Same applies to other similar cases)

...

What about the driver(s) that use threaded IRQ instead?
Do you plan to convert them as well?

I am talking about current users of virt-dma that do not use tasklets.

-- 
With Best Regards,
Andy Shevchenko



