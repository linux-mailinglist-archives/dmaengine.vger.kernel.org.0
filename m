Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB21ABA43
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 09:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439676AbgDPHts (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 03:49:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44299 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439552AbgDPHtp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Apr 2020 03:49:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id j4so2294589otr.11;
        Thu, 16 Apr 2020 00:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7EAKDlcfBCR0cNYDbFqTsIfPUpqN+dep+QQkp3mZTrY=;
        b=hOLK72tYMnIxD+/Z+Y4cepLomuWLRyvBXXTJ0AUbPwIDj3msiaJooKDD6r847Sn8/7
         qb5oKRf+EvRgL0zX+RfwLr1MxykN7L7O+Zybe+AtmmOtRWorfTkKdkjy3sXJqDGpgaW9
         soyeBtJvvyPOrUZGgrfM3xT8Tm0b+LbQdfNmot46m+cvtc6L8fkUI+bz3d9G0h1+sE0k
         XwkwG2mAua1QlmtyQ7GBiSg8iYbfy2Z7NgqyQWZdei9ryF5jJF89Q+vmfl5QWEZEn31t
         QWtU7rdlfC7yJ3hQ6pCfxJ1HfknbxUMJuP0cDVaE17ioqjW/7g+MMNZunajORIcdQL9+
         wLxA==
X-Gm-Message-State: AGi0PubYSVxqHlLkSNADrpcybm/jk8zxNUxAwWf9S4Qj/u78qhG9e9P5
        M5Y++hA3DCFBh7nYhUzkvCg0Jgl8TEfGwRA0CSM=
X-Google-Smtp-Source: APiQypK0AYhFdp7JA78l+ZC5c5vafaWm1QlZWNFK4hmOP12E7f5aW9lclWcmP2jqeUShv7YWP5JkmCvr62L92KmvRg8=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr25501635otk.250.1587023384138;
 Thu, 16 Apr 2020 00:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <1586512923-21739-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1586512923-21739-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWziQYKFeZZt7ZOCYMEWxD8e3mjqf+x0xsAcA7XDzZHWQ@mail.gmail.com> <OSAPR01MB452933886B2C83A6E054AE50D8D80@OSAPR01MB4529.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB452933886B2C83A6E054AE50D8D80@OSAPR01MB4529.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Apr 2020 09:49:32 +0200
Message-ID: <CAMuHMdXauwb2zwxUSPw_d-wZiOAfuo939r+TWYFVDjqmpbg_2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: dma: renesas,usb-dmac: convert bindings
 to json-schema
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Shimoda-san,

On Thu, Apr 16, 2020 at 4:04 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Wednesday, April 15, 2020 10:56 PM
> <snip>
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
> > > +  interrupts:
> > > +    maxItems: 2
> >
> > Is there a use case for specifying a single interrupt?
>
> No. All USB-DMAC of R-Car Gen2/3 and RZ/Gn has 2 channels.
> In case of R-Car Gen3, please refer to the Figure 75.1 USB-DMAC Block Diagram.
> These USB-DMACn have CH0 and CH1

Thanks for confirming!

> > > +  dma-channels:
> > > +    maximum: 2
> >
> > Is there a use case for specifying a single channel?
> >
> > > +
> > > +  iommus:
> > > +    maxItems: 2
> >
> > Likewise?
>
> As I mentioned above, there is not a use case for specifying a single channel.

Hence I think all of these should have "const: 2" or "minItems: 2".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
