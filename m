Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82DE65DD4A
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jan 2023 20:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjADT4m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 14:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjADT4j (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 14:56:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2855CB88
        for <dmaengine@vger.kernel.org>; Wed,  4 Jan 2023 11:56:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso25142055wmb.3
        for <dmaengine@vger.kernel.org>; Wed, 04 Jan 2023 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ifeoxPcOFrYuK6F+TgbiUrd0ztltIDwUxl6It3jUMk=;
        b=piWDU7gL1nHMrxwQ0Q/NCykuPeih/kHlzWdGfZ0BCEGNV55R3hU5HSrtsZb16U4A5I
         36syKEZYqrFQGb9ghe8S46YDHiUJK47SuxWjB0ZSOO/cTLkMtQjjVDqORF1cTi1NKMZQ
         rAmzYEt78dzhOma2zQByCQZpG87aO8VwBzd8Gxoy3mAv6cWEfOEU53aj/PUuORF4xxGR
         eqHUa6EP5ssp2Aun6ImGBq/vZlYa4N+CSaDiRMNirol752AYeuMQzOKK/z6fwvhbbuYS
         LuqAKg3rNEhxnG8qsOMgxzgyfsS27UB/8ZF/tOn1mddyM2yaNpK6qADe9ndv/4dff/HW
         Z5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ifeoxPcOFrYuK6F+TgbiUrd0ztltIDwUxl6It3jUMk=;
        b=iCR2snvrIi9RsiBmy6bnZ3aRD4SNzjUY5/IBGxjEC1d7sFtSmDrTp2uqxv/geA1RKn
         9cgg20pNGjUClU1RHiydkdp0UZd4/y1VD7h1LqPJ++lxk+aj9AM+KzTiKS0zDeB2HNHB
         hF7L8GqbThwF1yFwnN+QMfcoJPLr2toMTOVBw8OjcyuPJHPMzlZFHclpnecfbAab73Er
         PfV5T9Q6s53xp73IQJ58wbAsIb1XluCkl0H0fFTGjTCJ4BeYuDV724cQLoxlxwtsa22g
         Cu7e3xdoZMi7NBcFpLpk+Ndi+yxHBlL60w2c6BtG+VY32nmUkID0Tw5jrItOYi/d8HGn
         BH/Q==
X-Gm-Message-State: AFqh2kpThs54okiqLK0PtNhCv05tgF03T1AHk4hefvHx+1z6m6e2ZAI/
        PyHbTeUFW7OiyBDVK+A2BVuQA1irKQo=
X-Google-Smtp-Source: AMrXdXt2CKt2uukWx7vXejwlNDs9tCcYERDZuM0p1LGX1G51+lHvyxi1Qz0KV/uvtTgf1jfStOeppg==
X-Received: by 2002:a05:600c:5006:b0:3d2:3eda:dd1 with SMTP id n6-20020a05600c500600b003d23eda0dd1mr35033523wmr.17.1672862196590;
        Wed, 04 Jan 2023 11:56:36 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c2d0700b003c6c3fb3cf6sm44978164wmf.18.2023.01.04.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 11:56:35 -0800 (PST)
Date:   Wed, 4 Jan 2023 19:56:35 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 09/17] mm: export access_remote_vm() symbol
Message-ID: <Y7XZ8zY3KIRDlu/f@lucifer>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com>
 <Y7RpuqbTAM11wVQG@lucifer>
 <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
 <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu16rdea.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tu16rdea.fsf@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 04, 2023 at 05:12:31PM +1100, Alistair Popple wrote:
> Obviously something must still be holding a mmgrab() though. That should
> happen as part of the PASID allocation done by iommu_sva_bind_device().

I'm not familiar with the iommu code, but a brief glance suggests that no
mmgrab() is being performed for intel devices? I may have missed something
though.

We do need to be absolutely sure the mm sticks around (hence the
grab) but if we need userland mappings that we have to have a subsequent
mmget_not_zero().

> >> I definitely don't feel as if simply exporting this is a safe option, and you would in
> >> that case need a new function that handles different scenarios of mm
> >> ownership/not.
>
> Note this isn't that different from get_user_pages_remote().

get_user_pages_remote() differs in that, most importantly, it requires the
mm_lock is held on invocation (implying that the mm will stick around), which is
not the case for access_remote_vm() (as __access_remote_vm() subsequently
obtains it), but also in that it pins pages but doesn't copy things to a buffer
(rather returning VMAs or struct page objects).

Also note the comment around get_user_pages_remote() saying nobody should be
using it due to lack of FAULT_FLAG_ALLOW_RETRY handling :) yes it feels like GUP
is a bit of a mess.

> In any case though iommu_sva_find() already takes care of doing
> mmget_not_zero(). I wonder if it makes more sense to define a wrapper
> (eg. iommu_access_pasid) that takes a PASID and does the mm
> lookup/access_vm/mmput?

My concern is exposing something highly delicate _which accesses remote mas a public API with implicit
assumptions whose one and only (core kernel) user treats with enormous
caution. Even if this iommu code were to use it correctly, we'd end up with an
interface which could be subject to real risks which other drivers may misuse.

Another question is - why can't we:-

1. mmgrab() [or safely assume we already have a reference] + mmget_not_zero()
2. acquire mm read lock to stop VMAs disappearing underneath us and pin pages with get_user_pages_remote()
3. copy what we need using e.g. copy_from_user()/copy_to_user()
4. unwind
