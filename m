Return-Path: <dmaengine+bounces-2796-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629EC947F7D
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 18:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF9A1C21A6E
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576715C14C;
	Mon,  5 Aug 2024 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SChB3d5J"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833C3E479;
	Mon,  5 Aug 2024 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876013; cv=none; b=cxPCkVGf0xFA/Nkq+kAYBmLmC31O0WweeftCLML4pUWoSO6oCBnjgoCe+N7buNDozdgXIYxBPPQVGuQ1eKfw6JUPpnsIAWEg6bCNia4WrvClEBcJvGvVWzzIzSU/KaZSXRobLF9el1Nm5C8BwGtsJ5U6DVVpdfPsrQNozwDQT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876013; c=relaxed/simple;
	bh=iOLUluY5An/v5NUsmhvgSEoNjYlEKm9MqBVeCIp+V5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kufm0ctr3XTbzrF19WLCkACOfJ8/XznIdLwvqSE3ImjY05403IuWv75FX0ThT0OMBgO5DA8wu3dtVdQBKcDTWBLcIKb+5fJl0C/tHhjN0lqb/MTsDnHg29M2HbGgcM6Y2s0uFPIgSITyjjFPZIgEZt3CVEF8xA70fLmCT7LHq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SChB3d5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3050AC32782;
	Mon,  5 Aug 2024 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722876013;
	bh=iOLUluY5An/v5NUsmhvgSEoNjYlEKm9MqBVeCIp+V5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SChB3d5J9h4l8uw17ZrW5gk7a9QaS3yzKU0RZ9RfahroRTz7qfv9HGwLK+b5mD0Sc
	 Ox6+wFqtDhtUvS+JO6JNL2vw/TBUXrH8g8hqqFzJBFRBNq40ih1hpRmo7j739yaZ3e
	 o6Bln0tIoJ6iGQMrTuqkIOMdvM0hNiamlNivhHnjZ7ewg6k0X64XFPAArADbReXC6C
	 TZZThGp1y+mJ/6iNzAkimRC06/PqcbfOMlCaHbJ0mFZ1oOkK9lWLd2pButThIG9w9b
	 8nckuSMcUXw8LLSc/GSBAWbgMuV/BAH4nKOEDIwPeWVCf0Z+np74xWfYbUrmKNPjw6
	 EvbZjRSDiZh9A==
Date: Mon, 5 Aug 2024 22:10:08 +0530
From: Vinod Koul <vkoul@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v11 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA
 driver
Message-ID: <ZrEAaB_I1S2vM2EE@matsya>
References: <20240802-loongson1-dma-v11-2-85392357d4e0@gmail.com>
 <202408051242.8kGK28W7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408051242.8kGK28W7-lkp@intel.com>

On 05-08-24, 12:58, kernel test robot wrote:
> Hi Keguang,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 048d8cb65cde9fe7534eb4440bcfddcf406bb49c]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Keguang-Zhang-via-B4-Relay/dt-bindings-dma-Add-Loongson-1-APB-DMA/20240803-111220
> base:   048d8cb65cde9fe7534eb4440bcfddcf406bb49c
> patch link:    https://lore.kernel.org/r/20240802-loongson1-dma-v11-2-85392357d4e0%40gmail.com
> patch subject: [PATCH v11 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
> config: sparc64-randconfig-r063-20240804 (https://download.01.org/0day-ci/archive/20240805/202408051242.8kGK28W7-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408051242.8kGK28W7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408051242.8kGK28W7-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/dma/loongson1-apb-dma.c: In function 'ls1x_dma_chan_probe':
> >> drivers/dma/loongson1-apb-dma.c:520:34: warning: '%u' directive writing between 1 and 10 bytes into a region of size 2 [-Wformat-overflow=]
>      520 |         sprintf(pdev_irqname, "ch%u", chan_id);
>          |                                  ^~
>    drivers/dma/loongson1-apb-dma.c:520:31: note: directive argument in the range [0, 2147483646]
>      520 |         sprintf(pdev_irqname, "ch%u", chan_id);
>          |                               ^~~~~~
>    drivers/dma/loongson1-apb-dma.c:520:9: note: 'sprintf' output between 4 and 13 bytes into a destination of size 4
>      520 |         sprintf(pdev_irqname, "ch%u", chan_id);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Pls fix these warnings!

-- 
~Vinod

