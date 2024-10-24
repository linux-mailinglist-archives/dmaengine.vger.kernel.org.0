Return-Path: <dmaengine+bounces-3507-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A78A9AF04C
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FA7282973
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F62003CC;
	Thu, 24 Oct 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zy0umdYn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A1215F71
	for <dmaengine@vger.kernel.org>; Thu, 24 Oct 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796418; cv=none; b=DT2EfVNfQ8WHKGk5b5x4NittIqwVlgnSzajEwI5N2ZczottzmALvS0WxBXQlUQvPnbGLJMlxwZyJPns/OL0EI9qTHnu7Qks/jXs83F6XRn8QzifWH+849aARCFaJOlB+6NE3yS4hxtz0yt+WpUvco7DDUKPlL+88m/hzPNIXTNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796418; c=relaxed/simple;
	bh=r1ly9Ov9pSe4dejCsvHjf0/4gj1FQ8q93E1ce+k0Rgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyKmdZrxE8Kwa9witJMSHBuXh6QQFxNeWNjBajceY28yugpMk6bwDTWftlcbDSCUCU6fkPs7XRGUADeiQimkqiCOpEh4EwBUsEsf9bDA6GuBES5NSCOr2XfxYQ7ikODSq4FP8gP/TqwyiQNp5UZ2E2ujIJj8Qe20ri0Ey7bWz9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zy0umdYn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729796416; x=1761332416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r1ly9Ov9pSe4dejCsvHjf0/4gj1FQ8q93E1ce+k0Rgw=;
  b=Zy0umdYn4NLo4H797Eye/cVR9RHWgIT+JDL3p5PzMMKnHh4AEmYv5imn
   Ats3wioMlGobZ+Fm9HzDWMs10j0nrbgKs11ohnTkewHNbfDQsVvvCxE1j
   zX68DSkECtgOy5uVuYFzPkxgH5/U9E7SShrwPp20T7jSruux3TSwAdnmB
   Wx72/ue0jIGr5vbpAiZzM1RJH0KUBqOBGxWHQZDcsOllYFn5TiFPiUhf/
   QK7Gg+ZGEjXcM53VLG/w3IHbO+Jp8vOuZlxO3ojfNnMCys8KF8/fw6y5h
   V4v8raCCne7k44sdCCBPvPVBBzM/dUf59j9BGFy+X66nYmo5Im2C+MNN6
   Q==;
X-CSE-ConnectionGUID: Kago0farRq2XRBhbUyacKQ==
X-CSE-MsgGUID: fUlY7SU9Ts6bPWuTUE409g==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40066954"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="40066954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:00:15 -0700
X-CSE-ConnectionGUID: DdmIFQjYRKmtV6HOqB8Wsg==
X-CSE-MsgGUID: id03hHfSRTewlGoj18b2RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="104001041"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 24 Oct 2024 12:00:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4346-000Wsy-2W;
	Thu, 24 Oct 2024 19:00:10 +0000
Date: Fri, 25 Oct 2024 02:59:59 +0800
From: kernel test robot <lkp@intel.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org,
	dmaengine@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Raju.Rangoju@amd.com, Frank.li@nxp.com,
	helgaas@kernel.org, pstanner@redhat.com,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH v7 4/6] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
Message-ID: <202410250208.b82S9dvv-lkp@intel.com>
References: <20241023123613.710671-5-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023123613.710671-5-Basavaraj.Natikar@amd.com>

Hi Basavaraj,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Basavaraj-Natikar/dmaengine-Move-AMD-PTDMA-driver-to-amd-directory/20241023-203903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20241023123613.710671-5-Basavaraj.Natikar%40amd.com
patch subject: [PATCH v7 4/6] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
config: x86_64-buildonly-randconfig-004-20241024 (https://download.01.org/0day-ci/archive/20241025/202410250208.b82S9dvv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250208.b82S9dvv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250208.b82S9dvv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma/amd/ptdma/ptdma-dmaengine.c: In function 'ae4_core_execute_cmd':
>> drivers/dma/amd/ptdma/ptdma-dmaengine.c:115:20: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     115 |         bool soc = FIELD_GET(DWORD0_SOC, desc->dwouv.dw0);
         |                    ^~~~~~~~~
>> drivers/dma/amd/ptdma/ptdma-dmaengine.c:119:36: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     119 |                 desc->dwouv.dw0 |= FIELD_PREP(DWORD0_IOC, desc->dwouv.dw0);
         |                                    ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_GET +115 drivers/dma/amd/ptdma/ptdma-dmaengine.c

   112	
   113	static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct ae4_cmd_queue *ae4cmd_q)
   114	{
 > 115		bool soc = FIELD_GET(DWORD0_SOC, desc->dwouv.dw0);
   116		struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
   117	
   118		if (soc) {
 > 119			desc->dwouv.dw0 |= FIELD_PREP(DWORD0_IOC, desc->dwouv.dw0);
   120			desc->dwouv.dw0 &= ~DWORD0_SOC;
   121		}
   122	
   123		mutex_lock(&ae4cmd_q->cmd_lock);
   124		memcpy(&cmd_q->qbase[ae4cmd_q->tail_wi], desc, sizeof(struct ae4dma_desc));
   125		ae4cmd_q->q_cmd_count++;
   126		ae4cmd_q->tail_wi = (ae4cmd_q->tail_wi + 1) % CMD_Q_LEN;
   127		writel(ae4cmd_q->tail_wi, cmd_q->reg_control + AE4_WR_IDX_OFF);
   128		mutex_unlock(&ae4cmd_q->cmd_lock);
   129	
   130		wake_up(&ae4cmd_q->q_w);
   131	
   132		return 0;
   133	}
   134	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

