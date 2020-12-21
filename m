Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC02E0084
	for <lists+dmaengine@lfdr.de>; Mon, 21 Dec 2020 19:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgLUS4C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 13:56:02 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42988 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgLUS4B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Dec 2020 13:56:01 -0500
Received: by mail-oi1-f175.google.com with SMTP id l200so12244984oig.9;
        Mon, 21 Dec 2020 10:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IJ7l/a9mmzMt7kum9VbRKMbyay3Fw/ozonrRakViwg8=;
        b=bAB9pHrAmEe6bBSPAXbZCotHFKFyi1ioanuAxX+SZ5H8BpGof4P0OEVN8GkeLYON90
         7zM4sSZBcnNrG5kLgM1SMY+sp69QjS3RUYXVfpfVOZ3LooNTPDCDkjoRfbsmeshCyrb7
         R1f6V6JKi6ycmz5xvkGWvtgtdAyAs3sgfJQd0VOE/lsu4RJaXoQh+5dkQ7xdyezsoHDN
         OaALjn0vW9w9vqxlOq+QO7iBnaY4Gj+WOfjKbkVIlSAmBa7Pog/2FLqiB+TwLrFPLOts
         gUPL84IivSsqUdm4bYO/xBX8MEzHvbfbF9zXt8vTVtKYJy+efLWzQJPmFZyxXc++6pZX
         brhw==
X-Gm-Message-State: AOAM530SCwXXEc1Px3BJIw4XDy4HAi7tGHjZXVCEfVflMAYgi8tJD5GK
        sP4hBMTxWFvPd5DQZ7vZLd1QTareZQ==
X-Google-Smtp-Source: ABdhPJyyfSd9ZNa5xlxTSTlLKiW1koaF4UuSz+lFOcArcppC3IEGPpOvMc6mT5zQXH0+78WFgssBHQ==
X-Received: by 2002:aca:4d8b:: with SMTP id a133mr12303671oib.79.1608576920495;
        Mon, 21 Dec 2020 10:55:20 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q18sm3850264ood.35.2020.12.21.10.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:55:19 -0800 (PST)
Received: (nullmailer pid 357349 invoked by uid 1000);
        Mon, 21 Dec 2020 18:55:18 -0000
Date:   Mon, 21 Dec 2020 11:55:18 -0700
From:   Rob Herring <robh@kernel.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     devicetree@vger.kernel.org, mturquette@baylibre.com,
        dan.j.williams@intel.com, linux-clk@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] dt: bindings: dma: Add DT bindings for HiSilicon
 Hiedma Controller
Message-ID: <20201221185518.GA357293@robh.at.kernel.org>
References: <20201215110947.41268-1-gengdongjiu@huawei.com>
 <20201215110947.41268-4-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215110947.41268-4-gengdongjiu@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 15 Dec 2020 11:09:46 +0000, Dongjiu Geng wrote:
> The Hiedma Controller v310 Provides eight DMA channels, each
> channel can be configured for one-way transfer. The data can
> be transferred in 8-bit, 16-bit, 32-bit, or 64-bit mode. This
> documentation describes DT bindings of this controller.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  .../bindings/dma/hisilicon,hiedmacv310.yaml   | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
