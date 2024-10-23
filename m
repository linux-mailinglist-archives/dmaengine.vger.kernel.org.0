Return-Path: <dmaengine+bounces-3421-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5E19AC179
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 10:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054AB1C22F02
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 08:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653CC15852E;
	Wed, 23 Oct 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvnWr6iv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738E487BE;
	Wed, 23 Oct 2024 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671948; cv=none; b=UlNkoiNE1LIeSJL5KCJN8ivqWxQmTE6KjToz3fxqMn0e+vxG1mF9oKEfxTPejn8rwTD1T49xq22okgyYdFwJkXSmkSwCbGHGn06ehowW2r+iKgOkWbf6nwPQIsNZIVqeSOJk25Fh2ea3t8Cjx4JxvbYda7N9DAqGibjWZtV1/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671948; c=relaxed/simple;
	bh=uwqcONdnpQ3dUmY5A6V0+mL2NCmeSot4LHUJhAlmkbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUhpAb8OcAiNUDGN3N/7BpaAW8cF39mjU2uYjWaLgDgASMOqKKRG7rpMWrvMuYjhh0bX30mFOlI++Xti7jlIChDfUoGD1rxGepA0jTz05ZSX7k1MyC3u46LuLHul95LZq/7D++/mssz8IHHWkUro0R1/CI2DYXhsLut7XIisVwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvnWr6iv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0B7C4CEC6;
	Wed, 23 Oct 2024 08:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729671947;
	bh=uwqcONdnpQ3dUmY5A6V0+mL2NCmeSot4LHUJhAlmkbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvnWr6iv1udkFDTQe2MtYdqlsNLDaDmvwvF2+DrctD5Ki+0SNf2l5bTYYb1x2yhHL
	 Svtdg6dz2oIbsaiNebYz1Z+zts40O+6s3OZxKJQG0FBYdWB8ycUj27XMJEgWe3+s2F
	 lRKPQhMQDC6pLeJzbtKDGzjoiARq+OLW6WhwaviII7NbWbIECYPE1/8EMnXDcyWf03
	 eoJq+BBO4O7R05XnLS8YBUJx22rOwV5iZkbyIHPYmEiBPFm5HUbyLwvfRrsrQiqWhx
	 CJnjMPuSoq16+tsji/kC5Ka9cFOuyTQidpowsTiTzzFyTDb/9X5FxMzzeaGK9gRkMW
	 /ugFg6M4in2bA==
Date: Wed, 23 Oct 2024 10:25:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Document the sm8750 GPI DMA
 engine
Message-ID: <u65ibtgt2ecenv3omqwuc7sybrwuepbdkwlgxphiuaplsvu6w6@a2sbrcwuxfyq>
References: <20241021230500.2632527-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021230500.2632527-1-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:05:00PM -0700, Melody Olvera wrote:
> Document the GPI DMA engine on the sm8750 platform.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


