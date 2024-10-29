Return-Path: <dmaengine+bounces-3640-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FB09B544E
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 21:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7F21F217A3
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 20:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A127120C035;
	Tue, 29 Oct 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpjY7B7c"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754073207;
	Tue, 29 Oct 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234560; cv=none; b=DF9nt9/cR86Un/W78FpEZap3gLitr3sAZois+ZSpBMrxjakzRfipn6sk3W+3vaBUaBkHkXIobifycdJzjzFD1hJrYXukGHrF2ckPDdO9u5ZIzcS3O546MMHI+i8O+8C4L/9DrT5k+N4y5ZV4fnsxv0WXh/5E/qPp3+7b5HUBj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234560; c=relaxed/simple;
	bh=9fvuPkywl8HW3/QOWTp7Q5krfZOi18PJayiTTRq3EZ8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VnDVNMqBxbOsm5GT5los6IbEdMEjeavsZfr/P9OaWmbuCjnNso+zUATfTgtLHxMBYzg+GTK86+c2UYnaK5ZshNKOeuGcTFZRGZ+79tJzjYSMt23EkycJMO5wyy5tVv8K6ILGvEUSuaYNfDsnpcIbCb0cxqQlajsIevuPXSHoa+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpjY7B7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53A0C4CEE4;
	Tue, 29 Oct 2024 20:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730234560;
	bh=9fvuPkywl8HW3/QOWTp7Q5krfZOi18PJayiTTRq3EZ8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GpjY7B7cJLvaKIh32sIg7v4ch9K1WrUS/26SMj9EutuKBkFN4EqbeU2wyK06YHDVh
	 RQnAlWz65NoKtgYkGNTlRg7Bjz37LsyAeS+LYe6X0wuQnnSxpIGcg2VMP6oh/WWFSs
	 WdNb02U1hymHiUKyYBhslc/rGgV3IiZskhbf6j0/lFegzBZG6rkHwSA5TwvP7VXwV1
	 fjSIIvh9bwbLPjyFlfSVOIkKEhFciE8Y8HvgGqY9fCwNuXLq2/qrGFy1fMQ8NFZ+5E
	 qhmAiIVgPW2O/Lv4nx8JFZ1eVrc2PUhzJX32VAVgnORBRvi19sK/OkveqcW3LDiQy0
	 vn6VhN2bFFB2A==
Date: Tue, 29 Oct 2024 15:42:38 -0500
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
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
 Nuno Sa <nuno.sa@analog.com>
In-Reply-To: <20241029-axi-dma-dt-yaml-v2-2-52a6ec7df251@baylibre.com>
References: <20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com>
 <20241029-axi-dma-dt-yaml-v2-2-52a6ec7df251@baylibre.com>
Message-Id: <173023455618.1620887.12454823992375368491.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: adi,axi-dmac: deprecate
 adi,channels node


On Tue, 29 Oct 2024 14:29:15 -0500, David Lechner wrote:
> Deprecate the adi,channels node in the adi,axi-dmac binding. Prior to
> IP version 4.3.a, this information was required. Since then, there are
> memory-mapped registers that can be read to get the same information.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> For context, the adi,channels node has not been required in the Linux
> kernel since [1].
> 
> [1]: https://lore.kernel.org/all/20200825151950.57605-7-alexandru.ardelean@analog.com/
> ---
>  .../devicetree/bindings/dma/adi,axi-dmac.yaml         | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/adi,axi-dmac.example.dtb: dma-controller@7c420000: 'adi,channels' is a required property
	from schema $id: http://devicetree.org/schemas/dma/adi,axi-dmac.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241029-axi-dma-dt-yaml-v2-2-52a6ec7df251@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


