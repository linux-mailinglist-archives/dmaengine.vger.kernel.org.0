Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC6D5FD4EB
	for <lists+dmaengine@lfdr.de>; Thu, 13 Oct 2022 08:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJMGhw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Oct 2022 02:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMGhv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Oct 2022 02:37:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04D411D98B;
        Wed, 12 Oct 2022 23:37:49 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 187so592717iov.10;
        Wed, 12 Oct 2022 23:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNhamnGFWcGOYQgKBpc4NUk2S/tQUkP2tXcVyRZsw7w=;
        b=d4aW4wNfEHhNXyr75oI4eP0P0/jj9mS3Yq4Xewq/VAfs/yi+YOj7xR7T9Iifrk8exY
         qty6B/1u+xVf39efvYVSQ7WElxAW4XbiqGS5W4zhff34t7nKvl4KVxYuiqj05miEa2xK
         D27giew9e0cP9xobx4bvEhsvPT+Xt4cXVWnLvKGNpm1Hlxxzd7eh+WTtaqabSFpy6+Qo
         xTJSnEhHPtwptVdrxC1C1DDPqLDaVnb2/H0PmYBOqgUL57wQhMCI4SCoSegDLmoW6Jdg
         fmW+nBc9qE0HYq0riPMvBowSSW156BKMR+ybHsUDbI0rGSg47Oll+jiikOU3H8me6kq6
         5qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNhamnGFWcGOYQgKBpc4NUk2S/tQUkP2tXcVyRZsw7w=;
        b=l/7j3OSDWbzKyG42id30dhhGxfM/tdn8fcKw/TKEI1W2dYXeUi9BrChoK3LjUtFAWA
         dbnI45tZf0vyaEgVzNq8McWZBSi0mW9bzTT28iW+qt+fT1bVe7b7+sJ66jnuvyVrNRS2
         HvqwqOpC7tBD5KHcujeBkohg4AD+Te8AOgcsv32T+/tKg1q2wVItuc18mlTJjfM+LPk0
         aM9I+XWG7ZW9GEd3gCKAgsJevLSxXe7XV/jWpEbidcnYjaQh+hIV8KYyBv1w6pOZKi8Y
         gQKKuX4YXmn8cxdPrqhoOj1qJPzInlywmGPV63B8oSgHaBvQSm24fsC88btKR4rs1vsX
         fkZw==
X-Gm-Message-State: ACrzQf3dL//V6AopN72LUbIH+vjd2Mgn4UGFe5MkbJr08bIENwbevN42
        sVYZozauoiJiT8SFafNfNfE/pOwKPH6PS+Os83g=
X-Google-Smtp-Source: AMsMyM4ELJz9R9H1jqMfQnPYwPEgtKghQ8aj+Oa+wwS+iJG1Es590FLazGuHIs7ncAaAH0z4hQQdeIryUql3pX9gNE0=
X-Received: by 2002:a05:6638:2494:b0:363:db4f:c870 with SMTP id
 x20-20020a056638249400b00363db4fc870mr5703669jat.65.1665643069023; Wed, 12
 Oct 2022 23:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221009181338.2896660-8-lis8215@gmail.com> <202210100607.YdxoR0tD-lkp@intel.com>
In-Reply-To: <202210100607.YdxoR0tD-lkp@intel.com>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Thu, 13 Oct 2022 09:37:37 +0300
Message-ID: <CAKNVLfaFvge4A8-QUzeq-JManpuYMGvyHXCJi-ew==CWN8-M=A@mail.gmail.com>
Subject: Re: [PATCH 7/8] serial: 8250/ingenic: Add support for the
 JZ4750/JZ4755 SoCs
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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

=D0=BF=D0=BD, 10 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 01:29, kernel test=
 robot <lkp@intel.com>:
> config: ia64-allyesconfig
> config: arm64-randconfig-r035-20221010

>  > 142  #define CGU_REG_CPCCR   ((void *)CKSEG1ADDR(0x10000000))

> 0-DAY CI Kernel Test Service

I know CKSEG1ADDR is MIPS specific, might be it needed to disable COMPILE_T=
EST
on the driver?
Since early syscon isn't mainlined yet I don't see any other way at the mom=
ent.

Any suggestions on that, folks?
