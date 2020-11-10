Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6142A2ACF57
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 07:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbgKJGAn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 01:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731049AbgKJGAl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Nov 2020 01:00:41 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198A4C0613CF;
        Mon,  9 Nov 2020 22:00:41 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id oq3so15755689ejb.7;
        Mon, 09 Nov 2020 22:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bE8WeeYQEHFtF17RNP5Oxj6GxutlBisvy7hbOEQf1Ak=;
        b=OR07CcuVrCF6wYXaQDqlo/K8SH9Dw4xZULiQzKDVeg7I2cRTq9QNjisDaOAgFX7MfG
         ef4T9zjaSnxv/bbLbrScydAvkL7BjpinwWjJwvr35EYzojjVRrt96iEiWYH8H24miseF
         /0t+KZpK7HL7kihrBQF3skChsuuB081Fy5UQWnzSRWbkX8z5cq6JWgTXLtMs0+sL8nJp
         pJ/QPgquVxPVkAAfcU1cUCgbh/55gVopB+l+ZWO+bt7Hc90ztbv4Mc/0NG0jDHSoPtmJ
         lbfc3qzLnVmEpZqa8oIieKnK+k0FViYNrDT6XD/3eVm2YMVq5qH6gWHn0Wukcfx6nRyx
         VHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bE8WeeYQEHFtF17RNP5Oxj6GxutlBisvy7hbOEQf1Ak=;
        b=ScfotcBJV3RdvcFybovgu6LX6ZoMhaElIhAnIdP0N0TtC345y2qm9o1++zjQGrOyOV
         WitK8Ddf6+pDRgvCi8P7kSuxcCpahAr3+6vBC0NcoWr0htNtppnInKuqy3xPptpi4r1x
         fNj3ZE5I2udUwR6uAvh7Gr/hWeaTAhiwq99aASrNXXLybsbr4CA23Jly1DwSOKXw200f
         hdidN0mYjx5b1ZEcNJW6pGlpsi9Xz8VWddHKt0UcgvepdibVkti/gs0umyRRIOo0j4No
         jcp6xUcA8sua9KhYlxPLDLdU4whhkgGLhqyemFlzbaqTlT9xy4WkzpZX72EmxUjhezMQ
         bd8A==
X-Gm-Message-State: AOAM531LZmRqm3K8FW/n36rWoEicijCeUXzs7OTOq1sutGF4cvHlGv61
        dLG0yGLIkrAs0WDYe2VsNyQZNFHrfR0IxGccBjQ=
X-Google-Smtp-Source: ABdhPJz4mf96R6on9ZrpE6+hnIU7ZS3/XWcV1xcgyurHVQJVJmer6zC2N74MUy8lKIxMalPHU5n5gkdaU/rcrB/Uir8=
X-Received: by 2002:a17:906:5a97:: with SMTP id l23mr18192217ejq.232.1604988039859;
 Mon, 09 Nov 2020 22:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20201110040553.1381-1-frank@allwinnertech.com>
In-Reply-To: <20201110040553.1381-1-frank@allwinnertech.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 10 Nov 2020 14:00:28 +0800
Message-ID: <CAEExFWsc4Rx2U+BVuqTJkL0wj-gdNcF=emJRcStQ2Uq=FQEx1g@mail.gmail.com>
Subject: Re: [PATCH 00/19] Second step support for A100
To:     Frank Lee <frank@allwinnertech.com>
Cc:     vkoul@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kishon@ti.com,
        wim@linux-watchdog.org, Guenter Roeck <linux@roeck-us.net>,
        dan.j.williams@intel.com, Linus Walleij <linus.walleij@linaro.org>,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        marex@denx.de, Colin King <colin.king@canonical.com>,
        rdunlap@infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        rikard.falkeborn@gmail.com, dmaengine@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It seems that sending too many e-mails at one time will cause some
emails to fail to be sent out. I will try again.

BR / Yangtao
