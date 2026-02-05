Return-Path: <dmaengine+bounces-8746-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB6gOn8ChGk+wwMAu9opvQ
	(envelope-from <dmaengine+bounces-8746-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 03:37:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 802B6EE039
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 03:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE237300B9EE
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 02:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669652BE7D6;
	Thu,  5 Feb 2026 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5BrKqNW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23E1DD0EF;
	Thu,  5 Feb 2026 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259069; cv=none; b=ZytgcezAQNMOFqRReH04DSSghIQ9lTyGbwMc1Z33qrUvTX4qZK4z1nFfDsHkY4ZplSQXmzJUzyYWTY23LcbapP4U/wqFLyCEvooISuLn+e28q0V+oWYg8GO037V7/coTqG6RwUt4+jc9Qe56rVybiIr4tq5pL6j7T84Vd92BCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259069; c=relaxed/simple;
	bh=E5LPU4NWtqOyTdkjV6OAOmlb669H2tC5lWTVQZncWtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTp4xSp0tS06Qlk+BNAWC4FR+jbVH/M8wLKt58X/5x5WBoLTQvA9ntl+NG31hU1Qn0o/f++aiSks0QYwnH7XPap+CbhoqKLyI9KAXw7PVLY5fHodcLJ6aZkN5qKSQ2u6oEzCGA48hay5kKk4mNuUx4Gu9ck/t8ONq36Z5W56rl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5BrKqNW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770259069; x=1801795069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E5LPU4NWtqOyTdkjV6OAOmlb669H2tC5lWTVQZncWtg=;
  b=A5BrKqNW3v3VHxR1mBW6rXtT4AFi4/Jp/mw1ooVYUOOtwhN6aygOgsL2
   GfeUJlOTcXJ+DLeEth89zmKxi/0FCnDfyCFUzBQR7Pdd1TW/qNmjexsyf
   sC5pzfAaKhwzNKashk3JzhwCq+AmmSmdxA9CAAMnbBwNdS+F+z5Nt0A28
   wqE3piqvr7jrorAiCQFBb5smF/GY0lMtNIYb4KT/S5xPwTF35rpe0AjgK
   /cqhw2Ia4oV65YMFZhMn99L17C4ePn4dgZgDM/FyJArpaIsq3XdVYU0fy
   GJUOeykc+wSmipbiNTsTMA8VMNVSXC4EyMT5xFrA/OW3nIk5n+VoG2KXb
   A==;
X-CSE-ConnectionGUID: z6BqvePBS8u9QFJC/XaYDA==
X-CSE-MsgGUID: PSl1egV6SWKnMau3R6Ak3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71549169"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="71549169"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 18:37:48 -0800
X-CSE-ConnectionGUID: oNLTQC/mT7GrfH0lFLvqfQ==
X-CSE-MsgGUID: S66bEHSISoCB+sTIOkhzFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="210438991"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Feb 2026 18:37:45 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnpFW-00000000jLU-1B29;
	Thu, 05 Feb 2026 02:37:42 +0000
Date: Thu, 5 Feb 2026 10:37:16 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <den@valinux.co.jp>, vkoul@kernel.org, mani@kernel.org,
	Frank.Li@nxp.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/11] PCI: endpoint: pci-epf-test: Add smoke test for
 EPC remote resource API
Message-ID: <202602051059.2bwjcYJE-lkp@intel.com>
References: <20260204145440.950609-10-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204145440.950609-10-den@valinux.co.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8746-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[valinux.co.jp,kernel.org,nxp.com,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: 802B6EE039
X-Rspamd-Action: no action

Hi Koichiro,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on next-20260204]
[cannot apply to vkoul-dmaengine/next pci/for-linus linus/master v6.19-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Koichiro-Den/dmaengine-Add-hw_id-to-dma_slave_caps/20260204-230604
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260204145440.950609-10-den%40valinux.co.jp
patch subject: [PATCH v3 09/11] PCI: endpoint: pci-epf-test: Add smoke test for EPC remote resource API
config: um-randconfig-001-20260205 (https://download.01.org/0day-ci/archive/20260205/202602051059.2bwjcYJE-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602051059.2bwjcYJE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602051059.2bwjcYJE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/endpoint/functions/pci-epf-test.c:11:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/pci/endpoint/functions/pci-epf-test.c:1013:36: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
    1012 |                                 "Invalid remote resource[%d] (type=%d phys=%pa size=%llu)\n",
         |                                                                                     ~~~~
         |                                                                                     %u
    1013 |                                 i, res->type, &res->phys_addr, res->size);
         |                                                                ^~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/pci/endpoint/functions/pci-epf-test.c:1021:25: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
    1020 |                                 "Remote resource[%d] overflow (phys=%pa size=%llu)\n",
         |                                                                              ~~~~
         |                                                                              %u
    1021 |                                 i, &res->phys_addr, res->size);
         |                                                     ^~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   3 warnings generated.


vim +1013 drivers/pci/endpoint/functions/pci-epf-test.c

   972	
   973	static void pci_epf_test_epc_api(struct pci_epf_test *epf_test,
   974					 struct pci_epf_test_reg *reg)
   975	{
   976		struct pci_epc_remote_resource *resources = NULL;
   977		u32 status = le32_to_cpu(reg->status);
   978		struct pci_epf *epf = epf_test->epf;
   979		struct device *dev = &epf->dev;
   980		struct pci_epc *epc = epf->epc;
   981		int num_resources;
   982		int ret, i;
   983	
   984		num_resources = pci_epc_get_remote_resources(epc, epf->func_no,
   985							     epf->vfunc_no, NULL, 0);
   986		if (num_resources == -EOPNOTSUPP || num_resources == 0)
   987			goto out_success;
   988		if (num_resources < 0)
   989			goto err;
   990	
   991		resources = kcalloc(num_resources, sizeof(*resources), GFP_KERNEL);
   992		if (!resources)
   993			goto err;
   994	
   995		ret = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
   996						   resources, num_resources);
   997		if (ret < 0) {
   998			dev_err(dev, "EPC remote resource query failed: %d\n", ret);
   999			goto err_free;
  1000		}
  1001		if (ret > num_resources) {
  1002			dev_err(dev, "EPC API returned %d resources (max %d)\n",
  1003				ret, num_resources);
  1004			goto err_free;
  1005		}
  1006	
  1007		for (i = 0; i < ret; i++) {
  1008			struct pci_epc_remote_resource *res = &resources[i];
  1009	
  1010			if (!res->phys_addr || !res->size) {
  1011				dev_err(dev,
  1012					"Invalid remote resource[%d] (type=%d phys=%pa size=%llu)\n",
> 1013					i, res->type, &res->phys_addr, res->size);
  1014				goto err_free;
  1015			}
  1016	
  1017			/* Guard against address overflow */
  1018			if (res->phys_addr + res->size < res->phys_addr) {
  1019				dev_err(dev,
  1020					"Remote resource[%d] overflow (phys=%pa size=%llu)\n",
  1021					i, &res->phys_addr, res->size);
  1022				goto err_free;
  1023			}
  1024	
  1025			switch (res->type) {
  1026			case PCI_EPC_RR_DMA_CTRL_MMIO:
  1027				/* Generic checks above are sufficient. */
  1028				break;
  1029			case PCI_EPC_RR_DMA_CHAN_DESC:
  1030				/*
  1031				 * hw_chan_id and ep2rc are informational. No extra validation
  1032				 * beyond the generic checks above is needed.
  1033				 */
  1034				break;
  1035			default:
  1036				dev_err(dev, "Unknown remote resource type %d\n", res->type);
  1037				goto err_free;
  1038			}
  1039		}
  1040	
  1041	out_success:
  1042		kfree(resources);
  1043		status |= STATUS_EPC_API_SUCCESS;
  1044		reg->status = cpu_to_le32(status);
  1045		return;
  1046	
  1047	err_free:
  1048		kfree(resources);
  1049	err:
  1050		status |= STATUS_EPC_API_FAIL;
  1051		reg->status = cpu_to_le32(status);
  1052	}
  1053	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

