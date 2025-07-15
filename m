Return-Path: <dmaengine+bounces-5816-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB894B04EDE
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05B0166A50
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A422D29AB;
	Tue, 15 Jul 2025 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haHKnUSB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4B42D0C9A;
	Tue, 15 Jul 2025 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550120; cv=none; b=WOT6s/gogxVUugPy+SODRK5wHqKH4MA3DVOpeq1I9qC3VuulSrInzj5lxZ5SKoUUMOL9eRjgnbD6O6VfJ35uqETQCnRMMuAXJFnpNLgmIHYXjEWV5PbtkH2pZYJNXVHrOXHFFCKyEEDCfZRGyC0aHiInV/74dS2uiFRei5Fchc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550120; c=relaxed/simple;
	bh=6NwGfe1gUHWzTRDKiupQVjbnpUUAfV0fQqDtk/LzFFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bB02oUqQl8FZzhG4JmtjrOadVIYFf5yBQJLewsdCGyWPPVqSnVR/ivzBd1t0hSERYDs9xGZjdR2FCkpbvaSa2mw4/Pe/8BpEi6RI5MBZslKE5ePkmtWg7nVBgPiKPp4mLmUEx/JlsEJMXyD6jnuJCss1rL0EdkY2CNU+NUMCAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haHKnUSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED35C4CEED;
	Tue, 15 Jul 2025 03:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550120;
	bh=6NwGfe1gUHWzTRDKiupQVjbnpUUAfV0fQqDtk/LzFFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haHKnUSBvyyMxxdDYkpyFX53FHbEF190ZkZiW6sAWE3nrt+AVA+IN2L7Kdl1GBhec
	 nTh5lUesxUSKHkLYgtKwr8PdxVKUsq7tYeyTTg0jjpBCVRvOO+ZczzbPJDkcBeGCti
	 A4MkFeoNMuDsHXzn54Qx8RhtjxrFaEDhkjP9G/hdYLrGJ0jGUwJlGoE3WuDwrsicsX
	 Mz893SnrradqjmgnUO15WPtH0XrBKE0Rhs5Xg3ulJT26qbl1AheHRnKQGwH9ASyumW
	 MdrTFYO8rR5fGjNuZYTSd/pn8SsupXPz3AZwt9ovkFsBXaC4clReWY5PnKo+AmOx82
	 /HeAiHuVBftKw==
Date: Mon, 14 Jul 2025 22:28:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-mmc@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	dmaengine@vger.kernel.org,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	Amit Kucheria <amitk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-crypto@vger.kernel.org,
	phone-devel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Joerg Roedel <joro@8bytes.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	~postmarketos/upstreaming@lists.sr.ht, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 07/15] dt-bindings: soc: qcom,aoss-qmp: document the
 Milos Always-On Subsystem side channel
Message-ID: <175255011867.4170451.9041457354849590160.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-7-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-7-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:29 +0200, Luca Weiss wrote:
> Document the Always-On Subsystem side channel on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


