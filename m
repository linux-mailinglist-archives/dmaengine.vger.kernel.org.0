Return-Path: <dmaengine+bounces-3639-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F529B544C
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 21:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75A82857E4
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 20:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A117C20C02F;
	Tue, 29 Oct 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbUjgBv4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754662076DE;
	Tue, 29 Oct 2024 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234560; cv=none; b=ryj33mhuZ31Xsdh74lOt43RJIJSGOhAd7TT57kxeuJn+LxE1DE8euoePDINsPKSAfBB8KssTRwtmqy5t3i65OewtYYmb+VVWVOe4FGmZjw+oCQsE53SLYPMgMvZXJtOAbWi4e0V1GQQwg3+oOxGZ9chw1BVC4KXLWtHtF6onYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234560; c=relaxed/simple;
	bh=HcHPYKJzVMGol5SkJjwz2YHmnwXp2odjeLVoF6z6SOA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=cDkWlqfFuY2vm+NE5P/x9f/4i27WhSEizIjDTDFnBQbW1eEdN6u9TLwt4dfejpMEJd/5L9ysqvbkIjSJnNZLn/nSbhCNgWY8qbm3PduzgpZxeSyxM+vojCxqtPY/4pHAorCuUewDcDO8cVlRujkcf5lKcAJTQRjzD37BQcXHX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbUjgBv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A4AC4CECD;
	Tue, 29 Oct 2024 20:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730234558;
	bh=HcHPYKJzVMGol5SkJjwz2YHmnwXp2odjeLVoF6z6SOA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fbUjgBv4L9WFnFZv7YvkOF/T3zEeCiZXonMSPGkUYJ/WZQUmR9GIzW/QOS8lDUADN
	 TynNTbWg2K8NOnDu2wG6TOvi3UiFs5uRTsu/UebmGWSfWDOV1TZ+wV5b1Y/PREkJIO
	 yIsFkshMc/2gWzcmQjT/SAK9Bv2O2xE2WKVAWv4tot8RBRBpjSycxQcD7jA6re25nJ
	 XF4gw1jeo4mHM6EYERVjMu1fG9VPtFgKrJvkZvRRuVzip/qdwugfNyMNLulNW6nRqk
	 2UjIWIQpmv25aZYQtXznwlcbx+yIEipw5IJt5aYoZDvAbedZ8wwukGgcAcWdPFapjJ
	 YHg7fiBBU2jgA==
Date: Tue, 29 Oct 2024 15:42:36 -0500
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
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20241029-axi-dma-dt-yaml-v2-1-52a6ec7df251@baylibre.com>
References: <20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com>
 <20241029-axi-dma-dt-yaml-v2-1-52a6ec7df251@baylibre.com>
Message-Id: <173023455539.1620834.4844843662866954288.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: adi,axi-dmac: convert to yaml
 schema


On Tue, 29 Oct 2024 14:29:14 -0500, David Lechner wrote:
> Convert the AXI DMAC bindings from .txt to .yaml.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> For the maintainer, Lars is the original author, but isn't really
> active with ADI anymore, so I have added Nuno instead since he is the
> most active ADI representative currently and is knowledgeable about this
> hardware.
> 
> As in v1, the rob-bot is likely to complain with the following:
> 
> 	Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml: properties:adi,channels:type: 'boolean' was expected
> 		hint: A vendor boolean property can use "type: boolean"
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	DTC [C] Documentation/devicetree/bindings/dma/adi,axi-dmac.example.dtb
> 
> This is due to the fact that we have a vendor prefix on an object node.
> We can't change that since it is an existing binding. Rob said he will
> fix this in dtschema.
> ---
>  .../devicetree/bindings/dma/adi,axi-dmac.txt       |  61 ---------
>  .../devicetree/bindings/dma/adi,axi-dmac.yaml      | 139 +++++++++++++++++++++
>  2 files changed, 139 insertions(+), 61 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml: properties:adi,channels:type: 'boolean' was expected
	hint: A vendor boolean property can use "type: boolean"
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241029-axi-dma-dt-yaml-v2-1-52a6ec7df251@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


