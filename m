Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447FE4C2464
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 08:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiBXHNT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 02:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiBXHNS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 02:13:18 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D5918DABB;
        Wed, 23 Feb 2022 23:12:46 -0800 (PST)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxUjv-1oBfXN0Tcn-00xqgA; Thu, 24 Feb 2022 08:07:36 +0100
Received: by mail-wr1-f42.google.com with SMTP id p9so1435973wra.12;
        Wed, 23 Feb 2022 23:07:35 -0800 (PST)
X-Gm-Message-State: AOAM532EpxCpwWjKfZVO60UsPuZ8Wv6zCAHCNVaTbsH4S6A6NhRzx/Oz
        TXaCCl9owcnbxk5pTojWFNHy8dt8v+HlZyDQblA=
X-Google-Smtp-Source: ABdhPJwEtLpX8E/vTN5J2WTCdVQZctqam7R0+5lnIigKmPPrPVDBdQ8fk8Xp/V3xYVy+7XSB18aLEhGa4luiP7dRyR0=
X-Received: by 2002:adf:a446:0:b0:1ed:c41b:cf13 with SMTP id
 e6-20020adfa446000000b001edc41bcf13mr1081355wra.407.1645686455629; Wed, 23
 Feb 2022 23:07:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <YhXmQwvjMFPQFPUr@infradead.org> <ddf6010e-417d-8da7-8e11-1b4a55f92fff@wanadoo.fr>
 <YhckzJp5/x9zW4uQ@infradead.org>
In-Reply-To: <YhckzJp5/x9zW4uQ@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 24 Feb 2022 08:07:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a23Pjm1Btc=mXX=vU4hkNiPqz3+o4=j0FuYKHB7KuMtPg@mail.gmail.com>
Message-ID: <CAK8P3a23Pjm1Btc=mXX=vU4hkNiPqz3+o4=j0FuYKHB7KuMtPg@mail.gmail.com>
Subject: Re: [PATCH 00/16] Remove usage of the deprecated "pci-dma-compat.h" API
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
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
X-Provags-ID: V03:K1:G+proiRNKst5hya+6hR+BYBd4VRS3n2DE6IeNAozttEzt7d4cvK
 f2mKBt5y9GjYdgZl32tJLtCozayM+b+0iu0mb+a1Jy2ATjYQYdM39CF3Ix2QNs8gajVrziT
 JrSs4NPIV+pYHoSzDtBDVmlKKYey23olqCofiIVZkhYIozH6Jh7hTUOh9MPFZiyiNMVlz3s
 QjJN+PIRYwIUNErT7Po/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mCNfRr881tI=:qp5or3CpyeODvVtkcH91Ts
 YpYmaQP8NRwfJ08tKJwL/IIdBv1yJHWNRW+foapbEcNq7Ksfe2jyeM2f79/k+b9BOsd0iMuNC
 bpwkGvv56vEsWY1afkiGSh/0/dEq8Xrfs8is0jKQlGPcL35cTnmx5im1s/hKHHY61EOTaY0pp
 vr698e4MGchUHuFbs53kNuKbzAi1vchcM3a8ZpyQNSzETvK55ymffALqOnPtgpKutx+PAPPD8
 ApGM21+JeR8ff6vK3awRfhUZ0eqB7rmFxaX+NAj15QMnEKA7o/UqhtKkS4WU7fLNeL2wXJAEJ
 7d9dyDO8Mtt+ZKaxTZMhjcLtMGGM2mzgAgpJmvZx5yclAYhR3UKIJG/Gnti6YyF0pThtdr+0+
 zVB/1XbvTSKDY4GXEjZVKBkSIlxSb64UnfKXob2BfcySCv/tr9giyvqeXpKzsZCI4y87klPhA
 xGkOjdNcNDo2loKsbhpzh8/om+4YnQUTciYT+ZvEQ4Y7F3kJhIdu0hWmIquq2rhf8guurJabA
 dpCyX/8Ox/9HVhF84E9mKCqhUqGqENk9HUIPzABILhrG21qLvABlC1LQjji5VPRsftckB3Dt3
 8R3K5uMe1OvszQNxMlaLlCaG6hU+9xpeUIlM+6Fu0GrnLGyR6uIMC0IjG1tcVggoe0WKOk+S6
 EITixEsJjFFZ/I4VXfOAwxe2N5k7IpUxJ6FZFz0u09OrYPwhADfStNL9XXHRCS9iG/JFAu9Iu
 QGECULqnwiafO68whyRCFYRlz2+hrMMnDpEFs/AvWtWzhrR0/26HK7MOrOuJY5d3m20rexzfH
 DILYvTn2VL1KZ6fwfAAH7hDCC8AIbbkZJD/tZgUjG/qrPxzp0Y7xyndOnNoccJD0NtsUOCdaA
 2FhLNkRGdWVsdGZFU8w6alIutuvgf5JWOlHHUd3+QrXcUOT9Ct585q0FF2b2ifnWoO+Num27d
 RD2sOUb+FrA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Feb 24, 2022 at 7:25 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Feb 23, 2022 at 09:26:56PM +0100, Christophe JAILLET wrote:
> > Patch 01, 04, 05, 06, 08, 09 have not reached -next yet.
> > They all still apply cleanly.
> >
> > 04 has been picked it up for inclusion in the media subsystem for 5.18.
> > The other ones all have 1 or more Reviewed-by:/Acked-by: tags.
> >
> > Patch 16 must be resubmitted to add "#include <linux/dma-mapping.h>" in
> > order not to break builds.
>
> So how about this:  I'll pick up 1, 5,6,8 and 9 for the dma-mapping
> tree.  After -rc1 when presumably all other patches have reached
> mainline your resubmit one with the added include and we finish this
> off?

Sounds good to me as well.

       Arnd
