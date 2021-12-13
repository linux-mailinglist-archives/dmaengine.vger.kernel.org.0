Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9B472108
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 07:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhLMGZm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 01:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhLMGZm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 01:25:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE686C06173F;
        Sun, 12 Dec 2021 22:25:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1ED7ACE0B20;
        Mon, 13 Dec 2021 06:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3D4C00446;
        Mon, 13 Dec 2021 06:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639376738;
        bh=L1hIT+XO170lUVQIX/7fWBAEJb38HWLLhtx4zVYZW+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2+1gFt+ivU59tiorEA3LrYnK//SIBrOMJRLR/E2h9/uzdUIxeaqOraEmOLNe877H
         Ml2x7VWCKiF20gn+Tmk2XrtQRIIvTXyG8fgCOyTkfjlFgeQLKwgb/+9h6wP5FoY1Ii
         B2TuNC0t47I5nICVPsyr/fiRqL4WYJdoYxu+aJSMIarcdq7Efe+uIUu7EjYr77KiA2
         OlhXjtResjpnIn5Elvyixe/olhE+6mvqxxRrd6XCInsbSXngnCZJoYDhn3FgY0EVGJ
         XkBWZMer5HzqxA5+JOyGydAE4ZVhRIUJdti5LWBuR8ygq05w+VG1gb2NVkl6s87Nb0
         tFGT1yFkYimkQ==
Date:   Mon, 13 Dec 2021 11:55:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heng Sia <jee.heng.sia@intel.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: Document optional
 reset
Message-ID: <YbbnXuvtSwBJoUT2@matsya>
References: <20211125152008.162571-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125152008.162571-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-11-21, 16:20, Geert Uytterhoeven wrote:
> "make dtbs_check":
> 
>     Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>     arch/riscv/boot/dts/canaan/sipeed_maix_bit.dt.yaml: dma-controller@50000000: 'resets' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	    From schema: Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> 
> The Synopsys DesignWare AXI DMA Controller on the Canaan K210 SoC
> exposes its reset signal.

Applied, thanks

-- 
~Vinod
