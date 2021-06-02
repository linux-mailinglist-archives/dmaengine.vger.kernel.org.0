Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4204B398A65
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jun 2021 15:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhFBN3S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Jun 2021 09:29:18 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50759 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhFBN3R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Jun 2021 09:29:17 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0A1DC58080F;
        Wed,  2 Jun 2021 09:27:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 02 Jun 2021 09:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=t
        EtNI5XfZ6vhm4RT4AXBLdGYkWoF8xb2B7jzYSkFXwQ=; b=XzA6utgrMy5gqmgND
        Pgl6Oapfn8N0hQa9AFoi/7TdiBaJAcJmRMCFVh6csYA8DVV6MP8Sws6XfW+FmmAy
        xzQzgrS1G0UUYGwPxzJqnq7WB7EpbsxJf9XJiGEm4CJYsx5zXo5bUlmxIjwYzAqI
        TIp8kQdIUuw/ZgwSJt0oRU2/vf67cGOt/zkPr9clb2iQAd27HnTlujVOob4JKIhH
        qgpcfT+Z1BxZ0MTBkWW7qWO1bcT/dEIARvoUs8HZBpY+6C5FZCK2T29ktPu2ga2M
        +owQE0g1M/x5yvH5tDhL6xl5JFIkCV8tJusRIzETL3MtcvieqrjRGB1ZdH9a3Uyr
        PYx9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=tEtNI5XfZ6vhm4RT4AXBLdGYkWoF8xb2B7jzYSkFX
        wQ=; b=ZuNBU3QOJi8+Un8XIIGXqEvx2f22ZUavZeJ3aWhLT3CGYbo4bEPNqJZ+Q
        9G10DoKGLJjFhDd2zjnwdN+PkqX+PvPd2Wk3aKrA9Qtefujl0a8YC4FbmA54C6OD
        VhFisBmd/OxxnDh8MNNNsWGQCMcyKpjZcimO9nUd7Sivw5F35D+EGPDWF5OCSx80
        RcMLWd8APZCpaa93x2xPqXxUyOiCY+G6foJEwEr/fQ66I0ybsufsJxcRRn9//jWI
        cZtySYkLJm8y7CBggyOrHO8n0M0EBHsC38BdFle36/+O5YK7WaoXY7HpucoRqCZa
        1RPWwulWEtFa4ZjYcKmuI8l1n0uSg==
X-ME-Sender: <xms:Q4e3YH6HxDHcMJLxVFk3ubMRTk6kmBVLHHdJuFLp8bEmk9gK3lhvRg>
    <xme:Q4e3YM4AhzYT3Dl793iNtcVbNThbFNjhxOcZulnsi-dF9SDUu9IoDoWolrvkCSixx
    f6g-eZsJoE7hkta7yY>
X-ME-Received: <xmr:Q4e3YOfDfNtMQQ2sGJ8X1uHGlOet52fQsfV9jgn9kG-eg5dtsH9lHj1vXkKebfywxSOxOE7k83hXyC8o4vnJsqEERMn0aNtirJLe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeljedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Q4e3YIJf-LuxWGaE89vINCRk2sw3jBsbz9IlwawJCIA0c63jKkLCOg>
    <xmx:Q4e3YLI6qzJFFZm6NIU7dAh49s2rTOqVc4oy2wNy-meQSOczwZoCPw>
    <xmx:Q4e3YByGomI-AKkDrcqoelcxwDw1Qtua2_A7CPCNnjnvk5LZpBlzaA>
    <xmx:RYe3YM5tYXluYgIaDHX_8VitHSvFxXAOqHzGdWouLhCtpbe_MFIg3Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jun 2021 09:27:31 -0400 (EDT)
Date:   Wed, 2 Jun 2021 15:27:28 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 17/18] phy: dt-bindings: cdns,dphy: make clocks
 optional
Message-ID: <20210602132728.5lv5n2mgap2o7eyx@gilmour>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-18-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210526152308.16525-18-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Wed, May 26, 2021 at 08:53:07PM +0530, Pratyush Yadav wrote:
> The clocks are not used by the DPHY when used in Rx mode so make them
> optional.
>=20
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>=20
> ---
>=20
> Changes in v2:
> - Re-order subject prefixes.
>=20
>  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Docum=
entation/devicetree/bindings/phy/cdns,dphy.yaml
> index b90a58773bf2..3bb5be05e825 100644
> --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> @@ -33,8 +33,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - clocks
> -  - clock-names

As far as I can remember from the cadence documentation, those clocks
were required. I guess this is the integration that provides a few fixed
clocks?

Maxime
