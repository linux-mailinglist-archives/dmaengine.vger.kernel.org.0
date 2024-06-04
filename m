Return-Path: <dmaengine+bounces-2256-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C128FBCCB
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2024 21:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999E71C22966
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2024 19:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3350313FD9D;
	Tue,  4 Jun 2024 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzWaskoW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B42913;
	Tue,  4 Jun 2024 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531064; cv=none; b=avdXXYzpGrChIZow6hleExlx25CWoIZHSKAiVhPb2SQLMvwbmL4w7FDMkbr0P5JQ1/e1E5D1pfwsC86ysZTzV/IstLy470WZqXGXBqkjohUZw2bmjEHqASpJ+SlNx/HJ6eIaP5GdFP4OdgbfvqJQeJWtd5KLNrPiya2o4DEx00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531064; c=relaxed/simple;
	bh=nNx83s5H2Nme80ffzGT+wyaJvbA1Zr8r46ZafFrJ6/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGJo95hRDCxdDr7RaITyODF2dK4JL/H7ljpM9kVns7ncFRLVLf7CXXhhBSTKdw2MdUtz+eyx/gCEU+jz+bkaIurXPTdHdygxS8PAnGnVTFeyP5gkgacbp1Fvj59ZxHEFHUeCEEASgoBPCbKkRL/wrN2jP9CA97OTZUBPWbXE8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzWaskoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB33C2BBFC;
	Tue,  4 Jun 2024 19:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531063;
	bh=nNx83s5H2Nme80ffzGT+wyaJvbA1Zr8r46ZafFrJ6/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzWaskoWivm79PpRbEtJE3OSdHdEQauvwDnD9ZiE2xuSPYmp0ob6jkR48Fi+xOuwO
	 DXVYygwnoT6AS5tt4MqNX2zzkkiTiuZu0DUvwnWNidAdhPurKPhINBX0syd2JkieBb
	 Ez5Uzw39r2u51BDvzKbb6SZuGgK+uhgGfwoZyY6ubaIFlXCclMa90hVwZeN6eS3OvU
	 3hNK02/1p6Kh6GCDJefJ3O8FVUGQxEB1Jun2P/p5vIN04uTgGqDVqvc2hqqSIHUZpf
	 WnutR8SVkepUvW5MsRIPTY0dYEjzVFhCKbktDhWYO/NJeQmD4F74M8mgZ/bHfUdBDo
	 vpWzjSRP1Mjuw==
Date: Tue, 4 Jun 2024 14:57:41 -0500
From: Rob Herring <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: dma: fsl,imx-dma: Convert to dtschema
Message-ID: <20240604195741.GA1281512-robh@kernel.org>
References: <20240531090458.99744-1-animeshagarwal28@gmail.com>
 <a472e8ba-bf54-4a62-9b05-ea265a83ef1b@kernel.org>
 <CAE3Oz825RQg25PxEbnb=ui7+MtH0ssS=i2HAQK-yOJo+v8JMMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE3Oz825RQg25PxEbnb=ui7+MtH0ssS=i2HAQK-yOJo+v8JMMw@mail.gmail.com>

On Fri, May 31, 2024 at 04:43:52PM +0530, Animesh Agarwal wrote:
> On Fri, May 31, 2024 at 3:49 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On 31/05/2024 11:04, Animesh Agarwal wrote:
> > > +  "#dma-cells":
> > > +    const: 1
> > > +
> > > +  dma-channels:
> > > +    maximum: 16
> >
> > maximum or const?
> 
> The txt binding says it should always be 16. Datasheet says this
> device has 16 channels of DMA services. I thought specifying just the
> maximum implies maximum=minimum=16. Sorry for missing the changelog in
> this version it was cost in the v1 of this patch.
> 
> >
> > deprecated: true
> >
> 
> Shall it not be
> "#dma-channels ":
>   deprecated: true
> ?

Yes. dma-channels is not deprecated.

For the old ones, maybe it has been long enough that their use has been 
dropped that you can just drop them in the conversion. Looks like there 
is no driver support already.

Rob

