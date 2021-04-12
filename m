Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5243E35C5F2
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 14:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhDLMNW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 08:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237718AbhDLMNW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 08:13:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB10D601FF;
        Mon, 12 Apr 2021 12:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618229584;
        bh=sPXdhp1BnSWVMDKRXYxutnJfciTviwx1HjPYiqsyHSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvFibIxPxSe/3KW3rCboOplB2HJXHgwlQ8bry4ea0BM/NJGkt8eCD1evmM4V+NShy
         X2eC3F6ZbBlqW/OVn1gmPEz7O/Fgmi1Z/6m8BO1I/vOWEEK99oe/qKpGf8JW/N/NyU
         JLprW6b7sTjhdtkMxnhqc447vdt6ylH3R8tXqn851oD+dFRduwJHuXAQL1GpDjw5BH
         +H/7k9vqVllD1KV7+DimKYtTwHG3L+DCntb/EBtf0ZBBIJTaokhliAUiTgITOot5mA
         P8UmqUuP9dBeJLpWvNWmUKT26wPRqvapZC4yssB3jzDj14FlgPstOxauUGTyzyGBuW
         ZJyD0M1oLGlWA==
Date:   Mon, 12 Apr 2021 17:43:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shivank Garg <shivankgarg98@gmail.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: Doubts regarding DMAEngine
Message-ID: <YHQ5TFI4ooQO3U6J@vkoul-mobl.Dlink>
References: <CAOVCmzERZYznODQnVQaoxV-y5b6byYy9b4araY=kWghyat71dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOVCmzERZYznODQnVQaoxV-y5b6byYy9b4araY=kWghyat71dg@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Shivank,

On 02-04-21, 16:07, Shivank Garg wrote:
> Hi Everyone,

Always CC maintainers, scripts/get_maintainer.pl is your friend, use
it

> I'm a kernel newbie and M.Tech student at IIT Kanpur, India. I'm
> researching DMA and DMAEngine for my thesis. I want to thank the
> community for the dmatest.c program, It has helped me very much to get
> an idea about using DMA api and writing a custom kernel module with
> it. I'm stuck with the following doubts:
> 1. How to find which DMAEngine controller my Linux system is using. I
> read about I/OAT by intel and I guess this is the one my system is
> using, But I can't get it from my hardware or Linux kernel. I also
> want to know about my DMAEngine Controller specifications, like number
> of channels, bandwidth, latency etc.

/sys/class/dma/ would tell you the dmaengine channels available on a
system

> 2. Is DMA channel a software abstraction? How is it actually related
> to DMA hardware? Are multiple DMA channels multiplexed to some single
> entity. Also, if it's software abstraction, why can I only request a
> maximum of 16 DMA channels on my machine?
> Earlier I thought using multiple DMA channels would be like using a
> multi-lane highway which would be very fast, but My experiments on
> using multiple DMA channels simultaneously actually worsen the
> performance (compared with single DMA channel)

In theory things like dmaengine virtual channels are backed by hardware
channels. Now most of the implementations use 1:1 mapping b/w virtual
channels and hardware, it need not be so

> 3. I read Efficient Asynchronous Memory Copy Operations on Multi-Core
> Systems and I/OAT by K. Vaidyanathan, which helped me a lot. But still
> some of my above questions remain uncleared.
> 
> Also, a general doubt, to what extent the DMAEngine controller is
> utilized? I mean I observed the DMA is used for high-speed network
> packet copying in servers, and various applications ( like memory
> devices, video devices) propose to use the DMAEngine, Do we have
> enough DMA resources to fulfill everyone's needs?

That depends on the system. Typically system designers would try to
provide for intended usages on a system. Also TI has some fancy hardware
implementation - UDMA, you should look at that also as part of your
research (drivers/dma/ti/k3-udma.c)

-- 
~Vinod
