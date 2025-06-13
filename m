Return-Path: <dmaengine+bounces-5430-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9515FAD8182
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 05:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99192189A11F
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 03:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D781FCFC0;
	Fri, 13 Jun 2025 03:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dram.page header.i=@dram.page header.b="AQSmdXxd"
X-Original-To: dmaengine@vger.kernel.org
Received: from kuriko.dram.page (kuriko.dram.page [65.108.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CF1D5173;
	Fri, 13 Jun 2025 03:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784524; cv=none; b=X6cBQ9qC9Fah/op0cnCPF1uUPc83+ffqwsGBVyK8qanI78SeuwbRpapYMiNzrCC9PuEcVX3BXvcjUQ13KTWpWXGjm5WqXFEjnac89FiHvGjnakCmeGe6dv95YoWe9nfwvnPjqv3HaS0BN/ap+td8/URLKFe83CCewjXbrLUSmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784524; c=relaxed/simple;
	bh=o1SVX9nJPrwKUdAsGD/Hl7CBOsTjbHs500QARTgB8c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOAyDXoTZwfPfaw084w3MER4fH5ZvNEaPnSbCZNjonnT5CtftZ9OParkUevA9ywukpqaUxCvNSmqj4xgMhs/Mr/mpULsICmOkd74Y7H9hyJZ75yA2PHAqkDq/8zJgcsfVc4NsNlQFnk/PvSZyJ313OtGFA3DOiAtXR8E586LUb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dram.page; spf=pass smtp.mailfrom=dram.page; dkim=pass (1024-bit key) header.d=dram.page header.i=@dram.page header.b=AQSmdXxd; arc=none smtp.client-ip=65.108.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dram.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dram.page
Message-ID: <2b17769e-2620-4f22-9ea5-f15d4adcb27b@dram.page>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dram.page; s=mail;
	t=1749784027; bh=cA+IcBU1gia9Td2DjCXd/ukireOfXEXdOVKdoG1N2b8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AQSmdXxdX0T+5qO8FcZSVfEVbNkoeROXd5dG+BsEBuS+BEYtoDnVBsbFPRTxiCUXg
	 BVx7OXq9YmitSfaTIx5PtVZPSuQ1fOVirJfwl1eIwT4uypvHc5MqeHyOIiw9pnxrb0
	 CbSrJQuRXmzHWeJdhPwA00Zqmhu/QawSrHUWxh6w=
Date: Fri, 13 Jun 2025 11:06:43 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/8] riscv: dts: spacemit: Add dma bus and PDMA node for
 K1 SoC
To: Guodong Xu <guodong@riscstar.com>, vkoul@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, drew@pdp7.com,
 emil.renner.berthing@canonical.com, inochiama@gmail.com,
 geert+renesas@glider.be, tglx@linutronix.de, hal.feng@starfivetech.com,
 joel@jms.id.au, duje.mihanovic@skole.hr, Ze Huang <huangze@whut.edu.cn>
Cc: elder@riscstar.com, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
References: <20250611125723.181711-1-guodong@riscstar.com>
 <20250611125723.181711-6-guodong@riscstar.com>
Content-Language: en-US
From: Vivian Wang <uwu@dram.page>
In-Reply-To: <20250611125723.181711-6-guodong@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Guodong,

On 6/11/25 20:57, Guodong Xu wrote:
> <snip>
>
> -			status = "disabled";
> +		dma_bus: bus@4 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
> +				     <0x1 0x00000000 0x1 0x80000000 0x3 0x00000000>;
> +			ranges;
>  		};

Can the addition of dma_bus and movement of nodes under it be extracted
into a separate patch, and ideally, taken up by Yixun Lan without going
through dmaengine? Not specifically "dram_range4", but all of these
translations affects many devices on the SoC, including ethernet and
USB3. See:

https://lore.kernel.org/all/20250526-b4-k1-dwc3-v3-v4-2-63e4e525e5cb@whut.edu.cn/
https://lore.kernel.org/all/20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn/

(I haven't put eth{0,1} under dma_bus5 because in 6.16-rc1 there is
none, but ideally we should fix this.)

DMA address translation does not depend on PDMA. It would be best if we
get all the possible dma-ranges buses handled in one place, instead of
everyone moving nodes around.

@Ze Huang: This affects your "MBUS" changes as well. Please take a look,
thanks.

>  
>  		gpio: gpio@d4019000 {
> @@ -792,3 +693,124 @@ pwm19: pwm@d4022c00 {
>  		};
>  	};
>  };
> +
> +&dma_bus {
>
> <snip>


