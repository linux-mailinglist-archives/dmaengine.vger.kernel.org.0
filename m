Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163EF6BFAAD
	for <lists+dmaengine@lfdr.de>; Sat, 18 Mar 2023 15:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCROKW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Mar 2023 10:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCROKV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Mar 2023 10:10:21 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186F32210A;
        Sat, 18 Mar 2023 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Luv4E4Zi2VCB+ZCtjwI79vLjcLeZ5+7puHaRvQvw66k=; b=gvhhnjYhMMX9IcdWK0SRcmhyYi
        ANx26ZNPmi880X3NFYjtI6t4/ZFLLnPX8xngazTkX8fdWsjPZKlw8x5XE4GXCC5s407HjJjGZ9vOn
        lHGJbICc20UZh2gc30e885K00Bulj/7V8nzAyC1yLKJrVsTCQKtuKhE7JkZDFy6/JjBl3972/wQ8y
        EiiHa1eJcJeDOirH1VcuAmc07GswM0r54WovTB56oKjeUw7gRVFrwlBm9K/ww9/Kst9XOq7NgU9kh
        u7cEoIAbNf/BmV5JyHi0TeLWy5Hct7LEGBM05yGFXPyHnufFxO0+ruEHURJF7u//8uydlbaxTOKLg
        kB1/PLSA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pdWwL-0005Ex-NR; Sat, 18 Mar 2023 14:49:45 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pdWwL-000UnY-7I; Sat, 18 Mar 2023 14:49:45 +0100
Message-ID: <02216197-6cbd-319d-1015-bfb4449ead85@metafoo.de>
Date:   Sat, 18 Mar 2023 06:49:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 3/5] dmaengine: dw-edma: Add support for native HDMA
Content-Language: en-US
To:     Cai Huoqing <cai.huoqing@linux.dev>, fancer.lancer@gmail.com
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230315012840.6986-1-cai.huoqing@linux.dev>
 <20230315012840.6986-4-cai.huoqing@linux.dev>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230315012840.6986-4-cai.huoqing@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26847/Sat Mar 18 08:21:32 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/14/23 18:28, Cai Huoqing wrote:
> Add support for HDMA NATIVE, as long the IP design has set
>
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> new file mode 100644
> index 000000000000..0a6032aa1a33
> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -0,0 +1,130 @@
>
> +struct dw_hdma_v0_ch_regs {
> [...]
> +	u32 msi_msgdata;			/* 0x00a8 */
> +	u32 padding_2[21];			/* 0x00ac..0x00e8 */
The comment here is wrong. This goes all the way to 0x00fc.
> +} __packed;
> +

