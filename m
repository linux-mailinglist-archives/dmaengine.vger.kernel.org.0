Return-Path: <dmaengine+bounces-3477-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0369C9AEAD4
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 17:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32691F228E4
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0DF1F80B9;
	Thu, 24 Oct 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wd5zRaYW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989121F6671;
	Thu, 24 Oct 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784492; cv=none; b=lmmmVT2Bdvlz+fF66tQUHFYHVRNShigG8bAesV34XEKjtNj99VhCATyfszWbkJb8aRpU1FZHdIgZaOkOfQYjfsWB60teRGGFYhT6LJ8E45vzU8VROzN+EzMkJJ4PYj4IEMUMYT2lvVi+SV52mAsaP6g5PydSnWBpfFyYDOdMPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784492; c=relaxed/simple;
	bh=pldgdaG5MLkDB2a4oyN8yKvYJku+F7JY2MI4zp+PqSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPNH0HcHnVqQMNWgWsjCjvpUGtNdye5tEvEs65TxwUm74p74+QmFMggAtvIoXEDbNbdq2iv74XUphQg+hj8s9zx49pDC8m1k/GDTjk/K7Ssmdh5llQXACERgrZgB04gGH1PudadyNfarcnqkT9BAS48+/u3LQaaygmPo+znWG4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wd5zRaYW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729784490; x=1761320490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pldgdaG5MLkDB2a4oyN8yKvYJku+F7JY2MI4zp+PqSM=;
  b=Wd5zRaYWmcxtOCmcFnJMNq/qKFvtFmXSsCCDsKUBduOI6YYM5tk9oKoD
   QSUZwTDM1hthZCEkKlS2YChOZN1ZKAk2sprB8CgLt94decMgRyO8vu0De
   PeOIiZ5Yz6wAC4om78LJBg+ZiVgV/2KK0RLRPJvK0GyAHJnfo9EMyG3Kx
   5h6Re+7lVCYfNK161+0W5VrMxm68427/IwGlv52sPO5GFNRtl/MtpEvVv
   xCEVbzquBVmfM6S3vpjqMh2z80z/ezwMLdd6BceT98fwz5ZNqqNUc7dVG
   0cxQq7fuMwXuIwkSrSs+ftMKa3ilzixasHgM/AUa5wAfQrlHHKlvKQDw7
   g==;
X-CSE-ConnectionGUID: tOouvPuhSsqrYQeThcwIhg==
X-CSE-MsgGUID: O9ZrzVxGTiSqaS+ZFAypTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29641134"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29641134"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 08:41:28 -0700
X-CSE-ConnectionGUID: 6VCIzl9NTYSCGVZmLeyxaQ==
X-CSE-MsgGUID: NAmPtL4bRVi0gWH+HPOjZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85734765"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2024 08:41:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0FD9B252; Thu, 24 Oct 2024 18:41:17 +0300 (EEST)
Date: Thu, 24 Oct 2024 18:41:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ivan Epifanov <isage.dna@gmail.com>
Cc: torvalds@linux-foundation.org, aospan@netup.ru,
	conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
	dmaengine@vger.kernel.org, dushistov@mail.ru,
	fancer.lancer@gmail.com, geert@linux-m68k.org,
	gregkh@linuxfoundation.org, hoan@os.amperecomputing.com,
	ink@jurassic.park.msu.ru, jeffbai@aosc.io, kexybiscuit@aosc.io,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru,
	ntb@lists.linux.dev, patches@lists.linux.dev,
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru,
	shc_work@mail.ru, torvic9@mailbox.org, tsbogend@alpha.franken.de,
	v.georgiev@metrotek.ru, wangyuli@uniontech.com,
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
Message-ID: <Zxpqnf1M8rPTB4DN@black.fi.intel.com>
References: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <20241024095708.189649-1-isage.dna@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024095708.189649-1-isage.dna@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 24, 2024 at 12:57:08PM +0300, Ivan Epifanov wrote:
> 
> > I'm Finnish. Did you think I'd be *supporting* Russian
> > aggression? Apparently it's not just lack of real news, it's lack of
> > history knowledge too.
> 
> As an avid history lover, you've seem to forgot, that Finland fought on Nazi side.
> So yeah, we're well aware you don't like Russians, unless they're in concentration camps.
> Which is exactly what you do now: segragate, based on nationality. Strip of credits and names.
> Once a nazi - always a nazi. So, fuck you.

$ git log --author="isage.dna@gmail.com"
(no results given)

Q.E.D.

-- 
With Best Regards,
Andy Shevchenko



