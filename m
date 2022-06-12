Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4685479AF
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jun 2022 12:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiFLKGG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jun 2022 06:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiFLKGF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jun 2022 06:06:05 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73B35046F
        for <dmaengine@vger.kernel.org>; Sun, 12 Jun 2022 03:06:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id u99so5518644ybi.11
        for <dmaengine@vger.kernel.org>; Sun, 12 Jun 2022 03:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=nqybdXDlqhWCIjF5VGtbumzYH2PqIH9LUW8rH6PqlQU=;
        b=b/Te/HV9cYJ19ojEjDWjic2DbXjq/8y6cGfGno0Xil8wSKumsaptrU1+y6QeZOE+J6
         PTgJxYQqEx1cY5PRa7PRmD5ZY2+XtGigISk+l0ysAmEPlkrZMGzYBjhZuGWp1pCJ529X
         pCOaFWUwu8enfzlIUX8NlMTgATvVqTgg/FIuFg3afsfI+g7pF18o0/bQO8haD3NwgBi1
         8BVJXfnrre9I3lfZaWKp8vx6MjZ1t0H20gj/eV5Jm0kPJTclmcdyIbz9LbvFpsr6x766
         jrBfHuivWIwJscdRcfllX7WUHGXFWkORJj0Fq/D8YPhMq8PavG+ZfXTtvq4g8/LFrXOZ
         YWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=nqybdXDlqhWCIjF5VGtbumzYH2PqIH9LUW8rH6PqlQU=;
        b=5nzkD5n7U+vF3nFDg6nkfhOtnlSgkbg7GpDyhvmuk0G/uPBQai7PEjGB1zoo88AEgI
         dBK+fy4czGY854Ixl2agp/+Jr/lZ3EpZqrkPgERS+Pxb0C7YXYNci4uMSO3WicsLMwfy
         +Me7jI0nQjli2N/MHVJHCPL1IH+uESw21fDaJKO1RNvlHY3LE1sTnvO7+J9CpIzihQNs
         Yzoux52uBjr9IIK8HLInVQ28c9v1q4Xq9cTNA4krdFSq3zPgUMHz2b9msSCwdv7m+9f4
         /VMS9q55eXceLPJD2SEhujYSqioriY5a6OR9bvIWXiPMgF+KtUS562xoiM3DrhRIR/DX
         P3Sw==
X-Gm-Message-State: AOAM532lsbcnn6Lx/LjB/PRPutAj1pJN9Ry1/It0PWfAwWRzk+m5Jcs2
        m7GWY5IFNhy8TiHS06j8izzR5ud1cw5ogblfOks=
X-Google-Smtp-Source: ABdhPJzjHBPJA1OfK0PU7VnS4TaDl96Mia8+fxS7rnywHzFeixop+TFFgS2u2PD8LtEP3ERJktRifDxnnai5PEWRfgI=
X-Received: by 2002:a25:5d0d:0:b0:633:25c8:380 with SMTP id
 r13-20020a255d0d000000b0063325c80380mr51303348ybb.167.1655028362873; Sun, 12
 Jun 2022 03:06:02 -0700 (PDT)
MIME-Version: 1.0
Sender: drfranksaxxxx2@gmail.com
Received: by 2002:a05:7108:6822:0:0:0:0 with HTTP; Sun, 12 Jun 2022 03:06:02
 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Sun, 12 Jun 2022 03:06:02 -0700
X-Google-Sender-Auth: WTv46niWBHFXNGZnAbBxwBHztZw
Message-ID: <CAGnkwZ5XrsY8tJ7S=RGnBZ=kmGoXyPy3vG1C=FSiFTEb2cVBuQ@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5417]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drfranksaxxxx2[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [drfranksaxxxx2[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
Mrs. Hannah Vandrad, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000.00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I am waiting for your reply,

May God Bless you,

Mrs. Hannah Vandrad,
