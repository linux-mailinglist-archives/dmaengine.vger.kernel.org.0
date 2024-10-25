Return-Path: <dmaengine+bounces-3587-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF39B03D0
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 15:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0992823A5
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526B821217A;
	Fri, 25 Oct 2024 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QI3j/BnC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200452F76;
	Fri, 25 Oct 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862384; cv=none; b=iYRDfiwzqQsXaU5jkkKxhz7tGDNhu7bHLD29V6cAb9gWsYCjfXTBXXTIkZ4zWyvypel8wdIAHV5fAi96X9gM0AGc/yGb37AQzR1I2Cv03VHpSiRYHybgbGqtVcrLXbLgmg887mn3YfPTwhdsVcfyermS6pn72cBVXAVH4CcyX2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862384; c=relaxed/simple;
	bh=V1sOFV4W/vYmfHOo/YccbeoVgUSseDX9b1vcA4AQoKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upFX3+12YziKHGC9VS9BwK1FMODYS3Ve2/+uBUR8XupRoSgQ8ibI72SpnBviiupnp3dqmSmFcZtF9w+byXDxNEX8dMOii0S9pglWGq7DvFEaQC7rAPDysM7RPm0oeewXzM1k/JBSfWCc8D4UWZjyiJCEmx2C/Ci8YW2E3uZyxkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QI3j/BnC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729862382; x=1761398382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V1sOFV4W/vYmfHOo/YccbeoVgUSseDX9b1vcA4AQoKM=;
  b=QI3j/BnCYIGI0MU9Q+TJ17TcwbEVYW5m0WvLVTaBueYUkrOBkW6nyP4M
   n+2e7lnp6t797f0K6W8zSkMqPU7WtQQQa9/0mFF5KLVn6F/DPjQbNWxTN
   dnwLLRzgKnpC3NxxWbVXtYss84DzZdLAPhX7WS/qJVs5guaNjp4c1Dr0M
   nUqbY/FJWUP6BQ5w06gX48p/NdBkfmEi2g67T+HK8jVjEhvIeGAkAvnqw
   pPdf7nhl2Of4ekcyFOU8yuQn5Uybw3HjyjJeQTJ1LK1nLnQgdbd14Gro1
   kQgG4jj+ii1abvGuLibXr1oyFJGJ4UmhBd+2HoZMS7XCcU05ZrBDySIhv
   Q==;
X-CSE-ConnectionGUID: OLNuQvDyRlmR41UclrXNrA==
X-CSE-MsgGUID: CgICE2zCQxC4K5iaf8DH9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40145735"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="40145735"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:19:24 -0700
X-CSE-ConnectionGUID: Bl0XnzdTSbukqiK0fd1Znw==
X-CSE-MsgGUID: f6sOCNSFReipYddQD8BK3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80931768"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:19:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4KDd-00000006vFW-1Hxw;
	Fri, 25 Oct 2024 16:19:09 +0300
Date: Fri, 25 Oct 2024 16:19:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Oleksiy Protas <elfy.ua@gmail.com>
Cc: d.milivojevic@gmail.com, ajhalaney@gmail.com, allenbh@gmail.com,
	andrew@lunn.ch, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	broonie@kernel.org, cai.huoqing@linux.dev, dave.jiang@intel.com,
	davem@davemloft.net, dlemoal@kernel.org, dmaengine@vger.kernel.org,
	dushistov@mail.ru, fancer.lancer@gmail.com, geert@linux-m68k.org,
	gregkh@linuxfoundation.org, ink@jurassic.park.msu.ru,
	jdmason@kudzu.us, jiaxun.yang@flygoat.com, keguang.zhang@gmail.com,
	kory.maincent@bootlin.com, krzk@kernel.org, kuba@kernel.org,
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux@armlinux.org.uk,
	linux@roeck-us.net, manivannan.sadhasivam@linaro.org,
	netdev@vger.kernel.org, nikita.shubin@maquefel.me, nikita@trvn.ru,
	ntb@lists.linux.dev, olteanv@gmail.com, pabeni@redhat.com,
	paulburton@kernel.org, robh@kernel.org, s.shtylyov@omp.ru,
	sergio.paracuellos@gmail.com, shc_work@mail.ru,
	siyanteng@loongson.cn, tsbogend@alpha.franken.de, xeb@mail.ru,
	yoshihiro.shimoda.uh@renesas.com
Subject: Re: linux: Goodbye from a Linux community volunteer
Message-ID: <ZxuazYt5GMJWJ8xP@smile.fi.intel.com>
References: <CALtW_ahkg9W0wm09cxkJxiSQCH=42smeK=fqh5cQ9sRSNsjeXA@mail.gmail.com>
 <20241025030102.319485-1-elfy.ua@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025030102.319485-1-elfy.ua@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 06:01:02AM +0300, Oleksiy Protas wrote:
> Brate Dragane,
> 
> I was not aware of the fact that either Raytheon or Boeing are directly supplying the Russian invasion. That would be a concerning development indeed.
> 
> If you possess any information of that being the case, I urge you to contact GUR anonymously at their official whistleblowing email: gur_official@proton.me
> 
> Thank you for your diligence, only together we can stop the war.

Bravo!

P.S. "Don't feed the trolls".

-- 
With Best Regards,
Andy Shevchenko



