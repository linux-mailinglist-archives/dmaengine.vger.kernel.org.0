Return-Path: <dmaengine+bounces-6189-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96311B33224
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 20:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2E5189C8AE
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DDA2264B1;
	Sun, 24 Aug 2025 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQmXM6r1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1289521348;
	Sun, 24 Aug 2025 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756061752; cv=none; b=ty5aZeeLdpWkDpYdZ8u9S4RTyqc289FFrn5YVKEz0f5Apo8bTTnoxk9mLSNWmfxrt45ABD13vh3PZNl+qSeVPwNs3OtTFPiYVg5r4nUVcMLwXNz6qFIxKCGdES9w7kd+BT3a2ObkiSco9wR3IEll3QU1T4Y8QlCAHNvxARze+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756061752; c=relaxed/simple;
	bh=4HjsNwikn//1Eie5/vp3A/jazIOCs3yKbqZNtKgz4Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUaBwKQT+63Un4SCJOJK6C3D/KPMAZ9gB02xzoiWxkVvw/j2WBqNGs8QWVlngj8j455UYlknrDWOqixuERDnTmisWYMBUNHMvstZH7G3ppOoYzmWgeiTlzw25gjYk0dyY4Y8HEHxCgxCO8C0IxO2z1g5YBL0oLrSW4gM7CnYk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQmXM6r1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3258cdb7253so591512a91.3;
        Sun, 24 Aug 2025 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756061750; x=1756666550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWs0v2otzFcbzvrVOGXWRjThPGmVpPPk0clc6P2+rw4=;
        b=lQmXM6r16l2DcHtNuMJLSv75JvtWGSAuRrfUtFRNU7Z1DdFbN2EMgwtByElYZKg1d6
         j0O3n/uWSxUW3l8ec7j4xBoYzTCoT1gqtiBMBBoBp+JK4KOW3TRcannPEJ/fPWALCppC
         tCNZT0M7ajYhKuQZyr4dcUtxJKfgqVwNKxkrCqs2Bs0To6XbbmFBFn919znkD8ifaMV5
         uBQ3su/C1kpYfrFMmOe0/CZLFeTjDRRQyHRJTPRkJPE+HqwpyID0RvEnmWm0F6kqh5n/
         ny3ov02D34czbGxxoY44qpviPGpaKIG2VM5WI/MsKUJUgxTXl9mZVlOnU+H1ldYfXQcs
         BQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756061750; x=1756666550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWs0v2otzFcbzvrVOGXWRjThPGmVpPPk0clc6P2+rw4=;
        b=o74dM6C8cqqqdAKr7fJAvnN03pCpBiN5URREez1PtkjO+VetO6V4xP9sav2CvcDZiD
         X1hukYmD6N96QRJT2N4ZfhRIzglQbZv4Ya54ir+BShyTu1AtRIG3LegyHdbI2svUW5aG
         3BHqWae09BtwXhCsM0xFFPVb7gBeexmhr5fHFFrt74vWPB8B/D1nFQG3Q3/En/pFHZee
         6FVM6rgA0YENmqLcrFqO0x6B/dcJlOu8O1DinOuxOmJK8pQfBmZ7hEHxf3w+pcWn5/3K
         YHyZs8L1H/UCp6UK4P6NPzGWpZVUcBuG9iGPCOXcRSff1d+e8X1XKnxU6OG6yHYwQyby
         FPMw==
X-Forwarded-Encrypted: i=1; AJvYcCUSw03ZhsB7SCSPxjdsrO8qS9BRnsksYfdUUM6pwKcr2djvEAq6KmSC1BVLgHY+14SRBJXk360K7BH5qCbk@vger.kernel.org, AJvYcCVKXGI+XJus9qcjL294CjvCM1ZvVPHDMgMHvxFzyxiYEJfg4PRfTwSDxuSrCG+odCc2PTUip2dyunRjfw==@vger.kernel.org, AJvYcCVVBoBF/v/CIFl7uoPnjyP9UGZrZTRatRVyb+rrNXb3HJAfkiKo9UiFVAPatDzdA6FjKIXL/Ft0KQ6v@vger.kernel.org, AJvYcCWqbaZktnt5oFvsBMoGMicym3Mv38ecskEEE7u6l6zmjYw2f7dUDHkU6IjyrzyKWB9RhzY3ORPbwG6S@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPXzNFwnJMmxbcIkHAcvHQ7FP9MF47tLyrrGCgZW7VvWRz/do
	MSIQWzYlEzzq0d7lwqTSwP6kMQQ8N7jyujr8HLBTrpfddcy9KynxcIQQiKzp6zs7
X-Gm-Gg: ASbGnctFOP6HfNKqDXsvGA92JpgCt5urNbaqJOr59mXAmWHUS/2jZtFGWib75hJpj91
	GPcxfWFpTrlCJMZB980rLsSLm86p4wrp+jWVQ7VMZQdu2YJyso+GcZsw4o45CHt0kQMrD4oXuMM
	SSflVKDWDh2JC6HaZJeE91om+Mv5lzcE5IPNrP3Ngz9D7xLCSbPHOT0KIgdoSWVJRW9v/rpWdr6
	cWFBNCVNq0VElYWQoV8d+calWf4/rkOlnBz9kd19ZR4u99j9+c17Km9hXKJmX9bBaRlSgbb1t/g
	jBoEh3/7a4M7MqhazAMXjwzzf6Byvuai+61A6aLLG2vfh1s20qPP/EhTpEUi/FIeetGO0e7HFNc
	e6wwIjMX2LuHIHCVRlrVFSGV83sTIYXZHoo08XukmykQsYx8tFCWDKw==
X-Google-Smtp-Source: AGHT+IF9WHofD+oJxZR80LSsb7nKzQISul/qFgnftipP5rSxU7VTb+9bsOmFNZ/kfwXRoDPFZPrVJg==
X-Received: by 2002:a17:903:1a08:b0:246:cfc5:1b61 with SMTP id d9443c01a7336-246cfc51d45mr12560475ad.55.1756061750154;
        Sun, 24 Aug 2025 11:55:50 -0700 (PDT)
Received: from 100ask.localdomain ([116.234.74.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa650b2sm5098509a91.24.2025.08.24.11.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 11:55:49 -0700 (PDT)
From: Nino Zhang <ninozhang001@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	rahulbedarkar89@gmail.com,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: img-mdc-dma: convert to DT schema
Date: Mon, 25 Aug 2025 02:55:43 +0800
Message-ID: <20250824185543.475785-1-ninozhang001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822195024.GA194990-robh@kernel.org>
References: <20250822195024.GA194990-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 14:50:24 -0500 Rob Herring wrote:
> > Convert the img-mdc-dma binding from txt to YAML schema.
> > No functional changes except dropping the consumer node
> > (spi@18100f00) from the example, which belongs to the
> > consumer binding instead.
> > 
> > Tested with 'make dt_binding_check'.
> 
> No need to say that in the commit msg. It is assumed you did this.
> 
> > 
> > Signed-off-by: Nino Zhang <ninozhang001@gmail.com>
> > ---
> >  .../devicetree/bindings/dma/img-mdc-dma.txt   | 57 -----------
> >  .../devicetree/bindings/dma/img-mdc-dma.yaml  | 98 +++++++++++++++++++
> >  2 files changed, 98 insertions(+), 57 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/dma/img-mdc-dma.txt
> >  create mode 100644 Documentation/devicetree/bindings/dma/img-mdc-dma.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/img-mdc-dma.txt b/Documentation/devicetree/bindings/dma/img-mdc-dma.txt
> > deleted file mode 100644
> > index 28c1341db346..000000000000
> > --- a/Documentation/devicetree/bindings/dma/img-mdc-dma.txt
> > +++ /dev/null
> > @@ -1,57 +0,0 @@
> > -* IMG Multi-threaded DMA Controller (MDC)
> > -
> > -Required properties:
> > -- compatible: Must be "img,pistachio-mdc-dma".
> > -- reg: Must contain the base address and length of the MDC registers.
> > -- interrupts: Must contain all the per-channel DMA interrupts.
> > -- clocks: Must contain an entry for each entry in clock-names.
> > -  See ../clock/clock-bindings.txt for details.
> > -- clock-names: Must include the following entries:
> > -  - sys: MDC system interface clock.
> > -- img,cr-periph: Must contain a phandle to the peripheral control syscon
> > -  node which contains the DMA request to channel mapping registers.
> > -- img,max-burst-multiplier: Must be the maximum supported burst size multiplier.
> > -  The maximum burst size is this value multiplied by the hardware-reported bus
> > -  width.
> > -- #dma-cells: Must be 3:
> > -  - The first cell is the peripheral's DMA request line.
> > -  - The second cell is a bitmap specifying to which channels the DMA request
> > -    line may be mapped (i.e. bit N set indicates channel N is usable).
> > -  - The third cell is the thread ID to be used by the channel.
> > -
> > -Optional properties:
> > -- dma-channels: Number of supported DMA channels, up to 32.  If not specified
> > -  the number reported by the hardware is used.
> > -
> > -Example:
> > -
> > -mdc: dma-controller@18143000 {
> > -	compatible = "img,pistachio-mdc-dma";
> > -	reg = <0x18143000 0x1000>;
> > -	interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>,
> > -		     <GIC_SHARED 28 IRQ_TYPE_LEVEL_HIGH>,
> > -		     <GIC_SHARED 29 IRQ_TYPE_LEVEL_HIGH>,
> > -		     <GIC_SHARED 30 IRQ_TYPE_LEVEL_HIGH>,
> > -		     <GIC_SHARED 31 IRQ_TYPE_LEVEL_HIGH>,
> > -		     <GIC_SHARED 32 IRQ_TYPE_LEVEL_HIGH>,
> > -		     <GIC_SHARED 33 IRQ_TYPE_LEVEL_HIGH>,
> > -		     <GIC_SHARED 34 IRQ_TYPE_LEVEL_HIGH>,
> > -		     <GIC_SHARED 35 IRQ_TYPE_LEVEL_HIGH>,
> > -		     <GIC_SHARED 36 IRQ_TYPE_LEVEL_HIGH>,
> > -		     <GIC_SHARED 37 IRQ_TYPE_LEVEL_HIGH>,
> > -		     <GIC_SHARED 38 IRQ_TYPE_LEVEL_HIGH>;
> > -	clocks = <&system_clk>;
> > -	clock-names = "sys";
> > -
> > -	img,max-burst-multiplier = <16>;
> > -	img,cr-periph = <&cr_periph>;
> > -
> > -	#dma-cells = <3>;
> > -};
> > -
> > -spi@18100f00 {
> > -	...
> > -	dmas = <&mdc 9 0xffffffff 0>, <&mdc 10 0xffffffff 0>;
> > -	dma-names = "tx", "rx";
> > -	...
> > -};
> > diff --git a/Documentation/devicetree/bindings/dma/img-mdc-dma.yaml b/Documentation/devicetree/bindings/dma/img-mdc-dma.yaml
> > new file mode 100644
> > index 000000000000..b635125d7ae3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/img-mdc-dma.yaml
> 
> Use the compatible string for the filename.
> 
> > @@ -0,0 +1,98 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/img-mdc-dma.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: IMG Multi-threaded DMA Controller (MDC)
> > +
> > +maintainers:
> > +  - Vinod Koul <vkoul@kernel.org>
> 
> No, must be someone with this h/w and cares about this h/w.
> 
> > +
> > +allOf:
> > +  - $ref: /schemas/dma/dma-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    description: Must be "img,pistachio-mdc-dma".
> 
> Drop. The schema says that. Same goes for all the other descriptions, so 
> I won't repeat it everywhere.
> 
> > +    const: img,pistachio-mdc-dma
> > +
> > +  reg:
> > +    description:
> > +      Must contain the base address and length of the MDC registers.
> 
> Drop.
> 
> > +    minItems: 1
> 
> maxItems instead.
> 
> > +
> > +  interrupts:
> > +    description:
> > +      Must contain all the per-channel DMA interrupts.
> 
> Must define how many.
> 
> > +
> > +  clocks:
> > +    description: |
> > +      Must contain an entry for each entry in clock-names.
> > +      See clock/clock.yaml for details.
> 
> Drop.
> 
> Must define how many clocks and what they are.
> 
> > +
> > +  clock-names:
> > +    description: |
> > +      Must include the following entries:
> > +        - sys: MDC system interface clock.
> 
> Drop. The schema says that.
> 
> > +    minItems: 1
> > +    contains: { const: sys }
> 
> Must be exact list of values, not 'sys' plus anything else you want.
> 
> > +
> > +  img,cr-periph:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: |
> 
> Drop '|'. Not needed if no formatting to maintain.
> 
> 
> > +      Must contain a phandle to the peripheral control syscon node
> > +      which contains the DMA request to channel mapping registers.
> > +
> > +  img,max-burst-multiplier:
> > +    description: |
> > +      Must be the maximum supported burst size multiplier.
> > +      The maximum burst size is this value multiplied by the
> > +      hardware-reported bus width.
> 
> Wrap lines at 80 and drop '|'.
> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> constraints?
> 
> > +
> > +  "#dma-cells":
> > +    description: |
> > +      Must be 3:
> > +        - The first cell is the peripheral's DMA request line.
> > +        - The second cell is a bitmap specifying to which channels the DMA request
> > +          line may be mapped (i.e. bit N set indicates channel N is usable).
> > +        - The third cell is the thread ID to be used by the channel.
> > +    const: 3
> > +
> > +  dma-channels:
> > +    description: |
> > +      Number of supported DMA channels, up to 32. If not specified
> > +      the number reported by the hardware is used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Drop. Already has a type defined.
> 
> > +    maximum: 32
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - "img,cr-periph"
> > +  - "img,max-burst-multiplier"
> 
> Don't need quotes.
> 
> > +  - "#dma-cells"
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/mips-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    mdc: dma-controller@18143000 {
> 
> Drop 'mdc'
> 
> > +      compatible = "img,pistachio-mdc-dma";
> > +      reg = <0x18143000 0x1000>;
> > +      interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>,
> > +            <GIC_SHARED 28 IRQ_TYPE_LEVEL_HIGH>;
> > +      clocks = <&system_clk>;
> > +      clock-names = "sys";
> > +
> > +      img,max-burst-multiplier = <16>;
> > +      img,cr-periph = <&cr_periph>;
> > +
> > +      #dma-cells = <3>;
> > +    };
> > -- 
> > 2.43.0
> > 

Hi Rob, Krzysztof,

Thanks for your detailed reviews and guidance. As requested, I went back to the previous posting and responded to each comment below. This summarizes what was fixed in v2 and what I will address in v3.

---

> > Tested with 'make dt_binding_check'.
> 
> No need to say that in the commit msg. It is assumed you did this.

Fixed in v2. Dropped from commit message.

---

> > +++ b/Documentation/devicetree/bindings/dma/img-mdc-dma.yaml
> 
> Use the compatible string for the filename.
Fixed in v2.

---

> > +maintainers:
> > +  - Vinod Koul <vkoul@kernel.org>
>
> No, must be someone with this h/w and cares about this h/w.

Fixed in v2. Changed to Rahul Bedarkar (Pistachio DT maintainer) + linux-mips list.
Andrew Bresticker (original author) seems inactive. I updated to Rahul Bedarkar, who maintains the Pistachio/CI40 DT (which uses this controller), and added linux-mips list so the platform community is notified.

---

> > +  compatible:
> > +    description: Must be "img,pistachio-mdc-dma".
>
> Drop. The schema says that. Same goes for all the other descriptions, so
> I won't repeat it everywhere.

Fixed in v2. Dropped redundant descriptions.

---

> > +  reg:
> > +    description:
> > +      Must contain the base address and length of the MDC registers.
>
> Drop.

Fixed in v2. Dropped redundant description.

---

> > +    minItems: 1
> >
> maxItems instead.

Fixed in v2. Changed to `maxItems: 1`.

---

> > +  interrupts:
> > +    description:
> > +      Must contain all the per-channel DMA interrupts.
> >
> Must define how many.

Fixed in v2. Defined `minItems: 1`, `maxItems: 32`.
This matches the hardware max channels (DMA supports up to 32).
The original txt said "all per-channel interrupts", so schema now enforces that.

---

> > +  clocks:
> > +    description: |
> > +      Must contain an entry for each entry in clock-names.
> > +      See clock/clock.yaml for details.
>
> Drop.
>
> Must define how many clocks and what they are.

Fixed in v2. Set `clocks: maxItems: 1`.

---

> > +  clock-names:
> > +    description: |
> > +      Must include the following entries:
> > +        - sys: MDC system interface clock.
>
> Drop. The schema says that.

Fixed in v2. Dropped description.

---

> > +    minItems: 1
> > +    contains: { const: sys }
>
> Must be exact list of values, not 'sys' plus anything else you want.

Fixed in v2. Restricted to `sys`.

---

> > +  img,cr-periph:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: |
>
> Drop '|'. Not needed if no formatting to maintain.

Ack. I mistakenly switched to `>` in v2. Will drop the indicator in v3.

---

> > +  img,max-burst-multiplier:
> > +    description: |
> > +      Must be the maximum supported burst size multiplier.
> > +      The maximum burst size is this value multiplied by the
> > +      hardware-reported bus width.
>
> Wrap lines at 80 and drop '|'.

Ack. Will fix in v3.

---

> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> constraints?

Fixed in v2. Kept as uint32 with `minimum: 1` to exclude invalid 0. Actual maximum not confirmed in available docs.  
Example uses 16; I will add `maximum` once platform maintainers confirm.

---

> > +  dma-channels:
> > +    description: |
> > +      Number of supported DMA channels, up to 32. If not specified
> > +      the number reported by the hardware is used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> Drop. Already has a type defined.

Ack. Will fix in v3.

---

> > +required:
> > +  - "img,cr-periph"
> > +  - "img,max-burst-multiplier"
>
> Don't need quotes.

Fixed in v2. Removed quotes.

---

> > +examples:
> > +    mdc: dma-controller@18143000 {
>
> Drop 'mdc'

Fixed in v2. Dropped node label.

---

Please let me know if there are any further concerns. Otherwise, I will send [PATCH v3] shortly as a new thread with the remaining fixes.

Thanks,
Nino

