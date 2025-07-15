Return-Path: <dmaengine+bounces-5810-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 455DDB04EB1
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5702A1AA3443
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4602D0C8A;
	Tue, 15 Jul 2025 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYTpsc1I"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179556FBF;
	Tue, 15 Jul 2025 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752549961; cv=none; b=gUVFjpCl5VhCm2lQoUdRRvM1Lh0hJXzg1cQkndT22cgdXCoErm2hy9K7lmpHYuN3eoPYqiYrGFgwygS5+cKl0u1kIWYPb40lR6ACyPbtRs3UuTc7SKTe1rSHlKIcrHlIneD3x3k1QW7K8neRt0/Fqk3Cs6LTHsx6CxAxzD6ZfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752549961; c=relaxed/simple;
	bh=U6uuaEVc+vahHf8s9S/yRKRjutpaUY5aXn+/TSZmWOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc8ZVaNMLN2ccNRV0IOWdNS1WP8xPDGfcMTjQxFwn0xhBbHLUGrqI0RY1ToB0imo7kOCC5L97gP9K6jAtKRK3isex2QKUp+HQCkq8VAOYIh4mCgISdn/vueXJGGE53H2qQc4g8XYzqePlomnrMu9OHUcJxabx5Ms7zEEv2AByjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYTpsc1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658CFC4CEED;
	Tue, 15 Jul 2025 03:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752549960;
	bh=U6uuaEVc+vahHf8s9S/yRKRjutpaUY5aXn+/TSZmWOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYTpsc1Ic2OccNFYTOQE00RdS9a99NWuVmPGyujUKqop36anWgxpBFr/jewBjZ8jM
	 AW7snBrQvHtZnQNbi9hFvySphrh5JvpQAkvYMu8JFcjCZ3MKOJ7F6RlShve4VnQEwF
	 3rxc650pSb1cRF7oZGfESX7S+Ut6MXBBusRHIyMxKPOqVL2bv8OoSzDLQiBr564tja
	 gvcDdq+E7tQ/yeQ6wSRO6udFwck7TpsrMaIjTyCdQH7+x10m9ilyZ+LZz+FpZg7jH1
	 OsAUAtxq0JJhorTqsh08nSCYD+y/VXQDHUkVR5jGwka7zDSPueFliKxZG8ExbOZctI
	 MMxbhJmwDvcPg==
Date: Mon, 14 Jul 2025 22:25:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Das Srinagesh <quic_gurus@quicinc.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	linux-crypto@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>, iommu@lists.linux.dev,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	~postmarketos/upstreaming@lists.sr.ht,
	Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amitk@kernel.org>,
	linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] dt-bindings: arm-smmu: document the support on
 Milos
Message-ID: <175254995898.4166029.3581738288398276719.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-1-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-1-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:23 +0200, Luca Weiss wrote:
> Add compatible for smmu representing support on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


