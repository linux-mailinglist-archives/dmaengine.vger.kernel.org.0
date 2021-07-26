Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579863D6800
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jul 2021 22:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhGZThD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Jul 2021 15:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhGZThC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Jul 2021 15:37:02 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A34BC061757
        for <dmaengine@vger.kernel.org>; Mon, 26 Jul 2021 13:17:31 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id b1so8010397qtx.0
        for <dmaengine@vger.kernel.org>; Mon, 26 Jul 2021 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9INTzt+NTK+gmpZDfXmR+FklDZnFxgTPZTcF1bLjrBs=;
        b=cq0wESLS30PLQefH5Gd7d4yKB78mYVmGBusE+kcDF3GqDUlBGY8zhj3SO3IBHAlnyI
         ucqSo/YnfDAsZvNee+0pCX2APx1bdzvHoTo63xrZJmQtZi80ydgDCYQ4W+fB8/kTrcVD
         k1RGsaiIck2a/ZBGodeXdviys8xUJC2tqPl85AY178GJUsfnOymL1GqzmfNjjZspSBzC
         yE3KVwMMF6tsnMji69ao+zM5Nu6KLcV+R3ggJE7mYL9oiJ/Fjt9dE7h5ZX67D49Cw03w
         lgi/XgqQofG5ko5iKI4jZygkgwU1pdKTbQKhiamQ6SrI8GddImYdb71rpSS5FSWCexhz
         fFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9INTzt+NTK+gmpZDfXmR+FklDZnFxgTPZTcF1bLjrBs=;
        b=PcOiB8vrF7Hn2mvwlkMjyXyZ89Dk6mvhukBKudPX496gJHjmzhX7jmHWGI8s4sxGwK
         6tG29T0XXE2iYLk3r01eSzdO6FzHDP/Hn/Ns4f0OO0kauftrD2+RWCUAT3iLkYe4TEjk
         v4Fnrk0X4NS3pxh7BUV9CKl4GPa/Q1i0lyWkMoUVfVybZOhJQqZURMwn83sJ1GY3/0Yd
         HrDA+/cVlCpnxcr3jWM/50Nf1crXXVZOGUcrIYunhXkkiwNUvfiRJrmJQMbIRuIZxHck
         i4jw6vA+HlVgxWqooY10unsx+ITpwu6qkKJkXwSocHbZ/gX/PSHWxQKvssf/pNZ43BHq
         M0wg==
X-Gm-Message-State: AOAM531EJC+u3e22hAZs6jGYzU0UoTDkYkXtwhp2yeOuU5CnvJfnnkQq
        dtUBayTKcF6QqHwali/lCKC4vF0lQtivTLQDLthPBBFxsjQ=
X-Google-Smtp-Source: ABdhPJy1xOG1SwrRltHApamZbP1DTyAtWHtEcTm43VWrIIxRvZCeb/hbzSfRv8v6+fHVeOF5RKzGkvdT8A34VaulmLw=
X-Received: by 2002:ac8:45cf:: with SMTP id e15mr16713275qto.347.1627330650099;
 Mon, 26 Jul 2021 13:17:30 -0700 (PDT)
MIME-Version: 1.0
From:   Brian Varney <bvarney@gmail.com>
Date:   Mon, 26 Jul 2021 14:17:19 -0600
Message-ID: <CA+WACTdfQfDXm6H7MrkJda2t51Fn-z8sM6-RDd0Kc92cW8OjQA@mail.gmail.com>
Subject: dma_alloc_coherent / dma_map_single question
To:     dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

I have the following situation:
1. I'm using dma_alloc_coherent to allocate memory for DeviceA
2. I use DeviceA to fill the memory buffer.

Everything is fine so far but at this point I would like to DMA the
memory to DeviceB and I'm not sure the proper way of doing it.

Is it allowed/ok/proper to call dma_map_single for DeviceB using the
address returned from dma_alloc_coherent called on DeviceA?  This
seems to work fine in x86_64 but it feels like I'm breaking the rules
because:
 1. dma_map_single is supposed to be called with kmalloc addresses.
 2. Since the address is from both dma_alloc_coherent and
dma_map_single, I don't know if the dma_sync_* functions are necessary
or not.

I'm worried that I'm just getting lucky having this work and a future
kernel update will break me since I'm not really following the rules.
My code may eventually have to run on ARM too, and I'm not sure it
would work.

I have also considered:
1. Call dma_alloc_coherent for DeviceB and memcpy the data from
DeviceA into it.  This would work but I don't want the performance hit
of double buffering.
2. Get rid of the the dma_alloc_coherent for deviceA use
kmalloc/dma_map_single instead.   This would work and maybe is the
right thing to do.  This requires the extra hassle of dma_sync_*
functions which I was trying to avoid.

Is there a better way of doing this that I'm missing?

Thanks,
Brian V.
