Return-Path: <dmaengine+bounces-7232-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87846C65231
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E24B63675EB
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155F4284889;
	Mon, 17 Nov 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlmX01o6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B302C3255;
	Mon, 17 Nov 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396508; cv=none; b=SlWI4VixCYw2ty73/zmY5GzsgFJkGqqq305LsCpcIdxOG0+OQwnUrwXXSDEbVgnnVu3uPXvnkfBOIdG+fS6F4yDXpQntge1VXjIv8tquAMBs8WNeDcCHRIU/d8WHCj7J8N0tD53MSPOToZZhN9XHcMMucOg/wvbmprgjHG7AX4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396508; c=relaxed/simple;
	bh=TiI83tCg5AKsktlTXAjyXY6utWvY4C8WcBuoUX5zOms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocK4HsVXxypE/Ubrwb//NA1WKw7K6wVukwxGnKg1GU5bdbSZE4acb2pZhfP5TIPhOf5w5LjzXBMZAIuTfEMLGqlf/hpBgw1bOaIHrBTM6+d6+k98dq6Cu/iyQXBYN+Ei8A6tWVeOyWLUhc6vGcxsvx4mywtT/fRo2U/1n4TF4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlmX01o6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862EFC19423;
	Mon, 17 Nov 2025 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396507;
	bh=TiI83tCg5AKsktlTXAjyXY6utWvY4C8WcBuoUX5zOms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hlmX01o6zvfOF647eW/XjbKbtoiLEBORcvp36rZb1QULsMeVeRvCTx77FQee89Gbe
	 KYaycnMLmyAqD5KW77ykDsjwGMdEKrIKp7Yg3ReULVWo7kbiOpGLJWxtTf8d0x9LNt
	 ePeVQsdNo1Hu5DLkMdZqSzs6o+5zzEzbsQwWsYftqaVhI43BNBCfni2OBkDNLYVBJf
	 Th6N7HATRehRRItHXLZFD2TEd3sCVWwRzdeyLJRtbEKVxYzayf5WU9gJkHwL3HZ+Lw
	 Vtapxnh7oFdw4Oi4/cC5I99oWuPmsezKGQVMxbO45mTEIfiN46SgDpTSvcHQTdoKRi
	 on+XVqBrvKK4g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1z7-000000002yZ-1cgg;
	Mon, 17 Nov 2025 17:21:45 +0100
Date: Mon, 17 Nov 2025 17:21:45 +0100
From: Johan Hovold <johan@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 05/15] dmaengine: idxd: fix device leaks on compat bind
 and unbind
Message-ID: <aRtLmTQIJqMdQWFm@hovoldconsulting.com>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-7-johan@kernel.org>
 <867fa85c-8e7d-4b60-a354-630d4147c3ea@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867fa85c-8e7d-4b60-a354-630d4147c3ea@intel.com>

On Mon, Nov 17, 2025 at 09:18:39AM -0700, Dave Jiang wrote:
> 
> 
> On 11/17/25 9:12 AM, Johan Hovold wrote:
> > Make sure to drop the reference taken when looking up the idxd device as
> > part of the compat bind and unbind sysfs interface.
> > 
> > Fixes: 6e7f3ee97bbe ("dmaengine: idxd: move dsa_drv support to compatible mode")
> > Cc: stable@vger.kernel.org	# 5.15
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---

Thanks for reviewing.

Note that something happened here with the end of your tag. Hopefully
Vinod can fix that up when applying.

Johan

