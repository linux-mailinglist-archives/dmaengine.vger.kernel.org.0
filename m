Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305582AC791
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 22:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgKIVpx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 16:45:53 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:33133 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIVpw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Nov 2020 16:45:52 -0500
Received: by mail-oo1-f65.google.com with SMTP id f8so2072853oou.0;
        Mon, 09 Nov 2020 13:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d6PCW2KOH0KDLqsVM+6AHC+5drSfLm/w4ypsxg3tiJA=;
        b=c2+fSU8i6WHN/axX8yU7lf5G8CO4K/YfLwEg2DAhqRybQXhldBVaBGqupjtnCywtpt
         chj220z0EyIpit/NSgts3vayyXimzOmZ8ptcDOMtknR79Nozrwx7cAYkpM2Nt+F/iR6B
         KZWDrA9FXYCsr4d6MFW1cHOQSB96fJddfNYB0b6IZX0UOb7SWSwsjKE9r7rB2inniaNq
         34hjqEOTBYSa2DLWZnFJ58N3fUvsLfJA8W3i39AW3cOfmsWmzslgMga8I4KQYWufGVRo
         53Ez8uIJ28dUqN7YbMntlLwE4/Dn2tMD3U2qbatzYr9gPZRg6lfY8W6b7tuzi22uVASo
         2sTg==
X-Gm-Message-State: AOAM533+3d78v6R2W58v3+8zsBCrYoHEVlfSTHV0WdmoDogyePiF6H8j
        7NmPo9RnZDQ5w5as9Rxnyw==
X-Google-Smtp-Source: ABdhPJwsz1sxFO5IB6M0mkPCFruDjPSsYHpFhyA2CUxctoSVTH1f9ZqjFBpNjgMqk/akx34sIhRS8A==
X-Received: by 2002:a4a:d63a:: with SMTP id n26mr7290006oon.38.1604958352169;
        Mon, 09 Nov 2020 13:45:52 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d22sm2653060oij.53.2020.11.09.13.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:45:51 -0800 (PST)
Received: (nullmailer pid 1811549 invoked by uid 1000);
        Mon, 09 Nov 2020 21:45:50 -0000
Date:   Mon, 9 Nov 2020 15:45:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org, tglx@linutronix.de,
        linux-tegra@vger.kernel.org, jason@lakedaemon.net,
        thierry.reding@gmail.com, maz@kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: bus: Convert ACONNECT doc to
 json-schema
Message-ID: <20201109214550.GA1811494@bogus>
References: <1604677413-20411-1-git-send-email-spujar@nvidia.com>
 <1604677413-20411-5-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604677413-20411-5-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 06 Nov 2020 21:13:33 +0530, Sameer Pujar wrote:
> Move ACONNECT documentation to YAML format.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../bindings/bus/nvidia,tegra210-aconnect.txt      | 44 ------------
>  .../bindings/bus/nvidia,tegra210-aconnect.yaml     | 82 ++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt
>  create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
