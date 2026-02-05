Return-Path: <dmaengine+bounces-8745-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MSoFSfeg2l4vAMAu9opvQ
	(envelope-from <dmaengine+bounces-8745-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 01:02:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98360ED607
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 01:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31E02300F9FA
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 00:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8617D2;
	Thu,  5 Feb 2026 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNh4ex1F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D111862A;
	Thu,  5 Feb 2026 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770249764; cv=none; b=d9TetOmlWTg1KTjUzhSYD9Dr0leWQHLfLUOnDfyTWsdIaKUvGV4BoK9pVQRmMHZ6S063TjlQJ7lX1W7t3QacX9ZT6Ui+h8Q/zuwFYg+wMACca31+wopK8MAZPIOLEkgjs9Xjr6aanyo3fj4GXHMxvAieAjfrc8Wh+WEU8xDG7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770249764; c=relaxed/simple;
	bh=8EmPOgxCqMVBSCIXlKn5Fd96oBKayGlgN/Pw+n7N7ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOCN/cUOSzFEv9KVnbEoqwuvysaV/tA82ZZffKShiAY645E+Ap1XXaVo7FNtJZugq4pTjIpxaJv8DW/1Zee1iReA6AK3wboXqowltEMDV4VtPdE2RNSTVLMtIcRBgzmY3JrJdDSpPmw6d2Uh3/2eDVMfa6zteQn/Jfj2NOT+SJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNh4ex1F; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770249764; x=1801785764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8EmPOgxCqMVBSCIXlKn5Fd96oBKayGlgN/Pw+n7N7ZM=;
  b=kNh4ex1FoaDV5UwyUdFpruW0GUbkGZYS+mvtytx69TWdhseCT7Ea1iTF
   3mxSA18Wh2i+fXHGfyx3Lz9T/1sYQz13g8pZhIiWznu/wr3/NrroF6DYD
   kZ+cnsPp56O82UDLHUQPKoaBvRUlrn10Vnekk3GfKsq3MDGygApV/LB0R
   JUps+L+Tz/QIqu6bredGZwJWacr8Y2ZM9lVb4YWf++tltHgUk3cEYYVJV
   Q9dTAR0kJzS85sIUUJmrNS6/+oRcNZZRDU6OxQezAEPReh0GKEmIficTL
   jU8EWAbpij24vonnHdRgn1rEcy9iuNTPYm/TnLEp/1lxceBeSoN6bTAkl
   Q==;
X-CSE-ConnectionGUID: mOM/BJySQlO9TqldA4lvow==
X-CSE-MsgGUID: ht8IBpkXRr+xe7GHGM5bkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71430001"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="71430001"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 16:02:43 -0800
X-CSE-ConnectionGUID: DnA57gcFSWyPlRVzxUxI7w==
X-CSE-MsgGUID: WnkvpO+XQXaQuw8NIgtusw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="209419369"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Feb 2026 16:02:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnmpR-00000000jFQ-3OnI;
	Thu, 05 Feb 2026 00:02:37 +0000
Date: Thu, 5 Feb 2026 08:01:43 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <den@valinux.co.jp>, vkoul@kernel.org, mani@kernel.org,
	Frank.Li@nxp.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/11] PCI: endpoint: pci-epf-test: Add smoke test for
 EPC remote resource API
Message-ID: <202602050741.nyI2oa7X-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8745-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[valinux.co.jp,kernel.org,nxp.com,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 98360ED607
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
config: i386-randconfig-003-20260205 (https://download.01.org/0day-ci/archive/20260205/202602050741.nyI2oa7X-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602050741.nyI2oa7X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602050741.nyI2oa7X-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from drivers/pci/endpoint/functions/pci-epf-test.c:11:
   drivers/pci/endpoint/functions/pci-epf-test.c: In function 'pci_epf_test_epc_api':
>> drivers/pci/endpoint/functions/pci-epf-test.c:1012:33: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 6 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
    1012 |                                 "Invalid remote resource[%d] (type=%d phys=%pa size=%llu)\n",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/pci/endpoint/functions/pci-epf-test.c:1011:25: note: in expansion of macro 'dev_err'
    1011 |                         dev_err(dev,
         |                         ^~~~~~~
   drivers/pci/endpoint/functions/pci-epf-test.c:1012:88: note: format string is defined here
    1012 |                                 "Invalid remote resource[%d] (type=%d phys=%pa size=%llu)\n",
         |                                                                                     ~~~^
         |                                                                                        |
         |                                                                                        long long unsigned int
         |                                                                                     %u
   drivers/pci/endpoint/functions/pci-epf-test.c:1020:33: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 5 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
    1020 |                                 "Remote resource[%d] overflow (phys=%pa size=%llu)\n",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/pci/endpoint/functions/pci-epf-test.c:1019:25: note: in expansion of macro 'dev_err'
    1019 |                         dev_err(dev,
         |                         ^~~~~~~
   drivers/pci/endpoint/functions/pci-epf-test.c:1020:81: note: format string is defined here
    1020 |                                 "Remote resource[%d] overflow (phys=%pa size=%llu)\n",
         |                                                                              ~~~^
         |                                                                                 |
         |                                                                                 long long unsigned int
         |                                                                              %u


vim +1012 drivers/pci/endpoint/functions/pci-epf-test.c

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
> 1012					"Invalid remote resource[%d] (type=%d phys=%pa size=%llu)\n",
  1013					i, res->type, &res->phys_addr, res->size);
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

