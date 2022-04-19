Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D23506C2B
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 14:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352203AbiDSMVp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 08:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352204AbiDSMVn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 08:21:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F892A245;
        Tue, 19 Apr 2022 05:19:01 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c15so20264371ljr.9;
        Tue, 19 Apr 2022 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nDrFtjiljqpCw2clA2M5Q4tAXBJlxJuWExBZE6ls7cE=;
        b=P01RsUocGzItJ2X501OWco/fT+uRAR+g65SjiSrgvpeADPdW+g493uazX7iSGAowan
         Nnf5rwEqvMlpwyvBd7g4GUn12AEA44LyB8b2gThooOn+q3JtBdH+o5vMsAECyMppHqAm
         q4Cjr6I6+KYOoWKIOXVzyekOkheFdw5q9Vz6c4Jhcc5faaxu25gRw6gpzIi/eOzpEHWm
         nmcwSpkLAJqTqnrmSNNdIug4ldD+K7BsYekT5qS9tQDJtW1MVKhYUvFJzrHA2afvwkzr
         1dH3A0fe8gmMefvR1wmdrYs1Y1+D4Y+dVbUtyozWQjV4gZsFTmrc40nwmtLTwZ9rp4N6
         Dx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nDrFtjiljqpCw2clA2M5Q4tAXBJlxJuWExBZE6ls7cE=;
        b=2sU5fJukleEsjQ12jinl1WgUBvzffLYCHC2NXRSFjs7vRkzn7mRGiEOtCuHCqgnmzQ
         u9OSMbnYeBh2Xpsl+w0wGb9IwkoBYobBro8mKz7NHtdcaxQ/ORMcgQcqkR0maDHnewVJ
         wO1UI8wA4ZxyhMfmSs3luylznqAvO/aeIMd9JfaHNoeWUFeFR+8hBxABw19bJQVb6y1N
         uL9Fn5+FT5Uc2dssqV1+Ti3Iy5m40ifo5TJCK1lt9dkgJYTbzAw9BkIngCmN2An1+5Ev
         /GWUgpIDsRHGQbydv4rirW69VsqcQEjJG7BjVZ6PI/oLePiyMP8kd3YIKou1ZzcZEeg7
         bP4w==
X-Gm-Message-State: AOAM530r4xeZMYdMV+Fspz49K/Y/s1b89Wnr1w2KnsiBke4bdGGQeODo
        f5jLF3hx3lCaFzO60/O9DZHhUuhq0YDQWWynwi/lW4RNabs=
X-Google-Smtp-Source: ABdhPJz4Xtzx+VFMw5LihUTv1eNyt+O9C1i9E/JkHh8cB0K/2OpE96/2uAbv1KDSvg5bjnlDblfCvgeQwTwY3zYitqc=
X-Received: by 2002:a2e:302:0:b0:24d:9eb6:8ae8 with SMTP id
 2-20020a2e0302000000b0024d9eb68ae8mr10240086ljd.77.1650370739301; Tue, 19 Apr
 2022 05:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
 <20220318162044.169350-2-krzysztof.kozlowski@canonical.com>
 <a8c5d574-c050-bbc3-efa6-9b45f5f27524@linaro.org> <03e28a55-d3bd-f3e1-f418-557306d65505@microchip.com>
 <61923e45-6594-6dfc-5e2f-e808af99e7c1@linaro.org> <9f8faffa-0b0e-2fba-7f2c-56c82ec7936f@microchip.com>
 <20b63bd8-b527-43e0-884d-bf9fe3cacb19@linaro.org>
In-Reply-To: <20b63bd8-b527-43e0-884d-bf9fe3cacb19@linaro.org>
From:   Zong Li <zongbox@gmail.com>
Date:   Tue, 19 Apr 2022 20:18:47 +0800
Message-ID: <CA+ZOyaiWPZm6TQ0H7mvOS6UqBtCy7R1GSJrZg1AmC=4xwVWxfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: dts: sifive: fu540-c000: align dma node name
 with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor.Dooley@microchip.com, green.wan@sifive.com, vkoul@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, geert@linux-m68k.org,
        alexandre.ghiti@canonical.com, palmer@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B44=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:59=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 19/04/2022 12:57, Conor.Dooley@microchip.com wrote:
> >>> Not sure that this one is actually needed Krzysztof, Zong Li has a fi=
x
> >>> for this in his series of fixes for the sifive pdma:
> >>> https://lore.kernel.org/linux-riscv/edd72c0cca1ebceddc032ff6ec2284e3f=
48c5ad3.1648461096.git.zong.li@sifive.com/
> >>>
> >>> Maybe you could add your review to his version?
> >>
> >> Zong's Li patch was sent 10 days after my patch... [1] Why riscv DTS
> >> patches take so much time to pick up?
> >>
> >
> > Oh, my bad. I incorrectly assumed that that patch was present before v8=
,
> > I should've checked further back - sorry!
>
> No problem :)
>
> I don't mind Zong's patch to be taken although in general I believe more
> in FIFO (or FIF Served) style.
>

Hi all,
Thanks Conor brings me here. The patch 1 and 4 in my series has been
applied into dmaengine/next, but patch 2 and 3 should go by riscv
tree, so I guess that I could re-send the patch 2 based on top of
Krzysztof's patch, then let's drop the patch 2 & 3 of another
patchset. I will keep follow up here. Thanks all.

> Best regards,
> Krzysztof
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
