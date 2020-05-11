Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9971CD948
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgEKMFH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 08:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727019AbgEKMFH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 May 2020 08:05:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501C3C061A0C
        for <dmaengine@vger.kernel.org>; Mon, 11 May 2020 05:05:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h12so7349709pjz.1
        for <dmaengine@vger.kernel.org>; Mon, 11 May 2020 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sjMFDdzqoNT+Naq9xj8UYhZ5lsrML++iqrUgDzgeiyM=;
        b=Bk4/X/KvmnRxk7QBnw2YKwzYK3Xsi4NFpkiAaQlw2danAx7mgGkSV8QbT2/jVlSj2o
         ewwUEOwgcoPSvsdyrjMQkRSQlmtzYz2yEwKQIuyYcwNI3M+zOI+xB9US7zA47OEGuN9j
         p9c4Znk0iyqVSX22SfzxCrimPr9JSsBN3dAlTcjCeHQqnYSlezeh622BL3ppU0MUNeXU
         kwmz9+vZNmgakRVbV3M2lvS1l2XVAyAr4t12wIOrsSOCWdkbGRCfK7wKqOSLOIrPD4XM
         hNZk7kogqQByKfXHHbsZ4+lXf1De+rgQdcTv9XlsdSGOamvmPVBh1Vd8OpOq9VdHUX/O
         pXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sjMFDdzqoNT+Naq9xj8UYhZ5lsrML++iqrUgDzgeiyM=;
        b=OLWTSqIVAw39M8yKCMR2l479Z8D3htZNsjLPeJPMHpX/0btj8PctycNIU5nUOUmMNb
         wgGELAVIAfdecSQ6cxmL7Xe+JhpvoZSLUmyJICM9YK6hsRqm66f26qvcsbNCND0nYLUx
         vUXunglL0PqppVshp7/HgLDXEZbkcpEW5VpON92EhwK0B/mLuXuvncQ799O5RlHbKu4v
         Y7OPQQMVzUWhiwxYlbihJh9/zuXiDQUj74DBoJ+cpWyAk7TZiUyaS94lf20QB+UEUtv2
         rdrrK2icHGpgsTsaBPJcyxSaOEr6JmPwg13XNcJPNAfHPoiRDzbaTGlQY6uoO6fH8HMb
         Genw==
X-Gm-Message-State: AGi0PuZrUv0Y+1o7GT9/JzD/v4A5WHsLlDcIdW1srAFeg3Aja1GeQ/P0
        mCZ9x7E/JKNj1+v3VLj+fofk
X-Google-Smtp-Source: APiQypJen5c1uXINi2G4YgDD8yneG/m9c0hzml6Du7AQ77Y6AAXhEHiZjqtAaV+L/m77H2OQG4DZUA==
X-Received: by 2002:a17:90a:c702:: with SMTP id o2mr21889591pjt.196.1589198706525;
        Mon, 11 May 2020 05:05:06 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id m12sm7933086pgj.46.2020.05.11.05.05.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 05:05:05 -0700 (PDT)
Date:   Mon, 11 May 2020 17:34:58 +0530
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
Message-ID: <20200511120458.GB3322@Mani-XPS-13-9360>
References: <1588761371-9078-1-git-send-email-amittomer25@gmail.com>
 <1588761371-9078-2-git-send-email-amittomer25@gmail.com>
 <20200510155159.GA27924@Mani-XPS-13-9360>
 <CABHD4K_h7wc1gc3wvya1PRTRjMRkDPW==yrAWSk7cCF9ghkUjg@mail.gmail.com>
 <20200511112014.GA3322@Mani-XPS-13-9360>
 <87569683-509e-96e6-17f9-c1734a8b32d4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87569683-509e-96e6-17f9-c1734a8b32d4@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 11, 2020 at 12:44:26PM +0100, André Przywara wrote:
> On 11/05/2020 12:20, Manivannan Sadhasivam wrote:
> 
> Hi,
> 
> > On Mon, May 11, 2020 at 04:15:57PM +0530, Amit Tomer wrote:
> >> Hi
> >>
> >> Thanks for the reply.
> >>
> >>> I'm in favor of getting rid of bitfields due to its not so defined way of
> >>> working (and forgive me for using it in first place) but I don't quite like
> >>> the current approach.
> >>
> >> Because , its less readable the way we are writing to those different fields ?
> >> But this can be made more verbose by adding some comments around .
> >>
> > 
> > I don't like the way the hw linked lists are accessed (using an array with
> > enums).
> 
> But honestly this is the most sane way of doing this, see below.
> 
> >>> Rather I'd like to have custom bitmasks (S900/S700/S500?) for writing to those
> >>> fields.
> >>>
> >> I think S900 and S500 are same as pointed out by Cristian. and I didn't get by
> >> creating custom bitmasks for it ?
> >>
> >> Did you mean function like:
> >>
> >> lli->hw[OWL_DMADESC_FLEN]= llc_hw_FLEN(len, FCNT_VALUE, FCNT_SHIFT);
> >>
> > 
> > I meant to keep using old struct for accessing the linked list and replacing
> > bitfields with masks as below:
> > 
> > struct owl_dma_lli_hw {
> > 	...
> >         u32     flen;
> >         u32     fcnt;
> > 	...
> > };
> 
> And is think this is the wrong way of modelling hardware defined
> register fields. C structs have no guarantee of not introducing padding
> in between fields, the only guarantee you get is that the first member
> has no padding *before* it:
> C standard, section 6.7.2.1, end of paragraph 15:
> "There may be unnamed padding within a structure object, but not at its
> beginning."
> 
> Arrays in C on the contrary have very much this guarantee: The members
> are next to each other, no padding.
> 
> I see that structs are sometimes used in this function, but it's much
> less common in the kernel than in other projects (U-Boot comes to mind).
> It typically works, because common compiler *implementations* provide
> this guarantee, but we should not rely on this.
> 
> So:
> Using enums for the keys provides a natural way of increasing indices,
> without gaps. Also you get this nice and automatic size value by making
> this the last member of the enum.
> Arrays provide the guarantee of consecutive allocation.
> 

I agree with your concerns of using struct for defining registers. But we can
safely live with the existing implementation since all fields are u32 and if
needed we can also add '__packed' flag to it to avoid padding for any cases.

The reason why I prefer to stick to this is, this is a hardware linked list and
by defining it as an array and accessing the fields using enums looks awful to
me. Other than that there is no real justification to shy away.

When you are modelling a plain register bank (which we are also doing in this
driver), I'd prefer to use the defines directly.

> We can surely have a look at the masking problem, but this would need to
> be runtime determined masks, which tend to become "wordy". There can be
> simplifications, for instance I couldn't find where the frame length is
> really limited for the S900 (it must be less than 1MB). Since the S700
> supports *more* than that, there is no need to limit this differently.

I was just giving an example of how to handle the bitmasks for different
SoCs if needed. So yeah if it can be avoided, feel free to drop it.

Thanks,
Mani

> 
> Cheers,
> Andre.
> 
> 
> > 
> > hw->flen = len & OWL_S900_DMA_FLEN_MASK;
> > hw->fcnt = 1 & OWL_S900_DMA_FCNT_MASK;
> > 
> > Then you can use different masks for S700/S900 based on the compatible.
> > 
> > Thanks,
> > Mani
> > 
> >> Thanks
> >> -Amit
> 
