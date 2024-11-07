Return-Path: <dmaengine+bounces-3691-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F649C02CF
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2024 11:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6EE2820B1
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2024 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D40A1EC01C;
	Thu,  7 Nov 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJZMAAza"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D262B1E008B;
	Thu,  7 Nov 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976431; cv=none; b=JFwGFfBSly7n/accVpNp2r2ZmdpHaz48Dwc3EQrcPL/MlIBXL6ZJoOFEej1z6OSECN4+gufTWF5gioYsaNGIfptM+01OJs5zKFB7AQ/uf/obvRoJ0fxgOhgtM08f4YA1qQo9sBEYRR+mmFgBGoGIw31RwNAs2dfSWpthaS3g4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976431; c=relaxed/simple;
	bh=Art4tjTbLwOkQmQuSLoUMtaDzZxOOTvatVcVcO2CX38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNnbnfdg66wxreDVfnTo2gN5ywLX3C5czR8jB+2RlbSYCnN4FA1+la69mP6NBpVBqJv/gbH/3XnXU8vfanudWtpZ9E0ejnzuWnQNCOCKwXO4q+27x8fdVoT9Sxc7EyGpg1zEi2XOsVbaqzOIoKzzbnHDBHKokvqOq4yxc8aSKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJZMAAza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF80C4CECC;
	Thu,  7 Nov 2024 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730976431;
	bh=Art4tjTbLwOkQmQuSLoUMtaDzZxOOTvatVcVcO2CX38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJZMAAzaTWBqVnyGRVuuw+VOZZNCnWCm/oNy3lpdtFpVdhjXStJrZ/P/Limh62Vdw
	 m5S6ueJKiv6ErZNbY9Wi/iA4JddK5fVak2CbPaazFNcTmnN0npc7v4A+ePBY+DGVrM
	 InFydxEQ2Ny5vXYTQ1kP4t+fEJyfuWF0CnPG25NkvNjCiTLX3hxzhQrVKv44MA+iwl
	 QNrykG0BBe6thoQSITPHJNjkUCKnKjEMQKdchTotoVveXOuVnYgl12ulq81t+pEcQ5
	 H9A2/zQM1udFOfO188G0rFdYvI07GtL84a3+YyHCY3e3yKSQFvBK+ol5t8A31W7cDE
	 I9bpeyDyiGQzg==
Date: Thu, 7 Nov 2024 11:47:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com, 
	quic_anupkulk@quicinc.com
Subject: Re: [PATCH v1] dt-bindings: dma: qcom,gpi: Add QCS615 compatible
Message-ID: <w66ki7lwrqol24iptikn7ccna25ujqoywjena5ulekf6vynxny@dylbj2r34h7l>
References: <20241105104759.3775672-1-quic_vdadhani@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105104759.3775672-1-quic_vdadhani@quicinc.com>

On Tue, Nov 05, 2024 at 04:17:59PM +0530, Viken Dadhaniya wrote:
> Document compatible for GPI DMA controller on QCS615 platform.

It's nice to say something more about hardware, e.g. with what it is
compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


