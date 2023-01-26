Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008BF67D780
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jan 2023 22:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjAZVQk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Jan 2023 16:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAZVQk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Jan 2023 16:16:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34FCF74F;
        Thu, 26 Jan 2023 13:16:38 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id kt14so8676758ejc.3;
        Thu, 26 Jan 2023 13:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4wZGc+/61H+7nh1Ut/sPpVJzV2ViSDF832HFBXZPXE=;
        b=le3JHTg7dpllk2Nbd/TxIMUPbYMNoLaNZBsa3OCAkOAUNc+lm2N1dEdsa3MteLiGMR
         rmyFOau9hZGz12ZCdcj1AOdJKZM/Vo1rzzO/Efq7Tp8KkowhkpZIm28L2zgXfQitNtvo
         Aw2TK0HEZ5QFahBYgiNbLIhLTINZi/Ah+e9XysrktRo3OMuiCVjZcTe7DFz0dMcrUjtu
         ypK9MYE3X8TNFx41d2cd2M5XzPdadSJVH7Av3WiNfTYGLfsde5AYcM5typYKSMxw5l5k
         OyoVhy9DtVDS/5o0qslRCSjMGhhnUnWntgEghVqV2eFJShVWHbevLVoawBCA2uQl0UMl
         EsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4wZGc+/61H+7nh1Ut/sPpVJzV2ViSDF832HFBXZPXE=;
        b=IQC7B6HX8B48hHawmQX5P72n7qjxLisZY5w+oI3amFWcTKcLRTDk5ABPKIZnthGqjB
         ol+Qs+Y+eS0rl8lUBig2RAr1BxQ6hpO7W/w9cFH/4P0GZ5XY7G1zy2DW0EB4yeSqiTla
         foceqb5zD3zeCZXoKSaChBYLFhhX8qTp8QSNNJDCQM7VcPp8RZ9c/g0cge90/UKs8vni
         HwnCMVlScXItmq9JK8VkI7UvIwQCf5ILORpCKx9FoTUt8iTWDAD3JQyX989oqV2AzXWE
         WpGZananv5xiH6t8fKF/QomxUPAPBH/xa6y78Z6TDIEas0ZP+sRUgYdEPeX5fjyCjiT8
         NF3A==
X-Gm-Message-State: AFqh2koq3blM4HdSDPqBnVFE1yxIBWSkX5G7CJe9PgwS1nVDzRWzo33Z
        vQU9WYcoFYsxeDBDyX0vGsg=
X-Google-Smtp-Source: AMrXdXvowaonAq79z6eutzkjdeJ0OpfXBNXIa0ecYJhDnVmezB6z2YcV0iEaTTYUZndl4X+tdTr1Hw==
X-Received: by 2002:a17:906:edac:b0:844:1d1d:f7 with SMTP id sa12-20020a170906edac00b008441d1d00f7mr40261807ejb.23.1674767797343;
        Thu, 26 Jan 2023 13:16:37 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id se3-20020a170906ce4300b0084d37cc06fesm1137217ejb.94.2023.01.26.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:16:36 -0800 (PST)
Date:   Fri, 27 Jan 2023 00:16:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 24/27] dmaengine: dw-edma: Relax driver config settings
Message-ID: <20230126211633.2sptj5jn4ccmykx4@mobilestation>
References: <20230126163750.ae6z3pkyd3o32byn@mobilestation>
 <20230126181954.GA1290077@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126181954.GA1290077@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jan 26, 2023 at 12:19:54PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 26, 2023 at 07:37:50PM +0300, Serge Semin wrote:
> > On Wed, Jan 25, 2023 at 05:23:57PM -0600, Bjorn Helgaas wrote:
> 
> > > It's a pretty trivial update, so I just did it myself.  The result is
> > > at https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/ctrl/dwc&id=ecadcaed4ef7
> > > 
> > > I split this patch and tweaked some commit messages for consistency
> > > (including the "DW eDMA PCIe driver" change above).  "git diff -b"
> > > with Lorenzo's current branch (95624672bb3e ("PCI: dwc: Add DW eDMA
> > > engine support")) is empty except for a minor comment change.  
> > 
> > Great! Thanks. Although I've already created v10 beforehand but didn't
> > submitted it yet waiting for your response. The split up patches look
> > exactly like yours.
> > 
> > In addition to that since I was going to re-send v10 I also took into
> > account your comments regarding the patch:
> > [PATCH v9 19/27] dmaengine: dw-edma: Use non-atomic io-64 methods
> > Link: https://lore.kernel.org/linux-pci/20230113171409.30470-20-Sergey.Semin@baikalelectronics.ru/
> > I've dropped unneeded modification and unpinned another fixes patch
> > which turned out to be a part of those modifications. So if you
> > re-based your pci/ctrl/dwc branch with that patch replaced with the
> > patches attached to this email it would have been great. Otherwise
> > it's ok to merge the series as is.
> > 
> > Note in the attached "non-atomic io-64" patch I've already replaced
> > the commit log with the your short version.
> 

> Awesome, thanks!  I folded those updates in and updated my branch.
> 
> And merged the whole thing into the PCI "next" branch.
> 
> Thanks for all your work!

Great! Thanks to you too with reviewing and helping to merge the bits.
I've almost completed another series with a few more updates based on
the notes made by you and Mani during the review. I'll submit the
patchset soon.

-Serge(y)

> 
> Bjorn
