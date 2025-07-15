Return-Path: <dmaengine+bounces-5817-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8C9B04EF7
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569C41890D53
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D8F2D1916;
	Tue, 15 Jul 2025 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th4R/Vd9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07D2D12F6;
	Tue, 15 Jul 2025 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550131; cv=none; b=ASnlTKRMzmq/r4wTlHoBYtv92JMfs8n7A2KTFJsRTJo9f8CfQMoQvZ6vPgiDKXL5bkhCdXXJtczK0WXYvThZVnxwfn7GL+v1hW21zsBevMYQon4hgCj1Fv1KTrtyDCQLmSHr4T7BtVynYC/AlTMgZq7s+rnoI4F8rQStDe1X9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550131; c=relaxed/simple;
	bh=hJ5Tz4XRlWlp+Qr+K0nHaD5SudM2cYhAell+KZWfOyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3fkK+wUuJHWWgBsz1aTNzYuAVh3JHpNyTtZfaagtaT5Px5zt2BB44suR8Tv3fZ6FIvyisvFMUJ/zcgec35FbPcNXOJjAWVFZPJzq/ATfG3r9Pv6chgRQtxSBOJs94oWCXb4BgvojU2vAkGT+OJZjwQJrYoVRqcGmzAf2LtViQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th4R/Vd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEDAC4CEED;
	Tue, 15 Jul 2025 03:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550131;
	bh=hJ5Tz4XRlWlp+Qr+K0nHaD5SudM2cYhAell+KZWfOyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Th4R/Vd9Sc30eBwVlR0nlZTQaoK9uTYS/GaIe1Focfrd9Bqe6K+YweCRFqbDBjwni
	 AcLNZpvhF/v3nqU2Kvmh+/0+Yx2kiKWku8lA1caAXcjgVX1Ezi3jHg+juszRd3Op9I
	 J3ycYgzL1pfCFZDvKoTEPmNdUTRecjVHjZiIfZYTTXELwE0Kj42Ydp7vB/SWXcg8Rx
	 NFHD/e2zgi+s20WBIU0JBy/cFtsTNRpf3IFQuLZWedD3eKZmj5bGdG79xtpUn+QNCV
	 7rxrauWgWYlpkRreeTivMbRL1DLz/z7xfOVxsCwUk/Lc7tLM0RjBtsA4g23yfIUof5
	 F4/vfNL4cbkTw==
Date: Mon, 14 Jul 2025 22:28:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Bjorn Andersson <andersson@kernel.org>, dmaengine@vger.kernel.org,
	Robert Marko <robimarko@gmail.com>, linux-mmc@vger.kernel.org,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>, iommu@lists.linux.dev,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Thara Gopinath <thara.gopinath@gmail.com>,
	phone-devel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 08/15] dt-bindings: thermal: qcom-tsens: document the
 Milos Temperature Sensor
Message-ID: <175255012978.4170832.11710750151104191728.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-8-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-8-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:30 +0200, Luca Weiss wrote:
> Document the Temperature Sensor (TSENS) on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


