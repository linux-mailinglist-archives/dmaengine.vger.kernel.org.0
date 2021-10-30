Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6054407C0
	for <lists+dmaengine@lfdr.de>; Sat, 30 Oct 2021 08:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhJ3GsD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 30 Oct 2021 02:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhJ3GsD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 30 Oct 2021 02:48:03 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA30C061570;
        Fri, 29 Oct 2021 23:45:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 188so20453839ljj.4;
        Fri, 29 Oct 2021 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=K/rrEFOf5cm1HdBxS5mrdStp6FT9CDONhYigpV9iaAc=;
        b=K5dnybv0xtJmJNiRZT9HkWkIkH8843bnHN5IYG3p314lNtwJgBYbufDl5U4NmOqs4n
         dldig7C3Rm8TOGYfOd2gceNbpBHw/MOOVdYTOYC53ySdXM5BU+x0yqKtmT9BpC1CMu//
         ibcbJ/BD58vx5LKY+oBtYQBFDyUZlo+R6sKfYubnpy0TS0Cfde1QXtrQWrUPlXAHcgfA
         4IcqOyCQ0AfAnKrLVgk1UhcA4bIReGtxKxAFuvKjzL2Tu33Q3IpP94jXxm1x8ON+MDfS
         Ac6GDqyUhtdwMgdDMZtElIpFsF1606Hb9E+ZSURkCOrz/XeQ26H/EsBaM23+6yyLG7Ap
         51uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=K/rrEFOf5cm1HdBxS5mrdStp6FT9CDONhYigpV9iaAc=;
        b=DQCLDcB6ebUwHJti6iouVEMaOtw2Xmb1Msb4RdALFkq7h0O37uJp5WA1zc9OC2CHy8
         izQLHZOhhZKn6XADCYUYt8EQM5735yUfeALHAyA5Gv3VElB7+xxVcBoXNF2AebaNoivB
         nTuI9kaFL7TUk3hbcjLAhMFo3fhGbzgQuRp+u3dDzeoquwBKRZyKJUM9/nH2FS4+RTB8
         6eU6EawxXVwayP+K92JVG+Xc9fFqKiD7mmB0K+rke7Oyq/GvUS6wwMBKKO7z+EJPOnFL
         IWRmc5OItD3BaYWEQ08ihL+ANZ+BjZBBHWedpAJLyISQOVBf1ahpdFDhuJMCPDGdVgMf
         yY0g==
X-Gm-Message-State: AOAM530dI2EKEBsbSAnuXN/YCOFc0M8G0Kkib3tO3p89hODFSLoUMiaQ
        ipEKGaFYDl3KVgp+aKOkuwE=
X-Google-Smtp-Source: ABdhPJyRZMyjxCGtFAKXU4pGTYkjTKHG+WDxK185G9ow3mUqT4rHeBY9+6D4KKUyasZHEd0duY2v6Q==
X-Received: by 2002:a2e:144a:: with SMTP id 10mr627998lju.242.1635576330375;
        Fri, 29 Oct 2021 23:45:30 -0700 (PDT)
Received: from [10.0.0.115] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id u6sm809007lfs.21.2021.10.29.23.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 23:45:29 -0700 (PDT)
Message-ID: <87082448-0670-4fee-fc7b-8ead415180da@gmail.com>
Date:   Sat, 30 Oct 2021 09:45:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20211029151251.26421-1-kishon@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v3 0/2] dmaengine: ti: k3-udma: Fix NULL pointer
 dereference error
In-Reply-To: <20211029151251.26421-1-kishon@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kishon,

On 29/10/2021 18:12, Kishon Vijay Abraham I wrote:
> NULL pointer de-reference error was observed when all the PCIe endpoint
> functions (22 function in J721E) request a DMA channel. The issue was
> specfically observed when using mem-to-mem copy.
> 
> Changes from v2:
> 1) Fix commit subject and commit log to mention bchan/rchan/tchan to NULL
>    suggested by Peter.

Looks good, however the second patch also fixes the rflow. It is
mentioned in the commit message itself.

I suppose the reason for a split is that the UDMA part
(rchan/tchan/rflow) could be backported as fix for older kernel since
the bchan came later with BCDMA/PKTDMA support?

Can you find a good Fixes tag for these?

> 
> Changes from v1:
> 1) Split the patch for BCDMA and PKTDMA separately
> 2) Fixed the return value of udma_get_rflow() to 0.
> 3) Removed the fixes tag as the patches does not directly apply to the
> commits.
> 
> v1 => https://lore.kernel.org/r/20210209090036.30832-1-kishon@ti.com
> v2 => https://lore.kernel.org/r/20211027055625.11150-1-kishon@ti.com
> 
> Kishon Vijay Abraham I (2):
>   dmaengine: ti: k3-udma: Set bchan to NULL if a channel request fail
>   dmaengine: ti: k3-udma: Set rchan/tchan to NULL if a channel request
>     fail

dmaengine: ti: k3-udma: Set r/tchan or rflow to NULL if request fail

would have bee a better subject line, if you feel you can send an update.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>


> 
>  drivers/dma/ti/k3-udma.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 

-- 
Péter
