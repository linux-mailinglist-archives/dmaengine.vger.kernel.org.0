Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B600B3A23D2
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jun 2021 07:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFJFYq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Jun 2021 01:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhFJFYp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Jun 2021 01:24:45 -0400
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A76FC061574;
        Wed,  9 Jun 2021 22:22:49 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4G0sn12lfgzQjZ5;
        Thu, 10 Jun 2021 07:22:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 3etomxc0zP3G; Thu, 10 Jun 2021 07:22:42 +0200 (CEST)
Subject: Re: [PATCH v6 2/3] MAINTAINERS: add entry for Altera mSGDMA
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <7487a25cdb240d1be4a8593aa602c3c73d8f5acb.1623251990.git.olivier.dautricourt@orolia.com>
 <4258cb93e0f7ff57c4e116c3e8cd9a1a3159cec6.1623251990.git.olivier.dautricourt@orolia.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <31a0e56b-3cb7-122a-ec44-b504ea2c0960@denx.de>
Date:   Thu, 10 Jun 2021 07:22:41 +0200
MIME-Version: 1.0
In-Reply-To: <4258cb93e0f7ff57c4e116c3e8cd9a1a3159cec6.1623251990.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -7.14 / 15.00 / 15.00
X-Rspamd-Queue-Id: 4CC0017FC
X-Rspamd-UID: 930263
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09.06.21 17:20, Olivier Dautricourt wrote:
> This entry is for the standalone driver in drivers/dma/altera-msgdma.c
> Add myself as 'Odd fixes' maintainer for this driver as i am currently
> writing new code and have access to the hardware.
> Add Stefan Roese as reviewer.
> 
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>

Acked-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
> Notes:
>      splitted commit, introduced in v5
> 
>      v6:
>        add Stefan Roese as Reviewer (after consulting him)
> 
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b706dd20ff2b..3167d26f0718 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -783,6 +783,14 @@ M:	Ley Foon Tan <ley.foon.tan@intel.com>
>   S:	Maintained
>   F:	drivers/mailbox/mailbox-altera.c
> 
> +ALTERA MSGDMA IP CORE DRIVER
> +M:	Olivier Dautricourt <olivier.dautricourt@orolia.com>
> +R:	Stefan Roese <sr@denx.de>
> +L:	dmaengine@vger.kernel.org
> +S:	Odd Fixes
> +F:	Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> +F:	drivers/dma/altera-msgdma.c
> +
>   ALTERA PIO DRIVER
>   M:	Joyce Ooi <joyce.ooi@intel.com>
>   L:	linux-gpio@vger.kernel.org
> --
> 2.31.0.rc2
> 
> 
> --
> Olivier Dautricourt
> 


Viele Grüße,
Stefan

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
