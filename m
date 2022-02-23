Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730354C1D42
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 21:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbiBWUnH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Wed, 23 Feb 2022 15:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiBWUnG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 15:43:06 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264D24D9E1;
        Wed, 23 Feb 2022 12:42:37 -0800 (PST)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N2Unv-1oNLsZ1g5P-013tgA; Wed, 23 Feb 2022 21:42:36 +0100
Received: by mail-wr1-f54.google.com with SMTP id p9so41552050wra.12;
        Wed, 23 Feb 2022 12:42:36 -0800 (PST)
X-Gm-Message-State: AOAM532mTYFfWZt9TfUixYZ4bjOV6N86XMcqwYJ+8jYJNejvP5OSOxmv
        UlSrxI4myGyGV/gTE+kYAwKJ/kOZwQVH/a3WCO4=
X-Google-Smtp-Source: ABdhPJziqSCxjCS1x1u10tLrK12Y5BgM1gvdjleghmB0yDOaxeqY4rE/1foGEILFQdcVBbYw8yS43bNCsScP3V8TzG8=
X-Received: by 2002:adf:cf0c:0:b0:1e6:22fe:4580 with SMTP id
 o12-20020adfcf0c000000b001e622fe4580mr1011010wrj.12.1645648955871; Wed, 23
 Feb 2022 12:42:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <YhXmQwvjMFPQFPUr@infradead.org> <ddf6010e-417d-8da7-8e11-1b4a55f92fff@wanadoo.fr>
In-Reply-To: <ddf6010e-417d-8da7-8e11-1b4a55f92fff@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Feb 2022 21:42:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0nshfiWnhZydoRkmNBMQnyPueE4pvV1LuWR4XLxBQjUg@mail.gmail.com>
Message-ID: <CAK8P3a0nshfiWnhZydoRkmNBMQnyPueE4pvV1LuWR4XLxBQjUg@mail.gmail.com>
Subject: Re: [PATCH 00/16] Remove usage of the deprecated "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        David Miller <davem@davemloft.net>,
        David Airlie <airlied@linux.ie>, Vinod Koul <vkoul@kernel.org>,
        hao.wu@intel.com, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        awalls@md.metrocast.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alex Bounine <alex.bou9@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        dmaengine@vger.kernel.org, linux-fpga@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:+EHDA8n19nCeF+vM2P8PLPYGb0TUOdwEGHkS6GeBNEVHX4jMluh
 4zZVkIM4OTnw24x4ExwusPPRHPinutOocshs4HRvCffFKEiaheJeU+Nq600oylx4L0vNuhB
 XsenrL+MP+J7CKq0RD9h10OCqN2SKXzdGvqe2Cy5Y2gbRnG2J97LIgwqZ0D/nhZxJ/bNRpf
 hobvYupx0Urm+q/FHAHZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IBTzsmJgBfY=:S7FSvTCSOCm/oHqdAggS5Y
 bB8TWTPSiuxBUHKaKkZx+mHdyyBSGegJr6XMmUWkL1iEWFq7cZ6+nJViT4FO+xJ8Cs9yAqPyj
 AuRhBGGnbejqMXkAEdPMJNr2DYZbBHylHmvjRl4ql3B6M40+dsKEep0H3TP9iQ38+Ju48tG+k
 frLX1E8YwskOJ1YlpX0p5jR0BOnp3SXs4QpnSIhrnJ1Rskf9E/attNHn0CtH0EplRaKSSII9c
 fnJkYBUxfSnZdSEkGXPQcBj4tVd8Y1CrPf68Tu8JFxU/NbYGMsjrZEkNtO+DcR8QdONeldMKc
 jRsDBn9WNLVtZzxm2ZbemkIKZUweJYVuqDYiAScCL7C5CxnBzi6ta3DckQBY9yNMTXMoqXtgP
 2lLxWF0tql18b9jMDRbwSDLsZAchAwTbBoleQwTuh666QXns0eK55eMTrADXcE1Jtq68lj0o7
 tZQpeLPuJxf0CkxyZVHM3aJQS3PjTUivRK1U0kM6M6NVejJolVg3Vocjme8Yfy74KECVowJNb
 rQGB3THCUXOZtv8xM1+gRTHb8LcOVs/kISzkldj5wo93hqPOwzYjzQrdqOK755SMwei1KK5Ak
 SlTcE+/LaUYGsBaSvn0XOu/woz5JIXTUZZ/35l89tnlA8wKXFNxtp0s9qk0oh/FuHc4UY+6hV
 reXuv6YnNc6BnoduZPDGvnCglihJhCvm2V5Dxx8F/XJN+DG1tZHs6IR9KWwu6Pe15hiAnEm9f
 q3lKjAwktwqYLUtJuX5Ax/D+8OsnfhdlYYOX3q88j6Hvj1zFxIGcLcpi4wq8+neMdqGUz0YyQ
 sz0brsmpiFwKXxsKz4g49LhuSFB8c+J4uiz0M7FOftJWvcFZvA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 23, 2022 at 9:26 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 23/02/2022 à 08:46, Christoph Hellwig a écrit :
> > Hi Christophe,
> >
> > do you know what the state is in current linux-next?
> >
> > I think we'll just want to queue up anything left at this point in the
> > dma-mapping or PCI tree and get it done.
> >
>
> Hi,
>
> Patch 01, 04, 05, 06, 08, 09 have not reached -next yet.
> They all still apply cleanly.
>
> 04 has been picked it up for inclusion in the media subsystem for 5.18.
> The other ones all have 1 or more Reviewed-by:/Acked-by: tags.
>
> Patch 16 must be resubmitted to add "#include <linux/dma-mapping.h>" in
> order not to break builds.
>
>
> All the other patches have landed in -next.

Ok, these all look trivial. I'd suggest you send the rebase version to
Andrew Morton then, so he can pick them all up into linux-mm, on top
of the linux-next contents.

         Arnd
