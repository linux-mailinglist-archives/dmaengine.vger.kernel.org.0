Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049A6F8817
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2019 06:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfKLFhS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 00:37:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfKLFhS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Nov 2019 00:37:18 -0500
Received: from localhost (unknown [122.167.70.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54CF02084F;
        Tue, 12 Nov 2019 05:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573537038;
        bh=DY28ZU9iJjrpae4knOfkZebu2FgGI1JEdHocfirJtGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ne9ss+MVsI/j6Y/+Q5x3RMKfDe5np4vko2s3/+2sXfpBN/jAr0RvQO6Rl0Hs4lq17
         2lnc6rDPlVkKSU6bH+s7oJKE4rM3Ley2L1M4JT76AOC5cA1fnUZ5roRpINGLiRcrVh
         5Xkpl6VeEXsVQiRXSXd+XGAnKlWysyWckSPyS0KI=
Date:   Tue, 12 Nov 2019 11:07:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 15/15] dmaengine: ti: k3-udma: Add glue layer for non
 DMAengine users
Message-ID: <20191112053714.GX952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-16-peter.ujfalusi@ti.com>
 <20191111061258.GS952516@vkoul-mobl>
 <6d4d2fcc-502b-4b41-cd71-8942741f4ad8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4d2fcc-502b-4b41-cd71-8942741f4ad8@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-11-19, 12:31, Peter Ujfalusi wrote:
> 
> 
> On 11/11/2019 8.12, Vinod Koul wrote:
> > On 01-11-19, 10:41, Peter Ujfalusi wrote:
> >> From: Grygorii Strashko <grygorii.strashko@ti.com>
> >>
> >> Certain users can not use right now the DMAengine API due to missing
> >> features in the core. Prime example is Networking.
> >>
> >> These users can use the glue layer interface to avoid misuse of DMAengine
> >> API and when the core gains the needed features they can be converted to
> >> use generic API.
> > 
> > Can you add some notes on what all features does this layer implement..
> 
> In the commit message or in the code?

commit here so that we know what to expect.

Thanks
-- 
~Vinod
