Return-Path: <dmaengine+bounces-6772-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0129BBC15FF
	for <lists+dmaengine@lfdr.de>; Tue, 07 Oct 2025 14:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AF5189D18B
	for <lists+dmaengine@lfdr.de>; Tue,  7 Oct 2025 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6870F2DF12C;
	Tue,  7 Oct 2025 12:34:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADAC2D94B8;
	Tue,  7 Oct 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840496; cv=none; b=T9/z3eQYs/jN5YT/BaElQwl28uU1Vo0V81jOsdet5q6i5QsqrZ+/tsKC8nw2gOJj97A5FnqFXw1BKAUloq6Pi0vtVZYVZonUeJBo/Al3qvSrBsuQGqKKIl+B1gTzP90aLdc/BXWa1Y/Hy2witlZotLtu4l3LT0tXIsogGLkx+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840496; c=relaxed/simple;
	bh=DWZcXv4LGKuHQYrqbAmttjXhAkTF8/LAO+/rgtkGZWg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKlzAi0Nm9p1mQHsZmzYeuE2uMvWLYvdht+D+MyRfvBv3OxiuMYqo0mBkz1L+1U+hqXYjsjtz0sbofMBIA0+krpz4nykx5qTmI6cw1dwcaSXdfECoZYqhRZc/6e+qrdrYUTMv2k1J4SwETLxgPjKUHkQ9PLnAXJQ6SEsXi0FK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 597CX1bh055627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 20:33:01 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Tue, 7 Oct 2025 20:33:01 +0800
Date: Tue, 7 Oct 2025 20:33:01 +0800
From: CL Wang <cl634@andestech.com>
To: Conor Dooley <conor@kernel.org>
CC: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>, <cl634@andestech.com>
Subject: Re: [PATCH V1 1/2] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Message-ID: <aOUIfaZY7-eUYoOS@swlinux02>
References: <20251002131659.973955-1-cl634@andestech.com>
 <20251002131659.973955-2-cl634@andestech.com>
 <20251002-absolute-spinning-f899e75b2c4a@spud>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002-absolute-spinning-f899e75b2c4a@spud>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 597CX1bh055627

Hi Conor,

Thanks for your review.

Yes, the DMA driver supports the Qilai platform. I have updated the DTS binding as shown below.  
Could you please take a look and let me know if anything still needs to be adjusted?

 properties:
   compatible:
-    const: andestech,atcdmac300
+    oneOf:
+      - items:
+          - enum:
+              - andestech,qilai-dma
+          - const: andestech,atcdmac300
+      - const: andestech,atcdmac300
...
         dma-controller@f0c00000 {
-            compatible = "andestech,atcdmac300";
+            compatible = "andestech,qilai-dma", "andestech,atcdmac300";

Thank you again for your feedback.

Best regards,  
CL

On Thu, Oct 02, 2025 at 07:40:35PM +0100, Conor Dooley wrote:
> [EXTERNAL MAIL]

> Date: Thu, 2 Oct 2025 19:40:35 +0100
> From: Conor Dooley <conor@kernel.org>
> To: CL Wang <cl634@andestech.com>
> Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, robh@kernel.org,
>  krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
>  linux-kernel@vger.kernel.org, tim609@andestech.com
> Subject: Re: [PATCH V1 1/2] dt-bindings: dmaengine: Add support for
>  ATCDMAC300 DMA engine
> 
> On Thu, Oct 02, 2025 at 09:16:58PM +0800, CL Wang wrote:
> > Document devicetree bindings for Andes ATCDMAC300 DMA engine
> > 
> > Signed-off-by: CL Wang <cl634@andestech.com>
> > ---
> >  .../bindings/dma/andestech,atcdmac300.yaml    | 51 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 +++
> >  2 files changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml b/Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml
> > new file mode 100644
> > index 000000000000..769694616517
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/andestech,atcdmac300.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Andes ATCDMAC300 DMA Controller
> > +
> > +maintainers:
> > +  - CL Wang <cl634@andestech.com>
> > +
> > +allOf:
> > +  - $ref: dma-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: andestech,atcdmac300
> 
> "atcdmac300" sounds like the name of an IP block. What platforms are
> actually using this? They should have platform-specific compatibles, for
> example, "andestech,qilai-dma" if that's the platform where this is
> supported.
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#dma-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#dma-cells"
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        dma-controller@f0c00000 {
> > +            compatible = "andestech,atcdmac300";
> > +            reg = <0x0 0xf0c00000 0x0 0x1000>;
> > +            interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
> > +            #dma-cells = <1>;
> > +        };
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fe168477caa4..dd3272cdadd6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1778,6 +1778,12 @@ S:	Supported
> >  F:	drivers/clk/analogbits/*
> >  F:	include/linux/clk/analogbits*
> >  
> > +ANDES DMA DRIVER
> > +M:	CL Wang <cl634@andestech.com>
> > +S:	Supported
> > +F:	Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml
> > +F:	drivers/dma/atcdmac300*
> > +
> >  ANDROID DRIVERS
> >  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >  M:	Arve Hjønnevåg <arve@android.com>
> > -- 
> > 2.34.1
> > 




