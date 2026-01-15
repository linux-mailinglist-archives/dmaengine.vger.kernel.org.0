Return-Path: <dmaengine+bounces-8272-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C5FD2432D
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 12:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F93D301CF81
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCF03793DF;
	Thu, 15 Jan 2026 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuS7t6XS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE793793C1;
	Thu, 15 Jan 2026 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476607; cv=none; b=fJ07QUeOxq7Ztbo4TiFqsv5DvBuYU5BsOt+P+wzBCu8ugL5VXn7ghbEYP0T6rqxkusVPDu6OKzTIxb63DOidOlIk1jU4jGHZHndxAXU2H18pMjbDkgQmnKkUArV67PPLnIHgcDmXUqlDDauWq16NURiNwuTbq5muapDUwZCoDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476607; c=relaxed/simple;
	bh=sPpPbvhryAMe1NmcPn+z0LM6XHiUVy15HOBXB0+Othg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEr6OHZKpHxDtETXVbxvP2GlYpUW5WB5SgmkLxxSpkIA0PL0ql+qvoBgKN62dVyqshyzvzrZszjLJtihJURyN1+F8i5ds3Dz9ncdr7wKopUpRwqbxoc/QxA1z5og0pFP8gfu3meDs4Xr90tGXDVICP/MKt8wvMaQdfZDO6lDcWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuS7t6XS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768476605; x=1800012605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sPpPbvhryAMe1NmcPn+z0LM6XHiUVy15HOBXB0+Othg=;
  b=QuS7t6XSFUNZVTyrjEGyBS43jCb/q+ZZqRUha4q1+k0u+uKL0bqKvvrM
   K1YFw36DZ2v0yKHHzi9u/uxL4qije3q+wQ9d3US/dqU13UVEv6utPVKT4
   gk9IfZ9QVRXj5kJhBfYuxepmW9Izfg8mfkErOCN08o4W9IzycvXgbmkjT
   gd0xj7qONYlP+Xx1bkt5K9RdhFY72vLELdoJcKoi94ZyrDQHA2qDzW2Ll
   ax4+hsrB9qh4Hv8al4MZZWQnIp7G5tJMWtE4MJesI4lsoNzwu9hyFez3n
   rH6aE8mtvfUqGbUTIFLU9d/ifE5ZCv8xZz11MA+3sA4FyE6nZzoLBaXK+
   g==;
X-CSE-ConnectionGUID: Y0cIYDnaTNmjFqgFS6C/tQ==
X-CSE-MsgGUID: ivlD26D8QZOwVpy7Wc4JIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="72365563"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="72365563"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 03:30:04 -0800
X-CSE-ConnectionGUID: wowK3yctQJ6kdZmJLCRrOg==
X-CSE-MsgGUID: I0F7nP7lR+Wm+3bfXfMI7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="235643729"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Jan 2026 03:30:01 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgLY6-00000000Hsy-0Utw;
	Thu, 15 Jan 2026 11:29:58 +0000
Date: Thu, 15 Jan 2026 19:29:47 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 01/13] dmaengine: of_dma: Add
 devm_of_dma_controller_register()
Message-ID: <202601151942.cEs9s8Tj-lkp@intel.com>
References: <20260114-mxsdma-module-v1-1-9b2a9eaa4226@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-mxsdma-module-v1-1-9b2a9eaa4226@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-of_dma-Add-devm_of_dma_controller_register/20260115-063955
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20260114-mxsdma-module-v1-1-9b2a9eaa4226%40nxp.com
patch subject: [PATCH 01/13] dmaengine: of_dma: Add devm_of_dma_controller_register()
config: x86_64-randconfig-r071-20260115 (https://download.01.org/0day-ci/archive/20260115/202601151942.cEs9s8Tj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
smatch version: v0.5.0-8985-g2614ff1a
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601151942.cEs9s8Tj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601151942.cEs9s8Tj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/tty/serial/fsl_lpuart.c:22:
>> include/linux/of_dma.h:88:1: error: return type defaults to 'int' [-Werror=implicit-int]
      88 | devm_of_dma_controller_register(struct device *dev, struct device_node *np,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/int +88 include/linux/of_dma.h

    86	
    87	static inline
  > 88	devm_of_dma_controller_register(struct device *dev, struct device_node *np,
    89					struct dma_chan *(*of_dma_xlate)
    90					(struct of_phandle_args *, struct of_dma *),
    91					void *data)
    92	{
    93		return -ENODEV;
    94	}
    95	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

