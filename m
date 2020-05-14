Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1299E1D3928
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2020 20:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgENSeq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 May 2020 14:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726165AbgENSeq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 May 2020 14:34:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00335C061A0C
        for <dmaengine@vger.kernel.org>; Thu, 14 May 2020 11:34:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z5so3678642ejb.3
        for <dmaengine@vger.kernel.org>; Thu, 14 May 2020 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VzYKzBvqC75VcPkywsdMxmxFnXHOoxLK1AEgaB/V5Y=;
        b=g5t9TI0lRFOqTU+zNIA++xrtaX4gse1lRCl4dDi4w0XHna0ydkavbp08zMERmsR1+F
         jLbHmeOAcMdzBXztP6TK5ZDS2CaALpg11VS3rfpbKQuMy11eeMY8Noka8zMyd/+8jvFp
         oezrrkr8OQ4XsJnIaEqhKbDfnMh9dJedJHngPUhf7NpJ+90R7T6Js6U/UA2saASVTlF/
         1ih/rbdphSy8cGFkR+z0hCER0E/sUlUkbvmXSpkeVwY3r0j4+iDwavq/MO+TvDOg3xjE
         3Za280hfeKo1DqvWcTxDCYjbFLZvtrRgmvViYmR4wC2DEmbGyDluyjo01OAWxvVno0Td
         /8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VzYKzBvqC75VcPkywsdMxmxFnXHOoxLK1AEgaB/V5Y=;
        b=NmBNjPFaL74DZRkd55UXxop21PaSMyEcxazivcPJD61kZtKMhy/fy1xCOMV2or4gls
         7ujOFRWFJKmkI60w7azLNljFthEEdzQ2+dYWWfuRXrNEgFlWgV9d6vYzPd9pQu986TGD
         i3/cJFnsBXO/5NXQkLrtE45dMD7nB2m5X4A3q0odANDpsIMk1OfmFyBklMdtmEkvjZF/
         PrPgFfjyvyyXKQcqLAXe6tkNag0VmfYLa6JZConIvZ7GRHlFi7oyGVXQlGHBSdO0TkmH
         E78nJh0SYaOOKpPK3FSkHtYE/CrkPI3GtNbpZeOs3oXjLB769bvif/7QhW2JQE3fpN3v
         T5tA==
X-Gm-Message-State: AOAM530/N4V/xgsJobGztLWJFyn2NIzH+RWo9+nPY+8ALTlmm51MGVvm
        CDMDyejsgwGYnD+HEQOxadz1tJ6cQ2YEzwxPAR4=
X-Google-Smtp-Source: ABdhPJxCvxVC88mtHnROOgzUv7U+F6ZCgavmc3C+D/JK94/ZBvycpZLxsWEk85DnkDZz3BcigqI2fEQAZP+4G1unGuo=
X-Received: by 2002:a17:906:7e15:: with SMTP id e21mr5363706ejr.106.1589481284585;
 Thu, 14 May 2020 11:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <1589472657-3930-1-git-send-email-amittomer25@gmail.com>
 <1589472657-3930-2-git-send-email-amittomer25@gmail.com> <20200514182750.GJ14092@vkoul-mobl>
In-Reply-To: <20200514182750.GJ14092@vkoul-mobl>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Fri, 15 May 2020 00:04:07 +0530
Message-ID: <CABHD4K8F_sk3Xsevu4pMtR1jEanh5-dSATLYySPKW-nDY9fAvA@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] dmaengine: Actions: get rid of bit fields from dma descriptor
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Thu, May 14, 2020 at 11:58 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 14-05-20, 21:40, Amit Singh Tomar wrote:
> > At the moment, Driver uses bit fields to describe registers of the DMA
> > descriptor structure that makes it less portable and maintainable, and
> > Andre suugested(and even sketched important bits for it) to make use of
> > array to describe this DMA descriptors instead. It gives the flexibility
> > while extending support for other platform such as Actions S700.
> >
> > This commit removes the "owl_dma_lli_hw" (that includes bit-fields) and
> > uses array to describe DMA descriptor.
>
> So i see patch 1/9 and 2/9 in my inbox... where are the rest ? No cover
> to detail out what the rest contains, who should merge them etc etc!
>
> If you are sending a series to different subsystem please make a habit
> to CC everyone on cover letter so that we understand details about the
> series. If not dependent, just send as individual units to subsystems!

Ok, I would make note of it and Cc everyone on cover letter going forward.

Thanks
-Amit
