Return-Path: <dmaengine+bounces-2581-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5391B899
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 09:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDF51C21122
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAD313F43A;
	Fri, 28 Jun 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgmH5uCl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB5A5FBB1;
	Fri, 28 Jun 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719560359; cv=none; b=otn5AAmoX+PSglleEep7xWdCe4mIB1lDzAhNjXFgVAXHu1D88IBhfemBG1AvCWsn1RwRhXcQnTjSYcJ48v5zZIJlb3vS9fnwQCHTX8enr2KHTzJK+jYQLzBt7c00X9hpmck2zt/Jl+FROlMObYuTKzqpw/Q8Relty8hZyJX0t9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719560359; c=relaxed/simple;
	bh=1AZuypACBJ1EVl+EHSFcbj8lkbWG2c9CwFzXru13aDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/kEnHwGGLLnsBIbOaRiGqfSk7fqEddXznUabBerAjkZKxAMjxXxzDXCWKYi2lpQVhP8wTI6yYvAwsGJMwm+RJLDZ2mv2626NQ0vrdzhH7VWt/XcXkfCmpPfd04OGrl0V7pk9WQHv/KRT3Oo2TzClNEtUTAVA6OLcLiW9iovJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgmH5uCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789FEC116B1;
	Fri, 28 Jun 2024 07:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719560359;
	bh=1AZuypACBJ1EVl+EHSFcbj8lkbWG2c9CwFzXru13aDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RgmH5uClfa6lPYENsvQSkGudX3DSBGvDv2yWm1rN/s3Nv6gBV6RAd5xY3AfmD0A0s
	 XHW8XhNwd1ZxnZLkVS6ItiSuH96efKaxQHM91MF4eveJMKt2R9igca9Xf6pfgulCS6
	 f4tK1tFbgFQIl1V9zEoap/K/oYT/hr8vZwRlTXZBLJRoQ/u8AOmmcRncjhswmjYiP9
	 f54EwGygdxIYiXHSGhBvBTc+MPEIkIhnl4l6fsmKrIGBFu6TWqjc6MPnZTP/VgdZ5n
	 bYwb8J1t2p5BAsLe+D+0d9ZDNE5/azNOIm/zIf3FP6iuUu0MXI0gC1CS9f5hsDH9hY
	 gBcTAlSJIaYMg==
Date: Fri, 28 Jun 2024 13:09:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: JiaJie Ho <jiajie.ho@starfivetech.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] dmaengine: dw-axi-dmac: Support hardware quirks
Message-ID: <Zn5oo3rZCnxgc5Ns@matsya>
References: <20240530031112.4952-1-jiajie.ho@starfivetech.com>
 <20240530031112.4952-2-jiajie.ho@starfivetech.com>
 <ZmiOemWQrG-3EdIB@matsya>
 <NT0PR01MB11826C9F142FCD1A1199A11B8AC02@NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NT0PR01MB11826C9F142FCD1A1199A11B8AC02@NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn>


Hi JiaJie

On 12-06-24, 10:13, JiaJie Ho wrote:
> > On 30-05-24, 11:11, Jia Jie Ho wrote:
> > 
> > > +
> > > +struct dw_axi_peripheral_config {
> > > +#define DWAXIDMAC_STARFIVE_SM_ALGO	BIT(0)
> > 
> > what does this quirk mean?
> > 
> > > +	u32 quirks;
> > 
> > Can you explain why you need this to be exposed. I would prefer we use
> > existing interfaces and not define a new one...
> > 
> 
> Hi Vinod,
> Thanks for reviewing this.
> This is a dedicated dma controller for the crypto engine.
> I am adding this quirk to:
> 1. Select the src and dest AXI master for transfers between mem and dev. 
>     Driver currently only uses AXI0 for both.

why cant this information be passed thru DT, that is typically done by
most controllers?

> 2. Workaround a hardware limitation on the crypto engine to
>      transfer data > 256B by incrementing the peripheral FIFO offset.

Dont set the transfer data > 256B, you should ideally use maxburst for
configuring the FIFO...

> 
> What is the recommended way to handle such cases besides using 
> peripheral_config in dma_slave_config?

First use dma_slave_config() fields, if they are not appropriate, lets
discuss why before we add custom methods or use peripheral_config

-- 
~Vinod

