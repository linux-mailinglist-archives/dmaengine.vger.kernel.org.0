Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60ED65DDFC
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jan 2023 22:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbjADVFR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 16:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbjADVFQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 16:05:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7211C113
        for <dmaengine@vger.kernel.org>; Wed,  4 Jan 2023 13:05:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so27540177wms.2
        for <dmaengine@vger.kernel.org>; Wed, 04 Jan 2023 13:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LzfQSUgvIM2I1IWlBk0x0ciKpBQbVvGJGMBc1nzev4=;
        b=CKZNVdeDs4r35ksAkhFEpBHpUwkIwLnb9DiSNaCXEv5nMhReah7VqeZYh3zHlcwS3t
         SEhJwIerynaFPS3ynBI2L1RmpPRYUcVopwCJkYTqNgR2+368zyhqDD2+2jQpEw8yfA+3
         FNpHZIuYIlH8IFV7b9LnRA26Fbu2VoMTnwikMLKxS5l0YDxhMqI3HXDcJtgbHW6+lcNW
         PvHB1HPUtoTsK1rlRJvLT5uZPD2tS2WPLQVNy36ZwWo2P0h0nyHQo0KUKLaJOfQrGSv4
         vmgKgCM4rJMuZfdKj7q4bMyC3XICYVS/0zhd2fgSvAjGHVWb4b09vitSpFwfwLogUDCC
         +k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LzfQSUgvIM2I1IWlBk0x0ciKpBQbVvGJGMBc1nzev4=;
        b=fEGiJTlVX5X1ZJb8maymndOnKF8dQWMhfMxNJitfll9nReyC87fhGI7QzQkmmY1knz
         s2oYwG+nnozLrh05c7X0Dq66hMINWeffKPPOc5X1KpBrNcrk/I2DCelVQ3nOkO07FsTr
         TSaV9FP7GaQuN9+ajmLR9cLfCwoUxuvexj6d7tHLzgNfN3RnlLdTHvxMIAPILpd5csE1
         1LQmFhACeR08/4WS30Ro3IL2c0QsfcUQu4hFhn5Wh1eHbTVWCFMNDQ8MUMuC8656NPOJ
         x1FpLNqR9hCDrvnmX/AVPdwY0iPqrN15n6U+mxpjSKdmpHTzCFYRW656zj7jIxbLXMyX
         LiVg==
X-Gm-Message-State: AFqh2kok5Lc7GTIRBJMvF6tJbyGrOXAOpYLE8xNR+Ia/pkf3lFKKeQMn
        tvTvLcgVCwZ94Y9JpqqqrHA=
X-Google-Smtp-Source: AMrXdXtY7SKetrw41QqpZ6faUFEwlJ+P2rnGpc4edC+fz40j8dJ2YXXeoEioUhj1wc12FK+dknyrEQ==
X-Received: by 2002:a05:600c:3d1b:b0:3d0:6a57:66a5 with SMTP id bh27-20020a05600c3d1b00b003d06a5766a5mr34002357wmb.0.1672866313536;
        Wed, 04 Jan 2023 13:05:13 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id z25-20020a1c4c19000000b003d1e1f421bfsm30078wmf.10.2023.01.04.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:05:12 -0800 (PST)
Date:   Wed, 4 Jan 2023 21:05:11 +0000
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
Message-ID: <Y7XqBwewsUnAP4uP@lucifer>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com>
 <Y7RpuqbTAM11wVQG@lucifer>
 <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
 <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu16rdea.fsf@nvidia.com>
 <Y7XZ8zY3KIRDlu/f@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7XZ8zY3KIRDlu/f@lucifer>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 04, 2023 at 07:56:35PM +0000, Lorenzo Stoakes wrote:
> Another question is - why can't we:-
>
> 1. mmgrab() [or safely assume we already have a reference] + mmget_not_zero()
> 2. acquire mm read lock to stop VMAs disappearing underneath us and pin pages with get_user_pages_remote()
> 3. copy what we need using e.g. copy_from_user()/copy_to_user()
> 4. unwind

OK looking at __access_remote_vm() I just accidentally described exactly what it
does other than step 1 :)

Perhaps then the answer is a wrapper that gets the reference before
invoking __access_remote_vm()? I guess we could assume grab there.

It strikes me that access_remote_vm() being quite literally a pass through to
__access_remote_vm() means we could:-

a. change all callers of access_remote_vm() to use __access_remote_vm()
b. Update access_remote_vm() to be safer
c. finally, export access_remote_vm()

e.g.:-

int access_remote_vm(struct mm_struct *mm, unsigned long addr,
		void *buf, int len, unsigned int gup_flags)
{
	int ret;

	if (!mmget_not_zero(mm))
		return 0;

	ret = __access_remote_vm(mm, addr, buf, len, gup_flags);

	mmput(mm);
}
EXPORT_SYMBOL_GPL(access_remote_vm)
