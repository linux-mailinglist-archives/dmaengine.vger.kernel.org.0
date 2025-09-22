Return-Path: <dmaengine+bounces-6683-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 011A9B928DE
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 20:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5ED2440C44
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE3331771E;
	Mon, 22 Sep 2025 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpGqUY9t"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BED3316910;
	Mon, 22 Sep 2025 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564535; cv=none; b=BFsy/cHilADKPeELA87xZBSH1vvmGnxEbHyZ1PWROjEWs9g7VLGRym9qfJDM1eY7fiXb4rRFMcgAbRnYoZKYYVPazgTuqj96cgy76ZEHvtlCn8t/yVA3E2g1wZLUUPG/F7M8SIVtS5f8cgiei1PDUnpElUN8k1kXlst8WiVagg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564535; c=relaxed/simple;
	bh=ZpBXykY5GNJ3iTwM8KdwNbZCQ0CzTVwUOQGlFr5Uj8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5/ueVxNMpkNU0HvTmgHd46WpmZ7+1iBpO0IkzzdJ6S0/YkKK4RjRlH1lWshRt7ePLuOGsMxMOC4QlCby+5xTDMJvVs3VIn/lbaJb3GilI9HnA+ViegJgHhelMJCQZ9fsKumiIxFeLdPZdQsvGonSmWOE6fZyVbpZ2L6sToV4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpGqUY9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2CBC4CEF0;
	Mon, 22 Sep 2025 18:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758564534;
	bh=ZpBXykY5GNJ3iTwM8KdwNbZCQ0CzTVwUOQGlFr5Uj8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpGqUY9tAbHoS6O0fQsM5SICqWep8YqbeQ/cpjWS5o+s1i5vw/RlUISCLYPFuN1ZT
	 31S4Wsp+nkJ9R8+PHa4jgkgdwv6xWTMHF291bFtTiXnrJIs1zx42Gng9V9+4YIhskr
	 SYD9a4e6G+O2GAoMwFkw/NU7ge/Mw13apT+h1VWATEhMLfA19CR67v5UoNTftM00FP
	 Jpebm4E8zknwP6qq7N96XHpDDwbSUYdOtbwKH0Z3NTG/53V6uxBO2w+mRBAGhteQwO
	 bDTVYH3M1Rb1vh2Fa55Fev3q2xUjxuDgQuXuRAyj2ThNXyZ7diOTkQZqsp56tQgljJ
	 4X66QCUQ8sxRw==
Date: Mon, 22 Sep 2025 13:08:51 -0500
From: Rob Herring <robh@kernel.org>
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: dma: Add RDA IFC DMA
Message-ID: <20250922180851.GB547468-robh@kernel.org>
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
 <20250919-rda8810pl-mmc-v1-3-d4f08a05ba4d@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-rda8810pl-mmc-v1-3-d4f08a05ba4d@mainlining.org>

On Fri, Sep 19, 2025 at 01:48:43AM +0700, Dang Huynh wrote:
> The Intelligent Flow Controller (IFC) is a scatter/gather DMA
> controller.
> 
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
>  Documentation/devicetree/bindings/dma/rda,ifc.yaml | 45 ++++++++++++++++++++++
>  include/dt-bindings/dma/rda-ifc.h                  | 28 ++++++++++++++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/rda,ifc.yaml b/Documentation/devicetree/bindings/dma/rda,ifc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..323e1e87cee09cfc7b64bf44bef61e4d1e91afa5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/rda,ifc.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/rda,ifc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RDA Intelligent Flow Controller (IFC)
> +
> +maintainers:
> +  - Dang Huynh <dang.huynh@mainlining.org>
> +
> +description: |
> +  RDA IFC is a DMA controller, it only supports scatter/gather lists.
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - rda,8810pl-ifc
> +      - const: rda,ifc

Also, drop. Generic compatibles are rarely useful. If the next chip has 
the same block, then 'rda,8810pl-ifc' can be the fallback compatible.

Rob

