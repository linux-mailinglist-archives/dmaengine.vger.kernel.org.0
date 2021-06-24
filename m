Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2873B38D0
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 23:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhFXVgq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 17:36:46 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:46984 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhFXVgp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Jun 2021 17:36:45 -0400
Received: by mail-il1-f172.google.com with SMTP id i12so7770055ila.13;
        Thu, 24 Jun 2021 14:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lA9u/NU6RXqXrtO+WlVIvTvKekwJRd3nPzF7YBgfJeI=;
        b=NsQOVq/116pZ8WOdBwAmJ3264eqBjxCyXK70juND4ZwAeOID9ZKaKsumYMAQSJpcrD
         y9iJCgn4p7nVGVSdNxBccgleWObRMhjtHvgl+wb71qf/nm6kPlFFptnCkBWUnirDOcf3
         PsckGJ/HIKIlWp6OtXc13jnRRPdjOTPdRCTCLOh9sA+b0sRB+/ti4N9x2OmsEVWIeO6w
         D+FkW6JNXka5K6ZWkJXAY9NV9JGUMvbD7JeFBNeZ/p1pfIkK1jdXjbRtLRnqmP1SsMKn
         gZxNLRhaw7pblyYQcMilPmVs6yGBcJy6bHgMVSOMEeV662znAlUyDhDuTYPcU5vluZsO
         c+1g==
X-Gm-Message-State: AOAM530YNoOmTUBLooj+EPwpH6KQRVcs2LKD6CmNWfFhgwVV/R4dtU8h
        okalISu52HlXCIhuv40jP5kA97DJBA==
X-Google-Smtp-Source: ABdhPJxP+3zxw6fnxzDP+ne8xz4SO2x8bXnM36vvMiioO4ws8dPCA0v8WTJALCRARGKJfh1BiNnYBw==
X-Received: by 2002:a05:6e02:1147:: with SMTP id o7mr3727553ill.97.1624570465718;
        Thu, 24 Jun 2021 14:34:25 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c22sm2022425ioz.24.2021.06.24.14.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:34:24 -0700 (PDT)
Received: (nullmailer pid 2024761 invoked by uid 1000);
        Thu, 24 Jun 2021 21:34:21 -0000
Date:   Thu, 24 Jun 2021 15:34:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
Cc:     Stefan Roese <sr@denx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: dma: altera-msgdma: make response port
 optional
Message-ID: <20210624213421.GA2024713@robh.at.kernel.org>
References: <cover.1623898678.git.olivier.dautricourt@orolia.com>
 <fb28146a23a182be9e5435c1d3e5cac36b372294.1623898678.git.olivier.dautricourt@orolia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb28146a23a182be9e5435c1d3e5cac36b372294.1623898678.git.olivier.dautricourt@orolia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 17 Jun 2021 21:52:32 +0200, Olivier Dautricourt wrote:
> Response port is not required in some configuration of the IP core.
> 
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
> ---
>  Documentation/devicetree/bindings/dma/altr,msgdma.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
