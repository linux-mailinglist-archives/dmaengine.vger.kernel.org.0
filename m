Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8678E6CA8F7
	for <lists+dmaengine@lfdr.de>; Mon, 27 Mar 2023 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjC0P3r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Mar 2023 11:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjC0P3m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Mar 2023 11:29:42 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C89B126
        for <dmaengine@vger.kernel.org>; Mon, 27 Mar 2023 08:29:35 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id p204so11057569ybc.12
        for <dmaengine@vger.kernel.org>; Mon, 27 Mar 2023 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679930975;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6+Q77am20M2vc0H3trIHbNhNfOFLQobOVqxzGMsIaOo=;
        b=lF2KDyfgZmootNE5y6YlZ5N6ywQahpTxoS5W5ApnvKWV7R27L+b4n9fUtlOxQAH5XT
         88acCujJc4sCDtBL6lp7ykqK5BWfoQxgiYkQjTikfkehVEvVhMtRyglwS7LL8IU+RUBZ
         RZDSlTGxwlQkl1f6vcIekaHvZCuMXM3CHTAs/C9LgUHjO/ZXUTZRkLRi49kWXs6UQxG+
         9h+SvyC3EjtAkaD2zzLqI6UQQb9pvYPDA4VBg8S0pXF2gqgCCfrXwNWHqEbDNF8i62Q5
         ew9IccvC00VbAchkwohtR25VeTMxcbxLQIyL2AJdP4BkWK/F08h3fTGCxsDasqT5DDWN
         QZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679930975;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+Q77am20M2vc0H3trIHbNhNfOFLQobOVqxzGMsIaOo=;
        b=8FhzmX4G+Ua3wcO9qwaKmQzF2k01nRyuoJeA3TQCfs7sN5Runx1Zot5b9oeMQre88p
         mSBMZVq1fjHsRY5dm3Doae1mCUe4lwpR09hAiPBHYmqL/KVz1WTup23VYWeVZPhbCdtY
         mvSpCLOeFY3O5XdJbg8YcSxOBEz4arv8TS+a8w5v86uKNzNmllvE85Cdy1+b5xRerSYW
         0d+ZPffycrKK11YplM5lnQ9xmPfFGie2obwvE6h3qzdMKWtfFtOcMr9M4HUOuQ/z8eyd
         ykf0NCtDLsL8C5w9q03deLgr5Gr4ldbTxP2d/nr2qtG4DN04eiItv2rys1Pu5PvdTkRD
         7llg==
X-Gm-Message-State: AAQBX9ePn53/c8sVE1GzuyGiQ2VIOgNvLg5kJwALq8sS5dNw1Cay1GGn
        sdiMlFo9HKAbWiKfVfTJ//8NV9o497It7z+IxD0=
X-Google-Smtp-Source: AKy350aAkKtZvHE4fRzpUoXMSPwjCPQEKAau94SUQJwzl1AJb+LKtw2gUYTyPSUBnpxF8oJ7X70TJp4t041e6bTV+2c=
X-Received: by 2002:a05:6902:1108:b0:b6d:fc53:c5c0 with SMTP id
 o8-20020a056902110800b00b6dfc53c5c0mr9964450ybu.1.1679930974603; Mon, 27 Mar
 2023 08:29:34 -0700 (PDT)
MIME-Version: 1.0
Sender: samsonka22@gmail.com
Received: by 2002:a05:7108:5005:b0:2e9:4fc0:88f5 with HTTP; Mon, 27 Mar 2023
 08:29:34 -0700 (PDT)
From:   MRS LOVETH JAMES <loveth.james778@gmail.com>
Date:   Mon, 27 Mar 2023 16:29:34 +0100
X-Google-Sender-Auth: pT13yCffFnjLXi_n624Uu84g8Ps
Message-ID: <CAKY8iZriCVL2fzB3KzPNaAEBrsx6sDOCy7mkVi+cp2rffc4LkQ@mail.gmail.com>
Subject: Greetings dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b41 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [samsonka22[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [samsonka22[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Greetings dear,


   This letter might be a surprise to you, But I believe that you will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god's mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to see the next day. I am Mrs.Loveth
James, a widow suffering from a long time illness. I have some funds I
inherited from my late husband, the sum of ($11,000,000.00, Eleven
Million Dollars) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest and God fearing person who can claim this
money and use it for Charity works, for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of god
and the effort that the house of god is maintained.

 I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death,
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincere and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of god's be with you and all those that you
love and  care for.

I am waiting for your reply.

May God Bless you,


 Mrs. Loveth James
