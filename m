Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02444D42E8
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 09:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiCJI5o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 03:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiCJI5n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 03:57:43 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68DE137584
        for <dmaengine@vger.kernel.org>; Thu, 10 Mar 2022 00:56:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id r12so4272010pla.1
        for <dmaengine@vger.kernel.org>; Thu, 10 Mar 2022 00:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NstX+8MhKuPX15Q3Cn5v2S4ksEEmS5rE+lUKfrbEsw8=;
        b=ufeSvo1sQx1GrTcOvT9d/3N9WKIDvvcuLEVv1XMrqvjhNBOsb3S/D/ywRVvLpDZ1gx
         VjEh9QwiiHECtppmL9I+hOaTMzJh3wxJjQPkW+VJp5YH26L1iTXBmdntDz71yum+n6OJ
         RxUVf5/0+z24LAy6r63oQ625LtXWdR8udDYJ5KrYgyskXkigkfZ8+x9ZzNdaqF7ZcQI0
         VIE1/S63xfQeOsXDnjLhyXCAX2N/NfRoh72LuaGt/m9Bg2OgGG14487eBvFnY+EzFBuX
         hLXo2J6rDiipQjbyobC+TjSea1ee2FTtHySmQ8DJcD7+7sbpIWlG4L1kTC7evymD/aYR
         WLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NstX+8MhKuPX15Q3Cn5v2S4ksEEmS5rE+lUKfrbEsw8=;
        b=Vu7klMy8I6xiYUbnJlj5UnVjBv2461DWrtC2L0Wc0Q6hwCk+NZIVsKKKMRVTYnXYoz
         acrXKq0QLyW+jEoLCVNeqsPDVcnNInr8WshGwp/1+1QbEyohHJcSV0t3o1b2SVgiOIVj
         irizcZ5jzdFjfE+E2iLJVjbIp6S8FKK2OskLH0DoHgCaO5XISwP+35YXmhhqoTRWNR92
         vBjF6WaY+w/QSBYPxzAWq+In0Sw7vFI77/X9sQUwQdibZ6TQELm32cF+DN8oM+aVvOWo
         6sJjtXD1++JKKLRhV2aiYNbeewN1Ssv2YsSpHhdQCF3CdlQb82V9ItlMQWYxHY/LNH4/
         B1Uw==
X-Gm-Message-State: AOAM533ng4X7NQ6h3feJ2Y9PfQzZTwq3tSzazXXgKa0IDijnJYhy9Wbo
        Ipm/YfAsd3W8p2NKNwlamMwy
X-Google-Smtp-Source: ABdhPJzpvBqjItWH6Y5efU0r6nSLlA/IznpzdKlRZVZXLRVaXJg0uUl5/M6ZsuV1UbrxfGvYcDzjcw==
X-Received: by 2002:a17:903:22cd:b0:151:a884:d444 with SMTP id y13-20020a17090322cd00b00151a884d444mr3855855plg.141.1646902600187;
        Thu, 10 Mar 2022 00:56:40 -0800 (PST)
Received: from thinkpad ([117.193.208.22])
        by smtp.gmail.com with ESMTPSA id rm8-20020a17090b3ec800b001bcd57956desm5149383pjb.51.2022.03.10.00.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 00:56:39 -0800 (PST)
Date:   Thu, 10 Mar 2022 14:26:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
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
Message-ID: <20220310085632.GE4869@thinkpad>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
 <20220309133940.3le2ma24aqlhips4@mobilestation>
 <20220309181233.GC134091@thinkpad>
 <20220309190123.dnivojpqhl52o5vc@mobilestation>
 <20220310062242.GB4869@thinkpad>
 <20220310084112.2vhvvnl6pmlkfg36@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310084112.2vhvvnl6pmlkfg36@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 10, 2022 at 11:41:12AM +0300, Serge Semin wrote:
> On Thu, Mar 10, 2022 at 11:52:42AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Mar 09, 2022 at 10:01:23PM +0300, Serge Semin wrote:
> > 
> > [...]
> > 
> > > > I'm afraid that this will not work for all cases (unless I miss something). As
> > > > Zhi Li pointed out, there are places where only chip pointer will be passed and
> > > > we'd need to extract the private data (dw_edma) from it.
> > > > 
> > > > Tbh I also considered your idea but because of the above mentioned issue and
> > > > also referring to other implementations like gpiochip, I settled with Frank's
> > > > idea of copying the fields.
> > > 
> > > What places are these? I see the only obstacle is the dw_edma_remove()
> > > method. But it's easily fixable.
> > 
> > Yeah, right. I overlooked that part.
> > 
> > > Except that, everything else is more
> > > or less straightforward (just a few methods need to have prototypes
> > > converted to accepting dw_edma instead dw_edma_chip).
> > > 
> > > In order to make the code design more coherent, we need to split up
> > > private data and device/platform info. As I see it dw_edma_chip is
> > > nothing but a chip info data. The eDMA driver is supposed to mainly
> > > use and pass it's private data, not the platform info. It will greatly
> > > improve the code readability and maintainability. Such approach will
> > > also prevent a temptation of adding new private data fields into the
> > > dw_edma_chip structure since reaching the pointer to dw_edma will be
> > > much easier that getting the dw_edma_chip data. In this case
> > > dw_edma_chip will be something like i2c_board_info in i2c.
> > > 
> > > Ideally dw_edma_chip could be a temporarily defined device info, which
> > > memory after the dw_edma_probe() method invocation could be freed. But
> > > in order to implement that we'd need a bit more modifications
> > > introduced.
> > > 
> > 
> 
> > While at it, we should also consider adding an ops structure for passing the
> > callbacks from controller drivers. Currently the eDMA driver has the callbacks
> > defined in v0-core.c but it is used directly instead of as a callback.
> 
> Are you saying about DBI/Native IOs? If so seems reasonable. Though in
> my case it isn't required.) The only problem was a dword-aligned access,
> which has been created in the DW eDMA driver by default.
> 

It is not causing any problem but it doesn't look correct to me.

Btw, do you have a patch for DWORD access? If so, please share. We are also
facing the problem and like to see how to are handling it.

Thanks,
Mani

> -Sergey
> 
> > 
> > This should anyway needs to be fixed when another version of the IP get's added.
> > 
> > Thanks,
> > Mani
