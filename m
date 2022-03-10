Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADC4D4116
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 07:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiCJGXx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 01:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239753AbiCJGXv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 01:23:51 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA2E5575B
        for <dmaengine@vger.kernel.org>; Wed,  9 Mar 2022 22:22:51 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n15so4012452plh.2
        for <dmaengine@vger.kernel.org>; Wed, 09 Mar 2022 22:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dj3Da4QhbJDmhrY8mSKQqYTUZVJxjA5itzJkwxjbVvc=;
        b=bco7wNeVdItOHRyMV/9kQklokd8pyaVi4D5UcIAJXykHgePKLX7vSB+w/Ou7HLGUcN
         GWzkVQGi2JMldobJXkNDPyqJXGPbePpZtSUZow7wPbhJt6DGdgBodrHtJeuZwca/ZMg3
         qqIlsjzSYRezLrG+HVDyyyd5gI74vvvzAmH22eqGQAnpoRaCDG822CEdwsHJ3jPIM0mT
         1KUJROb0EpkLfI3NgCYHoVze34B3cfCJjDwbkZdSsh6iANCOrTSIrDw+uNX6YIKOG/AZ
         vGkK8V7exH6D5Fid1frJeLIbeOpZTqebp6FFFbU2VZOipU6EqP0nF6DLbqvCZdObJH71
         O9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dj3Da4QhbJDmhrY8mSKQqYTUZVJxjA5itzJkwxjbVvc=;
        b=GG574cGxuDHSNS3fs37r8pB45WdfWwSPCYFX+BFxfuZnKxHBelIDzQvA3c02CKgjIf
         68NCqHtmPlCYDGNT7wNNHCpeSLMVPgorLWLTqqrMxmXl3ZE9YvaFr2YO7+6PkgFOAWbj
         Qg3zRBGfMEUS3nbCC7wXj/qiYWsfxV2voMokf/qCiegc+hoshTXg0JwrX0YpOoNP/PtP
         q4OFt3tBXIKfJZKoztvbG+A1eYAR4qjDhHVECUBYWc7Y+NR1sj2kRGfO+v8ThRrhsU9v
         pjtpxbqUnU3OjlTSQsxlF8UXXd4CsqRTiiS9j8m7EBe3tavlrXXB+M9NSa9YE0the6o1
         27nA==
X-Gm-Message-State: AOAM533YAkzA3FhRxNCxwm6MUHR70Lj66zrUrC4jm9FFM2giSlKr2Z1Q
        5degvlvguKf3ZkRHHzTDtcbj
X-Google-Smtp-Source: ABdhPJxDHyzHli8Jhs+yCEcE4GMsLd+yFXyYIKOWUKjEjMCfZ/IZyUVZBKx3X5A5+KFOS592SfQ41w==
X-Received: by 2002:a17:90b:384b:b0:1bf:12d8:62c0 with SMTP id nl11-20020a17090b384b00b001bf12d862c0mr14574030pjb.142.1646893370373;
        Wed, 09 Mar 2022 22:22:50 -0800 (PST)
Received: from thinkpad ([117.193.208.22])
        by smtp.gmail.com with ESMTPSA id i192-20020a636dc9000000b0037c7149fb0asm4425473pgc.89.2022.03.09.22.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 22:22:49 -0800 (PST)
Date:   Thu, 10 Mar 2022 11:52:42 +0530
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
Message-ID: <20220310062242.GB4869@thinkpad>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
 <20220309133940.3le2ma24aqlhips4@mobilestation>
 <20220309181233.GC134091@thinkpad>
 <20220309190123.dnivojpqhl52o5vc@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309190123.dnivojpqhl52o5vc@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 09, 2022 at 10:01:23PM +0300, Serge Semin wrote:

[...]

> > I'm afraid that this will not work for all cases (unless I miss something). As
> > Zhi Li pointed out, there are places where only chip pointer will be passed and
> > we'd need to extract the private data (dw_edma) from it.
> > 
> > Tbh I also considered your idea but because of the above mentioned issue and
> > also referring to other implementations like gpiochip, I settled with Frank's
> > idea of copying the fields.
> 
> What places are these? I see the only obstacle is the dw_edma_remove()
> method. But it's easily fixable.

Yeah, right. I overlooked that part.

> Except that, everything else is more
> or less straightforward (just a few methods need to have prototypes
> converted to accepting dw_edma instead dw_edma_chip).
> 
> In order to make the code design more coherent, we need to split up
> private data and device/platform info. As I see it dw_edma_chip is
> nothing but a chip info data. The eDMA driver is supposed to mainly
> use and pass it's private data, not the platform info. It will greatly
> improve the code readability and maintainability. Such approach will
> also prevent a temptation of adding new private data fields into the
> dw_edma_chip structure since reaching the pointer to dw_edma will be
> much easier that getting the dw_edma_chip data. In this case
> dw_edma_chip will be something like i2c_board_info in i2c.
> 
> Ideally dw_edma_chip could be a temporarily defined device info, which
> memory after the dw_edma_probe() method invocation could be freed. But
> in order to implement that we'd need a bit more modifications
> introduced.
> 

While at it, we should also consider adding an ops structure for passing the
callbacks from controller drivers. Currently the eDMA driver has the callbacks
defined in v0-core.c but it is used directly instead of as a callback.

This should anyway needs to be fixed when another version of the IP get's added.

Thanks,
Mani
