Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478FF34D0AB
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhC2M61 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Mar 2021 08:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhC2M6C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Mar 2021 08:58:02 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9BAC061574;
        Mon, 29 Mar 2021 05:58:01 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x9so9151967qto.8;
        Mon, 29 Mar 2021 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=pXwScAbp9Oc9UUM+Y5MFv/NyYb1m2Ax9bkESJHn7OoM=;
        b=jIMlPhrnPxBkc1eIt0loxmUFn7wXXfPXYhzlXGaYPnegO6aUyr7PCPcsU1Q/nPx2fP
         z9dSO77ODJpoGbIqBdLPzf7Hmx+na9zXd2cZJ4qd9BBfUIDW2OzJWYE465wjBIWAuRrr
         NWCMehNEk3cJZY3zjwb6ZOQi1NkbEq5fCcB0n+UlGn7E/x8I9ZccVrQAOLQEjvvAhPgW
         gyvGu7fxdumQ9rlYgMvh+Gznzjnn6Qsqul2TwzNQVb6EA6ue+DdlAwS1sDkE02lS2xyR
         3n4LD+Mz6IiTzqnrhisHrhIHhSDc4vM/80A7UAKxL/KmVUJHzyawP00LVXC3wRmxEBMs
         lnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=pXwScAbp9Oc9UUM+Y5MFv/NyYb1m2Ax9bkESJHn7OoM=;
        b=QEuoIUsZpsTBFxciE3WVD7tIQzZMceKREJizxRwtrwV3w6izR2JLWmopCHXPjebdOB
         eNrptRbACCqBv7ZYKkNPzcXKSsIuoGA2J25t6kqMsWIctAsN5Evr9aHfC5LdTreVHa0c
         g7J8m0pxAIF6KvF/xVwJYCoSEKVvNhmsa3+mn5EmcwzgzEYfXii8aVwPTiytViVCi2F4
         PfWforJFj+pK2pTKgtbsluF0EbUlW9cBuRHrdZoDFsBRD+v8lCfXEp/9Kluv1hHGEshc
         7fNNfJ2EtJeWxUJgm6ev4XR6tLMBUhzJKauiw8mHAPZqkj4g3Bhv9SHp8YAbeEQt7rxj
         ZNYA==
X-Gm-Message-State: AOAM530cLEpU5+fgtleHQ6xrbAOE+dOmdXvgB+WFk6pP8yckBYBXyG23
        ZTrqBdJp68UkgKhv4IdsG6eo2bPEWVlbpJG9
X-Google-Smtp-Source: ABdhPJzGuB5bAHBNMyTzE3y0baxdhpY1BDoada/eHGqWehXn5kNmFoyZ95oSsGX4Gf6P46twv8R/cA==
X-Received: by 2002:aed:2ea4:: with SMTP id k33mr22317560qtd.169.1617022681256;
        Mon, 29 Mar 2021 05:58:01 -0700 (PDT)
Received: from Gentoo ([37.19.198.130])
        by smtp.gmail.com with ESMTPSA id y1sm13368206qki.9.2021.03.29.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:58:00 -0700 (PDT)
Date:   Mon, 29 Mar 2021 18:27:43 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        dave.jiang@intel.com, dan.j.williams@intel.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] DMA: Mundane typo fixes
Message-ID: <YGHOxwiqwhGAs819@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        dave.jiang@intel.com, dan.j.williams@intel.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
References: <cover.1616971780.git.unixbhaskar@gmail.com>
 <20210329052910.GB26495@lst.de>
 <YGFrvwX8QngvwPbA@Gentoo>
 <YGG+l1EfRuWp0J3A@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5zclouQno4veQbB1"
Content-Disposition: inline
In-Reply-To: <YGG+l1EfRuWp0J3A@kroah.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--5zclouQno4veQbB1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 13:48 Mon 29 Mar 2021, Greg KH wrote:
>On Mon, Mar 29, 2021 at 11:25:11AM +0530, Bhaskar Chowdhury wrote:
>> On 07:29 Mon 29 Mar 2021, Christoph Hellwig wrote:
>> > I really don't think these typo patchbomb are that useful.  I'm all
>> > for fixing typos when working with a subsystem, but I'm not sure these
>> > patchbombs help anything.
>> >
>> I am sure you are holding the wrong end of the wand and grossly failing to
>> understand.
>
>Please stop statements like this, it is not helpful and is doing nothing
>but ensure that your patches will not be looked at in the future.
>
Greg, don't you think you are bit harsh and have an one sided view? People can
say in better way if they don't like some work. I Have always try to get
along.
>> Anyway, I hope I give a heads up ...find "your way" to fix those damn
>> thing...it's glaring....
>
>There is no requirement that anyone accept patches that are sent to
>them.  When you complain when receiving comments on them, that
>shows you do not wish to work with others.
>
Unfortunate you are only seeing my complains...I don't know why you are so
blindfolded.
>Sorry, but you are now on my local blacklist for a while, and I
>encourage other maintainers to just ignore these patches as well.
>
I can not overrule that ...I know my pathes are trivial ..but it seems some
other problems are looming large.

NOT good Greg....not good seriously.
>thanks,
>
>greg k-h

--5zclouQno4veQbB1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBhzsAACgkQsjqdtxFL
KRW2qwf+LpIRIiK3vSyhfOkc5KEs6+JY1kuwY5zK8zNexJI+BFNVlKy2fiJDI5OJ
ohAkhZ7u6VPXdYX4JVipyUMEVaBJRI36ebb2fl5JhhjKdp+xaw+1pP+AMIXET/SS
mxlbUWkBiwZvlebkm26R/LDfJ6BMh8uOTth09mP9SEzfLvL41TJotFlJnCZ7+Akq
RtQfuF4c4a6g4rkBMbKz9GFP35UIl8xrQB9roiynNg8abT7mP0mfBYEa+yofDdA5
dmOmw22RwwuXueZhidrSifQYP4F0h/3zrUTetKYa4MZYUVnIR/Lvpa9K6U6xjuIb
rHZf1I6RXTsmUcErV7E2MR4mZEjStg==
=YLCg
-----END PGP SIGNATURE-----

--5zclouQno4veQbB1--
