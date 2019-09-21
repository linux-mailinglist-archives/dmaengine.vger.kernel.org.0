Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0EB9E43
	for <lists+dmaengine@lfdr.de>; Sat, 21 Sep 2019 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393539AbfIUO6N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 Sep 2019 10:58:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41450 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390556AbfIUO6N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 Sep 2019 10:58:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so6431378pfh.8;
        Sat, 21 Sep 2019 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=rMu789LD1T8uU9KacNFi9FCRB7xCR3S38zLi0aGwMPk=;
        b=n35lnfvxCsApW2kK/lMjVc0YEBMnaP2lRsh3iZP3PqPJ2tV3sg11DolTl/kk9xyJde
         /ha5P/doLG5uKhkPQNY5bQt/JkPdzdAEqzqk3AkVfHXePMgjGLWFzx80KbrzYnZ78z7s
         oKFHDgAnjMCs0loyHFt1jjasbEjPENOE1nLRi9OkT3p6vUCxrLXzpNR/BOoFSGI+z9Y7
         4OaVoqk3tj5sFv/99bVXIE/7qHl3U+ulaMA5oy3DSGu7oxcstDO/eXPyv6MwtrqODYPG
         U1QjzItNO/Fqx18aXt3H2HDvTec+8NdgrenBqnlI0CejEldxq1YFrwkqsWEk6G5YoH8C
         mdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=rMu789LD1T8uU9KacNFi9FCRB7xCR3S38zLi0aGwMPk=;
        b=izd/ZohTSYNTXe4yKXd8tFo99/ktHj0JfJNs615xVOLjgopJ1mbI3j5ZHOsh+9sn+C
         A9if4zpUTfdzIXP8iFIuopdgT3HvNwd22aAqNMpVotwOik1YI07Lb3AtkTri5qZni/74
         dAHr5m/M9Fw9sOQkeuIxXCA+y2NYs+THJJG5gTudXUGV8rBXjIpyklcCbX1+rYNWPpG5
         8Or1AVCylBjOR5F5iiVfjlt58bvedDywTXA03d8BDt1TmI+qDVKMVp6ItP6jFsf235qt
         wGYmWYC0O5Xf7ekk6nGiJFOIKbapInz3VeHofzX+B/7baPxVEP8z5Epvz0x6KUoohN3S
         60rA==
X-Gm-Message-State: APjAAAViIAeo2KwNqVZVaAYGR45ldqvfDZ1N/6LHtBq9TmFVDh/K4itA
        CzJOA+wBcWIbXBlkkU3/GOI=
X-Google-Smtp-Source: APXvYqzq1rGaqCGeV44c1S06GyiRUKXeYke/1wz8RtK+UwfNjVz8EIJCJF0JnYuM5kiFHQQ1VUVAJA==
X-Received: by 2002:a63:2224:: with SMTP id i36mr12763638pgi.135.1569077891943;
        Sat, 21 Sep 2019 07:58:11 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.67])
        by smtp.gmail.com with ESMTPSA id r185sm5933695pfr.68.2019.09.21.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 07:58:10 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org, jun.nie@linaro.org,
        shawnguo@kernel.org, agross@kernel.org, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, maxime.ripard@bootlin.com, wens@csie.org,
        lars@metafoo.de, afaerber@suse.de, manivannan.sadhasivam@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>
Subject: Re: Re: [PATCH 0/9] added helper macros to remove duplicate code from probe functions of the platform drivers
Date:   Sat, 21 Sep 2019 20:27:26 +0530
Message-Id: <2356e29bca5bdfa901534bb32a2782185eb0415f.1568909689.git.sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918102715.GO4392@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Sep 18, 2019 at 3:57 PM, Vinod Koul wrote:
> On 15-09-19, 12:30, Satendra Singh Thakur wrote:
> > 1. For most of the platform drivers's probe include following steps
> > 
> > -memory allocation for driver's private structure
> > -getting io resources
> > -io remapping resources
> > -getting irq number
> > -registering irq
> > -setting driver's private data
> > -getting clock
> > -preparing and enabling clock
>
> And we have perfect set of APIs for these tasks!
Hi Vinod,
Thanks for the comments.
You are right, we already have set of APIs for these tasks.
The proposed macros combine the very same APIs to remove 
duplicate/redundant code.
A new driver author can use these macros to easily write probe 
function without having to worry about signatures of internal APIs.
In the past, people have combined some of them e.g.
a) clk_prepare_enable combines clk_prepare and clk_enable
b) devm_platform_ioremap_resource combines
platform_get_resource (for type IORESOURCE_MEM)
and devm_ioremap_resource
c) module_platform_driver macro encompasses module_init/exit 
and driver_register/unregister functions.
The basic idea is to simplyfy coding.
> > 2. We have defined a set of macros to combine some or all of
> > the above mentioned steps. This will remove redundant/duplicate
> > code in drivers' probe functions of platform drivers.
> 
> Why, how does it help and you do realize it also introduces bugs
This will make probe function shorter by removing repeated code.
This will also reduce bugs caused due to improper handling
of failure cases because of these reasons:
a) If the developer calls each API individualy one might miss
proper handling of the failure for some API; Whereas the macro
properly handles failure of each API.
b) Macros are devres compatible which leaves less room for
memory leaks.

Yes, the macros which enable clock and request irqs
might cause bugs if they are not used carefully.
For instance, enabling the clock or requesting the irq
earlier than actually required. So, the macros with _clk
and _irq, _all suffix should be used carefully.

Please let me know if I miss any specific type of bug
here.
> 
> > devm_platform_probe_helper(pdev, priv, clk_name);
> > devm_platform_probe_helper_clk(pdev, priv, clk_name);
> > devm_platform_probe_helper_irq(pdev, priv, clk_name,
> > irq_hndlr, irq_flags, irq_name, irq_devid);
> > devm_platform_probe_helper_all(pdev, priv, clk_name,
> > irq_hndlr, irq_flags, irq_name, irq_devid);
> > devm_platform_probe_helper_all_data(pdev, priv, clk_name,
> > irq_hndlr, irq_flags, irq_name, irq_devid);
> > 
> > 3. Code is made devres compatible (wherever required)
> > The functions: clk_get, request_irq, kzalloc, platform_get_resource
> > are replaced with their devm_* counterparts.
> 
> We already have devres APIs for people to use!
Yes, we have devres APIs and many drivers do use them.
But still there are many which don't use them.
The proposed macros provides just another way to use devres APIs.
> > 
> > 4. Few bugs are also fixed.
> 
> Which ones..?
The bug is that the failure of request_irq 
is not handled properly in mtk-hsdma.c. This is fixed in patch [5/9].
https://lkml.org/lkml/2019/9/15/35

Please let me know if I am missing something here.
Thanks
-Satendra 

