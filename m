Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA63529CE
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 12:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBKgY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 06:36:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45102 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBKgX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Apr 2021 06:36:23 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 292A28A1;
        Fri,  2 Apr 2021 12:36:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617359780;
        bh=UiwoZzURvu+edfJ8wILaZuM2KkzO4G9btTpBQ1aMANw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ii2vkV/5RNRcexH/+9Y9WXjZwDulyV3PbakBqHXX3OsXtVQKYxPZ/kwzom7gKVRMF
         VvAz/KFF9U0kNn7z+21xbG7nGA/DogMPndxH5CYxzkVS2IB/a4QXDJDxKW49eo/jVK
         ure/Qlf0WivRAymEW2YV6zpd6moDgxNkaceNDW3E=
Date:   Fri, 2 Apr 2021 13:35:36 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
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
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmaengine@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 16/16] dt-bindings: phy: cdns,dphy: add power-domains
 property
Message-ID: <YGbzeFuCKnetHRXN@pendragon.ideasonboard.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-17-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210330173348.30135-17-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Tue, Mar 30, 2021 at 11:03:48PM +0530, Pratyush Yadav wrote:
> This property is needed on TI platforms to enable the PD of the DPHY
> before it can be used.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> index 0807ba68284d..ddcd4de0aef6 100644
> --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> @@ -30,6 +30,9 @@ properties:
>    "#phy-cells":
>      const: 0
>  
> +  power-domains:
> +    maxItems: 1
> +

Would it be useful to add power-domains to the example ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  required:
>    - compatible
>    - reg

-- 
Regards,

Laurent Pinchart
