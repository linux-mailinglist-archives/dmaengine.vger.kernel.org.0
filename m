Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB444A4A
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 20:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfFMSHh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 14:07:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38873 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFMSHg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Jun 2019 14:07:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so21496702qtl.5;
        Thu, 13 Jun 2019 11:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oj9KR+T1fOqKQ4FESSVm1jnPwC60Lm44k4F4XEoSR9o=;
        b=Sul5XNJ8VYOzBBN660uHAjDRKi0A+HhQhyMksgpIYFjnGdNFxkNW96wIBK/q3eCnYn
         4bJlURsf/gV5mL9gNjoyvCRB1C9Gt/B/Bxcil1hO/s8MgPgpXzGJoExoAwxdPypjv3JH
         0lWmeflYMJ6nZSha0Namvh6SFeZosihilDkaCmizF+K86sCmXcDyLe5jX6B2a2WTufNw
         7C64lb+hDe+jPfTfsXFaInLHGdjR60WFS20jel9bgjABbFFPRSHs5dCLyF2pZMqjNMdT
         SYePBGeyUds1BfTHCd8MyK56gcq6IZExGQWaaky8fL01FFuOhkHNbrsSewuka+rLu9xr
         sL5Q==
X-Gm-Message-State: APjAAAVxVVNd5JQ/OTmUszKfqBNJIrsDx4GNFU/VfrGNtpxsU/A3CcFi
        LfCEgrHcx30Uqsh0Z8yLKkbmdpg=
X-Google-Smtp-Source: APXvYqyUp5hOsDZfLIs3lS90BPkWO4yBBGNdYOYbR9C7XHV9gSGJlFFkMIKIt+hKrpXob3c5vDNzQQ==
X-Received: by 2002:a0c:d1f0:: with SMTP id k45mr4787080qvh.69.1560449255707;
        Thu, 13 Jun 2019 11:07:35 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id x10sm264965qtc.34.2019.06.13.11.07.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:07:35 -0700 (PDT)
Date:   Thu, 13 Jun 2019 12:07:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Ma <peng.ma@nxp.com>
Subject: Re: [PATCH 4/4] dt-bindings: fsl-qdma: Add LS1028A qDMA bindings
Message-ID: <20190613180734.GA3178@bogus>
References: <20190506090344.37784-1-peng.ma@nxp.com>
 <20190506090344.37784-4-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506090344.37784-4-peng.ma@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon,  6 May 2019 09:03:44 +0000, Peng Ma wrote:
> Add LS1028A qDMA controller bindings to fsl-qdma bindings.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl-qdma.txt |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
