Return-Path: <dmaengine+bounces-5445-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D1AD8D0B
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 15:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB8A3AB7B0
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500614BFA2;
	Fri, 13 Jun 2025 13:22:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D854654;
	Fri, 13 Jun 2025 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749820956; cv=none; b=ULplLgjtGn+v1OxCg0JEPnP08SJGESZg4SfZ65P7TDHZnjX6XE+gAflLtxA4ec1fEzzvLVc9rppGkoVxCfOsftJ09cGDxhrFsmDgCZb/6pUhzkGqEQCvxL26woCCSNhiXcIdVwq5pAVx55M1UL6wdV1IGS68uaNi3mM5B3ueoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749820956; c=relaxed/simple;
	bh=ZStFIAdXWvcgH+i6/QJnkTysUtDb1IVoiav26flpgDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSzS/TA0f3GjR+e0z5WUzhqGmUXUUeyqtBFpw88KbJ9umw/pHfmbP3F0ELeF8IWOGl0e75ToyJaBpSMqPROAobSOQDIUFX062uwY4yD2rT3DXidJhQGwoWmPHNO3l0iembZkFUfw5Tgu5p5gbC1m/Fph44wnxadCAv+TkWEm9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id A915E3422ED;
	Fri, 13 Jun 2025 13:22:33 +0000 (UTC)
Date: Fri, 13 Jun 2025 13:22:27 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Vivian Wang <uwu@dram.page>
Cc: Guodong Xu <guodong@riscstar.com>, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, drew@pdp7.com,
	emil.renner.berthing@canonical.com, inochiama@gmail.com,
	geert+renesas@glider.be, tglx@linutronix.de,
	hal.feng@starfivetech.com, joel@jms.id.au, duje.mihanovic@skole.hr,
	Ze Huang <huangze@whut.edu.cn>, elder@riscstar.com,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH 5/8] riscv: dts: spacemit: Add dma bus and PDMA node for
 K1 SoC
Message-ID: <20250613132227-GYB135173@gentoo>
References: <20250611125723.181711-1-guodong@riscstar.com>
 <20250611125723.181711-6-guodong@riscstar.com>
 <2b17769e-2620-4f22-9ea5-f15d4adcb27b@dram.page>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b17769e-2620-4f22-9ea5-f15d4adcb27b@dram.page>

Hi Vivian, Guodong,

On 11:06 Fri 13 Jun     , Vivian Wang wrote:
> Hi Guodong,
> 
> On 6/11/25 20:57, Guodong Xu wrote:
> > <snip>
> >
> > -			status = "disabled";
> > +		dma_bus: bus@4 {
> > +			compatible = "simple-bus";
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
> > +				     <0x1 0x00000000 0x1 0x80000000 0x3 0x00000000>;
> > +			ranges;
> >  		};
> 
> Can the addition of dma_bus and movement of nodes under it be extracted
> into a separate patch, and ideally, taken up by Yixun Lan without going
> through dmaengine? Not specifically "dram_range4", but all of these
> translations affects many devices on the SoC, including ethernet and
> USB3. See:
Right, we've had an offline discussion, and agreed on this - have *bus
patches separated and let other patches depend on it.

But seems Guodong failed to do this or just sent out an old version
of the PDMA patch?

> 
> https://lore.kernel.org/all/20250526-b4-k1-dwc3-v3-v4-2-63e4e525e5cb@whut.edu.cn/
> https://lore.kernel.org/all/20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn/
> 
> (I haven't put eth{0,1} under dma_bus5 because in 6.16-rc1 there is
> none, but ideally we should fix this.)
> 
> DMA address translation does not depend on PDMA. It would be best if we
> get all the possible dma-ranges buses handled in one place, instead of
> everyone moving nodes around.
> 
I agree

> @Ze Huang: This affects your "MBUS" changes as well. Please take a look,
> thanks.
> 
> >  
> >  		gpio: gpio@d4019000 {
> > @@ -792,3 +693,124 @@ pwm19: pwm@d4022c00 {
> >  		};
> >  	};
> >  };
> > +
> > +&dma_bus {
> >
> > <snip>
> 

-- 
Yixun Lan (dlan)

