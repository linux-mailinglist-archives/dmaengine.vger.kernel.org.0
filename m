Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251766A8833
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCBSA7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 13:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCBSA6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 13:00:58 -0500
X-Greylist: delayed 970 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 10:00:57 PST
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8BC3B0EE;
        Thu,  2 Mar 2023 10:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=4IbCOFCeBwXgy84YRcxOCpjeU9wDALUMkNtS889rDxE=; b=AyabjqvNJyhU5Og+xENvCL+fpP
        qkD8tjW3rj7LrMdujFDbrOEDeWdT0DDNppAOzlTHl5nQDb56vnPaS3QgZ6e/nfSB7LSGGzhc9Qy0B
        eCJG8qIZPaukd3Sq2lqDCJk0IWLq2eQ+OFT5rmTSCOPqnQHZGnAn90VtoLDpv/2DClqEi1TlZp0Nc
        lXmfqJ1Jy2jvyxsqxt5KMsAXHN321VQPsu4UtWFCXGiVLKbPCRtuL2N6DjhcMk+vJK/06lxog8EPG
        7O/pVn85ilMTuzLUcw5ZSMT9OYtouLk90UNaUg+BwEJKWZsjiGduRWKhZsxFlEqz1VyfPo0poHf0L
        9Z5SwPrA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pXmhj-0005nh-6i; Thu, 02 Mar 2023 18:26:55 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pXmhi-000JZJ-Ju; Thu, 02 Mar 2023 18:26:54 +0100
Message-ID: <b108f61d-e812-a500-0c8f-4fb1acd44ca2@metafoo.de>
Date:   Thu, 2 Mar 2023 09:26:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 3/4] dmaengine: dw-edma: Add support for native HDMA
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
References: <20230221034656.14476-1-cai.huoqing@linux.dev>
 <20230221034656.14476-4-cai.huoqing@linux.dev>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230221034656.14476-4-cai.huoqing@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26828/Thu Mar  2 07:36:42 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2/20/23 19:46, Cai Huoqing wrote:
> +void dw_hdma_v0_core_register(struct dw_edma *dw)
> +{
> +	dw->core = &dw_hdma_v0_core;
> +}

Where is dw_hdma_v0_core_register() called?


