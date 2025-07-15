Return-Path: <dmaengine+bounces-5815-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC34B04EE2
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F15188B8D7
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F062D23A4;
	Tue, 15 Jul 2025 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmPYnQED"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B32D0C80;
	Tue, 15 Jul 2025 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550111; cv=none; b=nrQECiRPqpV+OtDcK7H0pXdpN8GjQzq4Hcf5Eojn0zO/v/mNrjP79M1zmWsarSLnX4ejweT+L4jprMOf1q53hgwe8KabHbdG07sqcvPeLNvWQQjcATFtqgdiJ06PnZhuUFcphw+7NBuVIiqjBDldkmRwR8p45Iu1LtBRfutTmAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550111; c=relaxed/simple;
	bh=tCDkt4BGILO4YsmTc165V52DS2CDHUg/GhQvUtMyiHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7s334bp4Fafe+nj26vdUOZMH/bLqLPjRDoHy1OfqY4PypOmZ3QHnD/8uhf1lCCe9AysOXgE0fgaSXewFxU/2vZAGUB1o6CXQeanoV6+anBUMvteod1haq4IqTleKMp6NI5FLW133U3RRuZS8mG8SODTs4NSydlCW1Nf+AlwWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmPYnQED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D43C4CEED;
	Tue, 15 Jul 2025 03:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550111;
	bh=tCDkt4BGILO4YsmTc165V52DS2CDHUg/GhQvUtMyiHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmPYnQEDbAa72vt5rC4gAU2byhERECXki907k4tKv8ajhXYfeNsYVtrOFR4Ud9DLU
	 TI4zmtkhh463vO3Bw+/PwLvtCyrX/8IXbo0gBTmsginvSnKfXyhcNsBXDk5vFNgUFH
	 qzIEa3scTmdKngrO/ZlP/mCAsn23ZPhf/9lWPKlmEVArJdAf+3oNBFe/+uw72FhX6z
	 v4IVrC5f76k2FWGdigbUOx/MXVq22BokjJ00taghYuLAtSal6Kcrt81FN4rifwZVpu
	 +VvFKsIbpCjAptkSH5HkSZ04NzFlJ3VzESnSaDXhVmP1GbEvaHT4YVGITE30pfunrL
	 /aevEXWyNyErQ==
Date: Mon, 14 Jul 2025 22:28:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Amit Kucheria <amitk@kernel.org>, phone-devel@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, iommu@lists.linux.dev,
	linux-pm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robert Marko <robimarko@gmail.com>,
	~postmarketos/upstreaming@lists.sr.ht,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-crypto@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	dmaengine@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v2 06/15] dt-bindings: mailbox: qcom-ipcc: document the
 Milos Inter-Processor Communication Controller
Message-ID: <175255010969.4170121.2567162403007816183.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-6-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-6-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:28 +0200, Luca Weiss wrote:
> Document the Inter-Processor Communication Controller on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


