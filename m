Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18A4482783
	for <lists+dmaengine@lfdr.de>; Sat,  1 Jan 2022 13:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiAAMG7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Jan 2022 07:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiAAMG5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Jan 2022 07:06:57 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F144DC061574
        for <dmaengine@vger.kernel.org>; Sat,  1 Jan 2022 04:06:56 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 8so25893432pgc.10
        for <dmaengine@vger.kernel.org>; Sat, 01 Jan 2022 04:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=psk0MSRBE4bUdsGfwiJCoYt1d3iXURUAx3THJCXE1m4wMQbM4G2zakcUDY5U40qf6s
         01AhJfqYHntpVsokpgRGW0/DdNP5O4AeoUzJyDHb1i1Cu8zsr/sbxFxvThGN4jJJGE/G
         taDqJIHgPjvdWgNN9TIcu4NJ/66nE1blGx812o+UfVT1kphgVGsMWk+FN+tzXDpfy6tC
         nH4bMPjEYQvCxThqXNipeD4BFmhJdmwhqrYSBpbmUwK914aA2hKTY6FOQMT7OOqNSvr5
         ZA+GZ+TUONV97T1e+L9+jNKATFgOSe/2WFt0FPQQJz3nU8S9J9LB2ha2scSjXWKS8qIs
         gQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=hb/xQZjSMJiHMx05yR3pqsOT0DvnKwtTyHqBsDtAcWpS4bIePCEQEEBySfSNa0pIvD
         ynoaFOqyn7v3zqlyCL+OQgKmlT0X20SVkOQ3YL5NvKejzh/y8oCPa+Qvip4nX2DNgMbu
         2wB6BnL+sc0p0r0Ka5N+m+1U7ESrqCGVyVh4qCUdN0t8VUJTHrcHYR23tKcFarG9gSon
         4ldj4uDxrvH9nbV98P4EQU7+23LrRll4gltkPS+F6Ah0o8P4jLcjQjWHNJFB0VNagC7B
         L87fTj7ZwsdQhAEDRcQczKtXQFlZAzBKcLEeewFHa2S4St6iih1BeUIt9+5r0sPVmBlq
         eTag==
X-Gm-Message-State: AOAM530P+K0nVqBazYvmbr96+Y1FZ8h/D7V+eRLGegTXAX8RYOMLca/r
        9Fz1E/mX1PcKmVQ39mRntUc=
X-Google-Smtp-Source: ABdhPJxuqTusR10/Fp4hkVrnYBEvCeCuwISfKdtYBI/sRaOQrFHQmXTV52uJt3M9yTE3S1yu0ExjTw==
X-Received: by 2002:a05:6a00:24cc:b0:4bb:ffe2:17c2 with SMTP id d12-20020a056a0024cc00b004bbffe217c2mr24174747pfv.31.1641038816569;
        Sat, 01 Jan 2022 04:06:56 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id w13sm27606619pgm.5.2022.01.01.04.06.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 04:06:55 -0800 (PST)
Message-ID: <61d043df.1c69fb81.c547a.d7fd@mx.google.com>
From:   yalaiibrahim818@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 14:06:39 +0200
Reply-To: andres.stemmet1@gmail.com
X-Mailer: TurboMailer 2
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I want to confide in you to finalize this transaction of mutual benefits. I=
t may seem strange to you, but it is real. This is a transaction that has n=
o risk at all, due process shall be followed and it shall be carried out un=
der the ambit of the financial laws. Being the Chief Financial Officer, BP =
Plc. I want to trust and put in your care Eighteen Million British Pounds S=
terling, The funds were acquired from an over-invoiced payment from a past =
contract executed in one of my departments. I can't successfully achieve th=
is transaction without presenting you as foreign contractor who will provid=
e a bank account to receive the funds.

Documentation for the claim of the funds will be legally processed and docu=
mented, so I will need your full cooperation on this matter for our mutual =
benefits. We will discuss details if you are interested to work with me to =
secure this funds. I will appreciate your prompt response in every bit of o=
ur communication. Stay Blessed and Stay Safe.

Best Regards


Tel: +44 7537 185910
Andres  Stemmet
Email: andres.stemmet1@gmail.com  =

Chief financial officer
BP Petroleum p.l.c.

                                                                           =
                        Copyright =A9 1996-2021

