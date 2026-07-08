Return-Path: <dmaengine+bounces-12098-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C2kxGR3dTWpA/QEAu9opvQ
	(envelope-from <dmaengine+bounces-12098-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:16:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 767CF721BF6
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:16:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Y4C5omGR;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12098-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12098-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4802300B47B
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 05:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797A13B8D50;
	Wed,  8 Jul 2026 05:16:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9379A3B95FA;
	Wed,  8 Jul 2026 05:16:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487771; cv=none; b=I9xnnPQGknnk6Xq/MOjId/G6ABXUZixNMLm6QRPPG4st4EbCCeo4Ng8YooPFSBa/STIb85OUkmajgpRCAzO5REoZguFHt6I0GjHO0IzcjZF5tK9tVndNLstw5lJkI9rFD+PGfL6g7UloKzbIKT0J8KZ4tbbd71ydB1rCT2LuTjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487771; c=relaxed/simple;
	bh=MR6Iu6D/1tgZuFmXVfRknoQ6Yhh0VHPYGspTosWqVyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAnHmF9Kjhtj5sDsQSSF+0oVQefDePKFbuGSU4K8kC/FuYRPkRM5tQcCNpOoJXozGGLfpDyqy3Wo6mK7xQPEw1ZMx2jt1T19rk4LJAFiGMbbeKdaPyobyrJ1oKMBou7GDRc7E3LZVlJFg4CBVOMYj6cuZCR18ZAsaVdTqAO9L60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4C5omGR; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783487766; x=1815023766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MR6Iu6D/1tgZuFmXVfRknoQ6Yhh0VHPYGspTosWqVyM=;
  b=Y4C5omGR0UeFGMb/rN+QTqeNMQX1P+YRAImO1/6kbwsow4Fg+0mGl0w1
   PLZ2O082yXFI0m1CTvI4qS1ou88Pk4YJ9q5nTPkK3sucK4pcFHpOlwkpz
   SSivilPzZMiqc1PLOKlVf2fR24846h8mSyjUN6pw1Bu4khD+W9q8tsJpW
   LqBih4T085YbTrXVazztvgpc4Zxn+VaP/puNxrytcL6zr+CdA14L8qfbc
   iL5votKL1P5SsLpYkUrZ102j+kTznkWgDyLxTnWV7cXZe8tQ2isz8sW3j
   OEdNPEmUWhJq7b+2xYCowiujCdEjB7JYVhJSIlNjJ3VEieDDIKnhHmTw+
   A==;
X-CSE-ConnectionGUID: edFRjh3xQ8uvugkocJQgkg==
X-CSE-MsgGUID: s/6+3ECWRNGSgkxKOgnnKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95658511"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95658511"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 22:16:05 -0700
X-CSE-ConnectionGUID: 1QCxjVsPQjSVcU2VkQIKRQ==
X-CSE-MsgGUID: sMGg6LCBTnqNN65ZafzhqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="247812743"
Received: from igk-lkp-server01.igk.intel.com (HELO e5a8ed462067) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 07 Jul 2026 22:16:03 -0700
Received: from kbuild by e5a8ed462067 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whKdd-000000002h3-09Ni;
	Wed, 08 Jul 2026 05:16:01 +0000
Date: Wed, 8 Jul 2026 07:15:51 +0200
From: kernel test robot <lkp@intel.com>
To: Bhargav Joshi <j.bhargav.u@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
	simona.toaca@nxp.com, j.bhargav.u@gmail.com
Subject: Re: [PATCH] dt-bindings: dma: ti,dma-crossbar: Convert to DT schema
Message-ID: <202607080708.nM6GUXuA-lkp@intel.com>
References: <20260708-ti-dma-crossbar-v1-1-f62796428f13@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-ti-dma-crossbar-v1-1-f62796428f13@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12098-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:j.bhargav.u@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk@kernel.org,m:conor+dt@kernel.org,m:vigneshr@ti.com,m:peter.ujfalusi@gmail.com,m:oe-kbuild-all@lists.linux.dev,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:goledhruva@gmail.com,m:m-chawdhry@ti.com,m:daniel.baluta@gmail.com,m:simona.toaca@nxp.com,m:jbhargavu@gmail.com,m:conor@kernel.org,m:peterujfalusi@gmail.com,m:danielbaluta@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com];
	FORGED_SENDER(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,ti.com,nxp.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 767CF721BF6

Hi Bhargav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhargav-Joshi/dt-bindings-dma-ti-dma-crossbar-Convert-to-DT-schema/20260708-053027
base:   0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
patch link:    https://lore.kernel.org/r/20260708-ti-dma-crossbar-v1-1-f62796428f13%40gmail.com
patch subject: [PATCH] dt-bindings: dma: ti,dma-crossbar: Convert to DT schema
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260708/202607080708.nM6GUXuA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607080708.nM6GUXuA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/zh_CN/how-to.rst references a file that doesn't exist: Documentation/xxx/xxx.rst
   Warning: Documentation/translations/zh_CN/networking/xfrm_proc.rst references a file that doesn't exist: Documentation/networking/xfrm_proc.rst
   Warning: Documentation/translations/zh_CN/scsi/scsi_mid_low_api.rst references a file that doesn't exist: Documentation/Configure.help
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/ABI/testing/sysfs-platform-ayaneo
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
   Warning: arch/powerpc/sysdev/mpic.c references a file that doesn't exist: Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
   Warning: drivers/net/ethernet/smsc/Kconfig references a file that doesn't exist: file:Documentation/networking/device_drivers/ethernet/smsc/smc9.rst
   Warning: rust/kernel/sync/atomic/ordering.rs references a file that doesn't exist: srctree/tools/memory-model/Documentation/explanation.txt
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: Documentation/virtual/lguest/lguest.c
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,\b(\S*)(Documentation/[A-Za-z0-9

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

