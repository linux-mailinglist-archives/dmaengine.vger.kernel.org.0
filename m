Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3235593A0
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jun 2022 08:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiFXGjL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jun 2022 02:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiFXGjK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Jun 2022 02:39:10 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFDF62BEA
        for <dmaengine@vger.kernel.org>; Thu, 23 Jun 2022 23:39:10 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i7so2885996ybe.11
        for <dmaengine@vger.kernel.org>; Thu, 23 Jun 2022 23:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=MUDd76TinUcA5JyTPJBAHn1VumWVzYjA1fKwU0h/HzI=;
        b=AHaLC6eUo9Mnfj7Z1uf5H+9jHP1A1dD6bhlZcqe3GDR/kirGluSY2E8QIR4apRwv0x
         d/HTq3apXpYDGuNfepEOVDrygtMzevci6iuFhkXpr8MGJCEfpuVcEAJADygFMmlWaJBs
         uk8Ysm4llXjYG1+BeVKOVplJEpmBfcQu/qvob28hbMvIAGN6wsjwry2VKd24YrUsCCcw
         WFKntwcNmFrgZQiZAYVbpsmGBvl5ykuTygDmsnh6OI5KSn8LwZqHFMPCvlEGvUN18NMP
         5L1Lv1vkrJRh38jxiQARjhQGcAyzoTiTL09vevXWYc6xXxIezADmVxKPxXdNkQ6Gr6fh
         2f/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=MUDd76TinUcA5JyTPJBAHn1VumWVzYjA1fKwU0h/HzI=;
        b=ARD9Lz6Oo2l7tOVlFP+fHMt0OHl2+Eb4lO9oUJvfsNat3V4/Bl24V4zBySn/Q/LPqX
         wreaBczLYCj7j7+5CxpLmnPEtOJHvZYXe+lgfQOUUf0Revf8yhU5GaHB7f7d4nRYIZ/l
         JlUT4Nfp2W6L6nWkpr2l57aQ52WhX5Hw4H2WD+zkEmnXQ7Dh8ZlVXDELN2QMxMh3X0Cp
         C5d/hzH1BqKlAE4/pAPlPePiQ+eCudF+8buSwUmdgKe3/RdQzifD32xrNvdRbUQGTEb3
         5EIuvrCRLdCjkZEaNLww32w8fP3Qrqir/2yvHW6wG6+1FubT6EjM/MtUethtdx9CJPDu
         RcYw==
X-Gm-Message-State: AJIora/TvNRXcb7+p101YOOEcGqhIfrCscZysI4HhHx4K6B3ud3EIYED
        zqkFPxs0Bf1DAH6Cz4/EEPWVtKyWcDS4vxOzs8g=
X-Google-Smtp-Source: AGRyM1sMvj9wxOuG+XGR2ew4fRL4vrDfWqvBVgEnt8nKKuBKcAUYAtjgvSPZWY/2FEWbeJXsVeqKCAESdha7NuiWpSo=
X-Received: by 2002:a05:6902:110e:b0:644:daff:1e6f with SMTP id
 o14-20020a056902110e00b00644daff1e6fmr13542265ybu.569.1656052749606; Thu, 23
 Jun 2022 23:39:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:e248:b0:2df:3cad:16e2 with HTTP; Thu, 23 Jun 2022
 23:39:09 -0700 (PDT)
Reply-To: marykayashsmm@gmail.com
From:   Mary Kayash <johnradke12@gmail.com>
Date:   Fri, 24 Jun 2022 01:39:09 -0500
Message-ID: <CAHEW3F7Dzy-+JigZ6bt43aryQ6uP95zqJ2AVT98mEeOxKzOhBw@mail.gmail.com>
Subject: Dear In Christ,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Please I want to know if the email is valid to reach you.

Mrs Mary.
