Return-Path: <dmaengine+bounces-5447-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F85DAD8F56
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 16:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54210188B7B3
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2520E2E11D8;
	Fri, 13 Jun 2025 14:15:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C633E47B;
	Fri, 13 Jun 2025 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749824120; cv=none; b=H83gBT962F0eXFUPlpGvGpdwwuimpVedWb3dvTRqd1+IsaBCTinGCR6sy2ZKyfgIgJHy6QPTOXGFzlOxGUhrd/zA+F0s7nUsCMjdOWFUdU2tzA1krwC96Ybn25ryCDZUgpI1N7xeLYpBNEU7QAkyfUYatzhc68EuHaj7d+kufBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749824120; c=relaxed/simple;
	bh=yn/qiltqTL4S0B2jWa7EQ/g1KAqAS/SJEN2xnA9rdkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfpRBN1O0pF5XdgYFWZTyXxTrTyo8Nuxf7aQ2cYZrs0P1JLEAPOfhmA6i3Vrv5A0YrdD9AXUpFrsE/X5hZaCOwdmld5mAhhHhVSw7VBClP+l2U+YQQfGKWg/mGiq/5nGcYPZlIDG7tAVlQBDhpYJFPcOO03TfnjHXLWQiLYhbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from localhost (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [27.18.107.32])
	by smtp.qiye.163.com (Hmail) with ESMTP id 18992ed15;
	Fri, 13 Jun 2025 22:15:06 +0800 (GMT+08:00)
Date: Fri, 13 Jun 2025 22:15:05 +0800
From: Ze Huang <huangze@whut.edu.cn>
To: Vivian Wang <uwu@dram.page>, Guodong Xu <guodong@riscstar.com>,
	vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlan@gentoo.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, drew@pdp7.com,
	emil.renner.berthing@canonical.com, inochiama@gmail.com,
	geert+renesas@glider.be, tglx@linutronix.de,
	hal.feng@starfivetech.com, joel@jms.id.au, duje.mihanovic@skole.hr,
	Ze Huang <huangze@whut.edu.cn>
Cc: elder@riscstar.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 5/8] riscv: dts: spacemit: Add dma bus and PDMA node for
 K1 SoC
Message-ID: <aEwyaQF6W7hXNC6N@jean.localdomain>
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
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQk9JVkMfHUMdHkhPQkMaTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJTFVKQ1VKS0xVSElZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSEJVSktLVUpCS0
	tZBg++
X-HM-Tid: 0a9769a4ed6f03a1kunm2a6912051f6b0a
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Njo6Ojo*VjE3E0oZLw4*LFYY
	CRZPCRJVSlVKTE9CQ0lPSktNQk5NVTMWGhIXVRMOGhUcAR47DBMOD1UeHw5VGBVFWVdZEgtZQVlJ
	TFVKQ1VKS0xVSElZV1kIAVlBSUNITjcG

On Fri, Jun 13, 2025 at 11:06:43AM +0800, Vivian Wang wrote:
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

Agree

> 
> @Ze Huang: This affects your "MBUS" changes as well. Please take a look,
> thanks.

Thanks for reminding. I would drop MBUS and follow the "dma_bus" approach.

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

