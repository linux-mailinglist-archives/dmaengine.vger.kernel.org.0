Return-Path: <dmaengine+bounces-1151-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23F86B592
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 18:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC94280E3C
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA65208DF;
	Wed, 28 Feb 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvJnUvPM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EF208D2;
	Wed, 28 Feb 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140081; cv=none; b=Z2QI9/UanG4EUuhBoBISdrI42b4K6Yg1dq5rVpns/rQqzoEUMh0MUmOjPddz8Q1GLCjWn9lVNU3Rrryb/vhb5NoPAxwWEKcnKheGhpdh4jYnDzExzUnKtWdYatCeLvDwRq4lo8v97TEg/bnoeSbEUCCtT4M/hpc9dhSUt2QP6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140081; c=relaxed/simple;
	bh=pOuRea6BcrpelSLBSjZEKw2v4BzFJQ/wIcZuMm258OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBig7xRXMukmutW7/d7DyQAV9pZ+u4gwGotx0DwMbjJ+FuuelFDH4hFPqb1BJgj1lOvF5QxkG4eYWLhAHn2ckhd1YQXmYOKV3s4BPbLAbBLb+r1mh+zm1+tQOx8X5+pBf3IxzweEv4TIjjclK1tt8OKmTamLBm4d9cUYE339Z64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvJnUvPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3FAC433F1;
	Wed, 28 Feb 2024 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709140081;
	bh=pOuRea6BcrpelSLBSjZEKw2v4BzFJQ/wIcZuMm258OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvJnUvPMBab76WOE4uz6Op5Jr28ARmCElH2uanEQiw8HquYASy/RXP4FYBZImq3AL
	 mMrhvnc9KME4g5YkWwALd0PvrWEoy4vMxznr5cY7Qa7IRWEn+7PVbRQapsn6JIITgA
	 tq/spAh5kfCnULx56BMPqY9dA/UsgjT0HofMRWo3yuyUrmUOp/9MY/s4s56ypO9huf
	 LHBqLFZW0a61icxbWCJk5vOyRe6PjOWT3mAuZ6btvxyIs7OpIeduP5KPDsFv3koBz7
	 SLQswe15efKH4qDOrXOtCBFm4BBvZyOwmdRLekgwdi51YtAU7WeT1+Kss9/fSWxhGu
	 LH2sZIbaleLJA==
Date: Wed, 28 Feb 2024 11:07:58 -0600
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: sophgo: Add top misc controller
 of CV18XX/SG200X series SoC
Message-ID: <20240228170758.GA282254-robh@kernel.org>
References: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB4962BEA2751F7C45A16E40B9BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
 <20240223003334.GA3981337-robh@kernel.org>
 <IA1PR20MB4953C60F0B70D82922D3AD36BB552@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953C60F0B70D82922D3AD36BB552@IA1PR20MB4953.namprd20.prod.outlook.com>

On Fri, Feb 23, 2024 at 09:47:05AM +0800, Inochi Amaoto wrote:
> On Thu, Feb 22, 2024 at 05:33:34PM -0700, Rob Herring wrote:
> > On Tue, Feb 20, 2024 at 06:28:59PM +0800, Inochi Amaoto wrote:
> > > CV18XX/SG200X series SoCs have a special top misc system controller,
> > > which provides register access for several devices. In addition to
> > > register access, this system controller also contains some subdevices
> > > (such as dmamux).
> > > 
> > > Add bindings for top misc controller of CV18XX/SG200X series SoC.
> > > 
> > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > ---
> > >  .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 48 +++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> > > new file mode 100644
> > > index 000000000000..29825fee66d5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> > > @@ -0,0 +1,48 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800-top-syscon.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Sophgo CV1800/SG2000 SoC top system controller
> > > +
> > > +maintainers:
> > > +  - Inochi Amaoto <inochiama@outlook.com>
> > > +
> > > +description:
> > > +  The Sophgo CV1800/SG2000 SoC top misc system controller provides
> > > +  register access to configure related modules.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: sophgo,cv1800-top-syscon
> > > +      - const: syscon
> > > +      - const: simple-mfd
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties:
> > > +  type: object
> > > +
> > > +examples:
> > > +  - |
> > > +    syscon@3000000 {
> > > +      compatible = "sophgo,cv1800-top-syscon",
> > > +                   "syscon", "simple-mfd";
> > > +      reg = <0x03000000 0x1000>;
> > > +
> > > +      dma-router {
> > 
> > Is there no defined register set you can put in 'reg' here?
> > 
> 
> It has multiple registers in the syscon. But in fact, the dmamux
> is a virtual device. And the syscon device only have some discrete 
> registers. This is why I did not put reg. It should access the
> device using the offset defined in the patch 3.

I would add:

reg = <0x154 8>, <0x298 0x4>;

(with appropriate "ranges" in parent)

No requirement for Linux to use this either.

Rob

