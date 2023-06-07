Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A7672607E
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jun 2023 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbjFGNHC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Jun 2023 09:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbjFGNHB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Jun 2023 09:07:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C69D188;
        Wed,  7 Jun 2023 06:06:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so5468793e87.3;
        Wed, 07 Jun 2023 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686143216; x=1688735216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eVqzqKRxOOSH01gk2xNCMDidxypcD2q3gKimT9RM4+k=;
        b=nBWgvoDTBM8BU6Km/vGwg3UUgfsXLIrlBfoRdHNeXtmng/myi5+Ld1ezT7XW83byLt
         pNwdZxebb7SDxqivpL1pUZBf+vXUeSvrjdWjIefpiL3AMjkNxFgsx8pAtXaXW+1sCvlJ
         9/D1QrTRRwkPj2mFiL7YO8VsdOvSBA2dHc72WG5ZsdSv9KfBZHXyh9AvlJgLR5NHXWv1
         +JGl2TlnpypVAePh3msVyJhsvXH0+pHSLyRUqOfAzF67U3KopqFmVS6xzaPtN1d2CLPc
         aPkj9V41/DCpByRLpr39DbImGyA8YAS4rYxOxxhEqtDw8EnvVz8UAT32pND9Hh9Gx8t4
         cdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686143216; x=1688735216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVqzqKRxOOSH01gk2xNCMDidxypcD2q3gKimT9RM4+k=;
        b=E7THm+mSGvI5KaHWzRXJqiV5MaURUzKFmdaVJ6oDcEAjiNEjelYVdOmi48Z+pTaWxM
         OQxCPwAw5PehVeXOtg8aAoFQWiop5JkK2AXAP5EkJafhRt5zyJtBe1GHsXvty73YsobZ
         1bJ/hxUSn96iar4oxDr/TMA2QZEmMm9WX3eTnTT4m+cxCVlxo7p8nTsfh/BMGsTIqxVI
         6ozFfXFmzp2+PzJT3TpTuy3vt4CbGcP1KXfWYrhOyzG08UHSAwuDny+Q49wc8CvFoKeC
         X+xrhpCpQvipi7BlkMnRqE6NPeY9W1kX7iPbO3Djumq1kZwrlgIaKAO4+CIhmIL/yz1r
         g/1w==
X-Gm-Message-State: AC+VfDzxZNUOtQSf6t4RKIwxLcB0X4Jo9p3taRK2g0SvpjGHvE5M2os8
        likYlPi9+gJfmwBb3xHmUEc=
X-Google-Smtp-Source: ACHHUZ77wsQ6YZTYZqBp2m7uP2YNING/MOKHTzG4QE7uJERRnznOu4OFw9O6bb1BUtghsr8HCqJpzg==
X-Received: by 2002:ac2:559c:0:b0:4f3:8143:765 with SMTP id v28-20020ac2559c000000b004f381430765mr2283763lfg.27.1686143216337;
        Wed, 07 Jun 2023 06:06:56 -0700 (PDT)
Received: from mobilestation ([91.144.185.176])
        by smtp.gmail.com with ESMTPSA id m1-20020ac24ac1000000b004f13634da05sm1806099lfp.180.2023.06.07.06.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:06:55 -0700 (PDT)
Date:   Wed, 7 Jun 2023 16:06:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Cai Huoqing <cai.huoqing@linux.dev>
Cc:     vkoul@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v11 3/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230607130653.5hueky3rfih6cnze@mobilestation>
References: <20230520050854.73160-1-cai.huoqing@linux.dev>
 <20230520050854.73160-4-cai.huoqing@linux.dev>
 <20230607095832.6d6b1a73@kmaincent-XPS-13-7390>
 <20230607114950.zml4l2rs77cbeesy@mobilestation>
 <20230607144014.6356a197@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607144014.6356a197@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 07, 2023 at 02:40:14PM +0200, Köry Maincent wrote:
> On Wed, 7 Jun 2023 14:49:50 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > Hi Köry
> > First of all. What is akida platform you are referring to? I failed to
> > find any mention in the mainline kernel repo.
> 
> Yes, sorry akida is the project prefix I am currently working on.
> It is simply a prefix for the symbol export to be different than mainline,
> don't take it into account.
> 
> > > channels by doing the minimum between ll_wr_cnt and the ch_count callback.
> > > The hdma ch_count callback is counting the number of channels enabled by
> > > reading the number of ch_en registers set. At probe time there is no
> > > channels registers that has been set as it is done later in the
> > > dw_hdma_v0_core_start function. Then the dw_hdma_v0_core_ch_count will
> > > always return 0 at probe time and the number of channels will be set to 0
> > > which is not what we want. Could I miss something?  
> > 
> > Based on the HDMA patches content you are right. The channels must be
> > pre-enabled in order to have the dw_hdma_v0_core_ch_count() procedure
> > to work correctly otherwise you'll indeed end up with an empty list of
> > channels. I don't have any device with the HDMA engine embedded so I
> > couldn't have possibly tracked that peculiarity on review. Anyway
> > AFAICS Cai just implemented a method which seemed to work for his
> > hardware setup.
> 
> Alright, on my side I have a board using this FPGA implementation and it
> indeed doesn't work as is.
> 
> > If you think it doesn't work correctly or it isn't portable enough
> > then you are free to provide your own implementation of the method and
> > submit a patch. I hope Cai will be willing to test it out to make sure
> > that it works correctly for you and his platforms.
> > 
> > As for me if I were on your place I would have implemented a loop
> > which would walk over all possible HDMA channels (HDMA_V0_MAX_NR_CH)
> > and counted all channels which could be enabled. If the ch_en CSR is
> > writable (that is the channel could be enabled) then it shall be
> > considered as existent. Of course before that I would have made sure
> > that the non-existent channels had non-writable ch_en CSR.
> 

> This could be a nice idea but it doesn't work, non-existent channels seems to
> be writable. The datasheet of the HDMA IP doesn't have any register to find out
> the maximum existent channel. 
> As there is no way to know this, the dw_hdma_v0_core_ch_count will simply
> return HDMA_V0_MAX_NR_CH.

What about some other CSRs (llp, etc)? Are they all writable even if
the respective channel doesn't exist?

If it isn't possible to auto-detect a number of channels then indeed
we need to come up with a strategy to rely on the platform settings
instead. Your suggestion seems to be the best choice seeing there is a
commit 16b90dd94d3f ("dmaengine: dw-edma: Improve number of channels
check") which converts the rely-on-platform-settings pattern to the
current rely-on-min-between-plat-and-hw-capability.

Cai?

-Serge(y)

> Cai how does it works on your side? does the ch_en register already enabled by
> the implementation?
