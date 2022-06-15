Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A845D54CF72
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jun 2022 19:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349960AbiFORLQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 13:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349893AbiFORLP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 13:11:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865ED37030;
        Wed, 15 Jun 2022 10:11:13 -0700 (PDT)
Received: from mail-yw1-f182.google.com ([209.85.128.182]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mq1GE-1nNWpB25qM-00n9gs; Wed, 15 Jun 2022 19:11:11 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-30c2f288f13so67861787b3.7;
        Wed, 15 Jun 2022 10:11:11 -0700 (PDT)
X-Gm-Message-State: AJIora/rlb+NWD306CsbyXaTrpEm2MaSjjPlTW9SJHgaVl0e+n1O3JJO
        viV+fllMntEFmER03N3ucaPsRsD27AY3SmienWE=
X-Google-Smtp-Source: AGRyM1s3W6+RTfK/zAiliPN7FcciReD9VjO+i3WcmGbp18cByfoPRqrc8ENsSK2P9DenDeE70xoIIb/pLq9Mty4V7yU=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr716680ywk.209.1655313070150; Wed, 15
 Jun 2022 10:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220615160116.528c324b@canb.auug.org.au> <1f8095db-a08f-7b6b-2cee-f530d914b9f8@infradead.org>
In-Reply-To: <1f8095db-a08f-7b6b-2cee-f530d914b9f8@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jun 2022 19:10:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2mQiWKyVux+bfAJiRH=72q76UTLZnBbPCLVFVoXpGfaw@mail.gmail.com>
Message-ID: <CAK8P3a2mQiWKyVux+bfAJiRH=72q76UTLZnBbPCLVFVoXpGfaw@mail.gmail.com>
Subject: Re: linux-next: Tree for Jun 15 (drivers/dma/apple-admac.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8pIB+MQNRZ+Q+hBsItMZ6JT391yz+hteDwMFY5EW6ObxEnIFl5O
 6oRtSJ2yI4hxs4jw2fOm29S6PqLmXIuHbQ6VKPK7+7NaEjZnVPzghnB9HN4QRrwE2LyCmHX
 0JJ2JEGvp6xjRukwnJRrwsH8kA6jTjl12N1X06uaIjXSkF54KTB15GIPYwTxTv+ABpd48cH
 A36gBReuikMbgyvA67H3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0fpu8GE+MPk=:PZKUHxggVN+/QafZ5AT864
 4q79TtdYpTSElim4NShpZtJEe6BYE5gw14hlH2UjblVTY+UvkuBffVwIH1jV7ofxSC74xGf7b
 uNm42q+yf8nMEqiRqLzwYHCD8e2dheJ9AaGbxbrNQLIyEu44vYh7pOgBUAcvn+ulcJhDv3cA8
 m01Xonz+b0ct4IeMciV9Q7Ow5iTDhRXhg1sjSNRnTp4t+6zNnitnOKKkAdwxlTZWUe+Y7KbFH
 ed6ihFWtZBzbFRFeDEbMy8cHzvMIbgzAW7KwuZKp5WBCfpx89vREq3AXn+I162HZAwxT15nEP
 N4b2WMFC9t+O2eMWSDIY65SVPvUmfT48+rIXkmEfoU6KsdHhv/hpydZXJXkWbivSBjlpYUxkc
 p5Y3+BOW4BrSUSKFEewAnTuihANeR7jYluv3adrqKXp9P1+iADFy7VjRSUITyUl3R08IJmxP6
 CWeSEocVRKnIb5W7fR8c6Gj9kRJwUHdB4ecXsdRzkUxsxJTxSAdu4cMyx65v3S6QeZruopgCt
 iSvog88cmk/xV0EUrD32MKwxcrvfmOiUbMse3g5KoQ1OGdR7KCMwbtTpjTuf8Zy6aHKhG6vMe
 f60ZOPZZF1XUpEPzYqnqV5NspFtTk/3bzSTu9S7uy3XTKaVeqr3r+t2i5dKl+kRMNxy1z8bVQ
 Pca46HycgkvWl9+XQD49TmF3yHSQpEkGedXw7MSK1o9OoUY35cww3mxjxzqAf0XN5aHTtM6XE
 m0pPFYLejrBbUlKBFTju7ixiJJoFA1spIyRtXA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 15, 2022 at 6:28 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 6/14/22 23:01, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20220614:
> >
>
> on i386:
>
> ../drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
> ../drivers/dma/apple-admac.c:213:22: warning: right shift count >= width of type [-Wshift-count-overflow]
>   writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
>                       ^

This should probably use lower_32_bits()/upper_32_bits() then.

       Arnd
