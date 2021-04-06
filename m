Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541DF355B3F
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbhDFSX5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 14:23:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40412 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhDFSXq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 14:23:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136INMkm083108;
        Tue, 6 Apr 2021 13:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617733402;
        bh=JhEkocfqBYT9SHhZ48vuKki2J0ybw2oAPtY/sW4Ok20=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=sZIzw5z3nk5rhIb60BkbP1RcNUdM4QPpeO3JKHJPlDkiXULJF/bucpR6igbyGx1Gg
         EsZhT7HnrnQQGN+TGqeHwF+5m2kA3KlCg8nRd3w6/aDadE63DVKRN8nKO54NJ8+nug
         6b2/KpBhj9K4vJLFCuzFfysSmHoVPSEaUwrXJIMM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136INMMm023167
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 13:23:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 13:23:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 13:23:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136INLp6104962;
        Tue, 6 Apr 2021 13:23:22 -0500
Date:   Tue, 6 Apr 2021 23:53:21 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 16/16] dt-bindings: phy: cdns,dphy: add power-domains
 property
Message-ID: <20210406182318.7a2cf7zmc3bniucq@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-17-p.yadav@ti.com>
 <YGbzeFuCKnetHRXN@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGbzeFuCKnetHRXN@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02/04/21 01:35PM, Laurent Pinchart wrote:
> Hi Pratyush,
> 
> Thank you for the patch.
> 
> On Tue, Mar 30, 2021 at 11:03:48PM +0530, Pratyush Yadav wrote:
> > This property is needed on TI platforms to enable the PD of the DPHY
> > before it can be used.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > index 0807ba68284d..ddcd4de0aef6 100644
> > --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > @@ -30,6 +30,9 @@ properties:
> >    "#phy-cells":
> >      const: 0
> >  
> > +  power-domains:
> > +    maxItems: 1
> > +
> 
> Would it be useful to add power-domains to the example ?

Ok. Will add it in v2.

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks.

> 
> >  required:
> >    - compatible
> >    - reg
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
