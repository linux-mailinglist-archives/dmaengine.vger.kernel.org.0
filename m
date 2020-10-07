Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E88285E18
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 13:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgJGL2M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 07:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbgJGL2M (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 07:28:12 -0400
Received: from localhost (unknown [122.171.222.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA29206F7;
        Wed,  7 Oct 2020 11:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602070091;
        bh=kY5VsQub9YBuVn954F0Hvvtht7ZySDXQRDsJceie9iM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dyt9iTFp03B8OwcY9z0GcHlfMNqCME8N04SBzD7esK8Pm2JFale4d/4z2ph/5yT9C
         t80gyqdDHIz8cu62TOX2P5E5rRtJ6TKuBckoqsqUtPmRgOcnau30z5pFvCWTfnyj5V
         jMaDPW9bG1EXTIGpYGxNRii5J8OlE3SOtaC6KdKU=
Date:   Wed, 7 Oct 2020 16:58:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dmaengine: add peripheral configuration
Message-ID: <20201007112807.GW2968@vkoul-mobl>
References: <20200923063410.3431917-1-vkoul@kernel.org>
 <20200923063410.3431917-3-vkoul@kernel.org>
 <29f95fff-c484-0131-d1fe-b06e3000fb9f@ti.com>
 <20201001112307.GX2968@vkoul-mobl>
 <f063ae03-41da-480a-19ba-d061e140e4d2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f063ae03-41da-480a-19ba-d061e140e4d2@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 02-10-20, 11:48, Peter Ujfalusi wrote:

> It depends which is best for the use case.
> I see the metadata useful when you need to send different
> metadata/configuration with each transfer.
> It can be also useful when you need it seldom, but for your use case and
> setup the dma_slave_config extended with
> 
> enum dmaengine_peripheral peripheral_type;
> void *peripheral_config;
> 
> would be a bit more explicit.
> 
> I would then deal with the peripheral config in this way:
> when the DMA driver's device_config is called, I would take the
> parameters and set a flag that the config needs to be processed as it
> has changed.
> In the next prep_slave_sg() then I would prepare the TREs with the
> config and clear the flag that the next transfer does not need the
> configuration anymore.
> 
> In this way each dmaengine_slave_config() will trigger at the next
> prep_slave_sg time configuration update for the peripheral to be
> included in the TREs.
> The set_config would be internal to the DMA driver, clients just need to
> update the configuration when they need to and everything is taken care of.

Ok I am going to drop the dmaengine_peripheral and make
peripheral_config as as you proposed.

So will add following to dma_slave_config:
        void *peripheral_config;

Driver can define the config they would like and use.

We can eventually look at common implementations and try to unify once
we have more users

-- 
~Vinod
