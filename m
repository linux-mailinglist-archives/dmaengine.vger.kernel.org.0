Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ECB4F564A
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 08:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiDFGAU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 02:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360839AbiDFDn7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 23:43:59 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F92428A4
        for <dmaengine@vger.kernel.org>; Tue,  5 Apr 2022 17:11:07 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r2so1123626iod.9
        for <dmaengine@vger.kernel.org>; Tue, 05 Apr 2022 17:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OZD6KXu0/6DkCWGxPHcUUj7jLh83t4i0P+4wK8zulTE=;
        b=gXMhofgrwixuAFQTZeMDoHPwjzxYXVSYPTjQJ262jku+StF8mJP84bmxmMEpDmbU2F
         YELtJbSnV0p/fKy66y5YSPztyD8MZ6imDuezFajare38rAWsYzUTdkz4mcANJsZCC+Vk
         nER3w6kC0stInQvfW71odGSDmk7JCOpEJQZ1PHu90RoyUl9UdCcLaMUTlTZrs3JGVLW+
         +c8kL47vMBy16+jygp/aLUrRkz5VWh9MUyd/iZDzpS506qfjMUm9lsX7ud841JiJCMek
         7GtuMsY4phzBCRCMBNSVGSwLPUE0aRrZk3CH2JJ7O/w9X2QWN5WnSqUfsZXSIExyYq2U
         Jscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OZD6KXu0/6DkCWGxPHcUUj7jLh83t4i0P+4wK8zulTE=;
        b=eNhNq4gxRCL5inGfDY/kO3LdKwmVvBC13DwA3obtvcV0fFK3a4UJWltGGY5v/3H5Q7
         zfaRAOg2OB1s78z9Ja1JD7MBQZJRoY4UkgCszMjgNWYXqvuWZ67shHV3oLZe7n44iI60
         NG0WQ19r9bkPH4gW2/uB7B1FoOW9sySPe01VvaoIBo5sTaTIe15IN2b41i8rvtVoQ+Fn
         4z2H9q0k9poS8flXOKtAM5rDndoOJMW+4hv/Be5K21D7MiwlZQJdt2KgjfjbyrabAuz+
         muOJreHiZSdQWzsR+GButTyuDS+gzBtkXd9Qp7t5yH4uaSiSY21RyFR/J77GS59xvPHQ
         Va4g==
X-Gm-Message-State: AOAM531C3RCBWeSIWsEbRuBWaz21C+5gEpU+Sv6b5QzngfUkCNXVggNx
        htjcKMnGM6UMDfsqU+fCAS94tj9gBMDnxhBEPbg=
X-Google-Smtp-Source: ABdhPJyzfBh0b0KfauKv05nOGaa7V+retbrbUJyCEOZZpqtk8xAsT6A5gMeB5QVC8oqnpormbOn82dYzm41BMNbDC28=
X-Received: by 2002:a05:6602:2b8c:b0:649:4310:602f with SMTP id
 r12-20020a0566022b8c00b006494310602fmr2996018iov.13.1649203863731; Tue, 05
 Apr 2022 17:11:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a92:cc82:0:0:0:0:0 with HTTP; Tue, 5 Apr 2022 17:11:03 -0700 (PDT)
Reply-To: susanraphel757@gmail.com
From:   mrs susan raphel <mawaberge@gmail.com>
Date:   Tue, 5 Apr 2022 17:11:03 -0700
Message-ID: <CABzYZLzHNHgJZ0z3a-H6Erv5oUUUoWxHT+OjNJ82-W1D6CGukA@mail.gmail.com>
Subject: cry for help
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [susanraphel757[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mawaberge[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

-- 

-- 
Dear Friend,

I warmly greet you.

Please forgive me if my plea sounds a bit strange or embarrassing to
you. I am 63 years old. am suffering from protracted cancer of the
lungs which has also affected part of my brain cells due to
complications,from all indication my condition is really deteriorating
and it is quite obvious according to my doctors that i may not live
for the next few months,because my condition has gotten to a critical
and life threatening stage.

Regards to my situation as well as the doctors report i have decided
to entrust my wealth and treasures to a trust worthy person. Get back
to me if you can be trusted for more details.

Sincerely Your's
Mrs. Susan Raphel
