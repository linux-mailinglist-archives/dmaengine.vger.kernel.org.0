Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303DA251B4B
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHYOvj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 10:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgHYOvg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 10:51:36 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8342075F;
        Tue, 25 Aug 2020 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598367095;
        bh=AUllHjwye2TIaljSNACL7VBXEIh69WdMA3ahzf153ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PK5uSW+BTKDzTjXEUvGROPruPWyCN+UX0s7aKo0087o6tw39xkTTyG41NJNZR3AP/
         GE1JD2VZ3aeOJUJnPf7Xb5rO6jhlMLaGBWcBD4/3oIwsIa9tlE4NIOu24cvTotv/Fp
         IL95pYyZrtSdJRjncevKEr84ykN4r9gVYL2gJQC8=
Date:   Tue, 25 Aug 2020 20:21:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Document qcom,gpi dma binding
Message-ID: <20200825145131.GS2639@vkoul-mobl>
References: <20200824084712.2526079-1-vkoul@kernel.org>
 <20200824084712.2526079-2-vkoul@kernel.org>
 <20200824174009.GA2948650@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824174009.GA2948650@bogus>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hey Rob,

On 24-08-20, 11:40, Rob Herring wrote:
> On Mon, 24 Aug 2020 14:17:10 +0530, Vinod Koul wrote:
> > Add devicetree binding documentation for GPI DMA controller
> > implemented on Qualcomm SoCs
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  .../devicetree/bindings/dma/qcom-gpi.yaml     | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/qcom-gpi.yaml
> > 
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,ev-factor: {'description': 'Event ring transfer size compare to channel transfer ring. Event ring length = ev-factor * transfer ring size', 'maxItems': 1} is not valid under any of the given schemas (Possible causes of the failure):
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,ev-factor: 'not' is a required property

Okay updating dt-schema I do see this, now the question is what is this
and what does it mean ;-) I am not sure I comprehend the error message.
I see this for all the new properties I added as required for this
device node

> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,gpii-mask: {'description': 'Bitmap of supported GPII instances for OS', 'maxItems': 1} is not valid under any of the given schemas (Possible causes of the failure):
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,gpii-mask: 'not' is a required property
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,max-num-gpii: {'description': 'Maximum number of GPII instances available', 'maxItems': 1} is not valid under any of the given schemas (Possible causes of the failure):
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,max-num-gpii: 'not' is a required property
> 
> ./Documentation/devicetree/bindings/dma/qcom-gpi.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/dma/qcom-gpi.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: ignoring, error in schema: properties: qcom,max-num-gpii
> warning: no schema found in file: ./Documentation/devicetree/bindings/dma/qcom-gpi.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.example.dt.yaml: example-0: dma@800000:reg:0: [0, 8388608, 0, 393216] is too long
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> 
> 
> See https://patchwork.ozlabs.org/patch/1350170
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.

-- 
~Vinod
