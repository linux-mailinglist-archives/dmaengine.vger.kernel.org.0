Return-Path: <dmaengine+bounces-8801-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJZFArY8hmkvLQQAu9opvQ
	(envelope-from <dmaengine+bounces-8801-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:10:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B0610278F
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74BBF3028006
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 19:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5723428849;
	Fri,  6 Feb 2026 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPr3oF03"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0D2ECE9B;
	Fri,  6 Feb 2026 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404895; cv=none; b=ZmHTXbb9wX7SuPvvuHfXdBG5KLFsqLy1x9VnOAxkQBqphzSoKNjS8vyox2bU9bDM5c+4tHQNuPZkWgrJ2bATnw1BXgpaXCBjAPp046Tjw7PeaZy8YFlxtMTEgknS4LgloQaufdYv9rIzdjAJzroDKUfs3d9CLdnUy1YoeqL1ULk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404895; c=relaxed/simple;
	bh=rD12jZNWPdLcwK9Chg3S5oef/etzrdqixcbLXgsH0rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yp0O90tovIDFhaDim21F4wQBl1N/fbwL5KEcnpPEgN/E5945TlFpE4s7Vb5n/9FeLgAdx4p1bgZklPvtuR8v/c+eyoQiy9shH4jrzQijdvs3eYSdA5/9RpX1ACek1IRVGrPikAr23Uk6tLNvC885G4OS5jowIqPCihS4UW9C7rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPr3oF03; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770404895; x=1801940895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rD12jZNWPdLcwK9Chg3S5oef/etzrdqixcbLXgsH0rQ=;
  b=MPr3oF03yJPg+cb3Gu2oFU1BmvPN3Zu7j9ipSetbsukruzIdLEPkAe+F
   Ik+5aQFYp2OtKFcr1v55/as567JVTwIETFZg2Xs0x1eFvK45y5uqyKJ4e
   Z0vZuoKirZV7pSPWHLSteHxTx9FzRWTRPrj1hQVr64JgWT0O/PCd1n9Fu
   UwOS3PlB6qf6ixR9XAt/At2tzr4A4/EwMcHMyVX4e51H8sZAwirGu5W0M
   v6CA0BgBoWcvCUkyp2eTV9s4aThclprGx8wnhRydwj3Xub1F1boPparl2
   Tzm9EeC25H6HLX0OGmfp9i+wNG0p4p0VeilvXu1ABfburi/Qtfpkq005a
   Q==;
X-CSE-ConnectionGUID: v8+33BxySwaBvsVKlqiyyQ==
X-CSE-MsgGUID: Vgx/9i/gTfekrR8nalSbkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="75239314"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="75239314"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 11:08:15 -0800
X-CSE-ConnectionGUID: 5AXItfbKTdefetpi8q88Cw==
X-CSE-MsgGUID: 3Xh8yCxSS/STtLkwnSHfFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="210819971"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 Feb 2026 11:08:11 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voRBZ-00000000l32-1kjn;
	Fri, 06 Feb 2026 19:08:09 +0000
Date: Sat, 7 Feb 2026 03:08:01 +0800
From: kernel test robot <lkp@intel.com>
To: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-amlogic@lists.infradead.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH v3 2/3] dma: amlogic: Add general DMA driver for A9
Message-ID: <202602070253.hZ9PqUeB-lkp@intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8801-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine,xianwei.zhao.amlogic.com,dt];
	NEURAL_HAM(-0.00)[-0.962];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 99B0610278F
X-Rspamd-Action: no action

Hi Xianwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2]

url:    https://github.com/intel-lab-lkp/linux/commits/Xianwei-Zhao-via-B4-Relay/dt-bindings-dma-Add-Amlogic-A9-SoC-DMA/20260206-170903
base:   3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2
patch link:    https://lore.kernel.org/r/20260206-amlogic-dma-v3-2-56fb9f59ed22%40amlogic.com
patch subject: [PATCH v3 2/3] dma: amlogic: Add general DMA driver for A9
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20260207/202602070253.hZ9PqUeB-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260207/202602070253.hZ9PqUeB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602070253.hZ9PqUeB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/dma/amlogic-dma.c:7:
>> arch/x86/include/asm/irq.h:39:56: warning: 'struct pt_regs' declared inside parameter list will not be visible outside of this definition or declaration
      39 | extern void __handle_irq(struct irq_desc *desc, struct pt_regs *regs);
         |                                                        ^~~~~~~
>> arch/x86/include/asm/irq.h:44:50: warning: 'struct cpumask' declared inside parameter list will not be visible outside of this definition or declaration
      44 | void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
         |                                                  ^~~~~~~


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

