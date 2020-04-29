Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC71BD8E9
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2020 11:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgD2J6O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 05:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgD2J6O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Apr 2020 05:58:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E1C03C1AE
        for <dmaengine@vger.kernel.org>; Wed, 29 Apr 2020 02:58:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so672420plr.3
        for <dmaengine@vger.kernel.org>; Wed, 29 Apr 2020 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kQWwU0V3P2cG9Df5CLi5Aes1IF7DF82n54z1tZA0tj8=;
        b=cQvDE5r8qFSkTrzZ4i81Gzp9dqP8ohUksJfLHUOBX+Po2pmMP1o2x1SSUZbwTC8ztO
         zpFtzt+mwbM1zrcinR/taemda/w0yc07a72tRJ+6+0IqETkEPswX0PzdXQJA5MSkyDmy
         bKGwQYt2bvw3qkOGUhOoR/WrST1Z0rVWR0Ba7OvU/32/ioUNtW8tLcJLNx7kKr4R5fq9
         xr7H/GbrVerDj9h4NkOjjmltmQnAiuozN55x/j7xKkGcazgitsrOdRcgn6qX+AmsxrKA
         bba2c5CNuwCwg+sVjBVP/Qb3NEU0bcRuttgfKRjy1jPmEEYaWLyGS5n2r52Mc3UZ4Gwv
         K/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kQWwU0V3P2cG9Df5CLi5Aes1IF7DF82n54z1tZA0tj8=;
        b=iFJbODCqmzzoSxsaATANtXJfed+BNmMQcRman2ETZ2DCNY2IRSZk2CCHLZwMpdZ3O9
         je2Mr2Bjne2LKb0/+5gVwQ9KLGgTg2LuwCTTwSIDdsxswh8ZJMiuJAGCBOE93UPciJDE
         804Q09dn1V+AFa4bJ1TD3DbgySrxXMCiTu3nIycDeDQux4LLIPgXxLd/xAm0/BiSbEg0
         Knrh8mjT7xslLJkHiBAUgHHFLN4CDaMdS5oLZAtR6EVl74Js0zWGGkt4jGrfRcabUyPw
         EaVPcxKdcZYqnJ7L+8N/EawWSfkKf9k6EUkH6U3TglDS6vRVb0XeDSDdah/jVLYmapIw
         OQaQ==
X-Gm-Message-State: AGi0PuZVaqCspDr95hJuGKKDQlf1P1qWCEMsyI38c3JjrMe3KkeUBc1J
        oGBE8UpJpDskhYXboxzBdKoy
X-Google-Smtp-Source: APiQypJq9Vv8kOy3qRauSuH1fn2l54cguipwDjEbc1fxWc9BOiY6PCKS0U4dHaO2yA/f4lXw0vFZ9A==
X-Received: by 2002:a17:90a:d085:: with SMTP id k5mr2279937pju.91.1588154293427;
        Wed, 29 Apr 2020 02:58:13 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6114:a3cc:cde9:1262:3f57:5dd])
        by smtp.gmail.com with ESMTPSA id f99sm4493906pjg.22.2020.04.29.02.58.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 02:58:12 -0700 (PDT)
Date:   Wed, 29 Apr 2020 15:28:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH 1/1] dma: actions: Fix lockdep splat for owl-dma
Message-ID: <20200429095802.GB6443@Mani-XPS-13-9360>
References: <7d503c3dcac2b3ef29d4122a74eacfce142a8f98.1588069418.git.cristian.ciocaltea@gmail.com>
 <20200428164921.GC5259@Mani-XPS-13-9360>
 <20200428181115.GB26885@BV030612LT>
 <20200428181803.GD5259@Mani-XPS-13-9360>
 <a70a2352-7b22-6b85-848b-94d9ee17c022@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a70a2352-7b22-6b85-848b-94d9ee17c022@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andreas,

On Wed, Apr 29, 2020 at 10:36:01AM +0200, Andreas Färber wrote:
> Am 28.04.20 um 20:18 schrieb Manivannan Sadhasivam:
> > On Tue, Apr 28, 2020 at 09:11:15PM +0300, Cristian Ciocaltea wrote:
> > > On Tue, Apr 28, 2020 at 10:19:21PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Apr 28, 2020 at 01:56:12PM +0300, Cristian Ciocaltea wrote:
> > > > > When the kernel is build with lockdep support and the owl-dma driver is
> > > > > used, the following message is shown:
> [...]
> > > > > The required fix is to use spin_lock_init() on the pchan lock before
> > > > > attempting to call any spin_lock_irqsave() in owl_dma_get_pchan().
> > > > 
> > > > Right, this is a bug. But while looking at the code now, I feel that we don't
> > > > need 'pchan->lock'. The idea was to protect 'pchan->vchan', but I think
> > > > 'od->lock' is the better candidate for that since it already protects it in
> > > > 'owl_dma_terminate_pchan'.
> > > > 
> > > > So I'd be happy if you remove the lock from 'pchan' and just directly use the
> > > > one in 'od'.
> > > > 
> > > > Out of curiosity, on which platform you're testing this?
> > > 
> > > Totally agree, I will send a new patch revision as soon as I do some
> > > more testing.
> > 
> > Coo[l], thanks!
> > 
> > > I'm currently experimenting on an Actions S500 based board (Roseapple Pi)
> > > trying to extend, if possible, the existing mainline support for those
> > > SoCs.
> > 
> > Awesome! It's great to see that Actions platform is seeing some attention
> > these days :)
> > 
> > > I don't have much progress so far, since I started quite recently
> > > and I also lack experience in the kernel development area, but I do my
> > > best to come back with more patches once I get a consistent functionality.
> > 
> > No worries. Feel free to reach out to me if you have any questions. There is
> > a lot of work to do and for sure it will be a good learning curve.
> > 
> > We do have an IRC channel (##linux-actions) for quick discussions. Fee[l] free
> > to join!
> 
> Please also CC the linux-actions mailing list on any patches:
> 
> https://lists.infradead.org/mailman/listinfo/linux-actions
> 
> Mani, do you have a 5.7-rc1 tree set up or should I queue patches this
> round?

I haven't set up the branch. You can do the maintainership duties for this
cycle.

> It still seems missing in MAINTAINERS, and then there's Matheus'
> patches in review.
> 

Yeah, the MAINTAINERS patch has fallen through cracks:

[PATCH v2 6/6] MAINTAINERS: Add linux-actions mailing list for Actions Semi

I did this as a part of S500 clk series. Feel free to pick it up.

Thanks,
Mani

> Thanks,
> Andreas
> 
> -- 
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer
> HRB 36809 (AG Nürnberg)
