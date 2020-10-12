Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20B28AE10
	for <lists+dmaengine@lfdr.de>; Mon, 12 Oct 2020 08:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgJLGJV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Oct 2020 02:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgJLGJV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Oct 2020 02:09:21 -0400
Received: from localhost (unknown [122.182.245.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BDB920757;
        Mon, 12 Oct 2020 06:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602482961;
        bh=GPU8CP6xKnWURBquscB890UF3K7DVSENbbTjU0EOU3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prFNN/Lgyqvvw6oyH5tHsdNyhvz7J9fnspEpav3BNtPSmXWEHte305llkJ9+etXiM
         2Zvxj4RuV2Vc2NenmjoWKYzrHqTVnxkWVhxw/itvpB+3ymUqEHmZrdEcQkX6oU8+VR
         1Gai7wI58vNqj1NZZm/xU2I3LEScUvfdsyQb0lLk=
Date:   Mon, 12 Oct 2020 11:39:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dmaengine: add peripheral configuration
Message-ID: <20201012060916.GI2968@vkoul-mobl>
References: <20201008123151.764238-1-vkoul@kernel.org>
 <20201008123151.764238-3-vkoul@kernel.org>
 <e2c0323b-4f41-1926-5930-c63624fe1dd1@ti.com>
 <20201009103019.GD2968@vkoul-mobl>
 <a44af464-7d13-1254-54dd-f7783ccfaa0f@ti.com>
 <20201009111515.GF2968@vkoul-mobl>
 <13fdee71-5060-83fc-d69d-8ec73f82fac4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13fdee71-5060-83fc-d69d-8ec73f82fac4@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-10-20, 14:29, Peter Ujfalusi wrote:
> 
> 
> On 09/10/2020 14.15, Vinod Koul wrote:
> >>> If for any any reason subsequent txn is for different direction, I would
> >>> expect that parameters are set again before prep_ calls
> >>
> >> But in DEV_TO_DEV?
> > 
> > Do we support that :D
> > 
> >> If we have two peripherals, both needs config:
> >> p1_config and p2_config
> >>
> >> What and how would one use the single peripheral_config?
> > 
> > Since the config is implementation specific, I do not think it limits.
> > You may create
> > 
> > struct peter_config {
> >         struct p1_config;
> >         struct p2_config;
> > };
> 
> The use case is:
> MEM -DMA-> P1 -DMA-> P2
> or
> P2 -DMA-> P1 -DMA-> MEM
> or
> MEM -DMA-> P2
> or
> P2 -DMA-> MEM
> or
> MEM -DMA-> P1 -DMA-> MEM
> 
> How would the DMA guess what it should do? How would the independent P1
> and P2 would know how to set up the config?

As I said, we do not support DEV_TO_DEV yet :)

Question is how would p1<-->p2 look, will p1 initiate a DMA txn or p2..?
who will configure these..

Do you have a real world example in horizon...

-- 
~Vinod
