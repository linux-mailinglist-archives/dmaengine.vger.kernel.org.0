Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F374D42EE
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2019 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfJKOcI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Oct 2019 10:32:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46229 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfJKOcI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Oct 2019 10:32:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id 89so8100523oth.13;
        Fri, 11 Oct 2019 07:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H3n2Fz+qj7wCeXKJS+vYpyY/63hEGZCo5PhUXjdN+zA=;
        b=nIgAbI29o+gkDMUimIzxegd63rTcNMRG+h8NOlRQlabevaRcCm85QeZ3aT0RiGY3Cx
         ZDe9vE9atVg+4MMnTVCip4UadSHlnvOmvNIeTM59pBWnXneRxmyyWVXHqBMZicpbyoyz
         2TkOvWgLE2V6j1o4eIVRUVIPWZGLfRXa8dneDYNMaRS4LHKNVR4S1vB7JDz1EWoPUMng
         LdcGS+rUgpjKqXNQmiLfxIdnITVAhJV+4OD7niN/vUy1Yn039GqzzxoBUqaj9WJwzlpI
         AFNwSq+vDxX8McvwmsWeoqeq9Q5Wi0CO9SAxuRnkvCllXUDnYEXxbgFVQtTxw+tsM69j
         TFzw==
X-Gm-Message-State: APjAAAUfUp45ibHm7z3d9qP9OpxWT3UPkARIg5ETTUOtpMh+H7OBrdr2
        1339wCHWSPlAaxBAspE4RQ==
X-Google-Smtp-Source: APXvYqzBomLw3m4J3taZnodc7sOY0vwonGNkdZBQ5F2aw5rN7biaYOSRbhELpcDaSNS8gI1A1Ds40A==
X-Received: by 2002:a05:6830:1e59:: with SMTP id e25mr12350373otj.342.1570804327317;
        Fri, 11 Oct 2019 07:32:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i4sm2668323oto.43.2019.10.11.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:32:06 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:32:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Biju Das <biju.das@bp.renesas.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: dmaengine: rcar-dmac: Document R8A774B1
 bindings
Message-ID: <20191011143205.GA19988@bogus>
References: <1569580629-55677-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569580629-55677-1-git-send-email-biju.das@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 27 Sep 2019 11:37:09 +0100, Biju Das wrote:
> Renesas RZ/G2N (R8A774B1) SoC also has the R-Car gen2/3 compatible
> DMA controllers, therefore document RZ/G2N specific bindings.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> V1-->V2
>   * Incorporated Geert's review comment
>   * Added Geert's reviewed by tag
> ---
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
