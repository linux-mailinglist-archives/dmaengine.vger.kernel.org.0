Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5813DEF7
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2020 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgAPPiE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jan 2020 10:38:04 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40685 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgAPPiA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jan 2020 10:38:00 -0500
Received: by mail-ua1-f66.google.com with SMTP id z24so7781619uam.7
        for <dmaengine@vger.kernel.org>; Thu, 16 Jan 2020 07:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzUD1zwU0rAYKh4GeaUEkzHO0hgVckdO3UlIrWCkJwk=;
        b=ckWYYhKcKb2dT7sxw5ofXkMuaW2T6G0oFm+4I1V6e8zX5MefXp/STLeCkdZBNxk9MI
         neLrSF/Zm+xkeIuUx/p6cIwda217LAvMkqRheBadA9nNimTzyZTSrfmaqOR/CMoqkegg
         CsFoks/mMk2fK8FTgIa5gL7BHICvFOGcuj+LkBtrD96/RZcjo1sqeEpKX/vgbz5R7ufx
         y09r1/bp77UukJ7tvo0ZDo19yuZ7IP4uvq8igqiZatyxQjyY5x9Vc5WRgOn1D7EqO6EU
         xIPvGJt7CgkVt3kAyfGVCrGwBQ1+yzgUzkdriZQppQLw8BZT/wupfBCRLzxV1Kd0utFa
         0qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzUD1zwU0rAYKh4GeaUEkzHO0hgVckdO3UlIrWCkJwk=;
        b=o18cC7HgfIwuvP/PnMQHevsCzKobPiVxZRx8HU+jrEwBsCOH7jK77Vnnsuw3G5eQ6H
         6aHs8AISpn1TGKxPssGOTQD1ftYJHiy6lGrmLb0IC8tvLEu3aIRHz8HxHLHhYo2ga9QZ
         WNmd8cxILaKThnrJnTnuIAkKqBzsutEukRiDH8HmarfQkwqg/AV7ncp9az5Jvs4E78C/
         GDX6aUuKNbz2rpyKBh2cne0kmguRf5TVzAGLMFxlqiNKL8uk7en4zcly4TE6OuB2McIn
         wzOnWb15UrhiZCyLiYOGGMAmSI8q4oeUr2gJ80+yPN2cLMQLMIN1uTc71FGQzHV6zy3J
         NEfg==
X-Gm-Message-State: APjAAAXp1rC7augtRIk/3nHF4BI8XB5UltxJpgulub8WtpFZPzEjAMf/
        Fc7I7mVuRnXlSQLYPLlCoAXFkzTVYTNWne9C5fwHdw==
X-Google-Smtp-Source: APXvYqxIHUm57SaE/1DYL+57dh4bMqtXOA4yP6vvoIGdM8To9YtT6rURJfc0cAe4IX6fBKyQ0iXse1GSG+37snCem2w=
X-Received: by 2002:ab0:5510:: with SMTP id t16mr19495257uaa.15.1579189079583;
 Thu, 16 Jan 2020 07:37:59 -0800 (PST)
MIME-Version: 1.0
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com> <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 16:37:23 +0100
Message-ID: <CAPDyKFqbWrj5XruJW3ooQSzw51YAg2ukrjdBdkBx1szTU=5DJA@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] dt-bindings: mmc: fsl-imx-esdhc: add i.MX8MP
 compatible string
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        rjones@gateworks.com,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        sebastien.szymanski@armadeus.com,
        Aisheng Dong <aisheng.dong@nxp.com>, richard.hu@technexion.com,
        angus@akkea.ca, cosmin.stoica@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, jun.li@nxp.com,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org, dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 13 Jan 2020 at 06:37, Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Add compatible string for imx8mp
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> New patch
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 2fb466c..c93643f 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -21,6 +21,7 @@ Required properties:
>                "fsl,imx8mq-usdhc"
>                "fsl,imx8mm-usdhc"
>                "fsl,imx8mn-usdhc"
> +              "fsl,imx8mp-usdhc"
>                "fsl,imx8qxp-usdhc"
>
>  Optional properties:
> --
> 2.7.4
>
