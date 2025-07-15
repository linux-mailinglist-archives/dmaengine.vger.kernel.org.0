Return-Path: <dmaengine+bounces-5811-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C99BB04EBD
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22837B1286
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBF2D0C96;
	Tue, 15 Jul 2025 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwS3ySgV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23CD2D0267;
	Tue, 15 Jul 2025 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550052; cv=none; b=g4ZK7v7uK5fIk1ZFGr77SoxnCmjDtDeJ1oj7WCE81rx/03WLqzLOc3ZepB+jDw9lHRaPZhqnatdn/VENHWXqgjPgJWzlupOHUjwMnvMlBCfZwnBv8xQVs2YoAy/MBp8oVsjF1tG8Ztv443GeXz7blzJ3Ng25UMBgepwT1l0V5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550052; c=relaxed/simple;
	bh=WHd+eJ/W/s5hjN+1CbjugGmPlFvTfWiYJ+bZ2t4fkNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbMD5FHQEwhKpEuPrAFSoC3g7Sq/eMlkvWf034DJl5p+m1vKLL2DCg06/GUMwRNoS3R1ZhsbBuV486ZDYCCpTS8xYjTcDfXsSGKhd2GSq85B34Q3j+5vRvroEfBVDnBBF++Pde0KTlcfPTcEGPANmqWlRk2u9nAEOa/RMKEzonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwS3ySgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD7AC4CEF0;
	Tue, 15 Jul 2025 03:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550052;
	bh=WHd+eJ/W/s5hjN+1CbjugGmPlFvTfWiYJ+bZ2t4fkNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwS3ySgVlb0c91Nuj1p0laqXqa9C3QpO3uQDnZCcC1FEW55a5fDG6O68P+OYKTZI1
	 Za8ZWudFYKWD/vXWeeymyeVXrmcoz0O6H4SV1sgggNc7ALvV2mAwQ/o0MS5w82GCAc
	 nYM83d7yvofs9vtyuu/Zw1tcGCDZWGNtXURhzDsPTIRNM58Qp94/eXtM1ehkV/r+c3
	 lbp0Z0N3UBMS0VxAHktJcvSpdL0GoWvBk0HkTvoApooXowmAQOLZVlaMe++nwuQar5
	 xHI0jkHZCgndP1nrGUjYL6ECEPGnZLzUPp9wC7eMYvhCoerAlhspWYCKI60/Bhzelz
	 iHHPb9++pTPMg==
Date: Mon, 14 Jul 2025 22:27:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robert Marko <robimarko@gmail.com>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Amit Kucheria <amitk@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, linux-mmc@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-crypto@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 02/15] dt-bindings: cpufreq: qcom-hw: document Milos
 CPUFREQ Hardware
Message-ID: <175255005066.4168309.14534457343594417316.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-2-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-2-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:24 +0200, Luca Weiss wrote:
> Document the CPUFREQ Hardware on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


