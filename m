Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B782B7BE2
	for <lists+dmaengine@lfdr.de>; Wed, 18 Nov 2020 11:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgKRKzR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 05:55:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgKRKzR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Nov 2020 05:55:17 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE60521D7E;
        Wed, 18 Nov 2020 10:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605696916;
        bh=xmUi7NEvnZdYYt+aDd+QBQNLDMyOOam0WWhgYkBWUBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTLL2CZfZ2BIxJxgh4MzdRJDEUi0JhmTrdoQCX4SbVZ04EcLJ9OxHOas5GLO69C40
         Ofh36C2PVM72SlKf9q4ca+oDr2Sxa8ve6UvRyQlvRWNo1Cf1vOMcyk/ehwyYB38mmJ
         X+BktUxlOGtBqhJPuQh1YoE8pC50oFVvLa0u3XjY=
Date:   Wed, 18 Nov 2020 16:25:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        Zubair.Kakakhel@imgtec.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: Re: [PATCH RESEND 0/2] Add dmaengine bindings for the JZ4775 and the
 X2000 SoCs.
Message-ID: <20201118105511.GM50232@vkoul-mobl>
References: <20201107122016.89859-1-zhouyanjie@wanyeetech.com>
 <BQOKJQ.FNG5W5HD7VTG1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BQOKJQ.FNG5W5HD7VTG1@crapouillou.net>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-11-20, 08:54, Paul Cercueil wrote:
> Hi Zhou,
> 
> Le sam. 7 nov. 2020 à 20:20, 周琰杰 (Zhou Yanjie)
> <zhouyanjie@wanyeetech.com> a écrit :
> > Add the dmaengine bindings for the JZ4775 SoC and the X2000 SoC from
> > Ingenic.
> > 
> > 周琰杰 (Zhou Yanjie) (2):
> >   dt-bindings: dmaengine: Add JZ4775 bindings.
> >   dt-bindings: dmaengine: Add X2000 bindings.
> > 
> >  include/dt-bindings/dma/jz4775-dma.h | 44 +++++++++++++++++++++++++++++
> >  include/dt-bindings/dma/x2000-dma.h  | 54
> > ++++++++++++++++++++++++++++++++++++
> 
> If that's up to me, these macros aren't really needed, and you can put the
> values directly in the dma cells. This is done already in jz4740.dtsi,
> jz4725b.dtsi and jz4770.dtsi.

But that is not really nice, it is good to define these rather than put
numbers, the include/dt-bindings exists for this sole reason!

-- 
~Vinod
