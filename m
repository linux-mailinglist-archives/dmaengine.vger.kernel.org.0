Return-Path: <dmaengine+bounces-5872-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7F8B1379B
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 11:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B30C7AAD4C
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DCA25229D;
	Mon, 28 Jul 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVSOwmfQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D822C35D;
	Mon, 28 Jul 2025 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695391; cv=none; b=IfnLITam8x+HAMnXm53z6cFdP56uMtMUefZM8iGOgdxdaiQbAS/R/rJz49DL65nP6CVk0YHnXq3v5OkCXVO2+II1NmTuALR68/Qy6bnrIdlOVvwWncwoysQ2nU21GXw0LLhF99Bd6bfueKoBD/ACPMVwC/1vMv1wlZEGZaMQHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695391; c=relaxed/simple;
	bh=3n4HhC/7wsuw6COyrxdLVHnQ6ZPOV/+3bIVhDFEv09s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nrKFQ8OKL31Hq1zTBpksOqkaQ84t4nkjKE++vmzXJwNJz+8qsK0CqdTP6iHUH6+5Au5kLqHs8y/6guOpY3h4wAphH7ZpSg92t4+594bPPFnhDtsDuWrZDL72hPb4hoPAmwRNvjajLRzF6rVsKfVmLd2C6DWLd/KZ3Gcu1ixw18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVSOwmfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226EBC4CEE7;
	Mon, 28 Jul 2025 09:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753695390;
	bh=3n4HhC/7wsuw6COyrxdLVHnQ6ZPOV/+3bIVhDFEv09s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bVSOwmfQwYZ0/WHu8G6oxZbLKERq7h7ySpobj9ZXcr+MJ30ZfeSnWMyub7S+ZxPEK
	 49KeYinltx73EITPQtST4Ttm/O5Fhk8XKUOgeyYVQWWcG7b5S7syvNCI1AlL3iuzvb
	 YmXVIqLN1DdCC1DMFm6j/1DBIuA4alFXnZWClZ6uASPV7yxxyPIlf9Ew895tYje2lU
	 UxzWnHdlKvdvLbKf16ISExwds0rSXTYV91aAcLe2YD7u0s2ifWzCxVDaHbRSVosIG/
	 /iBTC9xqF7udyij3hqXDEkpktGMALHhKr6j9jjWQWJaxmq0zc7qg/BvKXEB6CoYOsX
	 bMP8/MPp5rveA==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Yuvaraj Ranganathan <quic_yrangana@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
Subject: Re: (subset) [PATCH 0/8] dmaengine: qcom: bam_dma: Fix DT error
 handling for num-channels/ees
Message-Id: <175369538572.380782.9156416957982469667.b4-ty@kernel.org>
Date: Mon, 28 Jul 2025 15:06:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 12 Feb 2025 18:03:46 +0100, Stephan Gerhold wrote:
> num-channels and qcom,num-ees are required for BAM nodes without clock,
> because the driver cannot ensure the hardware is powered on when trying to
> obtain the information from the hardware registers. Specifying the node
> without these properties is unsafe and has caused early boot crashes for
> other SoCs before [1, 2].
> 
> The bam_dma driver has always printed an error to the kernel log in these
> situations, but that was not enough to prevent people from upstreaming
> patches without the required properties.
> 
> [...]

Applied, thanks!

[7/8] dt-bindings: dma: qcom: bam-dma: Add missing required properties
      commit: b04b950fddfcf2f7b0e6f789499c256d15b70720

Best regards,
-- 
~Vinod



