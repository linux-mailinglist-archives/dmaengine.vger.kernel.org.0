Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438C831BA4D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Feb 2021 14:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhBON07 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Feb 2021 08:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhBON0n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Feb 2021 08:26:43 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25A5C0613D6;
        Mon, 15 Feb 2021 05:26:02 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id my11so2670872pjb.1;
        Mon, 15 Feb 2021 05:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBnx1kDe3EFDlt7rxj/CXQzznsDJFWB2/f3gowikweg=;
        b=GVucbqKADNBuLhtE40/tqMhIIHvmsEBrHZX2JPzZG3Jva06rMgLHKNEPR7PeIEW0X+
         cm0XZrj9RzGC/+ORdxO+d/5rXvJPqwdj37BFYO/037M0z3WvfIIU/ufEpZcwc+oIqZAP
         cBqd9mJNn3D6BXTHNQR/U/noEt1S1jj/54JKGmAv6KkCx5U6gYcK13xJptBT471ZzIC1
         4eoouDRxIVj74SzqcodSAx55dXr1okNdrljajoTaf2HkV2O1dpLHthVzBZkgMLbNJMGD
         +5RQh8C3rv49B0RdDVakZuZBuWkj/nSd/1cTIkKcWYZQ7AEhZYXd8n8dl2/ljOFVrx0R
         qtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBnx1kDe3EFDlt7rxj/CXQzznsDJFWB2/f3gowikweg=;
        b=Im1OX0c1gDDLdQgef+oKnOD8kZlVj3Fpp23FNslJLd2uqMwwcYl4wmSqPydx6sA4kS
         fc7MiyEudYbMjbrbDna9+ujjgzngLp9Lc+QzCnmsELGMvpYyqYwNh7XuAQ1jRAHl2Ca8
         TBBDBdwOX0uIiUEXqPgVd8Jzc3F7S9wJA+bJHCz67zmfX85eFvLTnSPWkoqsyoOImClz
         o9zStgR5bkmWgWg6DxTDPZ+D6IFFgRgQm9/VNJOGF1EA4hx0gVuaJBZAIIiyBH+jaNAv
         b0RcdSi/9BQlFJy6JZ5JtfIq4sYRm0OEFrz3Qn9TEe+M8S/XBl8fSgl3yTsB+9K9aS9n
         pNPg==
X-Gm-Message-State: AOAM530yvW/UAztdf/s5ZSithqXo8u3iVxGZH/vROiXA9rn9DPGuZ1HE
        aP3Pammp6D4xespQEoCbQx3tgBchLD0qstMfkss=
X-Google-Smtp-Source: ABdhPJy1RDwe7j+gv7jN67oYyFmTUCAxioZCw3OsTgN2Lrh1exKfRImpKnnvEJrdbGDG75+GXgQtebfUTBpUs/SEQ2s=
X-Received: by 2002:a17:902:eac1:b029:e3:4940:541d with SMTP id
 p1-20020a170902eac1b02900e34940541dmr8159981pld.21.1613395562273; Mon, 15 Feb
 2021 05:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20210214132153.575350-1-zhengdejin5@gmail.com> <20210214132153.575350-2-zhengdejin5@gmail.com>
In-Reply-To: <20210214132153.575350-2-zhengdejin5@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Feb 2021 15:25:46 +0200
Message-ID: <CAHp75Vdt3j=gXepTfpSimazQZz63F1qwGwooh8jsbYKa6=mntg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dmaengine: hsu: Add missing call to
 'pci_free_irq_vectors()' in probe and remove functions
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ferry Toth <ftoth@exalondelft.nl>, qiuzhenfa@hisilicon.com,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Feb 14, 2021 at 3:22 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
>
> Call to 'pci_free_irq_vectors()' are missing both in the error handling
> path of the probe function, and in the remove function.
> Add them.

> Fixes: e9bb8a9df316a2 ("dmaengine: hsu: pci: switch to new API for IRQ allocation")

Same as per others. This does not fix anything, because there is no issue.
If you want to have it better, introduce a pcim_alloc_irq_vectors() to
show that it's managed.


-- 
With Best Regards,
Andy Shevchenko
