Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A341D39E67F
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 20:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFGSZF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 14:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhFGSZD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Jun 2021 14:25:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68A6A61105;
        Mon,  7 Jun 2021 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623090192;
        bh=F0DNX6ITtcI6m/H/+t3QDmlYTYmBnAWD7soN/1G1bsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VG9qnWR3MLjiTJGUVrFvCVxS6Bt73Grqpj11dLWkT12noG2TqiQPKAEqgVYNR95v0
         o05QNEpPz98iW3Ptj9WDy1jspiZl3mMJSUPrm1t16PjH0kENzBOja8MzDnU4XJbZpZ
         q1DYNH4YzTyzGgnvo8MDLx9/c5EDyzhXcKz7YMolFiSLYR1DXwycrIA1Co7GOLYpEc
         ObywgJR/DU4eIzoGZGm9HnrHXr0JkM15aXeQSf4liWTIn/1aFx9FcyNHdgl2OTu6E8
         bB6ncJeM6g6m5QL2B00K6uGYSri0KbfIvHemDmVVqyIO+P9SSVKE15vv0fZzDOGqnH
         Rf9LX3DKktzng==
Date:   Mon, 7 Jun 2021 23:53:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v1 1/1] dmaengine: dw: Program xBAR hardware for Elkhart
 Lake
Message-ID: <YL5kC1gg9vdXb9xz@vkoul-mobl>
References: <20210602085604.21933-1-andriy.shevchenko@linux.intel.com>
 <YL4EYb35GOVYxdQO@vkoul-mobl>
 <YL4RVEIJrSMy+Slf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL4RVEIJrSMy+Slf@smile.fi.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-06-21, 15:30, Andy Shevchenko wrote:
> On Mon, Jun 07, 2021 at 05:04:57PM +0530, Vinod Koul wrote:
> > On 02-06-21, 11:56, Andy Shevchenko wrote:

> > > +	case DMA_DEV_TO_DEV:
> > > +	default:
> > > +		value |= CTL_CH_WR_NON_SNOOP_BIT | CTL_CH_RD_NON_SNOOP_BIT;
> > > +		value |= CTL_CH_TRANSFER_MODE_S2S;
> > > +		break;
> > 
> > aha, how did you test this...
> 
> Not sure what the question is about. You are talking about last two cases
> or the entire switch? Last two weren't tested, just filed for the sake of
> being documented. First two were tested with SPI host controllers.

Last one is Device to device which is not supported by dmaengine and
cannot be tested right now!

-- 
~Vinod
