Return-Path: <dmaengine+bounces-2509-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6C913CD5
	for <lists+dmaengine@lfdr.de>; Sun, 23 Jun 2024 18:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C19D1C202F1
	for <lists+dmaengine@lfdr.de>; Sun, 23 Jun 2024 16:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3B181311;
	Sun, 23 Jun 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etwslPjM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38218BFA
	for <dmaengine@vger.kernel.org>; Sun, 23 Jun 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719161169; cv=none; b=qIUvOkiBBIIPm4nEsHajU9jpBGB9PJy8i521M40Q6J+kIte7J2+xyd1BZsFEQpT4+EN3UV1zRYLKvdOMZMxYjIoidNX4uWDvND9xotaFzoLM7qfd3lwunfg3nmLLyzLKEHfVOWYlI6Eqqu7srNiCyzjLgwbo5BdoeO/E6Iu8N9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719161169; c=relaxed/simple;
	bh=n3TDtP05+wle753FuNbbpJv6GnSdmJUBgE77Gjiccuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRpo2pgl4JyVA6jU+q8VzdkBIzsOslMAf2Gc0xQv4pLnYADfqI3/xRkbeDToUQowNmp8GPh8OZAf0//X5b3x8B+ROaER986TFotEgz3z1koJREInrsh9A03jfEFTS1NUAMIwpnMybze+tq6fo7X9mlo1k0iQdbv9s42GeY7sVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etwslPjM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719161165; x=1750697165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n3TDtP05+wle753FuNbbpJv6GnSdmJUBgE77Gjiccuc=;
  b=etwslPjMt/SeLK7ebfU+cpbmwbtThnYAhDn/kr8fF218yqfoGrydFGs0
   H1gm9rGfGOsbw0VkITb0r4uoXELAPYx4RvKNF7H6w/oFdbeWZEnUFx/gr
   8+5oTGxltQNImo8QbKO1UTzfvzarjW9UrnC75Y+FyFKYqVoewjZc6CTYH
   nRmB45cdlQJ2qZPv3PFhs7BM9pzxvH8HoVolkj7DCLOdGX4TopHuskMRy
   a3CWJUyuoVFWV8ltlNRq+hMk3XxjgOvkHXXN8DpVceC6TxiQ4xd/BGYmU
   OxF4j1lyaQkVT++zLoUa04jnu+dRcMntVx3f5tuIV2VJz3ROjSnqT7e4V
   A==;
X-CSE-ConnectionGUID: VpHG/uooTluBSggDZ2REwQ==
X-CSE-MsgGUID: o5bCbLxJRJaT/FHlAqR0Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="15889541"
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="15889541"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 09:46:04 -0700
X-CSE-ConnectionGUID: f40WRws/QMmuo8NudKOt4w==
X-CSE-MsgGUID: 4Z8j8rofSOm7kwQSi1O17Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="43187871"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 Jun 2024 09:46:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLQLo-000AhK-1R;
	Sun, 23 Jun 2024 16:46:00 +0000
Date: Mon, 24 Jun 2024 00:45:37 +0800
From: kernel test robot <lkp@intel.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org,
	dmaengine@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Raju.Rangoju@amd.com, Frank.li@nxp.com,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH v2 5/7] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
Message-ID: <202406240021.ytiS3jV6-lkp@intel.com>
References: <20240617100359.2550541-6-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617100359.2550541-6-Basavaraj.Natikar@amd.com>

Hi Basavaraj,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc4]
[cannot apply to vkoul-dmaengine/next next-20240621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Basavaraj-Natikar/dmaengine-Move-AMD-DMA-driver-to-separate-directory/20240617-184320
base:   linus/master
patch link:    https://lore.kernel.org/r/20240617100359.2550541-6-Basavaraj.Natikar%40amd.com
patch subject: [PATCH v2 5/7] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
config: x86_64-randconfig-103-20240623 (https://download.01.org/0day-ci/archive/20240624/202406240021.ytiS3jV6-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240624/202406240021.ytiS3jV6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406240021.ytiS3jV6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: pt_dmaengine_register
   >>> defined at ptdma-dmaengine.c:364 (drivers/dma/amd/ae4dma/../ptdma/ptdma-dmaengine.c:364)
   >>>            drivers/dma/amd/ptdma/ptdma-dmaengine.o:(pt_dmaengine_register) in archive vmlinux.a
   >>> defined at ptdma-dmaengine.c:364 (drivers/dma/amd/ae4dma/../ptdma/ptdma-dmaengine.c:364)
   >>>            drivers/dma/amd/ptdma/ptdma-dmaengine.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: pt_dmaengine_unregister
   >>> defined at ptdma-dmaengine.c:467 (drivers/dma/amd/ae4dma/../ptdma/ptdma-dmaengine.c:467)
   >>>            drivers/dma/amd/ptdma/ptdma-dmaengine.o:(pt_dmaengine_unregister) in archive vmlinux.a
   >>> defined at ptdma-dmaengine.c:467 (drivers/dma/amd/ae4dma/../ptdma/ptdma-dmaengine.c:467)
   >>>            drivers/dma/amd/ptdma/ptdma-dmaengine.o:(.text+0x1ED0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: pt_start_queue
   >>> defined at amd_dma.c:14 (drivers/dma/amd/ae4dma/../common/amd_dma.c:14)
   >>>            drivers/dma/amd/common/amd_dma.o:(pt_start_queue) in archive vmlinux.a
   >>> defined at amd_dma.c:14 (drivers/dma/amd/ae4dma/../common/amd_dma.c:14)
   >>>            drivers/dma/amd/common/amd_dma.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: pt_stop_queue
   >>> defined at amd_dma.c:20 (drivers/dma/amd/ae4dma/../common/amd_dma.c:20)
   >>>            drivers/dma/amd/common/amd_dma.o:(pt_stop_queue) in archive vmlinux.a
   >>> defined at amd_dma.c:20 (drivers/dma/amd/ae4dma/../common/amd_dma.c:20)
   >>>            drivers/dma/amd/common/amd_dma.o:(.text+0x70) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: pt_check_status_trans
   >>> defined at ptdma-dev.c:133 (drivers/dma/amd/ptdma/ptdma-dev.c:133)
   >>>            drivers/dma/amd/ptdma/ptdma-dev.o:(pt_check_status_trans) in archive vmlinux.a
   >>> defined at ae4dma-dev.c:64 (drivers/dma/amd/ae4dma/ae4dma-dev.c:64)
   >>>            drivers/dma/amd/ae4dma/ae4dma-dev.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: pt_core_perform_passthru
   >>> defined at ptdma-dev.c:90 (drivers/dma/amd/ptdma/ptdma-dev.c:90)
   >>>            drivers/dma/amd/ptdma/ptdma-dev.o:(pt_core_perform_passthru) in archive vmlinux.a
   >>> defined at ae4dma-dev.c:172 (drivers/dma/amd/ae4dma/ae4dma-dev.c:172)
   >>>            drivers/dma/amd/ae4dma/ae4dma-dev.o:(.text+0x350) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

