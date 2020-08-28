Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE72558CB
	for <lists+dmaengine@lfdr.de>; Fri, 28 Aug 2020 12:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgH1Kpg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 06:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbgH1Kpe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Aug 2020 06:45:34 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E182086A;
        Fri, 28 Aug 2020 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598611534;
        bh=Mj6pnTtOgpW6WTp2OmSmvZZOeKX/ycJ1cI+2QoSaZkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFbAQnf21V11OONhiZhgt+ZnkfAGtGOIscqDMUFXnwgqwV5jyHYjs10NX8XD9OS73
         yjOvrQFmJL/MKPl++7cLoO5cL6oeDyAw+g5yjrClmMTYWGDPbfGNIueIkus9JkM+vi
         n5iQzSrjRlRJHcD28/MwuCJ9q9pnuYeyfux9XZzk=
Date:   Fri, 28 Aug 2020 16:15:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, chuanhua.lei@linux.intel.com,
        malliamireddy009@gmail.com
Subject: Re: [PATCH v5 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Message-ID: <20200828104530.GT2639@vkoul-mobl>
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <68c77fd2ffb477aa4a52a58f8a26bfb191d3c5d1.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <20200814203222.GA2674896@bogus>
 <7cdc0587-8b4f-4360-a303-1541c9ad57b2@linux.intel.com>
 <20200825112107.GN2639@vkoul-mobl>
 <ffa5ba4d-f1b2-6a30-f2f1-f4578a77bce2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa5ba4d-f1b2-6a30-f2f1-f4578a77bce2@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-08-20, 17:54, Reddy, MallikarjunaX wrote:
> Hi Vinod,
> Thanks for the review comments.
> 
> On 8/25/2020 7:21 PM, Vinod Koul wrote:
> > On 18-08-20, 15:00, Reddy, MallikarjunaX wrote:
> > 
> > > > > +
> > > > > +            intel,chans:
> > > > > +              $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > +              description:
> > > > > +                 The channels included on this port. Format is channel start
> > > > > +                 number and how many channels on this port.
> > > > Why does this need to be in DT? This all seems like it can be in the dma
> > > > cells for each client.
> > > (*ABC)
> > > Yes. We need this.
> > > for dma0(lgm-cdma) old SOC supports 16 channels and the new SOC supports 22
> > > channels. and the logical channel mapping for the peripherals also differ
> > > b/w old and new SOCs.
> > > 
> > > Because of this hardware limitation we are trying to configure the total
> > > channels and port-channel mapping dynamically from device tree.
> > > 
> > > based on port name we are trying to configure the default values for
> > > different peripherals(ports).
> > > Example: burst length is not same for all ports, so using port name to do
> > > default configurations.
> > Sorry that does not make sense to me, why not specify the values to be
> > used here instead of defining your own name scheme!
> OK. Agreed. I will remove port name from DT and only use intel,chans

what is intel,chans, why not use dma-channels?

-- 
~Vinod
