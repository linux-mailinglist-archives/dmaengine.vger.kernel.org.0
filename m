Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486474D3961
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 20:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbiCITC3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 14:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiCITC2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 14:02:28 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EFB125CA9;
        Wed,  9 Mar 2022 11:01:28 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v28so4557709ljv.9;
        Wed, 09 Mar 2022 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jIu2Z0CGHFqZmEt49Jo67nU+xFa4QbfdZDGLa4PtXDg=;
        b=IjfHKwQjKYmZdFZ5dui9Ihs9xXJ5/cYPoTLuBK7FRL71BnicA40LcykzPmj2vBzdUw
         rtGJlqDdcs2Q4VTVc3isPQZR85q9JmZ6DUZPhFSSNywgaQE3IHa6/7MOipMtsJMAR3nV
         1b7rtVvQ08BjTcZKNibuMAWtw1g4/mPxuTpDRlRqfx5BqH7HBQYr0WJAWb0gf142arhC
         BBfZ4zKTj02wfe/ZJO+GMweTHHij4jdAP/IrRMkCt7zs51JEH2VVabCkwGN52yHZtUpT
         FF1ZfNMYhATyfePcQb+hjg/0tNaXKzZlu3ki/Ki3E389uoHfKlx8IHvw8i79K0TWQXra
         nCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jIu2Z0CGHFqZmEt49Jo67nU+xFa4QbfdZDGLa4PtXDg=;
        b=dQXCn24BrUpzUCyfOKgkaKZMj5PtGyIyFyLf6OR5t8HfkooVnupDSOOxbihxWb3ZUq
         1zkmIvhJjfkfHdcDqhXZmwhM5u8P7+yEMFO8rx6kVcHCWkeo6KHudMWOo1qY3a6oUr4y
         OcQ0BLScz/awmV+y8lDYLQYfzxs6MkDArx1NaEOQhBgvTloo731jdel/PGXbCsvg0GP7
         guOLBEbHmCzDElMLakKmnlW7Ow1dEz7NyixAbSP4gscbVNVEpzIXFVz7+g+1fOHjL1U+
         ODzixWTgz2pxjPuPT1r3LxVnjUAVlk5ZU72MksIe+fNQLP99AlZoLMVTUj2VMueYROMm
         oTZA==
X-Gm-Message-State: AOAM531Ujx1XOl2l4U8UxbPTjEPjdHJ9fGYWv4RTdGV2KYbx3pSK6phH
        12loIgiYYHL9TohOkTqvRzM=
X-Google-Smtp-Source: ABdhPJxI2v/O6oMElZGONuJ4xVy1GTx8cOkRuWEv8dfGsR/C8Ssd2DLcpd+BeMHTZGouMWd2A4f+BA==
X-Received: by 2002:a2e:b8c6:0:b0:247:988f:5636 with SMTP id s6-20020a2eb8c6000000b00247988f5636mr597092ljp.195.1646852486334;
        Wed, 09 Mar 2022 11:01:26 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id q7-20020a19a407000000b00445bb5d5bd0sm533880lfc.34.2022.03.09.11.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:01:25 -0800 (PST)
Date:   Wed, 9 Mar 2022 22:01:23 +0300
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
Message-ID: <20220309190123.dnivojpqhl52o5vc@mobilestation>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
 <20220309133940.3le2ma24aqlhips4@mobilestation>
 <20220309181233.GC134091@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309181233.GC134091@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 09, 2022 at 11:42:33PM +0530, Manivannan Sadhasivam wrote:
> Hey,
> 
> On Wed, Mar 09, 2022 at 04:39:40PM +0300, Serge Semin wrote:
> > Hello Frank
> > 
> > On Mon, Mar 07, 2022 at 04:47:45PM -0600, Frank Li wrote:
> > > "struct dw_edma_chip" contains an internal structure "struct dw_edma" that is
> > > used by the eDMA core internally. This structure should not be touched
> > > by the eDMA controller drivers themselves. But currently, the eDMA
> > > controller drivers like "dw-edma-pci" allocates and populates this
> > > internal structure then passes it on to eDMA core. The eDMA core further
> > > populates the structure and uses it. This is wrong!
> > > 
> > > Hence, move all the "struct dw_edma" specifics from controller drivers
> > > to the eDMA core.
> > 
> > Thanks for the patchset. Alas it has just drawn my attention on v3
> > stage, otherwise I would have given to you my thoughts stright away on
> > v1. Anyway first of all a cover letter would be very much appropriate
> > to have a general notion about all the changes introduced in the set.
> > 
> 
> +1 for cover letter.
> 
> > Secondly I've just been working on adding the eDMA platform support
> > myself, so you have been just about a week ahead of me submitting my
> > changes.
> 
> Welcome to the ship :) We (me and my colleague) were also working on eDMA
> support for Qcom platform, so jumped in.
> 
> >  My work contains some of the modifications done by you (but
> > have some additional fixes too) so I'll need to rebase it on top of
> > your patchset when it's finished. Anyway am I understand correctly,
> > that you've also been working on the DW PCIe driver alteration so one
> > would properly initialize the eDMA-chip data structure? If so have you
> > sent the patchset already?  Could you give me a link and add me to Cc
> > in the emailing thread? (That's where the cover letter with all the
> > info and related patchsets would be very helpful.)
> > 
> 

> https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> 
> But this patch got dropped in v3 as the ep support for imx driver has not landed
> yet.

I see. Ok then.

> 
> > Thirdly regarding this patch. Your modification is mainly correct, but
> > I would suggest to change the concept. Instead of needlessly converting
> > the code to using the dw_edma_chip structure pointer within the DW eDMA
> > driver, it would be much easier in modification and more logical to
> > keep using the struct dw_edma pointer. Especially seeing dw_edma
> > structure is going to be a pure private data. So to speak what I would
> > suggest is to have the next pointers setup:
> > 
> 

> I'm afraid that this will not work for all cases (unless I miss something). As
> Zhi Li pointed out, there are places where only chip pointer will be passed and
> we'd need to extract the private data (dw_edma) from it.
> 
> Tbh I also considered your idea but because of the above mentioned issue and
> also referring to other implementations like gpiochip, I settled with Frank's
> idea of copying the fields.

What places are these? I see the only obstacle is the dw_edma_remove()
method. But it's easily fixable. Except that, everything else is more
or less straightforward (just a few methods need to have prototypes
converted to accepting dw_edma instead dw_edma_chip).

In order to make the code design more coherent, we need to split up
private data and device/platform info. As I see it dw_edma_chip is
nothing but a chip info data. The eDMA driver is supposed to mainly
use and pass it's private data, not the platform info. It will greatly
improve the code readability and maintainability. Such approach will
also prevent a temptation of adding new private data fields into the
dw_edma_chip structure since reaching the pointer to dw_edma will be
much easier that getting the dw_edma_chip data. In this case
dw_edma_chip will be something like i2c_board_info in i2c.

Ideally dw_edma_chip could be a temporarily defined device info, which
memory after the dw_edma_probe() method invocation could be freed. But
in order to implement that we'd need a bit more modifications
introduced.

Last but not least the approach suggested by me is easier to
implement, thus having easier review, easier backporting and causing
less potential bugs.

-Sergey

> 
> Thanks,
> Mani
