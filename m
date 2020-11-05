Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AADF2A8699
	for <lists+dmaengine@lfdr.de>; Thu,  5 Nov 2020 19:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgKES6x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Nov 2020 13:58:53 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44771 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbgKES6x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Nov 2020 13:58:53 -0500
Received: by mail-oi1-f196.google.com with SMTP id t16so2744144oie.11;
        Thu, 05 Nov 2020 10:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MbaUDtHJwu9D9pa2rAlfH1GLJRvR+XRMqDcaWHunhzM=;
        b=iBx4Rntktz3UDVEgGiRWJH+vj55UqA/1MHTbIZVvdbLJOpEscQHc17KqWjR199Yntu
         m03q+7Ask2yb3A11iJ+9KeWpdXRzx+F+9NkyUWWWqcRNfpV47DCCnkO1M9Agj75AhFYJ
         AyWmpzlofKGqnLTft7du0Bz2oVrDWgPy9AZqh0j0G4/BCeGY66goA+1iasXW5p8p3lwG
         PiDoZnama2Q3B9FiJwUVVFSByZGfFMNRYKnfSUc4qnXGWXx0HmZCJmb1EyUfcmHQkMIp
         E9cUKLKJvLHegOhLWUNy5QTpEsCDAyNfciM98UUd3EgiiZ5f/u49lqfob1vgpyUCkSsl
         MUIA==
X-Gm-Message-State: AOAM533VZhJX2qKo7MA3xWQyLg2cRuN4fiwjClmIUsvZIfxgagCO8A2k
        GRGr2OdVoXFiAzisfR9SXw==
X-Google-Smtp-Source: ABdhPJzO+qpGu4aL2zaylA3VWrh0PbxwjMXLIkcMZuF1va24unRCMKjrlvFF0C2b6udP+8yvhYfYKg==
X-Received: by 2002:aca:3e86:: with SMTP id l128mr492097oia.133.1604602732513;
        Thu, 05 Nov 2020 10:58:52 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o63sm478826ooa.10.2020.11.05.10.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:58:51 -0800 (PST)
Received: (nullmailer pid 1634242 invoked by uid 1000);
        Thu, 05 Nov 2020 18:58:50 -0000
Date:   Thu, 5 Nov 2020 12:58:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     jason@lakedaemon.net, thierry.reding@gmail.com,
        jonathanh@nvidia.com, dmaengine@vger.kernel.org, vkoul@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, tglx@linutronix.de,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: interrupt-controller: arm,gic: Update
 Tegra compatibles
Message-ID: <20201105185850.GA1633758@bogus>
References: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
 <1604571846-14037-4-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604571846-14037-4-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 05 Nov 2020 15:54:05 +0530, Sameer Pujar wrote:
> Update Tegra compatibles to support newer Tegra chips and required
> combinations.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../devicetree/bindings/interrupt-controller/arm,gic.yaml        | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

With the indentation fixed:

Reviewed-by: Rob Herring <robh@kernel.org>
