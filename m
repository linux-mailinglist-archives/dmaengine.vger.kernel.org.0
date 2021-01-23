Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605663013AC
	for <lists+dmaengine@lfdr.de>; Sat, 23 Jan 2021 08:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbhAWHUP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 23 Jan 2021 02:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbhAWHUN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 23 Jan 2021 02:20:13 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FAEC0613D6
        for <dmaengine@vger.kernel.org>; Fri, 22 Jan 2021 23:19:33 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e9so4580022plh.3
        for <dmaengine@vger.kernel.org>; Fri, 22 Jan 2021 23:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RiZZvwwyb49yURnSjcY0X14bt1OOhPEh7Q9ZLRAbppo=;
        b=sfTx+w7Ky5+LoSBCX4toBY4WMmFidBHo6vNYmD2yT3IB/q6R7L0lmk4vRNoMacXrS5
         nYo8EmtLYA3e0K+QhamFclIdZid4uMLXb1hI2PvBfQnPhtl9Iy8CezuWSXeZbolfb6Rh
         7sENDnvBnlu9iFlDLdnxtAm043puL67MYHsUR1+W1BDwZFWvG4cDKg+7qDHLcnwqeCCS
         tcnvmE8kfrvTzyL3vWlxs0aNDJRdKPJY9mGYLB3DGXAV52vMA+6SHaKDNo1HcRspIFkv
         njQlfItLHMyWhgacE7sWzKgqYiWhbi+WuVcQsGgNGVCDxQRLu+ylyeMG5norNR0bgc5G
         3a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RiZZvwwyb49yURnSjcY0X14bt1OOhPEh7Q9ZLRAbppo=;
        b=lT/N5BQr5HpMjuXQF9LiG6scs2ZESqi5jppdjGh75XPM1YAnhjkCfttY1nOylQrzRO
         kJhY77aBzcAd94TgI7H7Aoz4x3DzZpj2wk8L3vbK3/rsx9Gb3yKOHnXsmxhtIwNgSfV1
         t0l1Q9mGs5Mz1D/oP/enHwrPm2Tv6lOK8prGzN3q/Yk1PVCzVSTHqgdoI/1QzR4KFIoD
         ViiyWxtzAD0gNyt67O8+Z/io8V8Wwe9tSSpUQ5XJXYLxBcZ4wX4b+SBfUydHEq/SHodj
         VSn/sj6nbyxMEgLY0aHSM7XKd+9mgxpTID5gy4lKt+onbmS3XBAuK5H96fR+x83TYKtg
         eQwg==
X-Gm-Message-State: AOAM531cBQ5uPForelaCsL/V7VinIQs6M8s7X5u6ET9Co+Z39E8whjab
        BJQTXcPUPUjeoNEHWDEACMSDRg==
X-Google-Smtp-Source: ABdhPJzRf4OR0O4j4MVOHVNlecGUVQ8m3Ufn11l8XPw3WRtQKtG0P34UJ9Vel+HMs5aKNSjKy7Dmdg==
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id w22-20020a1709027b96b02900de7ae6b8dbmr8914440pll.0.1611386372534;
        Fri, 22 Jan 2021 23:19:32 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id b7sm10607315pff.96.2021.01.22.23.19.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jan 2021 23:19:31 -0800 (PST)
Date:   Sat, 23 Jan 2021 15:19:25 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, vkoul@kernel.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: dma: qcom: bam_dma: Manage clocks when
 controlled_remotely is set
Message-ID: <20210123071924.GF2479@dragon>
References: <20210122025251.3501362-1-thara.gopinath@linaro.org>
 <20210122051013.GE2479@dragon>
 <d1f1724c-39f1-7b6e-8cd4-638a44608d9c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f1724c-39f1-7b6e-8cd4-638a44608d9c@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 22, 2021 at 10:44:09AM -0500, Thara Gopinath wrote:
> Hi Shawn,
> 
> Thanks for the review
> 
> On 1/22/21 12:10 AM, Shawn Guo wrote:
> > On Thu, Jan 21, 2021 at 09:52:51PM -0500, Thara Gopinath wrote:
> > > When bam dma is "controlled remotely", thus far clocks were not controlled
> > > from the Linux. In this scenario, Linux was disabling runtime pm in bam dma
> > > driver and not doing any clock management in suspend/resume hooks.
> > > 
> > > With introduction of crypto engine bam dma, the clock is a rpmh resource
> > > that can be controlled from both Linux and TZ/remote side.  Now bam dma
> > > clock is getting enabled during probe even though the bam dma can be
> > > "controlled remotely". But due to clocks not being handled properly,
> > > bam_suspend generates a unbalanced clk_unprepare warning during system
> > > suspend.
> > > 
> > > To fix the above issue and to enable proper clock-management, this patch
> > > enables runtim-pm and handles bam dma clocks in suspend/resume hooks if
> > > the clock node is present irrespective of controlled_remotely property.
> > 
> > Shouldn't the following probe code need some update?  Now we have both
> > controlled_remotely and clocks handle for cryptobam node.  For example,
> > if devm_clk_get() returns -EPROBE_DEFER, we do not want to continue with
> > bamclk forcing to be NULL, right?
> 
> We still will have to set bdev->bamclk to NULL in certain scenarios. For eg
> slimbus bam dma is controlled-remotely and the clocks are handled by the
> remote s/w. Linux does not handle the clocks at all and  there is no clock
> specified in the dt node.This is the norm for the devices that are also
> controlled by remote s/w. Crypto bam dma is a special case where the clock
> is actually a rpmh resource and hence can be independently handled from both
> remote side and Linux by voting. In this case, the dma is controlled
> remotely but clock can be turned off and on in Linux. Hence the need for
> this patch.

So is it correct to say that clock is mandatory for !controlled-remotely
BAM, while it's optional for controlled-remotely one.  If yes, maybe we
can do something like below to make the code a bit easier to read?

	if (controlled-remotely)
		bdev->bamclk = devm_clk_get_optional();
	else
		bdev->bamclk = devm_clk_get();
		
> Yes, the probe code needs updating to handle -EPROBE_DEFER (esp if the clock
> driver is built in as a module) I am not sure if the clock framework handles
> -EPROBE_DEFER properly either. So that
> might need updating too. This is a separate activity and not part of this
> patch.

As the patch breaks the assumption that for controlled-remotely BAM
there is no clock to be managed, the probe code becomes buggy right
away.

Shawn
