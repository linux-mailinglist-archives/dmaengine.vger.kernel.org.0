Return-Path: <dmaengine+bounces-5819-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E5EB04EF2
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC964177AB7
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0362D239A;
	Tue, 15 Jul 2025 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc+FBb1M"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55212D0C8A;
	Tue, 15 Jul 2025 03:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550166; cv=none; b=BPl5vLPiAOZpSfx1eUYim15ZYjA1zQP3Vt7TEzkKFKLGrS0lOO937CKc9MCqH/8DlptlJYLUj2MrVSslz9Zq3DUVgOzdQYQ8zBlZLmLpUv0wwt1xuEpMWYOhDLbqFE3AmCfI6r+O1boFAYGoCgQg7WVOhwqy8tJEl3Eacb0ICKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550166; c=relaxed/simple;
	bh=JP/VRVORz5gjKVseYbitlEJr8Ti7wgCNZno956ap+AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk4G10+8vK5NlorzlBrJQRL+o42J9mJqa9vl/G/7FXsuTJdmnSi6fmXWmkSJVg2L9JPF3oa3nxP7EK1x5bXq9a+I58+tA7vFAUG1hhbIrVZpWo6vhJD3i8zW5H7KlGz1DB+qD7RwWl/v7XT9vF60ldUoJmhquz9pCouEcWRUXGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc+FBb1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A63C4CEED;
	Tue, 15 Jul 2025 03:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550166;
	bh=JP/VRVORz5gjKVseYbitlEJr8Ti7wgCNZno956ap+AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xc+FBb1M1DFVvMvAMdex1zaMXX/TaAA5bWiv41Bo6eB+W6/JAhnvEeUWng/VODq3P
	 Isa51ccfrhoHn/6JhXHCwcUocfZ7qrkYoN66Q9AzlsPmJ0+KTwk2KR2nBHx76Uwfcg
	 dvdAqsFhGIJHqSLZt4vIjTXze6q9AebVALkFDgkrWNUsQCMQBBkvwkYEdMl+m2dGG0
	 23pvW4PbuYVJz2PsGE6OStTqqXY509qAoBiqLDhztuTZjmpSKUWV0kRniPcDjZmWvb
	 zyauDi4ifMFae0srkNxAmbhEQdneIHnY7WYHUoLkq1IePn9zZTXfTZy6nF8HeUWYxD
	 lOgfg4G6G8pBA==
Date: Mon, 14 Jul 2025 22:29:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	~postmarketos/upstreaming@lists.sr.ht,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Amit Kucheria <amitk@kernel.org>, Will Deacon <will@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, iommu@lists.linux.dev,
	Manivannan Sadhasivam <mani@kernel.org>,
	phone-devel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Robert Marko <robimarko@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-crypto@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2 10/15] dt-bindings: mmc: sdhci-msm: document the Milos
 SDHCI Controller
Message-ID: <175255016499.4171902.17843628131714515042.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:32 +0200, Luca Weiss wrote:
> Document the SDHCI Controller on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


