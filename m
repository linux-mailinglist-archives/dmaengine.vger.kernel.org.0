Return-Path: <dmaengine+bounces-7271-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C15C7609F
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 20:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 501D54E2E14
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 19:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B862D7DC5;
	Thu, 20 Nov 2025 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZ44JE1X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840A2E8B96;
	Thu, 20 Nov 2025 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666112; cv=none; b=kLkehraKWz6TcJe/XNvA5jOGsX7RvKFz+we0UBBjdnToRmlApNXKonvJhoL+m49Cl3eoPCBxxb9oeEWRAAUN1W4srLS2P5E1ddYnGu/D67LZWSwgt377CDG3/56eS3ibF0Si6TiMNj3tD4dKlqiQu/vn+LHGzLGeZN01MnIyxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666112; c=relaxed/simple;
	bh=GpSmpsR9NetbPJhQGjxFutnFsKHftqvhMSFwh84zcwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCLpOqyxeMofa7h4orxvZe7vdJJizuhJKliRXw5H5VUbH+z8Q5S6gJ2h8k4CCrK+6b2ecAWYdbD8qdISldRG9JqUOT6VxB0w97nEWwGR4rx8UeHefStb5dJbxpisVDKnBSbsZPYWXlRd3KEehLuec91Cp56Qvy8ED81g/JHxS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZ44JE1X; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763666110; x=1795202110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GpSmpsR9NetbPJhQGjxFutnFsKHftqvhMSFwh84zcwA=;
  b=HZ44JE1Xh5airIdPVCvxxBjnT6Ix2uvwXbQh6z0l+XQuibRKJV2VFEMS
   QviMX1NeWkfNbjj2sPgjmOxzvDCIm4ZNDDoBARPlhcu3usRJVNytnxMPi
   voCtIobJgzdzUydvK8SPbVOdX/4egAZ6zWBuUfLfYfy8SxKT8V/+/qDn/
   Qz0DVbjBrpSfMdzBqvk/gQlaEOoTOoRVZwx3hPtiTtSpuBPCcmL3NpA+6
   fCftNr/o6Pgqe0saMfhQm3gT4uFlHYgOxT7N6CzPsSVQjuzdS3baP+wZO
   TSjmcEVDddYfg1FvTpTSyV4oaH7+Kf/z3+/CsQwXECPzvkxX6PdPDSG8Z
   A==;
X-CSE-ConnectionGUID: MFAEZHYxRKaFKD0gmO1BJA==
X-CSE-MsgGUID: FZ5AXCa7Qn+byfDwg8M4PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65838708"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65838708"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 11:15:09 -0800
X-CSE-ConnectionGUID: Lj2UXwM4QvSoozpG9EqitA==
X-CSE-MsgGUID: JRP7KrHGShi83szIQwo8rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191308310"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 11:15:04 -0800
Date: Thu, 20 Nov 2025 21:15:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>, Vinod Koul <vkoul@kernel.org>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 00/13] dmaengine: introduce sg_nents_for_dma() and
 convert users
Message-ID: <aR9otpWZkPZrb9ug@smile.fi.intel.com>
References: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 13, 2025 at 04:12:56PM +0100, Andy Shevchenko wrote:
> A handful of the DMAengine drivers use same routine to calculate the number of
> SG entries needed for the given DMA transfer. Provide a common helper for them
> and convert.
> 
> I left the new helper on SG level of API because brief grepping shows potential
> candidates outside of DMA engine, e.g.:
> 
>   drivers/crypto/chelsio/chcr_algo.c:154:  nents += DIV_ROUND_UP(less, entlen);
>   drivers/spi/spi-stm32.c:1495:  /* Count the number of entries needed */

Vinod, what is your plan on the DMAengine patches? (Asking not only about this series)
Please, tell if anything needs to be done from my side to help them being pulled.

-- 
With Best Regards,
Andy Shevchenko



