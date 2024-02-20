Return-Path: <dmaengine+bounces-1058-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6CC85BA1E
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 12:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D38D1C212A6
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F02664A6;
	Tue, 20 Feb 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaN2fh/i"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAC604A9;
	Tue, 20 Feb 2024 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427764; cv=none; b=ipKS+0ow/DL6CytI47ORwDilUmAjhHUesaYQVfA0+m7ptLwCq+UEq8ztwmhUM1zko9+LlO24Re0/VW05wHjM+8AtofBpjdN3nV3o5PwLN6IHMjXMZlYgMvc8JTO4eytkSif+erH68u3v4w7RQ19wWupkweyPZi7XdXG8PUr21a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427764; c=relaxed/simple;
	bh=b3Q8EgeZzo8W7wf2Dwybt5IsYpM0CIbjVQaLGahQYeE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=CwV4ysz2Zg4E8x0QGl/Oz+FUa9r34fAHQq52bXSfC9XjhAvW/QmO/INhFtNh9RnrQ2PKFE1ZTynXIIlRQVQ9nvcJlEJ1DvUJ0pFkrpxmHE5SM7dfIgx01KyOfLafffyj1c9/J+OtteyIxoW2yUPajmy9vNkPUJ3sHYBQajjx3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaN2fh/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F740C433C7;
	Tue, 20 Feb 2024 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708427763;
	bh=b3Q8EgeZzo8W7wf2Dwybt5IsYpM0CIbjVQaLGahQYeE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CaN2fh/ih+BYJIL5Ws+1+IwLVaYYExR7VKCj+S0U7o8mQSiMFCjIaJBr9RQiJHNba
	 ENC16mJKyGByugLr4Rw72c9dZ/Cp0zjOk1slGQHrVViUhiF/nVuTj4wEwXdMT7y2vY
	 Cgs3UzXf2q02/ld2Q78ujip4Shr8I4ExoAam969vmSe93IVhQNza4kebbDAkiwgl1x
	 xAO60ToVjNJ9WG2BqsaNP6DdLc+FubLMNIGlCeIhXS5WsbVm9dVM3vFgYBQCgi5gfP
	 COEmcJBS4d7YMaRIZgGHJuScS0DHqh33Oden2MMCyka2EHFVhkrFjbCATPIQCq1d++
	 5kMhwYjofqNrg==
Date: Tue, 20 Feb 2024 05:16:02 -0600
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org, 
 dlan@gentoo.org, Jisheng Zhang <jszhang@kernel.org>, 
 Liu Gui <kenneth.liu@sophgo.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: 
 <PH7PR20MB4962823548BE1CB8E225ED09BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB4962823548BE1CB8E225ED09BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Message-Id: <170842776103.2697493.3548601402716430308.robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: clock: sophgo: Add top misc
 controller of CV18XX/SG200X series SoC


On Tue, 20 Feb 2024 18:20:29 +0800, Inochi Amaoto wrote:
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

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dtb: /example-0/syscon@3000000/dma-router: failed to match any schema with compatible: ['sophgo,cv1800-dmamux']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/PH7PR20MB4962823548BE1CB8E225ED09BB502@PH7PR20MB4962.namprd20.prod.outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


