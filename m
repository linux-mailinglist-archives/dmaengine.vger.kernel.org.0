Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757DA65C55D
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 18:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjACRuT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 12:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbjACRuN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 12:50:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC8E10BF
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 09:50:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d9so1809363wrp.10
        for <dmaengine@vger.kernel.org>; Tue, 03 Jan 2023 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyYi4Jm2MdjvyDWb5zjv8Qzw0iEU31dCdMdvKdbQK0g=;
        b=fUJ8xNanL071cXbUvdWe4msB0sV2ETZzqkTxgI8rcJGbN8fz43Ac3FkotVyhf6LE/8
         80sYxbm5BZ+Vl7cC2bO553m5uyp5d+cdEQkL+wz+UJZsnxfLbzhPvwnAx2u9NhdRNVB/
         zdg+c3adZPbLgP/yVwZpLK42bKNzEl9svV9mio4niiGyj1ZrCqcO7PceOiJpivypwiEq
         cMpRyQif78iSjOxHoR4aZBquzOe0Afj8oHadnA3CkSPtXXyuir2ldflHpp3FlIa+11LU
         C39ApCl6Q9v7xsH1Q0BGZzs555ka6qYsUR+Ym/+yviFluyyOPa6M1luR37fXeWSfAowP
         kpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyYi4Jm2MdjvyDWb5zjv8Qzw0iEU31dCdMdvKdbQK0g=;
        b=J2xBYN4eYsuLdF85tbyQ2P/DVeUv/+g4TKNUNGjfQS3OU5++klZokvI5cAfvfsl+M3
         2pVx2yNuCkCJ/rty88q7T/xzQE1zluwBErWaDnk0V4njxi9E819qX5qKQ6QxXuF64XvR
         zZ6T9OmccDqQBUToiRYeajd5fgo6Io62Tr8exrV0qQtXqwDmhjXmpwqZCUc+I5HhXKMn
         DOfC/DDl52GIUtDJwFtr693DTkewmuHgQUNds3QllejljimSuBivmJFKxhuTYlxtyMD3
         40y4iFAbF+k1CvA5dnZ+CpjYPabwybsgk1LnEv+PL6J0IAOVDYc/qK/o3y5agxidZGXF
         0RZg==
X-Gm-Message-State: AFqh2kpY78GvIatrDw1kMAwK91OD5LWvQrqIXUPmxrN7QIL7H1rcrf+t
        TrlpoZ5t3Lz/kcHhIIVtb3A=
X-Google-Smtp-Source: AMrXdXu1jUYyzGn58FFpX+lardEs6qySlMKy18QOaJja/qmX2K21PA5TetmYJ0AtHq/FVglTZmHx3w==
X-Received: by 2002:a5d:554e:0:b0:271:fbdb:73d2 with SMTP id g14-20020a5d554e000000b00271fbdb73d2mr24495795wrw.12.1672768210805;
        Tue, 03 Jan 2023 09:50:10 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id h18-20020adfa4d2000000b00241cfa9333fsm32853921wrb.5.2023.01.03.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:50:10 -0800 (PST)
Date:   Tue, 3 Jan 2023 17:50:09 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        dmaengine@vger.kernel.org, Tony Zhu <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 09/17] mm: export access_remote_vm() symbol
Message-ID: <Y7Rq0WRc4p3lCkjk@lucifer>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com>
 <Y7RpuqbTAM11wVQG@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7RpuqbTAM11wVQG@lucifer>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jan 03, 2023 at 05:45:30PM +0000, Lorenzo Stoakes wrote:
> Can you explain what use case you have for exporting this? Currently this is
> only used by procfs.
>

Ugh I hit send too soon ! I see you've explained the _why_ (i.e. idxd). The
other two points remain, however.

> Additionally, it relies on a reference count being held on the mm which seems a
> little risky exposing to a driver.
>
> Is there a reason you can't use access_process_vm() which is exported and
> additionally handles the refrencing?
