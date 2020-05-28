Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D761E707B
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 01:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437627AbgE1XkI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 19:40:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36977 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437625AbgE1XkH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 19:40:07 -0400
Received: by mail-io1-f68.google.com with SMTP id r2so435027ioo.4;
        Thu, 28 May 2020 16:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i4Y4lPDTpEphgjWEfCEtO/CC6ipcnlKyUlBGCBDZA24=;
        b=gK8/mUHHs40035WQYUzZXo5yeGAcTL3n8Z5dD3rRZGTA2jtW+zaAtrwnKCx+YgYJcf
         G5EuTdvkrrXUoymBZR0Z+lrOPjRn5zpWm1G7zRlNM7fh/trptOyhQzONzkhbCpfNje1I
         jhnU7Nan9DiUYD8zdQR3c/RgV9IWyn4aQ8PNAzVimZ26hvTXqCtcibyEzOy+ajArpTc3
         1gqJZpZH0pSJr5x22rvR1eTQwQADIW1DJddHUtBhXPbMbSIVpmtRi/wZfWrjw5Ke9SYT
         /+tne6VEpLmpJvOwXNV6Er4EG0TBsidmYuDo9Fj3jPHhRbLIaV9XuAhYZeYTVpnOV/gK
         GWtw==
X-Gm-Message-State: AOAM530ZOPoDTKb6bwp0zH2nDmsfmB8kB/Dp3HEU5ceTylrG9r+hO5hs
        iz2hNQUy3/SeS6oGQ9IskR6voWKDsw==
X-Google-Smtp-Source: ABdhPJy8BW9eTIOl/ecKA/VdytHdPNFmsc9AalD1NorbWXq7ZqfpCfTOjU89LHuDt9aD//1FAEZypQ==
X-Received: by 2002:a6b:d311:: with SMTP id s17mr4429829iob.18.1590709206102;
        Thu, 28 May 2020 16:40:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i2sm3111578ion.35.2020.05.28.16.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:40:05 -0700 (PDT)
Received: (nullmailer pid 891407 invoked by uid 1000);
        Thu, 28 May 2020 23:40:04 -0000
Date:   Thu, 28 May 2020 17:40:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     matthias.bgg@gmail.com, Matthias Brugger <mbrugger@suse.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sean.wang@mediatek.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, vkoul@kernel.org
Subject: Re: [PATCH] dt-bindings: dma: uart: mtk: fix example
Message-ID: <20200528234004.GA891377@bogus>
References: <20200523201530.18225-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523201530.18225-1-matthias.bgg@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, 23 May 2020 22:15:30 +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The binding example is missing the fallback compatible.
> This is needed as the driver only matches against mt6577.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!
