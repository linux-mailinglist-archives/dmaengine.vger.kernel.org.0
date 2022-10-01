Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551255F1F44
	for <lists+dmaengine@lfdr.de>; Sat,  1 Oct 2022 22:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiJAUTH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Oct 2022 16:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJAUTF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Oct 2022 16:19:05 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Oct 2022 13:19:04 PDT
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE483687F
        for <dmaengine@vger.kernel.org>; Sat,  1 Oct 2022 13:19:04 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D7B1F202E6;
        Sat,  1 Oct 2022 22:13:46 +0200 (CEST)
Message-ID: <40db9312-6450-8b45-1501-ceb2f3869270@somainline.org>
Date:   Sat, 1 Oct 2022 22:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/3] drivers: dma: gpi: Add SM6125 compatible
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001185526.494095-1-martin.botka@somainline.org>
 <20221001185526.494095-2-martin.botka@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221001185526.494095-2-martin.botka@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 1.10.2022 20:55, Martin Botka wrote:
> This commit adds compatible for SM6125
> SoC.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
It's been decided to not add any more compatibles without a need.
Please follow what has been done here:

https://lore.kernel.org/all/YzVL9ngfwqfwhF8Q@matsya/t/

Konrad
>  drivers/dma/qcom/gpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 8f0c9c4e2efd..0c42b40a7586 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -2288,6 +2288,7 @@ static int gpi_probe(struct platform_device *pdev)
>  static const struct of_device_id gpi_of_match[] = {
>  	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
>  	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
> +	{ .compatible = "qcom,sm6125-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
