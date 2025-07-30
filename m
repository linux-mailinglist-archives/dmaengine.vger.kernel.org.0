Return-Path: <dmaengine+bounces-5910-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D749CB16479
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 18:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4743A2DFC
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19822DD61E;
	Wed, 30 Jul 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ij4zr65N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FCD51022
	for <dmaengine@vger.kernel.org>; Wed, 30 Jul 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892268; cv=none; b=pjkTgRWBQOuP7Yh3/4i5h6y83fVgrRjdIucShWHbNeI0SbsqN/ay5GArNdTh9D54TsTKp0Mc4tjIhF19iwB/Yxlw1FvIBhKDpflwnbpQZWfx+6t2Z6+OOG9lQp/P1doq+nLtJwMUaZvB4y7u1pV2fTy5m/KCU8HgDNhQqwdkrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892268; c=relaxed/simple;
	bh=+h6EzbbOHcJKfZOy57XdSPF1XXqiZxLUfRoHNrtoYmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3dYJl4138LuR833WUNXnlYtSdX04Rm0qj1sYB8OgDADw6ddUkR8SOlsQ4YA/e8TVd7SQPU3LlZMzvDZxv0rZ9XdUU4IV6wFONyYwblFXnFq/hQZAQQUW+DZ7UgxsTQxBWsyIEznnMje7OojVE+6ihxwTW0JmExzmxKLrX/hgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ij4zr65N; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753892267; x=1785428267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+h6EzbbOHcJKfZOy57XdSPF1XXqiZxLUfRoHNrtoYmk=;
  b=Ij4zr65NeTDiVV8MlFz3W5/SHupZvbRf4S9kireCJCTo9nuWd+fPbgm3
   Quyo/xBAhJq0IXyt2Zs1rrmwSV3a2ChtLYSDkM/syw3+XYXiAWlBfSY//
   XQdJehxJXwU/D6NHNwaj5Nyh9wj23xT3RpGIUAr3BNjH1pWt6H/luEqjW
   bNeIUACkm4DMNMHiDfU3vyerspZyxLoZFB74J2imqq40r6fKI/n6Rm/L3
   g0dZVVu3NGtS/7jC4gHB3fflUXeSaIkawPnkiXpp9b8k2He31ScCvm6/l
   sZyxrY+8+piSiI03hEmmdHK6oEcJO3hOWGw6n6Uj8F5hDUkO/1lWvv4lO
   Q==;
X-CSE-ConnectionGUID: Xcegl57rRGq6IQl+3tSAzw==
X-CSE-MsgGUID: JFrvJKi1SpmGqrVAhCygYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="66473262"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="66473262"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:17:46 -0700
X-CSE-ConnectionGUID: vAVuUZC2RgCWnHNdyUsIxw==
X-CSE-MsgGUID: F4iWn4YfSDSyrx9ecp/ntg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162308253"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Jul 2025 09:17:45 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh9Us-0002vM-29;
	Wed, 30 Jul 2025 16:17:42 +0000
Date: Thu, 31 Jul 2025 00:17:20 +0800
From: kernel test robot <lkp@intel.com>
To: Zhu Yixin <yzhu@maxlinear.com>, dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jchng@maxlinear.com,
	sureshnagaraj@maxlinear.com, Zhu Yixin <yzhu@maxlinear.com>
Subject: Re: [PATCH 4/5] dmaengine: lgm-dma: Added HDMA software mode TX
 function.
Message-ID: <202507302344.XEgGylg3-lkp@intel.com>
References: <20250730024547.3160871-4-yzhu@maxlinear.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730024547.3160871-4-yzhu@maxlinear.com>

Hi Zhu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.16 next-20250730]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhu-Yixin/dmaengine-lgm-dma-Correct-ORRC-MAX-counter-value/20250730-105748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20250730024547.3160871-4-yzhu%40maxlinear.com
patch subject: [PATCH 4/5] dmaengine: lgm-dma: Added HDMA software mode TX function.
config: i386-buildonly-randconfig-003-20250730 (https://download.01.org/0day-ci/archive/20250730/202507302344.XEgGylg3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507302344.XEgGylg3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507302344.XEgGylg3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/lgm/lgm-hdma.c: In function 'hdma_irq_stat':
>> drivers/dma/lgm/lgm-hdma.c:253:27: warning: left shift count >= width of type [-Wshift-count-overflow]
     253 |         return high ? ret << 32 : ret;
         |                           ^~
   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:5,
                    from drivers/dma/lgm/lgm-hdma.c:10:
   drivers/dma/lgm/lgm-hdma.c: In function 'hdma_alloc_chan_resources':
>> drivers/dma/lgm/lgm-hdma.c:339:22: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     339 |         dev_dbg(dev, "DMA CH: %u, phy addr: 0x%llx, desc cnt: %u\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:139:49: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                 ^~~
   include/linux/dev_printk.h:171:40: note: in expansion of macro 'dev_fmt'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                        ^~~~~~~
   drivers/dma/lgm/lgm-hdma.c:339:9: note: in expansion of macro 'dev_dbg'
     339 |         dev_dbg(dev, "DMA CH: %u, phy addr: 0x%llx, desc cnt: %u\n",
         |         ^~~~~~~
   drivers/dma/lgm/lgm-hdma.c:339:50: note: format string is defined here
     339 |         dev_dbg(dev, "DMA CH: %u, phy addr: 0x%llx, desc cnt: %u\n",
         |                                               ~~~^
         |                                                  |
         |                                                  long long unsigned int
         |                                               %x
   drivers/dma/lgm/lgm-hdma.c: In function 'hdma_prep_slave_sg':
>> drivers/dma/lgm/lgm-hdma.c:508:29: warning: variable 'desc_hw' set but not used [-Wunused-but-set-variable]
     508 |         struct dw4_desc_hw *desc_hw;
         |                             ^~~~~~~


vim +253 drivers/dma/lgm/lgm-hdma.c

   213	
   214	static unsigned long hdma_irq_stat(struct ldma_dev *d, int high)
   215	{
   216		u32 irnen, irncr, en_off, cr_off, cid;
   217		unsigned long flags;
   218		unsigned long ret;
   219	
   220		spin_lock_irqsave(&d->dev_lock, flags);
   221	
   222		hdma_get_irq_off(high, &en_off, &cr_off);
   223	
   224		irncr = readl(d->base + cr_off);
   225		irnen = readl(d->base + en_off);
   226	
   227		if (!irncr || !irnen || !(irncr & irnen)) {
   228			writel(irncr, d->base + cr_off);
   229			spin_unlock_irqrestore(&d->dev_lock, flags);
   230			return 0;
   231		}
   232	
   233		/* disable EOP interrupt for the channel */
   234		for_each_set_bit(cid, (const unsigned long *)&irncr, d->chan_nrs) {
   235			/* select DMA channel */
   236			ldma_update_bits(d, DMA_CS_MASK, cid, DMA_CS);
   237			/* Clear EOP interrupt status */
   238			writel(readl(d->base + DMA_CIS), d->base + DMA_CIS);
   239			/* Disable EOP interrupt */
   240			writel(0, d->base + DMA_CIE);
   241		}
   242	
   243		/* ACK interrupt */
   244		writel(irncr, d->base + cr_off);
   245		irnen &= ~irncr;
   246		/* Disable interrupt */
   247		writel(irnen, d->base + en_off);
   248	
   249		spin_unlock_irqrestore(&d->dev_lock, flags);
   250	
   251		ret = irncr;
   252	
 > 253		return high ? ret << 32 : ret;
   254	}
   255	
   256	static irqreturn_t hdma_interrupt(int irq, void *dev_id)
   257	{
   258		struct ldma_dev *d = dev_id;
   259		struct hdma_chan *chan;
   260		u32 cid;
   261		unsigned long stat;
   262	
   263		stat = hdma_irq_stat(d, 0) | hdma_irq_stat(d, 1);
   264		if (!stat)
   265			return IRQ_HANDLED;
   266	
   267		for_each_set_bit(cid, (const unsigned long *)&stat, d->chan_nrs) {
   268			chan = (struct hdma_chan *)d->chans[cid].priv;
   269			tasklet_schedule(&chan->task);
   270		}
   271	
   272		return IRQ_HANDLED;
   273	}
   274	
   275	static int hdma_irq_init(struct ldma_dev *d, struct platform_device *pdev)
   276	{
   277		if (d->flags & DMA_CHAN_HW_DESC)
   278			return 0;
   279	
   280		d->irq = platform_get_irq(pdev, 0);
   281		if (d->irq < 0)
   282			return d->irq;
   283	
   284		return devm_request_irq(d->dev, d->irq, hdma_interrupt, 0,
   285					DRIVER_NAME, d);
   286	}
   287	
   288	/**
   289	 * Allocate DMA descriptor list
   290	 */
   291	static int hdma_alloc_chan_resources(struct dma_chan *dma_chan)
   292	{
   293		struct ldma_chan *c = to_ldma_chan(dma_chan);
   294		struct hdma_chan *chan = (struct hdma_chan *)c->priv;
   295		struct device *dev = c->vchan.chan.device->dev;
   296		struct dw4_desc_sw *desc_sw;
   297		struct dw4_desc_hw *desc_hw;
   298		size_t desc_sz;
   299		int i;
   300	
   301		/* HW allocate DMA descriptors */
   302		if (ldma_chan_is_hw_desc(c)) {
   303			c->flags |= CHAN_IN_USE;
   304			dev_dbg(dev, "desc in hw\n");
   305			return 0;
   306		}
   307	
   308		if (!c->desc_cnt) {
   309			dev_err(dev, "descriptor count is not set\n");
   310			return -EINVAL;
   311		}
   312	
   313		desc_sz = c->desc_cnt * sizeof(*desc_hw);
   314	
   315		c->desc_base = kzalloc(desc_sz, GFP_KERNEL);
   316		if (!c->desc_base)
   317			return -ENOMEM;
   318	
   319		c->desc_phys = dma_map_single(dev, c->desc_base,
   320					      desc_sz, DMA_TO_DEVICE);
   321		if (dma_mapping_error(dev, c->desc_phys)) {
   322			dev_err(dev, "dma mapping error for dma desc list\n");
   323			goto desc_err;
   324		}
   325	
   326		desc_sz = c->desc_cnt * sizeof(*desc_sw);
   327		chan->ds = kzalloc(desc_sz, GFP_KERNEL);
   328	
   329		if (!chan->ds)
   330			goto desc_err;
   331	
   332		desc_hw = (struct dw4_desc_hw *)c->desc_base;
   333		for (i = 0; i < c->desc_cnt; i++) {
   334			desc_sw = chan->ds + i;
   335			desc_sw->chan = c;
   336			desc_sw->desc_hw = desc_hw + i;
   337		}
   338	
 > 339		dev_dbg(dev, "DMA CH: %u, phy addr: 0x%llx, desc cnt: %u\n",
   340			c->nr, c->desc_phys, c->desc_cnt);
   341	
   342		ldma_chan_desc_hw_cfg(c, c->desc_phys, c->desc_cnt);
   343		ldma_chan_on(c);
   344	
   345		return c->desc_cnt;
   346	
   347	desc_err:
   348		kfree(c->desc_base);
   349		return -EINVAL;
   350	}
   351	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

