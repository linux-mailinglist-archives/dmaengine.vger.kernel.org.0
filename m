Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88BB13590D
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jan 2020 13:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgAIMUq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jan 2020 07:20:46 -0500
Received: from mx.socionext.com ([202.248.49.38]:22845 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbgAIMUp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 9 Jan 2020 07:20:45 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Jan 2020 21:20:44 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 345DE180093;
        Thu,  9 Jan 2020 21:20:44 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 9 Jan 2020 21:21:34 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id EB0AE1A01CF;
        Thu,  9 Jan 2020 21:20:43 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id B48FF120456;
        Thu,  9 Jan 2020 21:20:43 +0900 (JST)
Date:   Thu, 09 Jan 2020 21:20:43 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add UniPhier external DMA controller bindings
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20200108035537.GA7843@bogus>
References: <1576630620-1977-2-git-send-email-hayashi.kunihiko@socionext.com> <20200108035537.GA7843@bogus>
Message-Id: <20200109212043.5800.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,
Thank you for your comment.

On Tue, 7 Jan 2020 21:55:37 -0600 <robh@kernel.org> wrote:

> On Wed, Dec 18, 2019 at 09:56:59AM +0900, Kunihiko Hayashi wrote:
> > Add external DMA controller bindings implemented in Socionext UniPhier
> > SoCs.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../devicetree/bindings/dma/uniphier-xdmac.txt     | 86 ++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-xdmac.txt
> 
> Please make this a DT schema. See 
> Documentation/devicetree/writing-schema.rst.

Although I'm not familiar with this format, I'll try to make it.

> > 
> > diff --git a/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt b/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt
> > new file mode 100644
> > index 00000000..4e3927f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt
> > @@ -0,0 +1,86 @@
> > +Socionext UniPhier external DMA controller bindings
> > +
> > +This describes the devicetree bindings for an external DMA engine to perform
> > +memory-to-memory or peripheral-to-memory data transfer, implemented in
> > +Socionext UniPhier SoCs.
> > +
> > +* DMA controller
> > +
> > +Required properties:
> > +- compatible: Should be "socionext,uniphier-xdmac".
> > +- reg: Specifies offset and length of the register set for the device.
> > +- interrupts: An interrupt specifier associated with the DMA controller.
> > +- #dma-cells: Must be <2>. The first cell represents the channel index.
> > +	The second cell represents the factor for transfer request.
> > +	This is mentioned in DMA client section.
> > +- dma-channels : Number of DMA channels supported. Should be 16.
> 
> If always 16, then why do you need this?

Oh, currently this means 16 or less, though, this is the number supported
by the controller. I'll fix it.

> 
> > +
> > +Example:
> > +	xdmac: dma-controller@5fc10000 {
> > +		compatible = "socionext,uniphier-xdmac";
> > +		reg = <0x5fc10000 0x1000>, <0x5fc20000 0x800>;
> > +		interrupts = <0 188 4>;
> > +		#dma-cells = <2>;
> > +		dma-channels = <16>;
> > +	};
> > +
> > +* DMA client
> > +
> > +Required properties:
> > +- dmas: A list of DMA channel requests.
> > +- dma-names: Names of the requested channels corresponding to dmas.
> > +
> > +DMA clients must use the format described in the dma.txt file, using a two cell
> > +specifier for each channel.
> 
> No need to redefine the client binding here. Just need the cell format 
> as below.

I see. I'll replace with the cell format.

Thank you,

---
Best Regards,
Kunihiko Hayashi

