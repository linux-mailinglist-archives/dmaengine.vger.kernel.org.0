Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8105A564E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 23:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiH2VmS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 17:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiH2VmS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 17:42:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5EA7C509;
        Mon, 29 Aug 2022 14:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 265C061281;
        Mon, 29 Aug 2022 21:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA52FC433D6;
        Mon, 29 Aug 2022 21:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661809335;
        bh=W1VMfu9fY3nmLEU1HBpc31zvjXsJcdLyG9QMjo2oNc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6uJDf62f1/e5/gSXoUNeUckRIWQFS2OL04NMLeesSA13cVpzz0KJYkuDNxEr3ALi
         bIwfwqfHgJLFCsJrb8jQ1zHR+2DdNdOpU7HbKkKvxb86bsx9IcVSMnykMMjLRRUywj
         AmJd8UEkQEMAqyczbTcCM78nNGjYwDwM6c8/5tDStkAa5a2u2QneSImQaJxeI7h0/b
         8IP7xh+AWNKQMxPSwrkX6vUHHWcmiBjP8jRAbAWnmIkQS2Dkqw2mxSrNcm1P3udF2i
         qX9XeFkEl3OKtRn1hbCs5i/elvp0lGCJPUsEVShIzdb3/W+YJM9CUNdHHKFIFIvpSs
         b2I/0TNhWhCDQ==
Date:   Mon, 29 Aug 2022 16:42:12 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dmaengine: qcom: gpi: Add SM6350 support
Message-ID: <20220829214212.2kufzgrfjg5ad6ni@builder.lan>
References: <20220812082721.1125759-1-luca.weiss@fairphone.com>
 <20220812082721.1125759-3-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812082721.1125759-3-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Aug 12, 2022 at 10:27:20AM +0200, Luca Weiss wrote:
> The Qualcomm SM6350 platform does, like the SM8450, provide a set of GPI
> controllers with an ee-offset of 0x10000. Add this to the driver.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  drivers/dma/qcom/gpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 8f0c9c4e2efd..89839864b4ec 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -2288,6 +2288,7 @@ static int gpi_probe(struct platform_device *pdev)
>  static const struct of_device_id gpi_of_match[] = {
>  	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
>  	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
> +	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
>  	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
> -- 
> 2.37.1
> 
