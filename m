Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 320875D03E
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 15:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGBNLK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 09:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfGBNLK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 2 Jul 2019 09:11:10 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2C62089C;
        Tue,  2 Jul 2019 13:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562073069;
        bh=DMh8VAiW4j23dxHBYdwqpSzt+PEHyiAYz3LBrEYgS44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bV9Me7dkHZ2jA5IfDqhYDtI1pHt4S1XcdZswFAwxJlW6k6UFYC+l7dMTZGQLPkZJK
         LzJ/Z4wbRqDHe7r/1ZV7PgZh6M4sG8DTR6J1ZAs9H4w82Fk0wN8Gkbjf/2JaFa762k
         cE9yD6kaWN3Y4Z1G0+CGCxerlYTp0IxkgQ1Aqpfo=
Received: by mail-lf1-f44.google.com with SMTP id r15so11316958lfm.11;
        Tue, 02 Jul 2019 06:11:09 -0700 (PDT)
X-Gm-Message-State: APjAAAV7WAWXLMQykRsU/rJy1xdIjajAMgwLgGbkZ+o+4H8YrT5p4vxV
        JTU0H7Gh7rsL9KXbEHZDWCsh9MgkTcBK6m5F9V0=
X-Google-Smtp-Source: APXvYqxRfxfCOG8WBQbWTyTbYKTEBILbsprFNS3dDagJ3FUuiL9az56yVd8H9VPIQAr5aM+Tl26ahQuRD8y5f6z2qcU=
X-Received: by 2002:ac2:44d3:: with SMTP id d19mr14432915lfm.30.1562073067826;
 Tue, 02 Jul 2019 06:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfx6HeJgTu9TiusGACyt+uXVSmnpibO0m-qzCvFQNGK7g@mail.gmail.com>
 <CAOMZO5A-XTtMD0g0ESHA=7bM4=HQjgTpzQq2BSYnPyd_1eG=qw@mail.gmail.com>
In-Reply-To: <CAOMZO5A-XTtMD0g0ESHA=7bM4=HQjgTpzQq2BSYnPyd_1eG=qw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 2 Jul 2019 15:10:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfQHVGiLsL+FZ2jk-am=Xp6L5w=tLEQsGrP2TNLPgQ=vw@mail.gmail.com>
Message-ID: <CAJKOXPfQHVGiLsL+FZ2jk-am=Xp6L5w=tLEQsGrP2TNLPgQ=vw@mail.gmail.com>
Subject: Re: [BUG BISECT] Net boot fails on VF50 after "dmaengine: fsl-edma:
 support little endian for edma driver"
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Peng Ma <peng.ma@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 2 Jul 2019 at 15:04, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Krzysztof,
>
> On Tue, Jul 2, 2019 at 9:13 AM Krzysztof Koz=C5=82owski
> <k.kozlowski.k@gmail.com> wrote:
> >
> > Hi,
> >
> > Bisect pointed commit:
> > commit 002905eca5bedab08bafd9e325bbbb41670c7712
> > Author: Peng Ma <peng.ma@nxp.com>
> > Date:   Thu Jun 13 10:27:08 2019 +0000
> >     dmaengine: fsl-edma: support little endian for edma driver
> >
> > as a reason of NFSv4 root boot failures. Toradex Colibri VF50 (Cortex
> > A5) on Toradex Iris board.
> >
> > The user-space starts but hangs - a lot of messages are missing or
> > seriously delayed.
> >
> > Please revert the patch of fix it. If needed I can provide more
> > details about test system - let me know.
> >
> > Full log attached.
>
> Does this fix the problem?
>
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -92,6 +92,7 @@
>                                 clock-names =3D "dmamux0", "dmamux1";
>                                 clocks =3D <&clks VF610_CLK_DMAMUX0>,
>                                         <&clks VF610_CLK_DMAMUX1>;
> +                               big-endian;
>                                 status =3D "disabled";
>                         };
>
> @@ -491,6 +492,7 @@
>                                 clock-names =3D "dmamux0", "dmamux1";
>                                 clocks =3D <&clks VF610_CLK_DMAMUX2>,
>                                         <&clks VF610_CLK_DMAMUX3>;
> +                               big-endian;
>                                 status =3D "disabled";
>                         };
>
> I am not saying this is the proper fix as we should not break old dtb's.

Hi,

No, unfortunately it does not help.

Best regards,
Krzysztof
