Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C70E6C08EC
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 03:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCTCgx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Mar 2023 22:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCTCgw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Mar 2023 22:36:52 -0400
Received: from out-59.mta0.migadu.com (out-59.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579B31EBE2
        for <dmaengine@vger.kernel.org>; Sun, 19 Mar 2023 19:36:51 -0700 (PDT)
Date:   Mon, 20 Mar 2023 10:36:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679279809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgQAiGefSASwrILG20+TjVn3CY38eGKM4K8VV4CahxU=;
        b=VZJYaWxQ1RsUe99l8y8YOyhkKTiBBJV0ophB+rC549zbG0668w6Xi2fK4lcLvl2e8jkI4O
        PzD3k3tlGfIlDqVANFxYVbYsKR5kYiEnFBkLphPH81HrN/eIfdss6OGXodsbL3bbMRnK5L
        J/df7CwKRhs55hnfBSpXSi1xUjWapCI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     fancer.lancer@gmail.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 3/5] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <ZBfGvRL8cHuj1tJF@chq-MS-7D45>
References: <20230315012840.6986-1-cai.huoqing@linux.dev>
 <20230315012840.6986-4-cai.huoqing@linux.dev>
 <02216197-6cbd-319d-1015-bfb4449ead85@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02216197-6cbd-319d-1015-bfb4449ead85@metafoo.de>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18 3月 23 06:49:41, Lars-Peter Clausen wrote:
> On 3/14/23 18:28, Cai Huoqing wrote:
> > Add support for HDMA NATIVE, as long the IP design has set
> > 
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > new file mode 100644
> > index 000000000000..0a6032aa1a33
> > --- /dev/null
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > @@ -0,0 +1,130 @@
> > 
> > +struct dw_hdma_v0_ch_regs {
> > [...]
> > +	u32 msi_msgdata;			/* 0x00a8 */
> > +	u32 padding_2[21];			/* 0x00ac..0x00e8 */
> The comment here is wrong. This goes all the way to 0x00fc.

Will fix, if send next version.

Thanks,
Cai-

> > +} __packed;
> > +
> 
