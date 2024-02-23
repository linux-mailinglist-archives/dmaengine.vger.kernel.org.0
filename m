Return-Path: <dmaengine+bounces-1078-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F68607BB
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 01:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236841C22336
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 00:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0476FA8;
	Fri, 23 Feb 2024 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNk0Ggw3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD903209;
	Fri, 23 Feb 2024 00:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708648351; cv=none; b=g7dJqI+BkRhiCjEV/5Z/toaooy4eOvKmbD7OVgGHwW8C1dK5qBW/hvsYE51egjqcvjCsN36qxiQyJDZBLKAHAJgul+k3F7K2S5OaNIGfGZzUjNVxf3RvlHjfnniZ2KEd5ZoiHAnQZ1HLmIbENDloNjpSB7ZzUioRSDYAYyX/KHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708648351; c=relaxed/simple;
	bh=39PnR7lzUc4xlzKBBvykUEno32yE1GWmUwn8OLQwBoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evSQpODsVqJ3XVe22eu8rTWmxZRSU+7QW2kr2PZV1VHAZG/NP/MMiVyL4a+pAzX5ax6TaDUIoKFgRpWXzvI5qrW00Y6kQXNwpmRPSxqTOjk9AtmjV8fujHgszWmA3z4c6BU9jXM3vd5/+Bm9N33nOHqrm4SvAbaPpRnmGFsdVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNk0Ggw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AC7C433C7;
	Fri, 23 Feb 2024 00:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708648350;
	bh=39PnR7lzUc4xlzKBBvykUEno32yE1GWmUwn8OLQwBoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNk0Ggw3XXCwyobwwjTbjSK4MTQfJ8CBHszxVeHpcu5DHpj/AWTgwW2i+UYhtpltA
	 US9zEtmUulkpBxmhw4a+f1aIsC4CX6k71KjgukO4+PYTI+yQ2709qyKBN8Sfbkj0Qe
	 3JtoPAE+CvXm7xtWp75udfIdKm207mJXI6yczzqjm7bh7u1wweJe7LAiHI78CSSwWI
	 Q3fgaT3/WsqffI9tVG/wSW2yfISIpFpN6dV1rVvf+bWKrtuBFDPAoA1lNWTKDsutOl
	 pbqL5Iwy9OSBBn6oOwVT/9PhtQgBQTRF4Zl3Cs5u349w+jyMw/nJ5PQO8L1GVtiSC+
	 iwX6ahNKrdIEQ==
Date: Thu, 22 Feb 2024 17:32:26 -0700
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org, dlan@gentoo.org,
	Chen Wang <unicorn_wang@outlook.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	Liu Gui <kenneth.liu@sophgo.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
Message-ID: <170864834605.3981147.17280292328482810678.robh@kernel.org>
References: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB4962B924A3BB53FB2C161CF5BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR20MB4962B924A3BB53FB2C161CF5BB502@PH7PR20MB4962.namprd20.prod.outlook.com>


On Tue, 20 Feb 2024 18:28:58 +0800, Inochi Amaoto wrote:
> The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> an additional channel remap register located in the top system control
> area. The DMA channel is exclusive to each core.
> 
> Add the dmamux binding for CV18XX/SG200X series SoC
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 44 +++++++++++++++
>  include/dt-bindings/dma/cv1800-dma.h          | 55 +++++++++++++++++++
>  2 files changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
>  create mode 100644 include/dt-bindings/dma/cv1800-dma.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


