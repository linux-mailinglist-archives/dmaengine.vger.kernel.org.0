Return-Path: <dmaengine+bounces-10024-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NUqCBIS4mkg1AAAu9opvQ
	(envelope-from <dmaengine+bounces-10024-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2026 12:57:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961F41A7AD
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2026 12:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83E0B300ADB3
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2026 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E23383C69;
	Fri, 17 Apr 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSqczjzY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400213B38A2;
	Fri, 17 Apr 2026 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423395; cv=none; b=CTQ0cL5Hskjgxwtb5ragJJFSmm+EZkkskuAMvQ5t7C5SpAHJH9gFDal5iqCU3iR7Q6AfTB8MeFrPT3rYqx6zQxrFt0nwLUOTteg25ISzjMU6BuU3pkhdgIXgxo36orZ6iBINurbJfSwu1h0yzq67brElYJUatcDHQ83G/dAWb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423395; c=relaxed/simple;
	bh=bDDxe6yCiiX0HBvBrYA3XwWhcLpDG14hB3Lfi/7cuzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgxKbG4rkIEdvJOjVZ52OZisWp/YUN2lSNKHzLMKbYcvi7nHNb0SiKfXECwhNQ08MGU1x+rgtpKGPRVQtSmD0dbEKqScIynDnlx0wRMlE+rIYe4YYFtrc6ty0PZGz6B/03JkhVUS3qxTUc2DHPZpxh4K7CvrTj9xtC9mgqErQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSqczjzY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776423394; x=1807959394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bDDxe6yCiiX0HBvBrYA3XwWhcLpDG14hB3Lfi/7cuzY=;
  b=eSqczjzYqUFDfVsr/W93+PefGyl5dn9/yhgJdwac4y3GXM83r1NW3VRv
   S723yLE641/IZZCw/fw2OtNxMikbI5s1s+2y5GhgTw1KV/LHm9O2Rs4gO
   CsQYh01Vr/1mvgKGX/Do2oHIrW1oVkdMboFS3sRxpXqB8tTqxEgf7VVnG
   HAd4+k0JwibULjCjls9RPS+6cQWiLFELnVSyM8Opr4uztKmJQYFOY35Ke
   ip7TPM/jqYeyK5ffuwFzAvpFsngn2dl8iPmfuC+SrW2ZjG9cQhx4fZx64
   +qFhtf4kK1ijNub7vv4TMDK4K7KnxNwwnPGkS/CRl2er/3/8kDL43C1ah
   A==;
X-CSE-ConnectionGUID: B3ckPEknSzK04UUIvwJg0g==
X-CSE-MsgGUID: JITddxxOQcu3b/7KFxDOKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77345757"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="77345757"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 03:56:34 -0700
X-CSE-ConnectionGUID: 8jrViil9RjmICwdPWfiZYg==
X-CSE-MsgGUID: 4TaKAjvgR4Scv1JD5xJTzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="235995089"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Apr 2026 03:56:33 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDgs9-000000000HR-3TGn;
	Fri, 17 Apr 2026 10:56:29 +0000
Date: Fri, 17 Apr 2026 18:55:41 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: add COMPILE_TEST to AMBA_PL08X
Message-ID: <202604171853.KZzzfda6-lkp@intel.com>
References: <20260407035104.98985-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407035104.98985-1-rosenp@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10024-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 4961F41A7AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v7.0 next-20260416]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/dma-add-COMPILE_TEST-to-AMBA_PL08X/20260414-134925
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20260407035104.98985-1-rosenp%40gmail.com
patch subject: [PATCH] dma: add COMPILE_TEST to AMBA_PL08X
config: m68k-randconfig-r062-20260417 (https://download.01.org/0day-ci/archive/20260417/202604171853.KZzzfda6-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260417/202604171853.KZzzfda6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604171853.KZzzfda6-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/dma/amba-pl08x.o: in function `pl08x_probe':
>> amba-pl08x.c:(.text+0x183c): undefined reference to `amba_request_regions'
>> m68k-linux-ld: amba-pl08x.c:(.text+0x18ae): undefined reference to `amba_release_regions'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

