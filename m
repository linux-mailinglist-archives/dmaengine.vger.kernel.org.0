Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB83495D8B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jan 2022 11:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379959AbiAUKQf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jan 2022 05:16:35 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:42588 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379950AbiAUKQe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jan 2022 05:16:34 -0500
Received: by mail-ua1-f49.google.com with SMTP id p1so15941880uap.9;
        Fri, 21 Jan 2022 02:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J40sY0C3RdKpNTUqWX9QRsbzyFuUi8J252xN/iv6cgo=;
        b=Oc+/4rtLr1XlEVBtVAprF3HX5NzoaudpFN34hs81cJB7m3glOsbj/gRDZCp4R/je8F
         pZ4Yme6dLBZuE47VL9JJf0oVl0oSYw9aTvX8de1REYabTh7SuzA7yYRb9XewSSEeXk1G
         vHrDwTHPw7qGX7ScyNoTRx4HGYBSN6m/JMx4ot7fx9+jT003v2mzMPgXCKRLiBvNb5Ya
         h0rm50P8pExyWPcONG9jtE0VP0TQ7ywdm7M+D4mjp6qxAht88Taor0mfYJXiG5pfxR4T
         zst2s1c78LY+CItybeJ0amzb02UhEDFdXi8O11Sa74XKul9SMd8BPUeDfxgr1kiQqldh
         EqPA==
X-Gm-Message-State: AOAM5313QZWTminr2OKuc+iD8q0oPBNANVpz19wE2FiU65f4h6yXps16
        uxFvhnM/PMg59oyHVDKvK1wGMU9gzv/r2HHX0KM=
X-Google-Smtp-Source: ABdhPJwWGllR1k7m42AgCn6JkwW6h6jiEQddY5M0kBb98zhQSYAO2GbDqsTHlXma6IA6Ug61w4wDfEA71NuSzq+dwgI=
X-Received: by 2002:a67:e144:: with SMTP id o4mr1408483vsl.4.1642760193762;
 Fri, 21 Jan 2022 02:16:33 -0800 (PST)
MIME-Version: 1.0
References: <20220112151541.1328732-1-m.tretter@pengutronix.de>
In-Reply-To: <20220112151541.1328732-1-m.tretter@pengutronix.de>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Fri, 21 Jan 2022 15:46:23 +0530
Message-ID: <CAFcVECKJMAH3==zoYihtJg_6SJprd7ELC8uL7SO1yGCZzZxemA@mail.gmail.com>
Subject: Re: [PATCH 0/3] dt-bindings: dmaengine: zynqmp_dma: Convert binding
 to YAML
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Michael,

On Thu, Jan 13, 2022 at 4:52 AM Michael Tretter
<m.tretter@pengutronix.de> wrote:
>
> Hi,
>
> This series converts the ZynqMP dma engine dt bindings to yaml and fixes the
> ZynqMP device tree following the stricter yaml bindings.
>
> The series is based on https://github.com/Xilinx/linux-xlnx/tree/zynqmp/dt to
> avoid conflicts when applying the patches to the zynqmp/dt tree.
>
> Patch 1 converts the binding to yaml, Patches 2 and 3 cleanup the dma engine
> nodes in the zynqmp.dtsi that is included by actual board device trees.

Thanks for the series Michael.
Reviewed-by: Harini Katakam <harini.katakam@xilinx.com>

Regards,
Harini
