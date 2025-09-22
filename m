Return-Path: <dmaengine+bounces-6680-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83651B92721
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 19:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5291898529
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5EC31578B;
	Mon, 22 Sep 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRtwAyLJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BFD314D3F;
	Mon, 22 Sep 2025 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562369; cv=none; b=TKMSts5YP7c5tDjrPKYShzRTx/JBjlMrAIvGjLEOugI6K3p3i62O1Go2sDybGwNfFmVPg7u34FXwiCU+UF5CBHQuJVDq2DERdZuvmY/PoZ4RnBdMnX9Z/V6QXHJvdFGWL77bBQPSf4dDr/R8kR6xhmha0aPCImHQ2XLr3q5ZSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562369; c=relaxed/simple;
	bh=gLoJKtzalDuOH/rmRMJ55zcAI7y5bhJhyzWCe2JGf1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxuvOhhsgwMuq6rPWOfVZxL5TuMe138xGH9PWz0Cqoc95k172L8+wYgM98XdHz+MRhgdYHQ+T2dOuVjaKx80nj+C8vN4kkUN4fOa7fadBuJc8is0KAlIWQZ6PZ8IcJu3U/o/AhmCzJKtEuHT1NSxqyr9W5VUAZsMsbga0KTaBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRtwAyLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C4CC4CEF0;
	Mon, 22 Sep 2025 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758562368;
	bh=gLoJKtzalDuOH/rmRMJ55zcAI7y5bhJhyzWCe2JGf1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRtwAyLJHXC/w4/KuZ533bntdd1AtbCwzsDCiQLhxyNuMrwr/qZv3rAQ/6PucLbl1
	 +Ii6PL+zXm8m7CVZDaE4DreOP6VRzhXQYNFICTjAnt+f7LtwHLuuez3v5ibBFjIQ3q
	 2xgeR2WHLYf7BG7JEGPys36TfIfdVYN0LHnLT7xbq/gKNK//5987u+O80O5Mc3rV2P
	 0i6kYNha3h28RSBq6xhh3xp/goplAT1sRv1/XPORSY91gBsTsT7ho+oCIJKt0PEILi
	 GLZj0UA2kS2spRINxR40UBXYZ0+CxuSNNyCEpeZOgN4N8EVyJTYIkNSEDTit6bgTO7
	 2XrDoQB1PmzdA==
Date: Mon, 22 Sep 2025 12:32:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Sheetal ." <sheetal@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, dmaengine@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH 3/4] dt-bindings: interrupt-controller: arm,gic: Add
 tegra264-agic
Message-ID: <175856236329.510188.15404982398472651889.robh@kernel.org>
References: <20250918102009.1519588-1-sheetal@nvidia.com>
 <20250918102009.1519588-4-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918102009.1519588-4-sheetal@nvidia.com>


On Thu, 18 Sep 2025 15:50:08 +0530, Sheetal . wrote:
> From: sheetal <sheetal@nvidia.com>
> 
> Add nvidia,tegra264-agic to the arm,gic binding for tegra264 audio
> interrupt controller support.
> 
> Signed-off-by: sheetal <sheetal@nvidia.com>
> ---
>  .../devicetree/bindings/interrupt-controller/arm,gic.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


