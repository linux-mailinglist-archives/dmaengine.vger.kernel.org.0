Return-Path: <dmaengine+bounces-8700-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEk8APJXgmmkSgMAu9opvQ
	(envelope-from <dmaengine+bounces-8700-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 21:17:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FDFDE6CA
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 21:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF0DE302E716
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 20:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE8436C5AA;
	Tue,  3 Feb 2026 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxWQO5xq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A905368294;
	Tue,  3 Feb 2026 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149865; cv=none; b=pBHwoybV5XuEeGD2SILDoVpjOsswLopPto6ssoVIFEBw5UCWF36pqnRQt18VCdwi44ZI2aM+UecvQWc/FRpFMawCbCz3IZLLNkBk0JkmsHquW6bbj4uqWPMRAzxBEvMlMXo2FGedfoVcEVi2spGVhYv+OC0My3w7mP1Mr1nA3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149865; c=relaxed/simple;
	bh=w42yFQWHEEYQnV+V0mgtNBGRcqPxBXBP+2r7gtsMWzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBhSqMulvNwexZkWGvOT8wJrNnhRi6axQC+NWDK1lE1vsldOS9iLWgcSfDSq4bHDHDx1NYsL54yu4G3c8ClTywyu3hDYJobvw1/dKrBssBEHp++8jUITcYvfodi7AlShZObkqD80uhYBc3q18cMfYRTSch+Hj+9o9HJPNTNliy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxWQO5xq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770149862; x=1801685862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w42yFQWHEEYQnV+V0mgtNBGRcqPxBXBP+2r7gtsMWzQ=;
  b=QxWQO5xqwSXYm+5wqcPxX21fyAkJKNQ9YiT1UtXym8ReLC8b9O8QSXuF
   sjUGfd1EpkN+leytvw+tdfieftqfeu8zp63xwmLK8mlKckX/Q+eU8M2zX
   3a0HklYiuL/8C+gcj/Q66MALCTHO6D6AiVqYlvXbeu+vojRiqhFv1oHs1
   O8gXQVXDdjwO2UBFBnXYU6BRg7QXoSq4Z8axp9RbYimnSju0Ld+I5yLeI
   IxteomhpPbyunUUAddrc5d+zvRq5e4l9VEBSIWIIDh17QbWzEflvbh/P8
   PcmJDPqZN5Z2Xe/niV+jWwu4DIm6IpE1DMbylyVpH2nTIbwu/dHRL4LU9
   w==;
X-CSE-ConnectionGUID: fY30a+4wTPGvxGwXSnpQgA==
X-CSE-MsgGUID: rW/+miCSR2+UZTfVeU+F7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71413068"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71413068"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 12:17:42 -0800
X-CSE-ConnectionGUID: iW3FNoxKTo+bbu/AWWdnhg==
X-CSE-MsgGUID: s6Vf1vhaRoKa44zcg00ZMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="214437336"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 03 Feb 2026 12:17:41 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnMqB-00000000h32-2Lfp;
	Tue, 03 Feb 2026 20:17:39 +0000
Date: Wed, 4 Feb 2026 04:16:51 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <phasta@kernel.org>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: Re: [PATCH] dmaengine: amd: Replace deprecated PCI functions
Message-ID: <202602040405.NuKnq4rr-lkp@intel.com>
References: <20260203123238.88598-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203123238.88598-2-phasta@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-8700-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2FDFDE6CA
X-Rspamd-Action: no action

Hi Philipp,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.19-rc8 next-20260202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/dmaengine-amd-Replace-deprecated-PCI-functions/20260203-204040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20260203123238.88598-2-phasta%40kernel.org
patch subject: [PATCH] dmaengine: amd: Replace deprecated PCI functions
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20260204/202602040405.NuKnq4rr-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602040405.NuKnq4rr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602040405.NuKnq4rr-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/dma/amd/ae4dma/ae4dma-pci.c:11:
   In file included from drivers/dma/amd/ae4dma/ae4dma.h:14:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/dma/amd/ae4dma/ae4dma-pci.c:80:24: error: expected ';' at end of declaration
      80 |         unsigned long bar_mask
         |                               ^
         |                               ;
   1 warning and 1 error generated.


vim +80 drivers/dma/amd/ae4dma/ae4dma-pci.c

    75	
    76	static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
    77	{
    78		struct device *dev = &pdev->dev;
    79		struct ae4_device *ae4;
  > 80		unsigned long bar_mask
    81		struct pt_device *pt;
    82		int ret = 0;
    83		int bar;
    84	
    85		ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
    86		if (!ae4)
    87			return -ENOMEM;
    88	
    89		ae4->ae4_msix = devm_kzalloc(dev, sizeof(struct ae4_msix), GFP_KERNEL);
    90		if (!ae4->ae4_msix)
    91			return -ENOMEM;
    92	
    93		ret = pcim_enable_device(pdev);
    94		if (ret)
    95			goto ae4_error;
    96	
    97		bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
    98		for_each_set_bit(bar, &bar_mask, sizeof(bar_mask)) {
    99			ret = pcim_request_region(pdev, bar, DRIVER_NAME);
   100			if (ret)
   101				goto ae4_error;
   102		}
   103	
   104		pt = &ae4->pt;
   105		pt->dev = dev;
   106		pt->ver = AE4_DMA_VERSION;
   107	
   108		pt->io_regs = pcim_iomap(pdev, 0, 0);
   109		if (!pt->io_regs) {
   110			ret = -ENOMEM;
   111			goto ae4_error;
   112		}
   113	
   114		ret = ae4_get_irqs(ae4);
   115		if (ret < 0)
   116			goto ae4_error;
   117	
   118		pci_set_master(pdev);
   119	
   120		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
   121	
   122		dev_set_drvdata(dev, ae4);
   123	
   124		ret = ae4_core_init(ae4);
   125		if (ret)
   126			goto ae4_error;
   127	
   128		return 0;
   129	
   130	ae4_error:
   131		ae4_deinit(ae4);
   132	
   133		return ret;
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

