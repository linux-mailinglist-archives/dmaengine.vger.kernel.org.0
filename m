Return-Path: <dmaengine+bounces-1079-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306928607C0
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 01:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5035DB21CE0
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 00:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50ABE4A;
	Fri, 23 Feb 2024 00:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDsYLGcT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DCDB65F;
	Fri, 23 Feb 2024 00:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708648419; cv=none; b=flSa2Fr+LqNFo3+kkDvqO48UghkEefF5ydasc+phPEmzbGhg7oY3k5PTx9cz/Ld8djG2tPPmNGS5HJLPeYQuuHgWVtAy8h5JCNdBFCldV/m47Ayn3zOOfkuKSuH8t4ejFf13q0F20l2RTxALfk6jWjW1wUYypCfAuN+jadjxWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708648419; c=relaxed/simple;
	bh=cBU1jt1M8bZGFlsvQJ38aNDs/DA2/MQxShbTiC7Nm5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQv7y8zOXhRQdjTeowW5L6Q0bjqYDL5Hu0vPyMw/EC6d2kUDhOXmoFV4aRptl1Zs6au/0frqlYNb6qjbCRexMX8dke++7InVPyIvRtj2Lo2jRU5vAiOsiRx6RCEl3is+LNlCq/9XP9l/Z1ZOQDS+oZSiCRZOEQHC4T5l3WT1P9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDsYLGcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E92C433F1;
	Fri, 23 Feb 2024 00:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708648418;
	bh=cBU1jt1M8bZGFlsvQJ38aNDs/DA2/MQxShbTiC7Nm5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDsYLGcTA+ia+aygpPKeAbN/zQXOaKUCUiuK2UNLDYkKau1qWuXUI7zC9SpmrJcrH
	 Xxha085TJ7oOXL03JV90djtanvXBIyWr3jwW1mFr9+Vmdk3c4kB8T6WTvDYsi6pE9v
	 ESdIhshMLWrxdjNe5k3gh3lzqMSV0tFVtLudiqYAwq+3apNNv0wUDjBEsR7lf381QX
	 QLQdE6zuXjrVqyrYGO7QYc5G/uiVN9cJsI04lhiEBpdlceH7mgKm0BuI5vDg+Xd1Hm
	 C3LkIHOf92G8VdyOF1Yc6czDVKpGbrmMDaBi2DYJP3HH40kb897EkLqxM136cce4pc
	 /BKR+8Y5vQntA==
Date: Thu, 22 Feb 2024 17:33:34 -0700
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: sophgo: Add top misc controller
 of CV18XX/SG200X series SoC
Message-ID: <20240223003334.GA3981337-robh@kernel.org>
References: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB4962BEA2751F7C45A16E40B9BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR20MB4962BEA2751F7C45A16E40B9BB502@PH7PR20MB4962.namprd20.prod.outlook.com>

On Tue, Feb 20, 2024 at 06:28:59PM +0800, Inochi Amaoto wrote:
> CV18XX/SG200X series SoCs have a special top misc system controller,
> which provides register access for several devices. In addition to
> register access, this system controller also contains some subdevices
> (such as dmamux).
> 
> Add bindings for top misc controller of CV18XX/SG200X series SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> new file mode 100644
> index 000000000000..29825fee66d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800-top-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV1800/SG2000 SoC top system controller
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +description:
> +  The Sophgo CV1800/SG2000 SoC top misc system controller provides
> +  register access to configure related modules.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sophgo,cv1800-top-syscon
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties:
> +  type: object
> +
> +examples:
> +  - |
> +    syscon@3000000 {
> +      compatible = "sophgo,cv1800-top-syscon",
> +                   "syscon", "simple-mfd";
> +      reg = <0x03000000 0x1000>;
> +
> +      dma-router {

Is there no defined register set you can put in 'reg' here?

> +        compatible = "sophgo,cv1800-dmamux";
> +        #dma-cells = <3>;
> +        dma-masters = <&dmac>;
> +        dma-requests = <8>;
> +      };
> +    };
> +
> +...
> --
> 2.43.2
> 

