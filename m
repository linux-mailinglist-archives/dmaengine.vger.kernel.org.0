Return-Path: <dmaengine+bounces-5412-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDEAD6B77
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 10:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE24B16C8E6
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130F22154A;
	Thu, 12 Jun 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy4qzLDf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E801E51EB;
	Thu, 12 Jun 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718555; cv=none; b=Laqv2zyLhFPnyEM0Em712Gnm8Lq0DRTlSeMKl+REeF/WzaFJuxW+UH2D/eNSeomsc5k0x3HshWmz2QUN4Y05v7N0Oal0GDH91QeA2VzAGlRiNd5pe+kKF2n3bnZgmVw0M7mremQeTEnW/PLnW8tXRwKVJx0tu+Jm+jC0Nikv4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718555; c=relaxed/simple;
	bh=0QUTCiUny0eCr51w7ek1yKVwt5TNV5EjnPzwiEPvTMA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=B7QVpnkr+F3mzDyoeyfgh+O5WN8Vn86upj8zOEpj76sAk/xWa9tBFercKftEJNqHWgAvV87qjMFJltgYm8pQs+KyhqT2twVSg1XGUydDI4srnyA8H+vCE/n3W1Lf8EDrzIoFCF08DWFI+nFvdg6PmUHvPmZgsvTlgUA9Ps3NA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy4qzLDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55480C4CEEA;
	Thu, 12 Jun 2025 08:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749718553;
	bh=0QUTCiUny0eCr51w7ek1yKVwt5TNV5EjnPzwiEPvTMA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Yy4qzLDf07NFS4ydPK/3k4p/HYydUhpDxE7fSzbg319wHA0xctInGEHO0SuFXwaVb
	 chQhJdMyJZ3Tmg/ozH03H2giBJBJK0tEQ4TgnaD0H9fT9GOcWI22j/QXfN9W5KM4HY
	 ClTplDgWRItB6ZfASmbCvk+m0IlYm15w4MQOAwRTTmWL9falFUEqgNJ8IYwor1GhOu
	 dKVzm5DRrEbKhKwRAVXfLgQOGtIvYLs7TSYyjbz0wrGd+3fDekzD7CBn15oYH97l0D
	 nbmUFfuE+JnExjsoXssmsAWKSfrc2Nuj2pvj4gi93YT8Am1cKo2DjnlZhSax8wFYB8
	 dsDsEjjhTbg6Q==
Date: Thu, 12 Jun 2025 03:55:52 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: u-kumar1@ti.com, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 vigneshr@ti.com, a-chavda@ti.com, p-mantena@ti.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Santosh Shilimkar <ssantosh@kernel.org>, praneeth@ti.com, 
 Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org, 
 Nishanth Menon <nm@ti.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <20250612071521.3116831-13-s-adivi@ti.com>
References: <20250612071521.3116831-1-s-adivi@ti.com>
 <20250612071521.3116831-13-s-adivi@ti.com>
Message-Id: <174971855176.3983058.3404871673988477983.robh@kernel.org>
Subject: Re: [PATCH v2 12/17] dt-bindings: dma: ti: Add document for K3
 BCDMA V2


On Thu, 12 Jun 2025 12:45:16 +0530, Sai Sree Kartheek Adivi wrote:
> New binding document for
> Texas Instruments K3 Block Copy DMA (BCDMA) V2.
> 
> BCDMA V2 is introduced as part of AM62L.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  .../bindings/dma/ti/k3-bcdma-v2.yaml          | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.example.dtb: /example-0/cbass_main/dma-controller@485c4000: failed to match any schema with compatible: ['ti,dmss-bcdma-v2']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250612071521.3116831-13-s-adivi@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


