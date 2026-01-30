Return-Path: <dmaengine+bounces-8633-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF30HaoWfWkGQQIAu9opvQ
	(envelope-from <dmaengine+bounces-8633-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 21:38:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4EFBE72E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 21:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82AC73043D5E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 20:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153D34321A;
	Fri, 30 Jan 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjrpvNVd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8582FC006;
	Fri, 30 Jan 2026 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805455; cv=none; b=ARKEJak3DeW3qNWZAXO9O3aFpiN4nStBCK5Q2Ceo/VGQKicfpH7BWPmEbDrROvSx1ht0GgRPjOpQ39Gc1pCzQ8jlotPSKFw7PU35fnIeoV4pQ8snBvmsNNwhDyb5ZHsseFPsbNrKfo/9YGDCngeeyD0hsFPJyKWO/ySQzMHHby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805455; c=relaxed/simple;
	bh=oyYyl/3tzRz6bgIlUzjXdXzpWFXNTALSND9eRqESxCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSvNs8eJsSWhGlFiK0WliPeQy6xWERCbqQAeeKk8O4jgEbEJLRImmdP6moSOA2ItI2KlG5T0q4/R5genaYkEE+WlZkpeIOO+LgNC5HoqiOixvVLebNk/5JlNrGOXdW+SsV+2vfCyluY+wvBjM8B7wlwwdLMZQQt3F4lAQkS2IIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjrpvNVd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769805454; x=1801341454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oyYyl/3tzRz6bgIlUzjXdXzpWFXNTALSND9eRqESxCg=;
  b=MjrpvNVdbMfvxuyCveemzOWUb75s9yZs23YIKauc715SUIVGuBIvOXMd
   v50yR/tr1WoMS+d3bWi9fkOGUX+h1H20iFxGmLJuZx7D2VNY/Rgwsti6m
   8tRXx6NijULAPgNRGUNEIb+iTw1SecII2HPyasXFXR0Nw0AHy8yq8FLB0
   gdAd4wpD6ouYtOK/qeOTkrZpwJi9H15prd1yzRC4oyma6kULRU26E2eMJ
   oEs0JuaJhxtru7L8bN50STAfhwkGog3e4MMgIGkVmPEpJB0UeFrsekL39
   ELzs22s65VmR6YtweXhXIr10Dmtt98k/vDMOeic8rucW7u6xyMy86cOsP
   w==;
X-CSE-ConnectionGUID: sgCB7qEbSWyF/SFlM83m/Q==
X-CSE-MsgGUID: KsutD8YASZGEud3PwZY81g==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71098024"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="71098024"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 12:37:33 -0800
X-CSE-ConnectionGUID: H+oLySCaRWKJOz7BqmUbuQ==
X-CSE-MsgGUID: jFCgHKmpRKiD9ohcblL71g==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 30 Jan 2026 12:37:30 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlvF9-00000000dKy-33wx;
	Fri, 30 Jan 2026 20:37:27 +0000
Date: Sat, 31 Jan 2026 04:37:06 +0800
From: kernel test robot <lkp@intel.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, peter.ujfalusi@gmail.com,
	vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	vigneshr@ti.com
Cc: oe-kbuild-all@lists.linux.dev, r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v4 19/19] dmaengine: ti: k3-udma: switch to synchronous
 descriptor freeing
Message-ID: <202601310444.S9H39g4c-lkp@intel.com>
References: <20260130110159.359501-20-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130110159.359501-20-s-adivi@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8633-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[ti.com,gmail.com,kernel.org,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 3B4EFBE72E
X-Rspamd-Action: no action

Hi Sai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on next-20260130]
[cannot apply to linus/master v6.19-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sai-Sree-Kartheek-Adivi/dmaengine-ti-k3-udma-move-macros-to-header-file/20260130-191306
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20260130110159.359501-20-s-adivi%40ti.com
patch subject: [PATCH v4 19/19] dmaengine: ti: k3-udma: switch to synchronous descriptor freeing
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20260131/202601310444.S9H39g4c-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260131/202601310444.S9H39g4c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601310444.S9H39g4c-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/ti/k3-udma-common.c: In function 'udma_desc_free':
>> drivers/dma/ti/k3-udma-common.c:103:23: warning: unused variable 'flags' [-Wunused-variable]
     103 |         unsigned long flags;
         |                       ^~~~~
>> drivers/dma/ti/k3-udma-common.c:100:26: warning: unused variable 'ud' [-Wunused-variable]
     100 |         struct udma_dev *ud = to_udma_dev(vd->tx.chan->device);
         |                          ^~


vim +/flags +103 drivers/dma/ti/k3-udma-common.c

f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30   97  
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30   98  void udma_desc_free(struct virt_dma_desc *vd)
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30   99  {
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30 @100  	struct udma_dev *ud = to_udma_dev(vd->tx.chan->device);
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  101  	struct udma_chan *uc = to_udma_chan(vd->tx.chan);
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  102  	struct udma_desc *d = to_udma_desc(&vd->tx);
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30 @103  	unsigned long flags;
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  104  
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  105  	if (uc->terminated_desc == d)
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  106  		uc->terminated_desc = NULL;
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  107  
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  108  	udma_free_hwdesc(uc, d);
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  109  	kfree(d);
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  110  	return;
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  111  }
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  112  EXPORT_SYMBOL_GPL(udma_desc_free);
f30a784b467d1f Sai Sree Kartheek Adivi 2026-01-30  113  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

