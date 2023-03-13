Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0CA6B7FD6
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCMR7Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMR7Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:59:16 -0400
X-Greylist: delayed 1365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 10:59:14 PDT
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746A84FF27;
        Mon, 13 Mar 2023 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Lt4mtIjD4YyqKIuyjla1T3Ra1U7Xq48NvAy7VCekmRA=; b=g0r/lWXHFdizF5Hl/TIfhR8fWF
        NMwSnoXGienHTsvDiDVVuUhUdbZageGCHqFcSPB62BhE+aE1EvX/pM6fSD7mVorRljtom07PFW9uf
        4wsKDq0kUP1aIx7PLLAaovyhBZunUsJwoiOUWB4q93uZkwxhXPK/P26a8hR9PZl3O5cRboFtObBOB
        sHwG5eWy6VGSqHyoYAebRR3131LkIKuj9dXMEuat/buc2XmCp40Kn/rxfaysd6SB9FG5EqD856mJe
        X1/FF8EULD1S8990dV0hl5uqGdSkv5f7+U7fEaD0Dp1RgXIoB6xsxBpkIuN9iDtDCfFzhl9ck9ebN
        4QxuIUAw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pbm5w-000O5g-P4; Mon, 13 Mar 2023 18:36:24 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pbm5w-000XJa-7C; Mon, 13 Mar 2023 18:36:24 +0100
Message-ID: <5513e68a-22b8-2c91-5342-b1796741610d@metafoo.de>
Date:   Mon, 13 Mar 2023 10:36:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/5] dmaengine: axi-dmac: Don't set chancnt
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20230313170250.815-1-jszhang@kernel.org>
 <20230313170250.815-3-jszhang@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230313170250.815-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26840/Mon Mar 13 08:22:58 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/13/23 10:02, Jisheng Zhang wrote:
> The dma framework will calculate the dma channels chancnt, setting it
> outself is wrong.

s/outself/ourself/

Looks good otherwise, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/dma/dma-axi-dmac.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index a812b9b00e6b..fc7cdad37161 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -963,7 +963,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
>   	dma_dev->device_terminate_all = axi_dmac_terminate_all;
>   	dma_dev->device_synchronize = axi_dmac_synchronize;
>   	dma_dev->dev = &pdev->dev;
> -	dma_dev->chancnt = 1;
>   	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
>   	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
>   	dma_dev->directions = BIT(dmac->chan.direction);


