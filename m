Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8F6252F9
	for <lists+dmaengine@lfdr.de>; Fri, 11 Nov 2022 06:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiKKFMk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Nov 2022 00:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiKKFMg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Nov 2022 00:12:36 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D076A765;
        Thu, 10 Nov 2022 21:12:30 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b21so3375745plc.9;
        Thu, 10 Nov 2022 21:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6AFisnUSRQfK8ABgK0xB4dwtfDA3SfhZ4EP16tnpQc=;
        b=PHM1BWy+hmTEJ1nC0iG0WU15ZFeuSdRp3oOSYqLsdisYBO/j5OtXJ8GOYfTkbT3YLv
         blbaMByAMjBMvfZDVH+KMcDE9WtqWF1/VrW4pF3WBmC5mZYWHjfqFT2FQJ6uPJGYEG6c
         XLpZsgRSggzTpm1RyRXSvnssqDZun8qYI2FyyL3Zz7NOhRmEMEdlEc8lTTWeVhTy8911
         ebaMD6B70Quqj1KJxlYAdr1HKZhvkMU8Bbs0s6Su4s7yzCY7yVwP8z7KLeq+1053V74q
         ATc2mE+4urY8yncyg54NtyMOqczQtVM/TmR/I8J0x54SNCxuXK/qUagFYpW1lDtSSJyA
         N4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w6AFisnUSRQfK8ABgK0xB4dwtfDA3SfhZ4EP16tnpQc=;
        b=Ixzg59BZ0X4pQ4pe/Qtbc/QDOEgnlR/+2cdlapo92Pfup2cdLjT2ByDjbs187fvtjU
         nmqRAP9tNpUNBfksr2oDVZhB9vZcsuLnBusVoJvxASrQw3HKCdco1iyEx3kQZVjqRdki
         UrRoQnGbpCCX7gqdosonDNbl7+5eaooeKWsAKdkaet0Csv8N6UKb47sHCep1Mwl4KYaH
         BPzs1SyZioCAzHbtkPkpTNVT995wfpQ5G/AEizdACaWmdcG4wCTGxxmgcePtv+zhN9V9
         D6jCdMaQSc20LU2iX3gyzt9nYcb7/Qyd5BYzUFmexrjqIUbfvtGQPzWPlwYNaOFikBuV
         uR4g==
X-Gm-Message-State: ANoB5pliT5Iv2UHOR0fePYOkCJung5UY97wMgvYuJpdaTqG8eWTPrmMl
        JMrBogXC2Jqf+FGAWSOIsDs=
X-Google-Smtp-Source: AA0mqf6nsG0qO3LUGUVkwyhQqNXSnwkWsIVb+Bxk7h9RY5lFQZCnJGRQs510q9Ad8ctt7ZHsy7UCrA==
X-Received: by 2002:a17:90a:7acd:b0:202:f88d:587 with SMTP id b13-20020a17090a7acd00b00202f88d0587mr69447pjl.232.1668143549632;
        Thu, 10 Nov 2022 21:12:29 -0800 (PST)
Received: from localhost ([122.172.87.196])
        by smtp.gmail.com with ESMTPSA id y28-20020aa793dc000000b0056c0d129edfsm570025pff.121.2022.11.10.21.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 21:12:28 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 10:42:24 +0530
Message-Id: <CO97J91UP8IF.23GNHUUM2KTVH@skynet-linux>
Cc:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v2 0/3] dmaengine: Add support for immediate commands
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Vinod Koul" <vkoul@kernel.org>
X-Mailer: aerc 0.13.0
References: <20221027051429.46593-1-sireeshkodali1@gmail.com>
 <Y2UIS7P0alvqT4jn@matsya>
In-Reply-To: <Y2UIS7P0alvqT4jn@matsya>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri Nov 4, 2022 at 6:10 PM IST, Vinod Koul wrote:
> On 27-10-22, 10:44, Sireesh Kodali wrote:
> > The IPA v2.x block, found on some older Qualcomm SoCs, uses BAM DMA to
> > send and receive packets from the AP. It also uses BAM to receive
> > commands from the AP (and possibly the modem). These commands are
> > encoded as "Immediate Commands". They vary from regular BAM DMA
> > commands. Adding support for immediate commands is trivial, but require=
s
> > also adding Immediate Commands to the dmaengine API, which is what this
> > patch series does.
>
> Can you explain a bit more. I understand you need "Immediate Commands"
> but am really reluctant to add another interface to support a specific
> use case
>

Apologies for the delayed response

BAM supports both regular commands, and "immediate commands". Currently,
commands are used by the Qualcom NAND chip driver, while "immediate
commands" are intended to be used by the (yet to be mainlined) IPA
driver. From the BAM driver perspective, both immediate and regular
commands are simply a matter of setting the appropriate flag in the
descriptor. I don't have access to the documentation on BAM to know
exactly how these two modes differ, however I do know they are not
interchangable. If a different API is suggested, I can change the
implementation as needed.

Regards,
Sireesh Kodali
> >=20
> > Sireesh Kodali (3):
> >   doc: dmaengine: client-api: Add immediate commands in the DMA client
> >     API
> >   dmaengine: Add support for immediate commands in the client API
> >   dmaengine: bam_dma: Add support for immediate commands
> >=20
> >  Documentation/driver-api/dmaengine/provider.rst | 10 ++++++++++
> >  drivers/dma/qcom/bam_dma.c                      |  3 +++
> >  include/linux/dmaengine.h                       |  4 ++++
> >  3 files changed, 17 insertions(+)
> >=20
> > --=20
> > 2.38.1
>
> --=20
> ~Vinod

