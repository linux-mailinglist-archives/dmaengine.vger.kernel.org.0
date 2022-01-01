Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402FB482745
	for <lists+dmaengine@lfdr.de>; Sat,  1 Jan 2022 11:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiAAKaZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Jan 2022 05:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiAAKaZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Jan 2022 05:30:25 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469DC061574
        for <dmaengine@vger.kernel.org>; Sat,  1 Jan 2022 02:30:25 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id n16so21690244plc.2
        for <dmaengine@vger.kernel.org>; Sat, 01 Jan 2022 02:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=WHC2U5vtiQQ0K/89J7ts3TCnJfiZmmFC0XwzkDCgygNMQBKYC3ol2xm+3CnFVVapES
         Ob83J9MAbBeiQjrYuTfu0IpGcpuhqdsoyPaH0a3y3FVgLflYxUlM7hTFpQm1FJIgMp/B
         6Ebn+T15TdJgpGfpuAm1dLBCSZ16lSBn31fDF8p6e2t90S600o1KGkFqa2mGVnev5ZHQ
         zy6BWALOIf/ETj5ePjFuIc6itE7GtD8ZfN7Hfg030s9V2CK/Z+BQouom2gnwfu4ajtq6
         AtAumb0wUMZY/uYfaAYxqH1bqGJ2eILZXQZkXBHtr4EYssi785780PpV2qhJBdM0hQ90
         yjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=bY3UOxx0VRZCSgv3lWb3UgrefHeitRqIrK7pbm573a9lTIepnsfw1jx6fX4s6c0En6
         mpwOV/sxVz+vNzoHdCwAYM2iuu4syhx8So7g6Ny0oF+Iun6GaacpYRT6t7f3TTU/8QKp
         rucBoYGdbADw2pWtBElYkSPsgPDYo5/y3Ms9UEI4+rSLQhzrITw5/83hYaKKzX6lFukO
         q5z3/cWWSKTF/C4YTu9bwhfvYCNZUpIafmpc120X3u/wA0UrcglfKgj6WPiIr7iEQL/f
         AxiOrZk0M7F0tyDuLQ3hTc4Y8pZbzLqEYZwfunWzOfJL24oBPmFIn86k90uCgFLDuKZo
         XCrg==
X-Gm-Message-State: AOAM530dJHZfy1CVCAFIl2KSO86XoXBAuBBwMJDx72Iaph2h4Dy6UqT4
        F5iCzQP1FigF3rntNtfOzeI=
X-Google-Smtp-Source: ABdhPJyQxXxJbUjgzVxnTaRLPDxfeQTuQS1L1/CDkyAcQtSnsOjKwdPwXGCzZjnXYoo5nGzrJSsXRg==
X-Received: by 2002:a17:902:b944:b0:148:be4b:66dd with SMTP id h4-20020a170902b94400b00148be4b66ddmr38163400pls.63.1641033024712;
        Sat, 01 Jan 2022 02:30:24 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id c24sm17039024pgj.57.2022.01.01.02.30.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 02:30:24 -0800 (PST)
Message-ID: <61d02d40.1c69fb81.20b84.ed4e@mx.google.com>
From:   vipiolpeace@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 12:30:09 +0200
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

