Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C4202CC8
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2020 22:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgFUUpR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Jun 2020 16:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgFUUpQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 Jun 2020 16:45:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3406C061794;
        Sun, 21 Jun 2020 13:45:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f18so13886088qkh.1;
        Sun, 21 Jun 2020 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69sqAb6PtzlOsETgOwIYJYItUN2UtrTOjmN+peBeU4Y=;
        b=FkLGPmO6WWMaOWhz7QB1DTT1SNCpG15DKCCzcR+MAGi4ZgbjTxdPI55Hq36CFGSQzW
         8oSyqiUbotqFVhiaq1QWQIGYVUA299Z3siJYQmHGXo+mRcvSZd5YC2AW8RBrPyM0AASx
         /uAL10MwAvhBDrLVhPHHGbThOvw96h2CibArNvwmXI2aypOB8IV2M9sDXFsZi26R+d18
         FD5Q26rPDiXzdTB/nnLafLn+YHDEJCFe31+aiZXVFjMFSz0fzibZW1C//7/6MmJKbb9/
         FJQGp0lKvu5UnBVVNIviyBUoQLCIta/f+KQPMr1Q4+PW53i9xmFld8c1l3Oqf/kEJ1Qy
         nQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69sqAb6PtzlOsETgOwIYJYItUN2UtrTOjmN+peBeU4Y=;
        b=qyipkjao6eg1tnZiMT1k2usIShQ/h41p7jmpPc3bzAj+HBUmirRJrn2jlO1hYRNCbT
         ooSR2ZjZkQbWT52zPcrNmlsPLbVk1oO1nkkKn24yWasfzNXo4kWqhaPZ0kIiNI4fr0rX
         gRQci0ZF5VKEABAOqsqRTo8Vg0b0nLCxNJO34XGQAUEtf3Xzsffhk7/MB2RYx4xuTUKe
         +Bas5m3Z1l2i5pOjVx8Cd0NJaZ42ispMHRcluGGSyzLAtK7GFfWiLqa3enMYguNkDF/j
         YKe8cXCYzJMOMUT1RI63WmE7TtBk4z9EQT9gQkNa11tSpYCKpuRbgpZt1d6+epwt20pl
         46wA==
X-Gm-Message-State: AOAM533en4G3oyyMa9grP7NPB9JBexhQu0liDpUEiFAxAHzy+XBDuTss
        FN3UCZ77VTBtFHDwMkq+1je00CduyA9dXcnIKxhJyQ==
X-Google-Smtp-Source: ABdhPJzEY1SgrXXhiYAmpZU8YmTa1NSk+ahX+IyukV0zAijACbGafncE+jVsQuZG2+qUUklMuyf8ZgFokFB4w9d3Nwg=
X-Received: by 2002:a37:9147:: with SMTP id t68mr608599qkd.34.1592772315942;
 Sun, 21 Jun 2020 13:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <5614531.lOV4Wx5bFT@harkonnen> <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl> <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
In-Reply-To: <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 21 Jun 2020 22:45:04 +0200
Message-ID: <CAFLxGvyaqOsrtD5_Re8_T6BXEaV64vFO2e_2eafrHEr7id_ubg@mail.gmail.com>
Subject: Re: DMA Engine: Transfer From Userspace
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jun 21, 2020 at 10:37 PM Federico Vaga <federico.vaga@cern.ch> wrote:
> >Federico, what use case do you have in mind?
>
> Userspace drivers

Is using vfio an option?

-- 
Thanks,
//richard
