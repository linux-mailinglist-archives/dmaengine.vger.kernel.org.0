Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7403B573E36
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jul 2022 22:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbiGMUwu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jul 2022 16:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbiGMUwp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jul 2022 16:52:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3F3138E
        for <dmaengine@vger.kernel.org>; Wed, 13 Jul 2022 13:52:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso132665pjo.0
        for <dmaengine@vger.kernel.org>; Wed, 13 Jul 2022 13:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=qtDzge8NR6GryD1E5KAuTjCPpy4A13nBq1VK8aOGTL5hVyz5lwEWFzfV7G5VJiCo3P
         2hdUzz0n7G76Ujt+Wes5UvfX/TjgHuE0udA5/7YmG17HV1IMnfjnqQJM6N9OkvGoitr1
         XSSyCf92HxyPIG8OkEWq+WE3fL9XIjFBChUycJ6AXPXb0JAB2C0UFHg2czgJgTfv58Dc
         2PyhLGkde5ITtYhTeAEUg+X4/kXwctqaLDL7P6kaXvKlWFe6YxLHTJf5+1iSjqlexlRt
         oAmyRvK4fxn471al8fsnD70ecEr/yw5osG0c8p8yH8VyElbELNupMfrgLdCSi+WGde+N
         ZiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=nQhaqRGGFLGvac5PR75Ql2+4ZkmgBkqzxhGUBoJA3Ku+vyDPlgzINKkKAOBQN+Zs+/
         IsEcO7WVCsqGzC7zmWucZCcQ0Uzka3i5k10X/Q/6Ejnw2bK0Z63xLl8II0GORk5OqWtZ
         WKi8iCGK0F+x8Twk2RUwiX0EjZpVzBick8+QL60Y1O/kWH8Ghf8vfH79jyO+hAATqaAg
         FZo+gVIvCjtaEGmw9z6EyR8JMj/Losi8stOhdlSkH8kr9U0qw74KGKf4ZXyqQDXC1nty
         6oyiMnpwwBItBSAd5LNg90fvEW2KuhUJ3fAdo4TrzaPpICTSfLPiyfsiZzVWEbxmN8iW
         Qw+g==
X-Gm-Message-State: AJIora+A/qgdOvRhs6DCbHyRhoM6ZNS+sFGes8sBzdRhG+Bjs0/2hUDP
        ta7safL7/9HDUb9duTYtMOGY4ENcSTofPg/YwmE=
X-Google-Smtp-Source: AGRyM1uUs9uoBdK5TbSHQ2ZSxVV2z+yhuCpoHODlUYVXfpjpldrZBJnwvyqHJCE2uCRrRyXRQD+7KX49fE2SQiAyE58=
X-Received: by 2002:a17:902:8a8e:b0:16c:66bf:1734 with SMTP id
 p14-20020a1709028a8e00b0016c66bf1734mr4909218plo.161.1657745563668; Wed, 13
 Jul 2022 13:52:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:626:b0:42:c3cf:981a with HTTP; Wed, 13 Jul 2022
 13:52:42 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <savadogoidrissaboursouma@gmail.com>
Date:   Wed, 13 Jul 2022 12:52:42 -0800
Message-ID: <CAA6zzomhPkaeLxYwpkL_aRL9zxjYziE==Pu1tT2UcUtTtq0ewQ@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1044 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [savadogoidrissaboursouma[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lilywilliam989[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dear,

My name is Dr Lily William from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
