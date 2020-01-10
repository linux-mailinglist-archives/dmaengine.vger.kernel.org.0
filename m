Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35FA1368C2
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2020 09:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAJIFZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jan 2020 03:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgAJIFZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 Jan 2020 03:05:25 -0500
Received: from localhost (unknown [223.226.110.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD7120678;
        Fri, 10 Jan 2020 08:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578643524;
        bh=ph4YepTwOT/qIeLabnOL4SubJAWhPNmTtBxMU/1k/JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yqo4FMBHCn39WlxEW1VfdmMkBx2GsMBiaRtzFJMxeAKw2mU+TFg5mK1WeMcoHqmHJ
         dUA0ZuEaIDxdXDeeN3L//JM+ftcjdvY0v/6u9LfMx7Kbt1HU5qj9n+UIDm11hZ2oSi
         ck6muWTktwT+Wjtn/i0FpdsxUAiY4bEsuRV2CGJU=
Date:   Fri, 10 Jan 2020 13:35:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/13] dmaengine: tegra-apb: Remove runtime PM usage
Message-ID: <20200110080510.GH2818@vkoul-mobl>
References: <20200106011708.7463-1-digetx@gmail.com>
 <20200106011708.7463-10-digetx@gmail.com>
 <f63a68cf-bb9d-0e79-23f3-233fc97ca6f9@nvidia.com>
 <fd6215ac-a646-4e13-ee22-e815a69cd099@gmail.com>
 <01660250-0489-870a-6f0e-d74c5041e8e3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01660250-0489-870a-6f0e-d74c5041e8e3@nvidia.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-01-20, 18:38, Jon Hunter wrote:
> 
> On 07/01/2020 17:12, Dmitry Osipenko wrote:
> > 07.01.2020 18:13, Jon Hunter пишет:
> >>
> >> On 06/01/2020 01:17, Dmitry Osipenko wrote:
> >>> There is no benefit from runtime PM usage for the APB DMA driver because
> >>> it enables clock at the time of channel's allocation and thus clock stays
> >>> enabled all the time in practice, secondly there is benefit from manually
> >>> disabled clock because hardware auto-gates it during idle by itself.
> >>
> >> This assumes that the channel is allocated during a driver
> >> initialisation. That may not always be the case. I believe audio is one
> >> case where channels are requested at the start of audio playback.
> > 
> > At least serial, I2C, SPI and T20 FUSE are permanently keeping channels
> > allocated, thus audio is an exception here. I don't think that it's
> > practical to assume that there is a real-world use-case where audio
> > driver is the only active DMA client.
> > 
> > The benefits of gating the DMA clock are also dim, do you have any
> > power-consumption numbers that show that it's really worth to care about
> > the clock-gating?
> 
> No, but at the same time, I really don't see the point in this. In fact,
> I think it is a step backwards. If we wanted to only enable clocks while
> DMA channels are active we could. So I request you drop this.

Agree, if pm is working fine with audio, doesnt make much sense to
remove. Future clients or updates to existing clients can be done to
make it dynamic..

-- 
~Vinod
