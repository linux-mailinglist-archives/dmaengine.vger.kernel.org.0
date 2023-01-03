Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DF565C7E8
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 21:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbjACUN0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 15:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjACUNZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 15:13:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2D3FED
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 12:13:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y8so30807084wrl.13
        for <dmaengine@vger.kernel.org>; Tue, 03 Jan 2023 12:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrFn/NjeOH4GIyZk6aOm/OSPrHoFrPqY9Q0KHXjSIOs=;
        b=LTfRcMjBMP6gIbOXLqQvzwc8zWwgA9YuJuIwNXoB5HiHpV96tGWIAqNIClRBpSRMY+
         8C3EIvXeyt+OEQxGPwgFpC0UlcIipArPEIw6In/aqew5rlgAKagWCgSzGiZm/2wDj0+m
         G/LYvwTJhObr4IMOBpavJ08oAB4LiICY0icBPgjAwLcprYckh2Zq73FmYJkFPFRQrQGd
         9tuR1qECp6MqiTyew8fgZCK2wkg09Ip9/9cEqzMi4mLS7Nl7iRYDlXDPEq5iwOyCpUXy
         f9lyuc3ZhraRl7rpX9Jcc6g3r7DG+99KPwcZiJ/f9ZcAq8kA3vUknLz3fz/osj4Qg1UP
         3B1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrFn/NjeOH4GIyZk6aOm/OSPrHoFrPqY9Q0KHXjSIOs=;
        b=BuEZNaFRp1lE7nyxS4dI2P6T8qjLx8dHPAOwrq1iCMVRhmjEiph4S4PbuV9f2GK++O
         Uouj/0D5Jz660PEbA7hNQU1urBIgB921p+6UjnMyZQHmbV5Pzci+XPSgxkrkzpHh6qlW
         QKbm4pKFANuVKz0huKn/1B7kRkIBFoH+eW3f2Yo/GFyX55v0nqLmv+G7EG6m2yE19zgQ
         s2F4h6y9AmV6c6Lq25MhQeGfioUgpvJ3VFhig2sFsdT0d9tJbvZUTqakKM5x9CYXft06
         N3XKM7waw5MCFRPVn4uWXz8uYqQuzsd3u5MOCYyfHjZ1W3VTYVVL5uzEX1gDXsjv8DWH
         5YLQ==
X-Gm-Message-State: AFqh2krvdP/QdPy3wyXzKuI15KWGiqLGvU1VurVxZXxFi6BZ/GT/kiPB
        6ldr8st3wKFkglHUZ6xOp1e9ucXLu3Y=
X-Google-Smtp-Source: AMrXdXssXGWcR3yJzn67F8e02C9UPrjEFh09Ewfd8LoLuitb8R1jaHz081aPGwTe6+P/FZpD+hA59Q==
X-Received: by 2002:a5d:6807:0:b0:29b:4c0a:a446 with SMTP id w7-20020a5d6807000000b0029b4c0aa446mr3912218wru.57.1672776801660;
        Tue, 03 Jan 2023 12:13:21 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id d11-20020adffd8b000000b00236545edc91sm31856742wrr.76.2023.01.03.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 12:13:20 -0800 (PST)
Date:   Tue, 3 Jan 2023 20:13:20 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 09/17] mm: export access_remote_vm() symbol
Message-ID: <Y7SMYF8MlzeqDgp+@lucifer>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com>
 <Y7RpuqbTAM11wVQG@lucifer>
 <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jan 03, 2023 at 07:20:11PM +0000, Yu, Fenghua wrote:
> Hi, Lorenzo,
>

Hey Fenghua :)

> access_remote_vm(mm) directly call __access_remote_vm(mm).
> access_process_vm(tsk) calls mm=get_task_mm() then __access_remote_vm(mm).
>
> So instead of access_remote_vm(mm), it's access_process_vm(tsk) that holds
> a reference count on the mm, right?

Indeed!

>
> > >
> > > Is there a reason you can't use access_process_vm() which is exported
> > > and additionally handles the refrencing?
>
> IDXD interrupt handler starts a work which needs to access remote vm.
> The remote mm is found by PASID which is saved in device event log.
>
> In the work, it's hard to get the remote mm from a task because mm->owner could be NULL
> but the mm is still existing.

That makes sense, however I do feel nervous about exporting something that that
relies on this reference.

The issue is ensuring that the mm can't be taken from underneath you, the only
user of access_remote_vm(), procfs, does a careful dance using get_task_mm() and
mm_access() to ensure this can't happen, if _sometimes_ the remote mm might have
an owner and _sometimes_ not it feels like any exported function needs to be
equally careful?

I definitely don't feel as if simply exporting this is a safe option, and you
would in that case need a new function that handles different scenarios of mm
ownership/not.

I may be missing something here and I will wait for others to chime in but I
think we would definitely need something more than simply exporting this.
