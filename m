Return-Path: <dmaengine+bounces-9515-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBfZH205u2lNhAIAu9opvQ
	(envelope-from <dmaengine+bounces-9515-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 00:46:53 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 614DB2C3E44
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 00:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEF6B3023156
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 23:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43AF38F251;
	Wed, 18 Mar 2026 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IED844GM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1830C37A;
	Wed, 18 Mar 2026 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877610; cv=none; b=nb/DZLANemHQK8C8ABh2VGTKgSBlvnN4BiIm2mIADUFQuUR1f30a+L3UdIRDAt0NhtvpDa/o2u7aLhjoZO8e0ZRV3QJlm1xn5Z0F9IGGCAjWncbsOX7zhR0DFXTWdp2aoMcweYqXK1NSQ33gnThLFtbG/J7skm8ZBED1zHUBppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877610; c=relaxed/simple;
	bh=htXtzqA5D5xHsQ7LDToss/Gx1lJOnKeDkKdnL4bkopE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQYPUR70LYs98+iTD4XzrGfCKKGMoLvv9/CppH4Bd/YnoWUth5M5vy5lT/pPqkdgDLQkAFxYLDKUEVya4uuDejk29kR4BP+d97zVL8pC1C0N6Y/38B1n1H4KOcQKkRLE6dUbNPBXfy9KfB/buuRz59dXz4Mg/uGHVcd72sXfDtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IED844GM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773877609; x=1805413609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=htXtzqA5D5xHsQ7LDToss/Gx1lJOnKeDkKdnL4bkopE=;
  b=IED844GMePPTzlbPY+s44SvQTBc13LfEUH5cO3W5tKI3JwO3BeVpucKq
   Opxj8M+aEUCO32PldIcODR3RQ5bB+2UIkmApWcCZ61/DbAsIev+HuzUVt
   IoCu1iW7rPPZORJ5WD81zkMPs8lPXIimU8ee5eGNZLMxt/g22ggC/59L+
   qTSvZd0E89FGVWAdP0Rvcx8C/Gl7lJo9lAIdQn3VWxL9LA2WdgtWE8H/O
   tM4fyHIBbersoTzQD3HpGQkd2XYzcdYn+d+xTBpcUIYHFexuzF+QFdD+J
   78wDt2uqmCHz5RuUvbcW2dG6aOD5XOOskwFQf4Q8Sy9TPrNGZbYdWNu41
   Q==;
X-CSE-ConnectionGUID: MjwlcLGGTOaF0RQylAzxXw==
X-CSE-MsgGUID: 38rAlmXtSgqW9HcQ9TedIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="77554927"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="77554927"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 16:46:48 -0700
X-CSE-ConnectionGUID: t63IPWpUSjaj4ajSUB8Ibg==
X-CSE-MsgGUID: e725TaPFR9q2CTuunIHsEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="227739417"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 18 Mar 2026 16:46:43 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w30X4-0000000005R-0VDr;
	Wed, 18 Mar 2026 23:44:42 +0000
Date: Thu, 19 Mar 2026 07:42:09 +0800
From: kernel test robot <lkp@intel.com>
To: Sheetal <sheetal@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Laxman Dewangan <ldewangan@nvidia.com>,
	Frank Li <Frank.Li@kernel.org>, Mohan Kumar <mkumard@nvidia.com>,
	dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sheetal <sheetal@nvidia.com>
Subject: Re: [PATCH] dmaengine: tegra210-adma: Add error logging on failure
 paths
Message-ID: <202603190726.ahyQblsp-lkp@intel.com>
References: <20260318073922.1760132-1-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318073922.1760132-1-sheetal@nvidia.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9515-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 614DB2C3E44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sheetal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v7.0-rc4 next-20260318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sheetal/dmaengine-tegra210-adma-Add-error-logging-on-failure-paths/20260318-214221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20260318073922.1760132-1-sheetal%40nvidia.com
patch subject: [PATCH] dmaengine: tegra210-adma: Add error logging on failure paths
config: x86_64-buildonly-randconfig-003-20260319 (https://download.01.org/0day-ci/archive/20260319/202603190726.ahyQblsp-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260319/202603190726.ahyQblsp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603190726.ahyQblsp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from include/linux/of_dma.h:14,
                    from drivers/dma/tegra210-adma.c:12:
   drivers/dma/tegra210-adma.c: In function 'tegra_adma_set_xfer_params':
>> drivers/dma/tegra210-adma.c:677:39: warning: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     677 |                 dev_err(tdc2dev(tdc), "invalid DMA periods %u (max %u)\n",
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/dma/tegra210-adma.c:677:17: note: in expansion of macro 'dev_err'
     677 |                 dev_err(tdc2dev(tdc), "invalid DMA periods %u (max %u)\n",
         |                 ^~~~~~~
   drivers/dma/tegra210-adma.c:677:61: note: format string is defined here
     677 |                 dev_err(tdc2dev(tdc), "invalid DMA periods %u (max %u)\n",
         |                                                            ~^
         |                                                             |
         |                                                             unsigned int
         |                                                            %lu


vim +677 drivers/dma/tegra210-adma.c

   666	
   667	static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
   668					      struct tegra_adma_desc *desc,
   669					      dma_addr_t buf_addr,
   670					      enum dma_transfer_direction direction)
   671	{
   672		struct tegra_adma_chan_regs *ch_regs = &desc->ch_regs;
   673		const struct tegra_adma_chip_data *cdata = tdc->tdma->cdata;
   674		unsigned int burst_size, adma_dir, fifo_size_shift;
   675	
   676		if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS) {
 > 677			dev_err(tdc2dev(tdc), "invalid DMA periods %u (max %u)\n",
   678				desc->num_periods, ADMA_CH_CONFIG_MAX_BUFS);
   679			return -EINVAL;
   680		}
   681	
   682		switch (direction) {
   683		case DMA_MEM_TO_DEV:
   684			fifo_size_shift = ADMA_CH_TX_FIFO_SIZE_SHIFT;
   685			adma_dir = ADMA_CH_CTRL_DIR_MEM2AHUB;
   686			burst_size = tdc->sconfig.dst_maxburst;
   687			ch_regs->config = ADMA_CH_CONFIG_SRC_BUF(desc->num_periods - 1);
   688			ch_regs->ctrl = ADMA_CH_REG_FIELD_VAL(tdc->sreq_index,
   689							      cdata->ch_req_mask,
   690							      cdata->ch_req_tx_shift);
   691			ch_regs->src_addr = buf_addr;
   692			break;
   693	
   694		case DMA_DEV_TO_MEM:
   695			fifo_size_shift = ADMA_CH_RX_FIFO_SIZE_SHIFT;
   696			adma_dir = ADMA_CH_CTRL_DIR_AHUB2MEM;
   697			burst_size = tdc->sconfig.src_maxburst;
   698			ch_regs->config = ADMA_CH_CONFIG_TRG_BUF(desc->num_periods - 1);
   699			ch_regs->ctrl = ADMA_CH_REG_FIELD_VAL(tdc->sreq_index,
   700							      cdata->ch_req_mask,
   701							      cdata->ch_req_rx_shift);
   702			ch_regs->trg_addr = buf_addr;
   703			break;
   704	
   705		default:
   706			dev_err(tdc2dev(tdc), "DMA direction is not supported\n");
   707			return -EINVAL;
   708		}
   709	
   710		ch_regs->ctrl |= ADMA_CH_CTRL_DIR(adma_dir, cdata->ch_dir_mask,
   711				cdata->ch_dir_shift) |
   712				 ADMA_CH_CTRL_MODE_CONTINUOUS(cdata->ch_mode_shift) |
   713				 ADMA_CH_CTRL_FLOWCTRL_EN;
   714		ch_regs->config |= cdata->adma_get_burst_config(burst_size);
   715	
   716		if (cdata->global_ch_config_base)
   717			ch_regs->global_config |= cdata->ch_config;
   718		else
   719			ch_regs->config |= cdata->ch_config;
   720	
   721		/*
   722		 * 'sreq_index' represents the current ADMAIF channel number and as per
   723		 * HW recommendation its FIFO size should match with the corresponding
   724		 * ADMA channel.
   725		 *
   726		 * ADMA FIFO size is set as per below (based on default ADMAIF channel
   727		 * FIFO sizes):
   728		 *    fifo_size = 0x2 (sreq_index > sreq_index_offset)
   729		 *    fifo_size = 0x3 (sreq_index <= sreq_index_offset)
   730		 *
   731		 */
   732		if (tdc->sreq_index > cdata->sreq_index_offset)
   733			ch_regs->fifo_ctrl =
   734				ADMA_CH_REG_FIELD_VAL(2, cdata->ch_fifo_size_mask,
   735						      fifo_size_shift);
   736		else
   737			ch_regs->fifo_ctrl =
   738				ADMA_CH_REG_FIELD_VAL(3, cdata->ch_fifo_size_mask,
   739						      fifo_size_shift);
   740	
   741		ch_regs->tc = desc->period_len & ADMA_CH_TC_COUNT_MASK;
   742	
   743		return tegra_adma_request_alloc(tdc, direction);
   744	}
   745	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

