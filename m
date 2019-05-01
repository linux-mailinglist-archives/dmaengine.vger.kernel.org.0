Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A3010DBD
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2019 22:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEAUHk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 May 2019 16:07:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45757 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEAUHk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 May 2019 16:07:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id a10so46252otl.12;
        Wed, 01 May 2019 13:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NUkhtg7+aAgAyNuqnNTM6hyqkyEfScztnaS0eIaqMl8=;
        b=nGhZD3vcEm4+Y5ikstUNCafu3GGS5fvCWec1Zm/F2O66w/1IrH/E/C9719h74O7Mia
         c2uz+0TTew78I5rslspiYOL4syH0MZIL4b1Iw9B3ogHM43oALKa+HAJ6rI3/Bmbe1xWG
         E59ArvuawsOMjhBNVAwztl1VAINYvFW6LElXyzYMd9Zeq6vpY/pQg7L5pqti3BhOT/Y3
         k35LN98irytBrKzVf+7snkGRosDyJsVe6++Hd9BLDgODzm22IqfVj+vIMAgUh0P7hYiU
         hQqANjj1A75fBQ7ZVUt7bdGEQCrcIN7+sbHI1oqYGnyyY1Xhx13xZ6NWB2G98vdCHwih
         gJYQ==
X-Gm-Message-State: APjAAAXpwTXmEMoG8lVh3TjBQQELY36ZuEW5QbwXcT47J22HGnggJDon
        ZHphjfx9M5Ghpb81VNgqNg==
X-Google-Smtp-Source: APXvYqwpI0PmHtqAfOIdYfsq6gfME3D3Ho7yZc3qgpejZuF1tY3yA/iZe13vbv8FxOQSIIRylDQavw==
X-Received: by 2002:a05:6830:2059:: with SMTP id f25mr2244063otp.81.1556741259493;
        Wed, 01 May 2019 13:07:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s202sm5566028oih.42.2019.05.01.13.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:07:38 -0700 (PDT)
Date:   Wed, 1 May 2019 15:07:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 10/15] dt-bindings: dma: imx-sdma: add i.mx6ul/6sx
  compatible name
Message-ID: <20190501200738.GA7100@bogus>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
 <1556265512-9130-11-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556265512-9130-11-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 26 Apr 2019 08:06:03 +0000, Robin Gong wrote:
> Add i.mx6ul and i.mx6sx compatible name.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
