Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979476BFCB
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2019 18:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfGQQok (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jul 2019 12:44:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34144 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQQok (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 Jul 2019 12:44:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so9765623lfq.1
        for <dmaengine@vger.kernel.org>; Wed, 17 Jul 2019 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yk4XP9CZ1kslTNlitSHU1MG+UFO4IaHTa/axM5q+rdo=;
        b=F2vezRmfQSUXDCV1cPzbOl2mzviZagTPoHiu/ODYdsVpUBhK9w9YTNxRiMunEfJhbe
         3mqlmRvWWVWE6Wv2vMgJ/3fBXkb3weOGO4vSXqe1TpskMrzWhuzEuBnbHN2a2Hq7gQ+N
         E0BypQok1qcNIHv9hOwhsaElTu9JZ9Rqp2IpbKSGBiLu7ZE4GXKoNRauH2aKK/ljCC5z
         monU+OXeYlqNMgfB3NMS8HM2UQQH3Q12XmDlf9eAzdg0CjaNheV90gHdKVequ8iaodmB
         iPe07LMAM179eQNaYMQKSFAIGnaQEVwfW9GcMigIERJVLEFsmYpeY5n5M4g2gsHVL8c2
         047g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yk4XP9CZ1kslTNlitSHU1MG+UFO4IaHTa/axM5q+rdo=;
        b=WhKn9URVyWU51YI9SJn83ryX3WZtct1l2meeTCUVmBVhpAhkJSsxRaJvIX0qPfNSsv
         3HKicr8npJq+TbwoHUtSPT0fOIpnSAlw2YDVaXIgZhsjmlp0O1NPWInnwbb0iFV1nA6X
         DyV6EnrNm8mWhfcGXKTfcRnjK42Q7Rslk30nk9c69gilGxwFBQeVHuxi8ag8Jy0JXaT1
         U2VJ/C3QN8o2+uBMJcc9R4V+HVJM7/1EHnqopyMivkSFHWxYfrXp6y2augTcbrlngb2z
         6Oq9jgbmQtsz3+V9e2REQzPz4JoZtuwachShUWlVs6EzyMkfFzvwoM3wPnS8g8FReOo5
         BqAA==
X-Gm-Message-State: APjAAAVPgJjJCD9CV6TPqaX4HilzIxWLG/517T8Vvxf+Slwd80VWfGOn
        qupBPLdmQR6E5xkyp3tc8lA0N2pA0OrRwfMnaKGfXg==
X-Google-Smtp-Source: APXvYqwQLMvsudJ95j/wcOmtZU/P9Yg5GgR6Iscd/wl6FHMGs+YoknUb+sFGT6wakjO1DBNIm8fyfNl1xZoU/iz67ug=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr7368803lfp.61.1563381877741;
 Wed, 17 Jul 2019 09:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190712091357.744515-1-arnd@arndb.de>
In-Reply-To: <20190712091357.744515-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 Jul 2019 18:44:26 +0200
Message-ID: <CACRpkdaKNk3eE5cfh8fKQ341PhDxOCRqVz8Cay5to_ZZ3t_7Vg@mail.gmail.com>
Subject: Re: [PATCH] dma: ste_dma40: fix unneeded variable warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 12, 2019 at 11:14 AM Arnd Bergmann <arnd@arndb.de> wrote:

> clang-9 points out that there are two variables that depending on the
> configuration may only be used in an ARRAY_SIZE() expression but not
> referenced:
>
> drivers/dma/ste_dma40.c:145:12: error: variable 'd40_backup_regs' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> static u32 d40_backup_regs[] = {
>            ^
> drivers/dma/ste_dma40.c:214:12: error: variable 'd40_backup_regs_chan' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> static u32 d40_backup_regs_chan[] = {
>
> Mark these __maybe_unused to shut up the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Seems like a reasonable fix:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
