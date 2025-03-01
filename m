Return-Path: <dmaengine+bounces-4627-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E56A4ADBB
	for <lists+dmaengine@lfdr.de>; Sat,  1 Mar 2025 21:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE782170461
	for <lists+dmaengine@lfdr.de>; Sat,  1 Mar 2025 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B5E1E7C2B;
	Sat,  1 Mar 2025 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGMWoBQD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3081E3790;
	Sat,  1 Mar 2025 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859809; cv=none; b=Ed7C0gWpkhDqo5J1gFs4na/Iz9I/qaa1VZU8mWBSo48JtpD91ekL5sGfglSRjFUEkPlvneHhMYtk2EWnbFjU9QfKYZ56IqWuorg5t7SGxPLrkkmKg90VmoTFhDXveifOO628IF2klw1AgZYjmZIsHAknU8+5iwXpaZnBH8iI+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859809; c=relaxed/simple;
	bh=ZfGj1VvKOCNm7vTywX/xNLIbng1hIS9ksg3oRkOji3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RijIj8q2miINlWXVlcylIdFRITnsy5PHHdPIAbkNe7dFlXuEBapUP6iuQSmhPMkji+dsCsU2tJSWTOTqQ03CKLdQ1l5g1IDmAO444Z281obUE07Y0gI+o16eN3hoL+IEdRrWAG3rxm7d9X+XHWGIPgO47z27tEqMh8aJV6zpsR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGMWoBQD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740859807; x=1772395807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZfGj1VvKOCNm7vTywX/xNLIbng1hIS9ksg3oRkOji3M=;
  b=UGMWoBQD+CSk+GBeis0ixrdBsFvcjQy8tu89Pc/776lqhDOPuHndxIW5
   Hy1R5W8uSFZ/Pbg8ZYEKkVnJOV3XfHXNng3obG8BBX4KZg3NP/Smmauj/
   /tkBpycNylYBWPqtGcy0jbFn0a2oHWqPGOL1Q6lIxeh+IpHK8b2PyFp1r
   80PB5fhxDwZWVv24g7/XID0zn/XOxdQAHN1pg/U531UxymX/mPzSLRJVO
   XvRdoOMfvcQeUVHq9TECovKboGDSfnUrsFRoMfBAR6Q3gw93/RCTmiUXl
   FaQGSm5ZB6Mdq1coqTfHu03Klp+4Zsoj6xVdbgAxJUgkBhHiMvJFzgeEM
   w==;
X-CSE-ConnectionGUID: NAYzV2mTSo2hH76MbUNzAg==
X-CSE-MsgGUID: FlSxLlrmRMqjV1NWfBiZqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41959942"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41959942"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 12:10:06 -0800
X-CSE-ConnectionGUID: n9ipID95TjqGXZ0wuii2jQ==
X-CSE-MsgGUID: c981CLrzROeKm6mC/sKYEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="117626585"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 01 Mar 2025 12:10:04 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toT9u-000Gek-19;
	Sat, 01 Mar 2025 20:10:02 +0000
Date: Sun, 2 Mar 2025 04:09:16 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, vkoul@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dmaengine: Add Arm DMA-350 driver
Message-ID: <202503020324.hFtOv6c7-lkp@intel.com>
References: <55e084dd2b5720bdddf503ffac560d111032aa96.1740762136.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e084dd2b5720bdddf503ffac560d111032aa96.1740762136.git.robin.murphy@arm.com>

Hi Robin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/dt-bindings-dma-Add-Arm-DMA-350/20250301-012733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/55e084dd2b5720bdddf503ffac560d111032aa96.1740762136.git.robin.murphy%40arm.com
patch subject: [PATCH 2/2] dmaengine: Add Arm DMA-350 driver
config: parisc-randconfig-002-20250302 (https://download.01.org/0day-ci/archive/20250302/202503020324.hFtOv6c7-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020324.hFtOv6c7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020324.hFtOv6c7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/arm-dma350.c:641:34: warning: 'd350_of_match' defined but not used [-Wunused-const-variable=]
     641 | static const struct of_device_id d350_of_match[] = {
         |                                  ^~~~~~~~~~~~~


vim +/d350_of_match +641 drivers/dma/arm-dma350.c

   640	
 > 641	static const struct of_device_id d350_of_match[] = {
   642		{ .compatible = "arm,dma-350" },
   643		{}
   644	};
   645	MODULE_DEVICE_TABLE(of, d350_of_match);
   646	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

