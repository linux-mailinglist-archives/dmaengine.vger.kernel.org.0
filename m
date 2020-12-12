Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07442D84AD
	for <lists+dmaengine@lfdr.de>; Sat, 12 Dec 2020 06:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgLLFWX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 12 Dec 2020 00:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbgLLFVx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 12 Dec 2020 00:21:53 -0500
Date:   Sat, 12 Dec 2020 10:51:08 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607750472;
        bh=p4pDn+cuf2hqSNVU61KNyvncFgtp+nQKPT6OuE7kHxg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbjnF+XpZToBv/dbSiHbG3ZvQ8YpofvohnOhYjT4azmxUdB5CD6hv+HkZ2jfOcNz/
         OCu9PKs33GxOfsxFVmJfTJi/dn6vNc/lpkK1FzJNyboXA5g7vz26UpeoXWgqIPVINV
         7M6p2D0FJq9Kf2ORtfLhXEN3kgF+f/WXvPbMqUJm5tWEdnApw1RYaaMIkZVjdVwo60
         d/FjM4jEx3YP9YaK1wxg+d6RsL7GLd46Dn3+K//3D+IoWQ5WBeycR5gli6kG3F9I/P
         vaYMpcrcExgJkvcBTjouxfqDyKQ88+SBSc0AmuxH4Phy9uThq/1CjNjH2U4RatkjY7
         N+azFCeMgh9Ew==
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     nm@ti.com, ssantosh@kernel.org, robh+dt@kernel.org,
        dan.j.williams@intel.com, t-kristo@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        vigneshr@ti.com, grygorii.strashko@ti.com
Subject: Re: [PATCH v3 00/20] dmaengine/soc: k3-udma: Add support for BCDMA
 and PKTDMA
Message-ID: <20201212052108.GA8403@vkoul-mobl>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
 <20201211162400.GZ8403@vkoul-mobl>
 <8df78a7a-abc8-e0e3-6b60-a0832be74aa5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df78a7a-abc8-e0e3-6b60-a0832be74aa5@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-12-20, 21:16, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 11/12/2020 18.24, Vinod Koul wrote:
> > On 08-12-20, 11:04, Peter Ujfalusi wrote:
> >> Hi,
> >>
> >> The series have build dependency on ti_sci/soc series (v2):
> >> https://lore.kernel.org/lkml/20201008115224.1591-1-peter.ujfalusi@ti.com/
> >>
> >> Santosh kindly provided immutable branch and tag holding the series:
> >> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.11 
> > 
> > I have picked this and then merged this and pushed to test branch. If
> > everything is okay, it will be next on monday
> 
> Thank you!
> 
> this might cause a sparse warning:
> https://lore.kernel.org/lkml/a1f83b16-c1ce-630e-3410-738b80a92741@ti.com/
> 
> I can send an incremental patch or resend the whole series with this
> correction?

Incremental please

Thanks

-- 
~Vinod
