Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB665F57D
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jan 2023 22:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjAEVFE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Jan 2023 16:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjAEVFD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Jan 2023 16:05:03 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FC66338A
        for <dmaengine@vger.kernel.org>; Thu,  5 Jan 2023 13:05:02 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so2266097wmk.4
        for <dmaengine@vger.kernel.org>; Thu, 05 Jan 2023 13:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HoWJgXt75B2FaD5T8CG8P5HWgc9d5ls9y8uuDb2TdCk=;
        b=Cvvxp/eZbhwKnViR7moem4VFGoYLw1ZPpnfYtO+GTLH0Cp1P5dpDAG6yMxQ7XAK4rP
         l0fmAwxjlWee1lz1fV/WXAjYRG6zKRpGHYflZZdVRKe/KxsE14ehtX/LcHl6LQjn+9pV
         OxMTdclWovGYNSTyHuMLjBDGJMH/r494voTBcRH2ERxKF9m2/zNZqzw3mT0PnwDyuld6
         KurK+82Xo/rw3fGpBzW+yKIdetfOYItwCAs63ZC3lDJRWPyF61HX5W6N67/8qzQXQ01Y
         V6vFee4KD/6Fd0vK4oyBTnoFBcIz6+8WsqZ4yesAqdGyRaSti0f1xEoB2Z0/T+7wo+7w
         RAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoWJgXt75B2FaD5T8CG8P5HWgc9d5ls9y8uuDb2TdCk=;
        b=Njp4g9cO0FMVIzxg0E3DxxrjgRqLQDtPyqDPNyyEPLUclQ2K8R+8QWN1caM+5obZVI
         fM+p2Kb9W3aEE9+cMiLGb5+llzbJZ8A9/3V/1SECGs8fxNppHuN5wjFkECKJAvNd/JYJ
         d5U5Afv4bWBf9dZ1KSBJUKPyf+MXBdwYM0hHqMdfGhlHHV3irhvOkIgT2sIo9JKLe2iE
         2J9e2qqEDgGxT0qZmTW9r9ob3ly3t2Qh5n5pUjw4ZfIHr65n6Lki+h4vw91pGnLbYvWM
         PFFXBs+P0o6p8pRfQ2aR4CnSr2BTW1UINJLZa0kARPDlIN3oua7xecf6VU05mGgUzzrD
         KCsg==
X-Gm-Message-State: AFqh2kpBpQnl/OYXpc+N4yPrS9YN3XCeK6FCqxacua01fV1b+u0En/v7
        eDQIQ8mZ78JATnLnuy+aL78=
X-Google-Smtp-Source: AMrXdXv2shvhv/8hSUoaMitujEMFKLRB8CO1/qW92HGxAtrkhB8CmUefelbTOZw24lw/jenTP34FHA==
X-Received: by 2002:a05:600c:214a:b0:3cf:6910:51d4 with SMTP id v10-20020a05600c214a00b003cf691051d4mr36994060wml.29.1672952701014;
        Thu, 05 Jan 2023 13:05:01 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c2caa00b003cfd58409desm3721982wmc.13.2023.01.05.13.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:05:00 -0800 (PST)
Date:   Thu, 5 Jan 2023 21:04:59 +0000
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
Message-ID: <Y7c7e8vEY0CPfkbx@lucifer>
References: <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
 <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu16rdea.fsf@nvidia.com>
 <Y7XZ8zY3KIRDlu/f@lucifer>
 <87k021vnmw.fsf@nvidia.com>
 <IA1PR11MB6097336ED90E27E78E069E299BFA9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu15u061.fsf@nvidia.com>
 <IA1PR11MB6097D5C6C3182A3C782E99D89BFA9@IA1PR11MB6097.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6097D5C6C3182A3C782E99D89BFA9@IA1PR11MB6097.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jan 05, 2023 at 08:58:08PM +0000, Yu, Fenghua wrote:
> This looks better than exporting access_remote_vm(). I will remove this patch
> and write the IOMMU wrapper to call access_remote_vm() in v2.

Thank you both for a very constructive conversation! I definitely think this is
the right way to go.

All the best, Lorenzo
