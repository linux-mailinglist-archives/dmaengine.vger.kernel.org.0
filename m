Return-Path: <dmaengine+bounces-6770-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63906BBF95D
	for <lists+dmaengine@lfdr.de>; Mon, 06 Oct 2025 23:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235F53BED94
	for <lists+dmaengine@lfdr.de>; Mon,  6 Oct 2025 21:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C05C25D917;
	Mon,  6 Oct 2025 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSJbfBOI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F7246760;
	Mon,  6 Oct 2025 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759786606; cv=none; b=MtztxQi/pklvxwii81DApaWfxtPt56NIAZPyX+9nigebAkdBusLi4j5TjmgTzfTGjzBxFNDnrz6tChJ/eL05CBJpHKBlZS39FP5z2K3Dd0UHNluy2e7POQKrVjheErvUxk3D02WiQoxvfTPyGbhiuybXGAEivtJ+B6ohsJwAjkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759786606; c=relaxed/simple;
	bh=Wc+JgdfB2HdH0elOKIjjG6YIjjzGSAhaMhztbt8QOzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsqVrfFPX7RWCoU1dwJ6PMHZEMgEMu2AR8czzW5Ejfp2W8evW1v4bB9LU+SJ/xyrc5HBQuVZdiPKfnbvgrhTpsoyjHOINTgi76ydwxJWMIqJ7BGA350wlSgOUlfPtlS+drkFs0PvTkAPtEkWfGvEp3qM9tDJPj8IucNniaYLW/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSJbfBOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC37C4CEF5;
	Mon,  6 Oct 2025 21:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759786605;
	bh=Wc+JgdfB2HdH0elOKIjjG6YIjjzGSAhaMhztbt8QOzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSJbfBOIuUhvEerY6D13zJsFE6bPufqjG2fMQYtMuR3GaU9AkOagbe1wXishsyuFy
	 yaAXw72c0NyBZO6hr3NC0CmWuQGY24hg/26ZlnXngujAGzzAgQRR2gynSYa9jcnx6w
	 XfMT15F/nDAbc2xPv8iBQadx7suWCBi4BFUennKXJ7XN2Xws9wawVcgtWHrluYdiT4
	 32TD6Dl3uU5N67rbb4e8EswXaRC2Jt1Nk/s6o7oYi83ekbHZ8YuItbokVV4abiL7RP
	 cBC96KLw6IWtSUb2fUiBGcJ0a0AHFFdwQ4o/YtlrHiHGqjvZ8MfVtr3NHx3JyU3irR
	 RN7SUOzG5Waaw==
Date: Mon, 6 Oct 2025 16:36:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Sheetal ." <sheetal@nvidia.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Sameer Pujar <spujar@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/4] dt-bindings: sound: Update ADMAIF bindings for
 tegra264
Message-ID: <175978660352.625360.14343154592016440283.robh@kernel.org>
References: <20250929105930.1767294-1-sheetal@nvidia.com>
 <20250929105930.1767294-3-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929105930.1767294-3-sheetal@nvidia.com>


On Mon, 29 Sep 2025 16:29:28 +0530, Sheetal . wrote:
> From: sheetal <sheetal@nvidia.com>
> 
> Update the ADMAIF bindings as tegra264 supports 64 channels, which includes
> 32 RX and 32 TX channels.
> 
> Signed-off-by: sheetal <sheetal@nvidia.com>
> ---
>  .../sound/nvidia,tegra210-admaif.yaml         | 106 +++++++++++-------
>  1 file changed, 66 insertions(+), 40 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


