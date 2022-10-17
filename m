Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14D0601566
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 19:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiJQRbJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 13:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJQRay (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 13:30:54 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF466553;
        Mon, 17 Oct 2022 10:30:40 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id q11so6172701ilj.10;
        Mon, 17 Oct 2022 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8q4ui2I0PbkckThln1KL8S7Gv3bNjUbhV3T4UKkFUc=;
        b=LWQhQijW/K3QGTtSbzZcPYA000ASjJ1kn+xVcuG8p9zwsP53ifcj9jWnJ+S/JIIb5n
         MscYqdmx/56bCG9Lya7D9ZHNdRKg97dKEkxXYCS6ljMupabbP8nr3e7vyLTCfZFG5I01
         77YlPFIyARGCSnU6HrpwYpT3eh1WD9plur8N01+VK5fYIO7k3N9rhRpNq3tvXdgZDKm4
         H+svTlfD/f4ONxoRNOWK5anXeGD8u/uJWL7s6I8+AU61DPqH0Ela/mlkU9jfr5xbcfk9
         iulIzAhImVHe+Hu+xbti8GNqlpiAqEMYM5bpAae/wwVbucnmOoZqFN4dxUQFvXbUwF+d
         QnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8q4ui2I0PbkckThln1KL8S7Gv3bNjUbhV3T4UKkFUc=;
        b=PTmRQmwztklPSngdsmTnDzf6dMN53vLsS/tIL16+qlqA4yW7u3d1LZjDnsx74HCiJX
         MzzIM8En80+3YdYUzrJMsUZ7V+CBlhaNbPREhqYyT0cGmXUPHCdrqYy+8/py09Vn7BPD
         d6YK8ORBKdrqUMAS6WT6EQ6KczKM1hlSkGtMWHSpH8vK625nsU37PdAPBo/z++AyVa7a
         gwmoyJJBNj2ydkKE4hfHXyy8fFVg8BddDJp4/df5turkOjBw9NubR1DOHtFJGbFKecnt
         4GakYA9xDU2vSgQy/GaX91Hz++CCM/YljyykPVXwsgCZQTW4B+wHGk5RyhF/6GBT8IZ0
         dA1w==
X-Gm-Message-State: ACrzQf04iiEDEGLPPLPNnJpFpKSQ++AbSXSZ8h0I5DAWZ290csVrBrAD
        d12uw/jxGBeGTntik7zrIH6QYdg083aGTqqZHtY=
X-Google-Smtp-Source: AMsMyM4CrTJ6ZDzgjAcivdZiwngBUcCRna8HIl3nfrbF+OemFiWRHT+jPO25/qV6JOQykn/PXkrq60j+ldVtvrx/LGg=
X-Received: by 2002:a05:6e02:13ca:b0:2fa:3064:2a81 with SMTP id
 v10-20020a056e0213ca00b002fa30642a81mr5123803ilj.19.1666027778867; Mon, 17
 Oct 2022 10:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221016151256.3021729-1-lis8215@gmail.com> <20221016151256.3021729-3-lis8215@gmail.com>
 <895WJR.03DS0G5N9R0V1@crapouillou.net>
In-Reply-To: <895WJR.03DS0G5N9R0V1@crapouillou.net>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Mon, 17 Oct 2022 20:29:27 +0300
Message-ID: <CAKNVLfY87P6jTG8g5L_S84MUXCfL1Z0GLgAdZqD4K6h6ubJb-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dmaengine: JZ4780: Add support for the JZ4755.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

=D0=BF=D0=BD, 17 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 12:34, Paul Cercue=
il <paul@crapouillou.net>:
> Can you verify that?
>
> It should be pretty simple, if it has the bug you'll see I/O errors on
> the SD card.

Well, the result is ambiguous:

Without that 'broken' flag: mmc works poorly, but becomes more or less
stable when MMC clock downs to 6MHz (90% boots without errors).
On the 12MHz MMC clock the issue doesn't appear in 50-70% cases.
On the 24MHz MMC clock the device never boots up.

However with the flag: MMC works stable on 24MHz MMC clock
(boot issue observed only once), but if I increase MMC clock speed even
a bit the problem appears oftenly ( >70% of cases).

So, that flag definitely helps a lot, but the nature of the problem might b=
e
different.

BR,
Siarhei
