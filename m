Return-Path: <dmaengine+bounces-6309-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CDCB3F696
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA1C206463
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 07:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FE82E06C9;
	Tue,  2 Sep 2025 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLx38X9B"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60B257845;
	Tue,  2 Sep 2025 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797934; cv=none; b=HMFHW7eu5ZJe3Jii7s5KQw0zj+dCeKOynhTsPVpK/BOQlelE+gBGdBGGb7rckyKeELBDmQcXFVQPn4f+D6l/55S21HCbGnJ73ZFm4eCu+9aoQoSNjl20Nz/koP0GmEd0qCTtzsgK5tHkI/VYculK8r0ZSrGMth025dCRSyZhjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797934; c=relaxed/simple;
	bh=v7TB70HJ+44v/bJ2UIPB2lLgM9SlwIWN6K5LRHr65Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikj5hcqdxtwZAU83j+eb9cflss11Lgl5MVin5CYQvdsi/IBZoxMhB9spxdD1P5WXkDMH1HLkY7/UjlRoEVVusA9oEJXqRFyu8850vbdTtn7i5AphBPom9gbs8s5419Sh/+gOqqSCqUtFf6+bvVvc1OEx+2WtB62CCxsHHHR6KaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLx38X9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9369C4CEED;
	Tue,  2 Sep 2025 07:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756797933;
	bh=v7TB70HJ+44v/bJ2UIPB2lLgM9SlwIWN6K5LRHr65Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLx38X9BgYROyoM2o6TMTJpZyHkj9TsWM2xDd1BXI6a9mmK1zPBbVWKgLn83qewqc
	 bJdhNDlFtPEGLu7YrI+U10seQ5hiCWDsxHt/nhcmbToWMICZoMvAW3KvTOwFEoFC4b
	 shlU1LJwF4/23enCexcUEVm800xwi2dg27KEIDlC0hzk8957HQHnydLJrJJllMXs2r
	 AdZTxY8JeEabXFFLRFN5RrHYP3/M1LjTekGqYMZbWUuHBa8dlM+XBR0iZ3pAcD75oS
	 IzIEClpGiRBsnpZoMDKRW2I99/BUp0F3rVu22hS1TEdhxYfppVUzn/q/3GpgauYqUH
	 UCK6RAoj03dJA==
Date: Tue, 2 Sep 2025 12:55:27 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Yi Sun <yi.sun@intel.com>
Cc: vinicius.gomes@intel.com, dave.jiang@intel.com,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	gordon.jin@intel.com, fenghuay@nvidia.com, yi1.lai@intel.com,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [PATCH v3 1/2] dmaengine: idxd: Expose DSA3.0 capabilities
 through sysfs
Message-ID: <aLab55JCvLcbOm0S@vaman>
References: <20250821085111.1430076-1-yi.sun@intel.com>
 <20250821085111.1430076-2-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821085111.1430076-2-yi.sun@intel.com>

On 21-08-25, 16:51, Yi Sun wrote:
> Introduce sysfs interfaces for 3 new Data Streaming Accelerator (DSA)
> capability registers (dsacap0-2) to enable userspace awareness of hardware
> features in DSA version 3 and later devices.
> 
> Userspace components (e.g. configure libraries, workload Apps) require this
> information to:
> 1. Select optimal data transfer strategies based on SGL capabilities
> 2. Enable hardware-specific optimizations for floating-point operations
> 3. Configure memory operations with proper numerical handling
> 4. Verify compute operation compatibility before submitting jobs
> 
> The output format is <dsacap2>,<dsacap1>,<dsacap0>, where each DSA
> capability value is a 64-bit hexadecimal number, separated by commas.
> The ordering follows the DSA 3.0 specification layout:
>  Offset:    0x190    0x188    0x180
>  Reg:       dsacap2  dsacap1  dsacap0
> 
> Example:
> cat /sys/bus/dsa/devices/dsa0/dsacaps
>  000000000000f18d,0014000e000007aa,00fa01ff01ff03ff

sysfs are supposed to be single values only, should we rather do per
capability? Also in future if you have more than three...? what happens
then?

-- 
~Vinod

