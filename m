Return-Path: <dmaengine+bounces-3655-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1589B7003
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 23:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085381C213E4
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 22:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB4F213EF6;
	Wed, 30 Oct 2024 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwXp4agm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626401F4288;
	Wed, 30 Oct 2024 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328678; cv=none; b=SVKOQW/DH2RNiVSP64rrHslUJuaPesL3+s1wEjbj8kqev+7WZLg9JsRyBCZ3ye57v8dPiwW4ikxB5c8dGuBNyN7Ge8bHBqp9+K7FJm6lVrQyplpuoCw2La4IX3sn0LQXrdrq5sOr5yh964cEqR1vCMe62cHDManKJ3s06auXKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328678; c=relaxed/simple;
	bh=6984DWiiZS6tpY28qzM6kzD89hg0yELFs+RNJQ8Wu9Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=I/B2bi8G4Y2R8vkji4n6wCIPoR0DmPTScMJkDQ99g5KvDMNkSvVLqcbZWM+g93zq6Xui+zPiwKBIDrYfH5bHx1mbXEgc0Bvv3VAzBHH8JN9Q1sEcJ3Egz5uRTxUwsQK9NooxqSultVltdNYu/Kv8NQyizjs6jPL+4hOjEBy2Q/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwXp4agm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD72C4CECE;
	Wed, 30 Oct 2024 22:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730328676;
	bh=6984DWiiZS6tpY28qzM6kzD89hg0yELFs+RNJQ8Wu9Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BwXp4agmfVWQmJf6zrYQmWhunGpiG4KNBmdIhywjHM7ULS6RWwE+jKOYGJyR/uoHi
	 WtWPh1dSm1BJYOxpJ4eRN/rgGQU9BQjTYx7nLCO2lZvvOcrjT+2IOl1Ag0muixkKLK
	 aH6CT1e90ckLNGB9fhofWECC7jbB5s6Xae65l4fo5cuH5GgzqtnVvLAWiZStwfIp54
	 YHNG2wVPQY6So6ShwY5IkgYdysN3T3uMpAppb1CTkBgK3yy102SPar02WnqAv0FEVz
	 9Hn3S+sAc+PpGCkrPhJN+OTMATpXL6ao3YEcPEtNy4neNQg4LlXoiNpryhcbKT4H5d
	 qSe5oJ1BE2xGQ==
Date: Wed, 30 Oct 2024 17:51:14 -0500
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
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Vinod Koul <vkoul@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20241030-axi-dma-dt-yaml-v3-1-d3a9b506f96c@baylibre.com>
References: <20241030-axi-dma-dt-yaml-v3-0-d3a9b506f96c@baylibre.com>
 <20241030-axi-dma-dt-yaml-v3-1-d3a9b506f96c@baylibre.com>
Message-Id: <173032867487.2384864.2184195071332557080.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: adi,axi-dmac: convert to yaml
 schema


On Wed, 30 Oct 2024 16:33:56 -0500, David Lechner wrote:
> Convert the AXI DMAC bindings from .txt to .yaml.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241030-axi-dma-dt-yaml-v3-1-d3a9b506f96c@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


