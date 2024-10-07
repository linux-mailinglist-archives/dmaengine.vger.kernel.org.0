Return-Path: <dmaengine+bounces-3280-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A213F992D38
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB2DB254BD
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9161D3596;
	Mon,  7 Oct 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQrNT71g"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40F1D3560;
	Mon,  7 Oct 2024 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307666; cv=none; b=syEA9jBTa8MIRf5AjTOQlPY50cyRsg8kCNcQ68wex0nhsqK7MIVMOP0zG2P40MQTpJXjx2iQECfFyOrVEv+9TdUlYNOqfW2EojUrn9YlZYjVou3xJsn+sPDHgFnjVEZ2iJLALELrfJ3Nr0+jeyXEL8cwD1aKhL2zByHZjRFUrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307666; c=relaxed/simple;
	bh=6li13mG7rvgAP9Nm8d61xioTFUbu8TpWPproLOenVpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT9IeIG3uuaVvAjAEkelwcyhKzBprxAFoClWUc8WVDqndpbEL9cTO/4mfJ3LTp1SwY6hVdIwP107lNr6ZQLEEyt5ntQG+na21haNs53zvhseHKEef2XhJZTjLRCn71a46rqij4fUVjokWiZAM/tTBWxblVz2a4JlE/rPPipgmA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQrNT71g; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728307665; x=1759843665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6li13mG7rvgAP9Nm8d61xioTFUbu8TpWPproLOenVpQ=;
  b=IQrNT71gBmCodS/yML8DpiPh9gTU5ETCy9Phkg7HaXVFHUBmB+tm0Xp7
   XkqAkSKp0ZqCFJlIlhO4ciMxtmOL/VBVIvJ3iy9rITl7xLgzpGM3FRB5C
   K5onCE1JfShcsrX076iCyEeUcHrG3Sd9cfq2MQGA7m03oifuL0fQZ0LLP
   bYHnL8eQDq7r9T/2KjD31k107uhAWj8ML0Wuu6Q5AK1yAP/Amnx51p72X
   dm0MA7S1/6UaxTYP7gzpdwtiXDTYKpYzdGgQdIoT3MnEysOw4RI6HYYnY
   kHt0fE40WkfbVKVu+USAR/VLkN00jWK4/94Yp5L/XgQFvN2lBgmeiVf5Z
   Q==;
X-CSE-ConnectionGUID: PAc4Uiw0QmCQbq/HP/vaHw==
X-CSE-MsgGUID: 0S89wkcyRuSsnDjEQMRDRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38026165"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38026165"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:27:45 -0700
X-CSE-ConnectionGUID: pMedMtvZRmWZNfZaZIrn1w==
X-CSE-MsgGUID: 7uZTz8MzTiGXCJfhzfLKHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80272278"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:27:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sxnm0-00000000Djt-0L9V;
	Mon, 07 Oct 2024 16:27:40 +0300
Date: Mon, 7 Oct 2024 16:27:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ferry Toth <fntoth@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] dmaengine: dw: Select only supported masters for
 ACPI devices
Message-ID: <ZwPhy9ZRBILy3S1l@smile.fi.intel.com>
References: <20240920155820.3340081-1-andriy.shevchenko@linux.intel.com>
 <d6ebb78b-a369-4958-9ce1-8d0647d3410a@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6ebb78b-a369-4958-9ce1-8d0647d3410a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 24, 2024 at 09:07:19PM +0200, Ferry Toth wrote:
> Op 20-09-2024 om 17:56 schreef Andy Shevchenko:
> > From: Serge Semin <fancer.lancer@gmail.com>
> > 
> > The recently submitted fix-commit revealed a problem in the iDMA 32-bit
> > platform code. Even though the controller supported only a single master
> > the dw_dma_acpi_filter() method hard-coded two master interfaces with IDs
> > 0 and 1. As a result the sanity check implemented in the commit
> > b336268dde75 ("dmaengine: dw: Add peripheral bus width verification")
> > got incorrect interface data width and thus prevented the client drivers
> > from configuring the DMA-channel with the EINVAL error returned. E.g.,
> > the next error was printed for the PXA2xx SPI controller driver trying
> > to configure the requested channels:
> > 
> > > [  164.525604] pxa2xx_spi_pci 0000:00:07.1: DMA slave config failed
> > > [  164.536105] pxa2xx_spi_pci 0000:00:07.1: failed to get DMA TX descriptor
> > > [  164.543213] spidev spi-SPT0001:00: SPI transfer failed: -16
> > 
> > The problem would have been spotted much earlier if the iDMA 32-bit
> > controller supported more than one master interfaces. But since it
> > supports just a single master and the iDMA 32-bit specific code just
> > ignores the master IDs in the CTLLO preparation method, the issue has
> > been gone unnoticed so far.
> > 
> > Fix the problem by specifying the default master ID for both memory
> > and peripheral devices in the driver data. Thus the issue noticed for
> > the iDMA 32-bit controllers will be eliminated and the ACPI-probed
> > DW DMA controllers will be configured with the correct master ID by
> > default.

...

> Tested-by: Ferry Toth <fntoth@gmail.com> (Intel Edison-Arduino)

Thanks for testing!
Vinod, can this be queued for v6.12-rc3?

-- 
With Best Regards,
Andy Shevchenko



