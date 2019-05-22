Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F195426523
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfEVNvb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 09:51:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34344 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfEVNva (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 May 2019 09:51:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id l17so2138838otq.1;
        Wed, 22 May 2019 06:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WNC2JYWG7tWES9f64iNfx+WaqJ4vmOCp/0J1TeLz0p4=;
        b=qvDEVPVqzuWN4+F1oBQDNBoUDdISpYKkJKEo2Cs6N45xy8S1Qpgw5EubdZDx2rAj6L
         UErOCz8Oqxz5cnCMHZ0dtTO2laJzV+/lgvrymruRQ8MHh2sMklXJ0GuST0uUh1m+NSc/
         uC0xWDV4Vr4ZggrxRWDE8JR31c04MeE65QiIC1vsQCQW2ZSP5ALRzQ4U8A/Kw7kdZvt/
         GkDUmPxTCqJLm7VzhCH5FOYixAwKYtLS/dq0MWLq+jOyVG0+qOI/9IJxt2ehj6Wmp6As
         0l+CggYmYmHtb+12+uL+zVm8Gz2DkkeOCg/aGZM4inOjHxeIcgKFAUzKRGW8KuU2sLqz
         9f1w==
X-Gm-Message-State: APjAAAX8TUFhDNgH6qjeyogUqQq5iBDzhAwUAieSbYJkiowI77w0tuAX
        BcLFsp4pbtVJzdALtQjYug==
X-Google-Smtp-Source: APXvYqyruJO4hpb5ERYDyy8YFYJg7Z8ngUs0aEUiTimEwLTJsVuVZ4S1t245qpR8qtmb7mfA8CLAFA==
X-Received: by 2002:a05:6830:11ce:: with SMTP id v14mr23382616otq.184.1558533089709;
        Wed, 22 May 2019 06:51:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e8sm4849679otk.13.2019.05.22.06.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 06:51:29 -0700 (PDT)
Date:   Wed, 22 May 2019 08:51:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 10/14] dma: imx-sdma: add i.mx6ul/6sx compatible name
Message-ID: <20190522135128.GA24987@bogus>
References: <1558548188-1155-1-git-send-email-yibin.gong@nxp.com>
 <1558548188-1155-11-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558548188-1155-11-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 22 May 2019 10:00:38 +0000, Robin Gong wrote:
> Add i.mx6ul and i.mx6sx compatible name in binding doc.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
