Return-Path: <dmaengine+bounces-7073-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E83AC39942
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 09:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C91A3B81E1
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0583019D9;
	Thu,  6 Nov 2025 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czG+46CH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC783019D2;
	Thu,  6 Nov 2025 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417664; cv=none; b=IuTj+W/99iC+dqgN8XPPNwIGh6MvswmESh1+G/HKCAD+lSNnM9XDZDd81KJ0Je/lh652xBAaaTFy1zd6sBYR5Nf0qrjNXWiu/wzlWk9d2dPgSK1nGoPTa2AWIlfYzNZUEIr8zV5bTF1Lu9K+b3vt4+d40jgg9vD//3av1HAOChM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417664; c=relaxed/simple;
	bh=piok6udxBqWBTMQORGjJb6hVQfQMMfQmXd5wVaet1is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQzsEE5W+i7GduqpI4sHhZg2CW0yeiiO54PLlmyF6UmbKUOpJlU8CciqvyI2lBw+4mc3OPSXuwWplQvv60nSm0LO+tOeyF1KF78Q1IInlqy43kcUu9lxfi5Mt+onEqW7wPDiHhfxD1WUFqKK16GOR7bKsDmzV7hKUBsAt1EKbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czG+46CH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89328C16AAE;
	Thu,  6 Nov 2025 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762417663;
	bh=piok6udxBqWBTMQORGjJb6hVQfQMMfQmXd5wVaet1is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czG+46CHlrs2jFBhA3Y9N2FRsS2+XsFfExTDRZ5F8iqENrgsfr+IcOEY0pbI2D/Lk
	 t5H9FFOHhf1MHYRS0a/ht7BIVaNnDgxBnMVK0/a8mmSkycSqKryK1IThv1I+09gH5P
	 ICivWM6HxNS+Ve2ExyvS2rD7O2+7AI0428/fEp3kAG5VV0Al68U07p+lklGVwvn1mT
	 zyV1n/MNRxUNuXALFm6iklpnZ0O4JJxnxTZkNrMw3Q8+QRW4XBFQ7acXmuzTdZiKfS
	 nuuvl3gOFnsUxdk0f1qbFvXADsf9d++Qk1Rg6OCmBBWQEzK/pUwfNuzvgQSt7/k8dD
	 SIPwnT927tncw==
Date: Thu, 6 Nov 2025 09:27:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, aiqun.yu@oss.qualcomm.com, 
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>, 
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Subject: Re: [PATCH v2] dt-bindings: dma: qcom,gpi: Document GPI DMA engine
 for Kaanapali and Glymur SoCs
Message-ID: <20251106-glistening-invisible-rat-02c56b@kuoka>
References: <20251105-knp-bus-v2-1-ed3095c7013a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105-knp-bus-v2-1-ed3095c7013a@oss.qualcomm.com>

On Wed, Nov 05, 2025 at 07:00:42PM -0800, Jingyi Wang wrote:
> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> 
> Document the GPI DMA engine on the Kaanapali and Glymur platforms.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
> Changes in v2:
> - squash glymur binding: https://lore.kernel.org/all/20250920133305.412974-1-pankaj.patil@oss.qualcomm.com/
> - Link to v1: https://lore.kernel.org/r/20250924-knp-bus-v1-1-f2f2c6e6a797@oss.qualcomm.com
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


