Return-Path: <dmaengine+bounces-6762-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5535BB7C65
	for <lists+dmaengine@lfdr.de>; Fri, 03 Oct 2025 19:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3AF24E3533
	for <lists+dmaengine@lfdr.de>; Fri,  3 Oct 2025 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AF42DAFA3;
	Fri,  3 Oct 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRmDK+Ar"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E12D9EE8;
	Fri,  3 Oct 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513007; cv=none; b=GpPW/4v2vrRoEcf9am2GdsJ0bN8wSvyb+rPxiEG4nrEk5MsNIC3/fTKyZ0v2WaIBflJMk3oykDDK5WcmTWeYiHBzLgFfdquuAJ5cHItyYnk5YCtEnQ1NiF1ymhjejqrWlUm6Rk4zWDSP5Z6guqjLaW4W6Gw94yGaldbp3iWOTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513007; c=relaxed/simple;
	bh=BHHbUn7IgOD3HnvXRVp4HvLqs+/mElLYucKSLR9r09g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0/6DLOFhDibqd/F/VLKuqdfM4Qzi3zM7zq4Kvl2EyodTh/Ozpq2QLI/y0KqVOBpQ0Nz5HIYBKHDXDl+wx06+NsC71sL7z1uB3Im/sRbeSTL9RF3YRwOITLHLjr+ja8Savg+FfLoY6MeXt5r7ObwuwITluuBYx6GOiBdIXJIgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRmDK+Ar; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759513006; x=1791049006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BHHbUn7IgOD3HnvXRVp4HvLqs+/mElLYucKSLR9r09g=;
  b=HRmDK+ArB5mSkeQI2K5MXqcYEOEggqude+f/VdBGuLhswCPgN9tK7ghx
   xjpRdahd6q/0PuMXyb/g49GG17YDWUQlwKssSyAhSNfZD/XMobFg+vRbR
   xOKwATEIIqcBpBF91QAsyexaHZ6oIEOYlQWw8czbchhqSA+GXq+MzWRYV
   APj0CRmUEFQ2xRYOo/KjKlg3c7/vZrgAvSrjKlSLWolo+uMZt4O+mDEYT
   7A8TqMVfHTCnjLm+IeAH+XK0KO/HIOF3TNXxgm6CZntAxoLIyekPjtbgI
   Tuh/mcibdTuqPK05o8l3jgVUHeDvxeHvE4Zh+eQ4A8SM3u1hG6hAoJ252
   w==;
X-CSE-ConnectionGUID: 0ogv7XjxTMenrkVY+SxWQw==
X-CSE-MsgGUID: KMEx3WR/TmO4V+shHUr7UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="64413725"
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="64413725"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 10:36:45 -0700
X-CSE-ConnectionGUID: /Mg3AC7TTB+jdt9gYP48Ug==
X-CSE-MsgGUID: Lqm3yPECSZKINHHAyXMNQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="210016118"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Oct 2025 10:36:41 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4jhv-0004mB-2b;
	Fri, 03 Oct 2025 17:36:39 +0000
Date: Sat, 4 Oct 2025 01:36:31 +0800
From: kernel test robot <lkp@intel.com>
To: CL Wang <cl634@andestech.com>, vkoul@kernel.org,
	dmaengine@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	tim609@andestech.com
Subject: Re: [PATCH V1 2/2] dmaengine: atcdmac300: Add driver for Andes
 ATCDMAC300 DMA controller
Message-ID: <202510040111.2VVT6u6C-lkp@intel.com>
References: <20251002131659.973955-3-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002131659.973955-3-cl634@andestech.com>

Hi CL,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.17 next-20251003]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/CL-Wang/dt-bindings-dmaengine-Add-support-for-ATCDMAC300-DMA-engine/20251002-212152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20251002131659.973955-3-cl634%40andestech.com
patch subject: [PATCH V1 2/2] dmaengine: atcdmac300: Add driver for Andes ATCDMAC300 DMA controller
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20251004/202510040111.2VVT6u6C-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251004/202510040111.2VVT6u6C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510040111.2VVT6u6C-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:3:
   In file included from include/linux/compiler_types.h:171:
   include/linux/compiler-clang.h:28:9: warning: '__SANITIZE_ADDRESS__' macro redefined [-Wmacro-redefined]
      28 | #define __SANITIZE_ADDRESS__
         |         ^
   <built-in>:371:9: note: previous definition is here
     371 | #define __SANITIZE_ADDRESS__ 1
         |         ^
>> drivers/dma/atcdmac300.c:772:9: warning: variable 'total_len' set but not used [-Wunused-but-set-variable]
     772 |         size_t total_len = 0;
         |                ^
   drivers/dma/atcdmac300.c:887:9: warning: variable 'total_len' set but not used [-Wunused-but-set-variable]
     887 |         size_t total_len = 0;
         |                ^
   3 warnings generated.
--
>> Warning: drivers/dma/atcdmac300.c:695 function parameter 'dst' not described in 'atcdmac_prep_dma_memcpy'


vim +/total_len +772 drivers/dma/atcdmac300.c

   676	
   677	/**
   678	 * atcdmac_prep_dma_memcpy - Prepare a DMA memcpy operation for the specified
   679	 *                           channel
   680	 * @chan: DMA channel to configure for the operation
   681	 * @dest: Physical destination address for the transfer
   682	 * @src: Physical source address for the transfer
   683	 * @len: Size of the data to transfer, in bytes
   684	 * @flags: Status flags for the transfer descriptor
   685	 *
   686	 * This function sets up a DMA memcpy operation to transfer data from the
   687	 * specified source address to the destination address. It returns a DMA
   688	 * descriptor that represents the configured transaction.
   689	 */
   690	static struct dma_async_tx_descriptor *
   691	atcdmac_prep_dma_memcpy(struct dma_chan *chan,
   692				dma_addr_t dst,
   693				dma_addr_t src,
   694				size_t len,
 > 695				unsigned long flags)
   696	{
   697		struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(chan);
   698		struct atcdmac_dmac *dmac = atcdmac_dev_to_dmac(chan->device);
   699		struct atcdmac_desc *desc;
   700		unsigned int src_width;
   701		unsigned int dst_width;
   702		unsigned int ctrl;
   703		unsigned char src_max_burst;
   704	
   705		if (unlikely(!len)) {
   706			dev_warn(atcdmac_chan_to_dev(chan),
   707				 "Failed to prepare DMA operation: len is zero\n");
   708			return NULL;
   709		}
   710	
   711		if (dmac->regmap_iocp) {
   712			dst |= IOCP_MASK;
   713			src |= IOCP_MASK;
   714		}
   715		src_max_burst =
   716			atcdmac_convert_burst((unsigned int)SRC_BURST_SIZE_1024);
   717		src_width = atcdmac_map_tran_width(src,
   718						   dst,
   719						   len,
   720						   1 << dmac->data_width);
   721		dst_width = src_width;
   722		ctrl = SRC_BURST_SIZE(src_max_burst) |
   723		       SRC_ADDR_MODE_INCR |
   724		       DST_ADDR_MODE_INCR |
   725		       DST_WIDTH(dst_width) |
   726		       SRC_WIDTH(src_width);
   727	
   728		desc = atcdmac_build_desc(dmac_chan, src, dst, ctrl,
   729					  len >> src_width, 1);
   730		if (!desc)
   731			goto err_desc_get;
   732	
   733		return &desc->txd;
   734	
   735	err_desc_get:
   736		dev_warn(atcdmac_chan_to_dev(chan), "Failed to allocate descriptor\n");
   737		return NULL;
   738	}
   739	
   740	/**
   741	 * atcdmac_prep_device_sg - Prepare descriptors for memory/device DMA
   742	 *                          transactions
   743	 * @chan: DMA channel to configure for the operation
   744	 * @sgl: Scatter-gather list representing the memory regions to transfer
   745	 * @sg_len: Number of entries in the scatter-gather list
   746	 * @direction: Direction of the DMA transfer
   747	 * @flags: Status flags for the transfer descriptor
   748	 * @context: transaction context (ignored)
   749	 *
   750	 * This function prepares a DMA transaction by setting up the required
   751	 * descriptors based on the provided scatter-gather list and parameters.
   752	 * It supports memory-to-device and device-to-memory DMA transfers.
   753	 */
   754	static struct dma_async_tx_descriptor *
   755	atcdmac_prep_device_sg(struct dma_chan *chan,
   756			       struct scatterlist *sgl,
   757			       unsigned int sg_len,
   758			       enum dma_transfer_direction direction,
   759			       unsigned long flags,
   760			       void *context)
   761	{
   762		struct atcdmac_dmac *dmac = atcdmac_dev_to_dmac(chan->device);
   763		struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(chan);
   764		struct dma_slave_config *sconfig = &dmac_chan->dma_sconfig;
   765		struct atcdmac_desc *first;
   766		struct scatterlist *sg;
   767		dma_addr_t reg;
   768		unsigned int i;
   769		unsigned int width_src;
   770		unsigned int width_dst;
   771		unsigned short burst_bytes;
 > 772		size_t total_len = 0;
   773	
   774		if (unlikely(!sg_len)) {
   775			dev_warn(atcdmac_chan_to_dev(chan), "sg_len is zero\n");
   776			return NULL;
   777		}
   778	
   779		if (direction == DMA_MEM_TO_DEV) {
   780			reg = sconfig->dst_addr;
   781			burst_bytes = sconfig->dst_addr_width * sconfig->dst_maxburst;
   782			width_dst = atcdmac_map_buswidth(sconfig->dst_addr_width);
   783			width_src = atcdmac_map_buswidth(sconfig->src_addr_width);
   784		} else if (direction == DMA_DEV_TO_MEM) {
   785			reg = sconfig->src_addr;
   786			burst_bytes = sconfig->src_addr_width * sconfig->src_maxburst;
   787			width_src = atcdmac_map_buswidth(sconfig->src_addr_width);
   788			width_dst = atcdmac_map_buswidth(sconfig->dst_addr_width);
   789		} else {
   790			dev_info(atcdmac_chan_to_dev(chan),
   791				 "Invalid transfer direction %d\n", direction);
   792			return NULL;
   793		}
   794	
   795		for_each_sg(sgl, sg, sg_len, i) {
   796			struct atcdmac_desc *prev, *desc;
   797			dma_addr_t mem;
   798			dma_addr_t src, dst;
   799			unsigned int width_cal;
   800			unsigned int len;
   801			unsigned int ctrl;
   802			unsigned short burst_size;
   803	
   804			mem = sg_dma_address(sg);
   805			len = sg_dma_len(sg);
   806			if (unlikely(!len)) {
   807				dev_info(atcdmac_chan_to_dev(chan),
   808					 "sg(%u) data len is zero\n", i);
   809				goto err;
   810			}
   811	
   812			if (dmac->regmap_iocp)
   813				mem |= IOCP_MASK;
   814	
   815			width_cal = atcdmac_map_tran_width(mem,
   816							   reg,
   817							   len,
   818							   (1 << dmac->data_width) |
   819							   burst_bytes);
   820			if (direction == DMA_MEM_TO_DEV) {
   821				if (burst_bytes < (1 << width_cal)) {
   822					burst_size = burst_bytes;
   823					width_cal = WIDTH_1_BYTE;
   824				} else {
   825					burst_size = burst_bytes / (1 << width_cal);
   826				}
   827	
   828				ctrl = SRC_ADDR_MODE_INCR | DST_ADDR_MODE_FIXED |
   829				       DST_HS | DST_REQ(dmac_chan->req_num) |
   830				       SRC_WIDTH(width_cal) | DST_WIDTH(width_dst) |
   831				       SRC_BURST_SIZE(ilog2(burst_size));
   832				src = mem;
   833				dst = reg;
   834			} else {
   835				burst_size = burst_bytes / sconfig->src_addr_width;
   836	
   837				ctrl = SRC_ADDR_MODE_FIXED | DST_ADDR_MODE_INCR |
   838				       SRC_HS | SRC_REQ(dmac_chan->req_num) |
   839				       SRC_WIDTH(width_src) | DST_WIDTH(width_cal) |
   840				       SRC_BURST_SIZE(ilog2(burst_size));
   841				src = reg;
   842				dst = mem;
   843				width_cal = width_src;
   844			}
   845	
   846			desc = atcdmac_build_desc(dmac_chan, src, dst, ctrl,
   847						  len >> width_cal, sg_len);
   848			if (!desc)
   849				goto err_desc_get;
   850	
   851			atcdmac_chain_desc(&first, &prev, desc, false);
   852			total_len += len;
   853		}
   854	
   855		first->txd.cookie = -EBUSY;
   856		first->txd.flags = flags;
   857	
   858		return &first->txd;
   859	
   860	err_desc_get:
   861		dev_warn(atcdmac_chan_to_dev(chan), "Failed to allocate descriptor\n");
   862	
   863	err:
   864		if (first)
   865			atcdmac_put_desc(dmac_chan, first);
   866		return NULL;
   867	}
   868	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

