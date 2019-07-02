Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE75CFFF
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 15:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfGBNEu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 09:04:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39190 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfGBNEt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 09:04:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so11321444lfo.6;
        Tue, 02 Jul 2019 06:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I8L+XoxENRPPCU/GAaF+Dx63S13Wg9lzVgywMX6weeU=;
        b=uxw9ABVQi79SVaVgCaLAACIl3W8e0a9/6MJKJK6PdXoRMmZKKYjI8yKlpZKzy4023S
         m8NsLUh6Ja8pTRDOYo0q4toslV/Yh/QpH7fD9m22HS2U9WQuMObMn54IfM9Wuwy2ia3d
         H5tUi9zpCyF+K9oAev1HECPzy9usSMlBcIqQpFQ40DPChOX+pMbeQ35DHoWGC4imvDw8
         Bch96AQcaRFLCTJX/dBpdN6WWH8RYEFhP7FcwC7Qr7vGp33oVDwxX9Zs/uxVcji3Z6Ns
         pXMQMEcYh8Ivng1l4QNDAGKK7h6B+tgx13uCXp6LMiuIiJr6UJVjuc6Ore4cuzQqh27z
         fFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I8L+XoxENRPPCU/GAaF+Dx63S13Wg9lzVgywMX6weeU=;
        b=Upm491PdQahf7KVS9a4sT2dub/GEd8Cr5mUJgrGJsNLuDk+VNlhvAFsJjA92a5XhJQ
         iXwM8QJvumMa8fZe5SBHRZM3dWVTcjxu0B0BABRxQw7AqTG/piTX6fVUpJofVxYKhnya
         swk1/WjLAlLYvazheQ4Y8LB8AhTVQjQwvtyWydsZoBQu09CRCiMyxnox0kydCl6zB+RK
         OO+ANePzxPlfCDy6NaM+jfFTfZmi0GS4s4zp5AMNSRr34Ga+bH/ZbXaTnoCdkIocyyTr
         JFbQYXo0rPK57Bxr5hHv5/w8Zj8INokQvMLSFuEVlXJBDt4gsl2T0KqQ0J1CxT5rjp1A
         Am0Q==
X-Gm-Message-State: APjAAAXP7pL+AO5AGRbyVtNQBPxvfqPnJXB9he1tsfUdQW5tEEMBOcXW
        bhmAY+BeeU0ZE2wfjsXKgQYRXEAYVF8VzDLVKpU=
X-Google-Smtp-Source: APXvYqyENMpR07KifQWcS0D9x9VUH1KLIRDGZDHFzaa0+QZDuDjA0XI2xKLuxGXK5nmkIpPQTekK4uv/Zq/1jZl8KKQ=
X-Received: by 2002:a19:5044:: with SMTP id z4mr13972344lfj.80.1562072687507;
 Tue, 02 Jul 2019 06:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfx6HeJgTu9TiusGACyt+uXVSmnpibO0m-qzCvFQNGK7g@mail.gmail.com>
In-Reply-To: <CAJKOXPfx6HeJgTu9TiusGACyt+uXVSmnpibO0m-qzCvFQNGK7g@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 2 Jul 2019 10:04:49 -0300
Message-ID: <CAOMZO5A-XTtMD0g0ESHA=7bM4=HQjgTpzQq2BSYnPyd_1eG=qw@mail.gmail.com>
Subject: Re: [BUG BISECT] Net boot fails on VF50 after "dmaengine: fsl-edma:
 support little endian for edma driver"
To:     =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Cc:     Peng Ma <peng.ma@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Krzysztof,

On Tue, Jul 2, 2019 at 9:13 AM Krzysztof Koz=C5=82owski
<k.kozlowski.k@gmail.com> wrote:
>
> Hi,
>
> Bisect pointed commit:
> commit 002905eca5bedab08bafd9e325bbbb41670c7712
> Author: Peng Ma <peng.ma@nxp.com>
> Date:   Thu Jun 13 10:27:08 2019 +0000
>     dmaengine: fsl-edma: support little endian for edma driver
>
> as a reason of NFSv4 root boot failures. Toradex Colibri VF50 (Cortex
> A5) on Toradex Iris board.
>
> The user-space starts but hangs - a lot of messages are missing or
> seriously delayed.
>
> Please revert the patch of fix it. If needed I can provide more
> details about test system - let me know.
>
> Full log attached.

Does this fix the problem?

--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -92,6 +92,7 @@
                                clock-names =3D "dmamux0", "dmamux1";
                                clocks =3D <&clks VF610_CLK_DMAMUX0>,
                                        <&clks VF610_CLK_DMAMUX1>;
+                               big-endian;
                                status =3D "disabled";
                        };

@@ -491,6 +492,7 @@
                                clock-names =3D "dmamux0", "dmamux1";
                                clocks =3D <&clks VF610_CLK_DMAMUX2>,
                                        <&clks VF610_CLK_DMAMUX3>;
+                               big-endian;
                                status =3D "disabled";
                        };

I am not saying this is the proper fix as we should not break old dtb's.
