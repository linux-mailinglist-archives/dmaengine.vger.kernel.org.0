Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414B6399C50
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFCISH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 04:18:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52622 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhFCISG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Jun 2021 04:18:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1538G9Em086091;
        Thu, 3 Jun 2021 03:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622708169;
        bh=5wwte9CRzT+YNJ2vP9j/C62EmP//YgO8AMYtKlKvqDc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=cFlU62NDbrQ7UvVXWMaEKMDFSa9srdP5LtFjdFAn+YemRMpnOwlSBLhmGz/WmY+Ja
         XAszj0auUyk2UXjK1pWyRB9TkAyqkXcU+D7K2m/lptnckNV/VqLHCixG0+fbQIFIZn
         XMuerxx7nhepSUKJIc5szuXqWA+xOoj0cfkmJXjc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1538G9pw074737
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 03:16:09 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 03:16:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 03:16:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1538G80x052919;
        Thu, 3 Jun 2021 03:16:08 -0500
Date:   Thu, 3 Jun 2021 13:46:07 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Maxime Ripard <maxime@cerno.tech>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 17/18] phy: dt-bindings: cdns,dphy: make clocks
 optional
Message-ID: <20210603081605.v7b5peuqjbsivmzb@ti.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-18-p.yadav@ti.com>
 <20210602132728.5lv5n2mgap2o7eyx@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210602132728.5lv5n2mgap2o7eyx@gilmour>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02/06/21 03:27PM, Maxime Ripard wrote:
> Hi,
> 
> On Wed, May 26, 2021 at 08:53:07PM +0530, Pratyush Yadav wrote:
> > The clocks are not used by the DPHY when used in Rx mode so make them
> > optional.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > 
> > Changes in v2:
> > - Re-order subject prefixes.
> > 
> >  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > index b90a58773bf2..3bb5be05e825 100644
> > --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > @@ -33,8 +33,6 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - clocks
> > -  - clock-names
> 
> As far as I can remember from the cadence documentation, those clocks
> were required. I guess this is the integration that provides a few fixed
> clocks?

Yes. The clock divider/frequency has been set via the DPHY pins so no 
need to set them via software.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
