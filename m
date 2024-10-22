Return-Path: <dmaengine+bounces-3411-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4B9AB6BF
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 21:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D862840C8
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 19:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012261CB510;
	Tue, 22 Oct 2024 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILAwB6Ym"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A61CB32D;
	Tue, 22 Oct 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625266; cv=none; b=he6aBL15ox2Y1UtaR79Q78il+4VQXh+yuzCmA7Ug6DJuUBV4ZJqsS5k8BFQjuZApHjwRhZoxlpyBxy4G3dxLbgFIieHwGhoVt4k5FblNAbZGTKEjcEEdp4B2Oq9CoE94CK/UcKL9Hpz2MFnrCMc9Kh5AhqX4ev7sp3/scwQXwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625266; c=relaxed/simple;
	bh=t4G2nEue0LMPrLYZAJMBgi28497oY2Cr/YEeOQWx2hk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=c30msFYbyyjhoF5z1kPNdfI4f1aWLddrT16rixH/J/tY5uDiANdE1MoaBGZs0GRJr9I4xog0TVQQ4daeRrlm0g/bxGwU+buAPHYjOIfpC77cTnw7v1xAhJ8sp5OR6yvgQgmvp5KtyjQDpA9KygmKhMz/hwhVM5FdASr2nomJCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILAwB6Ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A678C4CEC3;
	Tue, 22 Oct 2024 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729625266;
	bh=t4G2nEue0LMPrLYZAJMBgi28497oY2Cr/YEeOQWx2hk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ILAwB6YmqfDs/3Vf9MWSiI9tDDiCe6j0+dOd/ae4r3fDQ6pt9KO+ryYcKyFXjikjL
	 /n4h/NfTALM34sE8ThTJsFxb2jD4zFJYM4q9m8M6pLN/KiFdV1qXUHtmXFkFDNDQgH
	 L8KadJ1lObkV8bCDT/4xZoHSwk9uQ1XPUKvg1TsCuDfBtG1ioVQ07Tu/p2LfXzQyEl
	 vpBBHYl+NqoBc0WEBNLdUw1n8xDoY3Z6ecXBqic91BV0ivdapaOaRw5ZkS83lP06lo
	 qPbGYVxT/A9Jf+capcLFcep8vOU93xg2V8aYpG8+M5lYUyKB2qlKiYSsoE1OHG4p4U
	 YV9bkgbxRz7dA==
Date: Tue, 22 Oct 2024 14:27:45 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 dmaengine@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20241022-axi-dma-dt-yaml-v1-1-68f2a2498d53@baylibre.com>
References: <20241022-axi-dma-dt-yaml-v1-0-68f2a2498d53@baylibre.com>
 <20241022-axi-dma-dt-yaml-v1-1-68f2a2498d53@baylibre.com>
Message-Id: <172962526539.1434557.4340108158922608537.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: dma: adi,axi-dmac: convert to yaml
 schema


On Tue, 22 Oct 2024 12:46:40 -0500, David Lechner wrote:
> Convert the AXI DMAC bindings from .txt to .yaml.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> For the maintainer, Lars is the original author, but isn't really
> active with ADI anymore, so I have added Nuno instead since he is the
> most active ADI representative currently and is knowledgeable about this
> hardware.
> 
> Also, the rob-bot is likely to complain. Locally, I am getting the
> following warning from dt_bindings_check:
> 
> 	Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml: properties:adi,channels:type: 'boolean' was expected
> 		hint: A vendor boolean property can use "type: boolean"
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	DTC [C] Documentation/devicetree/bindings/dma/adi,axi-dmac.example.dtb
> 
> I think this is telling me that object nodes should not have a vendor
> prefix. However, since this is an existing bindings, we can't change
> that.
> ---
>  .../devicetree/bindings/dma/adi,axi-dmac.txt       |  61 ---------
>  .../devicetree/bindings/dma/adi,axi-dmac.yaml      | 137 +++++++++++++++++++++
>  2 files changed, 137 insertions(+), 61 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml: properties:adi,channels:type: 'boolean' was expected
	hint: A vendor boolean property can use "type: boolean"
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241022-axi-dma-dt-yaml-v1-1-68f2a2498d53@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


