Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEC120E18D
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2020 23:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbgF2U5E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jun 2020 16:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731264AbgF2TNG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Jun 2020 15:13:06 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02146C008741;
        Mon, 29 Jun 2020 01:29:09 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e22so12063739edq.8;
        Mon, 29 Jun 2020 01:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p0Amh6fr+1R3C2RHtf7InopKIGPAneI2V6X/f0nvW6Q=;
        b=b77Q8K97SjCe4N8FKt73VUizzh+FuWSG8cJXm6d2FMGC0TtHg5b70pfUimyt/OH2Rt
         OAr/iJ4zjJb444/lbv2zVCLlse3US+YJfBymOdvEXIe7pTciZW+2R8mCpvl8um5461QU
         9rpTxROKF4jinHlpY+bak3w8PAzNO4b6KgBtnr5nvlGVgDfUe2VOf8enHOyYS6Eihw2i
         77Gd/SXdsF9tCnssdbK2oB0g46Z2D9+bAvqhwvlI8QmqW34M8X9Q4kmNSIjbvmib4SBr
         l+1efmH1oorND0bS9As7HzVldskq32kutrrGOyjohkSuTPAnozd6J3bVOV1f8mn1cf2l
         1lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p0Amh6fr+1R3C2RHtf7InopKIGPAneI2V6X/f0nvW6Q=;
        b=f0dC3cHkAPRcqFtJijH7ejOSz/XegJ7gXyIPkzzg+aTKLYvfsv1TbeL761oATIi0gx
         GuEhUB4K96AzGpgyaA/jXsvtPE9BJGZfG5EHKLDn83fwdsm1+AlSgOxIND5/P1TZweRK
         z+jICI5H6SLApWcMx3XsOwksNXdnt8HpZ+LsqqO3w/d8xM4mlNpEYiHGaNeOhJA6bODG
         PhtWSPjTPXWCXAaZvFJ4goTv6H2/QiMfYZxSIrP4HzX/CyRzYoD9rkWo9FK8dsN2hjYd
         05g6vGASrJzJR8/XDSQ7Fp3/OHkrfS6dwcvhMsuXLVhCFVcNrwrzu1lEHKCUn8sBHvK7
         th9w==
X-Gm-Message-State: AOAM533IzXTdztckmmaPWiQfTIMNSagVQpja8gs1UeOLpUf2S488lApl
        KtVSwpI9rs0otg9y+dS9q8YJl1FShz6nin+RQHU=
X-Google-Smtp-Source: ABdhPJxPj3tJ0PQzOv97lm804VPCxbjl4m6U29OVUfEV8uCWqRZKPmi25QGenCWT2I5pPTREN2ZYJEXttVeTSUc/wVc=
X-Received: by 2002:a50:f413:: with SMTP id r19mr17094422edm.17.1593419347605;
 Mon, 29 Jun 2020 01:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
 <1591697830-16311-3-git-send-email-amittomer25@gmail.com> <20200624061529.GF2324254@vkoul-mobl>
 <75d154d0-2962-99e6-a7c7-bf0928ec8b2a@arm.com>
In-Reply-To: <75d154d0-2962-99e6-a7c7-bf0928ec8b2a@arm.com>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Mon, 29 Jun 2020 13:58:31 +0530
Message-ID: <CABHD4K-uFzzHLcH8SXGYkn_ZburG-g0f-ECrefU2V61Fp+z3fQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] dmaengine: Actions: Add support for S700 DMA engine
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Wed, Jun 24, 2020 at 3:06 PM Andr=C3=A9 Przywara <andre.przywara@arm.com=
> wrote:
>
> On 24/06/2020 07:15, Vinod Koul wrote:
>
> Hi,
>
> > On 09-06-20, 15:47, Amit Singh Tomar wrote:
> >
> >> @@ -372,6 +383,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_v=
chan *vchan,
> >>                                struct dma_slave_config *sconfig,
> >>                                bool is_cyclic)
> >>  {
> >> +    struct owl_dma *od =3D to_owl_dma(vchan->vc.chan.device);
> >>      u32 mode, ctrlb;
> >>
> >>      mode =3D OWL_DMA_MODE_PW(0);
> >> @@ -427,14 +439,26 @@ static inline int owl_dma_cfg_lli(struct owl_dma=
_vchan *vchan,
> >>      lli->hw[OWL_DMADESC_DADDR] =3D dst;
> >>      lli->hw[OWL_DMADESC_SRC_STRIDE] =3D 0;
> >>      lli->hw[OWL_DMADESC_DST_STRIDE] =3D 0;
> >> -    /*
> >> -     * Word starts from offset 0xC is shared between frame length
> >> -     * (max frame length is 1MB) and frame count, where first 20
> >> -     * bits are for frame length and rest of 12 bits are for frame
> >> -     * count.
> >> -     */
> >> -    lli->hw[OWL_DMADESC_FLEN] =3D len | FCNT_VAL << 20;
> >> -    lli->hw[OWL_DMADESC_CTRLB] =3D ctrlb;
> >> +
> >> +    if (od->devid =3D=3D S700_DMA) {
> >> +            /* Max frame length is 1MB */
> >> +            lli->hw[OWL_DMADESC_FLEN] =3D len;
> >> +            /*
> >> +             * On S700, word starts from offset 0x1C is shared betwee=
n
> >> +             * frame count and ctrlb, where first 12 bits are for fra=
me
> >> +             * count and rest of 20 bits are for ctrlb.
> >> +             */
> >> +            lli->hw[OWL_DMADESC_CTRLB] =3D FCNT_VAL | ctrlb;
> >> +    } else {
> >> +            /*
> >> +             * On S900, word starts from offset 0xC is shared between
> >> +             * frame length (max frame length is 1MB) and frame count=
,
> >> +             * where first 20 bits are for frame length and rest of
> >> +             * 12 bits are for frame count.
> >> +             */
> >> +            lli->hw[OWL_DMADESC_FLEN] =3D len | FCNT_VAL << 20;
> >> +            lli->hw[OWL_DMADESC_CTRLB] =3D ctrlb;
> >
> > Unfortunately this wont scale, we will keep adding new conditions for
> > newer SoC's! So rather than this why not encode max frame length in
> > driver_data rather than S900_DMA/S700_DMA.. In future one can add value=
s
> > for newer SoC and not code above logic again.
>
> What newer SoCs? I don't think we should try to guess the future here.
> We can always introduce further abstractions later, once we actually
> *know* what we are looking at.
>
Apart from it , we have *one* more SoC from Actions .i.e. S500 where
the DMA controller is
identical to S900, and requires *no* additional code to work properly.

So, I think we are safe to have the changes proposed in this patch.

Thanks

-Amit
