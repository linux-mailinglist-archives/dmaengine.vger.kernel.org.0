Return-Path: <dmaengine+bounces-5821-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8927AB04F00
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE6856093C
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09E92D1913;
	Tue, 15 Jul 2025 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIwWzF4S"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923F2D0C99;
	Tue, 15 Jul 2025 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550189; cv=none; b=qAs0v2yRrw0avDp7vD8a64OdTjfKAYDL+efmDy5Js3XPFHOpn8Dj5lBk2fE7IxxyPARmn0qeTR+rsByRv4ZwpQFJDNzCOid4uSAW3b2Rpj/SGxHGqJmoF1g+zn43kSVZQv0WUE1S9X/uCXt0CvrqCET3VTzwn6q2b8aGoAZOvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550189; c=relaxed/simple;
	bh=hVLRemzeoLHOYt5g+Ho/v65roQrQwOj2GNRUmI1pu8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYZdYabNzOtuXFFqWooLo4WPKA/5o4NGkuoubf5xjIkZUa7DZM/qjp0A9SV0rF3+BAb8YTOFZTMMRLertAC3wAMsWJ9kTWMXgn5TDC2tPCGxb2KNjawcevDjp+IXt0dz25BpWKGP0g23WZv7pawAAh6hNe3u9Z+lHRjmc6rmwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIwWzF4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255D4C4CEED;
	Tue, 15 Jul 2025 03:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550189;
	bh=hVLRemzeoLHOYt5g+Ho/v65roQrQwOj2GNRUmI1pu8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIwWzF4S6FvVRf5oC/R7kgXZfMLV2VO0earPGGJd3ajT9B9bCcN3xmZRSJMI7T/ek
	 dFiKzJXvwgaFt7x5KN/EWF+KMTO8ZK7PsVknqmu/ASVA+lyX5xEW3HBy/XUAHRs6R8
	 GWz5jCR0GlbzAfnHIaQn7ift+NRGM/6eqqR704un951ecnDuJYZGCFui9ObdZ/XrvV
	 cp35WqRGkIMCFJZ6iESou7mVHmbBGSpTxvAGv11DCgldVBNJZYoQ978KShmxqyj6uE
	 4Ywpw6bXQc/nw32CZij62kI3sqpoCJxAyrWCViPofUe2Agld0XrAYn+dqR5+Gnsc/B
	 SKTXahk79y+bg==
Date: Mon, 14 Jul 2025 22:29:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	phone-devel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Das Srinagesh <quic_gurus@quicinc.com>, linux-pm@vger.kernel.org,
	linux-mmc@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	Robert Marko <robimarko@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, iommu@lists.linux.dev,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	~postmarketos/upstreaming@lists.sr.ht,
	Thomas Gleixner <tglx@linutronix.de>,
	Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 12/15] dt-bindings: arm: qcom: Add Milos and The
 Fairphone (Gen. 6)
Message-ID: <175255018786.4172663.76314608667353154.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-12-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-12-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:34 +0200, Luca Weiss wrote:
> Document the Milos-based The Fairphone (Gen. 6) smartphone.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


