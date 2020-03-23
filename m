Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A7318F705
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2020 15:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCWOgL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Mar 2020 10:36:11 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:54959 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWOgL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Mar 2020 10:36:11 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 32EFE2304C;
        Mon, 23 Mar 2020 15:36:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1584974169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3Afpl4Mo1o7I+chKBRp6t8NkD5Siw70y/D3EPvLGIM=;
        b=vmgF7nxi+pO6yK1h3/26DXcOEi4iESyqI+a3nBGAvWRMRSNVQh3lLVinlp2R6POQ4UGrIx
        K7kvRdOLxhwnSAJWl3LyXXv6P93URCZhct5XuGyUqM6DbnJ5oJPHOL8Qg+NKTAt5/JRTtn
        MOkOxyyGzoSZtzKNApo82QycuJqvLyE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Mar 2020 15:36:06 +0100
From:   Michael Walle <michael@walle.cc>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Peng Ma <peng.ma@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: ls1028a: add "fsl,vf610-edma" compatible
In-Reply-To: <20200306205403.29881-2-michael@walle.cc>
References: <20200306205403.29881-1-michael@walle.cc>
 <20200306205403.29881-2-michael@walle.cc>
Message-ID: <bd67afcd5720265109520d2ed5403b9f@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 32EFE2304C
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         NEURAL_HAM(-0.00)[-0.528];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi all,

Am 2020-03-06 21:54, schrieb Michael Walle:
> The bootloader does the IOMMU fixup and dynamically adds the "iommus"
> property to devices according to its compatible string. In case of the
> eDMA controller this property is missing. Add it. After that the IOMMU
> will work with the eDMA core.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Is it possible to have this merged, so it gets into the merge window
for 5.7? As I explained in this thread [1], without this compatible
all boards with enabled IOMMU (and who have either sound, lpuart or
i2c enabled), doesn't work.

-michael

[1] 
https://lore.kernel.org/linux-devicetree/433418e889347784bc74f3c22c23e644@walle.cc/

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index b152fa90cf5c..aa467bff2209 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -447,7 +447,7 @@
> 
>  		edma0: dma-controller@22c0000 {
>  			#dma-cells = <2>;
> -			compatible = "fsl,ls1028a-edma";
> +			compatible = "fsl,ls1028a-edma", "fsl,vf610-edma";
>  			reg = <0x0 0x22c0000 0x0 0x10000>,
>  			      <0x0 0x22d0000 0x0 0x10000>,
>  			      <0x0 0x22e0000 0x0 0x10000>;
