Return-Path: <dmaengine+bounces-2126-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D52538CB04A
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 16:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91393282113
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C871712FB13;
	Tue, 21 May 2024 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O36qRlvU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372C12EBEE;
	Tue, 21 May 2024 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301337; cv=none; b=m6DGVkS601QEL9Okl7igKirRlC98RauvC2VNWHAUZOJzsBFTNbqdvoyptNuoYYIcBCfXFKvpXmOclJWfG15EyOhqurdrTcOI9JQN/gZ6xuEu53UXCs5bCg5+0jipCfwSeDON6vdL9TwDQ21ARxg9gd3MQ9E2SBi55zwch8qV5d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301337; c=relaxed/simple;
	bh=RLq+RXQNSzy0R9or81dkF+MdgPUySYmWw8nGPvv9Drc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jquYMYRvdunKu6NTGf4V6CMgsLR1HlwnwW+90Cj6+TRO/U7zpRRskqwZR8uZxMuNSm4Kv7qKqzvYsYzRixPSbJ73L+004DtYsd4be8ed5nzwpcFIhU3lAGyfliuKSQl0Wbc7ULMo12nCVnBCTvTR4BCtq0KX2JaP34T7SMfw5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O36qRlvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F252AC2BD11;
	Tue, 21 May 2024 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716301337;
	bh=RLq+RXQNSzy0R9or81dkF+MdgPUySYmWw8nGPvv9Drc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O36qRlvUDk1F5zemOQgGYt9Srsrp1GE2glmpjPmICjEA47rlQWTIDrV3/oZXOleMl
	 V+3k0cpR32vjVFqDcq/GeeyZJTwZhJCNCsxe2wudjFOG7U5iTbhgjvPiZbn59txAUG
	 P68LM7kWzIe1fVug3aLcNPK/oSWzHbYyBeCTFq87+nsGyH63fEvvsrvrAJ9I2OjYmu
	 LBQxuzQ+Lx4CBs6/EYQHMfqJuuuVFk4aHwHMXYHqtFGiNkaHGuP4bR/kT0ZfF7KEgi
	 xuTMXuJK4D0Kj3JFkSZ1+poifFjNem7DkKs+xJClpdCdlHqC7Py32LHXK/wAoci7ua
	 xGVh/IGMDIaJg==
Date: Tue, 21 May 2024 09:22:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	stable@vger.kernel.org, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: fsl-edma: fix dma-channels constraints
Message-ID: <171630133350.4112614.15318794245915872440.robh@kernel.org>
References: <20240521083002.23262-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521083002.23262-1-krzysztof.kozlowski@linaro.org>


On Tue, 21 May 2024 10:30:02 +0200, Krzysztof Kozlowski wrote:
> dma-channels is a number, not a list.  Apply proper constraints on the
> actual number.
> 
> Fixes: 6eb439dff645 ("dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


