Return-Path: <dmaengine+bounces-8809-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wES+I1BQhmmuLwQAu9opvQ
	(envelope-from <dmaengine+bounces-8809-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 21:34:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF74010322F
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 21:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 473E9302E423
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 20:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1230E831;
	Fri,  6 Feb 2026 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2Z8zoPy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A728469F;
	Fri,  6 Feb 2026 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410060; cv=none; b=NfO74nxibnt+IvRU3KFNdaU57dTjfCTXjmwa8ApxfgzaOa1rK3BQG+2kjbHkhZGWUHF/KuGYwCPyatFq9nsDqaJIdrWLLNrqblA6nljTHcr4sOfd2ZnqEOOX/uj/IHK8JAuvehHEb/dYCk7+PKOcwBwJdp9WYg57HZafSp//rTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410060; c=relaxed/simple;
	bh=cHEh53/ktr4DOFZLnEwI3MqaHj/xZvem+tB575M2M1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbr44rvnvgAY2KSA01eznX919cu7hD7SxMx63Xvo8gMJRz9tG3jVgEk9tZrx79fjAaTucj88I6uodGdVw3X9eKNtG1eQspxQ+xXiWLzYh++MSkdXwI4o+4xtEoYgjr1Pe3ZZQ1oCvYhIY2gO/vTBT7oSvcD65/hNGAf2Ugn7QYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2Z8zoPy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770410060; x=1801946060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cHEh53/ktr4DOFZLnEwI3MqaHj/xZvem+tB575M2M1U=;
  b=B2Z8zoPyn3ctIBneejP/FA5C0fheLThiMWrp/FC8FZAVS1peK3285jUy
   krPq8JzI9/F0eIxyy8/4rI5wcTNs/53UUDE+U4ETCHQthgKWN6TpkEJd1
   +l+ggfxngPAwuz9sXxr/gsf3pR2yCfnr5lbUDdXM4MajOAYsvF1PLqw81
   4Qa1y0SAQijVe204EjzYeRxFPDktCjB+CAMPwED+4nDErBEgstayJh8Ca
   0MrbaUrrRCEJPitKhKnshngTZlN0sZzcFKXqyabVoMIG2kkMApL6V3lnN
   kLb33bQVURF5TY9b2PUZBh14BlfrMkDfMi+pRZzBpUdBWL+28xHpzv8Y+
   Q==;
X-CSE-ConnectionGUID: F/+AXB+YTx681YpczUgM9g==
X-CSE-MsgGUID: p1y2LrESTS2iW06sqttdog==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="97080977"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="97080977"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 12:34:19 -0800
X-CSE-ConnectionGUID: XtsNt/lmSTqAjTkKm0geLw==
X-CSE-MsgGUID: mMMetEEoSaeK5NPx/J9RbA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Feb 2026 12:34:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voSWr-00000000l7Q-26gA;
	Fri, 06 Feb 2026 20:34:13 +0000
Date: Sat, 7 Feb 2026 04:33:26 +0800
From: kernel test robot <lkp@intel.com>
To: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH v3 2/3] dma: amlogic: Add general DMA driver for A9
Message-ID: <202602070404.wKMJf0YW-lkp@intel.com>
References: <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8809-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.961];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,xianwei.zhao.amlogic.com,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: DF74010322F
X-Rspamd-Action: no action

Hi Xianwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2]

url:    https://github.com/intel-lab-lkp/linux/commits/Xianwei-Zhao-via-B4-Relay/dt-bindings-dma-Add-Amlogic-A9-SoC-DMA/20260206-170903
base:   3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2
patch link:    https://lore.kernel.org/r/20260206-amlogic-dma-v3-2-56fb9f59ed22%40amlogic.com
patch subject: [PATCH v3 2/3] dma: amlogic: Add general DMA driver for A9
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20260207/202602070404.wKMJf0YW-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260207/202602070404.wKMJf0YW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602070404.wKMJf0YW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/dma/amlogic-dma.c:7:
>> arch/x86/include/asm/irq.h:39:56: warning: declaration of 'struct pt_regs' will not be visible outside of this function [-Wvisibility]
      39 | extern void __handle_irq(struct irq_desc *desc, struct pt_regs *regs);
         |                                                        ^
>> arch/x86/include/asm/irq.h:44:50: warning: declaration of 'struct cpumask' will not be visible outside of this function [-Wvisibility]
      44 | void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
         |                                                  ^
   2 warnings generated.


vim +39 arch/x86/include/asm/irq.h

a782a7e46bb508 arch/x86/include/asm/irq.h Thomas Gleixner   2015-08-02  38  
7c2a57364cae0f arch/x86/include/asm/irq.h Thomas Gleixner   2020-05-21 @39  extern void __handle_irq(struct irq_desc *desc, struct pt_regs *regs);
22067d4501bfb4 include/asm-x86/irq.h      Thomas Gleixner   2008-05-02  40  
d9112f43021554 arch/x86/include/asm/irq.h Thomas Gleixner   2009-08-20  41  extern void init_ISA_irqs(void);
d9112f43021554 arch/x86/include/asm/irq.h Thomas Gleixner   2009-08-20  42  
b52e0a7c4e4100 arch/x86/include/asm/irq.h Michel Lespinasse 2013-06-06  43  #ifdef CONFIG_X86_LOCAL_APIC
9a01c3ed5cdb35 arch/x86/include/asm/irq.h Chris Metcalf     2016-10-07 @44  void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
8d539b84f1e347 arch/x86/include/asm/irq.h Douglas Anderson  2023-08-04  45  				    int exclude_cpu);
89f579ce99f7e0 arch/x86/include/asm/irq.h Yi Wang           2018-11-22  46  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

