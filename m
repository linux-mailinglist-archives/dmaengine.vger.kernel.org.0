Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C94D42C2
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 09:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiCJImR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 03:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiCJImR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 03:42:17 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3E2137002;
        Thu, 10 Mar 2022 00:41:16 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u7so6644563ljk.13;
        Thu, 10 Mar 2022 00:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HEH7N1bam7RhVeQVNij6YKH5QRorXfJG3z06SE7sOT8=;
        b=kFWHHpaeWJRl8678AwrrmoC5eOb2ooSjHVFf4giDh/l/+7sv84DfEpi8nkORWAdtSg
         Tw5r6+VN+3GYkw01qGbwdtiUj/mMtAG7ZZglGqA5P1AsKz+QKbnR5+D6bidfsaw55t0y
         vSkvHcF2meanYAvSDuGL/EVHwx0rdy6eQ/kn/XgIwOFVOhIGsx9alvoF0b+XEwwNzihH
         b7Y20hIrKrm86sQ6xBCgMvbcBXnccNLJbUVpJENDUacs5oPDVAokq3PO8bjSyLOBfG5K
         wO9B+AenLRhhLrPA55Aes4lEMczjIXvB/na3LQyETinkeBb4q48uuwKd0w6sBdB0yuzZ
         oyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HEH7N1bam7RhVeQVNij6YKH5QRorXfJG3z06SE7sOT8=;
        b=C6B9s5sk0UWCPXQY8kHalp8//KWeTnXzpGg/x9pm6bsO3aK8nQInBpQnSXsoiiwGOE
         +KnCuOvR169KxwBULpdHzU9qHulFstVD9fXo02g7uu3wD090CS5J7crOlRVdL6Ci3Fid
         uD1t9Lb/f7gPO9o1fEIawRJ2p1d9q3ZSXD32+aO8RveebAkMLKW87erajevJvdDTm4mZ
         JnSlMkoihqQZ+fgS9ziJxIfEjnHOb+2EMJvbCAH2YoFOJl24qu8PCORFPixt3eS+Pf70
         2ZF2uUndGyjgken+8wovg/PBQO1SsRxaPCgCpCfjKo7OSo7tIalSgKPqmaN0IYDOsZFm
         3qaw==
X-Gm-Message-State: AOAM531VP7P+jsh8R8Ev/Y7lNETcma6KcI5SWMb4wpzdaazn16JFCnLA
        yJ+jnX0rgyLjtsx8olvMqKg=
X-Google-Smtp-Source: ABdhPJxtsqVoIAH/wc4XH57wTFiikB21nFr19gsF8faHHurqn0GQSzdKOJspLMuZNI5wxDq2Jmd2VQ==
X-Received: by 2002:a05:651c:543:b0:247:e36d:72e7 with SMTP id q3-20020a05651c054300b00247e36d72e7mr2350716ljp.80.1646901674505;
        Thu, 10 Mar 2022 00:41:14 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id a8-20020a195f48000000b004482914411asm857544lfj.2.2022.03.10.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 00:41:13 -0800 (PST)
Date:   Thu, 10 Mar 2022 11:41:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v3 1/6] dmaengine: dw-edma: fix dw_edma_probe() can't be
 call globally
Message-ID: <20220310084112.2vhvvnl6pmlkfg36@mobilestation>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
 <20220309133940.3le2ma24aqlhips4@mobilestation>
 <20220309181233.GC134091@thinkpad>
 <20220309190123.dnivojpqhl52o5vc@mobilestation>
 <20220310062242.GB4869@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310062242.GB4869@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 10, 2022 at 11:52:42AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 09, 2022 at 10:01:23PM +0300, Serge Semin wrote:
> 
> [...]
> 
> > > I'm afraid that this will not work for all cases (unless I miss something). As
> > > Zhi Li pointed out, there are places where only chip pointer will be passed and
> > > we'd need to extract the private data (dw_edma) from it.
> > > 
> > > Tbh I also considered your idea but because of the above mentioned issue and
> > > also referring to other implementations like gpiochip, I settled with Frank's
> > > idea of copying the fields.
> > 
> > What places are these? I see the only obstacle is the dw_edma_remove()
> > method. But it's easily fixable.
> 
> Yeah, right. I overlooked that part.
> 
> > Except that, everything else is more
> > or less straightforward (just a few methods need to have prototypes
> > converted to accepting dw_edma instead dw_edma_chip).
> > 
> > In order to make the code design more coherent, we need to split up
> > private data and device/platform info. As I see it dw_edma_chip is
> > nothing but a chip info data. The eDMA driver is supposed to mainly
> > use and pass it's private data, not the platform info. It will greatly
> > improve the code readability and maintainability. Such approach will
> > also prevent a temptation of adding new private data fields into the
> > dw_edma_chip structure since reaching the pointer to dw_edma will be
> > much easier that getting the dw_edma_chip data. In this case
> > dw_edma_chip will be something like i2c_board_info in i2c.
> > 
> > Ideally dw_edma_chip could be a temporarily defined device info, which
> > memory after the dw_edma_probe() method invocation could be freed. But
> > in order to implement that we'd need a bit more modifications
> > introduced.
> > 
> 

> While at it, we should also consider adding an ops structure for passing the
> callbacks from controller drivers. Currently the eDMA driver has the callbacks
> defined in v0-core.c but it is used directly instead of as a callback.

Are you saying about DBI/Native IOs? If so seems reasonable. Though in
my case it isn't required.) The only problem was a dword-aligned access,
which has been created in the DW eDMA driver by default.

-Sergey

> 
> This should anyway needs to be fixed when another version of the IP get's added.
> 
> Thanks,
> Mani
