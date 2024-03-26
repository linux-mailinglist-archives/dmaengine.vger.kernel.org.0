Return-Path: <dmaengine+bounces-1516-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E02D88C5EB
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 15:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA911F63900
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB9E13C80F;
	Tue, 26 Mar 2024 14:53:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3213C809;
	Tue, 26 Mar 2024 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464804; cv=none; b=reyXTS3nmeE30abO6/XdFbNk9TTtAE5WzLimOLuzl9BhwIMH8sNNiX1arTgcUgBLPJXnRTM7xMecnIX2VKXRyEke2cI0iTvSsJRkFgbVzHl8ndJK+0raqZUtUOH/KRQPhkiC1xhvQ6EDuoV1gRH0tEODp8CJVp0AFoK6Gve4XZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464804; c=relaxed/simple;
	bh=Sxpuzis818g33XaA/nNCRA+K2FZNjUkOrkHHjScAvXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt0noE9t5agmdJvHBwLZq2qySjSmpRk2XAt+tc8s6rYNb6xO5YEgbdv6x0RkkDF18FmcNiM3TocFXBKJo2leEgoQOzx8l0Dl1V6XJ3DuPMqhqQ79YTgiTFUDU24je0qqHZHfRrUTUED+Llyy9eMd7blJAYzka2AQnpCcK9H1AY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Wj7kzTgcRAmabAGb5ciqwA==
X-CSE-MsgGUID: xgHfqc95TwSLwHQmJgalNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="28999629"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="28999629"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914882499"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914882499"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:53:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rp8Av-0000000GKce-2zLk;
	Tue, 26 Mar 2024 16:53:17 +0200
Date: Tue, 26 Mar 2024 16:53:17 +0200
From: Andy Shevchenko <andy@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	dmaengine@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 00/38] ep93xx device tree conversion
Message-ID: <ZgLhXanNnQ147rUP@smile.fi.intel.com>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 12:18:27PM +0300, Nikita Shubin via B4 Relay wrote:
> The goal is to recieve ACKs for all patches in series to merge it via Arnd branch.
> 
> Some changes since last version (v8):
> 
> - Most important, fixed bug in Device Tree resulting in CS4271 not working by Alexander Sverdlin.
> - added #interrupt-cells to gpio nodes with interrupts-controller
> - fixed some EOF in dtsi files
> - fixed identation and type in ep93xx-keypad thanks to Andy Shevchenko
> 
> Stephen Boyd, Vinod Koul PLEASE! give some comments on following, couse i
> hadn't one for a couple of iterations already:


>       clk: ep93xx: add DT support for Cirrus EP93xx

>       dma: cirrus: Convert to DT for Cirrus EP93xx

Thanks for pursuing this!

I just left the respective patches (I hope I haven't missed anything) that you
are waiting for the review.

-- 
With Best Regards,
Andy Shevchenko



