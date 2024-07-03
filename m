Return-Path: <dmaengine+bounces-2620-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5F8926B0B
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jul 2024 23:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396491C20366
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jul 2024 21:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B119518E74F;
	Wed,  3 Jul 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3HuJcMC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8111891C6
	for <dmaengine@vger.kernel.org>; Wed,  3 Jul 2024 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043866; cv=none; b=FSqEBYLj05jPDZtB6C0GqoMf8diRzI+OCXywsvCsmGCe2w2b2xTyvdtPxmTt/cyiG0mo1TupsDrjTs5bwKQzqFK/gri1PYaSIFZYa1RMmfHs39vzv24sWdhq6FabgKLoZrskUTvQadu9BZuGdPO+qnsbaiz6cRPqsrVFv8CRmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043866; c=relaxed/simple;
	bh=u6c8cEhbKLASZ3y0kQ8VmLeFrZTrVpISAbknzZDwfxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awuHkMY0vimhJUIY6sHnRQq886JixoqlrKNZk0TkKSfPwbH5Hb3FpW8Lb5GeYrEzt+vKVDD8dYnoJkQBscVV9JVFibQfYPY0/Y1mV8cdTZHSmql6/dXxoIUYz24lamOf1r46755xflhZio4BrHkavfiqXAPWjpDyLCsnoF1/OnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3HuJcMC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720043865; x=1751579865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u6c8cEhbKLASZ3y0kQ8VmLeFrZTrVpISAbknzZDwfxI=;
  b=h3HuJcMCQM99LZBmMUvY0ZcVE4oijtxG3RF5OqXZ2AKfJl0zqSNF5eLW
   lR5RLbIicvoWHIrUeReERV5scb+5B5xK1rx9PiR4K6gJ60HS84VA/8Xj6
   v99SSKhTZmQDGrN5MZOSWbWxTzu/iCAaZ8L9Y3m2rJQFAlgyMyt8achyQ
   101lsRRrue7ndjLwzQ8aLwdKNh7HCNwFSjnDeM7++a5Hsj3kJT7qa9CF2
   sfsVp2HC5MGxdVQmcwd9Z0bwUdHRjkQQsXw/OjecND8FIuqCVHeMhKeli
   pxyDqLfGG3pQzNvNL0Ljwj5ITNT/877C1iHbuv8x6cvaFhLqN7DlKMt1N
   A==;
X-CSE-ConnectionGUID: zW3Ks4poQ3y+ceEJBr/JhA==
X-CSE-MsgGUID: AFwQQt9sR5uqwPIPSGGBww==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="21108333"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="21108333"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 14:57:44 -0700
X-CSE-ConnectionGUID: eaGsrHu6QAacS3dyfbqhvQ==
X-CSE-MsgGUID: dyn5UHmVRhyPomcjdysQPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46402822"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Jul 2024 14:57:41 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sP7yt-000QGs-2f;
	Wed, 03 Jul 2024 21:57:39 +0000
Date: Thu, 4 Jul 2024 05:57:15 +0800
From: kernel test robot <lkp@intel.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org,
	dmaengine@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Raju.Rangoju@amd.com, Frank.li@nxp.com, helgaas@kernel.org,
	pstanner@redhat.com, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH v3 5/7] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
Message-ID: <202407040547.MfCINdp6-lkp@intel.com>
References: <20240624075610.1659502-6-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624075610.1659502-6-Basavaraj.Natikar@amd.com>

Hi Basavaraj,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc6]
[cannot apply to vkoul-dmaengine/next next-20240703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Basavaraj-Natikar/dmaengine-Move-AMD-DMA-driver-to-separate-directory/20240625-194947
base:   linus/master
patch link:    https://lore.kernel.org/r/20240624075610.1659502-6-Basavaraj.Natikar%40amd.com
patch subject: [PATCH v3 5/7] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240704/202407040547.MfCINdp6-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240704/202407040547.MfCINdp6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407040547.MfCINdp6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: __cfi_pt_check_status_trans
   >>> defined at ptdma-dev.c
   >>>            drivers/dma/amd/ptdma/ptdma-dev.o:(__cfi_pt_check_status_trans) in archive vmlinux.a
   >>> defined at ae4dma-dev.c
   >>>            drivers/dma/amd/ae4dma/ae4dma-dev.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: __cfi_pt_core_perform_passthru
   >>> defined at ptdma-dev.c
   >>>            drivers/dma/amd/ptdma/ptdma-dev.o:(__cfi_pt_core_perform_passthru) in archive vmlinux.a
   >>> defined at ae4dma-dev.c
   >>>            drivers/dma/amd/ae4dma/ae4dma-dev.o:(.text+0x440) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

