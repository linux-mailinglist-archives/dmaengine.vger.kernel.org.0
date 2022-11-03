Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538DC617710
	for <lists+dmaengine@lfdr.de>; Thu,  3 Nov 2022 08:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKCHCK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Nov 2022 03:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKCHCI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Nov 2022 03:02:08 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CDC63AF;
        Thu,  3 Nov 2022 00:02:05 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BEB39E0002;
        Thu,  3 Nov 2022 07:02:01 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1oqUEi-0085pf-In; Thu, 03 Nov 2022 08:02:00 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <m.tretter@pengutronix.de>, <harini.katakam@amd.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: Re: [PATCH] dt-bindings: dmaengine: zynqmp_dma: add xlnx,bus-width
 required property
References: <1667448757-7001-1-git-send-email-radhey.shyam.pandey@amd.com>
Date:   Thu, 03 Nov 2022 08:02:00 +0100
In-Reply-To: <1667448757-7001-1-git-send-email-radhey.shyam.pandey@amd.com>
        (Radhey Shyam Pandey's message of "Thu, 3 Nov 2022 09:42:37 +0530")
Message-ID: <87fsf0r05z.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

>>>>> "Radhey" == Radhey Shyam Pandey <radhey.shyam.pandey@amd.com> writes:

 > xlnx,bus-width is a required property. In yaml conversion somehow
 > it got missed out. Bring it back and mention it in required list.
 > Also add Harini and myself to the maintainer list.

 > Fixes: 5a04982df8da ("dt-bindings: dmaengine: zynqmp_dma: convert to yaml")
 > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 > ---
 >  .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml    | 3 +++
 >  1 file changed, 3 insertions(+)

 > diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
 > index c0a1408b12ec..a10019d3a650 100644
 > --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
 > +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
 > @@ -13,6 +13,8 @@ description: |
 
 >  maintainers:
 >    - Michael Tretter <m.tretter@pengutronix.de>
 > +  - Harini Katakam <harini.katakam@amd.com>
 > +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

That should ideally be in a separate patch.


 >  allOf:
 >    - $ref: "../dma-controller.yaml#"
 > @@ -65,6 +67,7 @@ required:
 >    - interrupts
 >    - clocks
 >    - clock-names
 > +  - xlnx,bus-width

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
