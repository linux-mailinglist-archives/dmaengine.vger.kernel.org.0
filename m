Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843BC733821
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 20:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjFPS26 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFPS26 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 14:28:58 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412F3C0E
        for <dmaengine@vger.kernel.org>; Fri, 16 Jun 2023 11:28:29 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-39b349405d9so152563b6e.1
        for <dmaengine@vger.kernel.org>; Fri, 16 Jun 2023 11:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686940100; x=1689532100;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5vkrcWLUwWt0kF46OGRlmHZMNUuh1gu7zIZhWqT1j8=;
        b=VTVpOL00pwSIGcWumeZ2TYr1kK6D3RK8a6AoJjcLY/cblP417OAVR6dm2GWgSNQnyy
         2asJPsyALVnDdU29GiMXZy9EcTpJDeRlnfRmAwlNhbBisYquZL8wq5HV7YgpJdAAlscB
         sBVzpmNOOcfIlmd/oXn3k/KC49xk/yj9pEQ3oqqwqNhBb0LykE86uObGbwbSSc41lXpl
         kQr4yyvKAMb5/3GHVaHvEYhqe3hG1I3LMUlQjaZHLA9/g5oi1czAdu51lZsq+ymyaFCY
         uPAuvbcNwMI3IhW/juCqxz+mLYH0zNBp7r5VymMY2LBX8rZuPvd2N/Cft/ffw7ch1Sp3
         G6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686940100; x=1689532100;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5vkrcWLUwWt0kF46OGRlmHZMNUuh1gu7zIZhWqT1j8=;
        b=fLT6gBidd9EaxHTUjgHYuDxxyekHTRxqH4TdMp+414tkvw2VCPMMkRBqiIMWyAE7Cj
         lA0ZYVBEYlcnxZypUruWbAWg/xBGUoZSRslDobN94kL1f8vPc8M47ZLbLFOSCL5Ft7/j
         c9dWCpA47B7t71LyUnraCbt6FLeKQoDyjOyvR/Wr4IBvuXlUWITU2NjVVnCeB9PETkhP
         LoYEoWr4L/c6O2ZbcPBsOmkV/KKPOjPTWjJ1a0YJUZsEERSi/f+9Q2LMbedfLwBmVuih
         sWRlJHfIo+YjI/CVerX4ni2rMZ4IUr/hOAtD50WAMFquEf0b6DCPiPllfTQkOxV9et+l
         FL8w==
X-Gm-Message-State: AC+VfDz9gCvSpDAehdjSNDG62fggZz1KVVyfD1ylqF7Y8DTj7DLD807C
        MDyI/DDF7G8hOwdSVrBznpP3sUJX7S2+cjcdEQA=
X-Google-Smtp-Source: ACHHUZ4W4Ih/PONFqJont+JHARZ2PelCsBdG7G0Jo5EGETq6d8DWpJ2cbcYL056UECAmCiGeyOJmBzvyzj2vZYlqZVw=
X-Received: by 2002:aca:340a:0:b0:39e:86b3:d8ab with SMTP id
 b10-20020aca340a000000b0039e86b3d8abmr1984560oia.4.1686940100304; Fri, 16 Jun
 2023 11:28:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:729f:b0:129:c7f5:b8b0 with HTTP; Fri, 16 Jun 2023
 11:28:19 -0700 (PDT)
Reply-To: m_mohammed100@aol.com
From:   "Mr. Akeem Mohammed" <mken92144@gmail.com>
Date:   Fri, 16 Jun 2023 18:28:19 +0000
Message-ID: <CAObDG42os8orSZvvV0p1Kk_KndbZi_cvfAf3yQaWTSX=2ZwqwA@mail.gmail.com>
Subject: Hiii
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Greetings from Mr. Akeem Mohammed, can i talk to you, very important please?
m_mohammed100@aol.com
