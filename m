Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34131E303
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2019 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfD2Msa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Apr 2019 08:48:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41002 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbfD2Ms3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Apr 2019 08:48:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id v23so7984707oif.8;
        Mon, 29 Apr 2019 05:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=og27ttBtjgJ9jOWpsX9tE4/VFPoPVEaauxxZKhLh4wA=;
        b=YCcyb68g0HbnPS6KqhPv1iQoUsdN6C77xSAlm73E1yODNV+UBW35DilpWWx/EtAneh
         5gwo3fBoFmNETpiNRIlClBH/uT4bc6F6xHRHV7HZtuf/5NOQYIfKsBE2jcJK/CRtG96s
         UQ3oCC2vc7i/E5MtnQZtWqBVTObh0Gx7nSkPUAR/+3Em9wDKQajeQxDz3DREQqpoAhJi
         OOWBGaBl0wViTT0/QCEvjPvxk76j5PvTVZAG8ulMWvDMpANPTe94SR5gb0RJfRQRxPo4
         Lkmz4+O/p8TZqi1gQalN6RgteLdQDDidfxY4TdKtlpOuub4qOjStW0q+sVp3Lr4CIQqU
         mSbQ==
X-Gm-Message-State: APjAAAVBqtiFBJr639FjSHXcWf9emfwwvNPjk/upa8L2strbv4+1vjL4
        t5/NowxT3ky8/Ixxpxt7aw==
X-Google-Smtp-Source: APXvYqwKkbM8iUDWYjwi3FrVr9CbooaBbkgXDxXE3TLfLAeQGcrA39ywmAR8rFYO2DOBT72rVzWKCg==
X-Received: by 2002:aca:be89:: with SMTP id o131mr15557106oif.138.1556542108407;
        Mon, 29 Apr 2019 05:48:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c3sm7872781otr.57.2019.04.29.05.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 05:48:27 -0700 (PDT)
Date:   Mon, 29 Apr 2019 07:48:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Long Cheng <long.cheng@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Long Cheng <long.cheng@mediatek.com>
Subject: Re: [PATCH 3/4] dt-bindings: dma: uart: rename binding
Message-ID: <20190429124827.GA13816@bogus>
References: <1556336193-15198-1-git-send-email-long.cheng@mediatek.com>
 <1556336193-15198-4-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556336193-15198-4-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, 27 Apr 2019 11:36:32 +0800, Long Cheng wrote:
> The filename matches mtk-uart-apdma.c.
> So using "mtk-uart-apdma.txt" should be better.
> And add some property.
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 ------------
>  .../devicetree/bindings/dma/mtk-uart-apdma.txt     |   55 ++++++++++++++++++++
>  2 files changed, 55 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
