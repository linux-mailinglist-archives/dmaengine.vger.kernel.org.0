Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38C0E8DCB
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2019 18:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403775AbfJ2RM3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Oct 2019 13:12:29 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:39826 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390870AbfJ2RM2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Oct 2019 13:12:28 -0400
Received: by mail-oi1-f171.google.com with SMTP id v138so9583821oif.6;
        Tue, 29 Oct 2019 10:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fNM2UEnnNDrdLfT2bI3aJJfoKHNAkx3pECB9YdXiOiw=;
        b=j9PmG0VB34UD9j9FnnKPMatsBWZrEB71f5/heqmqWmbYor/wTU3iIKR1iQxLO+/5cJ
         gDWRS+LGlXorab69GEBbgKw0AbZGO6FoEy0lTq5IfHOEmYClo8lu+PndU3UhfGn6n9HB
         ZBWzqk7Htiqcz6vThMMRJ1WPe/q6tf1WOuCFr8tG1XLDMapix3HzypTSe66P/jgipMrr
         QCpWLaL93u05Pw1vxh5eEwRbIrzL789DBcOGRLpWdkbQLwsto/FrFiBSJRgnuy921ArL
         WDetfGQMAOBYTcXUwSQFzEnuAhEKp4f+Q5n6+SENppmS/wwIy21VjYU/LVoI21lt2WRe
         veJA==
X-Gm-Message-State: APjAAAWxTWpgpsNDoKtRuwr/1wpBEd7Fy1mIjljFZKlz6jn8TaAyibnR
        ycLh7+LRb4BDpR2C9bIEtg==
X-Google-Smtp-Source: APXvYqw0wGAUcfIn/tVYmeShtukBRHI9od8K/vH6/YwMErb1SV8d+MlQ35+4oUSu+PubXFiv9w2Xrg==
X-Received: by 2002:aca:3c86:: with SMTP id j128mr1343511oia.153.1572369146892;
        Tue, 29 Oct 2019 10:12:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm4986311otb.63.2019.10.29.10.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 10:12:26 -0700 (PDT)
Date:   Tue, 29 Oct 2019 12:12:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, michal.simek@xilinx.com,
        anirudha.sarangi@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH -next 2/6] dt-bindings: dmaengine: xilinx_dma: Fix
 formatting and style
Message-ID: <20191029171225.GA31221@bogus>
References: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1571763622-29281-3-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571763622-29281-3-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 22 Oct 2019 22:30:18 +0530, Radhey Shyam Pandey wrote:
> Trivial formatting(keep compatible string one per line, caps change etc).
> It doesn't modify the content of the binding.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes since RFC:
> New patch. Trivial formatting (compatible string one per line) as
> suggested by Rob in MCDMA RFC series.
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
