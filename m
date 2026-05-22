Return-Path: <dmaengine+bounces-10745-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIzjIidiEGphWwYAu9opvQ
	(envelope-from <dmaengine+bounces-10745-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:03:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F455B5C30
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BE333100432
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460E44CF44;
	Fri, 22 May 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iINdEIQu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FFD407592;
	Fri, 22 May 2026 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457751; cv=none; b=lpgvx5m030JIBfXZMsKqLtZzi6xO+rBaZI5Ve59HuJvonGN8kmmMiDKTB0hHaQiZMMkPsCHVtcIyyY13XtIiT3vl+6VTz0+zdGfyDWNBF/KCi4+6CeaGzRf4ENqlvcF33FawW73vlIBiZbdoF+mK2NU1qvVgnK1F3WsBa5nPcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457751; c=relaxed/simple;
	bh=1IqFCVbPyidY3VUJo+vm7c+lHUfIRJf2KhiGE8jVvz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1Ac7Xk9FsfrT1MmtP5weg27Tz3zZxByNQaMGPlWss7KsRBB3Mvt7PPlHcwLGknYoHCqlfRmA0u7iTmcU1yDWvbK/K+26ikMlOGzPI+xPVB92mf4mDS83yhAQTo5Ac4BtzKpg+kglCUZHHnMHywFmMdKQ+M/fes2XiBfF8QSjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iINdEIQu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779457749; x=1810993749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1IqFCVbPyidY3VUJo+vm7c+lHUfIRJf2KhiGE8jVvz0=;
  b=iINdEIQumATWyweaj+zl51+wlGRLvybO2+OomF/faGnCzlnRb5OCt1ev
   SULJ82OwcXz3nLqg87m6fN0bo6ooYHsX1JjtGg8Km3ioTs942y2lHYdpU
   toWhuRHwmNfAM88TmTLFN19M/SqLo5ViH78FjPU65L+8xscu1cqThXBCt
   EE2f8XlIyKNTP/cS5UOPA418pmdqo+j2jUNPMeAsm2XwDboRCvVXwiHjW
   SoAtzDzuNUlKuW0MQ6ZmfTVZiO/TZbZlaxtFZzZ69cq2MOZ/yC7//RBH6
   XxtDoMp9B8hMYlKZDunKwack4ZlB/r+c5nwgVj63e1aS5UUBJhCC6N8TI
   g==;
X-CSE-ConnectionGUID: O2w/9PU3T4ShF8FmxklEEw==
X-CSE-MsgGUID: KfJEFmAOTRKc9G3mdgJmiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="67910121"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="67910121"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 06:49:08 -0700
X-CSE-ConnectionGUID: 2AsZHcyWQB26rJvUU55MJA==
X-CSE-MsgGUID: J7evV2eVRqm0uwtcGX4vuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="241148171"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 May 2026 06:49:06 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQQFL-000000002Ur-2sBn;
	Fri, 22 May 2026 13:49:03 +0000
Date: Fri, 22 May 2026 21:48:34 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	"(open list:LIBATA SUBSYSTEM \\(Serial and Parallel ATA drivers\\))" <linux-ide@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: bestcomm: Enable compile testing
Message-ID: <202605222111.yK5iSsqD-lkp@intel.com>
References: <20260520223704.39320-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520223704.39320-1-rosenp@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-10745-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E7F455B5C30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v7.1-rc4 next-20260521]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/dmaengine-bestcomm-Enable-compile-testing/20260521-063851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20260520223704.39320-1-rosenp%40gmail.com
patch subject: [PATCH] dmaengine: bestcomm: Enable compile testing
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260522/202605222111.yK5iSsqD-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260522/202605222111.yK5iSsqD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605222111.yK5iSsqD-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mpc5xxx_fwnode_get_bus_frequency" [drivers/ata/pata_mpc52xx.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

