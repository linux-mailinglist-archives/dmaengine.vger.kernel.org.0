Return-Path: <dmaengine+bounces-2734-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE493BC44
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2024 07:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D471F239A1
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2024 05:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DC614EC5C;
	Thu, 25 Jul 2024 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfDeQ8Rk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963014E2F5;
	Thu, 25 Jul 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721887069; cv=none; b=QpXbAzbgVTeeucZ3RuSLKTVaJov7SVHZeE71/lMA+250CTCMfd8noeZTgHe6zdwR5i5HvAGL2sSWbsqrstggVywix5pSl0VQ2sYjn6tgcr/mfuh9O4lkNrhbDaBvNqaV7wYsyD3YZoARCaRyinwCkstzlqoSTyuHdyU7WpQiyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721887069; c=relaxed/simple;
	bh=Xzo+/0fKEArw98UEUgyX6dDr16x8+/w97OLWloTwTPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPWEGdSaknn0D2HjNO0wxO5k8+XJcgTMQercjLyVUFQmS79EZTUUWIwuiZoEuDNWlv3Ctk4vDxEihxDuQL5XwEno0G3o3xDIpuR5hTj0Y3TX4JEAvuVdp0bQm+EGMoBTfP4g6NNpANKcF0ava28CMHRTs7wKpQf6TlXtR451aCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfDeQ8Rk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D417CC116B1;
	Thu, 25 Jul 2024 05:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721887068;
	bh=Xzo+/0fKEArw98UEUgyX6dDr16x8+/w97OLWloTwTPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfDeQ8RkYPzzsKdE0libkMbEAdJRuiyi5kkV5F2ZK6X2KAEzZJTV13vPEOLiPm4BO
	 ZxDI7mFTtg+L8GpXxhXatA2Z1h4whLXFUxM9ePFm6fN3pKZAMsfI0IoUhmadHAlUs4
	 itiI3Lj7dclY2VD6BdYjdXO8KtMZ2Fc7SVRMXHkC+5TpvNSV3pk3oImAbEd40q+znj
	 D2Uil+oJ1nCSoFNX10mNkCae+W92AbCKZoniuQyQs0nL5LbMdZczZsGI9HE9UVceRS
	 s86u5jlhXP0S5nKRdtGu7CTqaGWvv0dFU/ZUKO6WJKHc4JAD39UKE6XYMQOBi1K1I7
	 IUWsYb6OD/Q4g==
Date: Thu, 25 Jul 2024 11:27:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>,
	kernel test robot <lkp@intel.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH RESEND v9 2/2] dmaengine: Loongson1: Add Loongson-1 APB
 DMA driver
Message-ID: <ZqHpWKLhRUi0N5Ps@matsya>
References: <20240711-loongson1-dma-v9-2-5ce8b5e85a56@gmail.com>
 <202407140536.iIizeGVy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407140536.iIizeGVy-lkp@intel.com>

On 14-07-24, 05:11, kernel test robot wrote:
> Hi Keguang,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on d35b2284e966c0bef3e2182a5c5ea02177dd32e4]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Keguang-Zhang-via-B4-Relay/dt-bindings-dma-Add-Loongson-1-APB-DMA/20240711-191657
> base:   d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> patch link:    https://lore.kernel.org/r/20240711-loongson1-dma-v9-2-5ce8b5e85a56%40gmail.com
> patch subject: [PATCH RESEND v9 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240714/202407140536.iIizeGVy-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240714/202407140536.iIizeGVy-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407140536.iIizeGVy-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/printk.h:598,
>                     from include/asm-generic/bug.h:22,
>                     from arch/x86/include/asm/bug.h:87,
>                     from include/linux/bug.h:5,
>                     from include/linux/fortify-string.h:6,
>                     from include/linux/string.h:374,
>                     from include/linux/scatterlist.h:5,
>                     from include/linux/dmapool.h:14,
>                     from drivers/dma/loongson1-apb-dma.c:8:
>    drivers/dma/loongson1-apb-dma.c: In function 'ls1x_dma_start':
> >> drivers/dma/loongson1-apb-dma.c:137:34: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
>      137 |         dev_dbg(chan2dev(dchan), "cookie=%d, starting hwdesc=%x\n",

You should not use %x for dma_addr_t, please see documentation

-- 
~Vinod

