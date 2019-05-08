Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB01717390
	for <lists+dmaengine@lfdr.de>; Wed,  8 May 2019 10:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfEHIXa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 May 2019 04:23:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41747 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfEHIXa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 May 2019 04:23:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id d12so5496651wrm.8
        for <dmaengine@vger.kernel.org>; Wed, 08 May 2019 01:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0VaTvjNyXoq1yX1XR0J7JNm8sTNFuKnRMk+whuCu7D0=;
        b=fGLUoVtCDVTy/EbZ3Aa4OYIl8YNXBqQcG0i0y90ufvcnJ8n4yL0O/n0ekwzNydey92
         v0Awd6F/VQU+HgQEaANzx9MzaKcWYwE67dbc2TCkzYrbXQxKTiWFSa6L67UIg7guMbph
         WHDsY3CKCWTvVQ1kQpm+ta0OfCgWntQ0O6dlxRC5lLYRxUzyVZz78y5IXxA7AufnTtrZ
         UAlJz/TRCx8HFW335qSNijJH6fImG7WTdf8dSUWVRpufQPge60SvNYa1DF2UK0zmYakE
         6fM8CCJg+VNmIG9Iq3AP6NiWlnYRfvc2T/+VbOAKKhvPfkPA3m4tiG0/TVmPnbzLZIsg
         exOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0VaTvjNyXoq1yX1XR0J7JNm8sTNFuKnRMk+whuCu7D0=;
        b=nGkhGIbxHzgrixorttvSPdLkL7WW4VZ1qeVWOI1E3bVavHtokQ30LtsvuWNvGDneEh
         4VdxsD85epWdeLNNQVTRVBhvH3H1pKWNxmjPoDSZRSAYRHk7baTSj0lJx3ArdcjomD+G
         n1BWSzKc6mKvqZuudlB9Eoe8qh8ojdL9nF82itJmxmaVdS/A76Ub6JJ9n3fAUXiBG1ud
         BmH/dQw9nz0keCAFZCAcu9m2uabgPL3/aSDs+2w+FsYYvlEJIDX3i0f6OFtRYk8zyKPP
         o7K1cpUsJSy0cp7YWH30A8aVT7HbmapEc8cEKbllQuKtM/n2Y9i+RufPs6N9JEcXCtSZ
         THVA==
X-Gm-Message-State: APjAAAXrZmzV1jAwzm/QACNSM7a92KcTsxh+j5mn35xOVp2KABNLoePx
        6PBXThawo8xmrxr1Vyq/d62H7A==
X-Google-Smtp-Source: APXvYqwHUMEGeUXXCCTpY8J+5uQSK7p25YG8sDX+QsL/woRHz87n1bDtTu5pGXc2fGrZqds3aCCt5g==
X-Received: by 2002:adf:b641:: with SMTP id i1mr25939076wre.288.1557303808615;
        Wed, 08 May 2019 01:23:28 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id y7sm42196473wrg.45.2019.05.08.01.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:23:28 -0700 (PDT)
Date:   Wed, 8 May 2019 09:23:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Binbin Wu <binbin.wu@intel.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mika.westerberg@linux.intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v2] mfd: intel-lpss: Set the device in reset state when
 init
Message-ID: <20190508082326.GD3995@dell>
References: <1554710950-21212-1-git-send-email-binbin.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554710950-21212-1-git-send-email-binbin.wu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 08 Apr 2019, Binbin Wu wrote:

> In virtualized setup, when system reboots due to warm
> reset interrupt storm is seen.
> 
> Call Trace:
> <IRQ>
> dump_stack+0x70/0xa5
> __report_bad_irq+0x2e/0xc0
> note_interrupt+0x248/0x290
> ? add_interrupt_randomness+0x30/0x220
> handle_irq_event_percpu+0x54/0x80
> handle_irq_event+0x39/0x60
> handle_fasteoi_irq+0x91/0x150
> handle_irq+0x108/0x180
> do_IRQ+0x52/0xf0
> common_interrupt+0xf/0xf
> </IRQ>
> RIP: 0033:0x76fc2cfabc1d
> Code: 24 28 bf 03 00 00 00 31 c0 48 8d 35 63 77 0e 00 48 8d 15 2e
> 94 0e 00 4c 89 f9 49 89 d9 4c 89 d3 e8 b8 e2 01 00 48 8b 54 24 18
> <48> 89 ef 48 89 de 4c 89 e1 e8 d5 97 01 00 84 c0 74 2d 48 8b 04
> 24
> RSP: 002b:00007ffd247c1fc0 EFLAGS: 00000293 ORIG_RAX: ffffffffffffffda
> RAX: 0000000000000000 RBX: 00007ffd247c1ff0 RCX: 000000000003d3ce
> RDX: 0000000000000000 RSI: 00007ffd247c1ff0 RDI: 000076fc2cbb6010
> RBP: 000076fc2cded010 R08: 00007ffd247c2210 R09: 00007ffd247c22a0
> R10: 000076fc29465470 R11: 0000000000000000 R12: 00007ffd247c1fc0
> R13: 000076fc2ce8e470 R14: 000076fc27ec9960 R15: 0000000000000414
> handlers:
> [<000000000d3fa913>] idma64_irq
> Disabling IRQ #27
> 
> To avoid interrupt storm, set the device in reset state
> before bringing out the device from reset state.
> 
> Changelog v2:
> - correct the subject line by adding "mfd: "
> 
> Signed-off-by: Binbin Wu <binbin.wu@intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
