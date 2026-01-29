Return-Path: <dmaengine+bounces-8587-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dH/7N666e2l0IAIAu9opvQ
	(envelope-from <dmaengine+bounces-8587-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 20:53:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 359A8B4190
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 20:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB98F3016ED0
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 19:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF98328B79;
	Thu, 29 Jan 2026 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UnHjAnmB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE72D594B;
	Thu, 29 Jan 2026 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769716396; cv=none; b=ufT86SYEOxV4HsaPkhmKxE9W0dKmLGcUuO2DA27duWt1XU+dW7OYqfzGpZgxQe4f5eTuUDzEAiaAvqv12stkpkKK7E7GQbX78YPcIEW/d5tsI9rQrTCzX0bQugXkBgOjUlgk5r+abrzrmDqOCcTENGT/RkLK+zdY+Y2Bn2rxKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769716396; c=relaxed/simple;
	bh=E0h/vVHA7OHJSA8zS2ZJtnFZdOA/wFH2xKAx5XGXzLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXIXNgaoY3ZVQUQRNbgnquwRTlPiVv+Yk7UadTpHypeYVuvRiWYp435w2OPbGY9f2SdFjGEsj/pC0CYb729noDwuSaaIDDuno0KgWkZh9w2oE7wlSNJVWjBMGEGTLzGS4UASRI8yUF0WRmESeWQfhzBwfZRpvJ9dQjqQg4tQZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UnHjAnmB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769716394; x=1801252394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E0h/vVHA7OHJSA8zS2ZJtnFZdOA/wFH2xKAx5XGXzLM=;
  b=UnHjAnmBgZtt41Zz7zOIfbL2NvOXhKTTq6b/CISJjlXFIKeoZ2Kliosd
   s7fSb3ZyIdP4GOAC1yFsigYVcV9mf0B4XK8y2Qqddb66dMF1nwzg9EuEO
   7HSfY/aZuQfAo8Ow0SgHXsqVckwLSUNa32eZR/MBk9VLrdjWHu4xn4SKv
   OMxQhSuI9OZN0VayxDeZPl0SIv/e6raBBFy/AgChTgpmbB3xj0UkoWOtj
   MmAeKVVoiCF9lIEuh+OUc37XbQH4Omvni93L27qfR6b7YzHKoCDtoL0QR
   qP3OesmSFxyssoLqJxYeeB0gWCE7itGyZKpYZ+3ngW4ITUCHmCo5ekkLT
   Q==;
X-CSE-ConnectionGUID: 1HQvzkONQROge+raWO/q5g==
X-CSE-MsgGUID: qjVxS/ofSLGSED88O44n7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="73565152"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="73565152"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 11:53:13 -0800
X-CSE-ConnectionGUID: Yk5qJfaKTr25Imd9twLazQ==
X-CSE-MsgGUID: 0nLfnOvTSq2Cn58Ck8DleA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="231582236"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 29 Jan 2026 11:53:12 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlY4k-00000000bpE-0HnU;
	Thu, 29 Jan 2026 19:53:10 +0000
Date: Fri, 30 Jan 2026 03:52:58 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v1 1/1] dmaengine: idma64: switch to
 DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <202601300349.PfvsP7uV-lkp@intel.com>
References: <20260129104916.200484-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129104916.200484-1-andriy.shevchenko@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8587-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: 359A8B4190
X-Rspamd-Action: no action

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.19-rc7 next-20260129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/dmaengine-idma64-switch-to-DEFINE_SIMPLE_DEV_PM_OPS/20260129-185309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20260129104916.200484-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] dmaengine: idma64: switch to DEFINE_SIMPLE_DEV_PM_OPS()
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260130/202601300349.PfvsP7uV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601300349.PfvsP7uV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601300349.PfvsP7uV-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/dma/idma64.c:690:68: error: macro "DEFINE_SIMPLE_DEV_PM_OPS" requires 3 arguments, but only 2 given
     690 | static DEFINE_SIMPLE_DEV_PM_OPS(idma64_pm_suspend, idma64_pm_resume);
         |                                                                    ^
   In file included from include/linux/device.h:25,
                    from include/linux/dmaengine.h:8,
                    from drivers/dma/idma64.c:11:
   include/linux/pm.h:416:9: note: macro "DEFINE_SIMPLE_DEV_PM_OPS" defined here
     416 | #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/idma64.c:690:8: error: type defaults to 'int' in declaration of 'DEFINE_SIMPLE_DEV_PM_OPS' [-Wimplicit-int]
     690 | static DEFINE_SIMPLE_DEV_PM_OPS(idma64_pm_suspend, idma64_pm_resume);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:36,
                    from include/linux/random.h:7,
                    from include/linux/nodemask.h:94,
                    from include/linux/numa.h:6,
                    from include/linux/cpumask.h:15,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/sched.h:37,
                    from include/linux/delay.h:13,
                    from drivers/dma/idma64.c:10:
>> drivers/dma/idma64.c:697:41: error: 'idma64_dev_pm_ops' undeclared here (not in a function)
     697 |                 .pm     = pm_sleep_ptr(&idma64_dev_pm_ops),
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/util_macros.h:136:44: note: in definition of macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   drivers/dma/idma64.c:697:27: note: in expansion of macro 'pm_sleep_ptr'
     697 |                 .pm     = pm_sleep_ptr(&idma64_dev_pm_ops),
         |                           ^~~~~~~~~~~~
>> drivers/dma/idma64.c:690:8: warning: 'DEFINE_SIMPLE_DEV_PM_OPS' defined but not used [-Wunused-variable]
     690 | static DEFINE_SIMPLE_DEV_PM_OPS(idma64_pm_suspend, idma64_pm_resume);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/idma64.c:682:12: warning: 'idma64_pm_resume' defined but not used [-Wunused-function]
     682 | static int idma64_pm_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~
>> drivers/dma/idma64.c:674:12: warning: 'idma64_pm_suspend' defined but not used [-Wunused-function]
     674 | static int idma64_pm_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~


vim +/DEFINE_SIMPLE_DEV_PM_OPS +690 drivers/dma/idma64.c

   673	
 > 674	static int idma64_pm_suspend(struct device *dev)
   675	{
   676		struct idma64_chip *chip = dev_get_drvdata(dev);
   677	
   678		idma64_off(chip->idma64);
   679		return 0;
   680	}
   681	
 > 682	static int idma64_pm_resume(struct device *dev)
   683	{
   684		struct idma64_chip *chip = dev_get_drvdata(dev);
   685	
   686		idma64_on(chip->idma64);
   687		return 0;
   688	}
   689	
 > 690	static DEFINE_SIMPLE_DEV_PM_OPS(idma64_pm_suspend, idma64_pm_resume);
   691	
   692	static struct platform_driver idma64_platform_driver = {
   693		.probe		= idma64_platform_probe,
   694		.remove		= idma64_platform_remove,
   695		.driver = {
   696			.name	= LPSS_IDMA64_DRIVER_NAME,
 > 697			.pm	= pm_sleep_ptr(&idma64_dev_pm_ops),
   698		},
   699	};
   700	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

