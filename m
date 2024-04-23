Return-Path: <dmaengine+bounces-1932-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8711E8AE8A7
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 15:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D1928965D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 13:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B613774E;
	Tue, 23 Apr 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJRvjvv+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1223136E38;
	Tue, 23 Apr 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880243; cv=none; b=adeTs/X7gdMN4GeTjj4Eo/qZc3Nbep0J0K3x29L3FP2BtBCjIgnsNCeL2o3EhpHkVJ0DR8yUqsjAlbxZYFClG2zfhj4FLh+cSMoD4V6dbIqFCf+duUPd7q1gPM4JmcgHqQt69tFnW6SMUhMI7ntp/TgFD3AWD9u7o0CcUcPIcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880243; c=relaxed/simple;
	bh=69xKIHYi9IlkPeRLSshR5Kkz2te6ObXlX0YWGXKs98A=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=h6TLAngWpctKYdE2NtzMP90csgkM24/T0Z5CfB5/vbv5rp+00gQv3/YLYk8EcF86P7pznTuRtQ9MjTo2XCecmXxyLD22AbVZ+E30HKO/89hpG3FkMgwjreitm8QDyKKqBzXABaX0ulsdXpZlIf568NE+XIq2ai8aMfTu2BBCVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJRvjvv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE67C32783;
	Tue, 23 Apr 2024 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880242;
	bh=69xKIHYi9IlkPeRLSshR5Kkz2te6ObXlX0YWGXKs98A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uJRvjvv+NskakdFYTyFSA8LvJusLkXDk85F1TIbbT6zb04rUFmlCmdZJbPRZJctwv
	 fyLDEgsPmHdVYnqa2irO5oOhhnc5gVEkb7KmGBIk56+RYNRZkav5cWgxyhlm87IzXv
	 eMLCy4fXhtNLZMVGt+GkXPnTWQhHykIclEoBLxur9mMYJrWv3ogAdZNM/s6/AOWn3D
	 rNbNtLZ7nabTNi6EpZ/FlU4ArW1RKkoFtp7sw93audwp4THtxqn3012OrZBEY7bVbJ
	 eBaXyZ7FeBe0vj/3yDjC6u53Q47gvgIAMXDYt3R/cNRL+LkE3JLlIoHPHTq+xh57y0
	 8W4EMtW3zYA3A==
Date: Tue, 23 Apr 2024 08:50:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Vinod Koul <vkoul@kernel.org>, linux-hardening@vger.kernel.org, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240423123302.1550592-2-amelie.delaunay@foss.st.com>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
 <20240423123302.1550592-2-amelie.delaunay@foss.st.com>
Message-Id: <171388024017.101826.4338039717721212935.robh@kernel.org>
Subject: Re: [PATCH 01/12] dt-bindings: dma: New directory for STM32 DMA
 controllers bindings


On Tue, 23 Apr 2024 14:32:51 +0200, Amelie Delaunay wrote:
> Gather the STM32 DMA controllers bindings under ./dma/stm32/
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  .../devicetree/bindings/dma/{ => stm32}/st,stm32-dma.yaml     | 4 ++--
>  .../devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml  | 4 ++--
>  .../devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml    | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>  rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dma.yaml (97%)
>  rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml (89%)
>  rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml (96%)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/spi/st,stm32-spi.yaml references a file that doesn't exist: Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
Documentation/devicetree/bindings/spi/st,stm32-spi.yaml: Documentation/devicetree/bindings/dma/st,stm32-dma.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240423123302.1550592-2-amelie.delaunay@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


