Return-Path: <dmaengine+bounces-8816-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDlOGSBQiGllnwQAu9opvQ
	(envelope-from <dmaengine+bounces-8816-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 08 Feb 2026 09:58:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70286108244
	for <lists+dmaengine@lfdr.de>; Sun, 08 Feb 2026 09:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27E3C3011116
	for <lists+dmaengine@lfdr.de>; Sun,  8 Feb 2026 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20C33CE92;
	Sun,  8 Feb 2026 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FC+BoQ7r"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1483EBF0E;
	Sun,  8 Feb 2026 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770541085; cv=none; b=pKeuqrIN90AYJTVhLfivW5ctZ5OFb/4lm42Vv9dqsJJ1yR9TEkWQ4BmE9du+46Wu+8QYg25N5Qjl0Q3SYPO2S5B5rOkn5Oe4cvUXXwPfrj7cNCThdxujcnK8rCXeG8YUTmrc3bJmEQzySeC7D6HnmdZI8xlNJoPwkifX5qRVBAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770541085; c=relaxed/simple;
	bh=6PXYYyFWwCKZhzlGOOe6zlKrU0nwj6paIBBqgxvvRSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYcooltfrARoRxRPJhUPA1nGtUozcoCG1nV/+OvGsgsO0GRgfpoC6mjTrpO3Y1IQs/w1/W/B78Y61WZWI3z6aMXlG6YJRpHp52EM0wO1yg4yq7KGZBw3aEkiHVxnJsJy3goOgZdCt49ZSKNBB19vCZgwZg9q/ASxRqFAeCjcT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FC+BoQ7r; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770541085; x=1802077085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6PXYYyFWwCKZhzlGOOe6zlKrU0nwj6paIBBqgxvvRSE=;
  b=FC+BoQ7rcdk1GYo5FRDaEP3FGmb+mNbFUvvcq/lPwiD5a5YwNRT7WL1y
   G7kiqaePLzIoQQp/Z+S0+3dyrgRe0jiS/MNvCQ9B6b/amuuB+1SxbnUGt
   u69j56EfFbZo/J/4kvNi2/UjGuFH2c/iEAFHYqDqqv0V2QN0i3KucyVmL
   wq015JgL8gIq2dtWw5bC2HCrZSPugzjb2AwJ/DRCs8dRg713zPURoc5hw
   Nj8MRz/eZHde+xxONGgjlmPyQBH7L7JbRtYGxPWtVh/tLQm5DSlUFfrGr
   zER8qaHDZi0fy1EHDCLXdxFrmQdKd+jsvmvb0PIhe0JGWtyBKnuiSdbFW
   w==;
X-CSE-ConnectionGUID: 7qaiEXn9R6myACv96HO7rg==
X-CSE-MsgGUID: aYLKGzH/QFixaP3pzKPILQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="83056644"
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="83056644"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 00:58:04 -0800
X-CSE-ConnectionGUID: hivW+x3DRgWV5innbmpaXw==
X-CSE-MsgGUID: RsoW97q6SVqRU4qzOyxhPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="215475021"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Feb 2026 00:58:01 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vp0cA-00000000m76-1env;
	Sun, 08 Feb 2026 08:57:58 +0000
Date: Sun, 8 Feb 2026 16:57:29 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <den@valinux.co.jp>, vkoul@kernel.org, mani@kernel.org,
	Frank.Li@nxp.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] dmaengine: dw-edma: Export per-channel IRQ and
 doorbell register offset
Message-ID: <202602081640.ChGzNbe8-lkp@intel.com>
References: <20260206172646.1556847-4-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206172646.1556847-4-den@valinux.co.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8816-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[valinux.co.jp,kernel.org,nxp.com,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 70286108244
X-Rspamd-Action: no action

Hi Koichiro,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.19-rc8 next-20260205]
[cannot apply to vkoul-dmaengine/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Koichiro-Den/dmaengine-dw-edma-Add-per-channel-interrupt-routing-control/20260207-013042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260206172646.1556847-4-den%40valinux.co.jp
patch subject: [PATCH v4 3/9] dmaengine: dw-edma: Export per-channel IRQ and doorbell register offset
config: arc-randconfig-002-20260208 (https://download.01.org/0day-ci/archive/20260208/202602081640.ChGzNbe8-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260208/202602081640.ChGzNbe8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602081640.ChGzNbe8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/dw-edma/dw-edma-core.c: In function 'dw_edma_chan_info':
>> drivers/dma/dw-edma/dw-edma-core.c:1109:26: warning: variable 'dchan' set but not used [-Wunused-but-set-variable]
    1109 |         struct dma_chan *dchan;
         |                          ^~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CAN_DEV
   Depends on [n]: NETDEVICES [=n] && CAN [=y]
   Selected by [y]:
   - CAN [=y] && NET [=y]


vim +/dchan +1109 drivers/dma/dw-edma/dw-edma-core.c

  1103	
  1104	int dw_edma_chan_info(struct dw_edma_chip *chip, unsigned int ch_idx,
  1105			      struct dw_edma_chan_info *info)
  1106	{
  1107		struct dw_edma *dw = chip->dw;
  1108		struct dw_edma_chan *chan;
> 1109		struct dma_chan *dchan;
  1110		u32 ch_cnt;
  1111		int ret;
  1112	
  1113		if (!chip || !info || !dw)
  1114			return -EINVAL;
  1115	
  1116		ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
  1117		if (ch_idx >= ch_cnt)
  1118			return -EINVAL;
  1119	
  1120		chan = &dw->chan[ch_idx];
  1121		dchan = &chan->vc.chan;
  1122	
  1123		ret = dw_edma_core_ch_info(dw, chan, info);
  1124		if (ret)
  1125			return ret;
  1126	
  1127		info->irq = dw->irq[chan->irq_idx].irq;
  1128		return 0;
  1129	}
  1130	EXPORT_SYMBOL_GPL(dw_edma_chan_info);
  1131	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

