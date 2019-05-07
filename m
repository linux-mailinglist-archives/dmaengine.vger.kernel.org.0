Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2502716871
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfEGQ4E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 12:56:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42629 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfEGQ4E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 12:56:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so12847706oig.9;
        Tue, 07 May 2019 09:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GHBrVv53KHjD9Lzdqkki/7g03N+HBCIm+A+C+qlOgKo=;
        b=mqY2BnbdJABDw2h5KE3+uHtDikSOmkEHT9HaDHwWgEkC39D2xuZOX9VxbrnHbKzxGB
         bx8lVw1QLQ3zC9sKHKQP0HBhsAOFnSpMX6KvFLRZFV1m66cxUj9Oj1KrJXVjYYjuJDrc
         ZjrotSLai0pfrQBPHehMiHZxFdIpqR1c1z+eVgBccSkiTLhjUkM5+lyZFn3sKXUMVzcW
         3VWPkO33ezgB7g6Yo9HZCBL3BNNCNmU2wdoz69Reu1MzKCe6eQzAnuuGzL5QjuZo5uZF
         icxAD9bwOWQNmnpPr6ErWIAgROmCsJ9skNd9IEBdI5Kahm8AZrqu4J8ltolYN1kqEuga
         N4sw==
X-Gm-Message-State: APjAAAV9XVukoQ8nekF+wVNgIoBG0EjxITU11Ewm+N0K6C33laNpV5ai
        8rfXEB/v0oYiQ+aSwdXQ4A==
X-Google-Smtp-Source: APXvYqziy0dt5yKxPRpC/WI0aEFVwLEYWl2rCLc0y89G5wpDrqyJ0QCVbRi5gzlBoihgjYMXAFGgkQ==
X-Received: by 2002:aca:db45:: with SMTP id s66mr824655oig.59.1557248162731;
        Tue, 07 May 2019 09:56:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n3sm5590234oia.46.2019.05.07.09.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 09:56:01 -0700 (PDT)
Date:   Tue, 7 May 2019 11:56:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 10/14] dt-bindings: dma: imx-sdma: add i.mx6ul/6sx
  compatible name
Message-ID: <20190507165601.GA17194@bogus>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-11-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557249513-4903-11-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 7 May 2019 09:16:38 +0000, Robin Gong wrote:
> Add i.mx6ul and i.mx6sx compatible name.
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
