Return-Path: <dmaengine+bounces-1855-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E58A7468
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 21:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233C8B21720
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6D137C29;
	Tue, 16 Apr 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGLnjAW1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC5137920;
	Tue, 16 Apr 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294811; cv=none; b=E3z/x4gsWKD1/xLZGiD6bGLaCCbB0mRM2BeBSYDZ5RXlAIJzTybaOzlTFHpYRxwm5v9k7nzngOFExURDtGZUk9H5bhFrP71DXFU/oUjjBcQXFkxL0rfLNmB4reKo2EBLwUmaqLYPZT5I3ZmIup3mo7Z1ztjecysMRmS2R8wp9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294811; c=relaxed/simple;
	bh=WidDV0+cydjYUFBcrsXyNgs1N16QDq4Ayftcy1ggqFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNq8GF3bl3kCxu8pjs/p57buJZVtd92Urqxz95XnP9SA/LurbLlr/eFiury6z9fiS7QlyVy6ALTzJmBRiwQNlmkox3kxffd2pOy+cymFi9XuUTImDdoTsQVa3aDatUlvssKZzTFuJabWN8r/3ntw/QdKxGJY6FxdACsxLTtwVzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGLnjAW1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713294810; x=1744830810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WidDV0+cydjYUFBcrsXyNgs1N16QDq4Ayftcy1ggqFE=;
  b=bGLnjAW1MbqBaO1Ogi24qI7MuBsIDEPpOHbxtmUNh53L5FzpKMJ6alpX
   gzUbj2PzhHxs9v9bhFUOwHxA1ufoqL8Y17HzOuo9gQMko6ZUbkL7st/o0
   phP0MPazk6Y6jR7oknzmAkpsheUKA9MVQMMVrpA9wUVoJJGeP/rgeplUG
   qvu12H6lrdsYPWas7+xmvgyXTOHXd7jzv7sF2GFTe/zQydgfpfLFEMMWy
   CT/cs6GHiscRC5nXftIKL1/YUKl+7/ytrwVsdI2GR4CV34gCYxT+Ljcfr
   NPwpUq+RiEfwLI7A4N5HuA1sP2twdFLZsSZHP57L+zaIJ8JtMMvGJRoPX
   A==;
X-CSE-ConnectionGUID: P7t9CeurTv+JCu/j8sTLuw==
X-CSE-MsgGUID: xFWTUOONSfe0dXVfVfH32A==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26268086"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="26268086"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 12:13:29 -0700
X-CSE-ConnectionGUID: rpK+ZSyiR3mB73v5+CjGHQ==
X-CSE-MsgGUID: qdEqqAxwQqaa96/cPZSPtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22768609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 12:13:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwoFA-00000004ngn-0THg;
	Tue, 16 Apr 2024 22:13:24 +0300
Date: Tue, 16 Apr 2024 22:13:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] dmaengine: dw: Fix src/dst addr width misconfig
Message-ID: <Zh7N0-D-TJ1OXqli@smile.fi.intel.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416162908.24180-1-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 07:28:54PM +0300, Serge Semin wrote:
> The main goal of this series is to fix the data disappearance in case of
> the DW UART handled by the DW AHB DMA engine. The problem happens on a
> portion of the data received when the pre-initialized DEV_TO_MEM
> DMA-transfer is paused and then disabled. The data just hangs up in the
> DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
> suspension (see the second commit log for details). On a way to find the
> denoted problem fix it was discovered that the driver doesn't verify the
> peripheral device address width specified by a client driver, which in its
> turn if unsupported or undefined value passed may cause DMA-transfer being
> misconfigured. It's fixed in the first patch of the series.
> 
> In addition to that two cleanup patch follow the fixes described above in
> order to make the DWC-engine configuration procedure more coherent. First
> one simplifies the CTL_LO register setup methods. Second one simplifies
> the max-burst calculation procedure and unifies it with the rest of the
> verification methods. Please see the patches log for more details.

Thank you for this.
I have looked into all of them and most worrying (relatively to the rest) to me
is the second patch that does some tricks. The rest are the cosmetics that can
be easily addressed.

-- 
With Best Regards,
Andy Shevchenko



