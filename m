Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E981CDF01
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEKP3l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 11:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbgEKP3l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 May 2020 11:29:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05942C061A0C
        for <dmaengine@vger.kernel.org>; Mon, 11 May 2020 08:29:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f6so4723856pgm.1
        for <dmaengine@vger.kernel.org>; Mon, 11 May 2020 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=y/V0wcoxC/Yk3CV9Ny72KgJNadmz9KFuZ61yQV7Ioak=;
        b=o+le0p8g5d/nvE3pzywPAZJpoIzOEmlpxN4Sow/q0VQ0QPFnUNKO3GCJZXABsT8kiu
         45bmA1W0/PY04u/CF5DEvBlWWogZwMOD+4v5iRBJZxWW61zr5u7/t/aibMPEj0TI7Y5J
         MGAKDOtUi35Rip0Z0Jqi5oRQBPX0mI5Ewpgiw0l6+cb72hGVJa2QS6+y8ddjJNz/UPdh
         w9h/1eSZ7tN5++f87W+3DrlTwG7T2KKvA55KeE+piTOrAib+leIymvWshHf0bYTXWfEK
         6y6v8OFu1YoRueD1I2O8XHyGDEmvGPtohynwLNxLB/9TX+HCMwUn1+A4nBQXWX4ynnps
         WtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y/V0wcoxC/Yk3CV9Ny72KgJNadmz9KFuZ61yQV7Ioak=;
        b=CM2bI8ey4OyrEgW1sWZE2lr/Ru2bRPDRJ6pkjzcDUSqNrx2eyvtVOfCtz54jJdaHC+
         DPPublVimj3ZQ/XQP1Y6NKQ3GAuz0u/zv+FD/p/C1omMAOdh1yHrfA9IfNtiUgjvaXql
         J8MKA0vWz2R5m8o80JSdxwLLfGVTatbFThpy2PRJyxiX0tow5Stbc6UA5NUlnhwHMupe
         4fnNAAshaQ1EsU6jjK21nBmJ/y31iiZXMBsMUXM0EU5vm8r/YHQSoXKGzgEqkw26Qbpd
         NI+Fz9ndHjuj4W1p0xl/6wqCvrycgPlarOwNk4X6Xq+ODj04GFIcWwvzmvQekRiaBPKf
         2IlQ==
X-Gm-Message-State: AGi0PuaEC6Wrcq/wPOwQ1Ky/utE8zUt8iz3Mvx27QsTkYSBVd0iIDyMT
        rqOngJQbvVaWLIPe6KAoH3Iy
X-Google-Smtp-Source: APiQypLyFwhYqdaWIHUXhMcandw2Ds1EIzw/MYLXIpDgFhOYsgqj0h7AN5YikFI6HeX1TtAh5mWmyA==
X-Received: by 2002:a63:dd0e:: with SMTP id t14mr14918193pgg.226.1589210979329;
        Mon, 11 May 2020 08:29:39 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:28b:647d:9464:e66e:7157:1965])
        by smtp.gmail.com with ESMTPSA id g9sm3204412pgh.52.2020.05.11.08.29.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 08:29:38 -0700 (PDT)
Date:   Mon, 11 May 2020 20:59:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Amit Tomer <amittomer25@gmail.com>, vkoul@kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH RFC 1/8] dmaengine: Actions: get rid of bit fields from
 dma descriptor
Message-ID: <20200511152929.GB6865@Mani-XPS-13-9360>
References: <1588761371-9078-1-git-send-email-amittomer25@gmail.com>
 <1588761371-9078-2-git-send-email-amittomer25@gmail.com>
 <20200510155159.GA27924@Mani-XPS-13-9360>
 <CABHD4K_h7wc1gc3wvya1PRTRjMRkDPW==yrAWSk7cCF9ghkUjg@mail.gmail.com>
 <20200511112014.GA3322@Mani-XPS-13-9360>
 <87569683-509e-96e6-17f9-c1734a8b32d4@arm.com>
 <20200511120458.GB3322@Mani-XPS-13-9360>
 <68aa739c-f2fe-a739-f8ed-5683cba90b23@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68aa739c-f2fe-a739-f8ed-5683cba90b23@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 11, 2020 at 01:48:41PM +0100, André Przywara wrote:
> On 11/05/2020 13:04, Manivannan Sadhasivam wrote:
> 
> Hi,
> 
> > On Mon, May 11, 2020 at 12:44:26PM +0100, André Przywara wrote:
> >> On 11/05/2020 12:20, Manivannan Sadhasivam wrote:
> >>
> >> Hi,
> >>
> >>> On Mon, May 11, 2020 at 04:15:57PM +0530, Amit Tomer wrote:
> >>>> Hi
> >>>>
> >>>> Thanks for the reply.
> >>>>
> >>>>> I'm in favor of getting rid of bitfields due to its not so defined way of
> >>>>> working (and forgive me for using it in first place) but I don't quite like
> >>>>> the current approach.
> >>>>
> >>>> Because , its less readable the way we are writing to those different fields ?
> >>>> But this can be made more verbose by adding some comments around .
> >>>>
> >>>
> >>> I don't like the way the hw linked lists are accessed (using an array with
> >>> enums).
> >>
> >> But honestly this is the most sane way of doing this, see below.
> >>
> >>>>> Rather I'd like to have custom bitmasks (S900/S700/S500?) for writing to those
> >>>>> fields.
> >>>>>
> >>>> I think S900 and S500 are same as pointed out by Cristian. and I didn't get by
> >>>> creating custom bitmasks for it ?
> >>>>
> >>>> Did you mean function like:
> >>>>
> >>>> lli->hw[OWL_DMADESC_FLEN]= llc_hw_FLEN(len, FCNT_VALUE, FCNT_SHIFT);
> >>>>
> >>>
> >>> I meant to keep using old struct for accessing the linked list and replacing
> >>> bitfields with masks as below:
> >>>
> >>> struct owl_dma_lli_hw {
> >>> 	...
> >>>         u32     flen;
> >>>         u32     fcnt;
> >>> 	...
> >>> };
> >>
> >> And is think this is the wrong way of modelling hardware defined
> >> register fields. C structs have no guarantee of not introducing padding
> >> in between fields, the only guarantee you get is that the first member
> >> has no padding *before* it:
> >> C standard, section 6.7.2.1, end of paragraph 15:
> >> "There may be unnamed padding within a structure object, but not at its
> >> beginning."
> >>
> >> Arrays in C on the contrary have very much this guarantee: The members
> >> are next to each other, no padding.
> >>
> >> I see that structs are sometimes used in this function, but it's much
> >> less common in the kernel than in other projects (U-Boot comes to mind).
> >> It typically works, because common compiler *implementations* provide
> >> this guarantee, but we should not rely on this.
> >>
> >> So:
> >> Using enums for the keys provides a natural way of increasing indices,
> >> without gaps. Also you get this nice and automatic size value by making
> >> this the last member of the enum.
> >> Arrays provide the guarantee of consecutive allocation.
> >>
> > 
> > I agree with your concerns of using struct for defining registers. But we can
> > safely live with the existing implementation since all fields are u32 and if
> 
> But why, actually? I can understand that this is done in existing code,
> because this was done in the past and apparently never challenged. And
> since it seems to work, at least, there is probably not much reason to
> change it, just for the sake of it.
> But if we need to rework this anyway, we should do the right thing. This
> is especially true in the Linux kernel, which is highly critical and
> privileged code and also aims to be very portable. We should take no
> chances here.
> 

I gave it a spin and I think it makes sense to stick to arrays. I do talk to
a compiler guy internally and he recommended to not trust compilers to do the
right thing for non standard behaviour like this.

> Honestly I don't understand the advantage of using a struct here,
> especially if you need to play some tricks (__packed__) to make it work.
> So why is:
> 	hw->flen
> so much better than
> 	hw[DMA_FLEN]

To be honest this looks ugly to me and that's why I was reluctant. But lets not
worry about it :)

> that it justifies to introduce dodgy code?
> 
> In think in general we should be much more careful when using C language
> constructs to access hardware or hardware defined data structures, and
> be it to not give people the wrong idea about this.
> I think with the advance of more optimising compilers (and, somewhat
> related, more out-of-order CPUs) the chance of breakage becomes much
> higher here.
> 

Only way it can go wrong is, if a nasty compiler adds padding eventhough the
struct is homogeneous. And yeah, let's be on the safe side.

Sorry for stretching this so long!

Thanks,
Mani

> Cheers,
> Andre.
> 
> > needed we can also add '__packed' flag to it to avoid padding for any cases.
> > 
> > The reason why I prefer to stick to this is, this is a hardware linked list and
> > by defining it as an array and accessing the fields using enums looks awful to
> > me. Other than that there is no real justification to shy away.
> > 
> > When you are modelling a plain register bank (which we are also doing in this
> > driver), I'd prefer to use the defines directly.
> > 
> >> We can surely have a look at the masking problem, but this would need to
> >> be runtime determined masks, which tend to become "wordy". There can be
> >> simplifications, for instance I couldn't find where the frame length is
> >> really limited for the S900 (it must be less than 1MB). Since the S700
> >> supports *more* than that, there is no need to limit this differently.
> > 
> > I was just giving an example of how to handle the bitmasks for different
> > SoCs if needed. So yeah if it can be avoided, feel free to drop it.
> > 
> > Thanks,
> > Mani
> > 
> >>
> >> Cheers,
> >> Andre.
> >>
> >>
> >>>
> >>> hw->flen = len & OWL_S900_DMA_FLEN_MASK;
> >>> hw->fcnt = 1 & OWL_S900_DMA_FCNT_MASK;
> >>>
> >>> Then you can use different masks for S700/S900 based on the compatible.
> >>>
> >>> Thanks,
> >>> Mani
> >>>
> >>>> Thanks
> >>>> -Amit
> >>
> 
