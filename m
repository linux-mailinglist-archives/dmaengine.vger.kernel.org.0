Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB76B84AB
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 23:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjCMWVc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 18:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCMWVc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 18:21:32 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEFB1ABC8;
        Mon, 13 Mar 2023 15:21:30 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b13so14191114ljf.6;
        Mon, 13 Mar 2023 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678746089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lgLb5XFePEU9jptTtQsEKcrGixEAnt+jbUUD2Xgwnk=;
        b=XrECHhrUNMF7t1fwGgwocFZDCoNVlVcKRW5Em4KQoq1n8fmq6JuBJSVM51ELcsxROP
         1LzAJ9r6cQ8fK22QU8b7+71aJZq6timCL+alDw0n6IB5XrCg52tVoc8YUG6cl1g1gGRd
         QVYJf9W1iWwWwxIlwD5b69A50LglRfo5bxIjNupvDdqQdaLEY43MfTZKFgUIDbtoooRz
         AyrsyTQr0f16aGDfRAWPAMHoIWVODHcKD8kRpqdgI+Lt1vLtPPeYW2uuJQqYqYOlPMzg
         hqnjYkMwdkSNAmNWdYKxhDDuzDM3LuwSbMSFvUgmkKjhLhSXuyjaPFhnfpiioR6Sj6Uv
         WIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678746089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lgLb5XFePEU9jptTtQsEKcrGixEAnt+jbUUD2Xgwnk=;
        b=YLB49Dc2V7ISdcgNmwO6rMcm/Tklo7xz7evlJrefwmr3NBg40haGDuuBBnRZgAKPmg
         ABtD/ZhTL/L5OiPZRN2QhSAnGJjb61lgBffcXjVqWxN6UiCTFG6U76saVim2VNwkt8Hs
         QO45Ky2bykBmtZ7y4hLBpUBq1xgNvYHgZBbQNadbCCVskniCfooomEf0rEZemOXS/hFD
         0mUm7/w4+AVQZsvQycMG6VordRpDZIJ1CVfgQFcgdU64OskJbA67RwpmauffKdoboiFO
         LWAFjF51Bar1Xb2ImWfHkYDm85gy0I0BQ8K56VISJiNUhtfTCXWgqEs3qbOSNnzOOUMk
         ke3g==
X-Gm-Message-State: AO0yUKVNFsYtVDWLXWjd8ZCuBaPm6WIiCl5TEhjoNjrtyuS4XR+qjAtj
        y4rRiAtt794HVBaMvYa2UKs=
X-Google-Smtp-Source: AK7set9VSGT9OVCegHXHz7hvv7WJzGrMgLmFof3LizWBxMiVI+Q8qhqs1X7/TA3/c6KZhSy8EiUx4g==
X-Received: by 2002:a2e:8510:0:b0:295:9ba2:8a78 with SMTP id j16-20020a2e8510000000b002959ba28a78mr3394391lji.17.1678746088803;
        Mon, 13 Mar 2023 15:21:28 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id e19-20020a2e9853000000b002934b5c5c67sm173547ljj.32.2023.03.13.15.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:21:28 -0700 (PDT)
Date:   Tue, 14 Mar 2023 01:21:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 00/11] PCI: dwc: Relatively simple fixes and
 cleanups
Message-ID: <20230313222123.fshj3vvpbpcptyru@mobilestation>
References: <20230313200816.30105-1-Sergey.Semin@baikalelectronics.ru>
 <20230313211752.GA1541360@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313211752.GA1541360@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Bjorn

On Mon, Mar 13, 2023 at 04:17:52PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 13, 2023 at 11:08:04PM +0300, Serge Semin wrote:
> > ...
> > Link: https://lore.kernel.org/linux-pci/20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v2:
> > - Rebase onto the kernel 6.3-rc2.
> 

> This is fine, but just FYI that there's no need to rebase past -rc1
> because PCI patches are applied on topic branches based on the PCI
> "main" branch, typically -rc1.

Thanks for reminding about that. I am not that keen of early rc's
because there is a higher risk to catch instability in unexpected
places. Normally I wait for rc2 or newer kernel is released in order
to rebase onto that mainline kernel. I am using the Linus' master
because most of time I get to develop and submit patchsets for several
subsystems concurrently (currently it's PCIe, EDAC, net and MIPS-arch)
and having them rebased on top of each subsystem' next-branch would be
even more risky. Of course I understand that the subsystem main/topic
branches may have some conflicting changes. So normally I make sure
that the submitted changes are applicable against the subsystem trees
if/when it's necessary. (Can't deny though I forget to do that from
time to time.)

-Serge(y)

> 
> Bjorn
