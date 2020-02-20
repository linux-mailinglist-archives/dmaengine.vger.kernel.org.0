Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277FC1654AB
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2020 02:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBTBqJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Feb 2020 20:46:09 -0500
Received: from mx.socionext.com ([202.248.49.38]:33097 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgBTBqJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Feb 2020 20:46:09 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Feb 2020 10:46:07 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 4F39418008C;
        Thu, 20 Feb 2020 10:46:07 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 20 Feb 2020 10:46:07 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 27FAC40376;
        Thu, 20 Feb 2020 10:46:07 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id EC1FE12047F;
        Thu, 20 Feb 2020 10:46:06 +0900 (JST)
Date:   Thu, 20 Feb 2020 10:46:07 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: dmaengine: Add UniPhier external DMA controller bindings
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20200219135344.GA15319@bogus>
References: <1582077141-16793-2-git-send-email-hayashi.kunihiko@socionext.com> <20200219135344.GA15319@bogus>
Message-Id: <20200220104606.53AA.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,
Thanks for pointing out.

On Wed, 19 Feb 2020 07:53:44 -0600 <robh@kernel.org> wrote:

> On Wed, 19 Feb 2020 10:52:20 +0900, Kunihiko Hayashi wrote:
> > Add devicetree binding documentation for external DMA controller
> > implemented on Socionext UniPhier SOCs.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../bindings/dma/socionext,uniphier-xdmac.yaml     | 63 ++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml: Additional properties are not allowed ('additinalProperties' was unexpected)
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml: Additional properties are not allowed ('additinalProperties' was unexpected)
> Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.example.dts] Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1240464
> Please check and re-submit.

Something was missing the string by mistake.
I'll resubmit it.

Thank you,

---
Best Regards,
Kunihiko Hayashi

