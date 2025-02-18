Return-Path: <dmaengine+bounces-4514-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F89DA39973
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 11:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 489D37A32B6
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 10:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBD923716F;
	Tue, 18 Feb 2025 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN7/crkc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B315235341;
	Tue, 18 Feb 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875607; cv=none; b=gH89PaW2b2r4fRxGSRUlPCVOTThzKzzQxqwyTrpDeZhWBWLTEAiOc4LJK71WseA2RxX303hBjG1ksCnng5IntZKddtfqSq10+FGQIQvBxD219VJlJQ6z7Hx/qj4CBPaDlCWCq7btpyR3GvQORnwHVFjUYnWMvL41GWCMtAW7AxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875607; c=relaxed/simple;
	bh=lFybjn1lzd3uty5K8+/fX/EZsa8vtx9u05tnjD6rAIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmNYIXldPGXYJg/I2QKFaIJJ5qXRIUZ/qgSlOEInU7J9BnzVd/ur4IorVKhGeTGveg3RblQi3a1fQtryCzJ/QW43RuTUtiQ3RKoNwwCOQ5Rexz7U0g3aaa24Cun/BtvKGAa57HQEV0A+Y+Hbubm8M9PTS32lXkuiVYuc0JDz1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN7/crkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A6EC4CEE6;
	Tue, 18 Feb 2025 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739875606;
	bh=lFybjn1lzd3uty5K8+/fX/EZsa8vtx9u05tnjD6rAIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LN7/crkcTZHdkdwLpR5JGrRCG/xYcwV7jukPGpHXq4XaRTgDpWXcdWfMYMQNzCuLT
	 rp9K9RFdMnXPh7bxX14G9dTedkkgHsGLvroa1YFHmxWysSxdXBN+v3u0OMDJOwJxp5
	 n9i3l+MKZfktPcPbepwTA6J0VHfftOEH1fEt9BOXlGJkKtwBeaAfxPs4+r0fWUcuz5
	 fjRrEIx+31QqVfgVhFvjtPmZtO8sPLciHzQ0wulItC7Y8mV04Kt+MoVrSSbn8RhWbU
	 iz1AF7CwjyotSIrAM9Y4IcK2/OY56JRKQI9+ugfNzT6RAp57fZ/epqu3GHD6sQ7pHk
	 VXTUxoHEdDUqQ==
Date: Tue, 18 Feb 2025 16:16:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, srk@ti.com,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: Drop skip_fdq argument from
 k3_udma_glue_reset_rx_chn
Message-ID: <Z7RlE+QfzdQ07spk@vaman>
References: <20250116-k3-udma-glue-single-fdq-v1-1-a0de73e36390@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-k3-udma-glue-single-fdq-v1-1-a0de73e36390@kernel.org>

On 16-01-25, 17:00, Roger Quadros wrote:
> The user of k3_udma_glue_reset_rx_chn() e.g. ti_am65_cpsw_nuss can
> run on multiple platforms having different DMA architectures.
> On some platforms there can be one FDQ for all flows in the RX channel
> while for others there is a separate FDQ for each flow in the RX channel.
> 
> So far we have been relying on the skip_fdq argument of
> k3_udma_glue_reset_rx_chn().
> 
> Instead of relying on the user to provide this information, infer it
> based on DMA architecture during k3_udma_glue_request_rx_chn() and save it
> in an internal flag 'single_fdq'. Use that flag at
> k3_udma_glue_reset_rx_chn() to deicide if the FDQ needs
> to be cleared for every flow or just for flow 0.

This fails to apply for me on dmaengine/fixes, can you please rebase and
resend

-- 
~Vinod

