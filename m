Return-Path: <dmaengine+bounces-5813-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D426B04EC8
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703393A46E8
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F822D192B;
	Tue, 15 Jul 2025 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRzE4do4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E22D1303;
	Tue, 15 Jul 2025 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550075; cv=none; b=Naf60acWinKmNX6I9ScN1rb77IH6tRx5tVnbSuvDV3DqkgGc5HPGIjN7q30T/gT/r+JgzHXQRRsVVNSvgKlavG9vYq90Q5Lk1yWybpSZl4BI86J56bFXodY1i59G+8sGCx9TJHfvHL0wXJU7uDrhXr9XfAZlAxyT6RHOTdabFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550075; c=relaxed/simple;
	bh=RgjkmaG1JI4kCb3OMB2bqGTvB0ZifKXuh5j6zP9f9VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFOAqFTHXgWER3ZG2HggmQC4axJR7WSD6F0qIsl4AIdgxonjfak9yAglNMI1UVrvFXyuXgM0PqTPA/zuXc9r2BrLeAx2jbppBAnesDM/PHHMj66S6mVWaxK3b0jG1JxM3VvIuAl3EjcQtHJ5/Xa7I2/v2qN5/SI3N36M+au97Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRzE4do4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDAFC4CEED;
	Tue, 15 Jul 2025 03:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550074;
	bh=RgjkmaG1JI4kCb3OMB2bqGTvB0ZifKXuh5j6zP9f9VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRzE4do4tUaPJFDv2Q1Q59tExpdoEaWMnQW6hDmy2JvbghbmZ7Jx26D/BJ0MZhVu1
	 7N7j4FcphOWWqZD1Paw7gcL18myt5DVmbG3vQ+oaocUdr30sC8eoA3ftXaC2LjfkPs
	 y9V5WpYXazsCrMLNfyiXI2ls4qXmutHton/d8WQu41ZEErAoiz7C1fSeRXKRsqnMZS
	 XEcxyC+0ahON1ftbYcy4/ufKBX1PL6d3g0V+ELp79UA0aUWDzBHoe9lctaulkGqjPH
	 ybv86Ohue2adM0pYecHnqXZ9C5E/IrjVaRYDfwa7SMIkYgTm6RdtD4pCSDMOjnCp9g
	 Eo8B6nL9XfVwg==
Date: Mon, 14 Jul 2025 22:27:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Robert Marko <robimarko@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>, linux-mmc@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, linux-crypto@vger.kernel.org,
	phone-devel@vger.kernel.org, linux-pm@vger.kernel.org,
	Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, iommu@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, dmaengine@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 04/15] dt-bindings: firmware: qcom,scm: document Milos
 SCM Firmware Interface
Message-ID: <175255007347.4169055.14756962065490424576.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-4-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-4-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:26 +0200, Luca Weiss wrote:
> Document the SCM Firmware Interface on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


