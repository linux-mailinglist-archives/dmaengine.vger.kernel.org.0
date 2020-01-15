Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AA613C82C
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgAOPmo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 10:42:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35183 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgAOPmo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 10:42:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id i15so16494473oto.2
        for <dmaengine@vger.kernel.org>; Wed, 15 Jan 2020 07:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZ89QzBAoQ2DzrvbjynM5ltUEoPFqx0Q/mdX+QC5z3Y=;
        b=NRzWzHXEw1mjDBvnU2TMIIDSTpL6rVX/OjatpHWDvQXwMWoFE87EyxdxjBPqNfFoac
         QutqTzuhztHQXO3R9F/boK8jKSk0uytRFC12GNlMaNrl9DZPvLAQ5nj8FXF0AdwAakqy
         VJTwelDyMuVZW1Cdz/Yuzs5KpWVeF+KzE+WdY0CWTmqeaOFwJufV0WIZb7WaiKF7ot2L
         G3AYesdI8887EgSITOIPBeCqCacKMicw6LvVH7zgrLkK9NUmvrQVOHWYh0q7nN46exIS
         8ck/tz1jTKLMnqW+nKAn1L228wVU5CeLpIgiv0zDd7yyYNzCm1oF8Ap7sshepFbwWT9u
         y3Gw==
X-Gm-Message-State: APjAAAUS8c0Ww0SIdSIYZ59YLEaCMklSc3ucSrs/CzcUtLlbLcCqqsmt
        jfp7YED4M6lMXpCou0kmeGk+xcQ=
X-Google-Smtp-Source: APXvYqxiDq1tl2lLdq4nQISv707bJT32+sJY8H40PpwSO19HjhmmExpXygBaLYcvntwUel7o8x3bZw==
X-Received: by 2002:a9d:6510:: with SMTP id i16mr1935750otl.142.1579102962547;
        Wed, 15 Jan 2020 07:42:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm5780284oib.42.2020.01.15.07.42.41
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:42:41 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22061a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:42:40 -0600
Date:   Wed, 15 Jan 2020 09:42:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, vkoul@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, broonie@kernel.org,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        rjones@gateworks.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, aisheng.dong@nxp.com,
        richard.hu@technexion.com, angus@akkea.ca, cosmin.stoica@nxp.com,
        l.stach@pengutronix.de, rabeeh@solid-run.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/7] dt-bindings: mmc: fsl-imx-esdhc: add i.MX8MP
 compatible string
Message-ID: <20200115154240.GA15071@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 13 Jan 2020 13:33:17 +0800, Anson Huang wrote:
> Add compatible string for imx8mp
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
