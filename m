Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494E2617E18
	for <lists+dmaengine@lfdr.de>; Thu,  3 Nov 2022 14:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiKCNkJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Nov 2022 09:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKCNkI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Nov 2022 09:40:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6C3140A2
        for <dmaengine@vger.kernel.org>; Thu,  3 Nov 2022 06:40:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1oqaRr-0007c7-IJ; Thu, 03 Nov 2022 14:39:59 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1oqaRp-0005ti-Tm; Thu, 03 Nov 2022 14:39:57 +0100
Date:   Thu, 3 Nov 2022 14:39:57 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        harini.katakam@amd.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: dmaengine: zynqmp_dma: add xlnx,bus-width
 required property
Message-ID: <20221103133957.GA28423@pengutronix.de>
References: <1667448757-7001-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1667448757-7001-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 03 Nov 2022 09:42:37 +0530, Radhey Shyam Pandey wrote:
> xlnx,bus-width is a required property. In yaml conversion somehow
> it got missed out. Bring it back and mention it in required list.
> Also add Harini and myself to the maintainer list.
> 
> Fixes: 5a04982df8da ("dt-bindings: dmaengine: zynqmp_dma: convert to yaml")
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

> ---
>  .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml    | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> index c0a1408b12ec..a10019d3a650 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> @@ -13,6 +13,8 @@ description: |
>  
>  maintainers:
>    - Michael Tretter <m.tretter@pengutronix.de>
> +  - Harini Katakam <harini.katakam@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>  
>  allOf:
>    - $ref: "../dma-controller.yaml#"
> @@ -65,6 +67,7 @@ required:
>    - interrupts
>    - clocks
>    - clock-names
> +  - xlnx,bus-width
>  
>  additionalProperties: false
>  
> 
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> -- 
> 2.25.1
> 
> 
