Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA0B709490
	for <lists+dmaengine@lfdr.de>; Fri, 19 May 2023 12:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjESKPX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 May 2023 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjESKPT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 May 2023 06:15:19 -0400
X-Greylist: delayed 89342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 May 2023 03:15:16 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02018D;
        Fri, 19 May 2023 03:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684491314; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iANyA4lM6//5dQkWecMxgml5rXURe/0ELdSy8UYp6WJrO8FonNjnXxWfnyd4LTzAs+
    Ux03ynJwpzKjMJ408uB37wjU0zAC4zXaOhj4fuN/795f2ezl+cQ+FMo+811GLK3Vd/UO
    YlPg/GwYFqIunknSdBuwJR8ODITVYm23oysVXro0nqO+t8lT21u03wEVUofoTY6soTX7
    bylf31XYNafH9fmG9znjNwQ15fV8BirNpvK5Nie7IAUs9gNeITHrKt/RfktXojIU2XFv
    y7OYFdytJ82Fe+LlFSAjaLRMd71NT10Nj6cqXPZG5vdHve8gc+96n9+WQxbHmPn9BszJ
    74yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684491314;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=bMaBcHyP5lxITjgi+pD+NP0DTQNJJ5pW1j0FLrg0quI=;
    b=G73tI7MN8s1wJBfCE+HS6Nva7yCzpwT8CeQrf3PildSZoXHKWMPaezcfC9kq8aqDvm
    rfCmQVY2/4PSRRAfKDtkwtzN0igXzPchRJN2uMEPOe56RJz5L8EhHW51ryhMSXlMbMPh
    xjIFJP0q7qaPjG3zIuEDN7BSkx5giN73ezVo6ctsExZxOUefyEe4Gf7uHN+KDYwqAk7o
    xEQxvwJnZ+94e9S9Dt3aDpfO4Y68H/M39iSxlgRhyaoiCu8dTMAqLMDGV8Qvie/VFy8v
    78HYUnHXqnxFi4larOri8lC0YqzA48Ooj4ge8WqevO7rC9anbwc99qcywbRcOKMZ7x/F
    l0fg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684491314;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=bMaBcHyP5lxITjgi+pD+NP0DTQNJJ5pW1j0FLrg0quI=;
    b=nOOuq5T3Q7+IDv8tzciey3NwrRAPEuvQwwoMt6GekNA4alhtNTpj/xsx3fHFSrrS+U
    ukYnizrIAfjBXUhiRC2A+XtU2+E8+zFQI9yxt9NNDzFjGJ5XC2kNJAQwK7LlcQ2YqpAK
    ei8zoQz/4bPKo059UbGJ3oqcGmbkvnvzlzy1b1lNBYm6msR4InYF7NDHum6TgAvOuX4L
    KIrtgm6wWNFIvdDPyoXs7zuHBjQk2QUEExMVf33sfavhZahxT2OFDWnPjsoiivt8LlaM
    eK2omIX09XA2bmTQB6myGm+6xuhPKZxmhQ3VKzpoTKFEZCMVQ7QEI0oE1sn8jw16LIG4
    Kdqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684491314;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=bMaBcHyP5lxITjgi+pD+NP0DTQNJJ5pW1j0FLrg0quI=;
    b=EvXGdjEoEvq2toiY8ete6slwJhuC6Fazz1BmAzUal1DnQ5Pm+7n+Kp69OKXye06eLk
    yQVn5Mk1pcWsfpWxsVCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4JAFEERA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 19 May 2023 12:15:14 +0200 (CEST)
Date:   Fri, 19 May 2023 12:15:13 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: make channels/EEs optional in
 DT with clock
Message-ID: <ZGdMMd3pS7LRjBOU@gerhold.net>
References: <20230518-bamclk-dt-v1-1-82f738c897d9@gerhold.net>
 <CAH=2Ntya7bqHVri_F8BOUJ6kJxtG2_usV08do+=OgkaoVJvxBQ@mail.gmail.com>
 <ZGYKQkgRrBqO2rsx@gerhold.net>
 <CAH=2Ntw0BZH=RGp14mYLhX7D6jV5O5eDKRQbby=uCy85xMDU_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2Ntw0BZH=RGp14mYLhX7D6jV5O5eDKRQbby=uCy85xMDU_g@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 19, 2023 at 02:40:21PM +0530, Bhupesh Sharma wrote:
> On Thu, 18 May 2023 at 16:51, Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > On Thu, May 18, 2023 at 04:43:57PM +0530, Bhupesh Sharma wrote:
> > > On Thu, 18 May 2023 at 14:56, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > >
> > > > If we have a BAM clock in the DT we are able to turn on the BAM
> > > > controller while probing, so there is no need to read "num-channels"
> > > > and "qcom,num-ees" from the DT. It can be read more accurately directly
> > > > from the identification registers of the BAM.
> > > >
> > > > This simplifies setting up typical controlled-remotely BAM DMAs in the
> > > > DT that can be turned on via a clock (e.g. the BLSP DMA).
> > >
> > > Can you please list which qcom board(s) you tested this patch on?
> > >
> >
> > It works fine at least on MSM8916/DB410c (for blsp_dma) and MDM9607
> > (blsp_dma and qpic_dma (for NAND)). More testing would be much
> > appreciated of course!
> 
> I tested this yesterday on RB1/RB2, RB5 and saw no improvement, so was wondering
> why exactly is this needed and which platforms are impacted.
> 

RB1/RB2 should be able to benefit from this for the cryptobam if you add
the rpmcc clock to it, see my reply in [1].

[1]: https://lore.kernel.org/linux-arm-msm/ZGdLCdSof027mk5u@gerhold.net/

> > Personally I don't see much of a risk: If enabling the clock doesn't
> > actually enable the BAM controller, then the clock probably does not
> > belong to the BAM in the first place... :)
> 
> Right, but I think the commit message needs a bit more clarity to
> reflect that it is now proposed to check for the bam_clk presence
> earlier in the _probe flow (as compared to earlier).
> 

Sure, I will try to clarify the commit message a bit in v2.

Thanks,
Stephan
