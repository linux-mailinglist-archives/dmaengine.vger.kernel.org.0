Return-Path: <dmaengine+bounces-7947-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E06FCDDDFF
	for <lists+dmaengine@lfdr.de>; Thu, 25 Dec 2025 16:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E192E300F599
	for <lists+dmaengine@lfdr.de>; Thu, 25 Dec 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1448032570F;
	Thu, 25 Dec 2025 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAtlzgC2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426F32692E;
	Thu, 25 Dec 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766675503; cv=none; b=LQpTpS3CZRp7tv8QaLCvEdYI9YHNiNe8WZfj/c01QAcsEUzk5AhozUpw7HE4QlOXNlrdbSEb/MvO9E84HK0pnuyeqt3U0OjOJmKxePMNaj66kF64G1P+8Cfn5GJMxDvsm1vBiFqHZz3JvBKqyENB+3hfYbS0jRvHIsLSmKyfdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766675503; c=relaxed/simple;
	bh=yyCBGzDXlMHFGXehLlhILicbHh60oofCHHG1NPZh8kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeGfUCvGXEH9w6JdSFPTeALjLJqlRb8rI8qvyC5D/GIeb2rficuI+dM7i+rhEKvn8EYHnlDTzpNxCgnGg+3tn0vSy1TTRBs2gH3TZTX4XgDN4ZYh0RUL85BYFVif6gZ7/TIzRXGfVi7IGPh4rfnIEENUoiV5DeBXe5L6CWIUKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAtlzgC2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766675501; x=1798211501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yyCBGzDXlMHFGXehLlhILicbHh60oofCHHG1NPZh8kA=;
  b=fAtlzgC2gG8TavfWorEo4s5Eijg5hVBepOgONjRfjxlT37TdEvacU+CO
   lZkqgoW0bl/A373ajJQFwaZBVEdQBEtazFPhpDNTrDD7bRlbzY+LQJsAi
   qsAhrt7QMOgVjeJvOTJEIDFI5IPQ3+s61sePyzGhlmJ+k0lzSb38XOYCs
   ECKNU35x5FqDUlHSIMondqhIUsGz1a50q+lsJUnsUq7LSOU56E0yEgLCE
   8kWamo54YQzVUSBBw4SrDtMxddqas3JhjuVwv/T172r/mYMMaqPbQ5ZwZ
   BvJzgMk/0o543WOc/zxUed/+9l10cNRRv8u5YaKpCBIckVHq2NWH+uN70
   g==;
X-CSE-ConnectionGUID: imlFEHQfQ/OfKmMToB0Hrw==
X-CSE-MsgGUID: 8N1C/ze/ToSMuQsoSEEjUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="71052556"
X-IronPort-AV: E=Sophos;i="6.21,176,1763452800"; 
   d="scan'208";a="71052556"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2025 07:11:41 -0800
X-CSE-ConnectionGUID: ibruoWqPSbaQLWUskrTTOw==
X-CSE-MsgGUID: FWWN82ZCQSqfNfysWESFiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,176,1763452800"; 
   d="scan'208";a="200716311"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 25 Dec 2025 07:11:39 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYn05-000000004Bl-1fOY;
	Thu, 25 Dec 2025 15:11:37 +0000
Date: Thu, 25 Dec 2025 23:10:55 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl08x: add COMPILE_TEST support
Message-ID: <202512252208.RWDZzD7W-lkp@intel.com>
References: <20251223204500.12786-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223204500.12786-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/dmaengine-pl08x-add-COMPILE_TEST-support/20251224-045157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20251223204500.12786-1-rosenp%40gmail.com
patch subject: [PATCH] dmaengine: pl08x: add COMPILE_TEST support
config: arc-randconfig-r112-20251225 (https://download.01.org/0day-ci/archive/20251225/202512252208.RWDZzD7W-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251225/202512252208.RWDZzD7W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512252208.RWDZzD7W-lkp@intel.com/

All errors (new ones prefixed by >>):

   arc-linux-ld: drivers/dma/amba-pl08x.o: in function `pl08x_probe':
>> amba-pl08x.c:(.text+0x245e): undefined reference to `amba_request_regions'
>> arc-linux-ld: amba-pl08x.c:(.text+0x245e): undefined reference to `amba_request_regions'
>> arc-linux-ld: amba-pl08x.c:(.text+0x24ea): undefined reference to `amba_release_regions'
>> arc-linux-ld: amba-pl08x.c:(.text+0x24ea): undefined reference to `amba_release_regions'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

