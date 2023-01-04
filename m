Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A31765DD56
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jan 2023 21:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjADUAM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 15:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjADUAI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 15:00:08 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD133FA14
        for <dmaengine@vger.kernel.org>; Wed,  4 Jan 2023 12:00:05 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso20897990wms.5
        for <dmaengine@vger.kernel.org>; Wed, 04 Jan 2023 12:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OG/y7xAe7GoU0v2u69k5lX/4KZLOEKX6GSOlMx3yuAQ=;
        b=jYTbS3tWP5PjKTYguj167jAFjYT2aPGkce/WrztXbN63Z0CVQr8Ld4Ac8efgxoL6DU
         ik3X9qtPNJEwy3wyFX1Ukf/DSERctCvNrNYUhM8W7RM9rm/3AQnMaGRJd4ID1dF4z3es
         dt0JeIWznmQgBiEyCqeYHezX8Vlzv9AtyGx9j9mm/qpDi8xZO5LkI78dyqrdoDDVQOaF
         nhUydsFwnoSvW3z8OOHlFeG7mk0+FJHB5RMEpQr7jTewbhwVtcYJisIUoI/YreJuAYtf
         87yGTnNs/lEO7qGx/rTR4yQJdWwAs/wXt+LpBqlvRNAzxAfcW6vWXEIz2mhZ25aq0t1R
         kmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OG/y7xAe7GoU0v2u69k5lX/4KZLOEKX6GSOlMx3yuAQ=;
        b=Wn/WRPFJ8NUYtWOhHK+pykuprnhNoBPaDmTTzTtDC3QmuD4tbJWtW3BuJQwCBZi/hm
         2faDaXRVgjx0E+30E1FeXZMHeoCo8X72c0qoPvhUxCbfewvaYJuzWmqgFPpCEZcTY3D9
         vRyh9JMMZy7vzgtNUJFd86IrK7Aj/HkU4rfjB7Voae93v9YTtEL3Ww/H//i5+qRS8BRN
         DK5tTxvpYMIPpX6VxC0IjpAa2WamrVzEBInYeNwttZ/5q/Qs5CC4PBAdlOpocinOmS69
         mb9a/O5inr4bRSXTpuJl4aWqesC0yoa7iWzpH6t/49wSujoeZi+ftiMQtSYOkSBv0KBR
         IKKw==
X-Gm-Message-State: AFqh2kpK/FY3d5912nhdOjW67FBmGGcL9+qOxVQFy/osNpuyiXOHHX8D
        k8DYthRGJSRzvEP0wUm12shGQyN+jpI=
X-Google-Smtp-Source: AMrXdXvfqTH0p/eJd0SwsLoZc2HcLfB3obqg0ghT/R+iy//w4COBtg/aXwEj7yayc8kTGnyia5x5pg==
X-Received: by 2002:a05:600c:54c2:b0:3d3:3c74:dbd0 with SMTP id iw2-20020a05600c54c200b003d33c74dbd0mr34390181wmb.13.1672862403849;
        Wed, 04 Jan 2023 12:00:03 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c191400b003b4fe03c881sm59068351wmq.48.2023.01.04.12.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:00:03 -0800 (PST)
Date:   Wed, 4 Jan 2023 20:00:02 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 09/17] mm: export access_remote_vm() symbol
Message-ID: <Y7Xawjg+uk/Ie7dI@lucifer>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com>
 <Y7RpuqbTAM11wVQG@lucifer>
 <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
 <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu16rdea.fsf@nvidia.com>
 <IA1PR11MB6097960B04B064457EABDA5A9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6097960B04B064457EABDA5A9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 04, 2023 at 07:00:55PM +0000, Yu, Fenghua wrote:
> So the current patch is good without any change, right?

No, you'd definitely need mmget_not_zero() (and a grab in advance of this,
though from the sounds of it you may already have it), I definitely don't think
the patch as-is works, see my reply to Alistair.
