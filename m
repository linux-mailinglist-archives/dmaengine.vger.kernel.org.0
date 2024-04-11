Return-Path: <dmaengine+bounces-1814-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A4B8A0703
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 06:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4E8285279
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 04:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F0913BC1A;
	Thu, 11 Apr 2024 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="er5LZgN/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277C13BC10;
	Thu, 11 Apr 2024 04:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712808912; cv=none; b=WH3xdjiuGlF5fjf/ga6R3HKZTMahTyZ22PE0IJZDCr5FDYeJrj/UPSA1eWu5ibkq0/STimnr01ymlcoBzcAidvsO1pMZ/JxPiw7rlLzwgfW7BZnV+SQ9zllO3bOxfHSj6wbIK8jj7caVkIKRY5gCzTVJtNY6TRwhuuv70wXKnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712808912; c=relaxed/simple;
	bh=XpV+R2c0z4CAA3E0iveJbJWN8/bqkAicQ1JKilviGHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSEN1SEQdc3VqMC9k0JynMCJ4mjAvsoMFTe+/GFyIYeo2V3HPl+fm33FVfcsdUfu0eKHXIch1RIK42syrdhADcjKsyq/H2QsrisIASmm4iunx/ZZ385q4J928Eg7QYPfR53mIFQeRIj1EVwhdXfuAdrNFEg7csKw81p1F1kKSEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=er5LZgN/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712808911; x=1744344911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XpV+R2c0z4CAA3E0iveJbJWN8/bqkAicQ1JKilviGHQ=;
  b=er5LZgN/ICZVP9gU2hYOig7Y9Afkgty1e7WTZXb3ao/rhm45R2+5aYFE
   g1ceI/0PdkZBjPJLRhPyB25FRBccV66TYNSAVfUbK2l/25oZm1de30P3Z
   3dUSRUrCKvklRf8xP0/13VgJQWH0JEPQaR01FMx1BI741PzmbLEhn/ale
   etQ3/yZIEPdV9y7W5QyeuH02KBV2gXk9ioPm0bARsAnkaQn+OpQ/7hdTq
   xAwmDJ49pI1bqCkH8Q0Sb1N0g9+0ouj1HRqKJQARRDu2Qq3GxT3qqf2Zg
   DVzx4ppGbe4VikPNqZahR8FkJzqgCjVFRCyqOFJD0yQAJvSElxYpaWwbb
   g==;
X-CSE-ConnectionGUID: P9vKhGugRSasow9Xa9nW5Q==
X-CSE-MsgGUID: qts77Fi5Rk2yZz0cXBAPRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8310330"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8310330"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 21:15:10 -0700
X-CSE-ConnectionGUID: nHvTGs0qTWW7RD+6h+qcVA==
X-CSE-MsgGUID: yYu7QXkYQoKNkQiTLPtS6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25259613"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 Apr 2024 21:15:05 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rulq3-0008Cq-0S;
	Thu, 11 Apr 2024 04:15:03 +0000
Date: Thu, 11 Apr 2024 12:14:10 +0800
From: kernel test robot <lkp@intel.com>
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X
 dmamux
Message-ID: <202404111148.YVXpdPke-lkp@intel.com>
References: <IA1PR20MB495310B8E4D7A6705A112004BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495310B8E4D7A6705A112004BB062@IA1PR20MB4953.namprd20.prod.outlook.com>

Hi Inochi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on robh/for-next krzk-dt/for-next linus/master v6.9-rc3 next-20240410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Inochi-Amaoto/dt-bindings-dmaengine-Add-dma-multiplexer-for-CV18XX-SG200X-series-SoC/20240410-092207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/IA1PR20MB495310B8E4D7A6705A112004BB062%40IA1PR20MB4953.namprd20.prod.outlook.com
patch subject: [PATCH v7 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20240411/202404111148.YVXpdPke-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8b3b4a92adee40483c27f26c478a384cd69c6f05)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240411/202404111148.YVXpdPke-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404111148.YVXpdPke-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/dma/cv1800-dmamux.c:8:
   In file included from include/linux/of_dma.h:14:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/cv1800-dmamux.c:191:22: warning: unused variable 'dma_master' [-Wunused-variable]
     191 |         struct device_node *dma_master;
         |                             ^~~~~~~~~~
   6 warnings generated.


vim +/dma_master +191 drivers/dma/cv1800-dmamux.c

   183	
   184	static int cv1800_dmamux_probe(struct platform_device *pdev)
   185	{
   186		struct device *dev = &pdev->dev;
   187		struct device_node *mux_node = dev->of_node;
   188		struct cv1800_dmamux_data *data;
   189		struct cv1800_dmamux_map *tmp;
   190		struct device *parent = dev->parent;
 > 191		struct device_node *dma_master;
   192		struct regmap *regmap = NULL;
   193		unsigned int i;
   194	
   195		if (!parent)
   196			return -ENODEV;
   197	
   198		regmap = device_node_to_regmap(parent->of_node);
   199		if (IS_ERR(regmap))
   200			return PTR_ERR(regmap);
   201	
   202		data = devm_kmalloc(dev, sizeof(*data), GFP_KERNEL);
   203		if (!data)
   204			return -ENOMEM;
   205	
   206		spin_lock_init(&data->lock);
   207		init_llist_head(&data->free_maps);
   208	
   209		for (i = 0; i <= MAX_DMA_CH_ID; i++) {
   210			tmp = devm_kmalloc(dev, sizeof(*tmp), GFP_KERNEL);
   211			if (!tmp) {
   212				/* It is OK for not allocating all channel */
   213				dev_warn(dev, "can not allocate channel %u\n", i);
   214				continue;
   215			}
   216	
   217			init_llist_node(&tmp->node);
   218			tmp->channel = i;
   219			llist_add(&tmp->node, &data->free_maps);
   220		}
   221	
   222		/* if no channel is allocated, the probe must fail */
   223		if (llist_empty(&data->free_maps))
   224			return -ENOMEM;
   225	
   226		data->regmap = regmap;
   227		data->dmarouter.dev = dev;
   228		data->dmarouter.route_free = cv1800_dmamux_free;
   229	
   230		platform_set_drvdata(pdev, data);
   231	
   232		return of_dma_router_register(mux_node,
   233					      cv1800_dmamux_route_allocate,
   234					      &data->dmarouter);
   235	}
   236	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

