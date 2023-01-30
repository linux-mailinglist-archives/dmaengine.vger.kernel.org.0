Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94B5681AB7
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 20:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbjA3TpW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Jan 2023 14:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjA3TpV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Jan 2023 14:45:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5068C163;
        Mon, 30 Jan 2023 11:45:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 679EEB8168D;
        Mon, 30 Jan 2023 19:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1ACC4339E;
        Mon, 30 Jan 2023 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675107918;
        bh=52J5/EqGhJ3KiKyV/iLX4Xpcfv1lkJzb5jsBfV0Gup0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ib7QLhO+fxZOwPJNUB43bjppstdngCG6rh1dMFX67vm2xHc902j+AYYpWI5OeiscI
         XBWDhLNM89oTYcJdVrzRg9BQaJPftYV155LeF6KKMGgQ1DTzjemBG1aWlN/ozVo81+
         AkEn38XP8uxtQltmDvV+DbSx54i2XNNd4V/OKl6e041o1o7miISG1rkHgZ9mK1XCbu
         iNHhpP0dwKjn2VXk4SnMrKIkKkfkf7gE6i/Mvkagwq062VCP9lHbkgIu4FjD9MwRh+
         Uaen15pskfu7saWpQi7QEbp4NCQdMeXMah2NZ/IksjtPc8YzAlBYPpxpJl398Q6w/N
         ol1HdFQMqd+ZQ==
Received: by mail-lf1-f45.google.com with SMTP id br9so20725616lfb.4;
        Mon, 30 Jan 2023 11:45:17 -0800 (PST)
X-Gm-Message-State: AFqh2koS8OaK59he3THjPwhz496ITerhpGIJV9iHV7JS08FpRufdQgaN
        qS9kbWrYjJEGJu73dKZ+czFt6Nv+hUXG/SQiBWw=
X-Google-Smtp-Source: AMrXdXuJOo7Pbv6iG6Moq7Ekn6wEAfrVjI/RQUFeuIXgnRtOAymLGgvgkwj6Zk11Ct0HYyEHh/eJJ8bCCHgUjjNms4Q=
X-Received: by 2002:ac2:4c4a:0:b0:4cc:a1e3:c04b with SMTP id
 o10-20020ac24c4a000000b004cca1e3c04bmr3476130lfk.15.1675107915984; Mon, 30
 Jan 2023 11:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20230129231053.20863-1-rdunlap@infradead.org> <20230129231053.20863-3-rdunlap@infradead.org>
In-Reply-To: <20230129231053.20863-3-rdunlap@infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 30 Jan 2023 11:45:03 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6GgFyF8AwJeZDTdtKfvDw2gRwPyQKii7Sgx-XqvtAcrw@mail.gmail.com>
Message-ID: <CAPhsuW6GgFyF8AwJeZDTdtKfvDw2gRwPyQKii7Sgx-XqvtAcrw@mail.gmail.com>
Subject: Re: [PATCH 2/9] Documentation: driver-api: correct spelling
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jan 29, 2023 at 3:11 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Correct spelling problems for Documentation/driver-api/ as reported
> by codespell.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: nvdimm@lists.linux.dev
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> ---
[...]
>  Documentation/driver-api/md/md-cluster.rst            |    2 +-
>  Documentation/driver-api/md/raid5-cache.rst           |    2 +-

For md bits:
Acked-by: Song Liu <song@kernel.org>

[...]
