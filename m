Return-Path: <dmaengine+bounces-3053-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A1896735A
	for <lists+dmaengine@lfdr.de>; Sat, 31 Aug 2024 23:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A671C2106B
	for <lists+dmaengine@lfdr.de>; Sat, 31 Aug 2024 21:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70D5171644;
	Sat, 31 Aug 2024 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlMV6wCB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8414B964;
	Sat, 31 Aug 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725139945; cv=none; b=GVEA3iM4TLySe6+LXqsJPeofFUTBgLyh1gKdInzrXaJkNsRbGh5tfWb4s/iIjiOm2gnGMa2oogka40QVWb0rI5wLaR9lPBz296k6rW0Yusz9s7i0S+hNCctI4D1scLvhPJ125NIiMgJrAjnAZCo4ReShGcUPsEX+a/LeA+pdMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725139945; c=relaxed/simple;
	bh=KMpYehZT6hWvW6eVl/T1MSre1Q/lDbOBJgrmiL261U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFDArGqte6ZtzbQTnaAq81BgsrHyEMU9gYORbbfbxTyDZ5xaUSh0OVixpzrde51MERVmserE/V0qWKaSPszbPSH0+Memukl7EUlI0fMNtj5kYtNCkFxEpuImc/ARHCATIDKNjPS8UWSDe1fyJq4ton+QAMzz+USTZAeMnnuazGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlMV6wCB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725139943; x=1756675943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KMpYehZT6hWvW6eVl/T1MSre1Q/lDbOBJgrmiL261U8=;
  b=XlMV6wCBgDHx9zvc5sOOelqEs0ssHChwIk19DgwN6qKD3lPtFnTjKK6Y
   l3nYRFK3A3HIPEIJ1d/FOjgUJRnIwJPd6KzfHBnkKHTk4Gggv5iSAnb3s
   W4sofjW9JqM95JVZFbdJt38WeJKH7ZggfRibVmse3HewspJP05xCtIiiT
   aeRXWRcllZL2d9KAocHgR8uuVRNRVA2WSzuuRitmUQ2eO3vqGkpyNcX7n
   XTdnO0r9OtnIzNDYsaU6nBIlUcJMwJGgJ6wEINeN7/PuaSPFk5932OmYL
   IMCa23KFtO2lkBtq2UtWROgm6L0PIyrdyePSyu2AIQDEJBHbKmbU0wiiB
   Q==;
X-CSE-ConnectionGUID: pIQHrDKlRPWfqBXo2pMd1Q==
X-CSE-MsgGUID: 58d//2s5T+igrqszAWve7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="13313616"
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="13313616"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 14:32:23 -0700
X-CSE-ConnectionGUID: bBrih1qVSKC4RBG583x1wg==
X-CSE-MsgGUID: EYtBiK9MQ2y9r1KZDG18tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="68354126"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 31 Aug 2024 14:32:21 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skVhi-000398-3A;
	Sat, 31 Aug 2024 21:32:18 +0000
Date: Sun, 1 Sep 2024 05:31:54 +0800
From: kernel test robot <lkp@intel.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>, vkoul@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: Re: [PATCH v2 1/7] dmaengine:Add COMPILE_TEST for easy testing
Message-ID: <202409010519.GDhNqskE-lkp@intel.com>
References: <20240830094118.15458-2-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830094118.15458-2-liaoyuanhong@vivo.com>

Hi Liao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on shawnguo/for-next soc/for-next linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liao-Yuanhong/dmaengine-Add-COMPILE_TEST-for-easy-testing/20240830-174451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20240830094118.15458-2-liaoyuanhong%40vivo.com
patch subject: [PATCH v2 1/7] dmaengine:Add COMPILE_TEST for easy testing
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240901/202409010519.GDhNqskE-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409010519.GDhNqskE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409010519.GDhNqskE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from drivers/dma/at_hdmac.c:16:
   drivers/dma/at_hdmac.c: In function 'atc_prep_dma_interleaved':
>> drivers/dma/at_hdmac.c:890:18: warning: format '%d' expects argument of type 'int', but argument 6 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     890 |                  "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:160:58: note: in expansion of macro 'dev_fmt'
     160 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/dma/at_hdmac.c:889:9: note: in expansion of macro 'dev_info'
     889 |         dev_info(chan2dev(chan),
         |         ^~~~~~~~
   drivers/dma/at_hdmac.c:890:50: note: format string is defined here
     890 |                  "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
         |                                                 ~^
         |                                                  |
         |                                                  int
         |                                                 %ld
   drivers/dma/at_hdmac.c:890:18: warning: format '%d' expects argument of type 'int', but argument 7 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     890 |                  "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:160:58: note: in expansion of macro 'dev_fmt'
     160 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/dma/at_hdmac.c:889:9: note: in expansion of macro 'dev_info'
     889 |         dev_info(chan2dev(chan),
         |         ^~~~~~~~
   drivers/dma/at_hdmac.c:890:65: note: format string is defined here
     890 |                  "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
         |                                                                ~^
         |                                                                 |
         |                                                                 int
         |                                                                %ld
   In file included from include/linux/printk.h:574,
                    from include/linux/kernel.h:31,
                    from include/linux/clk.h:13,
                    from drivers/dma/at_hdmac.c:15:
   drivers/dma/at_hdmac.c: In function 'atc_prep_dma_memset_sg':
>> drivers/dma/at_hdmac.c:1177:34: warning: format '%zx' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]
    1177 |         dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%zx f0x%lx\n", __func__,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:30: note: in expansion of macro 'dev_fmt'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   include/linux/dev_printk.h:261:25: note: in expansion of macro 'dev_dbg'
     261 | #define dev_vdbg        dev_dbg
         |                         ^~~~~~~
   drivers/dma/at_hdmac.c:1177:9: note: in expansion of macro 'dev_vdbg'
    1177 |         dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%zx f0x%lx\n", __func__,
         |         ^~~~~~~~
   drivers/dma/at_hdmac.c:1177:50: note: format string is defined here
    1177 |         dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%zx f0x%lx\n", __func__,
         |                                                ~~^
         |                                                  |
         |                                                  long unsigned int
         |                                                %x
   drivers/dma/at_hdmac.c: In function 'atc_prep_dma_cyclic':
   drivers/dma/at_hdmac.c:1506:34: warning: format '%d' expects argument of type 'int', but argument 7 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
    1506 |         dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%d/%d)\n",
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:30: note: in expansion of macro 'dev_fmt'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   include/linux/dev_printk.h:261:25: note: in expansion of macro 'dev_dbg'
     261 | #define dev_vdbg        dev_dbg
         |                         ^~~~~~~
   drivers/dma/at_hdmac.c:1506:9: note: in expansion of macro 'dev_vdbg'
    1506 |         dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%d/%d)\n",
         |         ^~~~~~~~
   drivers/dma/at_hdmac.c:1506:71: note: format string is defined here
    1506 |         dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%d/%d)\n",
         |                                                                      ~^
         |                                                                       |
         |                                                                       int
         |                                                                      %ld
   drivers/dma/at_hdmac.c:1506:34: warning: format '%d' expects argument of type 'int', but argument 8 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
    1506 |         dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%d/%d)\n",
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:30: note: in expansion of macro 'dev_fmt'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   include/linux/dev_printk.h:261:25: note: in expansion of macro 'dev_dbg'
     261 | #define dev_vdbg        dev_dbg
         |                         ^~~~~~~
   drivers/dma/at_hdmac.c:1506:9: note: in expansion of macro 'dev_vdbg'
    1506 |         dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%d/%d)\n",
         |         ^~~~~~~~
   drivers/dma/at_hdmac.c:1506:74: note: format string is defined here
    1506 |         dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%d/%d)\n",
         |                                                                         ~^
         |                                                                          |
         |                                                                          int
         |                                                                         %ld


vim +890 drivers/dma/at_hdmac.c

dc78baa2b90b28 Nicolas Ferre       2009-07-03  858  
dc78baa2b90b28 Nicolas Ferre       2009-07-03  859  /*--  DMA Engine API  --------------------------------------------------*/
5abecfa5e96972 Maxime Ripard       2015-05-27  860  /**
5abecfa5e96972 Maxime Ripard       2015-05-27  861   * atc_prep_dma_interleaved - prepare memory to memory interleaved operation
5abecfa5e96972 Maxime Ripard       2015-05-27  862   * @chan: the channel to prepare operation on
5abecfa5e96972 Maxime Ripard       2015-05-27  863   * @xt: Interleaved transfer template
5abecfa5e96972 Maxime Ripard       2015-05-27  864   * @flags: tx descriptor status flags
5abecfa5e96972 Maxime Ripard       2015-05-27  865   */
5abecfa5e96972 Maxime Ripard       2015-05-27  866  static struct dma_async_tx_descriptor *
5abecfa5e96972 Maxime Ripard       2015-05-27  867  atc_prep_dma_interleaved(struct dma_chan *chan,
5abecfa5e96972 Maxime Ripard       2015-05-27  868  			 struct dma_interleaved_template *xt,
5abecfa5e96972 Maxime Ripard       2015-05-27  869  			 unsigned long flags)
5abecfa5e96972 Maxime Ripard       2015-05-27  870  {
ac803b56860f65 Tudor Ambarus       2022-10-25  871  	struct at_dma		*atdma = to_at_dma(chan->device);
5abecfa5e96972 Maxime Ripard       2015-05-27  872  	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
62a277d43d47e7 Gustavo A. R. Silva 2017-11-20  873  	struct data_chunk	*first;
ac803b56860f65 Tudor Ambarus       2022-10-25  874  	struct atdma_sg		*atdma_sg;
ac803b56860f65 Tudor Ambarus       2022-10-25  875  	struct at_desc		*desc;
ac803b56860f65 Tudor Ambarus       2022-10-25  876  	struct at_lli		*lli;
5abecfa5e96972 Maxime Ripard       2015-05-27  877  	size_t			xfer_count;
5abecfa5e96972 Maxime Ripard       2015-05-27  878  	unsigned int		dwidth;
5abecfa5e96972 Maxime Ripard       2015-05-27  879  	u32			ctrla;
5abecfa5e96972 Maxime Ripard       2015-05-27  880  	u32			ctrlb;
5abecfa5e96972 Maxime Ripard       2015-05-27  881  	size_t			len = 0;
5abecfa5e96972 Maxime Ripard       2015-05-27  882  	int			i;
5abecfa5e96972 Maxime Ripard       2015-05-27  883  
4483320e241c5f Maninder Singh      2015-06-26  884  	if (unlikely(!xt || xt->numf != 1 || !xt->frame_size))
4483320e241c5f Maninder Singh      2015-06-26  885  		return NULL;
4483320e241c5f Maninder Singh      2015-06-26  886  
62a277d43d47e7 Gustavo A. R. Silva 2017-11-20  887  	first = xt->sgl;
62a277d43d47e7 Gustavo A. R. Silva 2017-11-20  888  
5abecfa5e96972 Maxime Ripard       2015-05-27  889  	dev_info(chan2dev(chan),
2c5d7407e01272 Arnd Bergmann       2015-11-12 @890  		 "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
2c5d7407e01272 Arnd Bergmann       2015-11-12  891  		__func__, &xt->src_start, &xt->dst_start, xt->numf,
5abecfa5e96972 Maxime Ripard       2015-05-27  892  		xt->frame_size, flags);
5abecfa5e96972 Maxime Ripard       2015-05-27  893  
5abecfa5e96972 Maxime Ripard       2015-05-27  894  	/*
5abecfa5e96972 Maxime Ripard       2015-05-27  895  	 * The controller can only "skip" X bytes every Y bytes, so we
5abecfa5e96972 Maxime Ripard       2015-05-27  896  	 * need to make sure we are given a template that fit that
5abecfa5e96972 Maxime Ripard       2015-05-27  897  	 * description, ie a template with chunks that always have the
5abecfa5e96972 Maxime Ripard       2015-05-27  898  	 * same size, with the same ICGs.
5abecfa5e96972 Maxime Ripard       2015-05-27  899  	 */
5abecfa5e96972 Maxime Ripard       2015-05-27  900  	for (i = 0; i < xt->frame_size; i++) {
5abecfa5e96972 Maxime Ripard       2015-05-27  901  		struct data_chunk *chunk = xt->sgl + i;
5abecfa5e96972 Maxime Ripard       2015-05-27  902  
5abecfa5e96972 Maxime Ripard       2015-05-27  903  		if ((chunk->size != xt->sgl->size) ||
5abecfa5e96972 Maxime Ripard       2015-05-27  904  		    (dmaengine_get_dst_icg(xt, chunk) != dmaengine_get_dst_icg(xt, first)) ||
5abecfa5e96972 Maxime Ripard       2015-05-27  905  		    (dmaengine_get_src_icg(xt, chunk) != dmaengine_get_src_icg(xt, first))) {
5abecfa5e96972 Maxime Ripard       2015-05-27  906  			dev_err(chan2dev(chan),
5abecfa5e96972 Maxime Ripard       2015-05-27  907  				"%s: the controller can transfer only identical chunks\n",
5abecfa5e96972 Maxime Ripard       2015-05-27  908  				__func__);
5abecfa5e96972 Maxime Ripard       2015-05-27  909  			return NULL;
5abecfa5e96972 Maxime Ripard       2015-05-27  910  		}
5abecfa5e96972 Maxime Ripard       2015-05-27  911  
5abecfa5e96972 Maxime Ripard       2015-05-27  912  		len += chunk->size;
5abecfa5e96972 Maxime Ripard       2015-05-27  913  	}
5abecfa5e96972 Maxime Ripard       2015-05-27  914  
ac803b56860f65 Tudor Ambarus       2022-10-25  915  	dwidth = atc_get_xfer_width(xt->src_start, xt->dst_start, len);
5abecfa5e96972 Maxime Ripard       2015-05-27  916  
5abecfa5e96972 Maxime Ripard       2015-05-27  917  	xfer_count = len >> dwidth;
5abecfa5e96972 Maxime Ripard       2015-05-27  918  	if (xfer_count > ATC_BTSIZE_MAX) {
5abecfa5e96972 Maxime Ripard       2015-05-27  919  		dev_err(chan2dev(chan), "%s: buffer is too big\n", __func__);
5abecfa5e96972 Maxime Ripard       2015-05-27  920  		return NULL;
5abecfa5e96972 Maxime Ripard       2015-05-27  921  	}
5abecfa5e96972 Maxime Ripard       2015-05-27  922  
d8840a7edcf0aa Tudor Ambarus       2022-10-25  923  	ctrla = FIELD_PREP(ATC_SRC_WIDTH, dwidth) |
d8840a7edcf0aa Tudor Ambarus       2022-10-25  924  		FIELD_PREP(ATC_DST_WIDTH, dwidth);
5abecfa5e96972 Maxime Ripard       2015-05-27  925  
d8840a7edcf0aa Tudor Ambarus       2022-10-25  926  	ctrlb = ATC_DEFAULT_CTRLB | ATC_IEN |
d8840a7edcf0aa Tudor Ambarus       2022-10-25  927  		FIELD_PREP(ATC_SRC_ADDR_MODE, ATC_SRC_ADDR_MODE_INCR) |
d8840a7edcf0aa Tudor Ambarus       2022-10-25  928  		FIELD_PREP(ATC_DST_ADDR_MODE, ATC_DST_ADDR_MODE_INCR) |
d8840a7edcf0aa Tudor Ambarus       2022-10-25  929  		ATC_SRC_PIP | ATC_DST_PIP |
d8840a7edcf0aa Tudor Ambarus       2022-10-25  930  		FIELD_PREP(ATC_FC, ATC_FC_MEM2MEM);
5abecfa5e96972 Maxime Ripard       2015-05-27  931  
ac803b56860f65 Tudor Ambarus       2022-10-25  932  	desc = kzalloc(struct_size(desc, sg, 1), GFP_ATOMIC);
ac803b56860f65 Tudor Ambarus       2022-10-25  933  	if (!desc)
ac803b56860f65 Tudor Ambarus       2022-10-25  934  		return NULL;
ac803b56860f65 Tudor Ambarus       2022-10-25  935  	desc->sglen = 1;
ac803b56860f65 Tudor Ambarus       2022-10-25  936  
ac803b56860f65 Tudor Ambarus       2022-10-25  937  	atdma_sg = desc->sg;
ac803b56860f65 Tudor Ambarus       2022-10-25  938  	atdma_sg->lli = dma_pool_alloc(atdma->lli_pool, GFP_NOWAIT,
ac803b56860f65 Tudor Ambarus       2022-10-25  939  				       &atdma_sg->lli_phys);
ac803b56860f65 Tudor Ambarus       2022-10-25  940  	if (!atdma_sg->lli) {
ac803b56860f65 Tudor Ambarus       2022-10-25  941  		kfree(desc);
5abecfa5e96972 Maxime Ripard       2015-05-27  942  		return NULL;
5abecfa5e96972 Maxime Ripard       2015-05-27  943  	}
ac803b56860f65 Tudor Ambarus       2022-10-25  944  	lli = atdma_sg->lli;
5abecfa5e96972 Maxime Ripard       2015-05-27  945  
ac803b56860f65 Tudor Ambarus       2022-10-25  946  	lli->saddr = xt->src_start;
ac803b56860f65 Tudor Ambarus       2022-10-25  947  	lli->daddr = xt->dst_start;
ac803b56860f65 Tudor Ambarus       2022-10-25  948  	lli->ctrla = ctrla | xfer_count;
ac803b56860f65 Tudor Ambarus       2022-10-25  949  	lli->ctrlb = ctrlb;
5abecfa5e96972 Maxime Ripard       2015-05-27  950  
5abecfa5e96972 Maxime Ripard       2015-05-27  951  	desc->boundary = first->size >> dwidth;
5abecfa5e96972 Maxime Ripard       2015-05-27  952  	desc->dst_hole = (dmaengine_get_dst_icg(xt, first) >> dwidth) + 1;
5abecfa5e96972 Maxime Ripard       2015-05-27  953  	desc->src_hole = (dmaengine_get_src_icg(xt, first) >> dwidth) + 1;
5abecfa5e96972 Maxime Ripard       2015-05-27  954  
ac803b56860f65 Tudor Ambarus       2022-10-25  955  	atdma_sg->len = len;
ac803b56860f65 Tudor Ambarus       2022-10-25  956  	desc->total_len = len;
5abecfa5e96972 Maxime Ripard       2015-05-27  957  
ac803b56860f65 Tudor Ambarus       2022-10-25  958  	set_lli_eol(desc, 0);
ac803b56860f65 Tudor Ambarus       2022-10-25  959  	return vchan_tx_prep(&atchan->vc, &desc->vd, flags);
5abecfa5e96972 Maxime Ripard       2015-05-27  960  }
5abecfa5e96972 Maxime Ripard       2015-05-27  961  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

