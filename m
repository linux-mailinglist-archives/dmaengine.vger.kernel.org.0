Return-Path: <dmaengine+bounces-2760-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A4393F8ED
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 17:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CD11C21D01
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65875155337;
	Mon, 29 Jul 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6iGGnrt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833C74E09;
	Mon, 29 Jul 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265323; cv=none; b=ZT9icloBEqAERv9WYOZfocg50tnahAjfqX67RRYnYMfWZxiK7gul9gvkBnxHtBOdP3lFWb3zjQlvgXKs2wyevq9LeFKcTjfzYAgJaoo6VAVENA86MYcaLbvQKZ7+U0xUnA5G3nUKPm6c4N+rSu/JvFWgomRvxNan0BiPbo/Xx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265323; c=relaxed/simple;
	bh=Z3oEEBdSHgN0bkthRPf/JvesgDNuaiaeKjStAc4mw50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1fIp5jZSK5l+Rhr5xmmcgdaV3dLtG3JXiZcmEDJSccrhnznjwg1n4ytOi/ld0GZ6pMZcNak9NOXlzTVFMZn8SRpb19ryBxPGFhLgmYTKmDLRdmX6/bYZ+pUDjQh6k+XvCakA4cpkiGzYQqiwSthAne+GYDE8vPvmX0G43GWzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6iGGnrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8DCC4AF0A;
	Mon, 29 Jul 2024 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722265323;
	bh=Z3oEEBdSHgN0bkthRPf/JvesgDNuaiaeKjStAc4mw50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6iGGnrtRtgbzF+GVoKbEna+hIBbGBcUCsSMuF5McoWT/DJ4yBe2042p+ul1uG3RU
	 2f/r7rAnOKSv4zOlkVZnI9FYajrktdEVoxTm5yr4sVZDJqeYVSu13jfrsFipQmCoJi
	 B5t3OAqmCNnacxvx4bVTt4+WAxFMNmswFHbvFfBrGsuCMlf/ZI/phWU86Z3gPce3Ua
	 GIC9K8NmupfdOLfEUI5DbZMNT8nDEWtMLTotRUJiwVDw8J3Qux0QySHGHGMG7AoVvI
	 FhsiHc300H7YJEHW1hMpXL3Z467J3QKSAKRk3U4JxDU3ZLT7h/MD+PYuk9WxzTIHhd
	 BejSYQcZDgP4A==
Date: Mon, 29 Jul 2024 10:02:01 -0500
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	dmaengine@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>, linux-riscv@lists.infradead.org,
	Chen Wang <unicorn_wang@outlook.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v8 RESEND 1/3] dt-bindings: dmaengine: Add dma
 multiplexer for CV18XX/SG200X series SoC
Message-ID: <20240729150201.GA334758-robh@kernel.org>
References: <IA1PR20MB49535EC188F8EE3F8FD0B68DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953865775FA926B2BA4580CBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <172223050278.2763977.11180028101195359000.robh@kernel.org>
 <IA1PR20MB4953E3AEACAC85765AE9442BBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <2e4b504c-6413-42fc-a544-472d4cc1a06b@linaro.org>
 <IA1PR20MB4953343445D88F046E1D28EFBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953343445D88F046E1D28EFBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>

On Mon, Jul 29, 2024 at 08:28:09PM +0800, Inochi Amaoto wrote:
> On Mon, Jul 29, 2024 at 11:30:20AM GMT, Krzysztof Kozlowski wrote:
> > On 29/07/2024 09:00, Inochi Amaoto wrote:
> > >> yamllint warnings/errors:
> > >>
> > >> dtschema/dtc warnings/errors:
> > >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> > >> 	from schema $id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
> > >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> > >> 	from schema $id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
> > >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> > >> 	from schema $id: http://devicetree.org/schemas/dma/dma-router.yaml#
> > >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> > >> 	from schema $id: http://devicetree.org/schemas/dma/dma-router.yaml#
> > >>
> > > 
> > > Hi Rob,
> > > 
> > > Could you share some suggestions? I can not reproduce this error with
> > > latest dtschema. I think this is more like a misreporting.
> > 
> > You would need dtschema from the master branch, so newer than 2024.05.
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> Is it a must for the type array to have more than 1 element?
> I have tested the value "<&dmac 0>" and "<&dmac>, <&dmac>".
> Both pass the check (These value are just for test, not the
> real hardware).
> 
> Setting dma-masters to type "phandle" also has no change. 
> It do not accept the value "<&dmac>", Is there any suggestion
> for this? Thanks in advance.

The issue is 'dma-masters' is also defined as a uint32 in the Spear 
binding. Types aren't local to a binding, so when there's a 4 byte 
value, is that a phandle or plain uint32? I'm working on a fix in 
dtschema for this. It should be committed shortly.


Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Rob

