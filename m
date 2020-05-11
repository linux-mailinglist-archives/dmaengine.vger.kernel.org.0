Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBED71CE782
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 23:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgEKVfh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 17:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725860AbgEKVfg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 May 2020 17:35:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5126CC061A0C;
        Mon, 11 May 2020 14:35:36 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f18so11221573lja.13;
        Mon, 11 May 2020 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fYJkLNV120eh6j9XZEAijsb1unZiMgZ34U7xH85m09s=;
        b=e6TUd2jEZN5MfVmrTCY58XKUvyZLG3kIpYwRSkhy4nHFSYWtfncPDWC9br1e5MOZzQ
         uUOMqQn9raMq9mQXggKII9sECrVTJCrGvGGzzvGOhgYan10woqRsqIIrABexKospKj3B
         cCxfTBI/jS6ucT3l0xJP0V0Q/5aSU4XCk9YuZOOMK8j2XmLyqzmO8QdvBTsjSxhM9YsL
         MSI/acv2GdVFa+vdmrJNftsuHZ2g0y1lhogHt6KX48MUJd7sCy3S1QBId6ke2AoEEorr
         bqO7dIHF+mr/fhXHVq8t6nPWkikUNR0gSwBSP0zBIgjjGxHvE2LBf2pbou8QMN5Iawdo
         QVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fYJkLNV120eh6j9XZEAijsb1unZiMgZ34U7xH85m09s=;
        b=cgwnnNAy4D+YCFMfwltlneWfoS44sHvz7AiD9TzuYNEw56tSntKOaxJjuWhj5TW/RF
         7P1BD9IBdI/cGxP/zvHLk0WA1UG+0njwDbvq7BJKlHVWEYVpD3SgW5ckRwaSB2Hrf2OL
         5Py1urjNRr+9WwFKJT90WR9Wh7+L2RhUx35wJRg3P1VfEHPgvsOtp2Iru0zn/Sj0IsWp
         q8I5fSZg8ZyhvaqEhqe9U49n91q0RX9sGLjywIVEpAAnQIWAzZNbRQHobUVTAssuJk9R
         zzqLa1ZeeBt3a4e3JemKVEpTf+WsiCvk/77pbrE41vCZ3+wwZPpQMnuLDujJUqpeVlAs
         xI9Q==
X-Gm-Message-State: AOAM530ux1G9F7ddoLm/kAuAuYsvsU6ppm6w+Px/rdWhykZJDSJeh2oF
        EdcgeJ9hamhEsbhPGKVcYJs=
X-Google-Smtp-Source: ABdhPJyFHiB0xr+CkXOcmAFcyDvbJir3HL6j/bBjATnZzqDS/avlkEaI1AplLwAszR8XVdGM0UC8ig==
X-Received: by 2002:a2e:7d12:: with SMTP id y18mr11868247ljc.211.1589232934836;
        Mon, 11 May 2020 14:35:34 -0700 (PDT)
Received: from mobilestation ([95.79.139.244])
        by smtp.gmail.com with ESMTPSA id m22sm10751538lji.75.2020.05.11.14.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:35:33 -0700 (PDT)
Date:   Tue, 12 May 2020 00:35:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: dma: dw: Add max burst transaction
 length property
Message-ID: <20200511213531.wnywlljiulvndx6s@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-3-Sergey.Semin@baikalelectronics.ru>
 <20200508111242.GH185537@smile.fi.intel.com>
 <20200511200528.nfkc2zkh3bvupn7l@mobilestation>
 <20200511210138.GN185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511210138.GN185537@smile.fi.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 12, 2020 at 12:01:38AM +0300, Andy Shevchenko wrote:
> On Mon, May 11, 2020 at 11:05:28PM +0300, Serge Semin wrote:
> > On Fri, May 08, 2020 at 02:12:42PM +0300, Andy Shevchenko wrote:
> > > On Fri, May 08, 2020 at 01:53:00PM +0300, Serge Semin wrote:
> > > > This array property is used to indicate the maximum burst transaction
> > > > length supported by each DMA channel.
> > > 
> > > > +  snps,max-burst-len:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +    description: |
> > > > +      Maximum length of burst transactions supported by hardware.
> > > > +      It's an array property with one cell per channel in units of
> > > > +      CTLx register SRC_TR_WIDTH/DST_TR_WIDTH (data-width) field.
> > > > +    items:
> > > > +      maxItems: 8
> > > > +      items:
> > > 
> > > > +        enum: [4, 8, 16, 32, 64, 128, 256]
> > > 
> > > Isn't 1 allowed?
> > 
> > Burst length of 1 unit is supported, but in accordance with Data Book the MAX
> > burst length is limited to be equal to a value from the set I submitted. So the
> > max value can be either 4, or 8, or 16 and so on.
> 
> Hmm... It seems you mistakenly took here DMAH_CHx_MAX_MULT_SIZE pre-silicon
> configuration parameter instead of runtime as described in Table 26:
> CTLx.SRC_MSIZE and DEST_MSIZE Decoding.

No. You misunderstood what I meant. We shouldn't use a runtime parameters values
here. Why would we? Property "snps,max-burst-len" matches DMAH_CHx_MAX_MULT_SIZE
config parameter. See a comment to the "SRC_MSIZE" and "DEST_MSIZE" fields of the
registers. You'll find out that their maximum value is determined by the
DMAH_CHx_MAX_MULT_SIZE parameter, which must belong to the set [4, 8, 16, 32, 64,
128, 256]. So no matter how you synthesize the DW DMAC block you'll have at least
4x max burst length supported.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
