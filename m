Return-Path: <dmaengine+bounces-5814-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21731B04ED2
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214D87A139D
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4332D1926;
	Tue, 15 Jul 2025 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKyVNoXi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F12D0C80;
	Tue, 15 Jul 2025 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550099; cv=none; b=o5uQKO7qUKy2gU5L52tznAJEa6E5tVKSrndqTW/PkNwd0ODssjIfzhCz44wJbUdcKm5UrHhh6CAUTdCp4KTAGMq5mrK5kml3ynlC7LscL/oYupXbWlDCndAHkQ2n2SGAOyu3/Tqssd9qLUrC/uwhsnNJIRNs7E6YC88RCOdq2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550099; c=relaxed/simple;
	bh=cEkWZAGCPe5OqgbcbvgJtoiI5d3slfPL2Fi0r80abhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvRAR/1XHJHYjuUp8MZGFBNzwEWH9RLLk+OknpEEdLnyxwiyq6ah72pMWENuvyLurWAtV8w+OhNgBo8vF4Q6bFZmOD/p6dflIWLYu228RAGPxRWxyv3qwBUGH04Qg11K7Fp58f7iJajDitEUANSB/fCaQq+pmjEDsENvjRK3+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKyVNoXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C20C4CEED;
	Tue, 15 Jul 2025 03:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550099;
	bh=cEkWZAGCPe5OqgbcbvgJtoiI5d3slfPL2Fi0r80abhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKyVNoXifyFEW/3Tp0Qs5lk3Qfa8CXyAM++5FEAlA082J54WWKASCRoopzOXEJfWm
	 eoMhhTMno67bJjOGEeGXCZUr2gQ7oodMZ17qfeKPR0dtuwXr1SF8cWTfTMl02rkB9l
	 6mBOpmORuNmVoQI1R9CriZmORg4r2dSC1Ge2IK7LqNXO/Q7YHYrfbswWrccl0mruwA
	 X6RZu3vAFPiwyVyzLR2M+DOzA/DIDHfd5oUNeJ+ZibyHt0gpbCwJByAyhUf4d7+DKx
	 qJhPmcd0u8ztSRs6dc8DgJ+Nxn7CT3U/Q9Oy3199yUAmP6pb5/CAZgjaow+TrY1gX8
	 Yjo0RgwjP6r9Q==
Date: Mon, 14 Jul 2025 22:28:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, phone-devel@vger.kernel.org,
	iommu@lists.linux.dev, linux-mmc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Robin Murphy <robin.murphy@arm.com>, linux-pm@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	Amit Kucheria <amitk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Joerg Roedel <joro@8bytes.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 05/15] dt-bindings: qcom,pdc: document the Milos Power
 Domain Controller
Message-ID: <175255009805.4169737.11762168509354403717.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-5-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-5-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:27 +0200, Luca Weiss wrote:
> Document the Power Domain Controller on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


