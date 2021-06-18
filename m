Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9E83AC2F7
	for <lists+dmaengine@lfdr.de>; Fri, 18 Jun 2021 07:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhFRF4e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Jun 2021 01:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbhFRF4e (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Jun 2021 01:56:34 -0400
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44E4C061574;
        Thu, 17 Jun 2021 22:54:25 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4G5p5n4t93zQjhT;
        Fri, 18 Jun 2021 07:54:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id e4Xno68kSk5Q; Fri, 18 Jun 2021 07:54:18 +0200 (CEST)
Subject: Re: [PATCH 1/2] dt-bindings: dma: altera-msgdma: make response port
 optional
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1623898678.git.olivier.dautricourt@orolia.com>
 <fb28146a23a182be9e5435c1d3e5cac36b372294.1623898678.git.olivier.dautricourt@orolia.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <2fb81c6b-fdad-b9bb-5a96-ea9102ca669f@denx.de>
Date:   Fri, 18 Jun 2021 07:54:17 +0200
MIME-Version: 1.0
In-Reply-To: <fb28146a23a182be9e5435c1d3e5cac36b372294.1623898678.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.51 / 15.00 / 15.00
X-Rspamd-Queue-Id: 93832181C
X-Rspamd-UID: 57652c
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17.06.21 21:52, Olivier Dautricourt wrote:
> Response port is not required in some configuration of the IP core.
> 
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   Documentation/devicetree/bindings/dma/altr,msgdma.yaml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> index a4f9fe23dcd9..b193ee2db4a7 100644
> --- a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> @@ -24,13 +24,15 @@ properties:
>       items:
>         - description: Control and Status Register Slave Port
>         - description: Descriptor Slave Port
> -      - description: Response Slave Port
> +      - description: Response Slave Port (Optional)
> +    minItems: 2
> 
>     reg-names:
>       items:
>         - const: csr
>         - const: desc
>         - const: resp
> +    minItems: 2
> 
>     interrupts:
>       maxItems: 1
> --
> 2.31.0.rc2
> 


Viele Grüße,
Stefan

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
