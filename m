Return-Path: <dmaengine+bounces-5413-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23527AD6B79
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 10:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE377A34D3
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A07221DB4;
	Thu, 12 Jun 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKTGJlXb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDB20B7EA;
	Thu, 12 Jun 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718555; cv=none; b=Tkyrg1hwLReD+R/SZkpmJTmGXQOg+oNdjokGi8h99nJ8Ny0kuN9B0B9GC6P1d+GP2jU7AfUH5NXn93nVZK/xLP8i8OKSw3z78/dC+oPzY27siWo30AA24l6ldT07aGxMF9tC9J61tT2PpPynIahrRXUUnnTrNdaTggYi1l/1r78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718555; c=relaxed/simple;
	bh=RQYBtssOY7+oGdh2lG5OPgacAKGthN9dqgrlCVHiJRE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=auX61MDr/N274qTa8QSd5H9ZAsdmVO4G12EnWONelVTQ41tJxYxFfVmKW0/Ywn0dVk6wmsbihuDy+BeMZz23HuHkguP4RerKhyOBW60i+Srn+/1rJsBy4JwItV0tAm2V6wjHMRHUa212KpqlCS9Xmc+2gB/ZEI7x8LYBQ292rE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKTGJlXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A6AC4CEEE;
	Thu, 12 Jun 2025 08:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749718554;
	bh=RQYBtssOY7+oGdh2lG5OPgacAKGthN9dqgrlCVHiJRE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=tKTGJlXb7NbO6b72bfefP6nbDKNQIB3EPfZ0fRG9zHBuxX+fFJBmM8JWl9A4wNp/v
	 AkNRhDzu+4ySC7dtwTvZSNlgxGB+7ewfbaWK5dmxhClE0JsHuHf7sbDpq0hxqcbbt5
	 dzHrHEa5uGzGQBn+ULgzXGLd/USBX3zERlwZUx8W7rVnapqLQmcjFlBGWuw+6N8er3
	 mQEUsjf45FweghnyY8tFh/T7yXa9qiYDwxeZr/QYcItPdEvIM6IWKfWJPYzllmt7+c
	 IxBj3LPrx4TF5DVcjZLSarj3g1d8bQl2avHfL44BVhst20ce2laoO6mq9aP7rjp/cj
	 URlXZ3zyVZ2hA==
Date: Thu, 12 Jun 2025 03:55:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: u-kumar1@ti.com, linux-arm-kernel@lists.infradead.org, 
 Nishanth Menon <nm@ti.com>, Vinod Koul <vkoul@kernel.org>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 a-chavda@ti.com, p-mantena@ti.com, vigneshr@ti.com, 
 Santosh Shilimkar <ssantosh@kernel.org>, praneeth@ti.com, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <20250612071521.3116831-14-s-adivi@ti.com>
References: <20250612071521.3116831-1-s-adivi@ti.com>
 <20250612071521.3116831-14-s-adivi@ti.com>
Message-Id: <174971855245.3983211.889546911604873358.robh@kernel.org>
Subject: Re: [PATCH v2 13/17] dt-bindings: dma: ti: Add document for K3
 PKTDMA V2


On Thu, 12 Jun 2025 12:45:17 +0530, Sai Sree Kartheek Adivi wrote:
> New binding document for
> Texas Instruments K3 Packet DMA (PKTDMA) V2.
> 
> PKTDMA V2 is introduced as part of AM62L.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  .../bindings/dma/ti/k3-pktdma-v2.yaml         | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-pktdma-v2.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dma/ti/k3-pktdma-v2.example.dtb: /example-0/cbass_main/dma-controller@485c0000: failed to match any schema with compatible: ['ti,dmss-pktdma-v2']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250612071521.3116831-14-s-adivi@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


