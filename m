Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB43965E609
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jan 2023 08:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjAEH22 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Jan 2023 02:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjAEH20 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Jan 2023 02:28:26 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7181853737
        for <dmaengine@vger.kernel.org>; Wed,  4 Jan 2023 23:28:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso651032wmq.1
        for <dmaengine@vger.kernel.org>; Wed, 04 Jan 2023 23:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSNU9QS85iBIZSSlQudLPj7Q9xV/goCsALmfh82q8io=;
        b=C/iDmm0Fr74H9SiEg8yd206ARmUbONcmSHkmR2pfu+WJRZNfp5fMn3Gt5SVV/I+o6C
         tbkggBd0AZSkjb/xaz0OuPDh1XYogcAjf/I3ZGp1E3smL5d55yiSzROeaK0wSFWITndU
         sV51gla5yRpL1gziG7TZuIVXGsEbyEN1WD8qv9lXfFa9SPnkndo2uUsE0WROiQsn5Psj
         XCuiEzmMIkgD1zbTQgI87MBa8tW9i42Qwvba6e6ZXNpCs4CsLZI3YV60+2MWFce4zoro
         PgLoFA982OMiZjeYujCRuh/GZHOWy7Sjj3MnUu4Iscu1AWc5AEQBUOs+2x99LmzLtuxB
         FBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSNU9QS85iBIZSSlQudLPj7Q9xV/goCsALmfh82q8io=;
        b=ccVhlVKBbKgNLDaZEMRWuhxDkBz6HZybVigg0c/+r9p0RqlHH/v+mbtyQ6dSJ6FDzR
         Yr7msrkGakFOAzAl6ZTTzH47cFBxR9eZ1qOfXszBaodfmMXTJSVRFPB063YjSZSF6B8H
         T/cJS/WDmsrXeGQN1W+UHuSzLt5m3t2+hR1KPl+FW2RMtng+XFUvPLiRErhR9LVnV90j
         pbTZj3NupQV9FZLdbzawiqIUHOTpqcIy1B0LSw3tnZ1te3KzMj4SGnOZ3kjiZNgZhGVp
         tZ/OduSfLcsd24ymXewK1uU+Dt0W/ZoRdwEtyMGBeGtQyyiXXn4Ikx5ANSIz+TG3Ag9c
         tRpg==
X-Gm-Message-State: AFqh2kprbTb5KWhqUuqrNc1/XJNLqYL1Nr9grdX5y/SVJntcyeIP2gAs
        zOWd3J7hePHiiEmRaNeYQUU=
X-Google-Smtp-Source: AMrXdXt07zoBecAvgIbSTx/PLlMy1ujJdHwsRkS5L50p1dqMUKAi5wXSBrQYpa1oeRULKXTjC50Sdw==
X-Received: by 2002:a05:600c:4d25:b0:3d2:27ba:dde0 with SMTP id u37-20020a05600c4d2500b003d227badde0mr36262386wmp.33.1672903702291;
        Wed, 04 Jan 2023 23:28:22 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c1d8700b003cf4eac8e80sm1611260wms.23.2023.01.04.23.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 23:28:21 -0800 (PST)
Date:   Thu, 5 Jan 2023 07:26:10 +0000
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
Message-ID: <Y7Z7kjnaEk1qwRi8@lucifer>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com>
 <Y7RpuqbTAM11wVQG@lucifer>
 <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
 <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu16rdea.fsf@nvidia.com>
 <Y7XZ8zY3KIRDlu/f@lucifer>
 <87k021vnmw.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k021vnmw.fsf@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jan 05, 2023 at 10:57:02AM +1100, Alistair Popple wrote:
> Ok, although I think making this an iommu specific wrapper taking a
> PASID rather than mm_struct would make the API more specific and less
> likely to be misused as the mm_count/users lifetime issues could be
> dealt with inside the core IOMMU code.

This sounds like the ideal approach, as long as we either mmgrab() or otherwise
ensure that the mm won't disappear underneath us, then use mmget_not_zero() to
get a reference in this wrapper function, I think we're gravy.
