Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0DC2526DB
	for <lists+dmaengine@lfdr.de>; Wed, 26 Aug 2020 08:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgHZGcw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Aug 2020 02:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgHZGcv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 26 Aug 2020 02:32:51 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2070620707;
        Wed, 26 Aug 2020 06:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598423571;
        bh=tlmi1dXDnwffZjtMmqckGcLrR8NIpwc3mBYPK75NtQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aO+yIuBS6V6tG2ZgXpu76vXf7CjrchXrcfFtHilQ/ixmTi/qAs4uVsF3b+VHxWg4K
         woRVhTPjqkMpI3uM18tj2FXD0PkCDlhdefR9/Spqna3399ooBCwwkS9XflrLCCOzbf
         NdXDFvVMSVUaOe5VuJIpFvNpV9W3NEO4R1oLIacQ=
Date:   Wed, 26 Aug 2020 12:02:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Document qcom,gpi dma binding
Message-ID: <20200826063246.GW2639@vkoul-mobl>
References: <20200824084712.2526079-1-vkoul@kernel.org>
 <20200824084712.2526079-2-vkoul@kernel.org>
 <20200824174009.GA2948650@bogus>
 <20200825145131.GS2639@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825145131.GS2639@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-08-20, 20:21, Vinod Koul wrote:
> Hey Rob,
> 
> On 24-08-20, 11:40, Rob Herring wrote:
> > On Mon, 24 Aug 2020 14:17:10 +0530, Vinod Koul wrote:
> > > Add devicetree binding documentation for GPI DMA controller
> > > implemented on Qualcomm SoCs
> > > 
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  .../devicetree/bindings/dma/qcom-gpi.yaml     | 87 +++++++++++++++++++
> > >  1 file changed, 87 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/dma/qcom-gpi.yaml
> > > 
> > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,ev-factor: {'description': 'Event ring transfer size compare to channel transfer ring. Event ring length = ev-factor * transfer ring size', 'maxItems': 1} is not valid under any of the given schemas (Possible causes of the failure):
> > 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,ev-factor: 'not' is a required property
> 
> Okay updating dt-schema I do see this, now the question is what is this
> and what does it mean ;-) I am not sure I comprehend the error message.
> I see this for all the new properties I added as required for this
> device node

Okay I think I have figured it out, I need to provide ref to
/schemas/types.yaml#definitions/uint32 for this to work, which does
makes sense to me.

  qcom,max-num-gpii:
    $ref: /schemas/types.yaml#definitions/uint32
    maxItems: 1
    description:
      Number of GPII instances

Looks good to schema tool
 
-- 
~Vinod
