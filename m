Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF611EDCBA
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2020 07:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgFDFnu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Jun 2020 01:43:50 -0400
Received: from mout.web.de ([212.227.17.11]:48187 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgFDFnu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 4 Jun 2020 01:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591249403;
        bh=3MkFD5u516RHMXs9tkq7u9K3YawNQbXNaeFLtPqnKtQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I3ELH3x/3D6qSmpDrl6cD8y2KG2tp5tbMj+Qfv9YpzGMIIwVe972QmH57+VgAQkYh
         bSCsyUCtVOO20dU4qAnDsGWf8YOojtRy7uyVToqZY814GDfKw/j5Yupune1uBzydMm
         mKUa10L1rXvME15InwNqd8ht3s2Kue7pi/iIvULA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.94.220]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mhnw2-1j307X1kG0-00drys; Thu, 04
 Jun 2020 07:43:23 +0200
Subject: Re: dmaengine: stm32-mdma: call pm_runtime_put if pm_runtime_get_sync
 fails
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <873bfb31-52d8-7c9b-5480-4a94dc945307@web.de>
 <CAMuHMdU3wMT_pnh4NE9W9Su6qip_oObgd6OiRCwfuvouqjXKHA@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3eca8df2-22ae-06e0-5809-c11e459915d5@web.de>
Date:   Thu, 4 Jun 2020 07:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU3wMT_pnh4NE9W9Su6qip_oObgd6OiRCwfuvouqjXKHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KynnLDi6KBJoEMNje4oN1eTT3NNOBiFU90Q69446fFG5stNUo72
 FmPpM60Wdq/d742po5l185fsNTdEDnhKVsx7aalLxglMhzAV90r4HJIuNIXyDynopO8z3cO
 rSQX0gMpluWTpgfluIkxagVEvTHi5/jehR6PUJ27joHQ+P/nnEHIVLBgzdLIdNjGirWpTop
 L+EIi5rZtfUcE6YQgH6lA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qeH4pHbZvq8=:jmti1En2s8gckqqZeTZkwb
 S2shioru5R/hBxKDoGZEIcnMw/SwoBEyEPX059DjUeanDvCc7Fac9WiLMWPBD8AJQUSPGuKCk
 CDDxPa8qm2v90HBzoLF92WP64GNbts+YMlr8bjCcCdh695FEjG1lIiVC3sRvPiWn0+Du931ui
 Fc93bAeZ1RJKoEa+eXUzqCihuCA2Qz5ztiEE33lsfWcp7K+yQqeSxf7VlIlfOkLJTeRuzQwW8
 OStLEkZ9W5WOYscIZs8ETeG4nO9ydJWWU1btmxy4Ec7tZ4VPSAQMg2sFUET7c7ET0TgDZq7xf
 I0eZTkLk5qMx8LBtCHqZpK+1pTBEJQ/rqdhncwjgpdN95tCJMYGg+ShhPZbHtIe2V7c8Suka6
 Dm9jvBe8SPEhv3eI3JLAFf6jdnk5KcWsNzfPGqVKaar+/u9j1Y6JYyQ5bbJNxP6IcUpdWwnZ9
 cTG7tXpX4GjH5ZTGzHbLt4Qv7ZWRxT4y9OEeqiaDBXGLMMU+Q0JUxv+4WaVg1NDHX0zl3MTtn
 RLeV8vsBuIoaqOyowaC0eRaDtK87AbVtNxMl3JUZDzSVRB2CrK44HXXaufPqxYNmBspRqRRIH
 E9PzeatfbiLycom1n9IsyDLiTtDoIB5aX+OmRtwlCoN5HgfVKQL8qYDJ+fVcJI8kmaKRzI+Re
 Bx336G8dL+2iEjO7QoK5OtoEpmP9raxiivSBRUjTlDG7bfjs9G8QcMOWWApTMU8JoXtC2ItFi
 RcdPdFbO8Ire1AXb5qsh9qkouwcYqNv5s0Nz0B/71LCAsOP2vHlo9HYEtrwtNWNmvwhU1jNf8
 vm+Q/EEBUHuNZ8FIZhFM0+fyve7dLAoCyTyWvMgSd3C7LoeEsd28BlF+H+ubwTlzuQ7sv6x1D
 cFUF/gaF/PqL13J78WEXIu/OzIHvEhkXZqCT5gksVHT2c9d+qKgwXXwSt4NQMqj1rPavqqEMG
 yCHyi4RAyQ0ODjosyaRSavc60sRq95c5pmzfrEKKIP6pJ7uMFZsY7dolAPSF2b/M9K9zd2+I7
 UgzRX06sH1ZCiGQBTju0A4P04qVZjnnZyF1R9B/eE45meR+AgcQQb3c94sKFLloRj7MW+ac6Y
 /Q10piqqruZ/1Z7ae91DnKbn7gGsUnqQl+vC1yj2Gh1uvQFeNUXKA9zOYH3xPpA+8EHBi/c/8
 jinOPQC/S4lk4yUyY20RCgt3WNwTDlc+RAwzuBVvezI38NmgmZ1I+iE2zC0969K48rC+WTY04
 0PvWapH4m8KRnD3AY
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

>>> Calling pm_runtime_get_sync increments the counter even in case of
>>> failure, causing incorrect ref count. Call pm_runtime_put if
>>> pm_runtime_get_sync fails.
>>
>> Is it appropriate to copy a sentence from the change description
>> into the patch subject?
>>
>> How do you think about a wording variant like the following?
>>
>>    The PM runtime reference counter is generally incremented by a call =
of
>>    the function =E2=80=9Cpm_runtime_get_sync=E2=80=9D.
>>    Thus call the function =E2=80=9Cpm_runtime_put=E2=80=9D also in two =
error cases
>>    to keep the reference counting consistent.
>
> IMHO the important part is "even in case of failure", which you dropped.
> Missing that point was the root cause of the issue being fixed.
> Hence I prefer the original description, FWIW.

Would you like to comment any more of the presented patch review concerns?

Can it make sense to combine any adjustments into a single patch
according to the discussed software transformation pattern?
https://lore.kernel.org/patchwork/project/lkml/list/?submitter=3D26544&sta=
te=3D*&q=3Dengine%3A+stm32&archive=3Dboth

Regards,
Markus
