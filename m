Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53B2753DD3
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jul 2023 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbjGNOmX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jul 2023 10:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjGNOmW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Jul 2023 10:42:22 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E94D10EA;
        Fri, 14 Jul 2023 07:42:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2659b1113c2so289718a91.1;
        Fri, 14 Jul 2023 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689345741; x=1691937741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaRLovlCHBbMUiBNLoIdFoM85ym4VDWRTXjihMydlzU=;
        b=XshTf99EO+tBcdMPMaAgMyAUPpB+bW/Fsl28G3dOmq/2kw5IsPLUZWY0nsO8BowGvG
         7mUYSHMaQPkyor5BtVeZSpfvsqEAdLRyXPWM9PPpSZqj0T/qwEh1HfJ4sQaLIGygOcmA
         fhnIVSGCdOokF2P9Ux+VzCoBSFhuJHZ6xS0XvTYyW5Kkmau5tw8zLjZiJrHYLeiFpQCm
         MBobO7ZTXY3Cac0wwYda1k0kQN73AEBrBmC/FKy2xNTLZAe2HOYXzT6MTgomGtURegtd
         Cm5Cq15d7khT7H9GnNYn91+7G7UeETqh3MfFDKbYc7MtTxz0QyhSCk9CoXM3VTgjvbWz
         RCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689345741; x=1691937741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaRLovlCHBbMUiBNLoIdFoM85ym4VDWRTXjihMydlzU=;
        b=W1q+V1DK8/6JebkBTgTqb/7/8axiyn5JH68GnMP2+DAjd3k43hCySxw9GcFRKHH/gB
         BkdUgT1R0Y4w5zWRmc4vjJvp6r31ObWajrfM9/UNYgQLsSrtUeie6YP21d4i9nnDrdvF
         IPW607m7kBuaOpNrzrUdKggt2LDhdnksn1QovADJy1E9lVo8uHtzOtTuGR79h3JMMt0p
         DOtoB8Es1brzMEU3hnkf9e8dt3gf1g3X1W6MVJQlx4THCCEomDPHo+vtRqidSyYUVH1b
         97/dPS4exezbnzwtwAxlZhW1Jd3pCrj5MEajzSzv5m7b3atUOYLYbUv5Nt4h6BCU7c5i
         K2vA==
X-Gm-Message-State: ABy/qLYKk4OcjkloYd4A3WSstxtyC3lHDI311OKtqredDzJbv1fdV/hG
        jycI1QtefsMDpG1OAJKqxWFKObs8yatTYNnrJLnZSEtQwhY=
X-Google-Smtp-Source: APBJJlF6k2yTJ2MJv7S7Oj8SsdnOpI/8ce/piOjG6djAzZa/79HQxFmrxWnNNoFa9ZYrL7gcurHgEzUqDEt75wfrhEo=
X-Received: by 2002:a17:90a:4f08:b0:263:25f9:65b2 with SMTP id
 p8-20020a17090a4f0800b0026325f965b2mr5058689pjh.4.1689345741008; Fri, 14 Jul
 2023 07:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR08MB308979EC3A8A53AE6E2D3408802CA@AM0PR08MB3089.eurprd08.prod.outlook.com>
In-Reply-To: <AM0PR08MB308979EC3A8A53AE6E2D3408802CA@AM0PR08MB3089.eurprd08.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 14 Jul 2023 11:42:10 -0300
Message-ID: <CAOMZO5A4NbZAxB5MSkQqXW+wknXAz_xViTSmyfBakJjz9Ja1Gw@mail.gmail.com>
Subject: Re: PROBLEM: deadlock when imx-sdma logs "restart cyclic channel"
To:     "Tim van der Staaij | Zign" <Tim.vanderstaaij@zigngroup.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Tim,

On Fri, Jul 14, 2023 at 11:36=E2=80=AFAM Tim van der Staaij | Zign
<Tim.vanderstaaij@zigngroup.com> wrote:

> # cat /proc/version
> Linux version 5.19.14-yocto-standard (oe-user@oe-host) (arm-poky-linux-gn=
ueabi-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39.0.20220819) #1 SMP Thu O=
ct 6 18:16:52 UTC 2022
>
> Note: I didn't test on a newer kernel because the diff with this version =
shows no relevant changes.

5.19 is not a supported kernel version. Please test it with the latest 6.5-=
rc1.
