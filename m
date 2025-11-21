Return-Path: <dmaengine+bounces-7289-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E06C7A34B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 15:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E11442E02B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AB6352FB9;
	Fri, 21 Nov 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhXAE2c0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07935292B;
	Fri, 21 Nov 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735653; cv=none; b=HxahVcjy4J8RGNTKCbiRgIncj21nB/U/GURoa7VLSmzJOwyh//Ikb8nkUVsH9FF86DKZyYxatCXoDM3S9ZDvfWkjRCWUUKbimlSic9xB1S/Rl4CCxxvnus6wPPQLDhKeEVpid8VQrz5h71eNFDvhnEiuZZr2/2nS2BApISvcRFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735653; c=relaxed/simple;
	bh=1XoUCF59kcMVVq7Hd7ANhG5TS1a7hgA1sXh6vlWZw8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSTwZFLEbKA8HxgETrsbOcaZZbOgHquh8xcgAuSnG5daxSjWSkA4x63zsVvtXjJTrgaH6HNLNJJjrhYjkQ8dSA7/TKTsWsrN3Cg9O5mtTHIm0iOPv5WfReYUi+JL+7uuBeB0mnL6X/9SeP/DKaSWxKlA7G4I138I0RXR9nAqYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhXAE2c0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763735649; x=1795271649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1XoUCF59kcMVVq7Hd7ANhG5TS1a7hgA1sXh6vlWZw8c=;
  b=WhXAE2c0RJNrocCR+Q/K2mbU30DuXM1Su66I206IwJVlMrRWByC1c0OY
   YzCCnFofgVfumFMdw183I+VgS6fiHIopAkn8aqDARLKJkJ2YyMwvd9b9/
   zfJA9EkSRgsK8+ZFX4r9r862YKkMJnaVwAVZVnbzEQ6muBT4xkcVpoiOr
   RoB1wm60FFFoCZjzsPaSVXJ7Z4N3xOz5tHJv0Q+uNCcqN6kD/CnFEKWlB
   ubsm5+M78NuwJoLqy3cu9LBSHZJ5msqru/JeIKhXc2fkKfHc0R7EGMyM5
   YMKRK65O7pXxiZ65o/C8S1WhxW0c5LKjfrivwO3iwG9GtbzLU33lzlOAy
   Q==;
X-CSE-ConnectionGUID: Of10cQZRQSGeNVVmacivlw==
X-CSE-MsgGUID: XXRUWNU5Rr2vK3ItGrYx8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="76512254"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="76512254"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 06:34:03 -0800
X-CSE-ConnectionGUID: GDde5zVlRbCzdD62mN8+RA==
X-CSE-MsgGUID: PAMWWwzOSAiXoV+m4AVJKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="192155378"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.4])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 06:32:53 -0800
Date: Fri, 21 Nov 2025 16:32:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Olivier Dautricourt <olivierdautricourt@gmail.com>,
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
Message-ID: <aSB4EwOqTs5Psg8i@smile.fi.intel.com>
References: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
 <aR9otpWZkPZrb9ug@smile.fi.intel.com>
 <aSBVwOs3igPF71DQ@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSBVwOs3igPF71DQ@vaman>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 21, 2025 at 05:36:24PM +0530, Vinod Koul wrote:
> On 20-11-25, 21:15, Andy Shevchenko wrote:
> > On Thu, Nov 13, 2025 at 04:12:56PM +0100, Andy Shevchenko wrote:
> > 
> > Vinod, what is your plan on the DMAengine patches? (Asking not only about this series)
> > Please, tell if anything needs to be done from my side to help them being pulled.
> 
> Sure would appreciate if folks can review, make it easier for me to
> pick. Yeah been behind for a bit, picking things now.
> 
> Reg this series, looks okay, who would ack patch 1?

You. :-) For the generic headers each subsystem maintainers may apply this.

-- 
With Best Regards,
Andy Shevchenko



