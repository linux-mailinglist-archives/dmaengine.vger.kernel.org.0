Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6347F4D3881
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 19:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiCISNl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 13:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiCISNl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 13:13:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216D64AE06
        for <dmaengine@vger.kernel.org>; Wed,  9 Mar 2022 10:12:42 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w4so2637641ply.13
        for <dmaengine@vger.kernel.org>; Wed, 09 Mar 2022 10:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=56BGe+3+cU6Bx05+BBTn6trXu9jVThBX8iDC4LtGob8=;
        b=Ym73uBzzXEBL/lEnILGlTjS7DuXYCXJ+VhZcuOog5OCA9Cp7u+PsFvY9nUlu4d1PJu
         YNXky+jjsFWbpLB/w2s0iUG75v9sgzoo0JufQlVh7DADuhhLJsGmnQY7Klt9cdZKnEJT
         dJD7NGkhg9lJYltPv5BVUXayEr+8Z8wworBt5imAtP8/E58yUb8Weo7dVLsiOrBd0ENx
         r0pBOiUvpQflZmYgIEZlnjHK35HoIecLl62DeQfhvDkQ4CcopqCkOhLkS8o3NeDTyLKZ
         BI+yq2kPygnSKZEleilI6kHdGNx6hTzU1IW3SjvkVnPJIqkkt4gYDd3JfKFqI3ZATHAd
         GmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=56BGe+3+cU6Bx05+BBTn6trXu9jVThBX8iDC4LtGob8=;
        b=PlF1ivpytt4xhVt6TcpoSV8oYmUWB4896AsefJDEZP05PA8QZ6H/+HL4HMqp0KWal0
         PZcO2qRX5GGmYZ5wxZTS2pHEs7Xup14Hwn5U5+A8rsfMt5WzZ6SNpVGqzddjupE8m8qt
         T+U/F2UyU38qrV+s5rG2LSdzzWFU/i/+Y+ghC0hB8lp5V3ZKWFyc2pzd32M5RzZdHCJL
         uOs1o5ZsSWyM5eQKFxRcyUxUqMQ/ggVDX7XCEZUejDxBrb9o/OHuGExEfJW1T5+GkpZy
         /lG1caSLyg9b0b7H+kS4RlV7zMxLJg9OK6Xc/lPsjII0YMiSxurOYc370dricFgiNOgn
         5taA==
X-Gm-Message-State: AOAM5336BMHl3IP63uRhO+RW0QhBD1+0/9aru1CFEEsQ/f4fetk51ln2
        y8r10LgdyT0m8b6pp/zO+1yb
X-Google-Smtp-Source: ABdhPJw/YiDUnk46iNcQP6vteSOf61VCBGPPbu1GCFtPtzLJhtGqs+AcKGfoeAyaF+01dRzOD7Yyag==
X-Received: by 2002:a17:902:ec8e:b0:152:939:ac4a with SMTP id x14-20020a170902ec8e00b001520939ac4amr888412plg.5.1646849561525;
        Wed, 09 Mar 2022 10:12:41 -0800 (PST)
Received: from thinkpad ([117.193.208.22])
        by smtp.gmail.com with ESMTPSA id lb1-20020a17090b4a4100b001bfb76e56d1sm2182220pjb.36.2022.03.09.10.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:12:41 -0800 (PST)
Date:   Wed, 9 Mar 2022 23:42:33 +0530
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
Message-ID: <20220309181233.GC134091@thinkpad>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
 <20220309133940.3le2ma24aqlhips4@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309133940.3le2ma24aqlhips4@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hey,

On Wed, Mar 09, 2022 at 04:39:40PM +0300, Serge Semin wrote:
> Hello Frank
> 
> On Mon, Mar 07, 2022 at 04:47:45PM -0600, Frank Li wrote:
> > "struct dw_edma_chip" contains an internal structure "struct dw_edma" that is
> > used by the eDMA core internally. This structure should not be touched
> > by the eDMA controller drivers themselves. But currently, the eDMA
> > controller drivers like "dw-edma-pci" allocates and populates this
> > internal structure then passes it on to eDMA core. The eDMA core further
> > populates the structure and uses it. This is wrong!
> > 
> > Hence, move all the "struct dw_edma" specifics from controller drivers
> > to the eDMA core.
> 
> Thanks for the patchset. Alas it has just drawn my attention on v3
> stage, otherwise I would have given to you my thoughts stright away on
> v1. Anyway first of all a cover letter would be very much appropriate
> to have a general notion about all the changes introduced in the set.
> 

+1 for cover letter.

> Secondly I've just been working on adding the eDMA platform support
> myself, so you have been just about a week ahead of me submitting my
> changes.

Welcome to the ship :) We (me and my colleague) were also working on eDMA
support for Qcom platform, so jumped in.

>  My work contains some of the modifications done by you (but
> have some additional fixes too) so I'll need to rebase it on top of
> your patchset when it's finished. Anyway am I understand correctly,
> that you've also been working on the DW PCIe driver alteration so one
> would properly initialize the eDMA-chip data structure? If so have you
> sent the patchset already?  Could you give me a link and add me to Cc
> in the emailing thread? (That's where the cover letter with all the
> info and related patchsets would be very helpful.)
> 

https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097

But this patch got dropped in v3 as the ep support for imx driver has not landed
yet.

> Thirdly regarding this patch. Your modification is mainly correct, but
> I would suggest to change the concept. Instead of needlessly converting
> the code to using the dw_edma_chip structure pointer within the DW eDMA
> driver, it would be much easier in modification and more logical to
> keep using the struct dw_edma pointer. Especially seeing dw_edma
> structure is going to be a pure private data. So to speak what I would
> suggest is to have the next pointers setup:
> 

I'm afraid that this will not work for all cases (unless I miss something). As
Zhi Li pointed out, there are places where only chip pointer will be passed and
we'd need to extract the private data (dw_edma) from it.

Tbh I also considered your idea but because of the above mentioned issue and
also referring to other implementations like gpiochip, I settled with Frank's
idea of copying the fields.

Thanks,
Mani
