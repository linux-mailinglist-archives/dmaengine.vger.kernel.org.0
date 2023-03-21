Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6766C2F9E
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 11:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCUKzr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 06:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCUKzq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 06:55:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAA129155
        for <dmaengine@vger.kernel.org>; Tue, 21 Mar 2023 03:55:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t5so21113887edd.7
        for <dmaengine@vger.kernel.org>; Tue, 21 Mar 2023 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679396142;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVw0iT4FSMRjIVx3X6H+mhmi1WAnugGzrc1l3XQuW3o=;
        b=awmAOj/kzNAqy2kY9hhPIkBVosyhUBjRPLy8fV2fJy6IdW4/oqq3JTjDArOJ9WSmxZ
         00MmqsiGcWrinLS/jItZnvYs4BOfC3xPvxTaHWBLeimvabbAPOT2+/7e0BScVfP33x8M
         Cq7CQdVxbDe8nMFDXtk4H9JL6viSZE8w50JvM7vBS+pLNLTm85j0kJ2HFJHa/0NI8N68
         D8pkgmCZbidhz7Jyy/L0n65DZcMZjxmK6eefI0BT8AOqIhLNF01j9D3iqf5rIGSbwY2T
         9pD9ZqYjBrHWt+yJa8Mi0Dlgnqyxa2rtBFMMuxEthbdiepkNzVMznpAcZigA3rdAciWs
         SjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679396142;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVw0iT4FSMRjIVx3X6H+mhmi1WAnugGzrc1l3XQuW3o=;
        b=jpVPjHNppplGItqoYnfvOWqrwcL0QC5dn8oCu8vPewzvyOGFVAqqVg6JyydVxTLvJK
         Lx120IdVCeMlzE0cvcAhVzD6MR4JRiefC/mrae3ZjmVmLZ91qofCuvXS2qufu0L5QxiF
         Pk7TGSqWro0NXuTheG1rtyutCI8ePyEofZ7gjXz7iUz6PqE1WgMh1dxzp+lvRtgjd66q
         IrE2TMZoNNqPARhLW3DNMI9agcsZUBoXHYlvA9NrIYG/3R46uWOHGb+HWnkBuQ2Du+Ad
         PC3k8y7D/FqghDXQ4sJhASIuKQuaUGrS/pgh8FpSp+t2m5ZQjcNqXq8tSLCbXUNvNDbE
         vRlw==
X-Gm-Message-State: AO0yUKXzjSp4WpWuGJT0RjtC7tL3kifQ6+hdkCZlKm6H/UK7ojvSZJcQ
        1GygKYsABxTHNnqXXq0po1k4suNA4d2bOhggOuo=
X-Google-Smtp-Source: AK7set8JpgvHxrOeGI9ilSUNEnktOUUu1GZAHg9v7xuCWeWAy1jaJ7s/O7d5f+u9zP5IjXBQKHWEc/bICHmWJYAkPNE=
X-Received: by 2002:a17:906:6613:b0:92e:a234:110a with SMTP id
 b19-20020a170906661300b0092ea234110amr1070641ejp.3.1679396141866; Tue, 21 Mar
 2023 03:55:41 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Margaret <wwwtechdataservice@gmail.com>
Date:   Tue, 21 Mar 2023 05:55:31 -0500
Message-ID: <CAJ55j2X0DUqrasWQPvgL2qSL3R9GbowDMU-xFbKgNdMQ1h7yjQ@mail.gmail.com>
Subject: RE: FINE TECH Attendees Email List 2023
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Would you be interested in acquiring FINE TECH Attendees Databank?

List Includes:- Org-Name, First Name, Last Name, Contact Job Title,
Verified Email Address, Website URL, Mailing Address, Phone Number,
Fax Number, Industry and many more=E2=80=A6

Number of Contacts :5,759 Verified Contacts.
Cost                         : $ 1,486

We do have an all industry list and conference attendee list from
across the globe.

Kind Regards,
Emily Margaret
Marketing Coordinator

If you do not wish to receive future emails from us, please reply as
'leave out=E2=80=99.
