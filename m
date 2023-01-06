Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C42660675
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jan 2023 19:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAFSiU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Jan 2023 13:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjAFSh6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Jan 2023 13:37:58 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3709E7CBFF
        for <dmaengine@vger.kernel.org>; Fri,  6 Jan 2023 10:37:57 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1322d768ba7so2434290fac.5
        for <dmaengine@vger.kernel.org>; Fri, 06 Jan 2023 10:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nH9cYiZVRVft8i5xKnlu+BzXoVM9je4X4PL8943d/Og=;
        b=ePbZd1bxIJUcRbdxV5Nk9PFGJiohRR52pww9vvUPABkxtKfaYUsL/oWm0U/DyCL0NX
         8Do3qp7gp5NydSFPrvnAIzW2p2rceE30k+pvQ6CYdvXmeAbmkYM5yzDaaPiRmQhgMCZ9
         r4o3OkozxH3Vy0SRNBRcgcmIU8ToIqqSweqTdL4gj6NYLnLgZlPSPwAQOr6mAgkDzejR
         XvlFJhrHZT3bDoy1gvUQwbLEj7Nuu/6hEw/MhzysP0ic9imCYy6z1zYca/E4p1CqoW9b
         8BGX0XqxqGFGDkqdaM6u9KDu+hii4evrums0kWqV3X/ngOuojpnWc0QIOA8pwOz6f3ep
         N4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nH9cYiZVRVft8i5xKnlu+BzXoVM9je4X4PL8943d/Og=;
        b=IX9Jq4Ost5j5tcwSFiQzGHbTvX3tHb8mCvJ853cy96y9bb8UKHSe7VKJ7UH/gwx6BO
         YAgKwaQUNLNq2GfQXRLwj+VBOi3fy07znfv8oovN3TwMKMp55e+EPKsJeYnIUQFovfp4
         Flfnw407R4vyexyH5cf3lf3bUdoM5TY9uRNu2jUvuYfRJOgHU3/Mdy7vHzPelmcTRqgO
         Ln+jk/1qGuCPDXnXnXZRytSF0NqVT5giDlsbuYPv9YtfEWVRaf1WCznBN3l+X1XjWnKP
         CO14UF/oAovsaUP5SciW+KkCVPMzxKUHnPTbjwpkihd5G494/yYgvxdlkjiFKKzyxhkd
         6qAA==
X-Gm-Message-State: AFqh2krtbHmIqNuV6cx1ARGVUq9at1I11UvfK1b5qZUthLM6bNGVaQzq
        l9dMU6aCc8dZMAhYmzelQQuerayRTYOiLcmNd6Y=
X-Google-Smtp-Source: AMrXdXscdFvS2/ho/a96/vRdpP01tEP20W1HPqpXGEJLgQyBlLb8c/JNXkVs5aIcbstvTGiEQt8wl271+xynm+UYjEk=
X-Received: by 2002:a05:6870:1682:b0:150:7fc3:e895 with SMTP id
 j2-20020a056870168200b001507fc3e895mr1970886oae.48.1673030276471; Fri, 06 Jan
 2023 10:37:56 -0800 (PST)
MIME-Version: 1.0
Sender: belloabubakar20002@gmail.com
Received: by 2002:a05:6358:998e:b0:ea:d5eb:1d55 with HTTP; Fri, 6 Jan 2023
 10:37:56 -0800 (PST)
From:   Bello Abubakar <belloabubaka94@gmail.com>
Date:   Fri, 6 Jan 2023 10:37:56 -0800
X-Google-Sender-Auth: L3QE8Uf3wzFLg4BTXL7MlEO9so8
Message-ID: <CAM5VdHEr+hGv_wLcBpkQpAp2jCMR3sC57POD64zW8V8W-NiWLw@mail.gmail.com>
Subject: URGENT REPLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5031]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [belloabubaka94[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [belloabubakar20002[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

I am a relative of a politically exposed person (PEP) that is in
financial regulation. Due to my present health condition, I'd decided
to write through this email for the security reason.

Therefore, kindly treat this as top secret for the security reason.
I'd after fasting and prayer choose to write not you particularly but
I believing in probability of you being a confidant chosen by chance;
luck to help and share in this noble cause.

I need your assistant to conduct secret transfers of family's funds
worth =E2=82=AC90.5 millions Euros. It was deposited in bank clandestinely.

I am in grave condition and I expect my death any moment now and I
want to donate the fund to less privilege and you will be rewarded
with reasonable percentage of the fund if you can assist.

Please contact me back for more details

Yours truly,
Bello Abubakar
