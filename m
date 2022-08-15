Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F6C594D2B
	for <lists+dmaengine@lfdr.de>; Tue, 16 Aug 2022 03:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbiHPA7i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Aug 2022 20:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343538AbiHPA4J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Aug 2022 20:56:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E13B4A1
        for <dmaengine@vger.kernel.org>; Mon, 15 Aug 2022 13:48:09 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h21so6460025qta.3
        for <dmaengine@vger.kernel.org>; Mon, 15 Aug 2022 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=ej3T27wdcOl5hgxFKEEvscpLUDARFbq7IX1O4+1Fbq8=;
        b=ZxcSrGOioSe9xEdDMedGhRHHFc6tlm5gmwbwnGdo3casqfVaqtrbKnFwDkaAWAV6Yu
         kdv8TFSxpO5c+r4VyaA2O+OUP1eGPTPY7nGyLn+BvVvMc3643hJ3axNoDrbe1ChWvIG/
         bCUNK0qmOmUTQOlxGEzpuwayfISfdBhuLkMf90MPn/1UwtCAOehV3r+1vxYzJnYzAzCF
         9rwPHzi8GsjJV1bqJw3pJtpTMC9Y1+DM6MgVSWIjZjNF5QUjDJyAEbLE/rQ4CSbKe1rx
         PKikAM4oBPczOYWC6R4VFvYaQfU92wvKqgp3UFJolMi3pybf2smWoYrRSOoq+CmARILv
         7nGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=ej3T27wdcOl5hgxFKEEvscpLUDARFbq7IX1O4+1Fbq8=;
        b=wIxdF3ouu43zjFCjSeAWIASyd3M2YpFz04z9h/WARll5d7lAYA+ua5Au0VTK/5h3J7
         AL8V0Z2GizOVgxZL7JIijvIIyQVOrUDd047PiI42n2YtQ37j6/kQ65Uf2go7Qq/kjncH
         we7MF7jnfndkPKT/f5ZamLiq038WdPC0mM2DnsT+SJKtZG8Jn9esFJbEFrmaQm7Bo/0v
         JOj0nCq4+pB9rKtosV/RMqFGeNeLrEEVS7ebFgw24QKnYxaPClyp163Q7RORJXhk8BMy
         Vt0EzJOyUbusySsH7mNRoLs6WUAbop/z5umMc0PobbNQaN4CD3vbEwV4vAGD5VMnKiKz
         1L7w==
X-Gm-Message-State: ACgBeo1OFEqY3shnRCUq+HLYXESfDIxInhR/dnUvosSx1rag68ea8B47
        1wbvO9cBzlC0fkur6YDnCgtiljBq88rpvKVRqWE=
X-Google-Smtp-Source: AA6agR5tQcE8NmliUI1dffBcVFPxpqbw9oV1LsCsncgLnox1abDAx8jfksXuwiQ6U0fzZ+SwIYCnpWRlgbqz8/VyfWo=
X-Received: by 2002:a05:622a:116:b0:343:7d5:e674 with SMTP id
 u22-20020a05622a011600b0034307d5e674mr15977915qtw.317.1660596488582; Mon, 15
 Aug 2022 13:48:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:ef88:0:b0:46d:3a61:256e with HTTP; Mon, 15 Aug 2022
 13:48:07 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Prof. Chin Guang" <dmitrybogdanv07@gmail.com>
Date:   Mon, 15 Aug 2022 13:48:07 -0700
Message-ID: <CAPi14yL3H81sTbs5Hku9nr1oS_Zyq0ek31JmkL+GVKZpZ=4STQ@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dmitrybogdanv07[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dmitrybogdanv07[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:836 listed in]
        [list.dnswl.org]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

-- 
Hello,
We the Board Directors believe you are in good health, doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

Sincerely,
Prof. Chin Guang
