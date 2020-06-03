Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D928B1ED667
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 20:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgFCSxA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 14:53:00 -0400
Received: from mout.web.de ([212.227.15.4]:56215 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgFCSw7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Jun 2020 14:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591210349;
        bh=7F6r5LW73SkyMamkRXQGUSJaJ9i1/pRDOcqL9DLIkyw=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=QGdyUPAfd6foz/CZDzljbLA14SrUEWVUN6zDbUNsWFS2e4nX7epgQ8I7Affu1mq4S
         ebGx9doVhwYdyHJyzi/kH4Rtfx1cfrkh691c+Kym8ReqaswipXAnnSQrT5mRh4z/re
         NfKjnc8tWXKAL5m77Kqa5RMferlPBKxi186uiMkQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.231]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPrwQ-1jbagx1m5a-004yTy; Wed, 03
 Jun 2020 20:52:29 +0200
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-mdma: call pm_runtime_put if
 pm_runtime_get_sync fails
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Message-ID: <873bfb31-52d8-7c9b-5480-4a94dc945307@web.de>
Date:   Wed, 3 Jun 2020 20:52:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LFgtFx/OT1Th7OxO55HEWjIgsKzljGMVBXU/JXtDSO9tpjt0k7M
 M+FtRQ+E22ElXdA6HhwXbCrld+Re0WGcZDijbXI3xC2S43VLbuOvDanE8UQFqjHP3YDVCPd
 +ZUuRHYZsNZgxppzcQ7Nlr+DwXxan/IHD1Rp6BEineinn6pQD5g4ofuxEn7He7yKRJKbr50
 xqWnCyWFwPKNBj1IZiTOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SI3bB6ZYjLA=:8uJUY1dPEM52b/VyJBchLo
 Ki2Qml/Wns2CVIny7eakOkRIj4RKfskUIbxvHQsCSTPNd1ZG6jT2XOWxAx/H0MvPpSDiVsasu
 JwrlP6GMhWDUdHum+LPdzBXb61shRiHGmZMAejJynZOHvxi/reqie7V6mCmK+GKnr+ghGzkWu
 RVX5TC4kKJ5gYlCWCSGc7Cztbpx4YfaHYyzByubcM2injH8TlA8qsuZYCbPbfMgF8fku3DWGA
 u9qTluTwZ60Z5mt3Fd+dHid34Xe9mxm4wUV6bOfe9RARZzj265ziYpWYYJQlb/ET12fz6n8Pp
 WBr5NueY8KleMZHQWnUX5Fkb4TPJF90eite0N4MU22ekpibwc57yBCI1sy35nx8HP42sgz9AF
 W7iHt64LXH3AJpk9dP3QcDkxmh9Hp1kk0pMUSotAcqryL8sRV93eOjTOCyokvXlERPLG5vD83
 Jm95IxK1WLsCafaF3y064Srmyt+IXfI0KtG0qtXFV+LwlVLzXHZSZTrRy+8b7OUF1A+T3XlcJ
 /peK+VCQV5MudKFgmJDpoZV47UsHAdgE2BiyKdMuyqN7xhXa6dpmgoIt67uJLsi5wsa7bEfx3
 cFC3iJpYYG3SNnB8ZvDwaFO3SK/BCJLHxwyAt/aYNZ4LQj/387N9ALQbAQOeBN9BP5YZCHiF2
 xz48zhl3fe9UoOG3gE3nKFJ6cFiaKMsM5ZsntQbGhw5e8vrugDhuk36stg8R+SHxMUi7TDSID
 /jFUOIKczakn7IA/vf21gY6vRbYvwzQ4dmj3mLBzxIQkyr3Kxhm/WcD0K6tU8oxWPRcZw2IGw
 smv3duRz7fJMsq6LwZuMjjuIxTGnhlW09jfCHs60RDk+nI7In9IhqN2Z714hhxFUh5Zt5J3Z2
 r8S4TTc/uOlSkO0uhLama6/QvjjNZ6lxqOYZrujFTjyj6mqN87QX1Tm9lSgpcJSLOC+mgg9qg
 Qs1bgcH8WgB3r2ZNkRPBPiYItk7Op3mrEh5WgYTSoYiG31/g3A7FFnNGAkFNylvYv8Ij/9cZ7
 Ltf34ciISsSO5wUmoENgKLN915DqPA2BqakeqZx6C8okOOd83TvooC1Jvtob8gBjXVofiAj3I
 szC1a24ZAUOWMammB1VwEPfM+SYf4dPRBSV1bNyA68eEpoSM3muy2wmqpZQVWnp2TufPf47iS
 mBF0fXKdWQNPRlTQIK25gCTMqJUHvDLU/eq+5VEYgHrvmVKV7nw3CJOMocBmOqOoDaqzmDhig
 5NtajeUM3ZIwbrs6w
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.

Is it appropriate to copy a sentence from the change description
into the patch subject?

How do you think about a wording variant like the following?

   The PM runtime reference counter is generally incremented by a call of
   the function =E2=80=9Cpm_runtime_get_sync=E2=80=9D.
   Thus call the function =E2=80=9Cpm_runtime_put=E2=80=9D also in two err=
or cases
   to keep the reference counting consistent.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
