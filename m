Return-Path: <dmaengine+bounces-5820-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070C6B04EFE
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2100A4A583B
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122752D3750;
	Tue, 15 Jul 2025 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqA4dbXj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1112D0C91;
	Tue, 15 Jul 2025 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550176; cv=none; b=fB2gYolA6LdlTZejE4tZjcPujrvPwqPSRWXIzCnE3UwX0dVEIQLtfWeoLzHUyROtLk6bZBmH82hfs1/5qyjOW4U5AYSswvKwvG17uSBBeWRSJTiqRRmAj/DyoYJN/5CO/HoxYOO8L9mfU3aiOOiMxkmfvA9DKY0m73vm5F66Amg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550176; c=relaxed/simple;
	bh=6vGbG9eZpdLkhCvtBV3XkyU02qs81/UKhfvdR9Gsg6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHW2W8BvL+uQLhIvSMSlhAYHzPV0eiScr9EE11dzE2sjBJWLp/hvIwAIKoufaC1FQlfrP4rRfx7Y/kHETRDynHY9MB06n2Flblr5nG2O7XO3T6xiJbPzqMt8DhxYeTxRJw4UrCCCpmQtzVsCsFdf2i+R5mZYjKLeF1hUHCpUTGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqA4dbXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AED2C4CEED;
	Tue, 15 Jul 2025 03:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550176;
	bh=6vGbG9eZpdLkhCvtBV3XkyU02qs81/UKhfvdR9Gsg6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqA4dbXjHjNlbbMUdZVf7RhIaIL7O/YLmyh8HiGnsu6xUl7C7QOZIF7UUaST3Z1HY
	 gO0OxkCV6ZwndVwbW5bcevSG/FnVsm0+QP8/TyDwMDuJW+zCczT7a1pHNPdtmwmjmQ
	 FHYzzqLAwWy/8H3SiN2dGrZuK/Z79PjyJqhCCEl6iUuT4Vox70A89Al/IbxTLD2QPj
	 Viqp2Gs3JNTNZl90eAPCnVzyChwhm/DZc4bPBkEvpELW+PPm9QhtM/2CM2hmLUwp5E
	 m0ktCzBqKJGQ3XZf+lYLhAcJF9BURi0sjxANsYjXLy0GzBA096AcggjREBs0uu0Rrf
	 2ZAb3i9/F1WoA==
Date: Mon, 14 Jul 2025 22:29:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	phone-devel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
	Amit Kucheria <amitk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2 11/15] dt-bindings: soc: qcom: qcom,pmic-glink:
 document Milos compatible
Message-ID: <175255017499.4172256.4796309138108783817.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-11-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-11-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:33 +0200, Luca Weiss wrote:
> Document the Milos compatible used to describe the pmic glink on this
> SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


