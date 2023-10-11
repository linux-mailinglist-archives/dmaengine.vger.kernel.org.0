Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB327C5498
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjJKM6A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 08:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjJKM5y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 08:57:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FE9B0
        for <dmaengine@vger.kernel.org>; Wed, 11 Oct 2023 05:57:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5347e657a11so11243699a12.2
        for <dmaengine@vger.kernel.org>; Wed, 11 Oct 2023 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697029071; x=1697633871; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DubYxiOgZnQ13XZl8rqUsBkiUvaaBjLBMGaI5G1SHpw=;
        b=iVjWBRIheJoL/4KK07mpfHdzALr+DFrvfr5b3oledgbuP5rrLwY77741p4ttvhcff2
         lPTabT1vGi0zwWyyS6EU3ZNYiMVwm3tAVYCEWUXyNjsfF5RuTx/FI7puy0nirt7AfrQT
         Uc6oI0+6la/CnHm6OtUA6eXCuNVO07b5j95vc7LU3+AI6BUU+De5OPnUdltkwFrGgi59
         n6ZKvbLGNcwbBrQ7T5rhSkJ7XuV4CCogU99RPjISD4puPxwxPbwgxmSMuta6+z0PtdSM
         QHqiGx0kgStLuLcHYHkkS6WomSTcE6SwkqHDS81hkTofBLO+ViR6+WxKwEGs5vdi/qKn
         aLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029071; x=1697633871;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DubYxiOgZnQ13XZl8rqUsBkiUvaaBjLBMGaI5G1SHpw=;
        b=HRAjDyEysp3WE3uoIjf6JcRVmf8Ok3qxBhb5C93DtOujOIyMMtCZIEdKakA5HTya3q
         iZk1rbSIhrQMbjSam8EIkkB+I0HtFNLCYe+BOa9O7T5XCoE0uA11uUQIDVlAm0Gfpdaj
         /hyJAvAmfRtcDHN67ojfG0UelnfvZZwkSjZXlSLys2ARJ54xsjc9VkEVPm6PLCwiZ08b
         DmSGaEjpHAynZSNB1FPjCi6xrAunGugPFfP5/B9x4HYk8NbtCplRSdHRBlMjQlGEWctT
         ZGmfhSjfRLd1pUM3JAVJ8J2QVgxKmehdb28YiVve0l8NG1fgB51UHBdo2B0HQF9oLdwI
         x0rw==
X-Gm-Message-State: AOJu0YwCNTiEQ3oTQD1AlnLejwDhEle2yu0osAXDKAyTTETKfsZ0IEhY
        Ia5mPaZ+CPJpOYF/btVyMaZbrZBEI9yPcKsnAcg=
X-Google-Smtp-Source: AGHT+IELHTEOSWhdrklJPeRTUOO06Xn17cWOru0LFUTVPSbI//FPlFggVGvJ0GxFArGSSTEYiP5EYn1UeqR4ZCguCu8=
X-Received: by 2002:a17:906:32d5:b0:9ae:6388:e09b with SMTP id
 k21-20020a17090632d500b009ae6388e09bmr19722131ejk.40.1697029071095; Wed, 11
 Oct 2023 05:57:51 -0700 (PDT)
MIME-Version: 1.0
From:   Mary Smith <jessi.usatech01@gmail.com>
Date:   Wed, 11 Oct 2023 07:57:38 -0500
Message-ID: <CAGjEitumEpbHEec_9WM6VOPHBZ-46YN-7Vtj4Crqza_FXRkudw@mail.gmail.com>
Subject: Re: MJBizCon Conference Registrants Data Lists-2023
To:     Mary Smith <jessi.usatech01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Wishing you all the best for the MJBizCon Conference 2023!

Would you be interested to acquire Registered MJBizCon Attendees Email
Lists-2023?

List Includes: Company Name, First Name, Last Name, Full Name, Contact
Job Title, Verified Email Address, Website URL, Mailing address, Phone
number, Industry and many more=E2=80=A6

Number of Contacts        : 11,968 Opt-in Contacts
Cost                                  : $1,599

All these contacts from register to attend the upcoming MJBizCon
Conference 2023.

If you=E2=80=99re interested please let me know I will assist you with furt=
her details.

Kind Regards,
Mary Smith
Marketing Coordinator
