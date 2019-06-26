Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B348C5705A
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2019 20:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZSPJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jun 2019 14:15:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54126 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZSPJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jun 2019 14:15:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so3076777wmj.3;
        Wed, 26 Jun 2019 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y1EU5SrEVuCxi1awwfJ1Xx4eANFBAlT5Z9JwCJMtbug=;
        b=CJHL2z+v4KRX896cUrFppatyVcEGmmqtaCmcLWHEvylIOffPIqiZpctl8mYzydsVyq
         RNo26/OObJwwk2sRJS+bUswcHRSA7B+JMwXngf0Xv6XXv4i8oVhjiEQdZSx+x5Hghd7z
         6QhUbgU0/k+G1LviEQ2ZtyAvznkIAD/5nmoUgsf4VVelyfrpE1iQuOsv8+zGUGmvH0vF
         FGoUCJYgHkmr0VnXcTixG8mQqS3W977KqMfJz4sO3I07YJdHjsZ0LtlGgegXPbIT49fl
         xD7bQ62RhBlhZR2Uuapp65sN0OPTXqecBW1St0+ken3i0cFt3H0qe4m4t5H0KxnC1b+v
         fB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y1EU5SrEVuCxi1awwfJ1Xx4eANFBAlT5Z9JwCJMtbug=;
        b=rpDZlrWlXQKoqkEyocLQBpFry13rOzgVDS8tENzPwR8wRjvpU0MZ8e3AE5jlxwr2gG
         xkhNhzpQADu0YWQhOhZy2ydlKOyctlfEzLUXYsk+Xic2LpL1LQiQk6jf4UTS0n/d2N77
         KfJQsgK+EHgQTAHG6LZzy+zrwIWTBDWY5ULnu5U5ilsKfLSufY6avQyOrXnAnuPo50lX
         psWaaKFzmpbd9bzjc2BMWjB6+lEVzmzMd9ou6v3Z6Wx0+2zLy+pvZ3kvXdotmG+yT9MI
         AQ0C1bPEfwq1/eWPjqoeyo5yNjcmsH741Rp7OGm/glTtNQfrNiTA4ufWTjGKsukXR+Th
         fU5Q==
X-Gm-Message-State: APjAAAUrUyq2qnPN/C9DJalZwKejYiyw98UgZ1z4uK0L0+9XMvDv4Vj7
        AEShF8+ox6iiO95bugOCxJ3+klFPaQFgCw==
X-Google-Smtp-Source: APXvYqxRWLgeCR6zmx7Pm5clwXV0bAHv6d3nw9+QOfSoxmv//lqPwh0yoNYhASkZeQJcYlrIkgU3JA==
X-Received: by 2002:a1c:618a:: with SMTP id v132mr208298wmb.17.1561572906411;
        Wed, 26 Jun 2019 11:15:06 -0700 (PDT)
Received: from x230 (ipb218f439.dynamic.kabel-deutschland.de. [178.24.244.57])
        by smtp.gmail.com with ESMTPSA id p140sm1813229wme.31.2019.06.26.11.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 11:15:05 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
Date:   Wed, 26 Jun 2019 20:14:59 +0200
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        dmaengine@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Reject zero-length slave DMA
 requests
Message-ID: <20190626181459.GA31913@x230>
References: <20190624123818.20919-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624123818.20919-1-geert+renesas@glider.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

On Mon, Jun 24, 2019 at 02:38:18PM +0200, Geert Uytterhoeven wrote:
[..]
> -	if (rchan->mid_rid < 0 || !sg_len) {
> +	if (rchan->mid_rid < 0 || !sg_len || !sg_dma_len(sgl)) {
>  		dev_warn(chan->device->dev,
>  			 "%s: bad parameter: len=%d, id=%d\n",
>  			 __func__, sg_len, rchan->mid_rid);

Just wanted to share the WARN output proposed by Wolfram in
https://patchwork.kernel.org/patch/11012991/#22721733
in case the issue discussed in [1] is reproduced with this patch:

[    2.065337] ------------[ cut here ]------------
[    2.065346] rcar_dmac_prep_slave_sg: <here-comes-the-warning-message>
[    2.065394] WARNING: CPU: 2 PID: 252 at drivers/dma/sh/rcar-dmac.c:1169 rcar_dmac_prep_slave_sg+0x50/0xc4
[    2.065397] Modules linked in:
[    2.065407] CPU: 2 PID: 252 Comm: kworker/2:1 Not tainted 5.2.0-rc6-00016-g2bfb85ba1481-dirty #26
[    2.065410] Hardware name: Renesas H3ULCB Kingfisher board based on r8a7795 ES2.0+ (DT)
[    2.065420] Workqueue: events sci_dma_tx_work_fn
[    2.065425] pstate: 40000005 (nZcv daif -PAN -UAO)
[    2.065430] pc : rcar_dmac_prep_slave_sg+0x50/0xc4
[    2.065434] lr : rcar_dmac_prep_slave_sg+0x50/0xc4
[    2.065436] sp : ffff0000112ebd00
[    2.065438] x29: ffff0000112ebd00 x28: 0000000000000000 
[    2.065443] x27: ffff8006fa367138 x26: ffff000010c5bce8 
[    2.065447] x25: 0000000738b1d000 x24: 0000000000000000 
[    2.065451] x23: ffff000010b76e00 x22: ffff000010a18000 
[    2.065455] x21: 0000000000000001 x20: ffff8006f9b5a080 
[    2.065459] x19: ffff0000107adc86 x18: 0000000000000000 
[    2.065462] x17: 0000000000000000 x16: 0000000000000000 
[    2.065466] x15: 0000000000000000 x14: 0000000000000000 
[    2.065469] x13: 0000000000040000 x12: ffff000010a35000 
[    2.065473] x11: ffff000010b12981 x10: 0000000000000040 
[    2.065477] x9 : 000000000000013e x8 : ffff000010b1b73b 
[    2.065481] x7 : 0000000000000000 x6 : 0000000000000001 
[    2.065484] x5 : ffff8006ff72f7c0 x4 : 0000000000000001 
[    2.065488] x3 : 0000000000000007 x2 : 0000000000000007 
[    2.065491] x1 : 878c73041cedc400 x0 : 0000000000000000 
[    2.065495] Call trace:
[    2.065500]  rcar_dmac_prep_slave_sg+0x50/0xc4
[    2.065504]  sci_dma_tx_work_fn+0xd8/0x1d4
[    2.065511]  process_one_work+0x1dc/0x394
[    2.065515]  worker_thread+0x21c/0x308
[    2.065520]  kthread+0x118/0x128
[    2.065527]  ret_from_fork+0x10/0x18
[    2.065530] ---[ end trace 75fc17d9000f1224 ]---

At first glance, it seems to give more details compared to:
rcar-dmac e7300000.dma-controller: rcar_dmac_prep_slave_sg: bad parameter: len=1, id=19

[1] https://patchwork.kernel.org/cover/11012981/

-- 
Best regards,
Eugeniu.
