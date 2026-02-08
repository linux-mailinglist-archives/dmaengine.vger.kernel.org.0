Return-Path: <dmaengine+bounces-8817-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBnJKT2DiGlBqQQAu9opvQ
	(envelope-from <dmaengine+bounces-8817-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 08 Feb 2026 13:36:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB051089DA
	for <lists+dmaengine@lfdr.de>; Sun, 08 Feb 2026 13:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BD97300EFB7
	for <lists+dmaengine@lfdr.de>; Sun,  8 Feb 2026 12:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BAF3570A0;
	Sun,  8 Feb 2026 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRYIFWI5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209073358B1;
	Sun,  8 Feb 2026 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770554171; cv=none; b=aV2DM+yZLMFoMk/P3+LU9DhzohoxGbkQhMyCd5M2x6JhQmFM7aLOC4rWbOQktxsHX755e+jPz6sfoFcdgbxksWlFkoUqethIv3ouXfpE9pnMJh1voMQNDU1k5edhj/UxWWszTsYPl5yxPIw6DIrZ1urahOCAGAJPar8CWDB+E+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770554171; c=relaxed/simple;
	bh=z9KLnrAUU3N91Lg0uRjeEXtQWzGV2NgVHqAR/6XXqDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsHJp1JdUjyWK6KqrZujrTyXSv0R4+W6bzYw2Egn8bPTC+Hwa7KlLGtAeH4iggTAcgdX2UaSsCi3I9IESwKKwyGgzO2UiPDa/QhEnMD6q6O/zf9YDHze6WRX1NcDfTWpIEvXXfq668Drf9ol1WFmk2xC57ihNR7yUUijX5p9VSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRYIFWI5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770554170; x=1802090170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z9KLnrAUU3N91Lg0uRjeEXtQWzGV2NgVHqAR/6XXqDc=;
  b=JRYIFWI5fsMxd8CpprkkYDnAQFoOMNbztFqrWYTq1ZdVzwIFbJX2H+m3
   YOXmFPgcbG7380Jyg42KbyDgY6raxAhOiuqfUNieCdUB12Vm1wMlE0+qA
   hFF4K4199HkWnyeC8KhkUseFrwpJsFxvPJzzkSAP38CTMXvXYYExRoBbT
   jm7uGpahpDHjBOPP33M469lMnFtb3lPkJOunxrL/0134kVIm8m6YU7Dmh
   LNPgd/DCb1bQI3nmz7RC/VaY/ZjUYnABPmJF2rl9zw79dfEjzeSyJIosS
   RVAjPnyLv15pTdLh3g4AxgOSMrH8Ncys4sP8BNm/uGKnPHHC96Jv8x0pg
   g==;
X-CSE-ConnectionGUID: cV0YLUp4QW6J0tu2d5YudQ==
X-CSE-MsgGUID: KI6zaBFuRUyDfCWRmV66hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="75540053"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="75540053"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 04:36:09 -0800
X-CSE-ConnectionGUID: CzKml9euSIylSd3uQxwF0w==
X-CSE-MsgGUID: e37On1BcRtGKQd0NT1Q/fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="216311972"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Feb 2026 04:36:06 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vp41D-00000000mBs-2FEx;
	Sun, 08 Feb 2026 12:36:03 +0000
Date: Sun, 8 Feb 2026 20:35:19 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <den@valinux.co.jp>, vkoul@kernel.org, mani@kernel.org,
	Frank.Li@nxp.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] PCI: endpoint: pci-epf-test: Add embedded
 doorbell variant
Message-ID: <202602082040.oSU5mO1p-lkp@intel.com>
References: <20260206172646.1556847-8-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206172646.1556847-8-den@valinux.co.jp>
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
	TAGGED_FROM(0.00)[bounces-8817-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[valinux.co.jp,kernel.org,nxp.com,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DB051089DA
X-Rspamd-Action: no action

Hi Koichiro,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on next-20260205]
[cannot apply to vkoul-dmaengine/next pci/for-linus linus/master v6.19-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Koichiro-Den/dmaengine-dw-edma-Add-per-channel-interrupt-routing-control/20260207-013042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260206172646.1556847-8-den%40valinux.co.jp
patch subject: [PATCH v4 7/9] PCI: endpoint: pci-epf-test: Add embedded doorbell variant
config: um-randconfig-002-20260208 (https://download.01.org/0day-ci/archive/20260208/202602082040.oSU5mO1p-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260208/202602082040.oSU5mO1p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602082040.oSU5mO1p-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/endpoint/functions/pci-epf-test.c:12:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/pci/endpoint/functions/pci-epf-test.c:858:3: error: cannot jump from this goto statement to its label
     858 |                 goto set_status_err;
         |                 ^
   drivers/pci/endpoint/functions/pci-epf-test.c:861:34: note: jump bypasses initialization of variable with __attribute__((cleanup))
     861 |         struct pci_epc_remote_resource *resources __free(kfree) =
         |                                         ^
   1 warning and 1 error generated.


vim +858 drivers/pci/endpoint/functions/pci-epf-test.c

   838	
   839	static void pci_epf_test_enable_doorbell_embedded(struct pci_epf_test *epf_test,
   840							  struct pci_epf_test_reg *reg)
   841	{
   842		struct pci_epc_remote_resource *dma_ctrl = NULL, *chan0 = NULL;
   843		const char *irq_name = "pci-ep-test-doorbell-embedded";
   844		u32 status = le32_to_cpu(reg->status);
   845		struct pci_epf *epf = epf_test->epf;
   846		struct pci_epc *epc = epf->epc;
   847		struct device *dev = &epf->dev;
   848		enum pci_barno bar;
   849		size_t align_off;
   850		unsigned int i;
   851		int cnt, ret;
   852		u32 db_off;
   853	
   854		cnt = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
   855						   NULL, 0);
   856		if (cnt <= 0) {
   857			dev_err(dev, "No remote resources available for embedded doorbell\n");
 > 858			goto set_status_err;
   859		}
   860	
   861		struct pci_epc_remote_resource *resources __free(kfree) =
   862					kcalloc(cnt, sizeof(*resources), GFP_KERNEL);
   863		if (!resources)
   864			goto set_status_err;
   865	
   866		ret = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
   867						   resources, cnt);
   868		if (ret < 0) {
   869			dev_err(dev, "Failed to get remote resources: %d\n", ret);
   870			goto set_status_err;
   871		}
   872		cnt = ret;
   873	
   874		for (i = 0; i < cnt; i++) {
   875			if (resources[i].type == PCI_EPC_RR_DMA_CTRL_MMIO)
   876				dma_ctrl = &resources[i];
   877			else if (resources[i].type == PCI_EPC_RR_DMA_CHAN_DESC &&
   878				 !chan0)
   879				chan0 = &resources[i];
   880		}
   881	
   882		if (!dma_ctrl || !chan0) {
   883			dev_err(dev, "Missing DMA ctrl MMIO or channel #0 info\n");
   884			goto set_status_err;
   885		}
   886	
   887		bar = pci_epc_get_next_free_bar(epf_test->epc_features,
   888						epf_test->test_reg_bar + 1);
   889		if (bar < BAR_0) {
   890			dev_err(dev, "No free BAR for embedded doorbell\n");
   891			goto set_status_err;
   892		}
   893	
   894		ret = pci_epf_align_inbound_addr(epf, bar, dma_ctrl->phys_addr,
   895						 &epf_test->db_bar.phys_addr,
   896						 &align_off);
   897		if (ret)
   898			goto set_status_err;
   899	
   900		db_off = chan0->u.dma_chan_desc.db_offset;
   901		if (db_off >= dma_ctrl->size ||
   902		    align_off + db_off >= epf->bar[bar].size) {
   903			dev_err(dev, "BAR%d too small for embedded doorbell (off %#zx + %#x)\n",
   904				bar, align_off, db_off);
   905			goto set_status_err;
   906		}
   907	
   908		epf_test->db_variant = PCI_EPF_TEST_DB_EMBEDDED;
   909	
   910		ret = request_irq(chan0->u.dma_chan_desc.irq,
   911				  pci_epf_test_doorbell_embedded_irq_handler,
   912				  IRQF_SHARED, irq_name, epf_test);
   913		if (ret) {
   914			dev_err(dev, "Failed to request embedded doorbell IRQ: %d\n",
   915				chan0->u.dma_chan_desc.irq);
   916			goto err_cleanup;
   917		}
   918		epf_test->db_irq = chan0->u.dma_chan_desc.irq;
   919	
   920		reg->doorbell_data = cpu_to_le32(0);
   921		reg->doorbell_bar = cpu_to_le32(bar);
   922		reg->doorbell_offset = cpu_to_le32(align_off + db_off);
   923	
   924		epf_test->db_bar.barno = bar;
   925		epf_test->db_bar.size = epf->bar[bar].size;
   926		epf_test->db_bar.flags = epf->bar[bar].flags;
   927	
   928		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
   929		if (ret)
   930			goto err_cleanup;
   931	
   932		status |= STATUS_DOORBELL_ENABLE_SUCCESS;
   933		reg->status = cpu_to_le32(status);
   934		return;
   935	
   936	err_cleanup:
   937		pci_epf_test_doorbell_cleanup(epf_test);
   938	set_status_err:
   939		status |= STATUS_DOORBELL_ENABLE_FAIL;
   940		reg->status = cpu_to_le32(status);
   941	}
   942	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

