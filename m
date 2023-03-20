Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C46C1FA5
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 19:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCTS0Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjCTSZW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 14:25:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D303D906
        for <dmaengine@vger.kernel.org>; Mon, 20 Mar 2023 11:18:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y4so50431633edo.2
        for <dmaengine@vger.kernel.org>; Mon, 20 Mar 2023 11:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679336290;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uVVx652hcMKMJrY2/TW3X5uhdHnpbhSboZxjUwpyCmQ=;
        b=LCPQpO+/TIMoBmEv9zdmvK7Lh15i5OPYxBaVV5AXmfMyEiOGyAyKVEN48pMZpZjoBx
         cldkdBGQnCveMh3VaGERnBg7mNj5JtDxkaAyt8YH2ckCJ+WL3FkgjNrG1nmtfn8XJTs1
         SrLcLSFoVig+wJErYSKJFd0Hu18lKXwNczvOFbAPlkhay/Kj7IiKsROduF9bbLIUKuVy
         4nM62dwzjJyvePwqw9v50d34MbRoWsclWgaWYgJZtd13eygML3AZ6rlSXApM7gsXWqMb
         oGBss1d9SmAJDxlS5p0rLeXeWxGcJ0iP2G2009F+fvoAmxZ8+akCMeA3dpKRQ5Q5HoiB
         DhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336290;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVVx652hcMKMJrY2/TW3X5uhdHnpbhSboZxjUwpyCmQ=;
        b=64oO/QeG+JlbTacnl4cMqj7bwRoFRdIAhKDNO5ER3w8emhM52CB9Jiadn8772jD5cA
         VgvRe6y4dEeMao7HF5k/n+InRFFWUafrUGLfKmVXT8Y6jsqgUgAKgd6z1+ADxax6Pwv8
         YVGqGJkwDw/zKo7rYyJ8uO5NmJPMy+4S4hvhWu8GU6+dVvu/JL/9TEl/5Rws9heTMzbR
         C0IPaofPb9GcQ/3oV8ju9syxkyJQ+IcRg+LTv2fKSTzi9g0w7zoOU5kypwNUBwLZB5Ah
         BxR/mnqz+2AH4AKbRInSU7U+ABlZ60nCWVuUFYXrFpceNrz1mA9xn105y/UyRbjzaaxH
         RvJg==
X-Gm-Message-State: AO0yUKUBkKGjZHEYTNpuE+XYXMrafISIKzClXOEEa1DFGonXZ7lDCizp
        FHBXMlnS3tmkuebmXX0SmyQdfEt7usxkhCDnUQg=
X-Google-Smtp-Source: AK7set8rfQQqUkj+svHwzbF1jndD0qaZCeRI8o2TU6zQiAC2h8QtnFxxqt97uqqNCsT4vcVYlTdvVRfLmoUzRH80vSI=
X-Received: by 2002:a17:907:1def:b0:877:747e:f076 with SMTP id
 og47-20020a1709071def00b00877747ef076mr25298ejc.0.1679336290427; Mon, 20 Mar
 2023 11:18:10 -0700 (PDT)
MIME-Version: 1.0
From:   ANNA MARIA <usatopdatalist789@gmail.com>
Date:   Mon, 20 Mar 2023 13:17:57 -0500
Message-ID: <CACe2vLVc=H8oiyCfAJ=UCzuPwSZpEPfUXA=TDZUK-MhYLtfGFA@mail.gmail.com>
Subject: RE: Fintech Meetup Attendees Email List- 2023
To:     ANNA MARIA <usatopdatalist789@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

I hope you=E2=80=99re having a great week!

Would you be interested in acquiring Fintech Meetup Attendees Email List 20=
23?

List Includes:- Org-Name, First Name, Last Name, Contact Job Title,
Verified Email Address, Website URL, Mailing Address, Phone Number,
Fax Number, Industry and many more=E2=80=A6

Number of Contacts: - 5,386 Verified Contacts.
Cost: $1,326

Kind Regards,
Anna Maria
Marketing Coordinator
