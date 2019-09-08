Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF9AACC8F
	for <lists+dmaengine@lfdr.de>; Sun,  8 Sep 2019 14:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfIHMMJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 8 Sep 2019 08:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfIHMMJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 8 Sep 2019 08:12:09 -0400
Received: from localhost (unknown [122.182.221.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4146320863;
        Sun,  8 Sep 2019 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567944728;
        bh=UmeDjAzR6/3LB9jjoTbqWWv9lFExcVwjpss84j0OuUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCditvPD0UQC6dVxIKH3ICuj3ZIA1Dy+Dle+f8rL1WQecFnEwS/c5Tvxeg8OHPjZJ
         /v8+4LCoekmWFchXedhGGwXcdlR2c74fCa51qg6FqmzK2y/yPDRa4llpTfXpBBVT/T
         kt8JpNhlZRuyb4HwSLIkwv/ZJO3qm7JX/kDhX+J4=
Date:   Sun, 8 Sep 2019 17:40:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC 1/3] dt-bindings: dma: Add documentation for DMA domains
Message-ID: <20190908121058.GL2672@vkoul-mobl>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-2-peter.ujfalusi@ti.com>
 <961d30ea-d707-1120-7ecf-f51c11c41891@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961d30ea-d707-1120-7ecf-f51c11c41891@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-09-19, 10:47, Peter Ujfalusi wrote:
> 
> 
> On 06/09/2019 17.18, Peter Ujfalusi wrote:
> > On systems where multiple DMA controllers available, none Slave (for example
> > memcpy operation) users can not be described in DT as there is no device
> > involved from the DMA controller's point of view, DMA binding is not usable.
> > However in these systems still a peripheral might need to be serviced by or
> > it is better to serviced by specific DMA controller.
> > When a memcpy is used to/from a memory mapped region for example a DMA in the
> > same domain can perform better.
> > For generic software modules doing mem 2 mem operations it also matter that
> > they will get a channel from a controller which is faster in DDR to DDR mode
> > rather then from the first controller happen to be loaded.
> > 
> > This property is inherited, so it may be specified in a device node or in any
> > of its parent nodes.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> >  .../devicetree/bindings/dma/dma-domain.yaml   | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/dma-domain.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/dma-domain.yaml b/Documentation/devicetree/bindings/dma/dma-domain.yaml
> > new file mode 100644
> > index 000000000000..c2f182f30081
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/dma-domain.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/dma-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DMA Domain Controller Definition
> > +
> > +maintainers:
> > +  - Vinod Koul <vkoul@kernel.org>
> > +
> > +allOf:
> > +  - $ref: "dma-controller.yaml#"
> > +
> > +description:
> > +  On systems where multiple DMA controllers available, none Slave (for example
> > +  memcpy operation) users can not be described in DT as there is no device
> > +  involved from the DMA controller's point of view, DMA binding is not usable.
> > +  However in these systems still a peripheral might need to be serviced by or
> > +  it is better to serviced by specific DMA controller.
> > +  When a memcpy is used to/from a memory mapped region for example a DMA in the
> > +  same domain can perform better.
> > +  For generic software modules doing mem 2 mem operations it also matter that
> > +  they will get a channel from a controller which is faster in DDR to DDR mode
> > +  rather then from the first controller happen to be loaded.
> > +
> > +  This property is inherited, so it may be specified in a device node or in any
> > +  of its parent nodes.
> > +
> > +properties:
> > +  $dma-domain-controller:
> 
> or domain-dma-controller?

I feel dma-domain-controller sounds fine as we are defining domains for
dmaengine. Another thought which comes here is that why not extend this to
slave as well and define dma-domain-controller for them as use that for
filtering, that is what we really need along with slave id in case a
specific channel is to be used by a peripheral

Thoughts..?

-- 
~Vinod
