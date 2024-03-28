Return-Path: <dmaengine+bounces-1588-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3902F88F452
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 02:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E739D29ECB4
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 01:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8E118C22;
	Thu, 28 Mar 2024 01:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0zeFM1y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A8BA2F;
	Thu, 28 Mar 2024 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711588194; cv=none; b=GAMlaIgv64U8piL0mBZpIQhv9ehY8OgqDYXuSj+Wrl+hktc34lRazMQhYISEK9tYDm7ruAAdVVemCqqmPkR7H99zc88D8nFQaCfNTnlp3OFiadIl9Orb31JOyLaI9rwl6fq2VSSerUcDtzsVYLE2cetKfeIq/UN1tSNqUO8iD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711588194; c=relaxed/simple;
	bh=Udc/J/js8gW3bfsrXjFKt4foNU5vAVjuTKQH3YecMVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxguDCVPpFibYexr7Hgnq1f9BZ4NX1rAnfZqgsKwvwci0H0HdP6tHXP2CesrsuUl6AdrsMRkEHGlrmBN9//X06V1opJ5OtpH03KP1LWcr7QPtr+VAArKBevW15ytmUrE4NPXT5qV4rPiLUQdsddfq6sLT8nPYKMXBGZ0RImQX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0zeFM1y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711588191; x=1743124191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Udc/J/js8gW3bfsrXjFKt4foNU5vAVjuTKQH3YecMVI=;
  b=a0zeFM1yFsPLBaFAhUMdQK09FnPnvxVJNoktWfXuBxWxX97eHPkZQnBN
   uzz6QRB9HdMHvDVkFIGUuGHKZQDiVotfsTd6o2EqU1hXuHgaCcIoj0b/O
   bXDb1RljRiE9eIF2bK5zcEpcG9UHeg2gFAkHWeSLea2U6QFahdygwptYE
   Opm8ToW9sVkmrg6oiTfPoacBhRlKTz9SxpbeuAPQPhxUv2Ks394yf6n1U
   aMp6a53MoV8YAhQ8cVdWi1iPuK48+Es2PXDm4vBJ1O8DCnylv5wMiKhLE
   YzkT1Dwn+wW1COO1gPN5EoZcbL0qlYCpGDdAP3NuuED34ZbZ82KSBmPdK
   g==;
X-CSE-ConnectionGUID: T6807yvVQTqdp8EEtQFn/w==
X-CSE-MsgGUID: 6ByE7gCqSU+mzrXk1gbHLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="9684482"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="9684482"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:09:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="17095487"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Mar 2024 18:09:47 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpeH2-0001f8-1i;
	Thu, 28 Mar 2024 01:09:44 +0000
Date: Thu, 28 Mar 2024 09:09:18 +0800
From: kernel test robot <lkp@intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>, Michal Simek <monstr@monstr.eu>,
	Jan Kuliga <jankul@alatek.krakow.pl>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH 2/3] dmaengine: xilinx: xdma: Fix synchronization issue
Message-ID: <202403280803.IAFl90ZE-lkp@intel.com>
References: <20240327-digigram-xdma-fixes-v1-2-45f4a52c0283@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-digigram-xdma-fixes-v1-2-45f4a52c0283@bootlin.com>

Hi Louis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8e938e39866920ddc266898e6ae1fffc5c8f51aa]

url:    https://github.com/intel-lab-lkp/linux/commits/Louis-Chauvet/dmaengine-xilinx-xdma-Fix-wrong-offsets-in-the-buffers-addresses-in-dma-descriptor/20240327-180155
base:   8e938e39866920ddc266898e6ae1fffc5c8f51aa
patch link:    https://lore.kernel.org/r/20240327-digigram-xdma-fixes-v1-2-45f4a52c0283%40bootlin.com
patch subject: [PATCH 2/3] dmaengine: xilinx: xdma: Fix synchronization issue
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20240328/202403280803.IAFl90ZE-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403280803.IAFl90ZE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403280803.IAFl90ZE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/xilinx/xdma.c:76: warning: Function parameter or struct member 'last_interrupt' not described in 'xdma_chan'
>> drivers/dma/xilinx/xdma.c:76: warning: Function parameter or struct member 'stop_requested' not described in 'xdma_chan'


vim +76 drivers/dma/xilinx/xdma.c

17ce252266c7f0 Lizhi Hou     2023-01-19  53  
17ce252266c7f0 Lizhi Hou     2023-01-19  54  /**
17ce252266c7f0 Lizhi Hou     2023-01-19  55   * struct xdma_chan - Driver specific DMA channel structure
17ce252266c7f0 Lizhi Hou     2023-01-19  56   * @vchan: Virtual channel
17ce252266c7f0 Lizhi Hou     2023-01-19  57   * @xdev_hdl: Pointer to DMA device structure
17ce252266c7f0 Lizhi Hou     2023-01-19  58   * @base: Offset of channel registers
17ce252266c7f0 Lizhi Hou     2023-01-19  59   * @desc_pool: Descriptor pool
17ce252266c7f0 Lizhi Hou     2023-01-19  60   * @busy: Busy flag of the channel
17ce252266c7f0 Lizhi Hou     2023-01-19  61   * @dir: Transferring direction of the channel
17ce252266c7f0 Lizhi Hou     2023-01-19  62   * @cfg: Transferring config of the channel
17ce252266c7f0 Lizhi Hou     2023-01-19  63   * @irq: IRQ assigned to the channel
17ce252266c7f0 Lizhi Hou     2023-01-19  64   */
17ce252266c7f0 Lizhi Hou     2023-01-19  65  struct xdma_chan {
17ce252266c7f0 Lizhi Hou     2023-01-19  66  	struct virt_dma_chan		vchan;
17ce252266c7f0 Lizhi Hou     2023-01-19  67  	void				*xdev_hdl;
17ce252266c7f0 Lizhi Hou     2023-01-19  68  	u32				base;
17ce252266c7f0 Lizhi Hou     2023-01-19  69  	struct dma_pool			*desc_pool;
17ce252266c7f0 Lizhi Hou     2023-01-19  70  	bool				busy;
17ce252266c7f0 Lizhi Hou     2023-01-19  71  	enum dma_transfer_direction	dir;
17ce252266c7f0 Lizhi Hou     2023-01-19  72  	struct dma_slave_config		cfg;
17ce252266c7f0 Lizhi Hou     2023-01-19  73  	u32				irq;
70e8496bf693e1 Louis Chauvet 2024-03-27  74  	struct completion		last_interrupt;
70e8496bf693e1 Louis Chauvet 2024-03-27  75  	bool				stop_requested;
17ce252266c7f0 Lizhi Hou     2023-01-19 @76  };
17ce252266c7f0 Lizhi Hou     2023-01-19  77  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

