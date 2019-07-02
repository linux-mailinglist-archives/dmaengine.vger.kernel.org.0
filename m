Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34AF5D15A
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 16:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGBOSh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 10:18:37 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:44647 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfGBOSh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 10:18:37 -0400
Received: by mail-lj1-f172.google.com with SMTP id k18so17047695ljc.11;
        Tue, 02 Jul 2019 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAL405WtuK+eb2kjWecuH6clFMcfEeJxF+EjZYWBccs=;
        b=IERAHN0J0WWwCpsB+rDD8lOPtnGyX4VwfwpmK93Bvq8Yqgs/oxUL7XXb8T8jWaJaOy
         hvjst6cIzIFPcUBRXJ0lRHgX8RimrIJ5Z1CK3GiEoM0YdAsepXkkwQPj6YkPdSaI7Jro
         GkT9mVtHIuxoVO1vtrjwXMfxb7ekykBzHEawgSD/DxiesyWHh0+5KB8viALCZNySkEgT
         Nzr1oTxwiVb+hbwB2WUjE4cSH9qhuDAoC1MEqKWC7cNeSYFEnCKHx7+W+sBL2YDj30p+
         /RAao5FBLSJQzip3QWQfjBjh1EZ2ArhMN2oZqFrQyrRZItPqccIjxjPIEof42JvjmuDf
         99Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAL405WtuK+eb2kjWecuH6clFMcfEeJxF+EjZYWBccs=;
        b=UrJmGwwNyz95A7TPhOrLaCl7uKSCFXdMOHr6g3JdCEfY9KRpEMVOt8VFNGknmG6OWw
         XY1v3v8YOLj2AuRL4ukYnf4K7zLzhQgvmbYwKdM5jqoJqeiAv1IUtfZeNZLtc+C6fTQf
         2BsSEkj+rJp/Ha/Gi2f5sRoC35cEqlmDD3Ef9MTlZUj3gOMKgbvp9UAhmrsFyuLaUnnq
         kU1aPSCf9RkayWbGsgtGeZvP9q/YbOX56DthA1Xaabb7sjLHbs6bbXf2Oe8/tNcHsb02
         s45kziN6oeldAHGG/k5xBd7BJcwmvloL332yi3zJUaoNvNPCzuap3GJDqXp9TnMecCJA
         2gNg==
X-Gm-Message-State: APjAAAUp9B5/mEY9P1U34BhaiN4e1D51zZF49/dB4qsxlIWHwxHJAxtg
        Yw860BgqomCQEfVB82vpAANlYITmfl3q8Ztpdgv2pBCAM/Q=
X-Google-Smtp-Source: APXvYqxpg7N+9Ol6MVilMHeS1g2RO0u8DFgpuDCXFOUtv4qCkqFYUGrKrfgylO/9OATB/zCXO0m+80FmaC2g9Wf/kDA=
X-Received: by 2002:a2e:970a:: with SMTP id r10mr11585591lji.115.1562077114749;
 Tue, 02 Jul 2019 07:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfx6HeJgTu9TiusGACyt+uXVSmnpibO0m-qzCvFQNGK7g@mail.gmail.com>
 <CAOMZO5A-XTtMD0g0ESHA=7bM4=HQjgTpzQq2BSYnPyd_1eG=qw@mail.gmail.com> <CAJKOXPfQHVGiLsL+FZ2jk-am=Xp6L5w=tLEQsGrP2TNLPgQ=vw@mail.gmail.com>
In-Reply-To: <CAJKOXPfQHVGiLsL+FZ2jk-am=Xp6L5w=tLEQsGrP2TNLPgQ=vw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 2 Jul 2019 11:18:36 -0300
Message-ID: <CAOMZO5AJLAGRrhjPdS4Y6PCEV77CiQUn3m8cxxGya2Lz17UuEg@mail.gmail.com>
Subject: Re: [BUG BISECT] Net boot fails on VF50 after "dmaengine: fsl-edma:
 support little endian for edma driver"
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Peng Ma <peng.ma@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jul 2, 2019 at 10:11 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> No, unfortunately it does not help.

Just looked at "dmaengine: fsl-edma: support little endian for edma
driver" more closely and this one assumes that there wasn't
little-endian support originally, which is incorrect.

Vybryd, i.MX7ULP uses edma in little-endian mode, so I think that we
should revert it.

Thanks
