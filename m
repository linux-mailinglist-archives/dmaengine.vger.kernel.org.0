Return-Path: <dmaengine+bounces-8317-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C68C8D38B63
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 03:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88E9530274FC
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 02:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCA8284B2E;
	Sat, 17 Jan 2026 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQAhTCFF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55C244661
	for <dmaengine@vger.kernel.org>; Sat, 17 Jan 2026 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615369; cv=none; b=izIurKR9+4iF73VrSg1WmsqMESzaSOpSuGbuygto91xYpL/dfi6zvPSWE2BzHsoI0uxp637Aj9FFR/J1e3GQKxLvLhbQwGnX/dqTWK0nqrz9tvcwEfUm7qGlPEXSxjR6zOFF3N+iDeIZL7O9/fvECAkg2mVdNy2GdL0oTWOWlvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615369; c=relaxed/simple;
	bh=WnbZ+diR5kVGMAEUJH5qwKXMKHbtB3/wTuJv9BYk9MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz4tIrlaUSFEj9UtWagGEZA8Tze3TmxzvSj7tDf/zzYt5u32s/pTGAt2G9SZToe9hXF3dXglH/45TTmD28OF3cq/ZDFSSZGetb99a9sB7CisExIFKmQ4wbSD6vYP+8TOusWbdaSAC2KhIwwi2qWQxYP1XxZKt59hTzmzdhiazS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQAhTCFF; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8908f5ed4aeso26219526d6.3
        for <dmaengine@vger.kernel.org>; Fri, 16 Jan 2026 18:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768615367; x=1769220167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dta8pivS2rued3Q3ChMqGgKi/kS9yYaS8vWr9CkDH7o=;
        b=dQAhTCFFgpgTMA5m2BVDEfTD9IcpoyXUDjeAX+LHWjE30kxb1bRJCVhgYk1xuVO5gz
         eRNnyiuJBwfhk8pHhVJRj90kp7hv1CAF6t4hzBVqwQvuHGQTEF4OtAXf1lM5pj2plJa+
         IKm2oXjMXk/SVc53g9Jpe6QINmQ4hfqU3JLSJvaaVHnJrRT9AT4Y8LEj3iN1WW0JFlQj
         QlmhLBj0SfIgcgefTtAfI/kTGmrNyz5P29r5L87aYrIMeGNB8IYjFPVt8A8FqohnWIwd
         lbVK3nVnE8uSk/grXovZC/p3WkBq11cKsF8NV2cHtdaMFO8h429fgNc8mYd9lEERLoI0
         RG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768615367; x=1769220167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dta8pivS2rued3Q3ChMqGgKi/kS9yYaS8vWr9CkDH7o=;
        b=mnkxzV7mkFUtxh3D70vagQAJCfCOmWVDBD34qSuTUmDM4/NR+i7Y7Vtk8w5vpjaz5s
         qWbMsm9zLR87OVIzod0izOR41gu8VndJDAPzg4+4uOfkQ3S9sDffyJNwadRFScuYrt4C
         y7Pgs9KzCeALt00QAQFAfiYwi8oNlgSnN/EB4wKKhFmm1MXCCNNBu0dI2qTvK7J817oj
         r5W6hAysa1K9VuV4ANq6KQ2po+iwUfLi/WRNLwPrYFJBJhfrAI1sDRf/YMdSe3GS7LZp
         V/rvuRGPEGdknfPRcSB83Kgxm4ZZZ7Yh/c48srExpN3wx/JU7cMCBZTwPApmMfX/CFs8
         nX5A==
X-Forwarded-Encrypted: i=1; AJvYcCU29jGMGwMOlkszaTL2JVuEW1OEG8ocnvuHf2pOFjpvRJogm6pWTZF2TD0RvH6TjpPT/lyXcw2dCiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12gfoODPzs9keBuq16521NK++TvVKomyCyUaosp4sjavY+ITH
	dscXQDAnO6BrCq3DBHTFRLPL+PQWrAYxTkAaDHTRxiiwAeUw9J94LldZoq/i7aNJDp0=
X-Gm-Gg: AY/fxX7+oSdKYoQpkddQltAKcfn2PLBRkeuu4emshU6zb6xJ6xXS9o3mfwT4ahV5Nv1
	qndV3HT0KrOOqP8YbXvUf3gnj3sWoTIUyNubPj3bAQznKASY1etMyap6qs7ss56iGCNxPexDCpB
	e6JpHsRXsY1XX6f1VLtBGMsxMgWX99K+tt2VuKeQzFETSlDCO17ZYxzN+Y/cC3GnXJaCdkn1lWD
	3StQJVrVtG6YeEFmswMocL83mYceYReaaP4B1YB1O3J2kTy5NfvtFJ/nArsrkfCYn0N34IWNVlc
	QCVuD588hAubPBUBtaoQUXi4oZP8o0YMwlm/3VMyz8v3V05wUxhdKLFBwnQrbsA6XdwznizB3ic
	soIt++BuHcFGDfNUqAG8psJbYu5fKwiSsj9zvf0cYwiT1jYrWPk44HFF/Gy14U+mlPeB5sJL7Uy
	1LpHUvKEwbpA==
X-Received: by 2002:a05:7022:4588:b0:123:3bba:fc4c with SMTP id a92af1059eb24-1244b381373mr3575104c88.38.1768609928525;
        Fri, 16 Jan 2026 16:32:08 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad740c5sm5332461c88.8.2026.01.16.16.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 16:32:08 -0800 (PST)
Date: Sat, 17 Jan 2026 08:32:02 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Frank Li <Frank.li@nxp.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Chen Wang <unicorn_wang@outlook.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>, 
	"Anton D . Stavinskii" <stavinsky@gmail.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, 
	Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2 3/3] riscv: dts: sophgo: cv180x: Allow the DMA
 multiplexer to set channel number for DMA controller
Message-ID: <aWrYSw94WjqPrUkK@inochi.infowork>
References: <20251214224601.598358-1-inochiama@gmail.com>
 <20251214224601.598358-4-inochiama@gmail.com>
 <aWpcfqHDFaq8Lsv5@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWpcfqHDFaq8Lsv5@lizhi-Precision-Tower-5810>

On Fri, Jan 16, 2026 at 10:42:54AM -0500, Frank Li wrote:
> On Mon, Dec 15, 2025 at 06:46:00AM +0800, Inochi Amaoto wrote:
> > Change the DMA controller compatible to the sophgo,cv1800b-axi-dma,
> > which supports setting DMA channel number in DMA phandle args.
> 
> 
> Does it need update DMA comsumer?
> 
> Frank


Not needed, this is handle by the dmamux driver, it is allocate and
configure the DMA channel dynamicly.

Regards,
Inochi

> >
> > Fixes: 514951a81a5e ("riscv: dts: sophgo: cv18xx: add DMA controller")
> > Reported-by: Anton D. Stavinskii <stavinsky@gmail.com>
> > Closes: https://github.com/sophgo/linux/issues/9
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv180x.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> > index 1b2b1969a648..e1b515b46466 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> > @@ -417,7 +417,7 @@ sdhci1: mmc@4320000 {
> >  		};
> >
> >  		dmac: dma-controller@4330000 {
> > -			compatible = "snps,axi-dma-1.01a";
> > +			compatible = "sophgo,cv1800b-axi-dma";
> >  			reg = <0x04330000 0x1000>;
> >  			interrupts = <SOC_PERIPHERAL_IRQ(13) IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks = <&clk CLK_SDMA_AXI>, <&clk CLK_SDMA_AXI>;
> > --
> > 2.52.0
> >

