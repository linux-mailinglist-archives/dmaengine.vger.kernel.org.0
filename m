Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E375FA60B
	for <lists+dmaengine@lfdr.de>; Mon, 10 Oct 2022 22:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJJUWS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Oct 2022 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJJUWA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Oct 2022 16:22:00 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F269561B21;
        Mon, 10 Oct 2022 13:20:59 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id 8so6193563ilj.4;
        Mon, 10 Oct 2022 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6qQlkkQO5iVjIU1+H3cRSHc4fGnIENPMJr/c+nO5fc=;
        b=btaQTSQilsWlBEJLA9I+ngMKgerioIsD/4qCTCBczEA9G/nsDYLkrxOpiffgOItntR
         NtpBLv/Bvm5nH407QaKKhVrLANNg+79wDnu8N9rGa675Cj4bJh6MJGbP9NeYMW2KQCE5
         o0gvdde/3k+XeN/iF4vVrclEZq+h2asM7087sXH6OQQq0befz/8bKXox36ocFWlYlNSd
         2OKr5p6SDaXeLKGytH8BCALAVNLVSpVsG9zsAlu72HFBxquq98QIlbWw6aTXn93xvQt3
         3/VgdBtIbFenM7Urkuhyd0Laf5r7mQEdGbUF8FzWqp/Keq5t+fZG8jekEtDxhhMncV5F
         yWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6qQlkkQO5iVjIU1+H3cRSHc4fGnIENPMJr/c+nO5fc=;
        b=ILZ5dHTVmb8+XKqqEzW2D4GbVjwfyr74BUT/gyWSC9BqGW8AcyBADyX01syq3jPgnD
         U1Zeho1sIktJgFtiquRn7vvTm9lO2+VGeNyeJYZZjGBmS/XQJzR445qtkXlcRQJRpEw2
         MqWRYpHPTcFHbnHliJq39fgYNFusOjatYEvl7DRKvaLZAg+vZW5UuDaZMQb8VCpmygHq
         DAm3iH1aRUGEdiRob+2n6XVC1rY02ZMgHKng+05wT74l7iu0lLaygiz3MV6aO5Q4ASq5
         52/GoCcx/GmKky4gCTIIlVIFXX1XQtEr8V1rEywu8Ont5iBLo4jZ/w6pMmU6+d9oxDbZ
         KCiA==
X-Gm-Message-State: ACrzQf3MMj3T1db40dcUwO2PFcFuFdzmAFE00puyvF07ifCh3BKymupY
        3bA0zMIZeRUxgTBK0179Y5REPvJcD+mUoNuflWw=
X-Google-Smtp-Source: AMsMyM7MJ/3iL8pr1i3T89t2QytCmLtbwlxjx7s4hT0TAkKvpXTdZ+4IQcbktPmd6FrCxzEsj2CqgETBeJTctp/OmTY=
X-Received: by 2002:a05:6e02:b22:b0:2f9:b864:f1ad with SMTP id
 e2-20020a056e020b2200b002f9b864f1admr9899410ilu.298.1665433096249; Mon, 10
 Oct 2022 13:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221009181338.2896660-1-lis8215@gmail.com> <20221009181338.2896660-2-lis8215@gmail.com>
 <84b6dae0-d503-bbd2-d483-80462917afa4@linaro.org>
In-Reply-To: <84b6dae0-d503-bbd2-d483-80462917afa4@linaro.org>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Mon, 10 Oct 2022 23:18:05 +0300
Message-ID: <CAKNVLfZmjfmKb5ybY8NDhV-bQCQn7o_bSVK=aM4byftasW6dLg@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: ingenic: Add support for the JZ4755 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
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

=D0=BF=D0=BD, 10 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 17:55, Krzysztof K=
ozlowski
<krzysztof.kozlowski@linaro.org>:

> How do you plan to merge it? Usually these go via subsystem trees...

It's a new case for me, could you explain the problem a bit more?
What things should I bother with in the next patchset version?
Thanks in advance.
