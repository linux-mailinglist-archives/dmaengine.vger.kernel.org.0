Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7573DAA99
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 20:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhG2SAt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 14:00:49 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:46594 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhG2SAs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Jul 2021 14:00:48 -0400
Received: by mail-io1-f51.google.com with SMTP id z7so7412951iog.13;
        Thu, 29 Jul 2021 11:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=na8BkWUA5gMutg6qlMuN6847wnsVMn6PQTz3HEtGN8g=;
        b=ZRDpz676cggKPazRiaGHA5j+eSgrlRjKxVoJ0jVgUNlWHMUYlwsGe+VFMFnodGQPRD
         OULDME/+iuR5ihXPTPAObD7D0lJCacXowFxLibnF/fhzHHWCRAUNvCyRo8xz0QNBMxmv
         77tGTCoctsckESzV4fBcG+QNfEPVjsuC3EEawpGd/Q2VcOcLcsqD6jrASImix4vVQXqO
         Qvq4z3ekTzulm3q2hWe+CwgLchr11lt1nIgp/ANC3IVzNOLISS2MipPxFwBdChalZVU/
         ggJPJrGU0mzoQ7I/IVbjPKImyxyLSKzczwWubiESup8Y5koNH5T+Sr4RcOYXRTNZsiXW
         MQvA==
X-Gm-Message-State: AOAM53168fk4/xEvjY3EcFtQKKwykS0hU1PGuh2G5k04PyP2p+GEXKn+
        31SbW84Jonsb+pysIk0+hA==
X-Google-Smtp-Source: ABdhPJyyLaALH3IuCiyR6jnGkq4nhdmhKmJq1u9FckH2SSDuzIvc24kHJAdJpEA7v69Ag+QZFobSsQ==
X-Received: by 2002:a05:6602:446:: with SMTP id e6mr5082379iov.85.1627581644107;
        Thu, 29 Jul 2021 11:00:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d9sm2297620ilu.9.2021.07.29.11.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:00:43 -0700 (PDT)
Received: (nullmailer pid 578452 invoked by uid 1000);
        Thu, 29 Jul 2021 18:00:42 -0000
Date:   Thu, 29 Jul 2021 12:00:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Chris Brandt <chris.brandt@renesas.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: dma: Document RZ/G2L bindings
Message-ID: <YQLsykqsogHXMVpA@robh.at.kernel.org>
References: <20210729082520.26186-1-biju.das.jz@bp.renesas.com>
 <20210729082520.26186-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729082520.26186-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 29 Jul 2021 09:25:18 +0100, Biju Das wrote:
> Document RZ/G2L DMAC bindings.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Note:-
>  This base series for this patch is Linux 5.14-rc2(or +) otherwise bots would
>  complain about check failures
> 
> v4->v5:
>   * Passing legacy slave channel configuration parameters using dmaengine_slave_config is prohibited.
>     So started passing this parameters in DT instead, by encoding MID/RID values with channel parameters
>     in the #dma-cells.
>   * Updated the description for #dma-cells
>   * Removed Rb tag's of Geert and Rob since there is a modification in binding patch
> v3->v4:
>   * Added Rob's Rb tag
>   * Described clocks and reset properties
> v2->v3:
>   * Added error interrupt first.
>   * Updated clock and reset maxitems.
>   * Added Geert's Rb tag.
> v1->v2:
>   * Made interrupt names in defined order
>   * Removed src address and channel configuration from dma-cells.
>   * Changed the compatibele string to "renesas,r9a07g044-dmac".
> v1:-
>   * https://patchwork.kernel.org/project/linux-renesas-soc/patch/20210611113642.18457-2-biju.das.jz@bp.renesas.com/
> ---
> ---
>  .../bindings/dma/renesas,rz-dmac.yaml         | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
