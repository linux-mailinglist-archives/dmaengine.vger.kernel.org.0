Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA68252DC1E
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbiESR5n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiESR5n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:57:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E44CEBB6;
        Thu, 19 May 2022 10:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A58FB8276B;
        Thu, 19 May 2022 17:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487A0C385AA;
        Thu, 19 May 2022 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652983060;
        bh=1WhWo2wQ3FT8dbfxI7lWLnvz36XoW1FAMZWWg7Av3iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmeGerv93gdZ1NZvXG1KagNIYABw/VlX37bb9cUnqCjXtHwGWg1pCUDV/haZyy0iI
         SuOs2F2X/+98QszPfJnChJXAUxJhA9R6dlDFHlF677D++dRSeJo+bNDKd9yg49p3z/
         tyLGZ/RXWnOtrjHrPTIsDlh1kRFq59DyE0MaX3cUnV0fC10/4DpbogNQVaT5vsRWUS
         8wyBce0l6CfR7vrSvGjFirLFFTbVa6+OE5IUsuFe389W9bBz2NmlbIUXoE6xhSXNe4
         IPIluxIJX5U4mfDA9RNcds3WSf7BUq0fUotAIdhBGvYJgTiKDQ15NBaJsDQiY+rW/f
         1TW7fC/DKKkzw==
Date:   Thu, 19 May 2022 23:27:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v1 01/15] Revert "ARM: dts: imx6q: Use correct SDMA
 script for SPI5 core"
Message-ID: <YoaFEM/jaHecERsG@matsya>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
 <1556027045-5269-2-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556027045-5269-2-git-send-email-yibin.gong@nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-04-19, 13:50, Robin Gong wrote:
> This reverts commit df07101e1c4a29e820df02f9989a066988b160e6.

Please add the commit title in canonical format. Also explain why this
should be reverted

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  arch/arm/boot/dts/imx6q.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index d038f41..7175898 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -172,7 +172,7 @@
>  					clocks = <&clks IMX6Q_CLK_ECSPI5>,
>  						 <&clks IMX6Q_CLK_ECSPI5>;
>  					clock-names = "ipg", "per";
> -					dmas = <&sdma 11 8 1>, <&sdma 12 8 2>;
> +					dmas = <&sdma 11 7 1>, <&sdma 12 7 2>;
>  					dma-names = "rx", "tx";
>  					status = "disabled";
>  				};
> -- 
> 2.7.4
> 

-- 
~Vinod
