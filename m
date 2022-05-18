Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BB852C67C
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 00:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiERWpG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 18:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiERWpF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 18:45:05 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F09417789E
        for <dmaengine@vger.kernel.org>; Wed, 18 May 2022 15:45:04 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2fefb051547so39957617b3.5
        for <dmaengine@vger.kernel.org>; Wed, 18 May 2022 15:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=NDFi7zILqZNM42WCg6lZaedTNe2J/Qj2DBcJ9mpjS0o+C/ZCsKw83qRjGLu8j3UBUa
         NH4GMUAD5sOgackO00QkXU7SOGh+jFvY3YRnaQaVZNXNK16YQfl/aOrUmG3gpzGNuWO5
         MIRnakDmv8q78Ed/tk6HvNzSnrXomKUnXnw07hBqJyvF2NsTQVwJfa1TzvvfYHzzRbwW
         qd6PrDIcWlgIrYLUUlzNyMPp5Ri3sxiPFi9mId3ON+t+ptDeCfNkS5bblSWbMzghwwsR
         vDEfFX1fFJhTYz1PerflHDnzZTw8U7fCk6Q6rZASsEbTMN0+nLNSsdKXEQz611JgmxjP
         E0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=Ryd0PDz3DWqNPow+zAKeOox8Nzs7fdMXrJjAAQ8Mvuu0gjEcrn1jkyK0TmBV9aK+ee
         uDoyGI1ReTC5TTSZbk9mjwGy2cfW/Lc3gi1M1ceDPsguo0nOSsSD1aX7O5jUs/hC/VBE
         xRfMttP6ebyHAJmC/lpvaQJcGJip4eG6FHkrZy89A5L3Gb1Gw8hfTflP5bHkeDk9wNLn
         GpGak0govKdbboQ06D/i0d04upQnORGfuiakf7Htl/L4mgXb+NDR24wlUyRVFY91obGp
         TjiDSb+LpPwz/COBl2YDehyT+4FQhQp4prJyewAcOEHlQYy58RGO0TZmehiWkZR4F5XE
         jtlA==
X-Gm-Message-State: AOAM533jIlizExMbNbaqM1csjHN2Yx6QgKHph1vJaD62Azx/X82qZUN9
        pfoRIkT2oqCXtEvhW3ELVPdINM9GSIAQcq1aPhs=
X-Google-Smtp-Source: ABdhPJy1muPhUFAe4Ct5t1dz1l7OvwTrcmt0zG3y+occVLuuj91BFsOt6p7FADwt/vgruHhqSBpaRijpLutPVhYQfPQ=
X-Received: by 2002:a81:5889:0:b0:2ff:19b:3746 with SMTP id
 m131-20020a815889000000b002ff019b3746mr1836804ywb.56.1652913903916; Wed, 18
 May 2022 15:45:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7143:0:0:0:0 with HTTP; Wed, 18 May 2022 15:45:03
 -0700 (PDT)
Reply-To: tonywenn@asia.com
From:   Tony Wen <weboutloock4@gmail.com>
Date:   Thu, 19 May 2022 06:45:03 +0800
Message-ID: <CAE2_YrCihkedOJ2w9BTxOU0nOW-N+ZjnU2P_BJkWeCvOSX5pwg@mail.gmail.com>
Subject: engage
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1129 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4700]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [weboutloock4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [weboutloock4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Can I engage your services?
