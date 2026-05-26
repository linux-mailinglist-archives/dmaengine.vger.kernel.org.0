Return-Path: <dmaengine+bounces-10968-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAaeJHMdFmoPhwcAu9opvQ
	(envelope-from <dmaengine+bounces-10968-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 00:23:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DD75DD2C9
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 00:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8851F302E910
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 22:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2265E3C769D;
	Tue, 26 May 2026 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4JALKv9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520073C65FE;
	Tue, 26 May 2026 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834223; cv=none; b=twzb/PKeSlkZDd/NPrDUMixaD9vtXPSafwSs3+oU0MzhiQopIjwKhmCl56rLE5v/NMfZE6lnKJX9c7hEtRlPdNCVTh1JYnD5lPFtcRNq8oYxli45ODKCIU2IovMhRlTUEqDzelbfdhU1ZhTv941/C8SAOIP9CF0XdZYTGOFsbI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834223; c=relaxed/simple;
	bh=PeWkXtVByZaI1HB4gRMRQ14IUpZcVF886iBQEGNYfvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2AKuyHUKkKVikH6xxXo/QQt+9tI/wHmwm51Ap1knapIrKaKWpOEIsgz+2pUrN2VjE4XPlYITbm7KkFilr7mP7XbxuGgjTAkBiPBzc0Do0OwhrprmCttZkf+EKsr1Po+pU8tPDclfPFL3tRX+7jtXrP/k7XyWeI5wq/PQRkKabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4JALKv9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779834221; x=1811370221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PeWkXtVByZaI1HB4gRMRQ14IUpZcVF886iBQEGNYfvg=;
  b=e4JALKv9l4zOu49Kf11bhIIUyeM91FsAF7HTbErMwiy8pw0Oq35s5XbS
   We3VmzXGTM73zSMoj9p4oFf6tSIAD5MoFSRdPTTTqUzt98AWHSArSXtE4
   fB4df1yRMDftZwZHIWMV1LuaDz2fwo/EsP8aYzmOH+scHiZxGgvNjiQFM
   GuS7gnKq0aXQq0h2LJY/+RedlvH7X+r9jbdjHvfcTQwzM/ybSbPJYuc2z
   KWka53Vwf5gvsbR9BeZAn3CKups7Uvf8RrILTEX/73+5lAoS+i7Ph1MhM
   v1Pcmzl1pqK1eXc4iYbVSmciksT1RCDS6CaFf6Qo/Y6i6XH9GoiiWv1p7
   w==;
X-CSE-ConnectionGUID: r7+pFPcoRK6Ob5n8PFjOBg==
X-CSE-MsgGUID: IROPJynYQVauPpzAsXnz7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80848044"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80848044"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 15:23:41 -0700
X-CSE-ConnectionGUID: jXp1pGdtQVWRxKGMFXbOoQ==
X-CSE-MsgGUID: XwU4YZPvT6+rsx2PIp014g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="241890275"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 26 May 2026 15:23:37 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wS0BS-00000000CUr-2yTH;
	Tue, 26 May 2026 22:23:34 +0000
Date: Wed, 27 May 2026 00:22:41 +0200
From: kernel test robot <lkp@intel.com>
To: Frank.Li@oss.nxp.com, Vinod Koul <vkoul@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, carlos.song@nxp.com,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 2/2] i2c: imx-lpi2c: use dmaengine_prep_submit() to
 simple code
Message-ID: <202605270007.xFkhAWbC-lkp@intel.com>
References: <20260522-dma_prep_submit-v2-2-7a87a5a29525@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522-dma_prep_submit-v2-2-7a87a5a29525@nxp.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10968-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[oss.nxp.com,kernel.org,nxp.com,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url]
X-Rspamd-Queue-Id: E5DD75DD2C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li-oss-nxp-com/dmaengine-Add-helper-dmaengine_prep_submit_slave_single/20260523-041812
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20260522-dma_prep_submit-v2-2-7a87a5a29525%40nxp.com
patch subject: [PATCH v2 2/2] i2c: imx-lpi2c: use dmaengine_prep_submit() to simple code
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260527/202605270007.xFkhAWbC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260527/202605270007.xFkhAWbC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605270007.xFkhAWbC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/dev.c:124:
>> include/linux/dmaengine.h:1588:48: error: expected ')'
    1588 |                                    dma_async_tx_callback cb, void *cb_param;
         |                                                                            ^
   include/linux/dmaengine.h:1587:35: note: to match this '('
    1587 | dmaengine_prep_submit_slave_single(struct dma_chan *chan,
         |                                   ^
>> include/linux/dmaengine.h:1587:1: error: conflicting types for 'dmaengine_prep_submit_slave_single'
    1587 | dmaengine_prep_submit_slave_single(struct dma_chan *chan,
         | ^
   include/linux/dmaengine.h:994:1: note: previous declaration is here
     994 | dmaengine_prep_submit_slave_single(struct dma_chan *chan,
         | ^
>> include/linux/dmaengine.h:1589:24: error: redefinition of 'size_t' as different kind of symbol
    1589 |                                    dma_addr_t buf, size_t len,
         |                                                    ^
   include/linux/types.h:62:26: note: previous definition is here
      62 | typedef __kernel_size_t         size_t;
         |                                 ^
   In file included from net/core/dev.c:124:
>> include/linux/dmaengine.h:1589:30: error: expected ';' after top level declarator
    1589 |                                    dma_addr_t buf, size_t len,
         |                                                          ^
         |                                                          ;
>> include/linux/dmaengine.h:1592:1: error: expected identifier or '('
    1592 | {
         | ^
   5 errors generated.


vim +1588 include/linux/dmaengine.h

  1585	
  1586	static inline dma_cookie_t
> 1587	dmaengine_prep_submit_slave_single(struct dma_chan *chan,
> 1588					   dma_async_tx_callback cb, void *cb_param;
> 1589					   dma_addr_t buf, size_t len,
  1590					   enum dma_transfer_direction dir,
  1591					   unsigned long flags);
> 1592	{
  1593		return -ENODEV;
  1594	}
  1595	#endif
  1596	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

