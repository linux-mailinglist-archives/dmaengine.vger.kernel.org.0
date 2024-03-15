Return-Path: <dmaengine+bounces-1390-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD40087C846
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 05:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB5D1C2110E
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 04:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE10DDF44;
	Fri, 15 Mar 2024 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qx8emhmY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDCEDDDC;
	Fri, 15 Mar 2024 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710477430; cv=none; b=T6J+r/DDscpgk9DMHSG+EcySMwOnvPMTtLW0IZB/TxNbH33zU/9npq39DlLqnnp+OpFpQ5Uy/qLbBnKXRLrTLuBL9Qy6UpWdqkpQOdMXvjXRlA6nlpqujTWkcAFJQli2efBF/nDHTyoxNeaXWhMvLKgDDTm6i9d3FzRY8dVMVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710477430; c=relaxed/simple;
	bh=PUemYcFBAHOYhcdhTqcE5Userz2v4Fkqh5RMcCkrqVo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=gUrn35PHnpHjsHVdWka0yXyEhKXLOP27jOIJHf/8zm+VnyBPOttVwvYI2D0jY1JGb0nqPOOUjtOfl9Wy/H5wcmM57NSDO/fs3Q+yWZNSjMN7hWaqspHrSBP44fUQ/mT4K0SFCs6zTm9cN3DGwzE/i++lRxs4BzrGHQ1BLCsZI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qx8emhmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA0CC43390;
	Fri, 15 Mar 2024 04:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710477430;
	bh=PUemYcFBAHOYhcdhTqcE5Userz2v4Fkqh5RMcCkrqVo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qx8emhmYpsXEI4WbCttop0+dqnAdklqAL0xSfWVGuLwPdLcIx+ZbIfV3QRPWl8CwD
	 eXoc4lvrLvY9uYFHvcYMIxoSNScxCtUxU6MP9hWzoEfJam6oOl/0Ek+hcy1z7Uvbjd
	 /CAfosxaXYlckrqBX1ARfopMr+MAWTOB7kHFwgl6PvZEQ4/qXI+HtBjygRJPftDaWC
	 5/DQftw1S2C5Dp2u6O2lFWHX9Mrw18iZOTRAbziHpjv1QQ8lhkrIcdwD4NXMw5HZHs
	 Y0cNBKjDEaz2ermjUPv0UIqXbtQIsyl9pipSSWgPD2w3dHlcCq9QJYAziyCG3K+rh5
	 GxVmnMqGTiYSw==
Date: Thu, 14 Mar 2024 22:37:07 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, dmaengine@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 dlan@gentoo.org, linux-riscv@lists.infradead.org, 
 Chen Wang <unicorn_wang@outlook.com>, Vinod Koul <vkoul@kernel.org>, 
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Liu Gui <kenneth.liu@sophgo.com>
In-Reply-To: 
 <IA1PR20MB4953D930316266781A229E97BB282@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953E7BB0B270157C8D1DDACBB282@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953D930316266781A229E97BB282@IA1PR20MB4953.namprd20.prod.outlook.com>
Message-Id: <171047742671.4112904.2484238766002561256.robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: soc: sophgo: Add top misc
 controller of CV18XX/SG200X series SoC


On Fri, 15 Mar 2024 10:50:33 +0800, Inochi Amaoto wrote:
> CV18XX/SG200X series SoCs have a special top misc system controller,
> which provides register access for several devices. In addition to
> register access, this system controller also contains some subdevices
> (such as dmamux).
> 
> Add bindings for top misc controller of CV18XX/SG200X series SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dts:25.13-44: Warning (reg_format): /example-0/syscon@3000000/dma-router@154:reg: property has invalid length (16 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dts:23.26-29.13: Warning (avoid_default_addr_size): /example-0/syscon@3000000/dma-router@154: Relying on default #address-cells value
Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dts:23.26-29.13: Warning (avoid_default_addr_size): /example-0/syscon@3000000/dma-router@154: Relying on default #size-cells value
Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dtb: dma-router@154: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/IA1PR20MB4953D930316266781A229E97BB282@IA1PR20MB4953.namprd20.prod.outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


