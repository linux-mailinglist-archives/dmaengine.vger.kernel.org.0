Return-Path: <dmaengine+bounces-5812-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9DBB04EC4
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924DF3B377A
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E4E2D12E2;
	Tue, 15 Jul 2025 03:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyLfxnd5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A912D0C8A;
	Tue, 15 Jul 2025 03:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550067; cv=none; b=AMN0F1JoA/r1r+6e66rJem1GkxKbpsWtYphoHSpmaz8FC5wTiQoT8XrcH0BN9QMRCWK2DepyEpo0iwbTQRvpcqZAIDn278eIZeNest3wbGNtzEh1BHlFLhcp/PCaFALBqkjW1ANLMNseqsp2bUtfqg66Hsg4d4ib4qw8OxEFlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550067; c=relaxed/simple;
	bh=gpWphFRskOkWmdItx+4G3mN3kDgf9R0tX9A1e8ENaFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCCDqCLCMMnB11fv+UeQOZM88lh5nOS4PVboEZj6qCHYg3L867dKBURyvs/bob2ufJaCUkJWVqb7IA81WfWL1umfOmA4emnQ72nLNMzqaDjGDIxN9hAooWwPzgMxp+NQBvBse/0PNNAsJWk6zqKTGuJFyb3kKjVvszCfb2gcJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyLfxnd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500C6C4CEED;
	Tue, 15 Jul 2025 03:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550066;
	bh=gpWphFRskOkWmdItx+4G3mN3kDgf9R0tX9A1e8ENaFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyLfxnd5aRaciO4FC7A6nzSpnvTNxV6wZA2RMxaAwtfuE1Ntib1ESDGDJwSdlVqyc
	 eHrXcR1sLHyblGIookDCwiNieMh5i/Xduwi15enCWC54vXagJPAERTM5BPt17cIXgl
	 Ql8qRkXu1FCiMkz7ugxUojXAYyuS5cKSdvxwz+UNKpforJhYqeRWcd8g2PNhtkzsic
	 5lElPzgBsP6bBg6ikVDHcUhuSvo89ESVaV47ntmXQmapC90ztACHlX03245IIGDTY6
	 2vnAOQ6md0rAtLoo2Y29rzAm9bsAcpoSv8+LA+PYYqhBevhVTh7zYHIkdOrA/0YVhP
	 7znnUnyBiRHTg==
Date: Mon, 14 Jul 2025 22:27:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pm@vger.kernel.org,
	Amit Kucheria <amitk@kernel.org>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Zhang Rui <rui.zhang@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	linux-crypto@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	phone-devel@vger.kernel.org, linux-mmc@vger.kernel.org,
	dmaengine@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	iommu@lists.linux.dev, Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 03/15] dt-bindings: crypto: qcom,prng: document Milos
Message-ID: <175255006480.4168742.250321076167127659.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-3-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-3-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:25 +0200, Luca Weiss wrote:
> Document Milos SoC compatible for the True Random Number Generator.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


