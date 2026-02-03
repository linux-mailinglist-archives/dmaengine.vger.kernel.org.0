Return-Path: <dmaengine+bounces-8697-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBAHDoRIgmnzRgMAu9opvQ
	(envelope-from <dmaengine+bounces-8697-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 20:12:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F35FDE146
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 20:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 806E330DCC05
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE238311C1B;
	Tue,  3 Feb 2026 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApiYfy0M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D7313E30;
	Tue,  3 Feb 2026 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145734; cv=none; b=NXLQ2V4MmpgzPibCC3O7gQkV4csXydmCvkMSFyJRDGDL8NacL5CRffZbq/AU18WioTgY50NDQGpwYREEn6SAq4OfUNDH7WtcygUPc1fDDr2D3Az2hFzLdg9HjdxxgLgvR7fmDbAFkYxbhpRMaUaCROV8yNyg79WJGw3eDZAvyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145734; c=relaxed/simple;
	bh=iK7oMrURz8O+USoBI7xONOLPuEM3yl5avtsv0w54wFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwaYWuZ52FqHxR8EKE5kRLunYD5J2XaI26adS29ZxdiYPIGL8ciku2SMuiJDkXhrj/bGvEnPXl9xA+9ib7CpIs4Sxnt3QG6Dec2eO6jFClYlJEN2XXgwagZZ6EbsK3+AnepKShVGEHofM7/5o+v+eaB38Pxqz2USYfSblwoJUAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApiYfy0M; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770145733; x=1801681733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iK7oMrURz8O+USoBI7xONOLPuEM3yl5avtsv0w54wFs=;
  b=ApiYfy0MHTABE+G6iVTKG41TDwglHIJc3K1PFR2dyrlb1B3zTVu65w7w
   xeOMYKSlKtPH9Jp2/f27xutAlZaTkc7W0uuzfqo94L+gBJbKQhzX2VlGx
   tasWq2Hhvt7XfLop/83q3yCc1rTQuV3nrhboRX0ks00xftOxeLG8ug6Y4
   YocPUIKaAcYsP4CljqW7EiiobUxPGZJwCc0DylH27Y6BFcK0R+yqGCGgl
   4HwauNUGii0MlNh12UNyUTkjYwyIRPyKo4NHxoKwqaqwJkImCq/laeQ0U
   1khDg2lSBTeegSssCyZUa2al+KpKGqHTCIVqIm5eqSS64r3sJT2mA45Le
   w==;
X-CSE-ConnectionGUID: 9lmIRMQ/TxuV38SbnKV19g==
X-CSE-MsgGUID: 859IkBUlR7GBkwdgQQcl+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82067354"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="82067354"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 11:08:52 -0800
X-CSE-ConnectionGUID: nsWX1Ce1RQCHeJjitgNevw==
X-CSE-MsgGUID: Vpa3l1eST6y3Hebxsl8BGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210032379"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 03 Feb 2026 11:08:50 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnLlX-000000003P3-2yKY;
	Tue, 03 Feb 2026 19:08:47 +0000
Date: Tue, 3 Feb 2026 20:08:05 +0100
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <phasta@kernel.org>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Philipp Stanner <phasta@kernel.org>
Subject: Re: [PATCH] dmaengine: amd: Replace deprecated PCI functions
Message-ID: <202602032034.I97ysnlu-lkp@intel.com>
References: <20260203123238.88598-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203123238.88598-2-phasta@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-8697-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F35FDE146
X-Rspamd-Action: no action

Hi Philipp,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.19-rc8 next-20260202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/dmaengine-amd-Replace-deprecated-PCI-functions/20260203-204040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20260203123238.88598-2-phasta%40kernel.org
patch subject: [PATCH] dmaengine: amd: Replace deprecated PCI functions
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260203/202602032034.I97ysnlu-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602032034.I97ysnlu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602032034.I97ysnlu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma/amd/ptdma/ptdma-pci.c: In function 'pt_pci_probe':
>> drivers/dma/amd/ptdma/ptdma-pci.c:26:21: error: 'ptdma' undeclared (first use in this function)
      26 | #define DRIVER_NAME ptdma
         |                     ^~~~~
   drivers/dma/amd/ptdma/ptdma-pci.c:156:54: note: in expansion of macro 'DRIVER_NAME'
     156 |                 ret = pcim_request_region(pdev, bar, DRIVER_NAME);
         |                                                      ^~~~~~~~~~~
   drivers/dma/amd/ptdma/ptdma-pci.c:26:21: note: each undeclared identifier is reported only once for each function it appears in
      26 | #define DRIVER_NAME ptdma
         |                     ^~~~~
   drivers/dma/amd/ptdma/ptdma-pci.c:156:54: note: in expansion of macro 'DRIVER_NAME'
     156 |                 ret = pcim_request_region(pdev, bar, DRIVER_NAME);
         |                                                      ^~~~~~~~~~~
   drivers/dma/amd/ptdma/ptdma-pci.c: At top level:
>> drivers/dma/amd/ptdma/ptdma-pci.c:26:21: error: 'ptdma' undeclared here (not in a function)
      26 | #define DRIVER_NAME ptdma
         |                     ^~~~~
   drivers/dma/amd/ptdma/ptdma-pci.c:230:17: note: in expansion of macro 'DRIVER_NAME'
     230 |         .name = DRIVER_NAME,
         |                 ^~~~~~~~~~~


vim +/ptdma +26 drivers/dma/amd/ptdma/ptdma-pci.c

    25	
  > 26	#define DRIVER_NAME ptdma
    27	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

